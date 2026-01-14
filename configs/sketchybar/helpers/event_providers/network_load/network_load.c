/*
 * network_load - Network traffic monitor for SketchyBar
 *
 * Usage: network_load <interface> <event_name> <update_interval>
 * Example: network_load en0 network_update 1.0
 *
 * Sends sketchybar events with upload/download speeds
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <net/route.h>

static char *format_bytes(unsigned long long bytes) {
    static char buf[32];
    const char *units[] = {"B/s", "KB/s", "MB/s", "GB/s"};
    int unit = 0;
    double size = (double)bytes;

    while (size >= 1024.0 && unit < 3) {
        size /= 1024.0;
        unit++;
    }

    if (unit == 0) {
        snprintf(buf, sizeof(buf), "%llu %s", bytes, units[unit]);
    } else {
        snprintf(buf, sizeof(buf), "%.1f %s", size, units[unit]);
    }

    return buf;
}

static int get_interface_stats(const char *ifname, unsigned long long *ibytes, unsigned long long *obytes) {
    int mib[] = {CTL_NET, PF_ROUTE, 0, 0, NET_RT_IFLIST2, 0};
    size_t len;
    char *buf, *next, *lim;
    struct if_msghdr2 *ifm;

    *ibytes = 0;
    *obytes = 0;

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        return -1;
    }

    buf = malloc(len);
    if (buf == NULL) {
        return -1;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        return -1;
    }

    lim = buf + len;
    for (next = buf; next < lim; ) {
        ifm = (struct if_msghdr2 *)next;
        next += ifm->ifm_msglen;

        if (ifm->ifm_type != RTM_IFINFO2) {
            continue;
        }

        struct sockaddr_dl *sdl = (struct sockaddr_dl *)(ifm + 1);
        if (sdl->sdl_nlen > 0) {
            char name[IF_NAMESIZE];
            memcpy(name, sdl->sdl_data, sdl->sdl_nlen);
            name[sdl->sdl_nlen] = '\0';

            if (strcmp(name, ifname) == 0) {
                *ibytes = ifm->ifm_data.ifi_ibytes;
                *obytes = ifm->ifm_data.ifi_obytes;
                free(buf);
                return 0;
            }
        }
    }

    free(buf);
    return -1;
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <interface> <event_name> <update_interval>\n", argv[0]);
        fprintf(stderr, "Example: %s en0 network_update 1.0\n", argv[0]);
        return 1;
    }

    const char *interface = argv[1];
    const char *event_name = argv[2];
    double interval = atof(argv[3]);

    if (interval <= 0) {
        interval = 1.0;
    }

    unsigned long long prev_ibytes = 0, prev_obytes = 0;
    unsigned long long curr_ibytes, curr_obytes;

    // Get initial values
    if (get_interface_stats(interface, &prev_ibytes, &prev_obytes) < 0) {
        fprintf(stderr, "Failed to get stats for interface: %s\n", interface);
        return 1;
    }

    while (1) {
        usleep((useconds_t)(interval * 1000000));

        if (get_interface_stats(interface, &curr_ibytes, &curr_obytes) < 0) {
            continue;
        }

        unsigned long long download = (curr_ibytes - prev_ibytes) / interval;
        unsigned long long upload = (curr_obytes - prev_obytes) / interval;

        prev_ibytes = curr_ibytes;
        prev_obytes = curr_obytes;

        char cmd[512];
        snprintf(cmd, sizeof(cmd),
            "sketchybar --trigger %s upload='%s' download='%s'",
            event_name, format_bytes(upload), format_bytes(download));

        system(cmd);
    }

    return 0;
}
