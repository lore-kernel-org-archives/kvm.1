Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB23AFD0F
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149842; cv=none; b=ewNP6IPHXMw4PDfRFAZLJJGJTrfvaVb+8F5cJJognVdUvuQW7FDY824RpkHBP57IMOhuh5Ji+bVtpmxDVTI1cHQARUd8fiVum/Rbs/RLxQlYzVG7ZLPA9Jpcq1ePgvDUxZ7be5+ueDNs6rZOTAki1GRUWVDHyzKdEoxhdG3Tu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149842; c=relaxed/simple;
	bh=R8dTAIDpuh3Q80AaNg6hH2IQLhowJN//qy61XqY6OZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS9h5faK0mgeHgyETwk+t81wZwjyZWVThdoXPNPV8/DGxGs2Y8CC9V1XwGa/s2mJE6uLrfWl45OHHuRT2ZJTnUli4adjjZY79oRHmPvkOeUNshkN6Kkuky92UQmohhIoMLtQGs9Danv6OcgTN6jSbB7Z77IGA6WVAQjqcUGdvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=la0Zcbo6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="la0Zcbo6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=jwGFj3dk7bRsmCsMxl/8zlgj8+Yd7iw52L+ctAQptL0=; b=la0Zcbo6bws+LX7c
	tyMBMAqD9oSk+niuKRwvcAUkz9bkmPFmfKSDPZfE21NmZwguFSjJS4xmj0IoRseCvobFtTCp7kOSU
	A9pe/rfpmK3CU8OOuZjBoRG7sVT0cydXiX5d0CNUq3gsiCrCugFqYHpg833BHcK5WA4kKn7aIbMn9
	SRWhyG6EAqeO4ML4TmSQTCwguoP1HhktToX2fuPfUIW2OocmEtxTeAXlZ7JXY4eNZ2RsvSEpkI0eF
	OK4kjNy6ld3tjiOzNduGgqeoqsWrP1YTTpqlNSYydajUaLQl5TVROl6Lno5oPU3RnlfcHTEtSHnWd
	8vUzl4dKnwrFbovJAw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wwhIS-00000003ACe-15ee;
	Wed, 19 Aug 2026 14:29:40 +0000
Date: Wed, 19 Aug 2026 14:29:40 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Ani Sinha <anisinha@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Hyman Huang <infra.ai.cloud@bitdeer.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu@processmission.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
	kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
	xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 37/49] monitor: tighten monitor_printf*()
Message-ID: <aoW91OUi2w68yBTR@gallifrey>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-37-e53fc35bc550@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-37-e53fc35bc550@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.101+deb13-amd64 (x86_64)
X-Uptime: 14:28:01 up 12 days, 18:05,  3 users,  load average: 0.05, 0.05,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> the first parameter from Monitor * to MonitorHMP * to enforce type
> safety. The implementation is also simplified: monitor_hmp_vprintf now
> directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> dispatch via moncls->vprintf.
> 
> The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> cast, they are fixed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Hmm, this patch is HUGE.
What are the chances of anyone being able to apply this without it conflicting
in a bunch of places?
Wouldn't it be better to split it into adding the monitor_hmp_ named versions,
then splitting the uses into one patch by area and then
trickling them in?

Dave

> ---
>  audio/audio-hmp-cmds.c                  |   6 +-
>  backends/cryptodev-hmp-cmds.c           |   9 +-
>  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
>  chardev/char-hmp-cmds.c                 |  12 +-
>  disas/disas-mon.c                       |  10 +-
>  docs/devel/style.rst                    |   2 +-
>  docs/devel/writing-monitor-commands.rst |   8 +-
>  dump/dump-hmp-cmds.c                    |   5 +-
>  hw/char/virtio-serial-bus.c             |  10 +-
>  hw/core/machine-hmp-cmds.c              | 213 +++++++++++-----------
>  hw/core/sysbus.c                        |   5 +-
>  hw/hexagon/hexagon_tlb.c                |  44 ++---
>  hw/i386/kvm/xen-stubs.c                 |   6 +-
>  hw/i386/kvm/xen_evtchn.c                |  21 +--
>  hw/i386/sgx-hmp-stub.c                  |   3 +-
>  hw/i386/sgx.c                           |  29 ++-
>  hw/misc/auxbus.c                        |   9 +-
>  hw/misc/mos6522-stub.c                  |   3 +-
>  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++-------
>  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
>  hw/pci/pci-stub.c                       |   3 +-
>  hw/s390x/s390-skeys.c                   |   9 +-
>  hw/s390x/s390-stattrib.c                |  20 +--
>  hw/uefi/ovmf-log.c                      |   5 +-
>  hw/usb/bus.c                            |  11 +-
>  hw/usb/host-libusb.c                    |  21 ++-
>  hw/virtio/virtio-hmp-cmds.c             | 297 +++++++++++++++----------------
>  hw/xen/xen-bus.c                        |   5 +-
>  include/disas/disas.h                   |   4 +-
>  include/monitor/hmp.h                   |  12 +-
>  migration/dirtyrate.c                   |  46 +++--
>  migration/migration-hmp-cmds.c          | 305 ++++++++++++++++----------------
>  monitor/hmp-cmds.c                      | 141 +++++++--------
>  monitor/hmp.c                           | 143 +++++++--------
>  monitor/monitor-internal.h              |   6 -
>  monitor/monitor.c                       |  33 ++--
>  net/net-hmp-cmds.c                      |  31 ++--
>  net/slirp.c                             |  31 ++--
>  qom/qom-hmp-cmds.c                      |  27 ++-
>  replay/replay-debugging.c               |   5 +-
>  stats/stats-hmp-cmds.c                  |  57 +++---
>  stubs/hmp-cmd-info_sev.c                |   3 +-
>  stubs/monitor-core.c                    |   2 +-
>  system/dirtylimit-hmp-cmds.c            |  10 +-
>  system/qdev-monitor.c                   |  19 +-
>  system/runstate-hmp-cmds.c              |  16 +-
>  system/tpm-hmp-cmds.c                   |  29 ++-
>  target/i386/cpu-apic.c                  |   3 +-
>  target/i386/monitor.c                   | 152 ++++++++--------
>  target/i386/sev.c                       |  35 ++--
>  target/m68k/monitor.c                   |   3 +-
>  target/ppc/monitor.c                    |   3 +-
>  target/riscv/monitor.c                  |  55 +++---
>  target/sh4/monitor.c                    |  29 ++-
>  target/sparc/monitor.c                  |   3 +-
>  target/xtensa/monitor.c                 |   3 +-
>  tests/unit/test-util-sockets.c          |   2 +-
>  tools/qemu-vnc/clipboard.c              |   4 +-
>  tools/qemu-vnc/stubs.c                  |   2 +-
>  trace/trace-hmp-cmds.c                  |  12 +-
>  ui/ui-hmp-cmds.c                        | 115 ++++++------
>  util/error-report.c                     |   2 +-
>  util/qemu-print.c                       |   4 +-
>  63 files changed, 1214 insertions(+), 1329 deletions(-)
> 
> diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
> index 4d326ec99fdf..94182fe1d71f 100644
> --- a/audio/audio-hmp-cmds.c
> +++ b/audio/audio-hmp-cmds.c
> @@ -34,14 +34,13 @@ static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
>  
>  void hmp_info_capture(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int i;
>      CaptureState *s;
>  
>      warn_report_once("'info capture' is deprecated since v10.2, to be removed");
>  
>      for (s = capture_head.lh_first, i = 0; s; s = s->entries.le_next, ++i) {
> -        monitor_printf(mon, "[%d]: ", i);
> +        monitor_hmp_printf(hmp, "[%d]: ", i);
>          s->ops.info (s->opaque);
>      }
>  }
> @@ -66,7 +65,6 @@ void hmp_stopcapture(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_wavcapture(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *path = qdict_get_str(qdict, "path");
>      int freq = qdict_get_try_int(qdict, "freq", 44100);
>      int bits = qdict_get_try_int(qdict, "bits", 16);
> @@ -86,7 +84,7 @@ void hmp_wavcapture(MonitorHMP *hmp, const QDict *qdict)
>      s = g_malloc0 (sizeof (*s));
>  
>      if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
> -        monitor_printf(mon, "Failed to add wave capture\n");
> +        monitor_hmp_printf(hmp, "Failed to add wave capture\n");
>          g_free (s);
>          return;
>      }
> diff --git a/backends/cryptodev-hmp-cmds.c b/backends/cryptodev-hmp-cmds.c
> index fb62428d795a..aafa4b970d24 100644
> --- a/backends/cryptodev-hmp-cmds.c
> +++ b/backends/cryptodev-hmp-cmds.c
> @@ -19,7 +19,6 @@
>  
>  void hmp_info_cryptodev(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      QCryptodevInfoList *il;
>      QCryptodevBackendServiceTypeList *sl;
>      QCryptodevBackendClientList *cl;
> @@ -41,13 +40,13 @@ void hmp_info_cryptodev(MonitorHMP *hmp, const QDict *qdict)
>                  services = tmp_services;
>              }
>          }
> -        monitor_printf(mon, "%s: service=[%s]\n", info->id, services);
> +        monitor_hmp_printf(hmp, "%s: service=[%s]\n", info->id, services);
>  
>          for (cl = info->client; cl; cl = cl->next) {
>              QCryptodevBackendClient *client = cl->value;
> -            monitor_printf(mon, "    queue %" PRIu32 ": type=%s\n",
> -                           client->queue,
> -                           QCryptodevBackendType_str(client->type));
> +            monitor_hmp_printf(hmp, "    queue %" PRIu32 ": type=%s\n",
> +                               client->queue,
> +                               QCryptodevBackendType_str(client->type));
>          }
>      }
>  
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index a2666e2f1b9b..7bae4d425c6d 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -89,7 +89,6 @@ out:
>  
>  void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      DriveInfo *dinfo;
>      QemuOpts *opts;
> @@ -119,7 +118,7 @@ void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
>  
>      switch (dinfo->type) {
>      case IF_NONE:
> -        monitor_printf(mon, "OK\n");
> +        monitor_hmp_printf(hmp, "OK\n");
>          break;
>      default:
>          error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
> @@ -552,9 +551,10 @@ void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
>      hmp_handle_error(hmp, err);
>  }
>  
> -static void print_block_info(Monitor *mon, BlockInfo *info,
> +static void print_block_info(MonitorHMP *hmp, BlockInfo *info,
>                               BlockDeviceInfo *inserted, bool verbose)
>  {
> +    Monitor *mon = MONITOR(hmp);
>      ImageInfo *image_info;
>  
>      assert(!info || !info->inserted || info->inserted == inserted);
> @@ -562,7 +562,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>      if (info && *info->device) {
>          monitor_puts(mon, info->device);
>          if (inserted && inserted->node_name) {
> -            monitor_printf(mon, " (%s)", inserted->node_name);
> +            monitor_hmp_printf(hmp, " (%s)", inserted->node_name);
>          }
>      } else {
>          assert(info || inserted);
> @@ -573,29 +573,29 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>      }
>  
>      if (inserted) {
> -        monitor_printf(mon, ": %s (%s%s%s%s)\n",
> -                       inserted->file,
> -                       inserted->drv,
> -                       inserted->ro ? ", read-only" : "",
> -                       inserted->encrypted ? ", encrypted" : "",
> -                       inserted->active ? "" : ", inactive");
> +        monitor_hmp_printf(hmp, ": %s (%s%s%s%s)\n",
> +                           inserted->file,
> +                           inserted->drv,
> +                           inserted->ro ? ", read-only" : "",
> +                           inserted->encrypted ? ", encrypted" : "",
> +                           inserted->active ? "" : ", inactive");
>      } else {
> -        monitor_printf(mon, ": [not inserted]\n");
> +        monitor_hmp_printf(hmp, ": [not inserted]\n");
>      }
>  
>      if (info) {
>          if (info->qdev) {
> -            monitor_printf(mon, "    Attached to:      %s\n", info->qdev);
> +            monitor_hmp_printf(hmp, "    Attached to:      %s\n", info->qdev);
>          }
>          if (info->has_io_status && info->io_status != BLOCK_DEVICE_IO_STATUS_OK) {
> -            monitor_printf(mon, "    I/O status:       %s\n",
> -                           BlockDeviceIoStatus_str(info->io_status));
> +            monitor_hmp_printf(hmp, "    I/O status:       %s\n",
> +                               BlockDeviceIoStatus_str(info->io_status));
>          }
>  
>          if (info->removable) {
> -            monitor_printf(mon, "    Removable device: %slocked, tray %s\n",
> -                           info->locked ? "" : "not ",
> -                           info->tray_open ? "open" : "closed");
> +            monitor_hmp_printf(hmp, "    Removable device: %slocked, tray %s\n",
> +                               info->locked ? "" : "not ",
> +                               info->tray_open ? "open" : "closed");
>          }
>      }
>  
> @@ -604,28 +604,28 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>          return;
>      }
>  
> -    monitor_printf(mon, "    Cache mode:       %s%s%s\n",
> -                   inserted->cache->writeback ? "writeback" : "writethrough",
> -                   inserted->cache->direct ? ", direct" : "",
> -                   inserted->cache->no_flush ? ", ignore flushes" : "");
> +    monitor_hmp_printf(hmp, "    Cache mode:       %s%s%s\n",
> +                       inserted->cache->writeback ? "writeback" : "writethrough",
> +                       inserted->cache->direct ? ", direct" : "",
> +                       inserted->cache->no_flush ? ", ignore flushes" : "");
>  
>      if (inserted->backing_file) {
> -        monitor_printf(mon,
> -                       "    Backing file:     %s "
> -                       "(chain depth: %" PRId64 ")\n",
> -                       inserted->backing_file,
> -                       inserted->backing_file_depth);
> +        monitor_hmp_printf(hmp,
> +                           "    Backing file:     %s "
> +                           "(chain depth: %" PRId64 ")\n",
> +                           inserted->backing_file,
> +                           inserted->backing_file_depth);
>      }
>  
>      if (inserted->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF) {
> -        monitor_printf(mon, "    Detect zeroes:    %s\n",
> +        monitor_hmp_printf(hmp, "    Detect zeroes:    %s\n",
>                  BlockdevDetectZeroesOptions_str(inserted->detect_zeroes));
>      }
>  
>      if (inserted->bps  || inserted->bps_rd  || inserted->bps_wr  ||
>          inserted->iops || inserted->iops_rd || inserted->iops_wr)
>      {
> -        monitor_printf(mon, "    I/O throttling:   bps=%" PRId64
> +        monitor_hmp_printf(hmp, "    I/O throttling:   bps=%" PRId64
>                          " bps_rd=%" PRId64  " bps_wr=%" PRId64
>                          " bps_max=%" PRId64
>                          " bps_rd_max=%" PRId64
> @@ -654,7 +654,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>      }
>  
>      if (verbose) {
> -        monitor_printf(mon, "\nImages:\n");
> +        monitor_hmp_printf(hmp, "\nImages:\n");
>          image_info = inserted->image;
>          while (1) {
>              bdrv_node_info_dump(qapi_ImageInfo_base(image_info), 0, false);
> @@ -669,7 +669,6 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>  
>  void hmp_info_block(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      BlockInfoList *block_list, *info;
>      BlockDeviceInfoList *blockdev_list, *blockdev;
>      const char *device = qdict_get_try_str(qdict, "device");
> @@ -690,10 +689,10 @@ void hmp_info_block(MonitorHMP *hmp, const QDict *qdict)
>          }
>  
>          if (info != block_list) {
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>  
> -        print_block_info(mon, info->value, info->value->inserted,
> +        print_block_info(hmp, info->value, info->value->inserted,
>                           verbose);
>          printed = true;
>      }
> @@ -713,17 +712,16 @@ void hmp_info_block(MonitorHMP *hmp, const QDict *qdict)
>          }
>  
>          if (blockdev != blockdev_list) {
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>  
> -        print_block_info(mon, NULL, blockdev->value, verbose);
> +        print_block_info(hmp, NULL, blockdev->value, verbose);
>      }
>      qapi_free_BlockDeviceInfoList(blockdev_list);
>  }
>  
>  void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      BlockStatsList *stats_list, *stats;
>  
>      stats_list = qmp_query_blockstats(false, false, NULL);
> @@ -733,28 +731,28 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
>              continue;
>          }
>  
> -        monitor_printf(mon, "%s%s: idle_time_ns=%" PRId64 "\n",
> -                       stats != stats_list ? "\n" : "",
> -                       stats->value->device,
> -                       stats->value->stats->idle_time_ns);
> -        monitor_printf(mon, "       %24s %16s %24s %10s\n", "bytes",
> -                       "operations", "total_time_ns", "merged");
> -        monitor_printf(mon, "Read:  %24" PRId64 " %16" PRId64 " %24" PRId64
> -                       " %10" PRId64 "\n",
> -                       stats->value->stats->rd_bytes,
> -                       stats->value->stats->rd_operations,
> -                       stats->value->stats->rd_total_time_ns,
> -                       stats->value->stats->rd_merged);
> -        monitor_printf(mon, "Write: %24" PRId64 " %16" PRId64 " %24" PRId64
> -                       " %10" PRId64 "\n",
> -                       stats->value->stats->wr_bytes,
> -                       stats->value->stats->wr_operations,
> -                       stats->value->stats->wr_total_time_ns,
> -                       stats->value->stats->wr_merged);
> -        monitor_printf(mon, "Flush: %24s %16" PRId64 " %24" PRId64 "\n",
> -                       "",
> -                       stats->value->stats->flush_operations,
> -                       stats->value->stats->flush_total_time_ns);
> +        monitor_hmp_printf(hmp, "%s%s: idle_time_ns=%" PRId64 "\n",
> +                           stats != stats_list ? "\n" : "",
> +                           stats->value->device,
> +                           stats->value->stats->idle_time_ns);
> +        monitor_hmp_printf(hmp, "       %24s %16s %24s %10s\n", "bytes",
> +                           "operations", "total_time_ns", "merged");
> +        monitor_hmp_printf(hmp, "Read:  %24" PRId64 " %16" PRId64 " %24" PRId64
> +                           " %10" PRId64 "\n",
> +                           stats->value->stats->rd_bytes,
> +                           stats->value->stats->rd_operations,
> +                           stats->value->stats->rd_total_time_ns,
> +                           stats->value->stats->rd_merged);
> +        monitor_hmp_printf(hmp, "Write: %24" PRId64 " %16" PRId64 " %24" PRId64
> +                           " %10" PRId64 "\n",
> +                           stats->value->stats->wr_bytes,
> +                           stats->value->stats->wr_operations,
> +                           stats->value->stats->wr_total_time_ns,
> +                           stats->value->stats->wr_merged);
> +        monitor_hmp_printf(hmp, "Flush: %24s %16" PRId64 " %24" PRId64 "\n",
> +                           "",
> +                           stats->value->stats->flush_operations,
> +                           stats->value->stats->flush_total_time_ns);
>      }
>  
>      qapi_free_BlockStatsList(stats_list);
> @@ -762,34 +760,33 @@ void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      BlockJobInfoList *list;
>  
>      list = qmp_query_block_jobs(&error_abort);
>  
>      if (!list) {
> -        monitor_printf(mon, "No active jobs\n");
> +        monitor_hmp_printf(hmp, "No active jobs\n");
>          return;
>      }
>  
>      while (list) {
>          if (list->value->type == JOB_TYPE_STREAM) {
> -            monitor_printf(mon, "Streaming device %s: Completed %" PRId64
> -                           " of %" PRId64 " bytes, speed limit %" PRId64
> -                           " bytes/s\n",
> -                           list->value->device,
> -                           list->value->offset,
> -                           list->value->len,
> -                           list->value->speed);
> +            monitor_hmp_printf(hmp, "Streaming device %s: Completed %" PRId64
> +                               " of %" PRId64 " bytes, speed limit %" PRId64
> +                               " bytes/s\n",
> +                               list->value->device,
> +                               list->value->offset,
> +                               list->value->len,
> +                               list->value->speed);
>          } else {
> -            monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
> -                           " of %" PRId64 " bytes, speed limit %" PRId64
> -                           " bytes/s\n",
> -                           JobType_str(list->value->type),
> -                           list->value->device,
> -                           list->value->offset,
> -                           list->value->len,
> -                           list->value->speed);
> +            monitor_hmp_printf(hmp, "Type %s, device %s: Completed %" PRId64
> +                               " of %" PRId64 " bytes, speed limit %" PRId64
> +                               " bytes/s\n",
> +                               JobType_str(list->value->type),
> +                               list->value->device,
> +                               list->value->offset,
> +                               list->value->len,
> +                               list->value->speed);
>          }
>          list = list->next;
>      }
> @@ -799,7 +796,6 @@ void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      BlockDriverState *bs, *bs1;
>      BdrvNextIterator it1;
>      QEMUSnapshotInfo *sn_tab, *sn;
> @@ -837,7 +833,7 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>      nb_sns = bdrv_snapshot_list(bs, &sn_tab);
>  
>      if (nb_sns < 0) {
> -        monitor_printf(mon, "bdrv_snapshot_list: error %d\n", nb_sns);
> +        monitor_hmp_printf(hmp, "bdrv_snapshot_list: error %d\n", nb_sns);
>          return;
>      }
>  
> @@ -866,7 +862,7 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>      }
>  
>      if (no_snapshot) {
> -        monitor_printf(mon, "There is no snapshot available.\n");
> +        monitor_hmp_printf(hmp, "There is no snapshot available.\n");
>          return;
>      }
>  
> @@ -889,11 +885,11 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>              }
>          }
>      }
> -    monitor_printf(mon, "List of snapshots present on all disks:\n");
> +    monitor_hmp_printf(hmp, "List of snapshots present on all disks:\n");
>  
>      if (total > 0) {
>          bdrv_snapshot_dump(NULL);
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>          for (i = 0; i < total; i++) {
>              sn = &sn_tab[global_snapshots[i]];
>              /*
> @@ -902,24 +898,24 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>               */
>              pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
>              bdrv_snapshot_dump(sn);
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>      } else {
> -        monitor_printf(mon, "None\n");
> +        monitor_hmp_printf(hmp, "None\n");
>      }
>  
>      QTAILQ_FOREACH(image_entry, &image_list, next) {
>          if (QTAILQ_EMPTY(&image_entry->snapshots)) {
>              continue;
>          }
> -        monitor_printf(mon,
> -                       "\nList of partial (non-loadable) snapshots on '%s':\n",
> -                       image_entry->imagename);
> +        monitor_hmp_printf(hmp,
> +                           "\nList of partial (non-loadable) snapshots on '%s':\n",
> +                           image_entry->imagename);
>          bdrv_snapshot_dump(NULL);
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>          QTAILQ_FOREACH(snapshot_entry, &image_entry->snapshots, next) {
>              bdrv_snapshot_dump(&snapshot_entry->sn);
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>      }
>  
> @@ -935,7 +931,7 @@ void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
>      g_free(global_snapshots);
>  }
>  
> -void hmp_change_medium(Monitor *mon, const char *device, const char *target,
> +void hmp_change_medium(MonitorHMP *hmp, const char *device, const char *target,
>                         const char *arg, const char *read_only, bool force,
>                         Error **errp)
>  {
> diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
> index 71017fd2d19e..fb0560054b7b 100644
> --- a/chardev/char-hmp-cmds.c
> +++ b/chardev/char-hmp-cmds.c
> @@ -26,12 +26,11 @@
>  
>  void hmp_info_chardev(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      ChardevInfoList *char_info, *info;
>  
>      char_info = qmp_query_chardev(NULL);
>      for (info = char_info; info; info = info->next) {
> -        monitor_printf(mon, "%s: filename=%s\n", info->value->label,
> +        monitor_hmp_printf(hmp, "%s: filename=%s\n", info->value->label,
>                                                   info->value->filename);
>      }
>  
> @@ -51,7 +50,6 @@ void hmp_ringbuf_write(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      uint32_t size = qdict_get_int(qdict, "size");
>      const char *chardev = qdict_get_str(qdict, "device");
>      char *data;
> @@ -67,15 +65,15 @@ void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
>          unsigned char ch = data[i];
>  
>          if (ch == '\\') {
> -            monitor_printf(mon, "\\\\");
> +            monitor_hmp_printf(hmp, "\\\\");
>          } else if ((ch < 0x20 && ch != '\n' && ch != '\t') || ch == 0x7F) {
> -            monitor_printf(mon, "\\u%04X", ch);
> +            monitor_hmp_printf(hmp, "\\u%04X", ch);
>          } else {
> -            monitor_printf(mon, "%c", ch);
> +            monitor_hmp_printf(hmp, "%c", ch);
>          }
>  
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>      g_free(data);
>  }
>  
> diff --git a/disas/disas-mon.c b/disas/disas-mon.c
> index bc9dec3a7761..32e4220181a8 100644
> --- a/disas/disas-mon.c
> +++ b/disas/disas-mon.c
> @@ -38,7 +38,7 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
>  }
>  
>  /* Disassembler for the monitor.  */
> -void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
> +void monitor_disas(MonitorHMP *hmp, CPUState *cpu, uint64_t pc,
>                     int nb_insn, bool is_physical)
>  {
>      int count, i;
> @@ -58,13 +58,13 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
>      s.info.buffer_vma = pc;
>  
>      if (s.info.cap_arch >= 0 && cap_disas_monitor(&s.info, pc, nb_insn)) {
> -        monitor_puts(mon, ds->str);
> +        monitor_puts(MONITOR(hmp), ds->str);
>          return;
>      }
>  
>      if (!s.info.print_insn) {
> -        monitor_printf(mon, "0x%08" PRIx64
> -                       ": Asm output not supported on this arch\n", pc);
> +        monitor_hmp_printf(hmp, "0x%08" PRIx64
> +                           ": Asm output not supported on this arch\n", pc);
>          return;
>      }
>  
> @@ -78,5 +78,5 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
>          pc += count;
>      }
>  
> -    monitor_puts(mon, ds->str);
> +    monitor_puts(MONITOR(hmp), ds->str);
>  }
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 6c5f94cc5098..6876d3a59ec7 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -754,7 +754,7 @@ Error handling and reporting
>  Reporting errors to the human user
>  ----------------------------------
>  
> -Do not use printf(), fprintf() or monitor_printf().  Instead, use
> +Do not use printf(), fprintf() or monitor_hmp_printf().  Instead, use
>  error_report() or error_vreport() from error-report.h.  This ensures the
>  error is reported in the right place (current monitor or stderr), and in
>  a uniform format.
> diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
> index 7ae7efe32759..baf94cbdefab 100644
> --- a/docs/devel/writing-monitor-commands.rst
> +++ b/docs/devel/writing-monitor-commands.rst
> @@ -479,7 +479,7 @@ The HMP command
>  
>  Here's the HMP counterpart of the query-option-roms command::
>  
> - void hmp_info_option_roms(Monitor *mon, const QDict *qdict)
> + void hmp_info_option_roms(MonitorHMP *mon, const QDict *qdict)
>   {
>       Error *err = NULL;
>       OptionRomInfoList *info_list, *tail;
> @@ -492,11 +492,11 @@ Here's the HMP counterpart of the query-option-roms command::
>  
>       for (tail = info_list; tail; tail = tail->next) {
>           info = tail->value;
> -         monitor_printf(mon, "%s", info->filename);
> +         monitor_hmp_printf(mon, "%s", info->filename);
>           if (info->has_bootindex) {
> -             monitor_printf(mon, " %" PRId64, info->bootindex);
> +             monitor_hmp_printf(mon, " %" PRId64, info->bootindex);
>           }
> -         monitor_printf(mon, "\n");
> +         monitor_hmp_printf(mon, "\n");
>       }
>  
>       qapi_free_OptionRomInfoList(info_list);
> diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> index 104ab5d2a53a..c7045c2d7314 100644
> --- a/dump/dump-hmp-cmds.c
> +++ b/dump/dump-hmp-cmds.c
> @@ -85,17 +85,16 @@ void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_dump(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      DumpQueryResult *result = qmp_query_dump(NULL);
>  
>      assert(result && result->status < DUMP_STATUS__MAX);
> -    monitor_printf(mon, "Status: %s\n", DumpStatus_str(result->status));
> +    monitor_hmp_printf(hmp, "Status: %s\n", DumpStatus_str(result->status));
>  
>      if (result->status == DUMP_STATUS_ACTIVE) {
>          float percent = 0;
>          assert(result->total != 0);
>          percent = 100.0 * result->completed / result->total;
> -        monitor_printf(mon, "Finished: %.2f %%\n", percent);
> +        monitor_hmp_printf(hmp, "Finished: %.2f %%\n", percent);
>      }
>  
>      qapi_free_DumpQueryResult(result);
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index 02604740f86a..33fdc0846ac3 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -838,11 +838,11 @@ static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
>  {
>      VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(qdev);
>  
> -    monitor_printf(mon, "%*sport %d, guest %s, host %s, throttle %s\n",
> -                   indent, "", port->id,
> -                   port->guest_connected ? "on" : "off",
> -                   port->host_connected ? "on" : "off",
> -                   port->throttled ? "on" : "off");
> +    monitor_hmp_printf(MONITOR_HMP(mon), "%*sport %d, guest %s, host %s, throttle %s\n",
> +                       indent, "", port->id,
> +                       port->guest_connected ? "on" : "off",
> +                       port->host_connected ? "on" : "off",
> +                       port->throttled ? "on" : "off");
>  }
>  
>  /* This function is only used if a port id is not provided by the user */
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 702c798ccc56..10a633af0780 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -27,7 +27,6 @@
>  
>  void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CpuInfoFastList *cpu_list, *cpu;
>  
>      cpu_list = qmp_query_cpus_fast(NULL);
> @@ -40,10 +39,10 @@ void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
>              active = '*';
>          }
>  
> -        monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> -                       cpu->value->cpu_index);
> -        monitor_printf(mon, " thread_id=%" PRId64 " model=%s\n",
> -                       cpu->value->thread_id, cpu_model);
> +        monitor_hmp_printf(hmp, "%c CPU #%" PRId64 ":", active,
> +                           cpu->value->cpu_index);
> +        monitor_hmp_printf(hmp, " thread_id=%" PRId64 " model=%s\n",
> +                           cpu->value->thread_id, cpu_model);
>      }
>  
>      qapi_free_CpuInfoFastList(cpu_list);
> @@ -51,7 +50,6 @@ void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      HotpluggableCPUList *l = qmp_query_hotpluggable_cpus(&err);
>      HotpluggableCPUList *saved = l;
> @@ -61,45 +59,45 @@ void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "Hotpluggable CPUs:\n");
> +    monitor_hmp_printf(hmp, "Hotpluggable CPUs:\n");
>      while (l) {
> -        monitor_printf(mon, "  type: \"%s\"\n", l->value->type);
> -        monitor_printf(mon, "  vcpus_count: \"%" PRIu64 "\"\n",
> -                       l->value->vcpus_count);
> +        monitor_hmp_printf(hmp, "  type: \"%s\"\n", l->value->type);
> +        monitor_hmp_printf(hmp, "  vcpus_count: \"%" PRIu64 "\"\n",
> +                           l->value->vcpus_count);
>          if (l->value->qom_path) {
> -            monitor_printf(mon, "  qom_path: \"%s\"\n", l->value->qom_path);
> +            monitor_hmp_printf(hmp, "  qom_path: \"%s\"\n", l->value->qom_path);
>          }
>  
>          c = l->value->props;
> -        monitor_printf(mon, "  CPUInstance Properties:\n");
> +        monitor_hmp_printf(hmp, "  CPUInstance Properties:\n");
>          if (c->has_node_id) {
> -            monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
> +            monitor_hmp_printf(hmp, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
>          }
>          if (c->has_drawer_id) {
> -            monitor_printf(mon, "    drawer-id: \"%" PRIu64 "\"\n", c->drawer_id);
> +            monitor_hmp_printf(hmp, "    drawer-id: \"%" PRIu64 "\"\n", c->drawer_id);
>          }
>          if (c->has_book_id) {
> -            monitor_printf(mon, "    book-id: \"%" PRIu64 "\"\n", c->book_id);
> +            monitor_hmp_printf(hmp, "    book-id: \"%" PRIu64 "\"\n", c->book_id);
>          }
>          if (c->has_socket_id) {
> -            monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
> +            monitor_hmp_printf(hmp, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
>          }
>          if (c->has_die_id) {
> -            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
> +            monitor_hmp_printf(hmp, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
>          }
>          if (c->has_cluster_id) {
> -            monitor_printf(mon, "    cluster-id: \"%" PRIu64 "\"\n",
> -                           c->cluster_id);
> +            monitor_hmp_printf(hmp, "    cluster-id: \"%" PRIu64 "\"\n",
> +                               c->cluster_id);
>          }
>          if (c->has_module_id) {
> -            monitor_printf(mon, "    module-id: \"%" PRIu64 "\"\n",
> -                           c->module_id);
> +            monitor_hmp_printf(hmp, "    module-id: \"%" PRIu64 "\"\n",
> +                               c->module_id);
>          }
>          if (c->has_core_id) {
> -            monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
> +            monitor_hmp_printf(hmp, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
>          }
>          if (c->has_thread_id) {
> -            monitor_printf(mon, "    thread-id: \"%" PRIu64 "\"\n", c->thread_id);
> +            monitor_hmp_printf(hmp, "    thread-id: \"%" PRIu64 "\"\n", c->thread_id);
>          }
>  
>          l = l->next;
> @@ -110,7 +108,6 @@ void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      MemdevList *memdev_list = qmp_query_memdev(&err);
>      MemdevList *m = memdev_list;
> @@ -120,31 +117,31 @@ void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict)
>      while (m) {
>          v = string_output_visitor_new(false, &str);
>          visit_type_uint16List(v, NULL, &m->value->host_nodes, &error_abort);
> -        monitor_printf(mon, "memory backend: %s\n", m->value->id);
> -        monitor_printf(mon, "  size:  %" PRId64 "\n", m->value->size);
> -        monitor_printf(mon, "  merge: %s\n",
> -                       m->value->merge ? "true" : "false");
> -        monitor_printf(mon, "  dump: %s\n",
> -                       m->value->dump ? "true" : "false");
> -        monitor_printf(mon, "  prealloc: %s\n",
> -                       m->value->prealloc ? "true" : "false");
> -        monitor_printf(mon, "  share: %s\n",
> -                       m->value->share ? "true" : "false");
> +        monitor_hmp_printf(hmp, "memory backend: %s\n", m->value->id);
> +        monitor_hmp_printf(hmp, "  size:  %" PRId64 "\n", m->value->size);
> +        monitor_hmp_printf(hmp, "  merge: %s\n",
> +                           m->value->merge ? "true" : "false");
> +        monitor_hmp_printf(hmp, "  dump: %s\n",
> +                           m->value->dump ? "true" : "false");
> +        monitor_hmp_printf(hmp, "  prealloc: %s\n",
> +                           m->value->prealloc ? "true" : "false");
> +        monitor_hmp_printf(hmp, "  share: %s\n",
> +                           m->value->share ? "true" : "false");
>          if (m->value->has_reserve) {
> -            monitor_printf(mon, "  reserve: %s\n",
> -                           m->value->reserve ? "true" : "false");
> +            monitor_hmp_printf(hmp, "  reserve: %s\n",
> +                               m->value->reserve ? "true" : "false");
>          }
> -        monitor_printf(mon, "  policy: %s\n",
> -                       HostMemPolicy_str(m->value->policy));
> +        monitor_hmp_printf(hmp, "  policy: %s\n",
> +                           HostMemPolicy_str(m->value->policy));
>          visit_complete(v, &str);
> -        monitor_printf(mon, "  host nodes: %s\n", str);
> +        monitor_hmp_printf(hmp, "  host nodes: %s\n", str);
>  
>          g_free(str);
>          visit_free(v);
>          m = m->next;
>      }
>  
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>  
>      qapi_free_MemdevList(memdev_list);
>      hmp_handle_error(hmp, err);
> @@ -152,15 +149,14 @@ void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_kvm(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      KvmInfo *info;
>  
>      info = qmp_query_kvm(NULL);
> -    monitor_printf(mon, "kvm support: ");
> +    monitor_hmp_printf(hmp, "kvm support: ");
>      if (info->present) {
> -        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
> +        monitor_hmp_printf(hmp, "%s\n", info->enabled ? "enabled" : "disabled");
>      } else {
> -        monitor_printf(mon, "not compiled\n");
> +        monitor_hmp_printf(hmp, "not compiled\n");
>      }
>  
>      qapi_free_KvmInfo(info);
> @@ -168,7 +164,6 @@ void hmp_info_kvm(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_accelerators(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      AcceleratorInfo *info;
>      AcceleratorList *accel;
>  
> @@ -176,9 +171,9 @@ void hmp_info_accelerators(MonitorHMP *hmp, const QDict *qdict)
>      for (accel = info->present; accel; accel = accel->next) {
>          char trail = accel->next ? ' ' : '\n';
>          if (info->enabled == accel->value) {
> -            monitor_printf(mon, "[%s]%c", Accelerator_str(accel->value), trail);
> +            monitor_hmp_printf(hmp, "[%s]%c", Accelerator_str(accel->value), trail);
>          } else {
> -            monitor_printf(mon, "%s%c", Accelerator_str(accel->value), trail);
> +            monitor_hmp_printf(hmp, "%s%c", Accelerator_str(accel->value), trail);
>          }
>      }
>  
> @@ -187,17 +182,15 @@ void hmp_info_accelerators(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_uuid(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      UuidInfo *info;
>  
>      info = qmp_query_uuid(NULL);
> -    monitor_printf(mon, "%s\n", info->UUID);
> +    monitor_hmp_printf(hmp, "%s\n", info->UUID);
>      qapi_free_UuidInfo(info);
>  }
>  
>  void hmp_info_balloon(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      BalloonInfo *info;
>      Error *err = NULL;
>  
> @@ -206,7 +199,7 @@ void hmp_info_balloon(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "balloon: actual=%" PRId64 "\n", info->actual >> 20);
> +    monitor_hmp_printf(hmp, "balloon: actual=%" PRId64 "\n", info->actual >> 20);
>  
>      qapi_free_BalloonInfo(info);
>  }
> @@ -223,7 +216,6 @@ void hmp_system_powerdown(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      uint32_t size = qdict_get_int(qdict, "size");
>      const char *filename = qdict_get_str(qdict, "filename");
>      uint64_t addr = qdict_get_int(qdict, "val");
> @@ -231,7 +223,7 @@ void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
>      int cpu_index = monitor_hmp_get_cpu_index(hmp);
>  
>      if (cpu_index < 0) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
> @@ -277,7 +269,6 @@ void hmp_balloon(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>      MemoryDeviceInfoList *info;
> @@ -298,76 +289,76 @@ void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>                  di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
>                       value->u.dimm.data : value->u.nvdimm.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               di->id ? di->id : "");
> -                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", di->addr);
> -                monitor_printf(mon, "  slot: %" PRId64 "\n", di->slot);
> -                monitor_printf(mon, "  node: %" PRId64 "\n", di->node);
> -                monitor_printf(mon, "  size: %" PRIu64 "\n", di->size);
> -                monitor_printf(mon, "  memdev: %s\n", di->memdev);
> -                monitor_printf(mon, "  hotplugged: %s\n",
> -                               di->hotplugged ? "true" : "false");
> -                monitor_printf(mon, "  hotpluggable: %s\n",
> -                               di->hotpluggable ? "true" : "false");
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   di->id ? di->id : "");
> +                monitor_hmp_printf(hmp, "  addr: 0x%" PRIx64 "\n", di->addr);
> +                monitor_hmp_printf(hmp, "  slot: %" PRId64 "\n", di->slot);
> +                monitor_hmp_printf(hmp, "  node: %" PRId64 "\n", di->node);
> +                monitor_hmp_printf(hmp, "  size: %" PRIu64 "\n", di->size);
> +                monitor_hmp_printf(hmp, "  memdev: %s\n", di->memdev);
> +                monitor_hmp_printf(hmp, "  hotplugged: %s\n",
> +                                   di->hotplugged ? "true" : "false");
> +                monitor_hmp_printf(hmp, "  hotpluggable: %s\n",
> +                                   di->hotpluggable ? "true" : "false");
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
>                  vpi = value->u.virtio_pmem.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               vpi->id ? vpi->id : "");
> -                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
> -                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
> -                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   vpi->id ? vpi->id : "");
> +                monitor_hmp_printf(hmp, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
> +                monitor_hmp_printf(hmp, "  size: %" PRIu64 "\n", vpi->size);
> +                monitor_hmp_printf(hmp, "  memdev: %s\n", vpi->memdev);
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
>                  vmi = value->u.virtio_mem.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               vmi->id ? vmi->id : "");
> -                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vmi->memaddr);
> -                monitor_printf(mon, "  node: %" PRId64 "\n", vmi->node);
> -                monitor_printf(mon, "  requested-size: %" PRIu64 "\n",
> -                               vmi->requested_size);
> -                monitor_printf(mon, "  size: %" PRIu64 "\n", vmi->size);
> -                monitor_printf(mon, "  max-size: %" PRIu64 "\n", vmi->max_size);
> -                monitor_printf(mon, "  block-size: %" PRIu64 "\n",
> -                               vmi->block_size);
> -                monitor_printf(mon, "  memdev: %s\n", vmi->memdev);
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   vmi->id ? vmi->id : "");
> +                monitor_hmp_printf(hmp, "  memaddr: 0x%" PRIx64 "\n", vmi->memaddr);
> +                monitor_hmp_printf(hmp, "  node: %" PRId64 "\n", vmi->node);
> +                monitor_hmp_printf(hmp, "  requested-size: %" PRIu64 "\n",
> +                                   vmi->requested_size);
> +                monitor_hmp_printf(hmp, "  size: %" PRIu64 "\n", vmi->size);
> +                monitor_hmp_printf(hmp, "  max-size: %" PRIu64 "\n", vmi->max_size);
> +                monitor_hmp_printf(hmp, "  block-size: %" PRIu64 "\n",
> +                                   vmi->block_size);
> +                monitor_hmp_printf(hmp, "  memdev: %s\n", vmi->memdev);
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_SGX_EPC:
>                  se = value->u.sgx_epc.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               se->id ? se->id : "");
> -                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", se->memaddr);
> -                monitor_printf(mon, "  size: %" PRIu64 "\n", se->size);
> -                monitor_printf(mon, "  node: %" PRId64 "\n", se->node);
> -                monitor_printf(mon, "  memdev: %s\n", se->memdev);
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   se->id ? se->id : "");
> +                monitor_hmp_printf(hmp, "  memaddr: 0x%" PRIx64 "\n", se->memaddr);
> +                monitor_hmp_printf(hmp, "  size: %" PRIu64 "\n", se->size);
> +                monitor_hmp_printf(hmp, "  node: %" PRId64 "\n", se->node);
> +                monitor_hmp_printf(hmp, "  memdev: %s\n", se->memdev);
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_HV_BALLOON:
>                  hi = value->u.hv_balloon.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               hi->id ? hi->id : "");
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   hi->id ? hi->id : "");
>                  if (hi->has_memaddr) {
> -                    monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
> -                                   hi->memaddr);
> +                    monitor_hmp_printf(hmp, "  memaddr: 0x%" PRIx64 "\n",
> +                                       hi->memaddr);
>                  }
> -                monitor_printf(mon, "  max-size: %" PRIu64 "\n", hi->max_size);
> +                monitor_hmp_printf(hmp, "  max-size: %" PRIu64 "\n", hi->max_size);
>                  if (hi->memdev) {
> -                    monitor_printf(mon, "  memdev: %s\n", hi->memdev);
> +                    monitor_hmp_printf(hmp, "  memdev: %s\n", hi->memdev);
>                  }
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_SP_MEM:
>                  spmi = value->u.sp_mem.data;
> -                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> -                               MemoryDeviceInfoKind_str(value->type),
> -                               spmi->id ? spmi->id : "");
> -                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
> -                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
> -                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
> -                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
> +                monitor_hmp_printf(hmp, "Memory device [%s]: \"%s\"\n",
> +                                   MemoryDeviceInfoKind_str(value->type),
> +                                   spmi->id ? spmi->id : "");
> +                monitor_hmp_printf(hmp, "  addr: 0x%" PRIx64 "\n", spmi->addr);
> +                monitor_hmp_printf(hmp, "  node: %" PRId64 "\n", spmi->node);
> +                monitor_hmp_printf(hmp, "  size: %" PRIu64 "\n", spmi->size);
> +                monitor_hmp_printf(hmp, "  memdev: %s\n", spmi->memdev);
>                  break;
>              default:
>                  g_assert_not_reached();
> @@ -381,11 +372,10 @@ void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      GuidInfo *info = qmp_query_vm_generation_id(&err);
>      if (info) {
> -        monitor_printf(mon, "%s\n", info->guid);
> +        monitor_hmp_printf(hmp, "%s\n", info->guid);
>      }
>      hmp_handle_error(hmp, err);
>      qapi_free_GuidInfo(info);
> @@ -393,16 +383,15 @@ void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_memory_size_summary(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      MemoryInfo *info = qmp_query_memory_size_summary(&err);
>      if (info) {
> -        monitor_printf(mon, "base memory: %" PRIu64 "\n",
> -                       info->base_memory);
> +        monitor_hmp_printf(hmp, "base memory: %" PRIu64 "\n",
> +                           info->base_memory);
>  
>          if (info->has_plugged_memory) {
> -            monitor_printf(mon, "plugged memory: %" PRIu64 "\n",
> -                           info->plugged_memory);
> +            monitor_hmp_printf(hmp, "plugged memory: %" PRIu64 "\n",
> +                               info->plugged_memory);
>          }
>  
>          qapi_free_MemoryInfo(info);
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index 13df7cbafe10..82130ba04698 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -252,13 +252,14 @@ bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp)
>  static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
>  {
>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
>      hwaddr size;
>      int i;
>  
>      for (i = 0; i < s->num_mmio; i++) {
>          size = memory_region_size(s->mmio[i].memory);
> -        monitor_printf(mon, "%*smmio " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
> -                       indent, "", s->mmio[i].addr, size);
> +        monitor_hmp_printf(hmp, "%*smmio " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
> +                           indent, "", s->mmio[i].addr, size);
>      }
>  }
>  
> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> index 2d878cee736d..576929ff224b 100644
> --- a/hw/hexagon/hexagon_tlb.c
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -124,30 +124,32 @@ static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
>  
>  bool hexagon_tlb_dump_entry(Monitor *mon, uint64_t entry)
>  {
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
> +
>      if (GET_PTE_V(entry)) {
>          uint64_t PA = hex_tlb_phys_addr(entry);
>          uint64_t VA = hex_tlb_virt_addr(entry);
> -        monitor_printf(mon, "0x%016" PRIx64 ": ", entry);
> -        monitor_printf(mon, "V:%" PRId64 " G:%" PRId64
> -                       " A1:%" PRId64 " A0:%" PRId64,
> -                       GET_PTE_V(entry),
> -                       GET_PTE_G(entry),
> -                       GET_PTE_ATR1(entry),
> -                       GET_PTE_ATR0(entry));
> -        monitor_printf(mon, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> -                       GET_PTE_ASID(entry), VA);
> -        monitor_printf(mon,
> -                       " X:%" PRId64 " W:%" PRId64 " R:%" PRId64
> -                       " U:%" PRId64 " C:%" PRId64,
> -                       GET_PTE_X(entry),
> -                       GET_PTE_W(entry),
> -                       GET_PTE_R(entry),
> -                       GET_PTE_U(entry),
> -                       GET_PTE_C(entry));
> -        monitor_printf(mon, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")",
> -                       PA, pgsize_str[hex_tlb_pgsize_type(entry)],
> -                       hex_tlb_page_size_bytes(entry));
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "0x%016" PRIx64 ": ", entry);
> +        monitor_hmp_printf(hmp, "V:%" PRId64 " G:%" PRId64
> +                           " A1:%" PRId64 " A0:%" PRId64,
> +                           GET_PTE_V(entry),
> +                           GET_PTE_G(entry),
> +                           GET_PTE_ATR1(entry),
> +                           GET_PTE_ATR0(entry));
> +        monitor_hmp_printf(hmp, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
> +                           GET_PTE_ASID(entry), VA);
> +        monitor_hmp_printf(hmp,
> +                           " X:%" PRId64 " W:%" PRId64 " R:%" PRId64
> +                           " U:%" PRId64 " C:%" PRId64,
> +                           GET_PTE_X(entry),
> +                           GET_PTE_W(entry),
> +                           GET_PTE_R(entry),
> +                           GET_PTE_U(entry),
> +                           GET_PTE_C(entry));
> +        monitor_hmp_printf(hmp, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")",
> +                           PA, pgsize_str[hex_tlb_pgsize_type(entry)],
> +                           hex_tlb_page_size_bytes(entry));
> +        monitor_hmp_printf(hmp, "\n");
>          return true;
>      }
>  
> diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
> index ab1eb14f99e0..5ed71583281a 100644
> --- a/hw/i386/kvm/xen-stubs.c
> +++ b/hw/i386/kvm/xen-stubs.c
> @@ -42,12 +42,10 @@ void xen_primary_console_set_be_port(uint16_t port)
>  
>  void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
> +    monitor_hmp_printf(hmp, "XEN emulation is not available in this QEMU\n");
>  }
>  
>  void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
> +    monitor_hmp_printf(hmp, "XEN emulation is not available in this QEMU\n");
>  }
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 00dff6ee8760..b2135020f27f 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -2346,7 +2346,6 @@ void qmp_xen_event_inject(uint32_t port, Error **errp)
>  
>  void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      EvtchnInfoList *iter, *info_list;
>      Error *err = NULL;
>  
> @@ -2359,22 +2358,22 @@ void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
>      for (iter = info_list; iter; iter = iter->next) {
>          EvtchnInfo *info = iter->value;
>  
> -        monitor_printf(mon, "port %4u: vcpu: %d %s", info->port, info->vcpu,
> -                       EvtchnPortType_str(info->type));
> +        monitor_hmp_printf(hmp, "port %4u: vcpu: %d %s", info->port, info->vcpu,
> +                           EvtchnPortType_str(info->type));
>          if (info->type != EVTCHN_PORT_TYPE_IPI) {
> -            monitor_printf(mon,  "(");
> +            monitor_hmp_printf(hmp,  "(");
>              if (info->remote_domain) {
> -                monitor_printf(mon, "%s:", info->remote_domain);
> +                monitor_hmp_printf(hmp, "%s:", info->remote_domain);
>              }
> -            monitor_printf(mon, "%d)", info->target);
> +            monitor_hmp_printf(hmp, "%d)", info->target);
>          }
>          if (info->pending) {
> -            monitor_printf(mon, " PENDING");
> +            monitor_hmp_printf(hmp, " PENDING");
>          }
>          if (info->masked) {
> -            monitor_printf(mon, " MASKED");
> +            monitor_hmp_printf(hmp, " MASKED");
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>  
>      qapi_free_EvtchnInfoList(info_list);
> @@ -2382,7 +2381,6 @@ void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int port = qdict_get_int(qdict, "port");
>      Error *err = NULL;
>  
> @@ -2390,7 +2388,6 @@ void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
>      if (err) {
>          hmp_handle_error(hmp, err);
>      } else {
> -        monitor_printf(mon, "Delivered port %d\n", port);
> +        monitor_hmp_printf(hmp, "Delivered port %d\n", port);
>      }
>  }
> -
> diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
> index a4848ae1d1a7..b7afb26886a8 100644
> --- a/hw/i386/sgx-hmp-stub.c
> +++ b/hw/i386/sgx-hmp-stub.c
> @@ -12,6 +12,5 @@
>  
>  void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "SGX is not available in this QEMU\n");
> +    monitor_hmp_printf(hmp, "SGX is not available in this QEMU\n");
>  }
> diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
> index 77b41d234c9f..634e33e819ce 100644
> --- a/hw/i386/sgx.c
> +++ b/hw/i386/sgx.c
> @@ -236,7 +236,6 @@ SgxInfo *qmp_query_sgx(Error **errp)
>  
>  void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      SgxEpcSectionList *section_list, *section;
>      g_autoptr(SgxInfo) info = qmp_query_sgx(&err);
> @@ -246,25 +245,25 @@ void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
>          error_report_err(err);
>          return;
>      }
> -    monitor_printf(mon, "SGX support: %s\n",
> -                   info->sgx ? "enabled" : "disabled");
> -    monitor_printf(mon, "SGX1 support: %s\n",
> -                   info->sgx1 ? "enabled" : "disabled");
> -    monitor_printf(mon, "SGX2 support: %s\n",
> -                   info->sgx2 ? "enabled" : "disabled");
> -    monitor_printf(mon, "FLC support: %s\n",
> -                   info->flc ? "enabled" : "disabled");
> +    monitor_hmp_printf(hmp, "SGX support: %s\n",
> +                       info->sgx ? "enabled" : "disabled");
> +    monitor_hmp_printf(hmp, "SGX1 support: %s\n",
> +                       info->sgx1 ? "enabled" : "disabled");
> +    monitor_hmp_printf(hmp, "SGX2 support: %s\n",
> +                       info->sgx2 ? "enabled" : "disabled");
> +    monitor_hmp_printf(hmp, "FLC support: %s\n",
> +                       info->flc ? "enabled" : "disabled");
>  
>      section_list = info->sections;
>      for (section = section_list; section; section = section->next) {
> -        monitor_printf(mon, "NUMA node #%" PRId64 ": ",
> -                       section->value->node);
> -        monitor_printf(mon, "size=%" PRIu64 "\n",
> -                       section->value->size);
> +        monitor_hmp_printf(hmp, "NUMA node #%" PRId64 ": ",
> +                           section->value->node);
> +        monitor_hmp_printf(hmp, "size=%" PRIu64 "\n",
> +                           section->value->size);
>          size += section->value->size;
>      }
> -    monitor_printf(mon, "total size=%" PRIu64 "\n",
> -                   size);
> +    monitor_hmp_printf(hmp, "total size=%" PRIu64 "\n",
> +                       size);
>  }
>  
>  bool check_sgx_support(void)
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index ac2525b90fec..ffa76f83016b 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -300,10 +300,11 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
>  
>      s = AUX_SLAVE(dev);
>  
> -    monitor_printf(mon, "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
> -                   indent, "",
> -                   object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
> -                   memory_region_size(s->mmio));
> +    monitor_hmp_printf(MONITOR_HMP(mon),
> +                       "%*smemory " HWADDR_FMT_plx "/" HWADDR_FMT_plx "\n",
> +                       indent, "",
> +                       object_property_get_uint(OBJECT(s->mmio), "addr", NULL),
> +                       memory_region_size(s->mmio));
>  }
>  
>  void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio)
> diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
> index 6a7d76292f00..154cd32ed88b 100644
> --- a/hw/misc/mos6522-stub.c
> +++ b/hw/misc/mos6522-stub.c
> @@ -12,6 +12,5 @@
>  
>  void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
> +    monitor_hmp_printf(hmp, "MOS6522 VIA is not available in this QEMU\n");
>  }
> diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
> index 6405ce26dd65..5099d59cc620 100644
> --- a/hw/net/rocker/rocker-hmp-cmds.c
> +++ b/hw/net/rocker/rocker-hmp-cmds.c
> @@ -22,7 +22,6 @@
>  
>  void hmp_rocker(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *name = qdict_get_str(qdict, "name");
>      RockerSwitch *rocker;
>      Error *err = NULL;
> @@ -32,16 +31,15 @@ void hmp_rocker(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "name: %s\n", rocker->name);
> -    monitor_printf(mon, "id: 0x%" PRIx64 "\n", rocker->id);
> -    monitor_printf(mon, "ports: %d\n", rocker->ports);
> +    monitor_hmp_printf(hmp, "name: %s\n", rocker->name);
> +    monitor_hmp_printf(hmp, "id: 0x%" PRIx64 "\n", rocker->id);
> +    monitor_hmp_printf(hmp, "ports: %d\n", rocker->ports);
>  
>      qapi_free_RockerSwitch(rocker);
>  }
>  
>  void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      RockerPortList *list, *port;
>      const char *name = qdict_get_str(qdict, "name");
>      Error *err = NULL;
> @@ -51,17 +49,17 @@ void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "            ena/    speed/ auto\n");
> -    monitor_printf(mon, "      port  link    duplex neg?\n");
> +    monitor_hmp_printf(hmp, "            ena/    speed/ auto\n");
> +    monitor_hmp_printf(hmp, "      port  link    duplex neg?\n");
>  
>      for (port = list; port; port = port->next) {
> -        monitor_printf(mon, "%10s  %-4s   %-3s  %2s  %s\n",
> -                       port->value->name,
> -                       port->value->enabled ? port->value->link_up ?
> -                       "up" : "down" : "!ena",
> -                       port->value->speed == 10000 ? "10G" : "??",
> -                       port->value->duplex ? "FD" : "HD",
> -                       port->value->autoneg ? "Yes" : "No");
> +        monitor_hmp_printf(hmp, "%10s  %-4s   %-3s  %2s  %s\n",
> +                           port->value->name,
> +                           port->value->enabled ? port->value->link_up ?
> +                           "up" : "down" : "!ena",
> +                           port->value->speed == 10000 ? "10G" : "??",
> +                           port->value->duplex ? "FD" : "HD",
> +                           port->value->autoneg ? "Yes" : "No");
>      }
>  
>      qapi_free_RockerPortList(list);
> @@ -69,7 +67,6 @@ void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      RockerOfDpaFlowList *list, *info;
>      const char *name = qdict_get_str(qdict, "name");
>      uint32_t tbl_id = qdict_get_try_int(qdict, "tbl_id", -1);
> @@ -80,7 +77,7 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "prio tbl hits key(mask) --> actions\n");
> +    monitor_hmp_printf(hmp, "prio tbl hits key(mask) --> actions\n");
>  
>      for (info = list; info; info = info->next) {
>          RockerOfDpaFlow *flow = info->value;
> @@ -89,54 +86,54 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>          RockerOfDpaFlowAction *action = flow->action;
>  
>          if (flow->hits) {
> -            monitor_printf(mon, "%-4d %-3d %-4" PRIu64,
> -                           key->priority, key->tbl_id, flow->hits);
> +            monitor_hmp_printf(hmp, "%-4d %-3d %-4" PRIu64,
> +                               key->priority, key->tbl_id, flow->hits);
>          } else {
> -            monitor_printf(mon, "%-4d %-3d     ",
> -                           key->priority, key->tbl_id);
> +            monitor_hmp_printf(hmp, "%-4d %-3d     ",
> +                               key->priority, key->tbl_id);
>          }
>  
>          if (key->has_in_pport) {
> -            monitor_printf(mon, " pport %d", key->in_pport);
> +            monitor_hmp_printf(hmp, " pport %d", key->in_pport);
>              if (mask->has_in_pport) {
> -                monitor_printf(mon, "(0x%x)", mask->in_pport);
> +                monitor_hmp_printf(hmp, "(0x%x)", mask->in_pport);
>              }
>          }
>  
>          if (key->has_vlan_id) {
> -            monitor_printf(mon, " vlan %d",
> -                           key->vlan_id & VLAN_VID_MASK);
> +            monitor_hmp_printf(hmp, " vlan %d",
> +                               key->vlan_id & VLAN_VID_MASK);
>              if (mask->has_vlan_id) {
> -                monitor_printf(mon, "(0x%x)", mask->vlan_id);
> +                monitor_hmp_printf(hmp, "(0x%x)", mask->vlan_id);
>              }
>          }
>  
>          if (key->has_tunnel_id) {
> -            monitor_printf(mon, " tunnel %d", key->tunnel_id);
> +            monitor_hmp_printf(hmp, " tunnel %d", key->tunnel_id);
>              if (mask->has_tunnel_id) {
> -                monitor_printf(mon, "(0x%x)", mask->tunnel_id);
> +                monitor_hmp_printf(hmp, "(0x%x)", mask->tunnel_id);
>              }
>          }
>  
>          if (key->has_eth_type) {
>              switch (key->eth_type) {
>              case 0x0806:
> -                monitor_printf(mon, " ARP");
> +                monitor_hmp_printf(hmp, " ARP");
>                  break;
>              case 0x0800:
> -                monitor_printf(mon, " IP");
> +                monitor_hmp_printf(hmp, " IP");
>                  break;
>              case 0x86dd:
> -                monitor_printf(mon, " IPv6");
> +                monitor_hmp_printf(hmp, " IPv6");
>                  break;
>              case 0x8809:
> -                monitor_printf(mon, " LACP");
> +                monitor_hmp_printf(hmp, " LACP");
>                  break;
>              case 0x88cc:
> -                monitor_printf(mon, " LLDP");
> +                monitor_hmp_printf(hmp, " LLDP");
>                  break;
>              default:
> -                monitor_printf(mon, " eth type 0x%04x", key->eth_type);
> +                monitor_hmp_printf(hmp, " eth type 0x%04x", key->eth_type);
>                  break;
>              }
>          }
> @@ -145,15 +142,15 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>              if ((strcmp(key->eth_src, "01:00:00:00:00:00") == 0) &&
>                  mask->eth_src &&
>                  (strcmp(mask->eth_src, "01:00:00:00:00:00") == 0)) {
> -                monitor_printf(mon, " src <any mcast/bcast>");
> +                monitor_hmp_printf(hmp, " src <any mcast/bcast>");
>              } else if ((strcmp(key->eth_src, "00:00:00:00:00:00") == 0) &&
>                  mask->eth_src &&
>                  (strcmp(mask->eth_src, "01:00:00:00:00:00") == 0)) {
> -                monitor_printf(mon, " src <any ucast>");
> +                monitor_hmp_printf(hmp, " src <any ucast>");
>              } else {
> -                monitor_printf(mon, " src %s", key->eth_src);
> +                monitor_hmp_printf(hmp, " src %s", key->eth_src);
>                  if (mask->eth_src) {
> -                    monitor_printf(mon, "(%s)", mask->eth_src);
> +                    monitor_hmp_printf(hmp, "(%s)", mask->eth_src);
>                  }
>              }
>          }
> @@ -162,56 +159,56 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>              if ((strcmp(key->eth_dst, "01:00:00:00:00:00") == 0) &&
>                  mask->eth_dst &&
>                  (strcmp(mask->eth_dst, "01:00:00:00:00:00") == 0)) {
> -                monitor_printf(mon, " dst <any mcast/bcast>");
> +                monitor_hmp_printf(hmp, " dst <any mcast/bcast>");
>              } else if ((strcmp(key->eth_dst, "00:00:00:00:00:00") == 0) &&
>                  mask->eth_dst &&
>                  (strcmp(mask->eth_dst, "01:00:00:00:00:00") == 0)) {
> -                monitor_printf(mon, " dst <any ucast>");
> +                monitor_hmp_printf(hmp, " dst <any ucast>");
>              } else {
> -                monitor_printf(mon, " dst %s", key->eth_dst);
> +                monitor_hmp_printf(hmp, " dst %s", key->eth_dst);
>                  if (mask->eth_dst) {
> -                    monitor_printf(mon, "(%s)", mask->eth_dst);
> +                    monitor_hmp_printf(hmp, "(%s)", mask->eth_dst);
>                  }
>              }
>          }
>  
>          if (key->has_ip_proto) {
> -            monitor_printf(mon, " proto %d", key->ip_proto);
> +            monitor_hmp_printf(hmp, " proto %d", key->ip_proto);
>              if (mask->has_ip_proto) {
> -                monitor_printf(mon, "(0x%x)", mask->ip_proto);
> +                monitor_hmp_printf(hmp, "(0x%x)", mask->ip_proto);
>              }
>          }
>  
>          if (key->has_ip_tos) {
> -            monitor_printf(mon, " TOS %d", key->ip_tos);
> +            monitor_hmp_printf(hmp, " TOS %d", key->ip_tos);
>              if (mask->has_ip_tos) {
> -                monitor_printf(mon, "(0x%x)", mask->ip_tos);
> +                monitor_hmp_printf(hmp, "(0x%x)", mask->ip_tos);
>              }
>          }
>  
>          if (key->ip_dst) {
> -            monitor_printf(mon, " dst %s", key->ip_dst);
> +            monitor_hmp_printf(hmp, " dst %s", key->ip_dst);
>          }
>  
>          if (action->has_goto_tbl || action->has_group_id ||
>              action->has_new_vlan_id) {
> -            monitor_printf(mon, " -->");
> +            monitor_hmp_printf(hmp, " -->");
>          }
>  
>          if (action->has_new_vlan_id) {
> -            monitor_printf(mon, " apply new vlan %d",
> -                           ntohs(action->new_vlan_id));
> +            monitor_hmp_printf(hmp, " apply new vlan %d",
> +                               ntohs(action->new_vlan_id));
>          }
>  
>          if (action->has_group_id) {
> -            monitor_printf(mon, " write group 0x%08x", action->group_id);
> +            monitor_hmp_printf(hmp, " write group 0x%08x", action->group_id);
>          }
>  
>          if (action->has_goto_tbl) {
> -            monitor_printf(mon, " goto tbl %d", action->goto_tbl);
> +            monitor_hmp_printf(hmp, " goto tbl %d", action->goto_tbl);
>          }
>  
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>  
>      qapi_free_RockerOfDpaFlowList(list);
> @@ -219,7 +216,6 @@ void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      RockerOfDpaGroupList *list, *g;
>      const char *name = qdict_get_str(qdict, "name");
>      uint8_t type = qdict_get_try_int(qdict, "type", 9);
> @@ -230,15 +226,15 @@ void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "id (decode) --> buckets\n");
> +    monitor_hmp_printf(hmp, "id (decode) --> buckets\n");
>  
>      for (g = list; g; g = g->next) {
>          RockerOfDpaGroup *group = g->value;
>          bool set = false;
>  
> -        monitor_printf(mon, "0x%08x", group->id);
> +        monitor_hmp_printf(hmp, "0x%08x", group->id);
>  
> -        monitor_printf(mon, " (type %s", group->type == 0 ? "L2 interface" :
> +        monitor_hmp_printf(hmp, " (type %s", group->type == 0 ? "L2 interface" :
>                                           group->type == 1 ? "L2 rewrite" :
>                                           group->type == 2 ? "L3 unicast" :
>                                           group->type == 3 ? "L2 multicast" :
> @@ -250,70 +246,70 @@ void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict)
>                                           "unknown");
>  
>          if (group->has_vlan_id) {
> -            monitor_printf(mon, " vlan %d", group->vlan_id);
> +            monitor_hmp_printf(hmp, " vlan %d", group->vlan_id);
>          }
>  
>          if (group->has_pport) {
> -            monitor_printf(mon, " pport %d", group->pport);
> +            monitor_hmp_printf(hmp, " pport %d", group->pport);
>          }
>  
>          if (group->has_index) {
> -            monitor_printf(mon, " index %d", group->index);
> +            monitor_hmp_printf(hmp, " index %d", group->index);
>          }
>  
> -        monitor_printf(mon, ") -->");
> +        monitor_hmp_printf(hmp, ") -->");
>  
>          if (group->has_set_vlan_id && group->set_vlan_id) {
>              set = true;
> -            monitor_printf(mon, " set vlan %d",
> -                           group->set_vlan_id & VLAN_VID_MASK);
> +            monitor_hmp_printf(hmp, " set vlan %d",
> +                               group->set_vlan_id & VLAN_VID_MASK);
>          }
>  
>          if (group->set_eth_src) {
>              if (!set) {
>                  set = true;
> -                monitor_printf(mon, " set");
> +                monitor_hmp_printf(hmp, " set");
>              }
> -            monitor_printf(mon, " src %s", group->set_eth_src);
> +            monitor_hmp_printf(hmp, " src %s", group->set_eth_src);
>          }
>  
>          if (group->set_eth_dst) {
>              if (!set) {
> -                monitor_printf(mon, " set");
> +                monitor_hmp_printf(hmp, " set");
>              }
> -            monitor_printf(mon, " dst %s", group->set_eth_dst);
> +            monitor_hmp_printf(hmp, " dst %s", group->set_eth_dst);
>          }
>  
>          if (group->has_ttl_check && group->ttl_check) {
> -            monitor_printf(mon, " check TTL");
> +            monitor_hmp_printf(hmp, " check TTL");
>          }
>  
>          if (group->has_group_id && group->group_id) {
> -            monitor_printf(mon, " group id 0x%08x", group->group_id);
> +            monitor_hmp_printf(hmp, " group id 0x%08x", group->group_id);
>          }
>  
>          if (group->has_pop_vlan && group->pop_vlan) {
> -            monitor_printf(mon, " pop vlan");
> +            monitor_hmp_printf(hmp, " pop vlan");
>          }
>  
>          if (group->has_out_pport) {
> -            monitor_printf(mon, " out pport %d", group->out_pport);
> +            monitor_hmp_printf(hmp, " out pport %d", group->out_pport);
>          }
>  
>          if (group->has_group_ids) {
>              struct uint32List *id;
>  
> -            monitor_printf(mon, " groups [");
> +            monitor_hmp_printf(hmp, " groups [");
>              for (id = group->group_ids; id; id = id->next) {
> -                monitor_printf(mon, "0x%08x", id->value);
> +                monitor_hmp_printf(hmp, "0x%08x", id->value);
>                  if (id->next) {
> -                    monitor_printf(mon, ",");
> +                    monitor_hmp_printf(hmp, ",");
>                  }
>              }
> -            monitor_printf(mon, "]");
> +            monitor_hmp_printf(hmp, "]");
>          }
>  
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>  
>      qapi_free_RockerOfDpaGroupList(list);
> diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
> index 51d95d76620e..500f821246a9 100644
> --- a/hw/pci/pci-hmp-cmds.c
> +++ b/hw/pci/pci-hmp-cmds.c
> @@ -24,54 +24,55 @@
>  #include "qapi/qapi-commands-pci.h"
>  #include "qemu/cutils.h"
>  
> -static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
> +static void hmp_info_pci_device(MonitorHMP *hmp, const PciDeviceInfo *dev)
>  {
> +    Monitor *mon = MONITOR(hmp);
>      PciMemoryRegionList *region;
>  
> -    monitor_printf(mon, "  Bus %2" PRId64 ", ", dev->bus);
> -    monitor_printf(mon, "device %3" PRId64 ", function %" PRId64 ":\n",
> -                   dev->slot, dev->function);
> -    monitor_printf(mon, "    ");
> +    monitor_hmp_printf(hmp, "  Bus %2" PRId64 ", ", dev->bus);
> +    monitor_hmp_printf(hmp, "device %3" PRId64 ", function %" PRId64 ":\n",
> +                       dev->slot, dev->function);
> +    monitor_hmp_printf(hmp, "    ");
>  
>      if (dev->class_info->desc) {
>          monitor_puts(mon, dev->class_info->desc);
>      } else {
> -        monitor_printf(mon, "Class %04" PRId64, dev->class_info->q_class);
> +        monitor_hmp_printf(hmp, "Class %04" PRId64, dev->class_info->q_class);
>      }
>  
> -    monitor_printf(mon, ": PCI device %04" PRIx64 ":%04" PRIx64 "\n",
> -                   dev->id->vendor, dev->id->device);
> +    monitor_hmp_printf(hmp, ": PCI device %04" PRIx64 ":%04" PRIx64 "\n",
> +                       dev->id->vendor, dev->id->device);
>      if (dev->id->has_subsystem_vendor && dev->id->has_subsystem) {
> -        monitor_printf(mon, "      PCI subsystem %04" PRIx64 ":%04" PRIx64 "\n",
> -                       dev->id->subsystem_vendor, dev->id->subsystem);
> +        monitor_hmp_printf(hmp, "      PCI subsystem %04" PRIx64 ":%04" PRIx64 "\n",
> +                           dev->id->subsystem_vendor, dev->id->subsystem);
>      }
>  
>      if (dev->has_irq) {
> -        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
> -                       dev->irq, (char)('A' + dev->irq_pin - 1));
> +        monitor_hmp_printf(hmp, "      IRQ %" PRId64 ", pin %c\n",
> +                           dev->irq, (char)('A' + dev->irq_pin - 1));
>      }
>  
>      if (dev->pci_bridge) {
> -        monitor_printf(mon, "      BUS %" PRId64 ".\n",
> -                       dev->pci_bridge->bus->number);
> -        monitor_printf(mon, "      secondary bus %" PRId64 ".\n",
> -                       dev->pci_bridge->bus->secondary);
> -        monitor_printf(mon, "      subordinate bus %" PRId64 ".\n",
> -                       dev->pci_bridge->bus->subordinate);
> +        monitor_hmp_printf(hmp, "      BUS %" PRId64 ".\n",
> +                           dev->pci_bridge->bus->number);
> +        monitor_hmp_printf(hmp, "      secondary bus %" PRId64 ".\n",
> +                           dev->pci_bridge->bus->secondary);
> +        monitor_hmp_printf(hmp, "      subordinate bus %" PRId64 ".\n",
> +                           dev->pci_bridge->bus->subordinate);
>  
> -        monitor_printf(mon, "      IO range [0x%04"PRIx64", 0x%04"PRIx64"]\n",
> -                       dev->pci_bridge->bus->io_range->base,
> -                       dev->pci_bridge->bus->io_range->limit);
> +        monitor_hmp_printf(hmp, "      IO range [0x%04"PRIx64", 0x%04"PRIx64"]\n",
> +                           dev->pci_bridge->bus->io_range->base,
> +                           dev->pci_bridge->bus->io_range->limit);
>  
> -        monitor_printf(mon,
> -                       "      memory range [0x%08"PRIx64", 0x%08"PRIx64"]\n",
> -                       dev->pci_bridge->bus->memory_range->base,
> -                       dev->pci_bridge->bus->memory_range->limit);
> +        monitor_hmp_printf(hmp,
> +                           "      memory range [0x%08"PRIx64", 0x%08"PRIx64"]\n",
> +                           dev->pci_bridge->bus->memory_range->base,
> +                           dev->pci_bridge->bus->memory_range->limit);
>  
> -        monitor_printf(mon, "      prefetchable memory range "
> -                       "[0x%08"PRIx64", 0x%08"PRIx64"]\n",
> -                       dev->pci_bridge->bus->prefetchable_range->base,
> -                       dev->pci_bridge->bus->prefetchable_range->limit);
> +        monitor_hmp_printf(hmp, "      prefetchable memory range "
> +                           "[0x%08"PRIx64", 0x%08"PRIx64"]\n",
> +                           dev->pci_bridge->bus->prefetchable_range->base,
> +                           dev->pci_bridge->bus->prefetchable_range->limit);
>      }
>  
>      for (region = dev->regions; region; region = region->next) {
> @@ -80,38 +81,38 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>          addr = region->value->address;
>          size = region->value->size;
>  
> -        monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
> +        monitor_hmp_printf(hmp, "      BAR%" PRId64 ": ", region->value->bar);
>  
>          if (!strcmp(region->value->type, "io")) {
>              if (addr != PCI_BAR_UNMAPPED) {
> -                monitor_printf(mon, "I/O at 0x%04" PRIx64
> +                monitor_hmp_printf(hmp, "I/O at 0x%04" PRIx64
>                                      " [0x%04" PRIx64 "]\n",
>                                 addr, addr + size - 1);
>              } else {
> -                monitor_printf(mon, "I/O (not mapped)\n");
> +                monitor_hmp_printf(hmp, "I/O (not mapped)\n");
>              }
>          } else {
>              if (addr != PCI_BAR_UNMAPPED) {
> -                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> +                monitor_hmp_printf(hmp, "%d bit%s memory at 0x%08" PRIx64
>                                     " [0x%08" PRIx64 "]\n",
>                                 region->value->mem_type_64 ? 64 : 32,
>                                 region->value->prefetch ? " prefetchable" : "",
>                                 addr, addr + size - 1);
>              } else {
> -                monitor_printf(mon, "%d bit%s memory (not mapped)\n",
> -                               region->value->mem_type_64 ? 64 : 32,
> -                               region->value->prefetch ? " prefetchable" : "");
> +                monitor_hmp_printf(hmp, "%d bit%s memory (not mapped)\n",
> +                                   region->value->mem_type_64 ? 64 : 32,
> +                                   region->value->prefetch ? " prefetchable" : "");
>              }
>          }
>      }
>  
> -    monitor_printf(mon, "      id \"%s\"\n", dev->qdev_id);
> +    monitor_hmp_printf(hmp, "      id \"%s\"\n", dev->qdev_id);
>  
>      if (dev->pci_bridge) {
>          if (dev->pci_bridge->has_devices) {
>              PciDeviceInfoList *cdev;
>              for (cdev = dev->pci_bridge->devices; cdev; cdev = cdev->next) {
> -                hmp_info_pci_device(mon, cdev->value);
> +                hmp_info_pci_device(hmp, cdev->value);
>              }
>          }
>      }
> @@ -119,7 +120,6 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>  
>  void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      PciInfoList *info_list, *info;
>  
>      info_list = qmp_query_pci(&error_abort);
> @@ -128,7 +128,7 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
>          PciDeviceInfoList *dev;
>  
>          for (dev = info->value->devices; dev; dev = dev->next) {
> -            hmp_info_pci_device(mon, dev->value);
> +            hmp_info_pci_device(hmp, dev->value);
>          }
>      }
>  
> @@ -137,6 +137,7 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
>  
>  void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
>  {
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
>      PCIDevice *d = (PCIDevice *)dev;
>      int class = pci_get_word(d->config + PCI_CLASS_DEVICE);
>      const pci_class_desc *desc = get_class_desc(class);
> @@ -150,30 +151,29 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
>          snprintf(ctxt, sizeof(ctxt), "Class %04x", class);
>      }
>  
> -    monitor_printf(mon, "%*sclass %s, addr %02x:%02x.%x, "
> -                   "pci id %04x:%04x (sub %04x:%04x)\n",
> -                   indent, "", ctxt, pci_dev_bus_num(d),
> -                   PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
> -                   pci_get_word(d->config + PCI_VENDOR_ID),
> -                   pci_get_word(d->config + PCI_DEVICE_ID),
> -                   pci_get_word(d->config + PCI_SUBSYSTEM_VENDOR_ID),
> -                   pci_get_word(d->config + PCI_SUBSYSTEM_ID));
> +    monitor_hmp_printf(hmp, "%*sclass %s, addr %02x:%02x.%x, "
> +                       "pci id %04x:%04x (sub %04x:%04x)\n",
> +                       indent, "", ctxt, pci_dev_bus_num(d),
> +                       PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
> +                       pci_get_word(d->config + PCI_VENDOR_ID),
> +                       pci_get_word(d->config + PCI_DEVICE_ID),
> +                       pci_get_word(d->config + PCI_SUBSYSTEM_VENDOR_ID),
> +                       pci_get_word(d->config + PCI_SUBSYSTEM_ID));
>      for (i = 0; i < PCI_NUM_REGIONS; i++) {
>          r = &d->io_regions[i];
>          if (!r->size) {
>              continue;
>          }
> -        monitor_printf(mon, "%*sbar %d: %s at 0x%"FMT_PCIBUS
> -                       " [0x%"FMT_PCIBUS"]\n",
> -                       indent, "",
> -                       i, r->type & PCI_BASE_ADDRESS_SPACE_IO ? "i/o" : "mem",
> -                       r->addr, r->addr + r->size - 1);
> +        monitor_hmp_printf(hmp, "%*sbar %d: %s at 0x%"FMT_PCIBUS
> +                           " [0x%"FMT_PCIBUS"]\n",
> +                           indent, "",
> +                           i, r->type & PCI_BASE_ADDRESS_SPACE_IO ? "i/o" : "mem",
> +                           r->addr, r->addr + r->size - 1);
>      }
>  }
>  
>  void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *id = qdict_get_str(qdict, "id");
>      const char *error_name;
> @@ -242,9 +242,9 @@ void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
>      }
>  
>  
> -    monitor_printf(mon, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n",
> -                   id, pci_root_bus_path(dev), pci_dev_bus_num(dev),
> -                   PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +    monitor_hmp_printf(hmp, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n",
> +                       id, pci_root_bus_path(dev), pci_dev_bus_num(dev),
> +                       PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
>  
>  out:
>      hmp_handle_error(hmp, err);
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index a80e34175462..7e2797300ba0 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -40,8 +40,7 @@ void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "PCI devices not supported\n");
> +    monitor_hmp_printf(hmp, "PCI devices not supported\n");
>  }
>  
>  /* kvm-all wants this */
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index d8afaf730639..b5e56a16cce1 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -106,7 +106,6 @@ static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
>  
>  void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      S390SKeysState *ss = s390_get_skeys_device();
>      S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
>      uint64_t addr = qdict_get_int(qdict, "addr");
> @@ -115,24 +114,24 @@ void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict)
>  
>      /* Quick check to see if guest is using storage keys*/
>      if (!skeyclass->skeys_are_enabled(ss)) {
> -        monitor_printf(mon, "Error: This guest is not using storage keys\n");
> +        monitor_hmp_printf(hmp, "Error: This guest is not using storage keys\n");
>          return;
>      }
>  
>      if (!address_space_access_valid(&address_space_memory,
>                                      addr & TARGET_PAGE_MASK, TARGET_PAGE_SIZE,
>                                      false, MEMTXATTRS_UNSPECIFIED)) {
> -        monitor_printf(mon, "Error: The given address is not valid\n");
> +        monitor_hmp_printf(hmp, "Error: The given address is not valid\n");
>          return;
>      }
>  
>      r = skeyclass->get_skeys(ss, addr / TARGET_PAGE_SIZE, 1, &key);
>      if (r < 0) {
> -        monitor_printf(mon, "Error: %s\n", strerror(-r));
> +        monitor_hmp_printf(hmp, "Error: %s\n", strerror(-r));
>          return;
>      }
>  
> -    monitor_printf(mon, "  key: 0x%X\n", key);
> +    monitor_hmp_printf(hmp, "  key: 0x%X\n", key);
>  }
>  
>  void hmp_dump_skeys(MonitorHMP *hmp, const QDict *qdict)
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index b4a405455901..644298f7f0b2 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -61,7 +61,6 @@ void s390_stattrib_init(void)
>  
>  void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      S390StAttribState *sas = s390_get_stattrib_device();
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      uint64_t what = qdict_get_int(qdict, "mode");
> @@ -70,14 +69,13 @@ void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict)
>  
>      r = sac->set_migrationmode(sas, what, &local_err);
>      if (r < 0) {
> -        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
> +        monitor_hmp_printf(hmp, "Error: %s", error_get_pretty(local_err));
>          error_free(local_err);
>      }
>  }
>  
>  void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      S390StAttribState *sas = s390_get_stattrib_device();
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      uint64_t addr = qdict_get_int(qdict, "addr");
> @@ -87,27 +85,27 @@ void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict)
>  
>      vals = g_try_malloc(buflen);
>      if (!vals) {
> -        monitor_printf(mon, "Error: %s\n", strerror(errno));
> +        monitor_hmp_printf(hmp, "Error: %s\n", strerror(errno));
>          return;
>      }
>  
>      len = sac->peek_stattr(sas, addr / TARGET_PAGE_SIZE, buflen, vals);
>      if (len < 0) {
> -        monitor_printf(mon, "Error: %s", strerror(-len));
> +        monitor_hmp_printf(hmp, "Error: %s", strerror(-len));
>          goto out;
>      }
>  
> -    monitor_printf(mon, "  CMMA attributes, "
> -                   "pages %" PRIu64 "+%d (0x%" PRIx64 "):\n",
> -                   addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
> +    monitor_hmp_printf(hmp, "  CMMA attributes, "
> +                       "pages %" PRIu64 "+%d (0x%" PRIx64 "):\n",
> +                       addr / TARGET_PAGE_SIZE, len, addr & ~TARGET_PAGE_MASK);
>      for (cx = 0; cx < len; cx++) {
>          if (cx % 8 == 7) {
> -            monitor_printf(mon, "%02x\n", vals[cx]);
> +            monitor_hmp_printf(hmp, "%02x\n", vals[cx]);
>          } else {
> -            monitor_printf(mon, "%02x", vals[cx]);
> +            monitor_hmp_printf(hmp, "%02x", vals[cx]);
>          }
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>  
>  out:
>      g_free(vals);
> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> index 0d59a74ad60e..0249eea2cfe9 100644
> --- a/hw/uefi/ovmf-log.c
> +++ b/hw/uefi/ovmf-log.c
> @@ -258,7 +258,6 @@ FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
>  
>  void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      g_autofree gchar *log_esc = NULL;
>      g_autofree guchar *log_out = NULL;
>      Error *err = NULL;
> @@ -278,10 +277,10 @@ void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
>  
>      if (log->version) {
>          g_autofree gchar *esc = g_strescape(log->version, NULL);
> -        monitor_printf(mon, "[ firmware version: %s ]\n", esc);
> +        monitor_hmp_printf(hmp, "[ firmware version: %s ]\n", esc);
>      }
>  
>      log_out = g_base64_decode(log->log, &log_len);
>      log_esc = g_strescape((gchar *)log_out, "\r\n");
> -    monitor_printf(mon, "%s\n", log_esc);
> +    monitor_hmp_printf(hmp, "%s\n", log_esc);
>  }
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 9b9b2e7c2f8f..fe3dbfa2227c 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -546,14 +546,15 @@ static const char *usb_speed(unsigned int speed)
>  
>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
>  {
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
>      USBDevice *dev = USB_DEVICE(qdev);
>      USBBus *bus = usb_bus_from_device(dev);
>  
> -    monitor_printf(mon, "%*saddr %d.%d, port %s, speed %s, name %s%s\n",
> -                   indent, "", bus->busnr, dev->addr,
> -                   dev->port ? dev->port->path : "-",
> -                   usb_speed(dev->speed), dev->product_desc,
> -                   dev->attached ? ", attached" : "");
> +    monitor_hmp_printf(hmp, "%*saddr %d.%d, port %s, speed %s, name %s%s\n",
> +                       indent, "", bus->busnr, dev->addr,
> +                       dev->port ? dev->port->path : "-",
> +                       usb_speed(dev->speed), dev->product_desc,
> +                       dev->attached ? ", attached" : "");
>  }
>  
>  static char *usb_get_dev_path(DeviceState *qdev)
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index c02343d3a655..9b9f26a1078e 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -1922,7 +1922,6 @@ static void usb_host_auto_check(void *unused)
>  
>  void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      libusb_device **devs = NULL;
>      struct libusb_device_descriptor ddesc;
>      char port[16];
> @@ -1941,14 +1940,14 @@ void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
>              continue;
>          }
>          usb_host_get_port(devs[i], port, sizeof(port));
> -        monitor_printf(mon, "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
> -                       libusb_get_bus_number(devs[i]),
> -                       libusb_get_device_address(devs[i]),
> -                       port,
> -                       speed_name[libusb_get_device_speed(devs[i])]);
> -        monitor_printf(mon, "    Class %02x:", ddesc.bDeviceClass);
> -        monitor_printf(mon, " USB device %04x:%04x",
> -                       ddesc.idVendor, ddesc.idProduct);
> +        monitor_hmp_printf(hmp, "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
> +                           libusb_get_bus_number(devs[i]),
> +                           libusb_get_device_address(devs[i]),
> +                           port,
> +                           speed_name[libusb_get_device_speed(devs[i])]);
> +        monitor_hmp_printf(hmp, "    Class %02x:", ddesc.bDeviceClass);
> +        monitor_hmp_printf(hmp, " USB device %04x:%04x",
> +                           ddesc.idVendor, ddesc.idProduct);
>          if (ddesc.iProduct) {
>              libusb_device_handle *handle;
>              if (libusb_open(devs[i], &handle) == 0) {
> @@ -1957,10 +1956,10 @@ void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
>                                                     ddesc.iProduct,
>                                                     name, sizeof(name));
>                  libusb_close(handle);
> -                monitor_printf(mon, ", %s", name);
> +                monitor_hmp_printf(hmp, ", %s", name);
>              }
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>      libusb_free_device_list(devs, 1);
>  }
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index fb36c8b9274c..e5da6f00699d 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -12,77 +12,76 @@
>  #include "qobject/qdict.h"
>  
>  
> -static void hmp_virtio_dump_protocols(Monitor *mon,
> +static void hmp_virtio_dump_protocols(MonitorHMP *hmp,
>                                        VhostDeviceProtocols *pcol)
>  {
>      strList *pcol_list = pcol->protocols;
>      while (pcol_list) {
> -        monitor_printf(mon, "\t%s", pcol_list->value);
> +        monitor_hmp_printf(hmp, "\t%s", pcol_list->value);
>          pcol_list = pcol_list->next;
>          if (pcol_list != NULL) {
> -            monitor_printf(mon, ",\n");
> +            monitor_hmp_printf(hmp, ",\n");
>          }
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>      if (pcol->has_unknown_protocols) {
> -        monitor_printf(mon, "  unknown-protocols(0x%016"PRIx64")\n",
> -                       pcol->unknown_protocols);
> +        monitor_hmp_printf(hmp, "  unknown-protocols(0x%016"PRIx64")\n",
> +                           pcol->unknown_protocols);
>      }
>  }
>  
> -static void hmp_virtio_dump_status(Monitor *mon,
> +static void hmp_virtio_dump_status(MonitorHMP *hmp,
>                                     VirtioDeviceStatus *status)
>  {
>      strList *status_list = status->statuses;
>      while (status_list) {
> -        monitor_printf(mon, "\t%s", status_list->value);
> +        monitor_hmp_printf(hmp, "\t%s", status_list->value);
>          status_list = status_list->next;
>          if (status_list != NULL) {
> -            monitor_printf(mon, ",\n");
> +            monitor_hmp_printf(hmp, ",\n");
>          }
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>      if (status->has_unknown_statuses) {
> -        monitor_printf(mon, "  unknown-statuses(0x%016"PRIx32")\n",
> -                       status->unknown_statuses);
> +        monitor_hmp_printf(hmp, "  unknown-statuses(0x%016"PRIx32")\n",
> +                           status->unknown_statuses);
>      }
>  }
>  
> -static void hmp_virtio_dump_features(Monitor *mon,
> +static void hmp_virtio_dump_features(MonitorHMP *hmp,
>                                       VirtioDeviceFeatures *features)
>  {
>      strList *transport_list = features->transports;
>      while (transport_list) {
> -        monitor_printf(mon, "\t%s", transport_list->value);
> +        monitor_hmp_printf(hmp, "\t%s", transport_list->value);
>          transport_list = transport_list->next;
>          if (transport_list != NULL) {
> -            monitor_printf(mon, ",\n");
> +            monitor_hmp_printf(hmp, ",\n");
>          }
>      }
>  
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>      strList *list = features->dev_features;
>      if (list) {
>          while (list) {
> -            monitor_printf(mon, "\t%s", list->value);
> +            monitor_hmp_printf(hmp, "\t%s", list->value);
>              list = list->next;
>              if (list != NULL) {
> -                monitor_printf(mon, ",\n");
> +                monitor_hmp_printf(hmp, ",\n");
>              }
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>  
>      if (features->has_unknown_dev_features) {
> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
> -                       features->unknown_dev_features2,
> -                       features->unknown_dev_features);
> +        monitor_hmp_printf(hmp, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
> +                           features->unknown_dev_features2,
> +                           features->unknown_dev_features);
>      }
>  }
>  
>  void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      VirtioInfoList *list = qmp_x_query_virtio(&err);
>      VirtioInfoList *node;
> @@ -93,14 +92,14 @@ void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict)
>      }
>  
>      if (list == NULL) {
> -        monitor_printf(mon, "No VirtIO devices\n");
> +        monitor_hmp_printf(hmp, "No VirtIO devices\n");
>          return;
>      }
>  
>      node = list;
>      while (node) {
> -        monitor_printf(mon, "%s [%s]\n", node->value->path,
> -                       node->value->name);
> +        monitor_hmp_printf(hmp, "%s [%s]\n", node->value->path,
> +                           node->value->name);
>          node = node->next;
>      }
>      qapi_free_VirtioInfoList(list);
> @@ -108,7 +107,6 @@ void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *path = qdict_get_try_str(qdict, "path");
>      VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
> @@ -118,68 +116,68 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "%s:\n", path);
> -    monitor_printf(mon, "  device_name:             %s %s\n",
> -                   s->name, s->vhost_dev ? "(vhost)" : "");
> -    monitor_printf(mon, "  device_id:               %d\n", s->device_id);
> -    monitor_printf(mon, "  vhost_started:           %s\n",
> -                   s->vhost_started ? "true" : "false");
> -    monitor_printf(mon, "  bus_name:                %s\n", s->bus_name);
> -    monitor_printf(mon, "  broken:                  %s\n",
> -                   s->broken ? "true" : "false");
> -    monitor_printf(mon, "  disabled:                %s\n",
> -                   s->disabled ? "true" : "false");
> -    monitor_printf(mon, "  disable_legacy_check:    %s\n",
> -                   s->disable_legacy_check ? "true" : "false");
> -    monitor_printf(mon, "  started:                 %s\n",
> -                   s->started ? "true" : "false");
> -    monitor_printf(mon, "  use_started:             %s\n",
> -                   s->use_started ? "true" : "false");
> -    monitor_printf(mon, "  start_on_kick:           %s\n",
> -                   s->start_on_kick ? "true" : "false");
> -    monitor_printf(mon, "  use_guest_notifier_mask: %s\n",
> -                   s->use_guest_notifier_mask ? "true" : "false");
> -    monitor_printf(mon, "  vm_running:              %s\n",
> -                   s->vm_running ? "true" : "false");
> -    monitor_printf(mon, "  num_vqs:                 %"PRId64"\n", s->num_vqs);
> -    monitor_printf(mon, "  queue_sel:               %d\n",
> -                   s->queue_sel);
> -    monitor_printf(mon, "  isr:                     %d\n", s->isr);
> -    monitor_printf(mon, "  endianness:              %s\n",
> -                   s->device_endian);
> -    monitor_printf(mon, "  status:\n");
> -    hmp_virtio_dump_status(mon, s->status);
> -    monitor_printf(mon, "  Guest features:\n");
> -    hmp_virtio_dump_features(mon, s->guest_features);
> -    monitor_printf(mon, "  Host features:\n");
> -    hmp_virtio_dump_features(mon, s->host_features);
> -    monitor_printf(mon, "  Backend features:\n");
> -    hmp_virtio_dump_features(mon, s->backend_features);
> +    monitor_hmp_printf(hmp, "%s:\n", path);
> +    monitor_hmp_printf(hmp, "  device_name:             %s %s\n",
> +                       s->name, s->vhost_dev ? "(vhost)" : "");
> +    monitor_hmp_printf(hmp, "  device_id:               %d\n", s->device_id);
> +    monitor_hmp_printf(hmp, "  vhost_started:           %s\n",
> +                       s->vhost_started ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  bus_name:                %s\n", s->bus_name);
> +    monitor_hmp_printf(hmp, "  broken:                  %s\n",
> +                       s->broken ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  disabled:                %s\n",
> +                       s->disabled ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  disable_legacy_check:    %s\n",
> +                       s->disable_legacy_check ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  started:                 %s\n",
> +                       s->started ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  use_started:             %s\n",
> +                       s->use_started ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  start_on_kick:           %s\n",
> +                       s->start_on_kick ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  use_guest_notifier_mask: %s\n",
> +                       s->use_guest_notifier_mask ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  vm_running:              %s\n",
> +                       s->vm_running ? "true" : "false");
> +    monitor_hmp_printf(hmp, "  num_vqs:                 %"PRId64"\n", s->num_vqs);
> +    monitor_hmp_printf(hmp, "  queue_sel:               %d\n",
> +                       s->queue_sel);
> +    monitor_hmp_printf(hmp, "  isr:                     %d\n", s->isr);
> +    monitor_hmp_printf(hmp, "  endianness:              %s\n",
> +                       s->device_endian);
> +    monitor_hmp_printf(hmp, "  status:\n");
> +    hmp_virtio_dump_status(hmp, s->status);
> +    monitor_hmp_printf(hmp, "  Guest features:\n");
> +    hmp_virtio_dump_features(hmp, s->guest_features);
> +    monitor_hmp_printf(hmp, "  Host features:\n");
> +    hmp_virtio_dump_features(hmp, s->host_features);
> +    monitor_hmp_printf(hmp, "  Backend features:\n");
> +    hmp_virtio_dump_features(hmp, s->backend_features);
>  
>      if (s->vhost_dev) {
> -        monitor_printf(mon, "  VHost:\n");
> -        monitor_printf(mon, "    nvqs:           %d\n",
> -                       s->vhost_dev->nvqs);
> -        monitor_printf(mon, "    vq_index:       %"PRId64"\n",
> -                       s->vhost_dev->vq_index);
> -        monitor_printf(mon, "    max_queues:     %"PRId64"\n",
> -                       s->vhost_dev->max_queues);
> -        monitor_printf(mon, "    n_mem_sections: %"PRId64"\n",
> -                       s->vhost_dev->n_mem_sections);
> -        monitor_printf(mon, "    n_tmp_sections: %"PRId64"\n",
> -                       s->vhost_dev->n_tmp_sections);
> -        monitor_printf(mon, "    backend_cap:    %"PRId64"\n",
> -                       s->vhost_dev->backend_cap);
> -        monitor_printf(mon, "    log_enabled:    %s\n",
> -                       s->vhost_dev->log_enabled ? "true" : "false");
> -        monitor_printf(mon, "    log_size:       %"PRId64"\n",
> -                       s->vhost_dev->log_size);
> -        monitor_printf(mon, "    Features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->features);
> -        monitor_printf(mon, "    Acked features:\n");
> -        hmp_virtio_dump_features(mon, s->vhost_dev->acked_features);
> -        monitor_printf(mon, "    Protocol features:\n");
> -        hmp_virtio_dump_protocols(mon, s->vhost_dev->protocol_features);
> +        monitor_hmp_printf(hmp, "  VHost:\n");
> +        monitor_hmp_printf(hmp, "    nvqs:           %d\n",
> +                           s->vhost_dev->nvqs);
> +        monitor_hmp_printf(hmp, "    vq_index:       %"PRId64"\n",
> +                           s->vhost_dev->vq_index);
> +        monitor_hmp_printf(hmp, "    max_queues:     %"PRId64"\n",
> +                           s->vhost_dev->max_queues);
> +        monitor_hmp_printf(hmp, "    n_mem_sections: %"PRId64"\n",
> +                           s->vhost_dev->n_mem_sections);
> +        monitor_hmp_printf(hmp, "    n_tmp_sections: %"PRId64"\n",
> +                           s->vhost_dev->n_tmp_sections);
> +        monitor_hmp_printf(hmp, "    backend_cap:    %"PRId64"\n",
> +                           s->vhost_dev->backend_cap);
> +        monitor_hmp_printf(hmp, "    log_enabled:    %s\n",
> +                           s->vhost_dev->log_enabled ? "true" : "false");
> +        monitor_hmp_printf(hmp, "    log_size:       %"PRId64"\n",
> +                           s->vhost_dev->log_size);
> +        monitor_hmp_printf(hmp, "    Features:\n");
> +        hmp_virtio_dump_features(hmp, s->vhost_dev->features);
> +        monitor_hmp_printf(hmp, "    Acked features:\n");
> +        hmp_virtio_dump_features(hmp, s->vhost_dev->acked_features);
> +        monitor_hmp_printf(hmp, "    Protocol features:\n");
> +        hmp_virtio_dump_protocols(hmp, s->vhost_dev->protocol_features);
>      }
>  
>      qapi_free_VirtioStatus(s);
> @@ -187,7 +185,6 @@ void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_vhost_queue_status(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *path = qdict_get_try_str(qdict, "path");
>      int queue = qdict_get_int(qdict, "queue");
> @@ -199,29 +196,28 @@ void hmp_vhost_queue_status(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "%s:\n", path);
> -    monitor_printf(mon, "  device_name:          %s (vhost)\n",
> -                   s->name);
> -    monitor_printf(mon, "  kick:                 %"PRId64"\n", s->kick);
> -    monitor_printf(mon, "  call:                 %"PRId64"\n", s->call);
> -    monitor_printf(mon, "  VRing:\n");
> -    monitor_printf(mon, "    num:         %"PRId64"\n", s->num);
> -    monitor_printf(mon, "    desc_phys:   0x%016"PRIx64"\n",
> -                   s->desc_phys);
> -    monitor_printf(mon, "    desc_size:   %"PRId32"\n", s->desc_size);
> -    monitor_printf(mon, "    avail_phys:  0x%016"PRIx64"\n",
> -                   s->avail_phys);
> -    monitor_printf(mon, "    avail_size:  %"PRId32"\n", s->avail_size);
> -    monitor_printf(mon, "    used_phys:   0x%016"PRIx64"\n",
> -                   s->used_phys);
> -    monitor_printf(mon, "    used_size:   %"PRId32"\n", s->used_size);
> +    monitor_hmp_printf(hmp, "%s:\n", path);
> +    monitor_hmp_printf(hmp, "  device_name:          %s (vhost)\n",
> +                       s->name);
> +    monitor_hmp_printf(hmp, "  kick:                 %"PRId64"\n", s->kick);
> +    monitor_hmp_printf(hmp, "  call:                 %"PRId64"\n", s->call);
> +    monitor_hmp_printf(hmp, "  VRing:\n");
> +    monitor_hmp_printf(hmp, "    num:         %"PRId64"\n", s->num);
> +    monitor_hmp_printf(hmp, "    desc_phys:   0x%016"PRIx64"\n",
> +                       s->desc_phys);
> +    monitor_hmp_printf(hmp, "    desc_size:   %"PRId32"\n", s->desc_size);
> +    monitor_hmp_printf(hmp, "    avail_phys:  0x%016"PRIx64"\n",
> +                       s->avail_phys);
> +    monitor_hmp_printf(hmp, "    avail_size:  %"PRId32"\n", s->avail_size);
> +    monitor_hmp_printf(hmp, "    used_phys:   0x%016"PRIx64"\n",
> +                       s->used_phys);
> +    monitor_hmp_printf(hmp, "    used_size:   %"PRId32"\n", s->used_size);
>  
>      qapi_free_VirtVhostQueueStatus(s);
>  }
>  
>  void hmp_virtio_queue_status(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *path = qdict_get_try_str(qdict, "path");
>      int queue = qdict_get_int(qdict, "queue");
> @@ -232,42 +228,41 @@ void hmp_virtio_queue_status(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "%s:\n", path);
> -    monitor_printf(mon, "  device_name:          %s\n", s->name);
> -    monitor_printf(mon, "  queue_index:          %d\n", s->queue_index);
> -    monitor_printf(mon, "  inuse:                %d\n", s->inuse);
> -    monitor_printf(mon, "  used_idx:             %d\n", s->used_idx);
> -    monitor_printf(mon, "  signalled_used:       %d\n",
> -                   s->signalled_used);
> -    monitor_printf(mon, "  signalled_used_valid: %s\n",
> -                   s->signalled_used_valid ? "true" : "false");
> +    monitor_hmp_printf(hmp, "%s:\n", path);
> +    monitor_hmp_printf(hmp, "  device_name:          %s\n", s->name);
> +    monitor_hmp_printf(hmp, "  queue_index:          %d\n", s->queue_index);
> +    monitor_hmp_printf(hmp, "  inuse:                %d\n", s->inuse);
> +    monitor_hmp_printf(hmp, "  used_idx:             %d\n", s->used_idx);
> +    monitor_hmp_printf(hmp, "  signalled_used:       %d\n",
> +                       s->signalled_used);
> +    monitor_hmp_printf(hmp, "  signalled_used_valid: %s\n",
> +                       s->signalled_used_valid ? "true" : "false");
>      if (s->has_last_avail_idx) {
> -        monitor_printf(mon, "  last_avail_idx:       %d\n",
> -                       s->last_avail_idx);
> +        monitor_hmp_printf(hmp, "  last_avail_idx:       %d\n",
> +                           s->last_avail_idx);
>      }
>      if (s->has_shadow_avail_idx) {
> -        monitor_printf(mon, "  shadow_avail_idx:     %d\n",
> -                       s->shadow_avail_idx);
> +        monitor_hmp_printf(hmp, "  shadow_avail_idx:     %d\n",
> +                           s->shadow_avail_idx);
>      }
> -    monitor_printf(mon, "  VRing:\n");
> -    monitor_printf(mon, "    num:          %"PRId32"\n", s->vring_num);
> -    monitor_printf(mon, "    num_default:  %"PRId32"\n",
> -                   s->vring_num_default);
> -    monitor_printf(mon, "    align:        %"PRId32"\n",
> -                   s->vring_align);
> -    monitor_printf(mon, "    desc:         0x%016"PRIx64"\n",
> -                   s->vring_desc);
> -    monitor_printf(mon, "    avail:        0x%016"PRIx64"\n",
> -                   s->vring_avail);
> -    monitor_printf(mon, "    used:         0x%016"PRIx64"\n",
> -                   s->vring_used);
> +    monitor_hmp_printf(hmp, "  VRing:\n");
> +    monitor_hmp_printf(hmp, "    num:          %"PRId32"\n", s->vring_num);
> +    monitor_hmp_printf(hmp, "    num_default:  %"PRId32"\n",
> +                       s->vring_num_default);
> +    monitor_hmp_printf(hmp, "    align:        %"PRId32"\n",
> +                       s->vring_align);
> +    monitor_hmp_printf(hmp, "    desc:         0x%016"PRIx64"\n",
> +                       s->vring_desc);
> +    monitor_hmp_printf(hmp, "    avail:        0x%016"PRIx64"\n",
> +                       s->vring_avail);
> +    monitor_hmp_printf(hmp, "    used:         0x%016"PRIx64"\n",
> +                       s->vring_used);
>  
>      qapi_free_VirtQueueStatus(s);
>  }
>  
>  void hmp_virtio_queue_element(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *path = qdict_get_try_str(qdict, "path");
>      int queue = qdict_get_int(qdict, "queue");
> @@ -282,41 +277,41 @@ void hmp_virtio_queue_element(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "%s:\n", path);
> -    monitor_printf(mon, "  device_name: %s\n", e->name);
> -    monitor_printf(mon, "  index:   %d\n", e->index);
> -    monitor_printf(mon, "  desc:\n");
> -    monitor_printf(mon, "    descs:\n");
> +    monitor_hmp_printf(hmp, "%s:\n", path);
> +    monitor_hmp_printf(hmp, "  device_name: %s\n", e->name);
> +    monitor_hmp_printf(hmp, "  index:   %d\n", e->index);
> +    monitor_hmp_printf(hmp, "  desc:\n");
> +    monitor_hmp_printf(hmp, "    descs:\n");
>  
>      list = e->descs;
>      while (list) {
> -        monitor_printf(mon, "        addr 0x%"PRIx64" len %d",
> -                       list->value->addr, list->value->len);
> +        monitor_hmp_printf(hmp, "        addr 0x%"PRIx64" len %d",
> +                           list->value->addr, list->value->len);
>          if (list->value->flags) {
>              strList *flag = list->value->flags;
> -            monitor_printf(mon, " (");
> +            monitor_hmp_printf(hmp, " (");
>              while (flag) {
> -                monitor_printf(mon, "%s", flag->value);
> +                monitor_hmp_printf(hmp, "%s", flag->value);
>                  flag = flag->next;
>                  if (flag) {
> -                    monitor_printf(mon, ", ");
> +                    monitor_hmp_printf(hmp, ", ");
>                  }
>              }
> -            monitor_printf(mon, ")");
> +            monitor_hmp_printf(hmp, ")");
>          }
>          list = list->next;
>          if (list) {
> -            monitor_printf(mon, ",\n");
> +            monitor_hmp_printf(hmp, ",\n");
>          }
>      }
> -    monitor_printf(mon, "\n");
> -    monitor_printf(mon, "  avail:\n");
> -    monitor_printf(mon, "    flags: %d\n", e->avail->flags);
> -    monitor_printf(mon, "    idx:   %d\n", e->avail->idx);
> -    monitor_printf(mon, "    ring:  %d\n", e->avail->ring);
> -    monitor_printf(mon, "  used:\n");
> -    monitor_printf(mon, "    flags: %d\n", e->used->flags);
> -    monitor_printf(mon, "    idx:   %d\n", e->used->idx);
> +    monitor_hmp_printf(hmp, "\n");
> +    monitor_hmp_printf(hmp, "  avail:\n");
> +    monitor_hmp_printf(hmp, "    flags: %d\n", e->avail->flags);
> +    monitor_hmp_printf(hmp, "    idx:   %d\n", e->avail->idx);
> +    monitor_hmp_printf(hmp, "    ring:  %d\n", e->avail->ring);
> +    monitor_hmp_printf(hmp, "  used:\n");
> +    monitor_hmp_printf(hmp, "    flags: %d\n", e->used->flags);
> +    monitor_hmp_printf(hmp, "    idx:   %d\n", e->used->idx);
>  
>      qapi_free_VirtioQueueElement(e);
>  }
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index a563f6066bb4..4075b5b001ae 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -103,10 +103,11 @@ abort:
>  
>  static void xen_bus_print_dev(Monitor *mon, DeviceState *dev, int indent)
>  {
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
>      XenDevice *xendev = XEN_DEVICE(dev);
>  
> -    monitor_printf(mon, "%*sname = '%s' frontend_id = %u\n",
> -                   indent, "", xendev->name, xendev->frontend_id);
> +    monitor_hmp_printf(hmp, "%*sname = '%s' frontend_id = %u\n",
> +                       indent, "", xendev->name, xendev->frontend_id);
>  }
>  
>  static char *xen_bus_get_dev_path(DeviceState *dev)
> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index c702b1effc1c..47daa9b4d2df 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -1,13 +1,15 @@
>  #ifndef QEMU_DISAS_H
>  #define QEMU_DISAS_H
>  
> +#include "monitor/hmp.h"
> +
>  /* Disassemble this for me please... (debugging). */
>  #ifdef CONFIG_TCG
>  void disas(FILE *out, const void *code, size_t size);
>  void target_disas(FILE *out, CPUState *cpu, const DisasContextBase *db);
>  #endif
>  
> -void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
> +void monitor_disas(MonitorHMP *hmp, CPUState *cpu, uint64_t pc,
>                     int nb_insn, bool is_physical);
>  
>  #ifdef CONFIG_PLUGIN
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 3fd17048b319..f10bf83df86d 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -38,10 +38,10 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
>  
>  MonitorHMP *monitor_cur_hmp(void);
>  
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>      G_GNUC_PRINTF(2, 0);
> -int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> -void monitor_printc(Monitor *mon, int ch);
> +int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
> +void monitor_hmp_printc(MonitorHMP *mon, int ch);
>  
>  void monitor_hmp_read_command(MonitorHMP *hmp, int show_prompt);
>  int monitor_hmp_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
> @@ -58,7 +58,7 @@ CPUState *monitor_hmp_get_cpu(MonitorHMP *hmp);
>  int monitor_hmp_get_cpu_index(MonitorHMP *hmp);
>  
>  bool hmp_handle_error(MonitorHMP *hmp, Error *err);
> -void hmp_help_cmd(Monitor *mon, const char *name);
> +void hmp_help_cmd(MonitorHMP *hmp, const char *name);
>  strList *hmp_split_at_comma(const char *str);
>  
>  void hmp_info_name(MonitorHMP *hmp, const QDict *qdict);
> @@ -114,11 +114,11 @@ void hmp_set_password(MonitorHMP *hmp, const QDict *qdict);
>  void hmp_expire_password(MonitorHMP *hmp, const QDict *qdict);
>  void hmp_change(MonitorHMP *hmp, const QDict *qdict);
>  #ifdef CONFIG_VNC
> -void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
> +void hmp_change_vnc(MonitorHMP *hmp, const char *device, const char *target,
>                      const char *arg, const char *read_only, bool force,
>                      Error **errp);
>  #endif
> -void hmp_change_medium(Monitor *mon, const char *device, const char *target,
> +void hmp_change_medium(MonitorHMP *hmp, const char *device, const char *target,
>                         const char *arg, const char *read_only, bool force,
>                         Error **errp);
>  void hmp_migrate(MonitorHMP *hmp, const QDict *qdict);
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 3c0931796ce2..bdbb2aaa99db 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -858,34 +858,33 @@ struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
>  
>  void hmp_info_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      DirtyRateInfo *info = query_dirty_rate_info(TIME_UNIT_SECOND);
>  
> -    monitor_printf(mon, "Status: %s\n",
> -                   DirtyRateStatus_str(info->status));
> -    monitor_printf(mon, "Start Time: %"PRIi64" (ms)\n",
> -                   info->start_time);
> +    monitor_hmp_printf(hmp, "Status: %s\n",
> +                       DirtyRateStatus_str(info->status));
> +    monitor_hmp_printf(hmp, "Start Time: %"PRIi64" (ms)\n",
> +                       info->start_time);
>      if (info->mode == DIRTY_RATE_MEASURE_MODE_PAGE_SAMPLING) {
> -        monitor_printf(mon, "Sample Pages: %"PRIu64" (per GB)\n",
> -                       info->sample_pages);
> +        monitor_hmp_printf(hmp, "Sample Pages: %"PRIu64" (per GB)\n",
> +                           info->sample_pages);
>      }
> -    monitor_printf(mon, "Period: %"PRIi64" (sec)\n",
> -                   info->calc_time);
> -    monitor_printf(mon, "Mode: %s\n",
> -                   DirtyRateMeasureMode_str(info->mode));
> -    monitor_printf(mon, "Dirty rate: ");
> +    monitor_hmp_printf(hmp, "Period: %"PRIi64" (sec)\n",
> +                       info->calc_time);
> +    monitor_hmp_printf(hmp, "Mode: %s\n",
> +                       DirtyRateMeasureMode_str(info->mode));
> +    monitor_hmp_printf(hmp, "Dirty rate: ");
>      if (info->has_dirty_rate) {
> -        monitor_printf(mon, "%"PRIi64" (MB/s)\n", info->dirty_rate);
> +        monitor_hmp_printf(hmp, "%"PRIi64" (MB/s)\n", info->dirty_rate);
>          if (info->has_vcpu_dirty_rate) {
>              DirtyRateVcpuList *rate, *head = info->vcpu_dirty_rate;
>              for (rate = head; rate != NULL; rate = rate->next) {
> -                monitor_printf(mon, "vcpu[%"PRIi64"], Dirty rate: %"PRIi64
> -                               " (MB/s)\n", rate->value->id,
> -                               rate->value->dirty_rate);
> +                monitor_hmp_printf(hmp, "vcpu[%"PRIi64"], Dirty rate: %"PRIi64
> +                                   " (MB/s)\n", rate->value->id,
> +                                   rate->value->dirty_rate);
>              }
>          }
>      } else {
> -        monitor_printf(mon, "(not ready)\n");
> +        monitor_hmp_printf(hmp, "(not ready)\n");
>      }
>  
>      qapi_free_DirtyRateVcpuList(info->vcpu_dirty_rate);
> @@ -894,7 +893,6 @@ void hmp_info_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int64_t sec = qdict_get_try_int(qdict, "second", 0);
>      int64_t sample_pages = qdict_get_try_int(qdict, "sample_pages_per_GB", -1);
>      bool has_sample_pages = (sample_pages != -1);
> @@ -904,13 +902,13 @@ void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
>      Error *err = NULL;
>  
>      if (!sec) {
> -        monitor_printf(mon, "Incorrect period length specified!\n");
> +        monitor_hmp_printf(hmp, "Incorrect period length specified!\n");
>          return;
>      }
>  
>      if (dirty_ring && dirty_bitmap) {
> -        monitor_printf(mon, "Either dirty ring or dirty bitmap "
> -                       "can be specified!\n");
> +        monitor_hmp_printf(hmp, "Either dirty ring or dirty bitmap "
> +                           "can be specified!\n");
>          return;
>      }
>  
> @@ -930,7 +928,7 @@ void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "Starting dirty rate measurement with period %"PRIi64
> -                   " seconds\n", sec);
> -    monitor_printf(mon, "[Please use 'info dirty_rate' to check results]\n");
> +    monitor_hmp_printf(hmp, "Starting dirty rate measurement with period %"PRIi64
> +                       " seconds\n", sec);
> +    monitor_hmp_printf(hmp, "[Please use 'info dirty_rate' to check results]\n");
>  }
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 73a974259478..6fe189471899 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -36,23 +36,23 @@
>  #include "options.h"
>  #include "migration.h"
>  
> -static void migration_global_dump(Monitor *mon)
> +static void migration_global_dump(MonitorHMP *hmp)
>  {
>      MigrationState *ms = migrate_get_current();
>  
> -    monitor_printf(mon, "Globals:\n");
> -    monitor_printf(mon, "  store-global-state: %s\n",
> -                   ms->store_global_state ? "on" : "off");
> -    monitor_printf(mon, "  only-migratable: %s\n",
> -                   only_migratable ? "on" : "off");
> -    monitor_printf(mon, "  send-configuration: %s\n",
> -                   ms->send_configuration ? "on" : "off");
> -    monitor_printf(mon, "  send-section-footer: %s\n",
> -                   ms->send_section_footer ? "on" : "off");
> -    monitor_printf(mon, "  send-switchover-start: %s\n",
> -                   ms->send_switchover_start ? "on" : "off");
> -    monitor_printf(mon, "  clear-bitmap-shift: %u\n",
> -                   ms->clear_bitmap_shift);
> +    monitor_hmp_printf(hmp, "Globals:\n");
> +    monitor_hmp_printf(hmp, "  store-global-state: %s\n",
> +                       ms->store_global_state ? "on" : "off");
> +    monitor_hmp_printf(hmp, "  only-migratable: %s\n",
> +                       only_migratable ? "on" : "off");
> +    monitor_hmp_printf(hmp, "  send-configuration: %s\n",
> +                       ms->send_configuration ? "on" : "off");
> +    monitor_hmp_printf(hmp, "  send-section-footer: %s\n",
> +                       ms->send_section_footer ? "on" : "off");
> +    monitor_hmp_printf(hmp, "  send-switchover-start: %s\n",
> +                       ms->send_switchover_start ? "on" : "off");
> +    monitor_hmp_printf(hmp, "  clear-bitmap-shift: %u\n",
> +                       ms->clear_bitmap_shift);
>  }
>  
>  static const gchar *format_time_str(uint64_t us)
> @@ -68,11 +68,11 @@ static const gchar *format_time_str(uint64_t us)
>      return g_strdup_printf("%"PRIu64" %s", us, units[index]);
>  }
>  
> -static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
> +static void migration_dump_blocktime(MonitorHMP *hmp, MigrationInfo *info)
>  {
>      if (info->has_postcopy_blocktime) {
> -        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> -                       info->postcopy_blocktime);
> +        monitor_hmp_printf(hmp, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> +                           info->postcopy_blocktime);
>      }
>  
>      if (info->has_postcopy_vcpu_blocktime) {
> @@ -80,25 +80,25 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>          const char *sep = "";
>          int count = 0;
>  
> -        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
> +        monitor_hmp_printf(hmp, "Postcopy vCPU Blocktime (ms):\n [");
>  
>          while (item) {
> -            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
> +            monitor_hmp_printf(hmp, "%s%"PRIu32, sep, item->value);
>              item = item->next;
>              /* Each line 10 vcpu results, newline if there's more */
>              sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
>          }
> -        monitor_printf(mon, "]\n");
> +        monitor_hmp_printf(hmp, "]\n");
>      }
>  
>      if (info->has_postcopy_latency) {
> -        monitor_printf(mon, "Postcopy Latency (ns): %" PRIu64 "\n",
> -                       info->postcopy_latency);
> +        monitor_hmp_printf(hmp, "Postcopy Latency (ns): %" PRIu64 "\n",
> +                           info->postcopy_latency);
>      }
>  
>      if (info->has_postcopy_non_vcpu_latency) {
> -        monitor_printf(mon, "Postcopy non-vCPU Latency (ns): %" PRIu64 "\n",
> -                       info->postcopy_non_vcpu_latency);
> +        monitor_hmp_printf(hmp, "Postcopy non-vCPU Latency (ns): %" PRIu64 "\n",
> +                           info->postcopy_non_vcpu_latency);
>      }
>  
>      if (info->has_postcopy_vcpu_latency) {
> @@ -106,29 +106,29 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>          const char *sep = "";
>          int count = 0;
>  
> -        monitor_printf(mon, "Postcopy vCPU Latencies (ns):\n [");
> +        monitor_hmp_printf(hmp, "Postcopy vCPU Latencies (ns):\n [");
>  
>          while (item) {
> -            monitor_printf(mon, "%s%"PRIu64, sep, item->value);
> +            monitor_hmp_printf(hmp, "%s%"PRIu64, sep, item->value);
>              item = item->next;
>              /* Each line 10 vcpu results, newline if there's more */
>              sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
>          }
> -        monitor_printf(mon, "]\n");
> +        monitor_hmp_printf(hmp, "]\n");
>      }
>  
>      if (info->has_postcopy_latency_dist) {
>          uint64List *item = info->postcopy_latency_dist;
>          int count = 0;
>  
> -        monitor_printf(mon, "Postcopy Latency Distribution:\n");
> +        monitor_hmp_printf(hmp, "Postcopy Latency Distribution:\n");
>  
>          while (item) {
>              g_autofree const gchar *from = format_time_str(1UL << count);
>              g_autofree const gchar *to = format_time_str(1UL << (count + 1));
>  
> -            monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
> -                           from, to, item->value);
> +            monitor_hmp_printf(hmp, "  [ %8s - %8s ]: %10"PRIu64"\n",
> +                               from, to, item->value);
>              item = item->next;
>              count++;
>          }
> @@ -137,7 +137,6 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>  
>  void hmp_info_migrate(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      bool show_all = qdict_get_try_bool(qdict, "all", false);
>      MigrationInfo *info;
>  
> @@ -145,59 +144,59 @@ void hmp_info_migrate(MonitorHMP *hmp, const QDict *qdict)
>  
>      if (info->blocked_reasons) {
>          strList *reasons = info->blocked_reasons;
> -        monitor_printf(mon, "Outgoing migration blocked:\n");
> +        monitor_hmp_printf(hmp, "Outgoing migration blocked:\n");
>          while (reasons) {
> -            monitor_printf(mon, "  %s\n", reasons->value);
> +            monitor_hmp_printf(hmp, "  %s\n", reasons->value);
>              reasons = reasons->next;
>          }
>      }
>  
>      if (info->has_status) {
> -        monitor_printf(mon, "Status: \t\t%s",
> -                       MigrationStatus_str(info->status));
> +        monitor_hmp_printf(hmp, "Status: \t\t%s",
> +                           MigrationStatus_str(info->status));
>          if ((info->status == MIGRATION_STATUS_FAILED ||
>               info->status == MIGRATION_STATUS_POSTCOPY_PAUSED) &&
>              info->error_desc) {
> -            monitor_printf(mon, " (%s)\n", info->error_desc);
> +            monitor_hmp_printf(hmp, " (%s)\n", info->error_desc);
>          } else {
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>  
>          if (info->total_time) {
> -            monitor_printf(mon, "Time (ms): \t\ttotal=%" PRIu64,
> -                           info->total_time);
> +            monitor_hmp_printf(hmp, "Time (ms): \t\ttotal=%" PRIu64,
> +                               info->total_time);
>              if (info->has_setup_time) {
> -                monitor_printf(mon, ", setup=%" PRIu64,
> -                               info->setup_time);
> +                monitor_hmp_printf(hmp, ", setup=%" PRIu64,
> +                                   info->setup_time);
>              }
>              if (info->has_expected_downtime) {
> -                monitor_printf(mon, ", exp_down=%" PRIu64,
> -                               info->expected_downtime);
> +                monitor_hmp_printf(hmp, ", exp_down=%" PRIu64,
> +                                   info->expected_downtime);
>              }
>              if (info->has_downtime) {
> -                monitor_printf(mon, ", down=%" PRIu64,
> -                               info->downtime);
> +                monitor_hmp_printf(hmp, ", down=%" PRIu64,
> +                                   info->downtime);
>              }
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>      }
>  
>      if (info->has_remaining) {
>          g_autofree char *remaining = size_to_str(info->remaining);
> -        monitor_printf(mon, "Remaining: \t\t%s\n", remaining);
> +        monitor_hmp_printf(hmp, "Remaining: \t\t%s\n", remaining);
>      }
>  
>      if (info->has_socket_address) {
>          SocketAddressList *addr;
>  
> -        monitor_printf(mon, "Sockets: [\n");
> +        monitor_hmp_printf(hmp, "Sockets: [\n");
>  
>          for (addr = info->socket_address; addr; addr = addr->next) {
>              char *s = socket_uri(addr->value);
> -            monitor_printf(mon, "\t%s\n", s);
> +            monitor_hmp_printf(hmp, "\t%s\n", s);
>              g_free(s);
>          }
> -        monitor_printf(mon, "]\n");
> +        monitor_hmp_printf(hmp, "]\n");
>      }
>  
>      if (info->ram) {
> @@ -209,219 +208,217 @@ void hmp_info_migrate(MonitorHMP *hmp, const QDict *qdict)
>          g_autofree char *str_multifd = size_to_str(info->ram->multifd_bytes);
>          g_autofree char *str_postcopy = size_to_str(info->ram->postcopy_bytes);
>  
> -        monitor_printf(mon, "RAM info:\n");
> -        monitor_printf(mon, "  Throughput (Mbps): \t%0.2f\n",
> -                       info->ram->mbps);
> -        monitor_printf(mon, "  Sizes: \t\tpagesize=%s, total=%s\n",
> -                       str_psize, str_total);
> -        monitor_printf(mon, "  Transfers: \t\ttransferred=%s, remain=%s\n",
> -                       str_transferred, str_remaining);
> -        monitor_printf(mon, "    Channels: \t\tprecopy=%s, "
> -                       "multifd=%s, postcopy=%s",
> -                       str_precopy, str_multifd, str_postcopy);
> +        monitor_hmp_printf(hmp, "RAM info:\n");
> +        monitor_hmp_printf(hmp, "  Throughput (Mbps): \t%0.2f\n",
> +                           info->ram->mbps);
> +        monitor_hmp_printf(hmp, "  Sizes: \t\tpagesize=%s, total=%s\n",
> +                           str_psize, str_total);
> +        monitor_hmp_printf(hmp, "  Transfers: \t\ttransferred=%s, remain=%s\n",
> +                           str_transferred, str_remaining);
> +        monitor_hmp_printf(hmp, "    Channels: \t\tprecopy=%s, "
> +                           "multifd=%s, postcopy=%s",
> +                           str_precopy, str_multifd, str_postcopy);
>  
>          if (info->vfio) {
>              g_autofree char *str_vfio = size_to_str(info->vfio->transferred);
>  
> -            monitor_printf(mon, ", vfio=%s", str_vfio);
> +            monitor_hmp_printf(hmp, ", vfio=%s", str_vfio);
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>  
> -        monitor_printf(mon, "    Page Types: \tnormal=%" PRIu64
> -                       ", zero=%" PRIu64 "\n",
> -                       info->ram->normal, info->ram->duplicate);
> -        monitor_printf(mon, "  Page Rates (pps): \ttransfer=%" PRIu64,
> -                       info->ram->pages_per_second);
> +        monitor_hmp_printf(hmp, "    Page Types: \tnormal=%" PRIu64
> +                           ", zero=%" PRIu64 "\n",
> +                           info->ram->normal, info->ram->duplicate);
> +        monitor_hmp_printf(hmp, "  Page Rates (pps): \ttransfer=%" PRIu64,
> +                           info->ram->pages_per_second);
>          if (info->ram->dirty_pages_rate) {
> -            monitor_printf(mon, ", dirty=%" PRIu64,
> -                           info->ram->dirty_pages_rate);
> +            monitor_hmp_printf(hmp, ", dirty=%" PRIu64,
> +                               info->ram->dirty_pages_rate);
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>  
> -        monitor_printf(mon, "  Others: \t\tdirty_syncs=%" PRIu64,
> -                       info->ram->dirty_sync_count);
> +        monitor_hmp_printf(hmp, "  Others: \t\tdirty_syncs=%" PRIu64,
> +                           info->ram->dirty_sync_count);
>          if (info->ram->postcopy_requests) {
> -            monitor_printf(mon, ", postcopy_req=%" PRIu64,
> -                           info->ram->postcopy_requests);
> +            monitor_hmp_printf(hmp, ", postcopy_req=%" PRIu64,
> +                               info->ram->postcopy_requests);
>          }
>          if (info->ram->downtime_bytes) {
> -            monitor_printf(mon, ", downtime_bytes=%" PRIu64,
> -                           info->ram->downtime_bytes);
> +            monitor_hmp_printf(hmp, ", downtime_bytes=%" PRIu64,
> +                               info->ram->downtime_bytes);
>          }
>          if (info->ram->dirty_sync_missed_zero_copy) {
> -            monitor_printf(mon, ", zerocopy_fallbacks=%" PRIu64,
> -                           info->ram->dirty_sync_missed_zero_copy);
> +            monitor_hmp_printf(hmp, ", zerocopy_fallbacks=%" PRIu64,
> +                               info->ram->dirty_sync_missed_zero_copy);
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>      }
>  
>      if (!show_all) {
>          goto out;
>      }
>  
> -    migration_global_dump(mon);
> +    migration_global_dump(hmp);
>  
>      if (info->xbzrle_cache) {
> -        monitor_printf(mon, "XBZRLE: size=%" PRIu64
> -                       ", transferred=%" PRIu64
> -                       ", pages=%" PRIu64
> -                       ", miss=%" PRIu64 "\n"
> -                       "  miss_rate=%0.2f"
> -                       ", encode_rate=%0.2f"
> -                       ", overflow=%" PRIu64 "\n",
> -                       info->xbzrle_cache->cache_size,
> -                       info->xbzrle_cache->bytes,
> -                       info->xbzrle_cache->pages,
> -                       info->xbzrle_cache->cache_miss,
> -                       info->xbzrle_cache->cache_miss_rate,
> -                       info->xbzrle_cache->encoding_rate,
> -                       info->xbzrle_cache->overflow);
> +        monitor_hmp_printf(hmp, "XBZRLE: size=%" PRIu64
> +                           ", transferred=%" PRIu64
> +                           ", pages=%" PRIu64
> +                           ", miss=%" PRIu64 "\n"
> +                           "  miss_rate=%0.2f"
> +                           ", encode_rate=%0.2f"
> +                           ", overflow=%" PRIu64 "\n",
> +                           info->xbzrle_cache->cache_size,
> +                           info->xbzrle_cache->bytes,
> +                           info->xbzrle_cache->pages,
> +                           info->xbzrle_cache->cache_miss,
> +                           info->xbzrle_cache->cache_miss_rate,
> +                           info->xbzrle_cache->encoding_rate,
> +                           info->xbzrle_cache->overflow);
>      }
>  
>      if (info->has_cpu_throttle_percentage) {
> -        monitor_printf(mon, "CPU Throttle (%%): %" PRIu64 "\n",
> -                       info->cpu_throttle_percentage);
> +        monitor_hmp_printf(hmp, "CPU Throttle (%%): %" PRIu64 "\n",
> +                           info->cpu_throttle_percentage);
>      }
>  
>      if (info->has_dirty_limit_throttle_time_per_round) {
> -        monitor_printf(mon, "Dirty-limit Throttle (us): %" PRIu64 "\n",
> -                       info->dirty_limit_throttle_time_per_round);
> +        monitor_hmp_printf(hmp, "Dirty-limit Throttle (us): %" PRIu64 "\n",
> +                           info->dirty_limit_throttle_time_per_round);
>      }
>  
>      if (info->has_dirty_limit_ring_full_time) {
> -        monitor_printf(mon, "Dirty-limit Ring Full (us): %" PRIu64 "\n",
> -                       info->dirty_limit_ring_full_time);
> +        monitor_hmp_printf(hmp, "Dirty-limit Ring Full (us): %" PRIu64 "\n",
> +                           info->dirty_limit_ring_full_time);
>      }
>  
> -    migration_dump_blocktime(mon, info);
> +    migration_dump_blocktime(hmp, info);
>  out:
>      qapi_free_MigrationInfo(info);
>  }
>  
>  void hmp_info_migrate_capabilities(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      MigrationCapabilityStatusList *caps, *cap;
>  
>      caps = qmp_query_migrate_capabilities(NULL);
>  
>      if (caps) {
>          for (cap = caps; cap; cap = cap->next) {
> -            monitor_printf(mon, "%s: %s\n",
> -                           MigrationCapability_str(cap->value->capability),
> -                           cap->value->state ? "on" : "off");
> +            monitor_hmp_printf(hmp, "%s: %s\n",
> +                               MigrationCapability_str(cap->value->capability),
> +                               cap->value->state ? "on" : "off");
>          }
>      }
>  
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
> -static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
> +static void monitor_print_cpr_exec_command(MonitorHMP *hmp, strList *args)
>  {
> -    monitor_printf(mon, "%s:",
> +    monitor_hmp_printf(hmp, "%s:",
>          MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
>  
>      while (args) {
> -        monitor_printf(mon, " %s", args->value);
> +        monitor_hmp_printf(hmp, " %s", args->value);
>          args = args->next;
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>  }
>  
>  void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      MigrationParameters *params;
>      MigrationState *s = migrate_get_current();
>  
>      params = qmp_query_migrate_parameters(NULL);
>  
>      if (params) {
> -        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL),
>              params->announce_initial);
> -        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
>              params->announce_max);
> -        monitor_printf(mon, "%s: %" PRIu64 "\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 "\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
>              params->announce_rounds);
> -        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
>              params->announce_step);
>          assert(params->has_throttle_trigger_threshold);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_hmp_printf(hmp, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
>              params->throttle_trigger_threshold);
>          assert(params->has_cpu_throttle_initial);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_hmp_printf(hmp, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL),
>              params->cpu_throttle_initial);
>          assert(params->has_cpu_throttle_increment);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_hmp_printf(hmp, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT),
>              params->cpu_throttle_increment);
>          assert(params->has_cpu_throttle_tailslow);
> -        monitor_printf(mon, "%s: %s\n",
> +        monitor_hmp_printf(hmp, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW),
>              params->cpu_throttle_tailslow ? "on" : "off");
>          assert(params->has_max_cpu_throttle);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_hmp_printf(hmp, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
>              params->max_cpu_throttle);
>          assert(params->tls_creds);
> -        monitor_printf(mon, "%s: '%s'\n",
> +        monitor_hmp_printf(hmp, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
>                         params->tls_creds->u.s);
>          assert(params->tls_hostname);
> -        monitor_printf(mon, "%s: '%s'\n",
> +        monitor_hmp_printf(hmp, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
>                         params->tls_hostname->u.s);
>          assert(params->tls_authz);
> -        monitor_printf(mon, "%s: '%s'\n",
> +        monitor_hmp_printf(hmp, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>                         params->tls_authz->u.s);
>          assert(params->has_max_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
>              params->max_bandwidth);
>          assert(params->has_avail_switchover_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_AVAIL_SWITCHOVER_BANDWIDTH),
>              params->avail_switchover_bandwidth);
>          assert(params->has_max_postcopy_bandwidth);
> -        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes/second\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH),
>              params->max_postcopy_bandwidth);
>          assert(params->has_downtime_limit);
> -        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>              params->downtime_limit);
>          assert(params->has_x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u ms\n",
> +        monitor_hmp_printf(hmp, "%s: %u ms\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_X_CHECKPOINT_DELAY),
>              params->x_checkpoint_delay);
> -        monitor_printf(mon, "%s: %u\n",
> +        monitor_hmp_printf(hmp, "%s: %u\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
>              params->multifd_channels);
> -        monitor_printf(mon, "%s: %s\n",
> +        monitor_hmp_printf(hmp, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESSION),
>              MultiFDCompression_str(params->multifd_compression));
>          assert(params->has_zero_page_detection);
> -        monitor_printf(mon, "%s: %s\n",
> +        monitor_hmp_printf(hmp, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_ZERO_PAGE_DETECTION),
>              qapi_enum_lookup(&ZeroPageDetection_lookup,
>                  params->zero_page_detection));
> -        monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
>              params->xbzrle_cache_size);
>  
>          if (s->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
>  
> -            monitor_printf(mon, "%s:\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
> +            monitor_hmp_printf(hmp, "%s:\n",
> +                               MigrationParameter_str(
> +                                   MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING));
>  
>              for (bmnal = params->block_bitmap_mapping;
>                   bmnal;
> @@ -430,47 +427,47 @@ void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
>                  const BitmapMigrationNodeAlias *bmna = bmnal->value;
>                  const BitmapMigrationBitmapAliasList *bmbal;
>  
> -                monitor_printf(mon, "  '%s' -> '%s'\n",
> -                               bmna->node_name, bmna->alias);
> +                monitor_hmp_printf(hmp, "  '%s' -> '%s'\n",
> +                                   bmna->node_name, bmna->alias);
>  
>                  for (bmbal = bmna->bitmaps; bmbal; bmbal = bmbal->next) {
>                      const BitmapMigrationBitmapAlias *bmba = bmbal->value;
>  
> -                    monitor_printf(mon, "    '%s' -> '%s'\n",
> -                                   bmba->name, bmba->alias);
> +                    monitor_hmp_printf(hmp, "    '%s' -> '%s'\n",
> +                                       bmba->name, bmba->alias);
>                  }
>              }
>          }
>  
> -        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " ms\n",
>          MigrationParameter_str(MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD),
>          params->x_vcpu_dirty_limit_period);
>  
> -        monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
> +        monitor_hmp_printf(hmp, "%s: %" PRIu64 " MB/s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT),
>              params->vcpu_dirty_limit);
>  
>          assert(params->has_mode);
> -        monitor_printf(mon, "%s: %s\n",
> +        monitor_hmp_printf(hmp, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>              qapi_enum_lookup(&MigMode_lookup, params->mode));
>  
>          if (params->has_direct_io) {
> -            monitor_printf(mon, "%s: %s\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_DIRECT_IO),
> -                           params->direct_io ? "on" : "off");
> +            monitor_hmp_printf(hmp, "%s: %s\n",
> +                               MigrationParameter_str(
> +                                   MIGRATION_PARAMETER_DIRECT_IO),
> +                               params->direct_io ? "on" : "off");
>          }
>  
>          if (params->has_x_rdma_chunk_size) {
> -            monitor_printf(mon, "%s: %" PRIu64 " bytes\n",
> -                           MigrationParameter_str(
> -                               MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
> -                           params->x_rdma_chunk_size);
> +            monitor_hmp_printf(hmp, "%s: %" PRIu64 " bytes\n",
> +                               MigrationParameter_str(
> +                                   MIGRATION_PARAMETER_X_RDMA_CHUNK_SIZE),
> +                               params->x_rdma_chunk_size);
>          }
>  
>          assert(params->has_cpr_exec_command);
> -        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
> +        monitor_print_cpr_exec_command(hmp, params->cpr_exec_command);
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -857,12 +854,12 @@ void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
>      if (uri_cpr) {
>          if (migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>              error_setg(&err, "-c can only be used in cpr-transfer mode");
> -            hmp_handle_error(mon, err);
> +            hmp_handle_error(hmp, err);
>              return;
>          }
>  
>          if (!migrate_uri_parse(uri_cpr, &channel_cpr, &err)) {
> -            hmp_handle_error(mon, err);
> +            hmp_handle_error(hmp, err);
>              return;
>          }
>  
> @@ -879,8 +876,8 @@ void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
>          HMPMigrationStatus *status;
>  
>          if (!hmp->use_readline) {
> -            monitor_printf(mon, "terminal does not allow synchronous "
> -                           "migration, continuing detached\n");
> +            monitor_hmp_printf(hmp, "terminal does not allow synchronous "
> +                               "migration, continuing detached\n");
>              return;
>          }
>          monitor_suspend(mon);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 89cc19c2431d..1834e3c1f697 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -105,26 +105,24 @@ strList *hmp_split_at_comma(const char *str)
>  
>  void hmp_info_name(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      NameInfo *info;
>  
>      info = qmp_query_name(NULL);
>      if (info->name) {
> -        monitor_printf(mon, "%s\n", info->name);
> +        monitor_hmp_printf(hmp, "%s\n", info->name);
>      }
>      qapi_free_NameInfo(info);
>  }
>  
>  void hmp_info_version(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      VersionInfo *info;
>  
>      info = qmp_query_version(NULL);
>  
> -    monitor_printf(mon, "%" PRId64 ".%" PRId64 ".%" PRId64 "%s\n",
> -                   info->qemu->major, info->qemu->minor, info->qemu->micro,
> -                   info->package);
> +    monitor_hmp_printf(hmp, "%" PRId64 ".%" PRId64 ".%" PRId64 "%s\n",
> +                       info->qemu->major, info->qemu->minor, info->qemu->micro,
> +                       info->package);
>  
>      qapi_free_VersionInfo(info);
>  }
> @@ -145,13 +143,12 @@ void hmp_stop(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_sync_profile(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *op = qdict_get_try_str(qdict, "op");
>  
>      if (op == NULL) {
>          bool on = qsp_is_enabled();
>  
> -        monitor_printf(mon, "sync-profile is %s\n", on ? "on" : "off");
> +        monitor_hmp_printf(hmp, "sync-profile is %s\n", on ? "on" : "off");
>          return;
>      }
>      if (!strcmp(op, "on")) {
> @@ -179,14 +176,13 @@ void hmp_exit_preconfig(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int64_t cpu_index;
>  
>      /* XXX: drop the monitor_hmp_set_cpu() usage when all HMP commands that
>              use it are converted to the QAPI */
>      cpu_index = qdict_get_int(qdict, "index");
>      if (monitor_hmp_set_cpu(hmp, cpu_index) < 0) {
> -        monitor_printf(mon, "invalid CPU index\n");
> +        monitor_hmp_printf(hmp, "invalid CPU index\n");
>      }
>  }
>  
> @@ -200,7 +196,6 @@ void hmp_cont(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_change(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *device = qdict_get_str(qdict, "device");
>      const char *target = qdict_get_str(qdict, "target");
>      const char *arg = qdict_get_try_str(qdict, "arg");
> @@ -210,11 +205,11 @@ void hmp_change(MonitorHMP *hmp, const QDict *qdict)
>  
>  #ifdef CONFIG_VNC
>      if (strcmp(device, "vnc") == 0) {
> -        hmp_change_vnc(mon, device, target, arg, read_only, force, &err);
> +        hmp_change_vnc(hmp, device, target, arg, read_only, force, &err);
>      } else
>  #endif
>      {
> -        hmp_change_medium(mon, device, target, arg, read_only, force, &err);
> +        hmp_change_medium(hmp, device, target, arg, read_only, force, &err);
>      }
>  
>      hmp_handle_error(hmp, err);
> @@ -242,21 +237,20 @@ void hmp_closefd(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
>      IOThreadInfoList *info;
>      IOThreadInfo *value;
>  
>      for (info = info_list; info; info = info->next) {
>          value = info->value;
> -        monitor_printf(mon, "%s:\n", value->id);
> -        monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
> -        monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
> -        monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
> -        monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
> -        monitor_printf(mon, "  poll-weight=%" PRId64 "\n", value->poll_weight);
> -        monitor_printf(mon, "  aio-max-batch=%" PRId64 "\n",
> -                       value->aio_max_batch);
> +        monitor_hmp_printf(hmp, "%s:\n", value->id);
> +        monitor_hmp_printf(hmp, "  thread_id=%" PRId64 "\n", value->thread_id);
> +        monitor_hmp_printf(hmp, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
> +        monitor_hmp_printf(hmp, "  poll-grow=%" PRId64 "\n", value->poll_grow);
> +        monitor_hmp_printf(hmp, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
> +        monitor_hmp_printf(hmp, "  poll-weight=%" PRId64 "\n", value->poll_weight);
> +        monitor_hmp_printf(hmp, "  aio-max-batch=%" PRId64 "\n",
> +                           value->aio_max_batch);
>      }
>  
>      qapi_free_IOThreadInfoList(info_list);
> @@ -264,26 +258,23 @@ void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_help(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
> +    hmp_help_cmd(hmp, qdict_get_try_str(qdict, "name"));
>  }
>  
>  void hmp_clear(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      /*
>       * Send an ANSI escape sequence:
>       * "\x1b[H" - move cursor to top-left
>       * "\x1b[2J" - clear visible screen
>       * "\x1b[3J" - clear scrollback
>       */
> -    monitor_printf(mon, "\x1b[H\x1b[2J\x1b[3J");
> +    monitor_hmp_printf(hmp, "\x1b[H\x1b[2J\x1b[3J");
>  }
>  
>  void hmp_info_help(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    hmp_help_cmd(mon, "info");
> +    hmp_help_cmd(hmp, "info");
>  }
>  
>  void hmp_info_sync_profile(MonitorHMP *hmp, const QDict *qdict)
> @@ -299,7 +290,6 @@ void hmp_info_sync_profile(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_history(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int i;
>      const char *str;
>  
> @@ -312,7 +302,7 @@ void hmp_info_history(MonitorHMP *hmp, const QDict *qdict)
>          if (!str) {
>              break;
>          }
> -        monitor_printf(mon, "%d: '%s'\n", i, str);
> +        monitor_hmp_printf(hmp, "%d: '%s'\n", i, str);
>          i++;
>      }
>  }
> @@ -328,7 +318,6 @@ void hmp_logfile(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_log(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int mask;
>      const char *items = qdict_get_str(qdict, "items");
>      Error *err = NULL;
> @@ -338,7 +327,7 @@ void hmp_log(MonitorHMP *hmp, const QDict *qdict)
>      } else {
>          mask = qemu_str_to_log_mask(items);
>          if (!mask) {
> -            hmp_help_cmd(mon, "log");
> +            hmp_help_cmd(hmp, "log");
>              return;
>          }
>      }
> @@ -350,7 +339,6 @@ void hmp_log(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_gdbserver(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      const char *device = qdict_get_try_str(qdict, "device");
>  
> @@ -361,43 +349,41 @@ void hmp_gdbserver(MonitorHMP *hmp, const QDict *qdict)
>      if (!gdbserver_start(device, &err)) {
>          error_report_err(err);
>      } else if (strcmp(device, "none") == 0) {
> -        monitor_printf(mon, "Disabled gdbserver\n");
> +        monitor_hmp_printf(hmp, "Disabled gdbserver\n");
>      } else {
> -        monitor_printf(mon, "Waiting for gdb connection on device '%s'\n",
> -                       device);
> +        monitor_hmp_printf(hmp, "Waiting for gdb connection on device '%s'\n",
> +                           device);
>      }
>  }
>  
>  void hmp_print(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int format = qdict_get_int(qdict, "format");
>      hwaddr val = qdict_get_int(qdict, "val");
>  
>      switch(format) {
>      case 'o':
> -        monitor_printf(mon, "%#" HWADDR_PRIo, val);
> +        monitor_hmp_printf(hmp, "0x%" HWADDR_PRIo, val);
>          break;
>      case 'x':
> -        monitor_printf(mon, "%#" HWADDR_PRIx, val);
> +        monitor_hmp_printf(hmp, "0x%" HWADDR_PRIx, val);
>          break;
>      case 'u':
> -        monitor_printf(mon, "%" HWADDR_PRIu, val);
> +        monitor_hmp_printf(hmp, "%" HWADDR_PRIu, val);
>          break;
>      default:
>      case 'd':
> -        monitor_printf(mon, "%" HWADDR_PRId, val);
> +        monitor_hmp_printf(hmp, "%" HWADDR_PRId, val);
>          break;
>      case 'c':
> -        monitor_printc(mon, val);
> +        monitor_hmp_printc(hmp, val);
>          break;
>      }
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>  }
>  
>  void hmp_sum(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      uint32_t addr;
>      uint16_t sum;
>      uint32_t start = qdict_get_int(qdict, "start");
> @@ -411,12 +397,11 @@ void hmp_sum(MonitorHMP *hmp, const QDict *qdict)
>          sum = (sum >> 1) | (sum << 15);
>          sum += val;
>      }
> -    monitor_printf(mon, "%05d\n", sum);
> +    monitor_hmp_printf(hmp, "%05d\n", sum);
>  }
>  
>  void hmp_ioport_read(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int size = qdict_get_int(qdict, "size");
>      int addr = qdict_get_int(qdict, "addr");
>      int has_index = qdict_haskey(qdict, "index");
> @@ -445,8 +430,8 @@ void hmp_ioport_read(MonitorHMP *hmp, const QDict *qdict)
>          suffix = 'l';
>          break;
>      }
> -    monitor_printf(mon, "port%c[0x%04x] = 0x%0*x\n",
> -                   suffix, addr, size * 2, val);
> +    monitor_hmp_printf(hmp, "port%c[0x%04x] = 0x%0*x\n",
> +                       suffix, addr, size * 2, val);
>  }
>  
>  void hmp_ioport_write(MonitorHMP *hmp, const QDict *qdict)
> @@ -473,7 +458,6 @@ void hmp_ioport_write(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_boot_set(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *local_err = NULL;
>      const char *bootdevice = qdict_get_str(qdict, "bootdevice");
>  
> @@ -481,7 +465,7 @@ void hmp_boot_set(MonitorHMP *hmp, const QDict *qdict)
>      if (local_err) {
>          error_report_err(local_err);
>      } else {
> -        monitor_printf(mon, "boot device list now set to %s\n", bootdevice);
> +        monitor_hmp_printf(hmp, "boot device list now set to %s\n", bootdevice);
>      }
>  }
>  
> @@ -507,7 +491,7 @@ void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(MONITOR(hmp), "DTB dumped to '%s'\n", filename);
> +    monitor_hmp_printf(hmp, "DTB dumped to '%s'\n", filename);
>  }
>  #endif
>  
> @@ -573,14 +557,13 @@ int monitor_hmp_get_cpu_index(MonitorHMP *hmp)
>  
>  void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
>      int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
>      CPUState *cs;
>  
>      if (all_cpus) {
>          CPU_FOREACH(cs) {
> -            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> +            monitor_hmp_printf(hmp, "\nCPU#%d\n", cs->cpu_index);
>              cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
>          }
>      } else {
> @@ -588,14 +571,14 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
>  
>          if (!cs) {
>              if (vcpu >= 0) {
> -                monitor_printf(mon, "CPU#%d not available\n", vcpu);
> +                monitor_hmp_printf(hmp, "CPU#%d not available\n", vcpu);
>              } else {
> -                monitor_printf(mon, "No CPU available\n");
> +                monitor_hmp_printf(hmp, "No CPU available\n");
>              }
>              return;
>          }
>  
> -        monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> +        monitor_hmp_printf(hmp, "\nCPU#%d\n", cs->cpu_index);
>          cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
>      }
>  }
> @@ -603,7 +586,6 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
>  static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>                          uint64_t addr, bool is_physical)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int l, line_size, i, max_digits, len;
>      uint8_t buf[16];
>      uint64_t v;
> @@ -612,12 +594,12 @@ static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>      const bool big_endian = target_big_endian();
>  
>      if (!cs && (format == 'i' || !is_physical)) {
> -        monitor_printf(mon, "Can not dump without CPU\n");
> +        monitor_hmp_printf(hmp, "Can not dump without CPU\n");
>          return;
>      }
>  
>      if (format == 'i') {
> -        monitor_disas(mon, cs, addr, count, is_physical);
> +        monitor_disas(hmp, cs, addr, count, is_physical);
>          return;
>      }
>  
> @@ -647,7 +629,7 @@ static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>      }
>  
>      while (len > 0) {
> -        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
> +        monitor_hmp_printf(hmp, "%0*" PRIx64 ":", addr_width, addr);
>          l = len;
>          if (l > line_size) {
>              l = line_size;
> @@ -657,12 +639,12 @@ static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>              MemTxResult r = address_space_read(as, addr,
>                                                 MEMTXATTRS_UNSPECIFIED, buf, l);
>              if (r != MEMTX_OK) {
> -                monitor_printf(mon, " Cannot access memory\n");
> +                monitor_hmp_printf(hmp, " Cannot access memory\n");
>                  break;
>              }
>          } else {
>              if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
> -                monitor_printf(mon, " Cannot access memory\n");
> +                monitor_hmp_printf(hmp, " Cannot access memory\n");
>                  break;
>              }
>          }
> @@ -683,27 +665,27 @@ static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
>                  v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
>                  break;
>              }
> -            monitor_printf(mon, " ");
> +            monitor_hmp_printf(hmp, " ");
>              switch (format) {
>              case 'o':
> -                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
> +                monitor_hmp_printf(hmp, "0%*" PRIo64, max_digits, v);
>                  break;
>              case 'x':
> -                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
> +                monitor_hmp_printf(hmp, "0x%0*" PRIx64, max_digits, v);
>                  break;
>              case 'u':
> -                monitor_printf(mon, "%*" PRIu64, max_digits, v);
> +                monitor_hmp_printf(hmp, "%*" PRIu64, max_digits, v);
>                  break;
>              case 'd':
> -                monitor_printf(mon, "%*" PRId64, max_digits, v);
> +                monitor_hmp_printf(hmp, "%*" PRId64, max_digits, v);
>                  break;
>              case 'c':
> -                monitor_printc(mon, v);
> +                monitor_hmp_printc(hmp, v);
>                  break;
>              }
>              i += wsize;
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>          addr += l;
>          len -= l;
>      }
> @@ -731,7 +713,6 @@ void hmp_physical_memory_dump(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      hwaddr addr = qdict_get_int(qdict, "addr");
>      Error *local_err = NULL;
>      MemoryRegion *mr = NULL;
> @@ -743,29 +724,28 @@ void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
> -                   " (%s) is %p\n",
> -                   addr, mr->name, ptr);
> +    monitor_hmp_printf(hmp, "Host virtual address for 0x%" HWADDR_PRIx
> +                       " (%s) is %p\n",
> +                       addr, mr->name, ptr);
>  
>      memory_region_unref(mr);
>  }
>  
>  void hmp_gva2gpa(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      vaddr addr = qdict_get_int(qdict, "addr");
>      CPUState *cs = monitor_hmp_get_cpu(hmp);
>      TranslateForDebugResult tres;
>  
>      if (!cs) {
> -        monitor_printf(mon, "No cpu\n");
> +        monitor_hmp_printf(hmp, "No cpu\n");
>          return;
>      }
>  
>      if (!cpu_translate_for_debug(cs, addr, &tres)) {
> -        monitor_printf(mon, "Unmapped\n");
> +        monitor_hmp_printf(hmp, "Unmapped\n");
>      } else {
> -        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", tres.physaddr);
> +        monitor_hmp_printf(hmp, "gpa: 0x%" HWADDR_PRIx "\n", tres.physaddr);
>      }
>  }
>  
> @@ -806,7 +786,6 @@ out:
>  
>  void hmp_gpa2hpa(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      hwaddr addr = qdict_get_int(qdict, "addr");
>      Error *local_err = NULL;
>      MemoryRegion *mr = NULL;
> @@ -823,9 +802,9 @@ void hmp_gpa2hpa(MonitorHMP *hmp, const QDict *qdict)
>      if (local_err) {
>          error_report_err(local_err);
>      } else {
> -        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
> -                       " (%s) is 0x%" PRIx64 "\n",
> -                       addr, mr->name, (uint64_t) physaddr);
> +        monitor_hmp_printf(hmp, "Host physical address for 0x%" HWADDR_PRIx
> +                           " (%s) is 0x%" PRIx64 "\n",
> +                           addr, mr->name, (uint64_t) physaddr);
>      }
>  
>      memory_region_unref(mr);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 2484a2310dff..e5f8b9c576e0 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -80,8 +80,6 @@ static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
>      hmp->use_readline = val;
>  }
>  
> -int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
> -    G_GNUC_PRINTF(2, 0);
>  static void monitor_hmp_accept_input(Monitor *mon);
>  static void monitor_hmp_complete(UserCreatable *uc, Error **errp);
>  static bool monitor_hmp_prepare_delete(UserCreatable *uc, Error **errp);
> @@ -95,7 +93,6 @@ static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
>                                     monitor_hmp_get_readline,
>                                     monitor_hmp_set_readline);
>  
> -    moncls->vprintf = monitor_hmp_vprintf;
>      moncls->accept_input = monitor_hmp_accept_input;
>  
>      ucc->complete = monitor_hmp_complete;
> @@ -114,12 +111,6 @@ static void monitor_hmp_init(Object *obj)
>      hmp->use_readline = true;
>  }
>  
> -int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
> -{
> -    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
> -    return monitor_puts(mon, buf);
> -}
> -
>  static void monitor_hmp_accept_input(Monitor *mon)
>  {
>      qemu_mutex_lock(&mon->mon_lock);
> @@ -166,8 +157,7 @@ int monitor_hmp_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
>          /* prompt is printed on return from the command handler */
>          return 0;
>      } else {
> -        monitor_printf(&hmp->parent_obj,
> -                       "terminal does not support password prompting\n");
> +        monitor_hmp_printf(hmp, "terminal does not support password prompting\n");
>          return -ENOTTY;
>      }
>  }
> @@ -319,7 +309,7 @@ static bool cmd_available(const HMPCommand *cmd)
>      return phase_check(PHASE_MACHINE_READY) || cmd_can_preconfig(cmd);
>  }
>  
> -static void help_cmd_dump_one(Monitor *mon,
> +static void help_cmd_dump_one(MonitorHMP *mon,
>                                const HMPCommand *cmd,
>                                char **prefix_args,
>                                int prefix_args_nb)
> @@ -331,13 +321,13 @@ static void help_cmd_dump_one(Monitor *mon,
>      }
>  
>      for (i = 0; i < prefix_args_nb; i++) {
> -        monitor_printf(mon, "%s ", prefix_args[i]);
> +        monitor_hmp_printf(mon, "%s ", prefix_args[i]);
>      }
> -    monitor_printf(mon, "%s %s -- %s\n", cmd->name, cmd->params, cmd->help);
> +    monitor_hmp_printf(mon, "%s %s -- %s\n", cmd->name, cmd->params, cmd->help);
>  }
>  
>  /* @args[@arg_index] is the valid command need to find in @cmds */
> -static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
> +static void help_cmd_dump(MonitorHMP *mon, const HMPCommand *cmds,
>                            char **args, int nb_args, int arg_index)
>  {
>      const HMPCommand *cmd;
> @@ -367,13 +357,13 @@ static void help_cmd_dump(Monitor *mon, const HMPCommand *cmds,
>      }
>  
>      /* Command not found */
> -    monitor_printf(mon, "unknown command: '");
> +    monitor_hmp_printf(mon, "unknown command: '");
>      for (i = 0; i <= arg_index; i++) {
> -        monitor_printf(mon, "%s%s", args[i], i == arg_index ? "'\n" : " ");
> +        monitor_hmp_printf(mon, "%s%s", args[i], i == arg_index ? "'\n" : " ");
>      }
>  }
>  
> -void hmp_help_cmd(Monitor *mon, const char *name)
> +void hmp_help_cmd(MonitorHMP *mon, const char *name)
>  {
>      char *args[MAX_ARGS];
>      int nb_args = 0;
> @@ -383,15 +373,15 @@ void hmp_help_cmd(Monitor *mon, const char *name)
>          /* special case for log, directly dump and return */
>          if (!strcmp(name, "log")) {
>              const QEMULogItem *item;
> -            monitor_printf(mon, "Log items (comma separated):\n");
> -            monitor_printf(mon, "%-15s %s\n", "none", "remove all logs");
> +            monitor_hmp_printf(mon, "Log items (comma separated):\n");
> +            monitor_hmp_printf(mon, "%-15s %s\n", "none", "remove all logs");
>              for (item = qemu_log_items; item->mask != 0; item++) {
> -                monitor_printf(mon, "%-15s %s\n", item->name, item->help);
> +                monitor_hmp_printf(mon, "%-15s %s\n", item->name, item->help);
>              }
>  #ifdef CONFIG_TRACE_LOG
> -            monitor_printf(mon, "trace:PATTERN   enable trace events\n");
> -            monitor_printf(mon, "\nUse \"log trace:help\" to get a list of "
> -                           "trace events.\n\n");
> +            monitor_hmp_printf(mon, "trace:PATTERN   enable trace events\n");
> +            monitor_hmp_printf(mon, "\nUse \"log trace:help\" to get a list of "
> +                               "trace events.\n\n");
>  #endif
>              return;
>          }
> @@ -455,12 +445,12 @@ static sigjmp_buf expr_env;
>  static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
>  
>  static G_NORETURN G_GNUC_PRINTF(2, 3)
> -void expr_error(Monitor *mon, const char *fmt, ...)
> +void expr_error(MonitorHMP *mon, const char *fmt, ...)
>  {
>      va_list ap;
>      va_start(ap, fmt);
> -    monitor_vprintf(mon, fmt, ap);
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_vprintf(mon, fmt, ap);
> +    monitor_hmp_printf(mon, "\n");
>      va_end(ap);
>      siglongjmp(expr_env, 1);
>  }
> @@ -475,9 +465,9 @@ static void next(void)
>      }
>  }
>  
> -static int64_t expr_sum(Monitor *mon);
> +static int64_t expr_sum(MonitorHMP *mon);
>  
> -static int64_t expr_unary(Monitor *mon)
> +static int64_t expr_unary(MonitorHMP *mon)
>  {
>      int64_t n;
>      char *p;
> @@ -535,8 +525,8 @@ static int64_t expr_unary(Monitor *mon)
>                  pch++;
>              }
>              *q = 0;
> -            if (!gdb_get_register(MONITOR_HMP(mon), &reg, buf)
> -                && get_monitor_def(MONITOR_HMP(mon), &reg, buf) < 0) {
> +            if (!gdb_get_register(mon, &reg, buf)
> +                && get_monitor_def(mon, &reg, buf) < 0) {
>                  expr_error(mon, "unknown register");
>              }
>              n = reg;
> @@ -564,7 +554,7 @@ static int64_t expr_unary(Monitor *mon)
>      return n;
>  }
>  
> -static int64_t expr_prod(Monitor *mon)
> +static int64_t expr_prod(MonitorHMP *mon)
>  {
>      int64_t val, val2;
>      int op;
> @@ -598,7 +588,7 @@ static int64_t expr_prod(Monitor *mon)
>      return val;
>  }
>  
> -static int64_t expr_logic(Monitor *mon)
> +static int64_t expr_logic(MonitorHMP *mon)
>  {
>      int64_t val, val2;
>      int op;
> @@ -627,7 +617,7 @@ static int64_t expr_logic(Monitor *mon)
>      return val;
>  }
>  
> -static int64_t expr_sum(Monitor *mon)
> +static int64_t expr_sum(MonitorHMP *mon)
>  {
>      int64_t val, val2;
>      int op;
> @@ -649,7 +639,7 @@ static int64_t expr_sum(Monitor *mon)
>      return val;
>  }
>  
> -static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
> +static int get_expr(MonitorHMP *mon, int64_t *pval, const char **pp)
>  {
>      pch = *pp;
>      if (sigsetjmp(expr_env, 0)) {
> @@ -664,7 +654,7 @@ static int get_expr(Monitor *mon, int64_t *pval, const char **pp)
>      return 0;
>  }
>  
> -static int get_double(Monitor *mon, double *pval, const char **pp)
> +static int get_double(MonitorHMP *mon, double *pval, const char **pp)
>  {
>      const char *p = *pp;
>      char *tailp;
> @@ -672,12 +662,12 @@ static int get_double(Monitor *mon, double *pval, const char **pp)
>  
>      d = strtod(p, &tailp);
>      if (tailp == p) {
> -        monitor_printf(mon, "Number expected\n");
> +        monitor_hmp_printf(mon, "Number expected\n");
>          return -1;
>      }
>      if (d != d || d - d != 0) {
>          /* NaN or infinity */
> -        monitor_printf(mon, "Bad number\n");
> +        monitor_hmp_printf(mon, "Bad number\n");
>          return -1;
>      }
>      *pval = d;
> @@ -788,7 +778,6 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp,
>                                                 const char **cmdp,
>                                                 HMPCommand *table)
>  {
> -    Monitor *mon = &hmp->parent_obj;
>      const char *p;
>      const HMPCommand *cmd;
>      char cmdname[256];
> @@ -801,14 +790,14 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp,
>  
>      cmd = search_dispatch_table(table, cmdname);
>      if (!cmd) {
> -        monitor_printf(mon, "unknown command: '%.*s'\n",
> -                       (int)(p - cmdp_start), cmdp_start);
> +        monitor_hmp_printf(hmp, "unknown command: '%.*s'\n",
> +                           (int)(p - cmdp_start), cmdp_start);
>          return NULL;
>      }
>      if (!cmd_available(cmd)) {
> -        monitor_printf(mon, "Command '%.*s' not available "
> -                            "until machine initialization has completed.\n",
> -                       (int)(p - cmdp_start), cmdp_start);
> +        monitor_hmp_printf(hmp, "Command '%.*s' not available "
> +                           "until machine initialization has completed.\n",
> +                           (int)(p - cmdp_start), cmdp_start);
>          return NULL;
>      }
>  
> @@ -832,7 +821,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp,
>   * Else, insert command arguments into a QDict, and return it.
>   * Note: On success, caller has to free the QDict structure.
>   */
> -static QDict *monitor_parse_arguments(Monitor *mon,
> +static QDict *monitor_parse_arguments(MonitorHMP *mon,
>                                        const char **endp,
>                                        const HMPCommand *cmd)
>  {
> @@ -873,15 +862,15 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  if (ret < 0) {
>                      switch (c) {
>                      case 'F':
> -                        monitor_printf(mon, "%s: filename expected\n",
> -                                       cmd->name);
> +                        monitor_hmp_printf(mon, "%s: filename expected\n",
> +                                           cmd->name);
>                          break;
>                      case 'B':
> -                        monitor_printf(mon, "%s: block device name expected\n",
> -                                       cmd->name);
> +                        monitor_hmp_printf(mon, "%s: block device name expected\n",
> +                                           cmd->name);
>                          break;
>                      default:
> -                        monitor_printf(mon, "%s: string expected\n", cmd->name);
> +                        monitor_hmp_printf(mon, "%s: string expected\n", cmd->name);
>                          break;
>                      }
>                      goto fail;
> @@ -968,8 +957,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                  next:
>                      if (*p != '\0' && !qemu_isspace(*p)) {
> -                        monitor_printf(mon, "invalid char in format: '%c'\n",
> -                                       *p);
> +                        monitor_hmp_printf(mon, "invalid char in format: '%c'\n",
> +                                           *p);
>                          goto fail;
>                      }
>                      if (format < 0) {
> @@ -1030,12 +1019,12 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  }
>                  /* Check if 'i' is greater than 32-bit */
>                  if ((c == 'i') && ((val >> 32) & 0xffffffff)) {
> -                    monitor_printf(mon, "\'%s\' has failed: ", cmd->name);
> -                    monitor_printf(mon, "integer is for 32-bit values\n");
> +                    monitor_hmp_printf(mon, "\'%s\' has failed: ", cmd->name);
> +                    monitor_hmp_printf(mon, "integer is for 32-bit values\n");
>                      goto fail;
>                  } else if (c == 'M') {
>                      if (val < 0) {
> -                        monitor_printf(mon, "enter a positive value\n");
> +                        monitor_hmp_printf(mon, "enter a positive value\n");
>                          goto fail;
>                      }
>                      val *= MiB;
> @@ -1060,7 +1049,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  }
>                  ret = qemu_strtosz_MiB(p, &end, &val);
>                  if (ret < 0 || val > INT64_MAX) {
> -                    monitor_printf(mon, "invalid size\n");
> +                    monitor_hmp_printf(mon, "invalid size\n");
>                      goto fail;
>                  }
>                  qdict_put_int(qdict, key, val);
> @@ -1094,7 +1083,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      }
>                  }
>                  if (*p && !qemu_isspace(*p)) {
> -                    monitor_printf(mon, "Unknown unit suffix\n");
> +                    monitor_hmp_printf(mon, "Unknown unit suffix\n");
>                      goto fail;
>                  }
>                  qdict_put(qdict, key, qnum_from_double(val));
> @@ -1117,7 +1106,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  } else if (p - beg == 3 && !memcmp(beg, "off", p - beg)) {
>                      val = false;
>                  } else {
> -                    monitor_printf(mon, "Expected 'on' or 'off'\n");
> +                    monitor_hmp_printf(mon, "Expected 'on' or 'off'\n");
>                      goto fail;
>                  }
>                  qdict_put_bool(qdict, key, val);
> @@ -1141,8 +1130,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      p++;
>                      if (c != *p) {
>                          if (!is_valid_option(p, typestr)) {
> -                            monitor_printf(mon, "%s: unsupported option -%c\n",
> -                                           cmd->name, *p);
> +                            monitor_hmp_printf(mon, "%s: unsupported option -%c\n",
> +                                               cmd->name, *p);
>                              goto fail;
>                          } else {
>                              skip_key = 1;
> @@ -1159,8 +1148,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                          }
>                          ret = get_str(buf, sizeof(buf), &p);
>                          if (ret < 0) {
> -                            monitor_printf(mon, "%s: value expected for -%c\n",
> -                                           cmd->name, *tmp);
> +                            monitor_hmp_printf(mon, "%s: value expected for -%c\n",
> +                                               cmd->name, *tmp);
>                              goto fail;
>                          }
>                          qdict_put_str(qdict, key, buf);
> @@ -1191,8 +1180,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                  }
>                  len = strlen(p);
>                  if (len <= 0) {
> -                    monitor_printf(mon, "%s: string expected\n",
> -                                   cmd->name);
> +                    monitor_hmp_printf(mon, "%s: string expected\n",
> +                                       cmd->name);
>                      goto fail;
>                  }
>                  qdict_put_str(qdict, key, p);
> @@ -1201,7 +1190,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>              break;
>          default:
>          bad_type:
> -            monitor_printf(mon, "%s: unknown type '%c'\n", cmd->name, c);
> +            monitor_hmp_printf(mon, "%s: unknown type '%c'\n", cmd->name, c);
>              goto fail;
>          }
>          g_free(key);
> @@ -1212,8 +1201,8 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>          p++;
>      }
>      if (*p != '\0') {
> -        monitor_printf(mon, "%s: extraneous characters at the end of line\n",
> -                       cmd->name);
> +        monitor_hmp_printf(mon, "%s: extraneous characters at the end of line\n",
> +                           cmd->name);
>          goto fail;
>      }
>  
> @@ -1281,19 +1270,19 @@ void handle_hmp_command(MonitorHMP *hmp, const char *cmdline)
>  
>      if (!cmd->cmd && !cmd->cmd_info_hrt) {
>          /* FIXME: is it useful to try autoload modules here ??? */
> -        monitor_printf(&hmp->parent_obj, "Command \"%.*s\" is not available.\n",
> -                       (int)(cmdline - cmd_start), cmd_start);
> +        monitor_hmp_printf(hmp, "Command \"%.*s\" is not available.\n",
> +                           (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
> -    qdict = monitor_parse_arguments(&hmp->parent_obj, &cmdline, cmd);
> +    qdict = monitor_parse_arguments(hmp, &cmdline, cmd);
>      if (!qdict) {
>          while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
>              cmdline--;
>          }
> -        monitor_printf(&hmp->parent_obj,
> -                       "Try \"help %.*s\" for more information\n",
> -                       (int)(cmdline - cmd_start), cmd_start);
> +        monitor_hmp_printf(hmp,
> +                           "Try \"help %.*s\" for more information\n",
> +                           (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
> @@ -1539,7 +1528,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>          }
>      } else {
>          if (size == 0 || buf[size - 1] != 0) {
> -            monitor_printf(&hmp->parent_obj, "corrupted command\n");
> +            monitor_hmp_printf(hmp, "corrupted command\n");
>          } else {
>              handle_hmp_command(hmp, (char *)buf);
>          }
> @@ -1580,8 +1569,8 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
>          break;
>  
>      case CHR_EVENT_OPENED:
> -        monitor_printf(mon, "QEMU %s monitor - type 'help' for more "
> -                       "information\n", QEMU_VERSION);
> +        monitor_hmp_printf(hmp, "QEMU %s monitor - type 'help' for more "
> +                           "information\n", QEMU_VERSION);
>          qemu_mutex_lock(&mon->mon_lock);
>          hmp->reset_seen = 1;
>          if (!mon->mux_out && hmp->use_readline) {
> @@ -1613,7 +1602,7 @@ static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
>      MonitorHMP *hmp = opaque;
>      va_list ap;
>      va_start(ap, fmt);
> -    monitor_vprintf(&hmp->parent_obj, fmt, ap);
> +    monitor_hmp_vprintf(hmp, fmt, ap);
>      va_end(ap);
>  }
>  
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index afdda1386080..c198c12eaa00 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -108,12 +108,6 @@ typedef struct HMPCommand {
>  struct MonitorClass {
>      ObjectClass parent_class;
>  
> -    /*
> -     * If non-NULL, the monitor is able to print messages
> -     * for attention of the client user
> -     */
> -    int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
> -        G_GNUC_PRINTF(2, 0);
>      /*
>       * If non-NULL, the monitor is able to send event
>       * notifications back to the client
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 8528af6f79b8..da76e6e4ac19 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -272,58 +272,53 @@ int monitor_puts(Monitor *mon, const char *str)
>      return monitor_puts_locked(mon, str);
>  }
>  
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>  {
> -    MonitorClass *moncls;
> +    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
>  
>      if (!mon) {
>          return -1;
>      }
>  
> -    moncls = MONITOR_GET_CLASS(mon);
> -    if (!moncls->vprintf) {
> -        return -1;
> -    }
> -
> -    return moncls->vprintf(mon, fmt, ap);
> +    return monitor_puts(MONITOR(mon), buf);
>  }
>  
> -int monitor_printf(Monitor *mon, const char *fmt, ...)
> +int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...)
>  {
>      int ret;
>  
>      va_list ap;
>      va_start(ap, fmt);
> -    ret = monitor_vprintf(mon, fmt, ap);
> +    ret = monitor_hmp_vprintf(mon, fmt, ap);
>      va_end(ap);
>      return ret;
>  }
>  
> -void monitor_printc(Monitor *mon, int c)
> +void monitor_hmp_printc(MonitorHMP *mon, int c)
>  {
> -    monitor_printf(mon, "'");
> +    monitor_hmp_printf(mon, "'");
>      switch(c) {
>      case '\'':
> -        monitor_printf(mon, "\\'");
> +        monitor_hmp_printf(mon, "\\'");
>          break;
>      case '\\':
> -        monitor_printf(mon, "\\\\");
> +        monitor_hmp_printf(mon, "\\\\");
>          break;
>      case '\n':
> -        monitor_printf(mon, "\\n");
> +        monitor_hmp_printf(mon, "\\n");
>          break;
>      case '\r':
> -        monitor_printf(mon, "\\r");
> +        monitor_hmp_printf(mon, "\\r");
>          break;
>      default:
>          if (c >= 32 && c <= 126) {
> -            monitor_printf(mon, "%c", c);
> +            monitor_hmp_printf(mon, "%c", c);
>          } else {
> -            monitor_printf(mon, "\\x%02x", c);
> +            monitor_hmp_printf(mon, "\\x%02x", c);
>          }
>          break;
>      }
> -    monitor_printf(mon, "'");
> +    monitor_hmp_printf(mon, "'");
>  }
>  
>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
> diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
> index 5b1c678f5d89..0d718d78aef9 100644
> --- a/net/net-hmp-cmds.c
> +++ b/net/net-hmp-cmds.c
> @@ -28,26 +28,25 @@
>  #include "qemu/help_option.h"
>  #include "qemu/option.h"
>  
> -static void hmp_print_client_info(Monitor *mon, NetworkClientInfo *ci)
> +static void hmp_print_client_info(MonitorHMP *hmp, NetworkClientInfo *ci)
>  {
>      NetFilterInfoList *f;
>  
> -    monitor_printf(mon, "%s: index=%" PRIu32 ",type=%s,%s\n",
> -                   ci->name, ci->queue_index,
> -                   NetClientDriver_str(ci->type), ci->info_str);
> +    monitor_hmp_printf(hmp, "%s: index=%" PRIu32 ",type=%s,%s\n",
> +                       ci->name, ci->queue_index,
> +                       NetClientDriver_str(ci->type), ci->info_str);
>      if (ci->filters) {
> -        monitor_printf(mon, "filters:\n");
> +        monitor_hmp_printf(hmp, "filters:\n");
>          for (f = ci->filters; f; f = f->next) {
> -            monitor_printf(mon, "  - %s: type=%s%s%s\n",
> -                           f->value->name, f->value->type,
> -                           f->value->info[0] ? "," : "", f->value->info);
> +            monitor_hmp_printf(hmp, "  - %s: type=%s%s%s\n",
> +                               f->value->name, f->value->type,
> +                               f->value->info[0] ? "," : "", f->value->info);
>          }
>      }
>  }
>  
>  void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      Error *err = NULL;
>      g_autoptr(NetworkInfo) info = qmp_x_query_network(&err);
>      NetHubInfoList *h;
> @@ -60,13 +59,13 @@ void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
>      for (h = info->hubs; h; h = h->next) {
>          NetHubPortInfoList *p;
>  
> -        monitor_printf(mon, "hub %d\n", (int)h->value->id);
> +        monitor_hmp_printf(hmp, "hub %d\n", (int)h->value->id);
>          for (p = h->value->ports; p; p = p->next) {
>              if (p->value->peer) {
> -                monitor_printf(mon, " \\ %s: ", p->value->name);
> -                hmp_print_client_info(mon, p->value->peer);
> +                monitor_hmp_printf(hmp, " \\ %s: ", p->value->name);
> +                hmp_print_client_info(hmp, p->value->peer);
>              } else {
> -                monitor_printf(mon, " \\ %s\n", p->value->name);
> +                monitor_hmp_printf(hmp, " \\ %s\n", p->value->name);
>              }
>          }
>      }
> @@ -75,11 +74,11 @@ void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
>          NetworkClientInfo *ci = entry->value;
>  
>          if (!ci->peer || ci->type == NET_CLIENT_DRIVER_NIC) {
> -            hmp_print_client_info(mon, ci);
> +            hmp_print_client_info(hmp, ci);
>          } /* else it's a netdev connected to a NIC, printed with the NIC */
>          if (ci->peer && ci->type == NET_CLIENT_DRIVER_NIC) {
> -            monitor_printf(mon, " \\ ");
> -            hmp_print_client_info(mon, ci->peer);
> +            monitor_hmp_printf(hmp, " \\ ");
> +            hmp_print_client_info(hmp, ci->peer);
>          }
>      }
>  }
> diff --git a/net/slirp.c b/net/slirp.c
> index d5c190b48b76..6fbefa9ed1d7 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -711,22 +711,22 @@ error:
>      return -1;
>  }
>  
> -static SlirpState *slirp_lookup(Monitor *mon, const char *id)
> +static SlirpState *slirp_lookup(MonitorHMP *hmp, const char *id)
>  {
>      if (id) {
>          NetClientState *nc = qemu_find_netdev(id);
>          if (!nc) {
> -            monitor_printf(mon, "unrecognized netdev id '%s'\n", id);
> +            monitor_hmp_printf(hmp, "unrecognized netdev id '%s'\n", id);
>              return NULL;
>          }
>          if (strcmp(nc->model, "user")) {
> -            monitor_printf(mon, "invalid device specified\n");
> +            monitor_hmp_printf(hmp, "invalid device specified\n");
>              return NULL;
>          }
>          return DO_UPCAST(SlirpState, nc, nc);
>      } else {
>          if (QTAILQ_EMPTY(&slirp_stacks)) {
> -            monitor_printf(mon, "user mode network stack not in use\n");
> +            monitor_hmp_printf(hmp, "user mode network stack not in use\n");
>              return NULL;
>          }
>          return QTAILQ_FIRST(&slirp_stacks);
> @@ -735,7 +735,6 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *id)
>  
>  void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      /* TODO: support removing unix fwd */
>      struct sockaddr_in host_addr = {
>          .sin_family = AF_INET,
> @@ -753,10 +752,10 @@ void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict)
>      const char *arg2 = qdict_get_try_str(qdict, "arg2");
>  
>      if (arg2) {
> -        s = slirp_lookup(mon, arg1);
> +        s = slirp_lookup(hmp, arg1);
>          src_str = arg2;
>      } else {
> -        s = slirp_lookup(mon, NULL);
> +        s = slirp_lookup(hmp, NULL);
>          src_str = arg1;
>      }
>      if (!s) {
> @@ -795,12 +794,12 @@ void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict)
>      err = slirp_remove_hostfwd(s->slirp, is_udp, host_addr.sin_addr, host_port);
>  #endif
>  
> -    monitor_printf(mon, "host forwarding rule for %s %s\n", src_str,
> -                   err ? "not found" : "removed");
> +    monitor_hmp_printf(hmp, "host forwarding rule for %s %s\n", src_str,
> +                       err ? "not found" : "removed");
>      return;
>  
>   fail_syntax:
> -    monitor_printf(mon, "invalid format\n");
> +    monitor_hmp_printf(hmp, "invalid format\n");
>  }
>  
>  static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
> @@ -960,17 +959,16 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
>  
>  void hmp_hostfwd_add(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *redir_str;
>      SlirpState *s;
>      const char *arg1 = qdict_get_str(qdict, "arg1");
>      const char *arg2 = qdict_get_try_str(qdict, "arg2");
>  
>      if (arg2) {
> -        s = slirp_lookup(mon, arg1);
> +        s = slirp_lookup(hmp, arg1);
>          redir_str = arg2;
>      } else {
> -        s = slirp_lookup(mon, NULL);
> +        s = slirp_lookup(hmp, NULL);
>          redir_str = arg1;
>      }
>      if (s) {
> @@ -1228,16 +1226,15 @@ UsernetInfoList *qmp_x_query_usernet(Error **errp)
>  
>  void hmp_info_usernet(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      g_autoptr(UsernetInfoList) list = NULL;
>      UsernetInfoList *entry;
>  
>      list = qmp_x_query_usernet(&error_abort);
>      for (entry = list; entry; entry = entry->next) {
>          UsernetInfo *ui = entry->value;
> -        monitor_printf(mon, "Hub %d (%s):\n%s",
> -                       ui->has_hub_id ? (int)ui->hub_id : -1,
> -                       ui->hub_name, ui->info);
> +        monitor_hmp_printf(hmp, "Hub %d (%s):\n%s",
> +                           ui->has_hub_id ? (int)ui->hub_id : -1,
> +                           ui->hub_name, ui->info);
>      }
>  }
>  
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index 2e2eb33371e2..bbf5980332a4 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -20,13 +20,12 @@
>  
>  void hmp_qom_list(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *path = qdict_get_try_str(qdict, "path");
>      ObjectPropertyInfoList *list;
>      Error *err = NULL;
>  
>      if (path == NULL) {
> -        monitor_printf(mon, "/\n");
> +        monitor_hmp_printf(hmp, "/\n");
>          return;
>      }
>  
> @@ -36,8 +35,8 @@ void hmp_qom_list(MonitorHMP *hmp, const QDict *qdict)
>          while (list != NULL) {
>              ObjectPropertyInfo *value = list->value;
>  
> -            monitor_printf(mon, "%s (%s)\n",
> -                           value->name, value->type);
> +            monitor_hmp_printf(hmp, "%s (%s)\n",
> +                               value->name, value->type);
>              list = list->next;
>          }
>          qapi_free_ObjectPropertyInfoList(start);
> @@ -75,7 +74,6 @@ void hmp_qom_set(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *path = qdict_get_str(qdict, "path");
>      const char *property = qdict_get_str(qdict, "property");
>      Error *err = NULL;
> @@ -83,7 +81,7 @@ void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict)
>  
>      if (err == NULL) {
>          GString *str = qobject_to_json_pretty(obj, true);
> -        monitor_printf(mon, "%s\n", str->str);
> +        monitor_hmp_printf(hmp, "%s\n", str->str);
>          g_string_free(str, true);
>      }
>  
> @@ -96,7 +94,7 @@ typedef struct QOMCompositionState {
>      int indent;
>  } QOMCompositionState;
>  
> -static void print_qom_composition(Monitor *mon, Object *obj, int indent);
> +static void print_qom_composition(MonitorHMP *hmp, Object *obj, int indent);
>  
>  static int qom_composition_compare(const void *a, const void *b)
>  {
> @@ -110,7 +108,7 @@ static int insert_qom_composition_child(Object *obj, void *opaque)
>      return 0;
>  }
>  
> -static void print_qom_composition(Monitor *mon, Object *obj, int indent)
> +static void print_qom_composition(MonitorHMP *hmp, Object *obj, int indent)
>  {
>      GArray *children = g_array_new(false, false, sizeof(Object *));
>      const char *name;
> @@ -121,14 +119,14 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>      } else {
>          name = object_get_canonical_path_component(obj);
>      }
> -    monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
> -                   object_get_typename(obj));
> +    monitor_hmp_printf(hmp, "%*s/%s (%s)\n", indent, "", name,
> +                       object_get_typename(obj));
>  
>      object_child_foreach(obj, insert_qom_composition_child, children);
>      g_array_sort(children, qom_composition_compare);
>  
>      for (i = 0; i < children->len; i++) {
> -        print_qom_composition(mon, g_array_index(children, Object *, i),
> +        print_qom_composition(hmp, g_array_index(children, Object *, i),
>                                indent + 2);
>      }
>      g_array_free(children, TRUE);
> @@ -136,7 +134,6 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>  
>  void hmp_info_qom_tree(MonitorHMP *hmp, const QDict *dict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *path = qdict_get_try_str(dict, "path");
>      Object *obj;
>      bool ambiguous = false;
> @@ -144,17 +141,17 @@ void hmp_info_qom_tree(MonitorHMP *hmp, const QDict *dict)
>      if (path) {
>          obj = object_resolve_path(path, &ambiguous);
>          if (!obj) {
> -            monitor_printf(mon, "Path '%s' could not be resolved.\n", path);
> +            monitor_hmp_printf(hmp, "Path '%s' could not be resolved.\n", path);
>              return;
>          }
>          if (ambiguous) {
> -            monitor_printf(mon, "Warning: Path '%s' is ambiguous.\n", path);
> +            monitor_hmp_printf(hmp, "Warning: Path '%s' is ambiguous.\n", path);
>              return;
>          }
>      } else {
>          obj = qdev_get_machine();
>      }
> -    print_qom_composition(mon, obj, 0);
> +    print_qom_composition(hmp, obj, 0);
>  }
>  
>  void hmp_object_add(MonitorHMP *hmp, const QDict *qdict)
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index ef69d23ff507..965565715ef2 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -33,11 +33,10 @@ bool replay_running_debug(void)
>  
>  void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      if (replay_mode == REPLAY_MODE_NONE) {
> -        monitor_printf(mon, "Record/replay is not active\n");
> +        monitor_hmp_printf(hmp, "Record/replay is not active\n");
>      } else {
> -        monitor_printf(mon,
> +        monitor_hmp_printf(hmp,
>              "%s execution '%s': instruction count = %"PRId64"\n",
>              replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
>              replay_get_filename(), replay_get_current_icount());
> diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
> index cd1f1deb58bc..3d556c745d61 100644
> --- a/stats/stats-hmp-cmds.c
> +++ b/stats/stats-hmp-cmds.c
> @@ -14,11 +14,11 @@
>  #include "qobject/qdict.h"
>  #include "qapi/error.h"
>  
> -static void print_stats_schema_value(Monitor *mon, StatsSchemaValue *value)
> +static void print_stats_schema_value(MonitorHMP *hmp, StatsSchemaValue *value)
>  {
>      const char *unit = NULL;
> -    monitor_printf(mon, "    %s (%s%s", value->name, StatsType_str(value->type),
> -                   value->has_unit || value->exponent ? ", " : "");
> +    monitor_hmp_printf(hmp, "    %s (%s%s", value->name, StatsType_str(value->type),
> +                       value->has_unit || value->exponent ? ", " : "");
>  
>      if (value->has_unit) {
>          if (value->unit == STATS_UNIT_SECONDS) {
> @@ -31,29 +31,29 @@ static void print_stats_schema_value(Monitor *mon, StatsSchemaValue *value)
>      if (unit && value->base == 10 &&
>          value->exponent >= -18 && value->exponent <= 18 &&
>          value->exponent % 3 == 0) {
> -        monitor_puts(mon, si_prefix(value->exponent));
> +        monitor_puts(MONITOR(hmp), si_prefix(value->exponent));
>      } else if (unit && value->base == 2 &&
>                 value->exponent >= 0 && value->exponent <= 60 &&
>                 value->exponent % 10 == 0) {
>  
> -        monitor_puts(mon, iec_binary_prefix(value->exponent));
> +        monitor_puts(MONITOR(hmp), iec_binary_prefix(value->exponent));
>      } else if (value->exponent) {
>          /* Use exponential notation and write the unit's English name */
> -        monitor_printf(mon, "* %d^%d%s",
> -                       value->base, value->exponent,
> -                       value->has_unit ? " " : "");
> +        monitor_hmp_printf(hmp, "* %d^%d%s",
> +                           value->base, value->exponent,
> +                           value->has_unit ? " " : "");
>          unit = NULL;
>      }
>  
>      if (value->has_unit) {
> -        monitor_puts(mon, unit ? unit : StatsUnit_str(value->unit));
> +        monitor_puts(MONITOR(hmp), unit ? unit : StatsUnit_str(value->unit));
>      }
>  
>      /* Print bucket size for linear histograms */
>      if (value->type == STATS_TYPE_LINEAR_HISTOGRAM && value->has_bucket_size) {
> -        monitor_printf(mon, ", bucket size=%d", value->bucket_size);
> +        monitor_hmp_printf(hmp, ", bucket size=%d", value->bucket_size);
>      }
> -    monitor_printf(mon, ")");
> +    monitor_hmp_printf(hmp, ")");
>  }
>  
>  static StatsSchemaValueList *find_schema_value_list(
> @@ -71,7 +71,7 @@ static StatsSchemaValueList *find_schema_value_list(
>      return NULL;
>  }
>  
> -static void print_stats_results(Monitor *mon, StatsTarget target,
> +static void print_stats_results(MonitorHMP *hmp, StatsTarget target,
>                                  bool show_provider,
>                                  StatsResult *result,
>                                  StatsSchemaList *schema)
> @@ -82,14 +82,14 @@ static void print_stats_results(Monitor *mon, StatsTarget target,
>      StatsList *stats_list;
>  
>      if (!schema_value_list) {
> -        monitor_printf(mon, "failed to find schema list for %s\n",
> -                       StatsProvider_str(result->provider));
> +        monitor_hmp_printf(hmp, "failed to find schema list for %s\n",
> +                           StatsProvider_str(result->provider));
>          return;
>      }
>  
>      if (show_provider) {
> -        monitor_printf(mon, "provider: %s\n",
> -                       StatsProvider_str(result->provider));
> +        monitor_hmp_printf(hmp, "provider: %s\n",
> +                           StatsProvider_str(result->provider));
>      }
>  
>      for (stats_list = result->stats; stats_list;
> @@ -103,31 +103,31 @@ static void print_stats_results(Monitor *mon, StatsTarget target,
>          /* Find schema entry */
>          while (!g_str_equal(stats->name, schema_value->name)) {
>              if (!schema_value_list->next) {
> -                monitor_printf(mon, "failed to find schema entry for %s\n",
> -                               stats->name);
> +                monitor_hmp_printf(hmp, "failed to find schema entry for %s\n",
> +                                   stats->name);
>                  return;
>              }
>              schema_value_list = schema_value_list->next;
>              schema_value = schema_value_list->value;
>          }
>  
> -        print_stats_schema_value(mon, schema_value);
> +        print_stats_schema_value(hmp, schema_value);
>  
>          if (stats_value->type == QTYPE_QNUM) {
> -            monitor_printf(mon, ": %" PRId64 "\n", stats_value->u.scalar);
> +            monitor_hmp_printf(hmp, ": %" PRId64 "\n", stats_value->u.scalar);
>          } else if (stats_value->type == QTYPE_QBOOL) {
> -            monitor_printf(mon, ": %s\n", stats_value->u.boolean ? "yes" : "no");
> +            monitor_hmp_printf(hmp, ": %s\n", stats_value->u.boolean ? "yes" : "no");
>          } else if (stats_value->type == QTYPE_QLIST) {
>              uint64List *list;
>              int i;
>  
> -            monitor_printf(mon, ": ");
> +            monitor_hmp_printf(hmp, ": ");
>              for (list = stats_value->u.list, i = 1;
>                   list;
>                   list = list->next, i++) {
> -                monitor_printf(mon, "[%d]=%" PRId64 " ", i, list->value);
> +                monitor_hmp_printf(hmp, "[%d]=%" PRId64 " ", i, list->value);
>              }
> -            monitor_printf(mon, "\n");
> +            monitor_hmp_printf(hmp, "\n");
>          }
>      }
>  }
> @@ -189,7 +189,6 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
>  
>  void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *target_str = qdict_get_str(qdict, "target");
>      const char *provider_str = qdict_get_try_str(qdict, "provider");
>      const char *names = qdict_get_try_str(qdict, "names");
> @@ -204,13 +203,13 @@ void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
>  
>      target = qapi_enum_parse(&StatsTarget_lookup, target_str, -1, &err);
>      if (err) {
> -        monitor_printf(mon, "invalid stats target %s\n", target_str);
> +        monitor_hmp_printf(hmp, "invalid stats target %s\n", target_str);
>          goto exit_no_print;
>      }
>      if (provider_str) {
>          provider = qapi_enum_parse(&StatsProvider_lookup, provider_str, -1, &err);
>          if (err) {
> -            monitor_printf(mon, "invalid stats provider %s\n", provider_str);
> +            monitor_hmp_printf(hmp, "invalid stats provider %s\n", provider_str);
>              goto exit_no_print;
>          }
>      }
> @@ -241,12 +240,12 @@ void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
>          goto exit;
>      }
>      for (entry = stats; entry; entry = entry->next) {
> -        print_stats_results(mon, target, provider_str == NULL, entry->value, schema);
> +        print_stats_results(hmp, target, provider_str == NULL, entry->value, schema);
>      }
>  
>  exit:
>      if (err) {
> -        monitor_printf(mon, "%s\n", error_get_pretty(err));
> +        monitor_hmp_printf(hmp, "%s\n", error_get_pretty(err));
>      }
>  exit_no_print:
>      error_free(err);
> diff --git a/stubs/hmp-cmd-info_sev.c b/stubs/hmp-cmd-info_sev.c
> index 6f2b87d1ad10..c9c1d10c165c 100644
> --- a/stubs/hmp-cmd-info_sev.c
> +++ b/stubs/hmp-cmd-info_sev.c
> @@ -12,6 +12,5 @@
>  
>  void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
> -    monitor_printf(mon, "SEV is not available in this QEMU\n");
> +    monitor_hmp_printf(hmp, "SEV is not available in this QEMU\n");
>  }
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index b0c7002bd406..094b80721003 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -17,7 +17,7 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
>  {
>  }
>  
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>  {
>      /*
>       * Pretend 'g_test_message' is our monitor console to
> diff --git a/system/dirtylimit-hmp-cmds.c b/system/dirtylimit-hmp-cmds.c
> index 75194add7931..fb9338e9aef6 100644
> --- a/system/dirtylimit-hmp-cmds.c
> +++ b/system/dirtylimit-hmp-cmds.c
> @@ -17,7 +17,6 @@
>  
>  void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
>      Error *err = NULL;
>  
> @@ -27,8 +26,8 @@ void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>  
> -    monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
> -                   "dirty limit for virtual CPU]\n");
> +    monitor_hmp_printf(hmp, "[Please use 'info vcpu_dirty_limit' to query "
> +                       "dirty limit for virtual CPU]\n");
>  }
>  
>  void hmp_set_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
> @@ -50,13 +49,12 @@ out:
>  
>  void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      DirtyLimitInfoList *info;
>      g_autoptr(DirtyLimitInfoList) head = NULL;
>      Error *err = NULL;
>  
>      if (!dirtylimit_in_service()) {
> -        monitor_printf(mon, "Dirty page limit not enabled!\n");
> +        monitor_hmp_printf(hmp, "Dirty page limit not enabled!\n");
>          return;
>      }
>  
> @@ -67,7 +65,7 @@ void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
>      }
>  
>      for (info = head; info != NULL; info = info->next) {
> -        monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
> +        monitor_hmp_printf(hmp, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
>                              " current rate %"PRIi64 " (MB/s)\n",
>                              info->value->cpu_index,
>                              info->value->limit_rate,
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 5c2de2f53cc9..3860ada2a237 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -763,9 +763,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>      return ret;
>  }
>  
> -#define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
> +#define qdev_printf(fmt, ...) \
> +    monitor_hmp_printf(hmp, "%*s" fmt, indent, "", ## __VA_ARGS__)
>  
> -static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
> +static void qdev_print_props(MonitorHMP *hmp, DeviceState *dev, DeviceClass *dc,
>                               int indent)
>  {
>      for (int i = 0, n = dc->props_count_; i < n; ++i) {
> @@ -798,8 +799,9 @@ static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int ind
>      }
>  }
>  
> -static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
> +static void qdev_print(MonitorHMP *hmp, DeviceState *dev, int indent)
>  {
> +    Monitor *mon = MONITOR(hmp);
>      ObjectClass *class;
>      NamedGPIOList *ngl;
>      NamedClockList *ncl;
> @@ -823,13 +825,13 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>      }
>      class = object_get_class(OBJECT(dev));
>      do {
> -        qdev_print_props(mon, dev, DEVICE_CLASS(class), indent);
> +        qdev_print_props(hmp, dev, DEVICE_CLASS(class), indent);
>          class = object_class_get_parent(class);
>      } while (class != object_class_by_name(TYPE_DEVICE));
>      bus_print_dev(dev->parent_bus, mon, dev, indent);
>  }
>  
> -static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
> +static void qbus_print(MonitorHMP *hmp, BusState *bus, int indent, bool details)
>  {
>      BusChild *kid;
>  
> @@ -842,10 +844,10 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
>          qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
>                      dev->id ? dev->id : "");
>          if (details) {
> -            qdev_print(mon, dev, indent + 2);
> +            qdev_print(hmp, dev, indent + 2);
>          }
>          QLIST_FOREACH(child_bus, &dev->child_bus, sibling) {
> -            qbus_print(mon, child_bus, indent + 2, details);
> +            qbus_print(hmp, child_bus, indent + 2, details);
>          }
>      }
>  }
> @@ -853,11 +855,10 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
>  
>  void hmp_info_qtree(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      bool details = !qdict_get_try_bool(qdict, "brief", false);
>  
>      if (sysbus_get_default()) {
> -        qbus_print(mon, sysbus_get_default(), 0, details);
> +        qbus_print(hmp, sysbus_get_default(), 0, details);
>      }
>  }
>  
> diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
> index 051ee45ee74c..ad70b53f8abf 100644
> --- a/system/runstate-hmp-cmds.c
> +++ b/system/runstate-hmp-cmds.c
> @@ -25,33 +25,31 @@
>  
>  void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      StatusInfo *info;
>  
>      info = qmp_query_status(NULL);
>  
> -    monitor_printf(mon, "VM status: %s",
> -                   info->running ? "running" : "paused");
> +    monitor_hmp_printf(hmp, "VM status: %s",
> +                       info->running ? "running" : "paused");
>  
>      if (!info->running && info->status != RUN_STATE_PAUSED) {
> -        monitor_printf(mon, " (%s)", RunState_str(info->status));
> +        monitor_hmp_printf(hmp, " (%s)", RunState_str(info->status));
>      }
>  
> -    monitor_printf(mon, "\n");
> +    monitor_hmp_printf(hmp, "\n");
>  
>      qapi_free_StatusInfo(info);
>  }
>  
>  void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *option = qdict_get_try_str(qdict, "option");
>      AccelState *accel = current_accel();
>      bool newval;
>  
>      if (!object_property_find(OBJECT(accel), "one-insn-per-tb")) {
> -        monitor_printf(mon,
> -                       "This accelerator does not support setting one-insn-per-tb\n");
> +        monitor_hmp_printf(hmp,
> +                           "This accelerator does not support setting one-insn-per-tb\n");
>          return;
>      }
>  
> @@ -60,7 +58,7 @@ void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
>      } else if (!strcmp(option, "off")) {
>          newval = false;
>      } else {
> -        monitor_printf(mon, "unexpected option %s\n", option);
> +        monitor_hmp_printf(hmp, "unexpected option %s\n", option);
>          return;
>      }
>      /* If the property exists then setting it can never fail */
> diff --git a/system/tpm-hmp-cmds.c b/system/tpm-hmp-cmds.c
> index 094c3f16cf50..35406e24d2c3 100644
> --- a/system/tpm-hmp-cmds.c
> +++ b/system/tpm-hmp-cmds.c
> @@ -13,7 +13,6 @@
>  
>  void hmp_info_tpm(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>  #ifdef CONFIG_TPM
>      TPMInfoList *info_list, *info;
>      Error *err = NULL;
> @@ -23,44 +22,44 @@ void hmp_info_tpm(MonitorHMP *hmp, const QDict *qdict)
>  
>      info_list = qmp_query_tpm(&err);
>      if (err) {
> -        monitor_printf(mon, "TPM device not supported\n");
> +        monitor_hmp_printf(hmp, "TPM device not supported\n");
>          error_free(err);
>          return;
>      }
>  
>      if (info_list) {
> -        monitor_printf(mon, "TPM device:\n");
> +        monitor_hmp_printf(hmp, "TPM device:\n");
>      }
>  
>      for (info = info_list; info; info = info->next) {
>          TPMInfo *ti = info->value;
> -        monitor_printf(mon, " tpm%d: model=%s\n",
> -                       c, TpmModel_str(ti->model));
> +        monitor_hmp_printf(hmp, " tpm%d: model=%s\n",
> +                           c, TpmModel_str(ti->model));
>  
> -        monitor_printf(mon, "  \\ %s: type=%s",
> -                       ti->id, TpmType_str(ti->options->type));
> +        monitor_hmp_printf(hmp, "  \\ %s: type=%s",
> +                           ti->id, TpmType_str(ti->options->type));
>  
>          switch (ti->options->type) {
>          case TPM_TYPE_PASSTHROUGH:
>              tpo = ti->options->u.passthrough.data;
> -            monitor_printf(mon, "%s%s%s%s",
> -                           tpo->path ? ",path=" : "",
> -                           tpo->path ?: "",
> -                           tpo->cancel_path ? ",cancel-path=" : "",
> -                           tpo->cancel_path ?: "");
> +            monitor_hmp_printf(hmp, "%s%s%s%s",
> +                               tpo->path ? ",path=" : "",
> +                               tpo->path ?: "",
> +                               tpo->cancel_path ? ",cancel-path=" : "",
> +                               tpo->cancel_path ?: "");
>              break;
>          case TPM_TYPE_EMULATOR:
>              teo = ti->options->u.emulator.data;
> -            monitor_printf(mon, ",chardev=%s", teo->chardev);
> +            monitor_hmp_printf(hmp, ",chardev=%s", teo->chardev);
>              break;
>          case TPM_TYPE__MAX:
>              break;
>          }
> -        monitor_printf(mon, "\n");
> +        monitor_hmp_printf(hmp, "\n");
>          c++;
>      }
>      qapi_free_TPMInfoList(info_list);
>  #else
> -    monitor_printf(mon, "TPM device not supported\n");
> +    monitor_hmp_printf(hmp, "TPM device not supported\n");
>  #endif /* CONFIG_TPM */
>  }
> diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
> index 3ae20f004b64..5d69ece15034 100644
> --- a/target/i386/cpu-apic.c
> +++ b/target/i386/cpu-apic.c
> @@ -82,7 +82,6 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
>  
>  void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUState *cs;
>  
>      if (qdict_haskey(qdict, "apic-id")) {
> @@ -98,7 +97,7 @@ void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
>  
>  
>      if (!cs) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>      x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 72bcab131f77..46762540ba65 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -48,27 +48,27 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>      return addr;
>  }
>  
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
>                        hwaddr pte, hwaddr mask)
>  {
>      addr = addr_canonical(env, addr);
>  
> -    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
> -                   " %c%c%c%c%c%c%c%c%c\n",
> -                   addr,
> -                   pte & mask,
> -                   pte & PG_NX_MASK ? 'X' : '-',
> -                   pte & PG_GLOBAL_MASK ? 'G' : '-',
> -                   pte & PG_PSE_MASK ? 'P' : '-',
> -                   pte & PG_DIRTY_MASK ? 'D' : '-',
> -                   pte & PG_ACCESSED_MASK ? 'A' : '-',
> -                   pte & PG_PCD_MASK ? 'C' : '-',
> -                   pte & PG_PWT_MASK ? 'T' : '-',
> -                   pte & PG_USER_MASK ? 'U' : '-',
> -                   pte & PG_RW_MASK ? 'W' : '-');
> +    monitor_hmp_printf(hmp, HWADDR_FMT_plx ": " HWADDR_FMT_plx
> +                       " %c%c%c%c%c%c%c%c%c\n",
> +                       addr,
> +                       pte & mask,
> +                       pte & PG_NX_MASK ? 'X' : '-',
> +                       pte & PG_GLOBAL_MASK ? 'G' : '-',
> +                       pte & PG_PSE_MASK ? 'P' : '-',
> +                       pte & PG_DIRTY_MASK ? 'D' : '-',
> +                       pte & PG_ACCESSED_MASK ? 'A' : '-',
> +                       pte & PG_PCD_MASK ? 'C' : '-',
> +                       pte & PG_PWT_MASK ? 'T' : '-',
> +                       pte & PG_USER_MASK ? 'U' : '-',
> +                       pte & PG_RW_MASK ? 'W' : '-');
>  }
>  
> -static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2;
> @@ -80,13 +80,13 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  /* 4M pages */
> -                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
> +                print_pte(hmp, env, (l1 << 22), pde, ~((1 << 21) - 1));
>              } else {
>                  for(l2 = 0; l2 < 1024; l2++) {
>                      pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
> +                        print_pte(hmp, env, (l1 << 22) + (l2 << 12),
>                                    pte & ~PG_PSE_MASK,
>                                    ~0xfff);
>                      }
> @@ -96,7 +96,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>      }
>  }
>  
> -static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2, l3;
> @@ -113,7 +113,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                  if (pde & PG_PRESENT_MASK) {
>                      if (pde & PG_PSE_MASK) {
>                          /* 2M pages with PAE, CR4.PSE is ignored */
> -                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
> +                        print_pte(hmp, env, (l1 << 30) + (l2 << 21), pde,
>                                    ~((hwaddr)(1 << 20) - 1));
>                      } else {
>                          pt_addr = pde & 0x3fffffffff000ULL;
> @@ -121,7 +121,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                              pte = address_space_ldq_le(as, pt_addr + l3 * 8,
>                                                         attrs, NULL);
>                              if (pte & PG_PRESENT_MASK) {
> -                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
> +                                print_pte(hmp, env, (l1 << 30) + (l2 << 21)
>                                            + (l3 << 12),
>                                            pte & ~PG_PSE_MASK,
>                                            ~(hwaddr)0xfff);
> @@ -135,7 +135,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>  }
>  
>  #ifdef TARGET_X86_64
> -static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
> +static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
>          uint64_t l0, uint64_t pml4_addr)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> @@ -158,7 +158,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>  
>              if (pdpe & PG_PSE_MASK) {
>                  /* 1G pages, CR4.PSE is ignored */
> -                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
> +                print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
>                          pdpe, 0x3ffffc0000000ULL);
>                  continue;
>              }
> @@ -172,7 +172,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>  
>                  if (pde & PG_PSE_MASK) {
>                      /* 2M pages, CR4.PSE is ignored */
> -                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
> +                    print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
>                              (l3 << 21), pde, 0x3ffffffe00000ULL);
>                      continue;
>                  }
> @@ -182,7 +182,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>                      pte = address_space_ldq_le(as, pt_addr + l4 * 8,
>                                                 attrs, NULL);
>                      if (pte & PG_PRESENT_MASK) {
> -                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
> +                        print_pte(hmp, env, (l0 << 48) + (l1 << 39) +
>                                  (l2 << 30) + (l3 << 21) + (l4 << 12),
>                                  pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
>                      }
> @@ -192,7 +192,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
>      }
>  }
>  
> -static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      uint64_t l0;
> @@ -203,7 +203,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>      for (l0 = 0; l0 < 512; l0++) {
>          pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
>          if (pml5e & PG_PRESENT_MASK) {
> -            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
> +            tlb_info_la48(hmp, env, as, l0, pml5e & 0x3fffffffff000ULL);
>          }
>      }
>  }
> @@ -211,18 +211,17 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env;
>      AddressSpace *as;
>  
>      env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
>      if (!(env->cr[0] & CR0_PG_MASK)) {
> -        monitor_printf(mon, "PG disabled\n");
> +        monitor_hmp_printf(hmp, "PG disabled\n");
>          return;
>      }
>      as = cpu_get_address_space(env_cpu(env), X86ASIdx_MEM);
> @@ -230,21 +229,21 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                tlb_info_la57(mon, env, as);
> +                tlb_info_la57(hmp, env, as);
>              } else {
> -                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
> +                tlb_info_la48(hmp, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
>              }
>          } else
>  #endif
>          {
> -            tlb_info_pae32(mon, env, as);
> +            tlb_info_pae32(hmp, env, as);
>          }
>      } else {
> -        tlb_info_32(mon, env, as);
> +        tlb_info_32(hmp, env, as);
>      }
>  }
>  
> -static void mem_print(Monitor *mon, CPUArchState *env,
> +static void mem_print(MonitorHMP *hmp, CPUArchState *env,
>                        hwaddr *pstart, int *plast_prot,
>                        hwaddr end, int prot)
>  {
> @@ -252,14 +251,14 @@ static void mem_print(Monitor *mon, CPUArchState *env,
>      prot1 = *plast_prot;
>      if (prot != prot1) {
>          if (*pstart != -1) {
> -            monitor_printf(mon, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
> -                           HWADDR_FMT_plx " %c%c%c\n",
> -                           addr_canonical(env, *pstart),
> -                           addr_canonical(env, end),
> -                           addr_canonical(env, end - *pstart),
> -                           prot1 & PG_USER_MASK ? 'u' : '-',
> -                           'r',
> -                           prot1 & PG_RW_MASK ? 'w' : '-');
> +            monitor_hmp_printf(hmp, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
> +                               HWADDR_FMT_plx " %c%c%c\n",
> +                               addr_canonical(env, *pstart),
> +                               addr_canonical(env, end),
> +                               addr_canonical(env, end - *pstart),
> +                               prot1 & PG_USER_MASK ? 'u' : '-',
> +                               'r',
> +                               prot1 & PG_RW_MASK ? 'w' : '-');
>          }
>          if (prot != 0)
>              *pstart = end;
> @@ -269,7 +268,7 @@ static void mem_print(Monitor *mon, CPUArchState *env,
>      }
>  }
>  
> -static void mem_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void mem_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2;
> @@ -286,7 +285,7 @@ static void mem_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  prot = pde & (PG_USER_MASK | PG_RW_MASK | PG_PRESENT_MASK);
> -                mem_print(mon, env, &start, &last_prot, end, prot);
> +                mem_print(hmp, env, &start, &last_prot, end, prot);
>              } else {
>                  for(l2 = 0; l2 < 1024; l2++) {
>                      pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
> @@ -298,19 +297,19 @@ static void mem_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                      } else {
>                          prot = 0;
>                      }
> -                    mem_print(mon, env, &start, &last_prot, end, prot);
> +                    mem_print(hmp, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot = 0;
> -            mem_print(mon, env, &start, &last_prot, end, prot);
> +            mem_print(hmp, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
> +    mem_print(hmp, env, &start, &last_prot, (hwaddr)1 << 32, 0);
>  }
>  
> -static void mem_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void mem_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      unsigned int l1, l2, l3;
> @@ -334,7 +333,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                      if (pde & PG_PSE_MASK) {
>                          prot = pde & (PG_USER_MASK | PG_RW_MASK |
>                                        PG_PRESENT_MASK);
> -                        mem_print(mon, env, &start, &last_prot, end, prot);
> +                        mem_print(hmp, env, &start, &last_prot, end, prot);
>                      } else {
>                          pt_addr = pde & 0x3fffffffff000ULL;
>                          for (l3 = 0; l3 < 512; l3++) {
> @@ -347,26 +346,26 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                              } else {
>                                  prot = 0;
>                              }
> -                            mem_print(mon, env, &start, &last_prot, end, prot);
> +                            mem_print(hmp, env, &start, &last_prot, end, prot);
>                          }
>                      }
>                  } else {
>                      prot = 0;
> -                    mem_print(mon, env, &start, &last_prot, end, prot);
> +                    mem_print(hmp, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot = 0;
> -            mem_print(mon, env, &start, &last_prot, end, prot);
> +            mem_print(hmp, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
> +    mem_print(hmp, env, &start, &last_prot, (hwaddr)1 << 32, 0);
>  }
>  
>  
>  #ifdef TARGET_X86_64
> -static void mem_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void mem_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      int prot, last_prot;
> @@ -390,7 +389,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                          prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
>                                         PG_PRESENT_MASK);
>                          prot &= pml4e;
> -                        mem_print(mon, env, &start, &last_prot, end, prot);
> +                        mem_print(hmp, env, &start, &last_prot, end, prot);
>                      } else {
>                          pd_addr = pdpe & 0x3fffffffff000ULL;
>                          for (l3 = 0; l3 < 512; l3++) {
> @@ -402,7 +401,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                                      prot = pde & (PG_USER_MASK | PG_RW_MASK |
>                                                    PG_PRESENT_MASK);
>                                      prot &= pml4e & pdpe;
> -                                    mem_print(mon, env, &start,
> +                                    mem_print(hmp, env, &start,
>                                                &last_prot, end, prot);
>                                  } else {
>                                      pt_addr = pde & 0x3fffffffff000ULL;
> @@ -420,32 +419,32 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                                          } else {
>                                              prot = 0;
>                                          }
> -                                        mem_print(mon, env, &start,
> +                                        mem_print(hmp, env, &start,
>                                                    &last_prot, end, prot);
>                                      }
>                                  }
>                              } else {
>                                  prot = 0;
> -                                mem_print(mon, env, &start,
> +                                mem_print(hmp, env, &start,
>                                            &last_prot, end, prot);
>                              }
>                          }
>                      }
>                  } else {
>                      prot = 0;
> -                    mem_print(mon, env, &start, &last_prot, end, prot);
> +                    mem_print(hmp, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot = 0;
> -            mem_print(mon, env, &start, &last_prot, end, prot);
> +            mem_print(hmp, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
> +    mem_print(hmp, env, &start, &last_prot, (hwaddr)1 << 48, 0);
>  }
>  
> -static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
> +static void mem_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
>  {
>      const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>      int prot, last_prot;
> @@ -461,7 +460,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>          end = l0 << 48;
>          if (!(pml5e & PG_PRESENT_MASK)) {
>              prot = 0;
> -            mem_print(mon, env, &start, &last_prot, end, prot);
> +            mem_print(hmp, env, &start, &last_prot, end, prot);
>              continue;
>          }
>  
> @@ -471,7 +470,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>              end = (l0 << 48) + (l1 << 39);
>              if (!(pml4e & PG_PRESENT_MASK)) {
>                  prot = 0;
> -                mem_print(mon, env, &start, &last_prot, end, prot);
> +                mem_print(hmp, env, &start, &last_prot, end, prot);
>                  continue;
>              }
>  
> @@ -481,7 +480,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                  end = (l0 << 48) + (l1 << 39) + (l2 << 30);
>                  if (pdpe & PG_PRESENT_MASK) {
>                      prot = 0;
> -                    mem_print(mon, env, &start, &last_prot, end, prot);
> +                    mem_print(hmp, env, &start, &last_prot, end, prot);
>                      continue;
>                  }
>  
> @@ -489,7 +488,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                      prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
>                              PG_PRESENT_MASK);
>                      prot &= pml5e & pml4e;
> -                    mem_print(mon, env, &start, &last_prot, end, prot);
> +                    mem_print(hmp, env, &start, &last_prot, end, prot);
>                      continue;
>                  }
>  
> @@ -500,7 +499,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                      end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
>                      if (pde & PG_PRESENT_MASK) {
>                          prot = 0;
> -                        mem_print(mon, env, &start, &last_prot, end, prot);
> +                        mem_print(hmp, env, &start, &last_prot, end, prot);
>                          continue;
>                      }
>  
> @@ -508,7 +507,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                          prot = pde & (PG_USER_MASK | PG_RW_MASK |
>                                  PG_PRESENT_MASK);
>                          prot &= pml5e & pml4e & pdpe;
> -                        mem_print(mon, env, &start, &last_prot, end, prot);
> +                        mem_print(hmp, env, &start, &last_prot, end, prot);
>                          continue;
>                      }
>  
> @@ -525,31 +524,30 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
>                          } else {
>                              prot = 0;
>                          }
> -                        mem_print(mon, env, &start, &last_prot, end, prot);
> +                        mem_print(hmp, env, &start, &last_prot, end, prot);
>                      }
>                  }
>              }
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
> +    mem_print(hmp, env, &start, &last_prot, (hwaddr)1 << 57, 0);
>  }
>  #endif /* TARGET_X86_64 */
>  
>  void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env;
>      AddressSpace *as;
>  
>      env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
>      if (!(env->cr[0] & CR0_PG_MASK)) {
> -        monitor_printf(mon, "PG disabled\n");
> +        monitor_hmp_printf(hmp, "PG disabled\n");
>          return;
>      }
>      as = cpu_get_address_space(env_cpu(env), X86ASIdx_MEM);
> @@ -557,17 +555,17 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>  #ifdef TARGET_X86_64
>          if (env->hflags & HF_LMA_MASK) {
>              if (env->cr[4] & CR4_LA57_MASK) {
> -                mem_info_la57(mon, env, as);
> +                mem_info_la57(hmp, env, as);
>              } else {
> -                mem_info_la48(mon, env, as);
> +                mem_info_la48(hmp, env, as);
>              }
>          } else
>  #endif
>          {
> -            mem_info_pae32(mon, env, as);
> +            mem_info_pae32(hmp, env, as);
>          }
>      } else {
> -        mem_info_32(mon, env, as);
> +        mem_info_32(hmp, env, as);
>      }
>  }
>  
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 4473d02981ff..36a62e58be95 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -756,33 +756,32 @@ SevInfo *qmp_query_sev(Error **errp)
>  
>  void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      SevInfo *info = sev_get_info();
>  
>      if (!info || !info->enabled) {
> -        monitor_printf(mon, "SEV is not enabled\n");
> +        monitor_hmp_printf(hmp, "SEV is not enabled\n");
>          goto out;
>      }
>  
> -    monitor_printf(mon, "SEV type: %s\n", SevGuestType_str(info->sev_type));
> -    monitor_printf(mon, "state: %s\n", SevState_str(info->state));
> -    monitor_printf(mon, "build: %d\n", info->build_id);
> -    monitor_printf(mon, "api version: %d.%d\n", info->api_major,
> -                   info->api_minor);
> +    monitor_hmp_printf(hmp, "SEV type: %s\n", SevGuestType_str(info->sev_type));
> +    monitor_hmp_printf(hmp, "state: %s\n", SevState_str(info->state));
> +    monitor_hmp_printf(hmp, "build: %d\n", info->build_id);
> +    monitor_hmp_printf(hmp, "api version: %d.%d\n", info->api_major,
> +                       info->api_minor);
>  
>      if (sev_snp_enabled()) {
> -        monitor_printf(mon, "debug: %s\n",
> -                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_DBG ? "on"
> -                                                                       : "off");
> -        monitor_printf(mon, "SMT allowed: %s\n",
> -                       info->u.sev_snp.snp_policy & SEV_SNP_POLICY_SMT ? "on"
> -                                                                       : "off");
> +        monitor_hmp_printf(hmp, "debug: %s\n",
> +                           info->u.sev_snp.snp_policy & SEV_SNP_POLICY_DBG ? "on"
> +                                                                           : "off");
> +        monitor_hmp_printf(hmp, "SMT allowed: %s\n",
> +                           info->u.sev_snp.snp_policy & SEV_SNP_POLICY_SMT ? "on"
> +                                                                           : "off");
>      } else {
> -        monitor_printf(mon, "handle: %d\n", info->u.sev.handle);
> -        monitor_printf(mon, "debug: %s\n",
> -                       info->u.sev.policy & SEV_POLICY_NODBG ? "off" : "on");
> -        monitor_printf(mon, "key-sharing: %s\n",
> -                       info->u.sev.policy & SEV_POLICY_NOKS ? "off" : "on");
> +        monitor_hmp_printf(hmp, "handle: %d\n", info->u.sev.handle);
> +        monitor_hmp_printf(hmp, "debug: %s\n",
> +                           info->u.sev.policy & SEV_POLICY_NODBG ? "off" : "on");
> +        monitor_hmp_printf(hmp, "key-sharing: %s\n",
> +                           info->u.sev.policy & SEV_POLICY_NOKS ? "off" : "on");
>      }
>  
>  out:
> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
> index 5645a5d4d4f5..23c25283b27a 100644
> --- a/target/m68k/monitor.c
> +++ b/target/m68k/monitor.c
> @@ -12,11 +12,10 @@
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index 5769829bdd7e..6e8a075f5a41 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -13,11 +13,10 @@
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>      dump_mmu(env1);
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 4c9c0c793b36..59cc04b3d0fb 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -51,13 +51,13 @@ static target_ulong addr_canonical(int va_bits, target_ulong addr)
>      return addr;
>  }
>  
> -static void print_pte_header(Monitor *mon)
> +static void print_pte_header(MonitorHMP *hmp)
>  {
> -    monitor_printf(mon, PTE_HEADER_FIELDS);
> -    monitor_printf(mon, PTE_HEADER_DELIMITER);
> +    monitor_hmp_printf(hmp, PTE_HEADER_FIELDS);
> +    monitor_hmp_printf(hmp, PTE_HEADER_DELIMITER);
>  }
>  
> -static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
> +static void print_pte(MonitorHMP *hmp, int va_bits, target_ulong vaddr,
>                        hwaddr paddr, target_ulong size, int attr)
>  {
>      /* sanity check on vaddr */
> @@ -69,20 +69,20 @@ static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
>          return;
>      }
>  
> -    monitor_printf(mon, TARGET_FMT_lx " " HWADDR_FMT_plx " " TARGET_FMT_lx
> -                   " %c%c%c%c%c%c%c\n",
> -                   addr_canonical(va_bits, vaddr),
> -                   paddr, size,
> -                   attr & PTE_R ? 'r' : '-',
> -                   attr & PTE_W ? 'w' : '-',
> -                   attr & PTE_X ? 'x' : '-',
> -                   attr & PTE_U ? 'u' : '-',
> -                   attr & PTE_G ? 'g' : '-',
> -                   attr & PTE_A ? 'a' : '-',
> -                   attr & PTE_D ? 'd' : '-');
> +    monitor_hmp_printf(hmp, TARGET_FMT_lx " " HWADDR_FMT_plx " " TARGET_FMT_lx
> +                       " %c%c%c%c%c%c%c\n",
> +                       addr_canonical(va_bits, vaddr),
> +                       paddr, size,
> +                       attr & PTE_R ? 'r' : '-',
> +                       attr & PTE_W ? 'w' : '-',
> +                       attr & PTE_X ? 'x' : '-',
> +                       attr & PTE_U ? 'u' : '-',
> +                       attr & PTE_G ? 'g' : '-',
> +                       attr & PTE_A ? 'a' : '-',
> +                       attr & PTE_D ? 'd' : '-');
>  }
>  
> -static void walk_pte(Monitor *mon, AddressSpace *as,
> +static void walk_pte(MonitorHMP *hmp, AddressSpace *as,
>                       hwaddr base, target_ulong start,
>                       int level, int ptidxbits, int ptesize, int va_bits,
>                       target_ulong *vbase, hwaddr *pbase, hwaddr *last_paddr,
> @@ -126,7 +126,7 @@ static void walk_pte(Monitor *mon, AddressSpace *as,
>                  if ((*last_attr != attr) ||
>                      (*last_paddr + *last_size != paddr) ||
>                      (last_start + *last_size != start)) {
> -                    print_pte(mon, va_bits, *vbase, *pbase,
> +                    print_pte(hmp, va_bits, *vbase, *pbase,
>                                *last_paddr + *last_size - *pbase, *last_attr);
>  
>                      *vbase = start;
> @@ -139,7 +139,7 @@ static void walk_pte(Monitor *mon, AddressSpace *as,
>                  *last_size = pgsize;
>              } else {
>                  /* pointer to the next level of the page table */
> -                walk_pte(mon, as, paddr, start, level - 1, ptidxbits, ptesize,
> +                walk_pte(hmp, as, paddr, start, level - 1, ptidxbits, ptesize,
>                           va_bits, vbase, pbase, last_paddr,
>                           last_size, last_attr);
>              }
> @@ -150,7 +150,7 @@ static void walk_pte(Monitor *mon, AddressSpace *as,
>  
>  }
>  
> -static void mem_info_svxx(Monitor *mon, CPUArchState *env)
> +static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
>  {
>      AddressSpace *as = env_cpu(env)->as;
>      int levels, ptidxbits, ptesize, vm, va_bits;
> @@ -198,7 +198,7 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
>      va_bits = PGSHIFT + levels * ptidxbits;
>  
>      /* print header */
> -    print_pte_header(mon);
> +    print_pte_header(hmp);
>  
>      vbase = -1;
>      pbase = -1;
> @@ -207,43 +207,42 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
>      last_attr = 0;
>  
>      /* walk page tables, starting from address 0 */
> -    walk_pte(mon, as, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
> +    walk_pte(hmp, as, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
>               &vbase, &pbase, &last_paddr, &last_size, &last_attr);
>  
>      /* don't forget the last one */
> -    print_pte(mon, va_bits, vbase, pbase,
> +    print_pte(hmp, va_bits, vbase, pbase,
>                last_paddr + last_size - pbase, last_attr);
>  }
>  
>  void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env;
>  
>      env = monitor_hmp_get_cpu_env(hmp);
>      if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
>      if (!riscv_cpu_cfg(env)->mmu) {
> -        monitor_printf(mon, "S-mode MMU unavailable\n");
> +        monitor_hmp_printf(hmp, "S-mode MMU unavailable\n");
>          return;
>      }
>  
>      if (riscv_cpu_mxl(env) == MXL_RV32) {
>          if (!(env->satp & SATP32_MODE)) {
> -            monitor_printf(mon, "No translation or protection\n");
> +            monitor_hmp_printf(hmp, "No translation or protection\n");
>              return;
>          }
>      } else {
>          if (!(env->satp & SATP64_MODE)) {
> -            monitor_printf(mon, "No translation or protection\n");
> +            monitor_hmp_printf(hmp, "No translation or protection\n");
>              return;
>          }
>      }
>  
> -    mem_info_svxx(mon, env);
> +    mem_info_svxx(hmp, env);
>  }
>  
>  #ifdef CONFIG_TCG
> diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
> index 4e443152bf56..62998a9a57cb 100644
> --- a/target/sh4/monitor.c
> +++ b/target/sh4/monitor.c
> @@ -26,33 +26,32 @@
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
>  
> -static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
> +static void print_tlb(MonitorHMP *hmp, int idx, tlb_t *tlb)
>  {
> -    monitor_printf(mon, " tlb%i:\t"
> -                   "asid=%hhu vpn=%x\tppn=%x\tsz=%hhu size=%u\t"
> -                   "v=%hhu shared=%hhu cached=%hhu prot=%hhu "
> -                   "dirty=%hhu writethrough=%hhu\n",
> -                   idx,
> -                   tlb->asid, tlb->vpn, tlb->ppn, tlb->sz, tlb->size,
> -                   tlb->v, tlb->sh, tlb->c, tlb->pr,
> -                   tlb->d, tlb->wt);
> +    monitor_hmp_printf(hmp, " tlb%i:\t"
> +                       "asid=%hhu vpn=%x\tppn=%x\tsz=%hhu size=%u\t"
> +                       "v=%hhu shared=%hhu cached=%hhu prot=%hhu "
> +                       "dirty=%hhu writethrough=%hhu\n",
> +                       idx,
> +                       tlb->asid, tlb->vpn, tlb->ppn, tlb->sz, tlb->size,
> +                       tlb->v, tlb->sh, tlb->c, tlb->pr,
> +                       tlb->d, tlb->wt);
>  }
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
>      int i;
>  
>      if (!env) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>  
> -    monitor_printf (mon, "ITLB:\n");
> +    monitor_hmp_printf(hmp, "ITLB:\n");
>      for (i = 0 ; i < ITLB_SIZE ; i++)
> -        print_tlb (mon, i, &env->itlb[i]);
> -    monitor_printf (mon, "UTLB:\n");
> +        print_tlb(hmp, i, &env->itlb[i]);
> +    monitor_hmp_printf(hmp, "UTLB:\n");
>      for (i = 0 ; i < UTLB_SIZE ; i++)
> -        print_tlb (mon, i, &env->utlb[i]);
> +        print_tlb(hmp, i, &env->utlb[i]);
>  }
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index e826e584a918..36f109cbb568 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -29,11 +29,10 @@
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>      dump_mmu(env1);
> diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
> index b7b7387706f3..b9c4089b0fb1 100644
> --- a/target/xtensa/monitor.c
> +++ b/target/xtensa/monitor.c
> @@ -28,11 +28,10 @@
>  
>  void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
>  
>      if (!env1) {
> -        monitor_printf(mon, "No CPU available\n");
> +        monitor_hmp_printf(hmp, "No CPU available\n");
>          return;
>      }
>      dump_mmu(env1);
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index b2a884529598..530a3fee3c13 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -75,7 +75,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>   */
>  Monitor *monitor_cur(void) { return cur_mon; }
>  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
> +int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap) { abort(); }
>  
>  #ifndef _WIN32
>  static void test_socket_fd_pass_name_good(void)
> diff --git a/tools/qemu-vnc/clipboard.c b/tools/qemu-vnc/clipboard.c
> index f62b2f294952..81a09ec5adfa 100644
> --- a/tools/qemu-vnc/clipboard.c
> +++ b/tools/qemu-vnc/clipboard.c
> @@ -62,7 +62,7 @@ vnc_dbus_clipboard_request_cancelled(VncDBusClipboardRequest *req)
>          "Cancelled clipboard request");
>  
>      g_clear_object(&req->invocation);
> -    g_clear_handle_id(&req->timeout_id, g_source_remove);;
> +    g_clear_handle_id(&req->timeout_id, g_source_remove);
>  }
>  
>  static gboolean
> @@ -137,7 +137,7 @@ vnc_dbus_clipboard_update_info(QemuClipboardInfo *info)
>          vnc_dbus_clipboard_complete_request(
>              req->invocation, info, req->type);
>          g_clear_object(&req->invocation);
> -        g_clear_handle_id(&req->timeout_id, g_source_remove);;
> +        g_clear_handle_id(&req->timeout_id, g_source_remove);
>          return;
>      }
>  
> diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
> index 26597fefaa99..0aa50a901d37 100644
> --- a/tools/qemu-vnc/stubs.c
> +++ b/tools/qemu-vnc/stubs.c
> @@ -42,7 +42,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return NULL;
>  }
>  
> -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
>  {
>      return -1;
>  }
> diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
> index 5a8158f4f4b6..a68f5b900d7c 100644
> --- a/trace/trace-hmp-cmds.c
> +++ b/trace/trace-hmp-cmds.c
> @@ -49,7 +49,6 @@ void hmp_trace_event(MonitorHMP *hmp, const QDict *qdict)
>  #ifdef CONFIG_TRACE_SIMPLE
>  void hmp_trace_file(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *op = qdict_get_try_str(qdict, "op");
>      const char *arg = qdict_get_try_str(qdict, "arg");
>  
> @@ -66,15 +65,14 @@ void hmp_trace_file(MonitorHMP *hmp, const QDict *qdict)
>              st_set_trace_file(arg);
>          }
>      } else {
> -        monitor_printf(mon, "unexpected argument \"%s\"\n", op);
> -        hmp_help_cmd(mon, "trace-file");
> +        monitor_hmp_printf(hmp, "unexpected argument \"%s\"\n", op);
> +        hmp_help_cmd(hmp, "trace-file");
>      }
>  }
>  #endif
>  
>  void hmp_info_trace_events(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *name = qdict_get_try_str(qdict, "name");
>      TraceEventInfoList *events;
>      TraceEventInfoList *elem;
> @@ -91,9 +89,9 @@ void hmp_info_trace_events(MonitorHMP *hmp, const QDict *qdict)
>      }
>  
>      for (elem = events; elem != NULL; elem = elem->next) {
> -        monitor_printf(mon, "%s : state %u\n",
> -                       elem->value->name,
> -                       elem->value->state == TRACE_EVENT_STATE_ENABLED ? 1 : 0);
> +        monitor_hmp_printf(hmp, "%s : state %u\n",
> +                           elem->value->name,
> +                           elem->value->state == TRACE_EVENT_STATE_ENABLED ? 1 : 0);
>      }
>      qapi_free_TraceEventInfoList(events);
>  }
> diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
> index 186209fd0234..f611dd7ee457 100644
> --- a/ui/ui-hmp-cmds.c
> +++ b/ui/ui-hmp-cmds.c
> @@ -81,20 +81,19 @@ void hmp_mouse_set(MonitorHMP *hmp, const QDict *qdict)
>  
>  void hmp_info_mice(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      MouseInfoList *mice_list, *mouse;
>  
>      mice_list = qmp_query_mice(NULL);
>      if (!mice_list) {
> -        monitor_printf(mon, "No mouse devices connected\n");
> +        monitor_hmp_printf(hmp, "No mouse devices connected\n");
>          return;
>      }
>  
>      for (mouse = mice_list; mouse; mouse = mouse->next) {
> -        monitor_printf(mon, "%c Mouse #%" PRId64 ": %s%s\n",
> -                       mouse->value->current ? '*' : ' ',
> -                       mouse->value->index, mouse->value->name,
> -                       mouse->value->absolute ? " (absolute)" : "");
> +        monitor_hmp_printf(hmp, "%c Mouse #%" PRId64 ": %s%s\n",
> +                           mouse->value->current ? '*' : ' ',
> +                           mouse->value->index, mouse->value->name,
> +                           mouse->value->absolute ? " (absolute)" : "");
>      }
>  
>      qapi_free_MouseInfoList(mice_list);
> @@ -102,48 +101,48 @@ void hmp_info_mice(MonitorHMP *hmp, const QDict *qdict)
>  
>  #ifdef CONFIG_VNC
>  /* Helper for hmp_info_vnc_clients, _servers */
> -static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
> +static void hmp_info_VncBasicInfo(MonitorHMP *hmp, VncBasicInfo *info,
>                                    const char *name)
>  {
> -    monitor_printf(mon, "  %s: %s:%s (%s%s)\n",
> -                   name,
> -                   info->host,
> -                   info->service,
> -                   NetworkAddressFamily_str(info->family),
> -                   info->websocket ? " (Websocket)" : "");
> +    monitor_hmp_printf(hmp, "  %s: %s:%s (%s%s)\n",
> +                       name,
> +                       info->host,
> +                       info->service,
> +                       NetworkAddressFamily_str(info->family),
> +                       info->websocket ? " (Websocket)" : "");
>  }
>  
>  /* Helper displaying and auth and crypt info */
> -static void hmp_info_vnc_authcrypt(Monitor *mon, const char *indent,
> +static void hmp_info_vnc_authcrypt(MonitorHMP *hmp, const char *indent,
>                                     VncPrimaryAuth auth,
>                                     VncVencryptSubAuth *vencrypt)
>  {
> -    monitor_printf(mon, "%sAuth: %s (Sub: %s)\n", indent,
> -                   VncPrimaryAuth_str(auth),
> -                   vencrypt ? VncVencryptSubAuth_str(*vencrypt) : "none");
> +    monitor_hmp_printf(hmp, "%sAuth: %s (Sub: %s)\n", indent,
> +                       VncPrimaryAuth_str(auth),
> +                       vencrypt ? VncVencryptSubAuth_str(*vencrypt) : "none");
>  }
>  
> -static void hmp_info_vnc_clients(Monitor *mon, VncClientInfoList *client)
> +static void hmp_info_vnc_clients(MonitorHMP *hmp, VncClientInfoList *client)
>  {
>      while (client) {
>          VncClientInfo *cinfo = client->value;
>  
> -        hmp_info_VncBasicInfo(mon, qapi_VncClientInfo_base(cinfo), "Client");
> -        monitor_printf(mon, "    x509_dname: %s\n",
> -                       cinfo->x509_dname ?: "none");
> -        monitor_printf(mon, "    sasl_username: %s\n",
> -                       cinfo->sasl_username ?: "none");
> +        hmp_info_VncBasicInfo(hmp, qapi_VncClientInfo_base(cinfo), "Client");
> +        monitor_hmp_printf(hmp, "    x509_dname: %s\n",
> +                           cinfo->x509_dname ?: "none");
> +        monitor_hmp_printf(hmp, "    sasl_username: %s\n",
> +                           cinfo->sasl_username ?: "none");
>  
>          client = client->next;
>      }
>  }
>  
> -static void hmp_info_vnc_servers(Monitor *mon, VncServerInfo2List *server)
> +static void hmp_info_vnc_servers(MonitorHMP *hmp, VncServerInfo2List *server)
>  {
>      while (server) {
>          VncServerInfo2 *sinfo = server->value;
> -        hmp_info_VncBasicInfo(mon, qapi_VncServerInfo2_base(sinfo), "Server");
> -        hmp_info_vnc_authcrypt(mon, "    ", sinfo->auth,
> +        hmp_info_VncBasicInfo(hmp, qapi_VncServerInfo2_base(sinfo), "Server");
> +        hmp_info_vnc_authcrypt(hmp, "    ", sinfo->auth,
>                                 sinfo->has_vencrypt ? &sinfo->vencrypt : NULL);
>          server = server->next;
>      }
> @@ -151,7 +150,6 @@ static void hmp_info_vnc_servers(Monitor *mon, VncServerInfo2List *server)
>  
>  void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      VncInfo2List *info2l, *info2l_head;
>      Error *err = NULL;
>  
> @@ -161,26 +159,26 @@ void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict)
>          return;
>      }
>      if (!info2l) {
> -        monitor_printf(mon, "None\n");
> +        monitor_hmp_printf(hmp, "None\n");
>          return;
>      }
>  
>      while (info2l) {
>          VncInfo2 *info = info2l->value;
> -        monitor_printf(mon, "%s:\n", info->id);
> -        hmp_info_vnc_servers(mon, info->server);
> -        hmp_info_vnc_clients(mon, info->clients);
> +        monitor_hmp_printf(hmp, "%s:\n", info->id);
> +        hmp_info_vnc_servers(hmp, info->server);
> +        hmp_info_vnc_clients(hmp, info->clients);
>          if (!info->server) {
>              /*
>               * The server entry displays its auth, we only need to
>               * display in the case of 'reverse' connections where
>               * there's no server.
>               */
> -            hmp_info_vnc_authcrypt(mon, "  ", info->auth,
> +            hmp_info_vnc_authcrypt(hmp, "  ", info->auth,
>                                 info->has_vencrypt ? &info->vencrypt : NULL);
>          }
>          if (info->display) {
> -            monitor_printf(mon, "  Display: %s\n", info->display);
> +            monitor_hmp_printf(hmp, "  Display: %s\n", info->display);
>          }
>          info2l = info2l->next;
>      }
> @@ -193,7 +191,6 @@ void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict)
>  #ifdef CONFIG_SPICE
>  void hmp_info_spice(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      SpiceChannelList *chan;
>      SpiceInfo *info;
>      const char *channel_name;
> @@ -214,38 +211,38 @@ void hmp_info_spice(MonitorHMP *hmp, const QDict *qdict)
>      info = qmp_query_spice(NULL);
>  
>      if (!info->enabled) {
> -        monitor_printf(mon, "Server: disabled\n");
> +        monitor_hmp_printf(hmp, "Server: disabled\n");
>          goto out;
>      }
>  
> -    monitor_printf(mon, "Server:\n");
> +    monitor_hmp_printf(hmp, "Server:\n");
>      if (info->has_port) {
> -        monitor_printf(mon, "     address: %s:%" PRId64 "\n",
> -                       info->host, info->port);
> +        monitor_hmp_printf(hmp, "     address: %s:%" PRId64 "\n",
> +                           info->host, info->port);
>      }
>      if (info->has_tls_port) {
> -        monitor_printf(mon, "     address: %s:%" PRId64 " [tls]\n",
> -                       info->host, info->tls_port);
> +        monitor_hmp_printf(hmp, "     address: %s:%" PRId64 " [tls]\n",
> +                           info->host, info->tls_port);
>      }
> -    monitor_printf(mon, "    migrated: %s\n",
> -                   info->migrated ? "true" : "false");
> -    monitor_printf(mon, "        auth: %s\n", info->auth);
> -    monitor_printf(mon, "    compiled: %s\n", info->compiled_version);
> -    monitor_printf(mon, "  mouse-mode: %s\n",
> -                   SpiceQueryMouseMode_str(info->mouse_mode));
> +    monitor_hmp_printf(hmp, "    migrated: %s\n",
> +                       info->migrated ? "true" : "false");
> +    monitor_hmp_printf(hmp, "        auth: %s\n", info->auth);
> +    monitor_hmp_printf(hmp, "    compiled: %s\n", info->compiled_version);
> +    monitor_hmp_printf(hmp, "  mouse-mode: %s\n",
> +                       SpiceQueryMouseMode_str(info->mouse_mode));
>  
>      if (!info->has_channels || info->channels == NULL) {
> -        monitor_printf(mon, "Channels: none\n");
> +        monitor_hmp_printf(hmp, "Channels: none\n");
>      } else {
>          for (chan = info->channels; chan; chan = chan->next) {
> -            monitor_printf(mon, "Channel:\n");
> -            monitor_printf(mon, "     address: %s:%s%s\n",
> -                           chan->value->host, chan->value->port,
> -                           chan->value->tls ? " [tls]" : "");
> -            monitor_printf(mon, "     session: %" PRId64 "\n",
> -                           chan->value->connection_id);
> -            monitor_printf(mon, "     channel: %" PRId64 ":%" PRId64 "\n",
> -                           chan->value->channel_type, chan->value->channel_id);
> +            monitor_hmp_printf(hmp, "Channel:\n");
> +            monitor_hmp_printf(hmp, "     address: %s:%s%s\n",
> +                               chan->value->host, chan->value->port,
> +                               chan->value->tls ? " [tls]" : "");
> +            monitor_hmp_printf(hmp, "     session: %" PRId64 "\n",
> +                               chan->value->connection_id);
> +            monitor_hmp_printf(hmp, "     channel: %" PRId64 ":%" PRId64 "\n",
> +                               chan->value->channel_type, chan->value->channel_id);
>  
>              channel_name = "unknown";
>              if (chan->value->channel_type > 0 &&
> @@ -254,7 +251,7 @@ void hmp_info_spice(MonitorHMP *hmp, const QDict *qdict)
>                  channel_name = channel_names[chan->value->channel_type];
>              }
>  
> -            monitor_printf(mon, "     channel name: %s\n", channel_name);
> +            monitor_hmp_printf(hmp, "     channel name: %s\n", channel_name);
>          }
>      }
>  
> @@ -333,7 +330,7 @@ static void hmp_change_read_arg(void *opaque, const char *password,
>      monitor_hmp_read_command(opaque, 1);
>  }
>  
> -void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
> +void hmp_change_vnc(MonitorHMP *hmp, const char *device, const char *target,
>                      const char *arg, const char *read_only, bool force,
>                      Error **errp)
>  {
> @@ -346,7 +343,6 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
>          return;
>      }
>      if (!arg) {
> -        MonitorHMP *hmp = MONITOR_HMP(mon);
>          monitor_hmp_read_password(hmp, hmp_change_read_arg, NULL);
>      } else {
>          qmp_change_vnc_password(arg, errp);
> @@ -371,7 +367,6 @@ static int index_from_key(const char *key, size_t key_length)
>  
>  void hmp_sendkey(MonitorHMP *hmp, const QDict *qdict)
>  {
> -    Monitor *mon = MONITOR(hmp);
>      const char *keys = qdict_get_str(qdict, "keys");
>      KeyValue *v = NULL;
>      KeyValueList *head = NULL, **tail = &head;
> @@ -432,7 +427,7 @@ out:
>      return;
>  
>  err_out:
> -    monitor_printf(mon, "invalid parameter: %.*s\n", keyname_len, keys);
> +    monitor_hmp_printf(hmp, "invalid parameter: %.*s\n", keyname_len, keys);
>      goto out;
>  }
>  
> diff --git a/util/error-report.c b/util/error-report.c
> index 70cbd174ffae..c20e157780fa 100644
> --- a/util/error-report.c
> +++ b/util/error-report.c
> @@ -38,7 +38,7 @@ error_vprintf_mon(const char *fmt, va_list ap)
>      MonitorHMP *hmp = monitor_cur_hmp();
>  
>      if (hmp) {
> -        return monitor_vprintf(MONITOR(hmp), fmt, ap);
> +        return monitor_hmp_vprintf(hmp, fmt, ap);
>      }
>  
>      return vfprintf(stderr, fmt, ap);
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> index 0eecc05b0330..aabe670fda01 100644
> --- a/util/qemu-print.c
> +++ b/util/qemu-print.c
> @@ -23,7 +23,7 @@ int qemu_vprintf(const char *fmt, va_list ap)
>  {
>      MonitorHMP *hmp = monitor_cur_hmp();
>      if (hmp) {
> -        return monitor_vprintf(MONITOR(hmp), fmt, ap);
> +        return monitor_hmp_vprintf(hmp, fmt, ap);
>      }
>      return vprintf(fmt, ap);
>  }
> @@ -54,7 +54,7 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
>  {
>      if (!stream) {
>          MonitorHMP *hmp = monitor_cur_hmp();
> -        return hmp ? monitor_vprintf(MONITOR(hmp), fmt, ap) : -1;
> +        return hmp ? monitor_hmp_vprintf(hmp, fmt, ap) : -1;
>      }
>      return vfprintf(stream, fmt, ap);
>  }
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
