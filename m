Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CD399340
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787949850; cv=none; b=uPDm5YJpdV3dfDqXslIcPGC8i0yGS1yPWwc1TUBzciTRjGKn3ofkKzUoVLnD4QrS6XCMy4f7ja1RR8dtRBsTRkZylY82BbisIripcihCsb3z4OQjDygafXNpmWyY4Uxt2/MFXjMwGUWptm3dBA6qL7VTHNObXQdoIUyJv2eJth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787949850; c=relaxed/simple;
	bh=yn6dyABfVLQUK2T3OLQkYLf2GR4UFPHk72clDER1lFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOgpnVISmJtu4wR7KGiI0UdkAYqLATKxfNeSlm2tCiRvxVgCSu7x4EwfuAd96vLYzAmiF1GPSWt6tEXBPys1u+yuNijKghC82R9qX4sv2EuyNK5fC+MWnI7krQZleOTe2wpaYY4LuGAX2lWG+bkzTTyUUcqd8ZvCUhZoXWne/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsUkllUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsUkllUy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787949844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFoxPtLu3Ck35QSCzEloxQU1yiQKuRhEpzYxa4Nk+fU=;
	b=DsUkllUyNYjElBHcRxQb903UEUUKyoBtdrbxuAZ9IXcmb3Mj5GPS3KIptMc/ygYrtylTMk
	l6ISbwJwLwV5yXnNOsw10q+G82JWxuBjRNyuO6jBl5xegOSjJBQmNnTOgleuc097SUApEa
	wyCHgvEyyreUayoWOy5Mybq5nUvrBng=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-5wIVm95oOJq-xu2dbm6biA-1; Fri,
 28 Aug 2026 16:43:59 -0400
X-MC-Unique: 5wIVm95oOJq-xu2dbm6biA-1
X-Mimecast-MFC-AGG-ID: 5wIVm95oOJq-xu2dbm6biA_1787949835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 992BD1907BF8;
	Fri, 28 Aug 2026 20:43:53 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46D1F18001CF;
	Fri, 28 Aug 2026 20:43:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:10 +0400
Subject: [GIT PULL 31/50] monitor: change HMPCommand cmd to take MonitorHMP
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-31-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=108582;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yn6dyABfVLQUK2T3OLQkYLf2GR4UFPHk72clDER1lFk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVcLtKrqfa1qYX8VwvBmzMD/nH6mb0vVJ72
 dWyXvYwox2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5XOaEACrWUiMhg9BAgldQi8map/Yf7+1Z5btlC+1b9RxA/P3GQs8UrfVbQCapgj5lJXihrJvQqG
 0sIRHgdaT7Z4QQQZ7R0V8FZ/7/7AwbmdfbXRC68zDdV2Ek2BPh2WoHo6hBct9lgYb0t2sn+8UHl
 YyPlaaHmRD1BF8KmgFGl09FTjBgz1R7n5Q0lh8yWCT/tROR8FEMZ97uS5FHph5k8Mnv4c6R7Cpa
 B670RYC8fQMSG94KqUIoOQ3LCt+IEiUkDJcrASdeMipuW/Livv3DVBGMTWF9DawGiaPYpgorIVK
 ZEFpyshNyyXJyzL5TzS57sdgKpvBWfbZ91s0Q+NOycCKzgQXycFLBLEMmWAxcLDS4SD6jNlfGRl
 JZsYhTvF05V5ILZNGkfRYgMgindBYTgryD6keuIyKjFyJZEjBhzbOOWuww/3L5rBFfsgzp2O26U
 q5MrsDUSh6gK9NKgHVLB8+7NhK2rVePxD/ltV/k2tTKJUymVH1ZFQKH721yoglMDLjCc9KakWzw
 BqaWZrm9nU59ERg6GnCA4jyq+kP+kdMoGaHYHms/wp61XBkq8exX+ubAIm64jtFHXcPDd3kc0CG
 f9LO0Aq98O32KGW7pZ3maQLXgpDuSRfIFOIS+hh7Fe9hOxf4u8Z3ufYDH91kQ7LNT6dTw9b2crx
 I8qKDjZzL843R3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

HMP commands are specific to the HMP monitor, so make the cmd function
pointer in HMPCommand take MonitorHMP * instead of Monitor *. This
strengthens type safety and makes the HMP-specific nature of these
handlers explicit.

Handler functions are renamed to take MonitorHMP *hmp, with a local
Monitor *mon = MONITOR(hmp) added where the body needs the base type.
Following patches will drop it, since most functions are HMP specific.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-31-9227de146347@redhat.com>
---
 audio/audio-hmp-cmds.c          |   8 +-
 backends/cryptodev-hmp-cmds.c   |   3 +-
 block/monitor/block-hmp-cmds.c  |  78 +++++++----
 chardev/char-hmp-cmds.c         |  21 ++-
 dump/dump-hmp-cmds.c            |   6 +-
 hw/core/machine-hmp-cmds.c      |  49 ++++---
 hw/i386/kvm/xen-stubs.c         |   6 +-
 hw/i386/kvm/xen_evtchn.c        |   6 +-
 hw/i386/sgx-hmp-stub.c          |   3 +-
 hw/i386/sgx.c                   |   3 +-
 hw/misc/mos6522-stub.c          |   3 +-
 hw/misc/mos6522.c               |   3 +-
 hw/net/rocker/rocker-hmp-cmds.c |  12 +-
 hw/pci/pci-hmp-cmds.c           |   6 +-
 hw/pci/pci-stub.c               |   5 +-
 hw/s390x/s390-skeys.c           |   5 +-
 hw/s390x/s390-stattrib.c        |   6 +-
 hw/uefi/ovmf-log.c              |   3 +-
 hw/usb/host-libusb.c            |   3 +-
 hw/virtio/virtio-hmp-cmds.c     |  15 +-
 include/block/block-hmp-cmds.h  |  55 ++++----
 include/hw/usb/usb.h            |   3 +-
 include/monitor/hmp.h           | 294 ++++++++++++++++++++--------------------
 include/monitor/qdev.h          |   5 +-
 include/net/net.h               |   5 +-
 include/net/slirp.h             |   8 +-
 migration/dirtyrate.c           |   6 +-
 migration/migration-hmp-cmds.c  |  48 ++++---
 monitor/hmp-cmds.c              |  96 ++++++++-----
 monitor/hmp.c                   |  17 ++-
 monitor/monitor-internal.h      |   2 +-
 net/net-hmp-cmds.c              |  14 +-
 net/slirp.c                     |   9 +-
 qom/qom-hmp-cmds.c              |  18 ++-
 replay/replay-debugging.c       |   9 +-
 replay/stubs-system.c           |   8 +-
 stats/stats-hmp-cmds.c          |   3 +-
 stubs/hmp-cmd-info_sev.c        |   3 +-
 system/dirtylimit-hmp-cmds.c    |   9 +-
 system/qdev-monitor.c           |  11 +-
 system/runstate-hmp-cmds.c      |   9 +-
 system/tpm-hmp-cmds.c           |   3 +-
 target/i386/cpu-apic.c          |   3 +-
 target/i386/monitor.c           |   9 +-
 target/i386/sev.c               |   3 +-
 target/m68k/monitor.c           |   3 +-
 target/ppc/monitor.c            |   3 +-
 target/riscv/monitor.c          |   3 +-
 target/sh4/monitor.c            |   3 +-
 target/sparc/monitor.c          |   3 +-
 target/xtensa/monitor.c         |   3 +-
 trace/trace-hmp-cmds.c          |   8 +-
 ui/ui-hmp-cmds.c                |  31 +++--
 53 files changed, 561 insertions(+), 390 deletions(-)

diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index 1ffb5ebc7420..4d326ec99fdf 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -32,8 +32,9 @@
 
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
 
-void hmp_info_capture(Monitor *mon, const QDict *qdict)
+void hmp_info_capture(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int i;
     CaptureState *s;
 
@@ -45,7 +46,7 @@ void hmp_info_capture(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_stopcapture(Monitor *mon, const QDict *qdict)
+void hmp_stopcapture(MonitorHMP *hmp, const QDict *qdict)
 {
     int i;
     int n = qdict_get_int(qdict, "n");
@@ -63,8 +64,9 @@ void hmp_stopcapture(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_wavcapture(Monitor *mon, const QDict *qdict)
+void hmp_wavcapture(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *path = qdict_get_str(qdict, "path");
     int freq = qdict_get_try_int(qdict, "freq", 44100);
     int bits = qdict_get_try_int(qdict, "bits", 16);
diff --git a/backends/cryptodev-hmp-cmds.c b/backends/cryptodev-hmp-cmds.c
index 01396d227c88..fb62428d795a 100644
--- a/backends/cryptodev-hmp-cmds.c
+++ b/backends/cryptodev-hmp-cmds.c
@@ -17,8 +17,9 @@
 #include "qobject/qdict.h"
 
 
-void hmp_info_cryptodev(Monitor *mon, const QDict *qdict)
+void hmp_info_cryptodev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     QCryptodevInfoList *il;
     QCryptodevBackendServiceTypeList *sl;
     QCryptodevBackendClientList *cl;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 22fa03089ea3..3914b5189d56 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -87,8 +87,9 @@ out:
     hmp_handle_error(mon, err);
 }
 
-void hmp_drive_add(Monitor *mon, const QDict *qdict)
+void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     DriveInfo *dinfo;
     QemuOpts *opts;
@@ -135,8 +136,9 @@ err:
     hmp_handle_error(mon, err);
 }
 
-void hmp_drive_del(Monitor *mon, const QDict *qdict)
+void hmp_drive_del(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -194,8 +196,9 @@ unlock:
     hmp_handle_error(mon, err);
 }
 
-void hmp_commit(Monitor *mon, const QDict *qdict)
+void hmp_commit(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     BlockBackend *blk;
     int ret;
@@ -232,8 +235,9 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
+void hmp_drive_mirror(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "target");
     const char *format = qdict_get_try_str(qdict, "format");
     bool reuse = qdict_get_try_bool(qdict, "reuse", false);
@@ -258,8 +262,9 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_drive_backup(Monitor *mon, const QDict *qdict)
+void hmp_drive_backup(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *filename = qdict_get_str(qdict, "target");
     const char *format = qdict_get_try_str(qdict, "format");
@@ -288,8 +293,9 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
+void hmp_block_job_set_speed(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     int64_t value = qdict_get_int(qdict, "speed");
@@ -299,8 +305,9 @@ void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_block_job_cancel(Monitor *mon, const QDict *qdict)
+void hmp_block_job_cancel(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     bool force = qdict_get_try_bool(qdict, "force", false);
@@ -310,8 +317,9 @@ void hmp_block_job_cancel(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_block_job_pause(Monitor *mon, const QDict *qdict)
+void hmp_block_job_pause(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
@@ -320,8 +328,9 @@ void hmp_block_job_pause(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_block_job_resume(Monitor *mon, const QDict *qdict)
+void hmp_block_job_resume(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
@@ -330,8 +339,9 @@ void hmp_block_job_resume(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
+void hmp_block_job_complete(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
 
@@ -340,8 +350,9 @@ void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
+void hmp_snapshot_blkdev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *filename = qdict_get_str(qdict, "snapshot-file");
     const char *format = qdict_get_try_str(qdict, "format");
@@ -355,8 +366,9 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
+void hmp_snapshot_blkdev_internal(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
@@ -365,8 +377,9 @@ void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
+void hmp_snapshot_delete_blkdev_internal(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_str(qdict, "name");
     const char *id = qdict_get_try_str(qdict, "id");
@@ -376,8 +389,9 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
+void hmp_nbd_server_start(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *uri = qdict_get_str(qdict, "uri");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     bool all = qdict_get_try_bool(qdict, "all", false);
@@ -438,8 +452,9 @@ exit:
     hmp_handle_error(mon, local_err);
 }
 
-void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
+void hmp_nbd_server_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *name = qdict_get_try_str(qdict, "name");
     bool writable = qdict_get_try_bool(qdict, "writable", false);
@@ -456,8 +471,9 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, local_err);
 }
 
-void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
+void hmp_nbd_server_remove(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_str(qdict, "name");
     bool force = qdict_get_try_bool(qdict, "force", false);
     Error *err = NULL;
@@ -467,16 +483,18 @@ void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
+void hmp_nbd_server_stop(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_nbd_server_stop(&err);
     hmp_handle_error(mon, err);
 }
 
-void coroutine_fn hmp_block_resize(Monitor *mon, const QDict *qdict)
+void coroutine_fn hmp_block_resize(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     int64_t size = qdict_get_int(qdict, "size");
     Error *err = NULL;
@@ -485,8 +503,9 @@ void coroutine_fn hmp_block_resize(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_block_stream(Monitor *mon, const QDict *qdict)
+void hmp_block_stream(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *error = NULL;
     const char *device = qdict_get_str(qdict, "device");
     const char *base = qdict_get_try_str(qdict, "base");
@@ -500,8 +519,9 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, error);
 }
 
-void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
+void hmp_block_set_io_throttle(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     char *device = (char *) qdict_get_str(qdict, "device");
     BlockIOThrottle throttle = {
@@ -528,8 +548,9 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_eject(Monitor *mon, const QDict *qdict)
+void hmp_eject(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool force = qdict_get_try_bool(qdict, "force", false);
     const char *device = qdict_get_str(qdict, "device");
     Error *err = NULL;
@@ -538,8 +559,9 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_qemu_io(Monitor *mon, const QDict *qdict)
+void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool qdev = qdict_get_try_bool(qdict, "qdev", false);
     const char *device = qdict_get_str(qdict, "device");
     const char *command = qdict_get_str(qdict, "command");
@@ -666,8 +688,9 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 }
 
-void hmp_info_block(Monitor *mon, const QDict *qdict)
+void hmp_info_block(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     BlockInfoList *block_list, *info;
     BlockDeviceInfoList *blockdev_list, *blockdev;
     const char *device = qdict_get_try_str(qdict, "device");
@@ -719,8 +742,9 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)
     qapi_free_BlockDeviceInfoList(blockdev_list);
 }
 
-void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
+void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     BlockStatsList *stats_list, *stats;
 
     stats_list = qmp_query_blockstats(false, false, NULL);
@@ -757,8 +781,9 @@ void hmp_info_blockstats(Monitor *mon, const QDict *qdict)
     qapi_free_BlockStatsList(stats_list);
 }
 
-void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
+void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     BlockJobInfoList *list;
 
     list = qmp_query_block_jobs(&error_abort);
@@ -793,8 +818,9 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     qapi_free_BlockJobInfoList(list);
 }
 
-void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
+void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     BlockDriverState *bs, *bs1;
     BdrvNextIterator it1;
     QEMUSnapshotInfo *sn_tab, *sn;
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index f377e00b6991..d4a5a3a255a5 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -24,8 +24,9 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 
-void hmp_info_chardev(Monitor *mon, const QDict *qdict)
+void hmp_info_chardev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     ChardevInfoList *char_info, *info;
 
     char_info = qmp_query_chardev(NULL);
@@ -37,8 +38,9 @@ void hmp_info_chardev(Monitor *mon, const QDict *qdict)
     qapi_free_ChardevInfoList(char_info);
 }
 
-void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
+void hmp_ringbuf_write(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *chardev = qdict_get_str(qdict, "device");
     const char *data = qdict_get_str(qdict, "data");
     Error *err = NULL;
@@ -48,8 +50,9 @@ void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_ringbuf_read(Monitor *mon, const QDict *qdict)
+void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     uint32_t size = qdict_get_int(qdict, "size");
     const char *chardev = qdict_get_str(qdict, "device");
     char *data;
@@ -77,8 +80,9 @@ void hmp_ringbuf_read(Monitor *mon, const QDict *qdict)
     g_free(data);
 }
 
-void hmp_chardev_add(Monitor *mon, const QDict *qdict)
+void hmp_chardev_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *args = qdict_get_str(qdict, "args");
     Error *err = NULL;
     QemuOpts *opts;
@@ -93,8 +97,9 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_chardev_change(Monitor *mon, const QDict *qdict)
+void hmp_chardev_change(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *args = qdict_get_str(qdict, "args");
     const char *id;
     Error *err = NULL;
@@ -127,16 +132,18 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
+void hmp_chardev_remove(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *local_err = NULL;
 
     qmp_chardev_remove(qdict_get_str(qdict, "id"), &local_err);
     hmp_handle_error(mon, local_err);
 }
 
-void hmp_chardev_send_break(Monitor *mon, const QDict *qdict)
+void hmp_chardev_send_break(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *local_err = NULL;
 
     qmp_chardev_send_break(qdict_get_str(qdict, "id"), &local_err);
diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index 21023db6fd85..ba78ad026f1e 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -12,8 +12,9 @@
 #include "qapi/qapi-commands-dump.h"
 #include "qobject/qdict.h"
 
-void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
+void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     bool win_dmp = qdict_get_try_bool(qdict, "windmp", false);
     bool paging = qdict_get_try_bool(qdict, "paging", false);
@@ -83,8 +84,9 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     g_free(prot);
 }
 
-void hmp_info_dump(Monitor *mon, const QDict *qdict)
+void hmp_info_dump(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     DumpQueryResult *result = qmp_query_dump(NULL);
 
     assert(result && result->status < DUMP_STATUS__MAX);
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 1c700aad3587..48fa27f12705 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -25,8 +25,9 @@
 #include "system/numa.h"
 #include "hw/core/boards.h"
 
-void hmp_info_cpus(Monitor *mon, const QDict *qdict)
+void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CpuInfoFastList *cpu_list, *cpu;
 
     cpu_list = qmp_query_cpus_fast(NULL);
@@ -48,8 +49,9 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_CpuInfoFastList(cpu_list);
 }
 
-void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
+void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     HotpluggableCPUList *l = qmp_query_hotpluggable_cpus(&err);
     HotpluggableCPUList *saved = l;
@@ -106,8 +108,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_HotpluggableCPUList(saved);
 }
 
-void hmp_info_memdev(Monitor *mon, const QDict *qdict)
+void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     MemdevList *memdev_list = qmp_query_memdev(&err);
     MemdevList *m = memdev_list;
@@ -147,8 +150,9 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_kvm(Monitor *mon, const QDict *qdict)
+void hmp_info_kvm(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     KvmInfo *info;
 
     info = qmp_query_kvm(NULL);
@@ -162,8 +166,9 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     qapi_free_KvmInfo(info);
 }
 
-void hmp_info_accelerators(Monitor *mon, const QDict *qdict)
+void hmp_info_accelerators(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     AcceleratorInfo *info;
     AcceleratorList *accel;
 
@@ -180,8 +185,9 @@ void hmp_info_accelerators(Monitor *mon, const QDict *qdict)
     qapi_free_AcceleratorInfo(info);
 }
 
-void hmp_info_uuid(Monitor *mon, const QDict *qdict)
+void hmp_info_uuid(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     UuidInfo *info;
 
     info = qmp_query_uuid(NULL);
@@ -189,8 +195,9 @@ void hmp_info_uuid(Monitor *mon, const QDict *qdict)
     qapi_free_UuidInfo(info);
 }
 
-void hmp_info_balloon(Monitor *mon, const QDict *qdict)
+void hmp_info_balloon(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     BalloonInfo *info;
     Error *err = NULL;
 
@@ -204,18 +211,19 @@ void hmp_info_balloon(Monitor *mon, const QDict *qdict)
     qapi_free_BalloonInfo(info);
 }
 
-void hmp_system_reset(Monitor *mon, const QDict *qdict)
+void hmp_system_reset(MonitorHMP *hmp, const QDict *qdict)
 {
     qmp_system_reset(NULL);
 }
 
-void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
+void hmp_system_powerdown(MonitorHMP *hmp, const QDict *qdict)
 {
     qmp_system_powerdown(NULL);
 }
 
-void hmp_memsave(Monitor *mon, const QDict *qdict)
+void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     uint32_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
@@ -231,8 +239,9 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_pmemsave(Monitor *mon, const QDict *qdict)
+void hmp_pmemsave(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     uint32_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
@@ -242,24 +251,27 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
+void hmp_system_wakeup(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_system_wakeup(&err);
     hmp_handle_error(mon, err);
 }
 
-void hmp_nmi(Monitor *mon, const QDict *qdict)
+void hmp_nmi(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_inject_nmi(&err);
     hmp_handle_error(mon, err);
 }
 
-void hmp_balloon(Monitor *mon, const QDict *qdict)
+void hmp_balloon(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int64_t value = qdict_get_int(qdict, "value");
     Error *err = NULL;
 
@@ -267,8 +279,9 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
+void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
     MemoryDeviceInfoList *info;
@@ -370,8 +383,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
+void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     GuidInfo *info = qmp_query_vm_generation_id(&err);
     if (info) {
@@ -381,8 +395,9 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict)
     qapi_free_GuidInfo(info);
 }
 
-void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
+void hmp_info_memory_size_summary(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     MemoryInfo *info = qmp_query_memory_size_summary(&err);
     if (info) {
diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index bf6ac28bef47..ab1eb14f99e0 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -40,12 +40,14 @@ void xen_primary_console_set_be_port(uint16_t port)
 {
 }
 
-void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
 }
 
-void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
 }
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 8b243984e412..845838c372d5 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2344,8 +2344,9 @@ void qmp_xen_event_inject(uint32_t port, Error **errp)
     }
 }
 
-void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     EvtchnInfoList *iter, *info_list;
     Error *err = NULL;
 
@@ -2379,8 +2380,9 @@ void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
     qapi_free_EvtchnInfoList(info_list);
 }
 
-void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int port = qdict_get_int(qdict, "port");
     Error *err = NULL;
 
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
index cf1d9a6344b0..a4848ae1d1a7 100644
--- a/hw/i386/sgx-hmp-stub.c
+++ b/hw/i386/sgx-hmp-stub.c
@@ -10,7 +10,8 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "SGX is not available in this QEMU\n");
 }
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 7e4c509f5a4a..77b41d234c9f 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -234,8 +234,9 @@ SgxInfo *qmp_query_sgx(Error **errp)
     return info;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     SgxEpcSectionList *section_list, *section;
     g_autoptr(SgxInfo) info = qmp_query_sgx(&err);
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
index 85eb0ee36ee1..6a7d76292f00 100644
--- a/hw/misc/mos6522-stub.c
+++ b/hw/misc/mos6522-stub.c
@@ -10,7 +10,8 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
-void hmp_info_via(Monitor *mon, const QDict *qdict)
+void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
 }
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index bae766ef1782..15a6a1a75745 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -586,8 +586,9 @@ static HumanReadableText *qmp_x_query_via(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-void hmp_info_via(Monitor *mon, const QDict *qdict)
+void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     g_autoptr(HumanReadableText) info = qmp_x_query_via(&err);
 
diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
index df40991f6d20..856aaef5e210 100644
--- a/hw/net/rocker/rocker-hmp-cmds.c
+++ b/hw/net/rocker/rocker-hmp-cmds.c
@@ -20,8 +20,9 @@
 #include "qapi/qapi-commands-rocker.h"
 #include "qobject/qdict.h"
 
-void hmp_rocker(Monitor *mon, const QDict *qdict)
+void hmp_rocker(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_str(qdict, "name");
     RockerSwitch *rocker;
     Error *err = NULL;
@@ -38,8 +39,9 @@ void hmp_rocker(Monitor *mon, const QDict *qdict)
     qapi_free_RockerSwitch(rocker);
 }
 
-void hmp_rocker_ports(Monitor *mon, const QDict *qdict)
+void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     RockerPortList *list, *port;
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
@@ -65,8 +67,9 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict)
     qapi_free_RockerPortList(list);
 }
 
-void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict)
+void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     RockerOfDpaFlowList *list, *info;
     const char *name = qdict_get_str(qdict, "name");
     uint32_t tbl_id = qdict_get_try_int(qdict, "tbl_id", -1);
@@ -214,8 +217,9 @@ void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict)
     qapi_free_RockerOfDpaFlowList(list);
 }
 
-void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict)
+void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     RockerOfDpaGroupList *list, *g;
     const char *name = qdict_get_str(qdict, "name");
     uint8_t type = qdict_get_try_int(qdict, "type", 9);
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index a5f6483cc3d2..be24aecc8ac8 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -117,8 +117,9 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
     }
 }
 
-void hmp_info_pci(Monitor *mon, const QDict *qdict)
+void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     PciInfoList *info_list, *info;
 
     info_list = qmp_query_pci(&error_abort);
@@ -170,8 +171,9 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent)
     }
 }
 
-void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
+void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *id = qdict_get_str(qdict, "id");
     const char *error_name;
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 3397d0c82ea8..a80e34175462 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -34,12 +34,13 @@ PciInfoList *qmp_query_pci(Error **errp)
     return NULL;
 }
 
-void hmp_info_pci(Monitor *mon, const QDict *qdict)
+void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
 {
 }
 
-void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
+void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "PCI devices not supported\n");
 }
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 7dca67d6618c..d8afaf730639 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -104,8 +104,9 @@ static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
     }
 }
 
-void hmp_info_skeys(Monitor *mon, const QDict *qdict)
+void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     S390SKeysState *ss = s390_get_skeys_device();
     S390SKeysClass *skeyclass = S390_SKEYS_GET_CLASS(ss);
     uint64_t addr = qdict_get_int(qdict, "addr");
@@ -134,7 +135,7 @@ void hmp_info_skeys(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "  key: 0x%X\n", key);
 }
 
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
+void hmp_dump_skeys(MonitorHMP *hmp, const QDict *qdict)
 {
     const char *filename = qdict_get_str(qdict, "filename");
     Error *err = NULL;
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index b0f04eb30c7f..b4a405455901 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -59,8 +59,9 @@ void s390_stattrib_init(void)
 
 /* Console commands: */
 
-void hmp_migrationmode(Monitor *mon, const QDict *qdict)
+void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     S390StAttribState *sas = s390_get_stattrib_device();
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint64_t what = qdict_get_int(qdict, "mode");
@@ -74,8 +75,9 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_info_cmma(Monitor *mon, const QDict *qdict)
+void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     S390StAttribState *sas = s390_get_stattrib_device();
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint64_t addr = qdict_get_int(qdict, "addr");
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 3a24afd9417d..c97622b2aad6 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -256,8 +256,9 @@ FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
     return ret;
 }
 
-void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
+void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     g_autofree gchar *log_esc = NULL;
     g_autofree guchar *log_out = NULL;
     Error *err = NULL;
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index af67d5dfeb10..c02343d3a655 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1920,8 +1920,9 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
+void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     libusb_device **devs = NULL;
     struct libusb_device_descriptor ddesc;
     char port[16];
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index a91bb7dbeda5..49f3367785ba 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -80,8 +80,9 @@ static void hmp_virtio_dump_features(Monitor *mon,
     }
 }
 
-void hmp_virtio_query(Monitor *mon, const QDict *qdict)
+void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     VirtioInfoList *list = qmp_x_query_virtio(&err);
     VirtioInfoList *node;
@@ -105,8 +106,9 @@ void hmp_virtio_query(Monitor *mon, const QDict *qdict)
     qapi_free_VirtioInfoList(list);
 }
 
-void hmp_virtio_status(Monitor *mon, const QDict *qdict)
+void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *path = qdict_get_try_str(qdict, "path");
     VirtioStatus *s = qmp_x_query_virtio_status(path, &err);
@@ -183,8 +185,9 @@ void hmp_virtio_status(Monitor *mon, const QDict *qdict)
     qapi_free_VirtioStatus(s);
 }
 
-void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict)
+void hmp_vhost_queue_status(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *path = qdict_get_try_str(qdict, "path");
     int queue = qdict_get_int(qdict, "queue");
@@ -216,8 +219,9 @@ void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict)
     qapi_free_VirtVhostQueueStatus(s);
 }
 
-void hmp_virtio_queue_status(Monitor *mon, const QDict *qdict)
+void hmp_virtio_queue_status(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *path = qdict_get_try_str(qdict, "path");
     int queue = qdict_get_int(qdict, "queue");
@@ -261,8 +265,9 @@ void hmp_virtio_queue_status(Monitor *mon, const QDict *qdict)
     qapi_free_VirtQueueStatus(s);
 }
 
-void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict)
+void hmp_virtio_queue_element(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *path = qdict_get_try_str(qdict, "path");
     int queue = qdict_get_int(qdict, "queue");
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7efa4..0f5908958f05 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -16,41 +16,42 @@
 #define BLOCK_BLOCK_HMP_CMDS_H
 
 #include "qemu/coroutine.h"
+#include "monitor/hmp.h"
 
-void hmp_drive_add(Monitor *mon, const QDict *qdict);
+void hmp_drive_add(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_commit(Monitor *mon, const QDict *qdict);
-void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_commit(MonitorHMP *hmp, const QDict *qdict);
+void hmp_drive_del(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
-void hmp_drive_backup(Monitor *mon, const QDict *qdict);
+void hmp_drive_mirror(MonitorHMP *hmp, const QDict *qdict);
+void hmp_drive_backup(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
-void hmp_block_job_cancel(Monitor *mon, const QDict *qdict);
-void hmp_block_job_pause(Monitor *mon, const QDict *qdict);
-void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
-void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
+void hmp_block_job_set_speed(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_job_cancel(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_job_pause(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_job_resume(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_job_complete(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
-void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
-void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict);
+void hmp_snapshot_blkdev(MonitorHMP *hmp, const QDict *qdict);
+void hmp_snapshot_blkdev_internal(MonitorHMP *hmp, const QDict *qdict);
+void hmp_snapshot_delete_blkdev_internal(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
-void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
+void hmp_nbd_server_start(MonitorHMP *hmp, const QDict *qdict);
+void hmp_nbd_server_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_nbd_server_remove(MonitorHMP *hmp, const QDict *qdict);
+void hmp_nbd_server_stop(MonitorHMP *hmp, const QDict *qdict);
 
-void coroutine_fn hmp_block_resize(Monitor *mon, const QDict *qdict);
-void hmp_block_stream(Monitor *mon, const QDict *qdict);
-void hmp_block_passwd(Monitor *mon, const QDict *qdict);
-void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
-void hmp_eject(Monitor *mon, const QDict *qdict);
+void coroutine_fn hmp_block_resize(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_stream(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_passwd(MonitorHMP *hmp, const QDict *qdict);
+void hmp_block_set_io_throttle(MonitorHMP *hmp, const QDict *qdict);
+void hmp_eject(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_qemu_io(Monitor *mon, const QDict *qdict);
+void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_info_block(Monitor *mon, const QDict *qdict);
-void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
-void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
-void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
+void hmp_info_block(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_blockstats(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_block_jobs(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_snapshots(MonitorHMP *hmp, const QDict *qdict);
 
 #endif
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
index 78e2ceedd7fd..cbd4711933e8 100644
--- a/include/hw/usb/usb.h
+++ b/include/hw/usb/usb.h
@@ -31,6 +31,7 @@
 #include "qemu/queue.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "monitor/hmp.h"
 
 /* Constants related to the USB / PCI interaction */
 #define USB_SBRN    0x60 /* Serial Bus Release Number Register */
@@ -466,7 +467,7 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream);
 void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 
 /* usb-linux.c */
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
+void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict);
 
 /* usb ports of the VM */
 
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 166cd4100c63..7a270ad3f25c 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -22,7 +22,7 @@
 OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
 
 #define HMP_STUB(cmd) \
-    void hmp_##cmd(Monitor *mon, const QDict *qdict) \
+    void hmp_##cmd(MonitorHMP *hmp, const QDict *qdict) \
     { \
         g_assert_not_reached(); \
     }
@@ -46,7 +46,7 @@ int monitor_hmp_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
                               void *opaque);
 
 void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict));
+                          void (*cmd)(MonitorHMP *mon, const QDict *qdict));
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
 
@@ -58,58 +58,58 @@ bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
 
-void hmp_info_name(Monitor *mon, const QDict *qdict);
-void hmp_info_version(Monitor *mon, const QDict *qdict);
-void hmp_info_kvm(Monitor *mon, const QDict *qdict);
-void hmp_info_accelerators(Monitor *mon, const QDict *qdict);
-void hmp_info_status(Monitor *mon, const QDict *qdict);
-void hmp_info_uuid(Monitor *mon, const QDict *qdict);
-void hmp_info_chardev(Monitor *mon, const QDict *qdict);
-void hmp_info_mice(Monitor *mon, const QDict *qdict);
-void hmp_info_migrate(Monitor *mon, const QDict *qdict);
-void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
-void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
-void hmp_info_cpus(Monitor *mon, const QDict *qdict);
-void hmp_info_vnc(Monitor *mon, const QDict *qdict);
-void hmp_info_spice(Monitor *mon, const QDict *qdict);
-void hmp_info_balloon(Monitor *mon, const QDict *qdict);
-void hmp_info_pci(Monitor *mon, const QDict *qdict);
-void hmp_info_tpm(Monitor *mon, const QDict *qdict);
-void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
-void hmp_quit(Monitor *mon, const QDict *qdict);
-void hmp_stop(Monitor *mon, const QDict *qdict);
-void hmp_sync_profile(Monitor *mon, const QDict *qdict);
-void hmp_system_reset(Monitor *mon, const QDict *qdict);
-void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
-void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
-void hmp_announce_self(Monitor *mon, const QDict *qdict);
-void hmp_cpu(Monitor *mon, const QDict *qdict);
-void hmp_memsave(Monitor *mon, const QDict *qdict);
-void hmp_pmemsave(Monitor *mon, const QDict *qdict);
-void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
-void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
-void hmp_cont(Monitor *mon, const QDict *qdict);
-void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
-void hmp_nmi(Monitor *mon, const QDict *qdict);
-void hmp_info_network(Monitor *mon, const QDict *qdict);
-void hmp_set_link(Monitor *mon, const QDict *qdict);
-void hmp_balloon(Monitor *mon, const QDict *qdict);
-void hmp_loadvm(Monitor *mon, const QDict *qdict);
-void hmp_savevm(Monitor *mon, const QDict *qdict);
-void hmp_delvm(Monitor *mon, const QDict *qdict);
-void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
-void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
-void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
-void hmp_migrate_recover(Monitor *mon, const QDict *qdict);
-void hmp_migrate_pause(Monitor *mon, const QDict *qdict);
-void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict);
-void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict);
-void hmp_client_migrate_info(Monitor *mon, const QDict *qdict);
-void hmp_migrate_start_postcopy(Monitor *mon, const QDict *qdict);
-void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict);
-void hmp_set_password(Monitor *mon, const QDict *qdict);
-void hmp_expire_password(Monitor *mon, const QDict *qdict);
-void hmp_change(Monitor *mon, const QDict *qdict);
+void hmp_info_name(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_version(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_kvm(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_accelerators(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_status(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_uuid(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_chardev(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_mice(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_migrate(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_migrate_capabilities(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_spice(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_balloon(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_tpm(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict);
+void hmp_quit(MonitorHMP *hmp, const QDict *qdict);
+void hmp_stop(MonitorHMP *hmp, const QDict *qdict);
+void hmp_sync_profile(MonitorHMP *hmp, const QDict *qdict);
+void hmp_system_reset(MonitorHMP *hmp, const QDict *qdict);
+void hmp_system_powerdown(MonitorHMP *hmp, const QDict *qdict);
+void hmp_exit_preconfig(MonitorHMP *hmp, const QDict *qdict);
+void hmp_announce_self(MonitorHMP *hmp, const QDict *qdict);
+void hmp_cpu(MonitorHMP *hmp, const QDict *qdict);
+void hmp_memsave(MonitorHMP *hmp, const QDict *qdict);
+void hmp_pmemsave(MonitorHMP *hmp, const QDict *qdict);
+void hmp_ringbuf_write(MonitorHMP *hmp, const QDict *qdict);
+void hmp_ringbuf_read(MonitorHMP *hmp, const QDict *qdict);
+void hmp_cont(MonitorHMP *hmp, const QDict *qdict);
+void hmp_system_wakeup(MonitorHMP *hmp, const QDict *qdict);
+void hmp_nmi(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_network(MonitorHMP *hmp, const QDict *qdict);
+void hmp_set_link(MonitorHMP *hmp, const QDict *qdict);
+void hmp_balloon(MonitorHMP *hmp, const QDict *qdict);
+void hmp_loadvm(MonitorHMP *hmp, const QDict *qdict);
+void hmp_savevm(MonitorHMP *hmp, const QDict *qdict);
+void hmp_delvm(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_cancel(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_continue(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_incoming(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_recover(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_pause(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_set_capability(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict);
+void hmp_client_migrate_info(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrate_start_postcopy(MonitorHMP *hmp, const QDict *qdict);
+void hmp_x_colo_lost_heartbeat(MonitorHMP *hmp, const QDict *qdict);
+void hmp_set_password(MonitorHMP *hmp, const QDict *qdict);
+void hmp_expire_password(MonitorHMP *hmp, const QDict *qdict);
+void hmp_change(MonitorHMP *hmp, const QDict *qdict);
 #ifdef CONFIG_VNC
 void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
                     const char *arg, const char *read_only, bool force,
@@ -118,101 +118,101 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
 void hmp_change_medium(Monitor *mon, const char *device, const char *target,
                        const char *arg, const char *read_only, bool force,
                        Error **errp);
-void hmp_migrate(Monitor *mon, const QDict *qdict);
-void hmp_device_add(Monitor *mon, const QDict *qdict);
-void hmp_device_del(Monitor *mon, const QDict *qdict);
-void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict);
-void hmp_netdev_add(Monitor *mon, const QDict *qdict);
-void hmp_netdev_del(Monitor *mon, const QDict *qdict);
-void hmp_getfd(Monitor *mon, const QDict *qdict);
-void hmp_closefd(Monitor *mon, const QDict *qdict);
-void hmp_mouse_move(Monitor *mon, const QDict *qdict);
-void hmp_mouse_button(Monitor *mon, const QDict *qdict);
-void hmp_mouse_set(Monitor *mon, const QDict *qdict);
-void hmp_sendkey(Monitor *mon, const QDict *qdict);
-void coroutine_fn hmp_screendump(Monitor *mon, const QDict *qdict);
-void hmp_chardev_add(Monitor *mon, const QDict *qdict);
-void hmp_chardev_change(Monitor *mon, const QDict *qdict);
-void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
-void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
-void hmp_object_add(Monitor *mon, const QDict *qdict);
-void hmp_object_del(Monitor *mon, const QDict *qdict);
-void hmp_info_memdev(Monitor *mon, const QDict *qdict);
-void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
-void hmp_qom_list(Monitor *mon, const QDict *qdict);
-void hmp_qom_get(Monitor *mon, const QDict *qdict);
-void hmp_qom_set(Monitor *mon, const QDict *qdict);
-void hmp_info_qom_tree(Monitor *mon, const QDict *dict);
-void hmp_virtio_query(Monitor *mon, const QDict *qdict);
-void hmp_virtio_status(Monitor *mon, const QDict *qdict);
-void hmp_virtio_queue_status(Monitor *mon, const QDict *qdict);
-void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict);
-void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict);
-void hmp_xen_event_inject(Monitor *mon, const QDict *qdict);
-void hmp_xen_event_list(Monitor *mon, const QDict *qdict);
-void hmp_rocker(Monitor *mon, const QDict *qdict);
-void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
-void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
-void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
-void hmp_info_dump(Monitor *mon, const QDict *qdict);
-void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
-void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
-void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
-void hmp_info_replay(Monitor *mon, const QDict *qdict);
-void hmp_replay_break(Monitor *mon, const QDict *qdict);
-void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
-void hmp_replay_seek(Monitor *mon, const QDict *qdict);
-void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict);
-void hmp_calc_dirty_rate(Monitor *mon, const QDict *qdict);
-void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict);
-void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict);
-void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict);
+void hmp_migrate(MonitorHMP *hmp, const QDict *qdict);
+void hmp_device_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_device_del(MonitorHMP *hmp, const QDict *qdict);
+void hmp_dump_guest_memory(MonitorHMP *hmp, const QDict *qdict);
+void hmp_netdev_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_netdev_del(MonitorHMP *hmp, const QDict *qdict);
+void hmp_getfd(MonitorHMP *hmp, const QDict *qdict);
+void hmp_closefd(MonitorHMP *hmp, const QDict *qdict);
+void hmp_mouse_move(MonitorHMP *hmp, const QDict *qdict);
+void hmp_mouse_button(MonitorHMP *hmp, const QDict *qdict);
+void hmp_mouse_set(MonitorHMP *hmp, const QDict *qdict);
+void hmp_sendkey(MonitorHMP *hmp, const QDict *qdict);
+void coroutine_fn hmp_screendump(MonitorHMP *hmp, const QDict *qdict);
+void hmp_chardev_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_chardev_change(MonitorHMP *hmp, const QDict *qdict);
+void hmp_chardev_remove(MonitorHMP *hmp, const QDict *qdict);
+void hmp_chardev_send_break(MonitorHMP *hmp, const QDict *qdict);
+void hmp_object_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_object_del(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_memdev(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_memory_devices(MonitorHMP *hmp, const QDict *qdict);
+void hmp_qom_list(MonitorHMP *hmp, const QDict *qdict);
+void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict);
+void hmp_qom_set(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_qom_tree(MonitorHMP *hmp, const QDict *dict);
+void hmp_virtio_query(MonitorHMP *hmp, const QDict *qdict);
+void hmp_virtio_status(MonitorHMP *hmp, const QDict *qdict);
+void hmp_virtio_queue_status(MonitorHMP *hmp, const QDict *qdict);
+void hmp_vhost_queue_status(MonitorHMP *hmp, const QDict *qdict);
+void hmp_virtio_queue_element(MonitorHMP *hmp, const QDict *qdict);
+void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict);
+void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict);
+void hmp_rocker(MonitorHMP *hmp, const QDict *qdict);
+void hmp_rocker_ports(MonitorHMP *hmp, const QDict *qdict);
+void hmp_rocker_of_dpa_flows(MonitorHMP *hmp, const QDict *qdict);
+void hmp_rocker_of_dpa_groups(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_dump(MonitorHMP *hmp, const QDict *qdict);
+void hmp_hotpluggable_cpus(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_vm_generation_id(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_memory_size_summary(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict);
+void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict);
+void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict);
+void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_dirty_rate(MonitorHMP *hmp, const QDict *qdict);
+void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict);
+void hmp_set_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict);
+void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict);
 void hmp_human_readable_text_helper(Monitor *mon,
                                     HumanReadableText *(*qmp_handler)(Error **));
-void hmp_info_stats(Monitor *mon, const QDict *qdict);
-void hmp_one_insn_per_tb(Monitor *mon, const QDict *qdict);
-void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
-void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
-void hmp_info_capture(Monitor *mon, const QDict *qdict);
-void hmp_stopcapture(Monitor *mon, const QDict *qdict);
-void hmp_wavcapture(Monitor *mon, const QDict *qdict);
-void hmp_trace_event(Monitor *mon, const QDict *qdict);
-void hmp_trace_file(Monitor *mon, const QDict *qdict);
-void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
-void hmp_help(Monitor *mon, const QDict *qdict);
-void hmp_clear(Monitor *mon, const QDict *qdict);
-void hmp_info_help(Monitor *mon, const QDict *qdict);
-void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
-void hmp_info_history(Monitor *mon, const QDict *qdict);
-void hmp_logfile(Monitor *mon, const QDict *qdict);
-void hmp_log(Monitor *mon, const QDict *qdict);
-void hmp_gdbserver(Monitor *mon, const QDict *qdict);
-void hmp_print(Monitor *mon, const QDict *qdict);
-void hmp_sum(Monitor *mon, const QDict *qdict);
-void hmp_ioport_read(Monitor *mon, const QDict *qdict);
-void hmp_ioport_write(Monitor *mon, const QDict *qdict);
-void hmp_boot_set(Monitor *mon, const QDict *qdict);
-void hmp_info_mtree(Monitor *mon, const QDict *qdict);
-void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
-void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
-void hmp_info_firmware_log(Monitor *mon, const QDict *qdict);
-void hmp_info_mem(Monitor *mon, const QDict *qdict);
-void hmp_info_tlb(Monitor *mon, const QDict *qdict);
-void hmp_mce(Monitor *mon, const QDict *qdict);
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
-void hmp_info_sev(Monitor *mon, const QDict *qdict);
-void hmp_info_sgx(Monitor *mon, const QDict *qdict);
-void hmp_info_via(Monitor *mon, const QDict *qdict);
-void hmp_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_info_registers(Monitor *mon, const QDict *qdict);
-void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
+void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict);
+void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict);
+void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict);
+void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_capture(MonitorHMP *hmp, const QDict *qdict);
+void hmp_stopcapture(MonitorHMP *hmp, const QDict *qdict);
+void hmp_wavcapture(MonitorHMP *hmp, const QDict *qdict);
+void hmp_trace_event(MonitorHMP *hmp, const QDict *qdict);
+void hmp_trace_file(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_trace_events(MonitorHMP *hmp, const QDict *qdict);
+void hmp_help(MonitorHMP *hmp, const QDict *qdict);
+void hmp_clear(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_help(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_sync_profile(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_history(MonitorHMP *hmp, const QDict *qdict);
+void hmp_logfile(MonitorHMP *hmp, const QDict *qdict);
+void hmp_log(MonitorHMP *hmp, const QDict *qdict);
+void hmp_gdbserver(MonitorHMP *hmp, const QDict *qdict);
+void hmp_print(MonitorHMP *hmp, const QDict *qdict);
+void hmp_sum(MonitorHMP *hmp, const QDict *qdict);
+void hmp_ioport_read(MonitorHMP *hmp, const QDict *qdict);
+void hmp_ioport_write(MonitorHMP *hmp, const QDict *qdict);
+void hmp_boot_set(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_mtree(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_cryptodev(MonitorHMP *hmp, const QDict *qdict);
+void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict);
+void hmp_mce(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_via(MonitorHMP *hmp, const QDict *qdict);
+void hmp_memory_dump(MonitorHMP *hmp, const QDict *qdict);
+void hmp_physical_memory_dump(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict);
+void hmp_gva2gpa(MonitorHMP *hmp, const QDict *qdict);
+void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict);
+void hmp_gpa2hpa(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_dump_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_skeys(Monitor *mon, const QDict *qdict);
-void hmp_info_cmma(Monitor *mon, const QDict *qdict);
-void hmp_migrationmode(Monitor *mon, const QDict *qdict);
+void hmp_dump_skeys(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict);
+void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict);
 
 #endif
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index f85f25738d58..8f7e2f616cf3 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -2,11 +2,12 @@
 #define MONITOR_QDEV_H
 
 #include "hw/core/qdev.h"
+#include "monitor/hmp.h"
 
 /*** monitor commands ***/
 
-void hmp_info_qtree(Monitor *mon, const QDict *qdict);
-void hmp_info_qdm(Monitor *mon, const QDict *qdict);
+void hmp_info_qtree(MonitorHMP *hmp, const QDict *qdict);
+void hmp_info_qdm(MonitorHMP *hmp, const QDict *qdict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
diff --git a/include/net/net.h b/include/net/net.h
index a7c49c543783..626b99794806 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -5,6 +5,7 @@
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
 #include "hw/core/qdev-properties-system.h"
+#include "monitor/hmp.h"
 
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
@@ -318,8 +319,8 @@ void net_init_clients(void);
 void net_check_clients(void);
 void net_client_set_link(NetClientState **ncs, int queues, bool up);
 void net_cleanup(void);
-void hmp_host_net_add(Monitor *mon, const QDict *qdict);
-void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
+void hmp_host_net_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_host_net_remove(MonitorHMP *hmp, const QDict *qdict);
 void netdev_add(QemuOpts *opts, Error **errp);
 
 int net_hub_id_for_client(NetClientState *nc, int *id);
diff --git a/include/net/slirp.h b/include/net/slirp.h
index bad3e1e2416b..38859edf58ae 100644
--- a/include/net/slirp.h
+++ b/include/net/slirp.h
@@ -24,13 +24,13 @@
 #ifndef QEMU_NET_SLIRP_H
 #define QEMU_NET_SLIRP_H
 
-
 #ifdef CONFIG_SLIRP
+#include "monitor/hmp.h"
 
-void hmp_hostfwd_add(Monitor *mon, const QDict *qdict);
-void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict);
+void hmp_hostfwd_add(MonitorHMP *hmp, const QDict *qdict);
+void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict);
 
-void hmp_info_usernet(Monitor *mon, const QDict *qdict);
+void hmp_info_usernet(MonitorHMP *hmp, const QDict *qdict);
 
 #endif
 
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index b360f49efeaf..567abab321cc 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -856,8 +856,9 @@ struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
         has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND);
 }
 
-void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)
+void hmp_info_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     DirtyRateInfo *info = query_dirty_rate_info(TIME_UNIT_SECOND);
 
     monitor_printf(mon, "Status: %s\n",
@@ -891,8 +892,9 @@ void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)
     g_free(info);
 }
 
-void hmp_calc_dirty_rate(Monitor *mon, const QDict *qdict)
+void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int64_t sec = qdict_get_try_int(qdict, "second", 0);
     int64_t sample_pages = qdict_get_try_int(qdict, "sample_pages_per_GB", -1);
     bool has_sample_pages = (sample_pages != -1);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index ad68fa23aa4b..8d2e8735277e 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -135,8 +135,9 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
     }
 }
 
-void hmp_info_migrate(Monitor *mon, const QDict *qdict)
+void hmp_info_migrate(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool show_all = qdict_get_try_bool(qdict, "all", false);
     MigrationInfo *info;
 
@@ -297,8 +298,9 @@ out:
     qapi_free_MigrationInfo(info);
 }
 
-void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
+void hmp_info_migrate_capabilities(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     MigrationCapabilityStatusList *caps, *cap;
 
     caps = qmp_query_migrate_capabilities(NULL);
@@ -326,8 +328,9 @@ static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
     monitor_printf(mon, "\n");
 }
 
-void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
+void hmp_info_migrate_parameters(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     MigrationParameters *params;
     MigrationState *s = migrate_get_current();
 
@@ -473,8 +476,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
     qapi_free_MigrationParameters(params);
 }
 
-void hmp_loadvm(Monitor *mon, const QDict *qdict)
+void hmp_loadvm(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     RunState saved_state = runstate_get();
 
     const char *name = qdict_get_str(qdict, "name");
@@ -489,8 +493,9 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_savevm(Monitor *mon, const QDict *qdict)
+void hmp_savevm(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     save_snapshot(qdict_get_try_str(qdict, "name"),
@@ -498,8 +503,9 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_delvm(Monitor *mon, const QDict *qdict)
+void hmp_delvm(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
@@ -507,13 +513,14 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
+void hmp_migrate_cancel(MonitorHMP *hmp, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
 }
 
-void hmp_migrate_continue(Monitor *mon, const QDict *qdict)
+void hmp_migrate_continue(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *state = qdict_get_str(qdict, "state");
     int val = qapi_enum_parse(&MigrationStatus_lookup, state, -1, &err);
@@ -525,8 +532,9 @@ void hmp_migrate_continue(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
+void hmp_migrate_incoming(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
     MigrationChannelList *caps = NULL;
@@ -544,8 +552,9 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
+void hmp_migrate_recover(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
@@ -554,8 +563,9 @@ void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_pause(Monitor *mon, const QDict *qdict)
+void hmp_migrate_pause(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_migrate_pause(&err);
@@ -564,8 +574,9 @@ void hmp_migrate_pause(Monitor *mon, const QDict *qdict)
 }
 
 
-void hmp_migrate_set_capability(Monitor *mon, const QDict *qdict)
+void hmp_migrate_set_capability(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *cap = qdict_get_str(qdict, "capability");
     bool state = qdict_get_bool(qdict, "state");
     Error *err = NULL;
@@ -589,8 +600,9 @@ end:
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
+void hmp_migrate_set_parameter(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
     Visitor *v = string_input_visitor_new(valuestr);
@@ -790,16 +802,18 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_migrate_start_postcopy(Monitor *mon, const QDict *qdict)
+void hmp_migrate_start_postcopy(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     qmp_migrate_start_postcopy(&err);
     hmp_handle_error(mon, err);
 }
 
 #ifdef CONFIG_REPLICATION
-void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict)
+void hmp_x_colo_lost_heartbeat(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_x_colo_lost_heartbeat(&err);
@@ -833,8 +847,9 @@ static void hmp_migrate_status_cb(void *opaque)
     qapi_free_MigrationInfo(info);
 }
 
-void hmp_migrate(Monitor *mon, const QDict *qdict)
+void hmp_migrate(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool detach = qdict_get_try_bool(qdict, "detach", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
@@ -873,7 +888,6 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
 
     if (!detach) {
         HMPMigrationStatus *status;
-        MonitorHMP *hmp = MONITOR_HMP(mon);
 
         if (!hmp->use_readline) {
             monitor_printf(mon, "terminal does not allow synchronous "
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 7c3fedb91936..31ce54e28449 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -103,8 +103,9 @@ strList *hmp_split_at_comma(const char *str)
     return res;
 }
 
-void hmp_info_name(Monitor *mon, const QDict *qdict)
+void hmp_info_name(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     NameInfo *info;
 
     info = qmp_query_name(NULL);
@@ -114,8 +115,9 @@ void hmp_info_name(Monitor *mon, const QDict *qdict)
     qapi_free_NameInfo(info);
 }
 
-void hmp_info_version(Monitor *mon, const QDict *qdict)
+void hmp_info_version(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     VersionInfo *info;
 
     info = qmp_query_version(NULL);
@@ -127,22 +129,23 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
     qapi_free_VersionInfo(info);
 }
 
-void hmp_quit(Monitor *mon, const QDict *qdict)
+void hmp_quit(MonitorHMP *hmp, const QDict *qdict)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
+    Monitor *mon = MONITOR(hmp);
     if (hmp->use_readline) {
         monitor_suspend(mon);
     }
     qmp_quit(NULL);
 }
 
-void hmp_stop(Monitor *mon, const QDict *qdict)
+void hmp_stop(MonitorHMP *hmp, const QDict *qdict)
 {
     qmp_stop(NULL);
 }
 
-void hmp_sync_profile(Monitor *mon, const QDict *qdict)
+void hmp_sync_profile(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *op = qdict_get_try_str(qdict, "op");
 
     if (op == NULL) {
@@ -166,16 +169,18 @@ void hmp_sync_profile(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_exit_preconfig(Monitor *mon, const QDict *qdict)
+void hmp_exit_preconfig(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_x_exit_preconfig(&err);
     hmp_handle_error(mon, err);
 }
 
-void hmp_cpu(Monitor *mon, const QDict *qdict)
+void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int64_t cpu_index;
 
     /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
@@ -186,16 +191,18 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_cont(Monitor *mon, const QDict *qdict)
+void hmp_cont(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qmp_cont(&err);
     hmp_handle_error(mon, err);
 }
 
-void hmp_change(Monitor *mon, const QDict *qdict)
+void hmp_change(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *device = qdict_get_str(qdict, "device");
     const char *target = qdict_get_str(qdict, "target");
     const char *arg = qdict_get_try_str(qdict, "arg");
@@ -216,8 +223,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
 }
 
 #ifdef CONFIG_POSIX
-void hmp_getfd(Monitor *mon, const QDict *qdict)
+void hmp_getfd(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *fdname = qdict_get_str(qdict, "fdname");
     Error *err = NULL;
 
@@ -226,8 +234,9 @@ void hmp_getfd(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-void hmp_closefd(Monitor *mon, const QDict *qdict)
+void hmp_closefd(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *fdname = qdict_get_str(qdict, "fdname");
     Error *err = NULL;
 
@@ -235,8 +244,9 @@ void hmp_closefd(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
+void hmp_info_iothreads(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
@@ -256,13 +266,15 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     qapi_free_IOThreadInfoList(info_list);
 }
 
-void hmp_help(Monitor *mon, const QDict *qdict)
+void hmp_help(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
-void hmp_clear(Monitor *mon, const QDict *qdict)
+void hmp_clear(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     /*
      * Send an ANSI escape sequence:
      * "\x1b[H" - move cursor to top-left
@@ -272,12 +284,13 @@ void hmp_clear(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\x1b[H\x1b[2J\x1b[3J");
 }
 
-void hmp_info_help(Monitor *mon, const QDict *qdict)
+void hmp_info_help(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     hmp_help_cmd(mon, "info");
 }
 
-void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_sync_profile(MonitorHMP *hmp, const QDict *qdict)
 {
     int64_t max = qdict_get_try_int(qdict, "max", 10);
     bool mean = qdict_get_try_bool(qdict, "mean", false);
@@ -288,9 +301,9 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
     qsp_report(max, sort_by, coalesce);
 }
 
-void hmp_info_history(Monitor *mon, const QDict *qdict)
+void hmp_info_history(MonitorHMP *hmp, const QDict *qdict)
 {
-    MonitorHMP *hmp = MONITOR_HMP(mon);
+    Monitor *mon = MONITOR(hmp);
     int i;
     const char *str;
 
@@ -308,7 +321,7 @@ void hmp_info_history(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_logfile(Monitor *mon, const QDict *qdict)
+void hmp_logfile(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
 
@@ -317,8 +330,9 @@ void hmp_logfile(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_log(Monitor *mon, const QDict *qdict)
+void hmp_log(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int mask;
     const char *items = qdict_get_str(qdict, "items");
     Error *err = NULL;
@@ -338,8 +352,9 @@ void hmp_log(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_gdbserver(Monitor *mon, const QDict *qdict)
+void hmp_gdbserver(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *device = qdict_get_try_str(qdict, "device");
 
@@ -357,8 +372,9 @@ void hmp_gdbserver(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_print(Monitor *mon, const QDict *qdict)
+void hmp_print(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int format = qdict_get_int(qdict, "format");
     hwaddr val = qdict_get_int(qdict, "val");
 
@@ -383,8 +399,9 @@ void hmp_print(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
 }
 
-void hmp_sum(Monitor *mon, const QDict *qdict)
+void hmp_sum(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     uint32_t addr;
     uint16_t sum;
     uint32_t start = qdict_get_int(qdict, "start");
@@ -401,8 +418,9 @@ void hmp_sum(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "%05d\n", sum);
 }
 
-void hmp_ioport_read(Monitor *mon, const QDict *qdict)
+void hmp_ioport_read(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
     int has_index = qdict_haskey(qdict, "index");
@@ -435,7 +453,7 @@ void hmp_ioport_read(Monitor *mon, const QDict *qdict)
                    suffix, addr, size * 2, val);
 }
 
-void hmp_ioport_write(Monitor *mon, const QDict *qdict)
+void hmp_ioport_write(MonitorHMP *hmp, const QDict *qdict)
 {
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
@@ -457,8 +475,9 @@ void hmp_ioport_write(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_boot_set(Monitor *mon, const QDict *qdict)
+void hmp_boot_set(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *local_err = NULL;
     const char *bootdevice = qdict_get_str(qdict, "bootdevice");
 
@@ -470,7 +489,7 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_info_mtree(Monitor *mon, const QDict *qdict)
+void hmp_info_mtree(MonitorHMP *hmp, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
@@ -481,8 +500,9 @@ void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 }
 
 #if defined(CONFIG_FDT)
-void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
+void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "filename");
     Error *local_err = NULL;
 
@@ -558,8 +578,9 @@ int monitor_get_cpu_index(Monitor *mon)
     return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
 }
 
-void hmp_info_registers(Monitor *mon, const QDict *qdict)
+void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
     int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
     CPUState *cs;
@@ -694,8 +715,9 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 }
 
-void hmp_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_memory_dump(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
@@ -704,8 +726,9 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, false);
 }
 
-void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_physical_memory_dump(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
@@ -714,8 +737,9 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, true);
 }
 
-void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
     MemoryRegion *mr = NULL;
@@ -734,8 +758,9 @@ void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
     memory_region_unref(mr);
 }
 
-void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
+void hmp_gva2gpa(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     vaddr addr = qdict_get_int(qdict, "addr");
     CPUState *cs = mon_get_cpu(mon);
     TranslateForDebugResult tres;
@@ -787,8 +812,9 @@ out:
     return ret;
 }
 
-void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hpa(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
     MemoryRegion *mr = NULL;
diff --git a/monitor/hmp.c b/monitor/hmp.c
index b4d05d47c4bf..6e6334b64685 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1228,12 +1228,12 @@ static void hmp_info_human_readable_text(Monitor *mon,
     monitor_puts(mon, info->human_readable_text);
 }
 
-static void handle_hmp_command_exec(Monitor *mon,
+static void handle_hmp_command_exec(MonitorHMP *mon,
                                     const HMPCommand *cmd,
                                     QDict *qdict)
 {
     if (cmd->cmd_info_hrt) {
-        hmp_info_human_readable_text(mon,
+        hmp_info_human_readable_text(MONITOR(mon),
                                      cmd->cmd_info_hrt);
     } else {
         cmd->cmd(mon, qdict);
@@ -1241,7 +1241,7 @@ static void handle_hmp_command_exec(Monitor *mon,
 }
 
 typedef struct HandleHmpCommandCo {
-    Monitor *mon;
+    MonitorHMP *mon;
     const HMPCommand *cmd;
     QDict *qdict;
     bool done;
@@ -1289,19 +1289,18 @@ void handle_hmp_command(MonitorHMP *hmp, const char *cmdline)
 
     if (!cmd->coroutine) {
         /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(),
-                                           &hmp->parent_obj);
-        handle_hmp_command_exec(&hmp->parent_obj, cmd, qdict);
+        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), MONITOR(hmp));
+        handle_hmp_command_exec(hmp, cmd, qdict);
         monitor_set_cur(qemu_coroutine_self(), old_mon);
     } else {
         HandleHmpCommandCo data = {
-            .mon = &hmp->parent_obj,
+            .mon = hmp,
             .cmd = cmd,
             .qdict = qdict,
             .done = false,
         };
         Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
-        monitor_set_cur(co, &hmp->parent_obj);
+        monitor_set_cur(co, MONITOR(hmp));
         aio_co_enter(qemu_get_aio_context(), co);
         AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
     }
@@ -1689,7 +1688,7 @@ int hmp_compare_cmd(const char *name, const char *list)
 }
 
 void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict))
+                          void (*cmd)(MonitorHMP *mon, const QDict *qdict))
 {
     HMPCommand *table = hmp_cmds_for_target(info);
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index ee9ba0c8231e..a0fa37c887ed 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,7 +77,7 @@ typedef struct HMPCommand {
     const char *params;
     const char *help;
     const char *flags; /* p=preconfig */
-    void (*cmd)(Monitor *mon, const QDict *qdict);
+    void (*cmd)(MonitorHMP *mon, const QDict *qdict);
     /*
      * If implementing a command that takes no arguments and simply
      * prints formatted data, then leave @cmd NULL, and then set
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 52ac8da770d9..702103b6a920 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -45,8 +45,9 @@ static void hmp_print_client_info(Monitor *mon, NetworkClientInfo *ci)
     }
 }
 
-void hmp_info_network(Monitor *mon, const QDict *qdict)
+void hmp_info_network(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     g_autoptr(NetworkInfo) info = qmp_x_query_network(&err);
     NetHubInfoList *h;
@@ -83,8 +84,9 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_set_link(Monitor *mon, const QDict *qdict)
+void hmp_set_link(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_str(qdict, "name");
     bool up = qdict_get_bool(qdict, "up");
     Error *err = NULL;
@@ -94,7 +96,7 @@ void hmp_set_link(Monitor *mon, const QDict *qdict)
 }
 
 
-void hmp_announce_self(Monitor *mon, const QDict *qdict)
+void hmp_announce_self(MonitorHMP *hmp, const QDict *qdict)
 {
     const char *interfaces_str = qdict_get_try_str(qdict, "interfaces");
     const char *id = qdict_get_try_str(qdict, "id");
@@ -109,8 +111,9 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
     qapi_free_AnnounceParameters(params);
 }
 
-void hmp_netdev_add(Monitor *mon, const QDict *qdict)
+void hmp_netdev_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     QemuOpts *opts;
     const char *type = qdict_get_try_str(qdict, "type");
@@ -133,8 +136,9 @@ out:
     hmp_handle_error(mon, err);
 }
 
-void hmp_netdev_del(Monitor *mon, const QDict *qdict)
+void hmp_netdev_del(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
diff --git a/net/slirp.c b/net/slirp.c
index 9bf09a2c8bc9..d5c190b48b76 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -733,8 +733,9 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *id)
     }
 }
 
-void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
+void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     /* TODO: support removing unix fwd */
     struct sockaddr_in host_addr = {
         .sin_family = AF_INET,
@@ -957,8 +958,9 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     return -1;
 }
 
-void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
+void hmp_hostfwd_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *redir_str;
     SlirpState *s;
     const char *arg1 = qdict_get_str(qdict, "arg1");
@@ -1224,8 +1226,9 @@ UsernetInfoList *qmp_x_query_usernet(Error **errp)
     return head;
 }
 
-void hmp_info_usernet(Monitor *mon, const QDict *qdict)
+void hmp_info_usernet(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     g_autoptr(UsernetInfoList) list = NULL;
     UsernetInfoList *entry;
 
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 47110ca58c0d..16847d1ce261 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -18,8 +18,9 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 
-void hmp_qom_list(Monitor *mon, const QDict *qdict)
+void hmp_qom_list(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *path = qdict_get_try_str(qdict, "path");
     ObjectPropertyInfoList *list;
     Error *err = NULL;
@@ -44,8 +45,9 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_qom_set(Monitor *mon, const QDict *qdict)
+void hmp_qom_set(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const bool json = qdict_get_try_bool(qdict, "json", false);
     const char *path = qdict_get_str(qdict, "path");
     const char *property = qdict_get_str(qdict, "property");
@@ -72,8 +74,9 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_qom_get(Monitor *mon, const QDict *qdict)
+void hmp_qom_get(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *path = qdict_get_str(qdict, "path");
     const char *property = qdict_get_str(qdict, "property");
     Error *err = NULL;
@@ -132,8 +135,9 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
     g_array_free(children, TRUE);
 }
 
-void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
+void hmp_info_qom_tree(MonitorHMP *hmp, const QDict *dict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *path = qdict_get_try_str(dict, "path");
     Object *obj;
     bool ambiguous = false;
@@ -154,8 +158,9 @@ void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
     print_qom_composition(mon, obj, 0);
 }
 
-void hmp_object_add(Monitor *mon, const QDict *qdict)
+void hmp_object_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *options = qdict_get_str(qdict, "object");
     Error *err = NULL;
 
@@ -163,8 +168,9 @@ void hmp_object_add(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
-void hmp_object_del(Monitor *mon, const QDict *qdict)
+void hmp_object_del(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 7b904a141654..ef69d23ff507 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -31,8 +31,9 @@ bool replay_running_debug(void)
     return replay_is_debugging;
 }
 
-void hmp_info_replay(Monitor *mon, const QDict *qdict)
+void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     if (replay_mode == REPLAY_MODE_NONE) {
         monitor_printf(mon, "Record/replay is not active\n");
     } else {
@@ -103,7 +104,7 @@ void qmp_replay_break(int64_t icount, Error **errp)
     }
 }
 
-void hmp_replay_break(Monitor *mon, const QDict *qdict)
+void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
     Error *err = NULL;
@@ -124,7 +125,7 @@ void qmp_replay_delete_break(Error **errp)
     }
 }
 
-void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
 
@@ -209,7 +210,7 @@ void qmp_replay_seek(int64_t icount, Error **errp)
     replay_seek(icount, replay_stop_vm, errp);
 }
 
-void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
     Error *err = NULL;
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index f8e17dcf1ce9..15e7411591ab 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -63,19 +63,19 @@ void replay_vmstate_init(void)
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
-void hmp_info_replay(Monitor *mon, const QDict *qdict)
+void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
-void hmp_replay_break(Monitor *mon, const QDict *qdict)
+void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
-void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
-void hmp_replay_seek(Monitor *mon, const QDict *qdict)
+void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
index b93b471b1b25..f280ad8c4314 100644
--- a/stats/stats-hmp-cmds.c
+++ b/stats/stats-hmp-cmds.c
@@ -187,8 +187,9 @@ static StatsFilter *stats_filter(StatsTarget target, const char *names,
     return filter;
 }
 
-void hmp_info_stats(Monitor *mon, const QDict *qdict)
+void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *target_str = qdict_get_str(qdict, "target");
     const char *provider_str = qdict_get_try_str(qdict, "provider");
     const char *names = qdict_get_try_str(qdict, "names");
diff --git a/stubs/hmp-cmd-info_sev.c b/stubs/hmp-cmd-info_sev.c
index f3624423a334..6f2b87d1ad10 100644
--- a/stubs/hmp-cmd-info_sev.c
+++ b/stubs/hmp-cmd-info_sev.c
@@ -10,7 +10,8 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
-void hmp_info_sev(Monitor *mon, const QDict *qdict)
+void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     monitor_printf(mon, "SEV is not available in this QEMU\n");
 }
diff --git a/system/dirtylimit-hmp-cmds.c b/system/dirtylimit-hmp-cmds.c
index 4928d57cc8e3..4c100783778f 100644
--- a/system/dirtylimit-hmp-cmds.c
+++ b/system/dirtylimit-hmp-cmds.c
@@ -15,8 +15,9 @@
 #include "monitor/monitor.h"
 #include "system/dirtylimit.h"
 
-void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+void hmp_cancel_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
     Error *err = NULL;
 
@@ -30,8 +31,9 @@ void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
                    "dirty limit for virtual CPU]\n");
 }
 
-void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+void hmp_set_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     int64_t dirty_rate = qdict_get_int(qdict, "dirty_rate");
     int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
     Error *err = NULL;
@@ -47,8 +49,9 @@ out:
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
+void hmp_info_vcpu_dirty_limit(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     DirtyLimitInfoList *info;
     g_autoptr(DirtyLimitInfoList) head = NULL;
     Error *err = NULL;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..e27b9724867a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -851,8 +851,9 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
 }
 #undef qdev_printf
 
-void hmp_info_qtree(Monitor *mon, const QDict *qdict)
+void hmp_info_qtree(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     bool details = !qdict_get_try_bool(qdict, "brief", false);
 
     if (sysbus_get_default()) {
@@ -860,7 +861,7 @@ void hmp_info_qtree(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_info_qdm(Monitor *mon, const QDict *qdict)
+void hmp_info_qdm(MonitorHMP *hmp, const QDict *qdict)
 {
     qdev_print_devinfos(true);
 }
@@ -1001,8 +1002,9 @@ void qmp_device_sync_config(const char *id, Error **errp)
     qdev_sync_config(dev, errp);
 }
 
-void hmp_device_add(Monitor *mon, const QDict *qdict)
+void hmp_device_add(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     QemuOpts *opts;
     DeviceState *dev;
@@ -1035,8 +1037,9 @@ out:
     hmp_handle_error(mon, err);
 }
 
-void hmp_device_del(Monitor *mon, const QDict *qdict)
+void hmp_device_del(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *id = qdict_get_str(qdict, "id");
     Error *err = NULL;
 
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index 02d1d42bf392..834b95835339 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -23,8 +23,9 @@
 #include "qobject/qdict.h"
 #include "qemu/accel.h"
 
-void hmp_info_status(Monitor *mon, const QDict *qdict)
+void hmp_info_status(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     StatusInfo *info;
 
     info = qmp_query_status(NULL);
@@ -41,8 +42,9 @@ void hmp_info_status(Monitor *mon, const QDict *qdict)
     qapi_free_StatusInfo(info);
 }
 
-void hmp_one_insn_per_tb(Monitor *mon, const QDict *qdict)
+void hmp_one_insn_per_tb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *option = qdict_get_try_str(qdict, "option");
     AccelState *accel = current_accel();
     bool newval;
@@ -66,8 +68,9 @@ void hmp_one_insn_per_tb(Monitor *mon, const QDict *qdict)
                              newval, &error_abort);
 }
 
-void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
+void hmp_watchdog_action(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     WatchdogAction action;
     char *qapi_value;
diff --git a/system/tpm-hmp-cmds.c b/system/tpm-hmp-cmds.c
index 9ed6ad6c4d46..094c3f16cf50 100644
--- a/system/tpm-hmp-cmds.c
+++ b/system/tpm-hmp-cmds.c
@@ -11,8 +11,9 @@
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 
-void hmp_info_tpm(Monitor *mon, const QDict *qdict)
+void hmp_info_tpm(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
 #ifdef CONFIG_TPM
     TPMInfoList *info_list, *info;
     Error *err = NULL;
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index b4cf048a7c0f..3219f78bd12a 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -83,8 +83,9 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
      }
 }
 
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
+void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUState *cs;
 
     if (qdict_haskey(qdict, "apic-id")) {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 9ed772e6d7f2..f1d2a327ddad 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -209,8 +209,9 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env;
     AddressSpace *as;
 
@@ -535,8 +536,9 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
+void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env;
     AddressSpace *as;
 
@@ -569,8 +571,9 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     }
 }
 
-void hmp_mce(Monitor *mon, const QDict *qdict)
+void hmp_mce(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     X86CPU *cpu;
     CPUState *cs;
     int cpu_index = qdict_get_int(qdict, "cpu_index");
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4d875d10ff23..a3f6ee95aaed 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -784,8 +784,9 @@ SevInfo *qmp_query_sev(Error **errp)
     return info;
 }
 
-void hmp_info_sev(Monitor *mon, const QDict *qdict)
+void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     SevInfo *info = sev_get_info();
 
     if (!info || !info->enabled) {
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 3e0df40a6b8b..0414474f2ffb 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -10,8 +10,9 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
     if (!env1) {
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 7c88e0e2bda0..99eda7351877 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -11,8 +11,9 @@
 #include "monitor/hmp.h"
 #include "cpu.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
     if (!env1) {
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f8042db9cdf3..496d519c978d 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -215,8 +215,9 @@ static void mem_info_svxx(Monitor *mon, CPUArchState *env)
               last_paddr + last_size - pbase, last_attr);
 }
 
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
+void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env;
 
     env = mon_get_cpu_env(mon);
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 50324d3600c4..50da650b2e04 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -38,8 +38,9 @@ static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
                    tlb->d, tlb->wt);
 }
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env = mon_get_cpu_env(mon);
     int i;
 
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 36f3d8d58e9d..09a15b821a1a 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -27,8 +27,9 @@
 #include "monitor/hmp.h"
 
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
     if (!env1) {
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 2af84934f83d..a1082c44e11c 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -26,8 +26,9 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
     if (!env1) {
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index c8f0133abecf..5a8158f4f4b6 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -33,7 +33,7 @@
 #include "trace/simple.h"
 #endif
 
-void hmp_trace_event(Monitor *mon, const QDict *qdict)
+void hmp_trace_event(MonitorHMP *hmp, const QDict *qdict)
 {
     const char *tp_name = qdict_get_str(qdict, "name");
     bool new_state = qdict_get_bool(qdict, "option");
@@ -47,8 +47,9 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict)
 }
 
 #ifdef CONFIG_TRACE_SIMPLE
-void hmp_trace_file(Monitor *mon, const QDict *qdict)
+void hmp_trace_file(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *op = qdict_get_try_str(qdict, "op");
     const char *arg = qdict_get_try_str(qdict, "arg");
 
@@ -71,8 +72,9 @@ void hmp_trace_file(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
+void hmp_info_trace_events(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *name = qdict_get_try_str(qdict, "name");
     TraceEventInfoList *events;
     TraceEventInfoList *elem;
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 4ef459490ba2..5f3522943c56 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -29,7 +29,7 @@
 
 static int mouse_button_state;
 
-void hmp_mouse_move(Monitor *mon, const QDict *qdict)
+void hmp_mouse_move(MonitorHMP *hmp, const QDict *qdict)
 {
     int dx, dy, dz, button;
     const char *dx_str = qdict_get_str(qdict, "dx_str");
@@ -53,7 +53,7 @@ void hmp_mouse_move(Monitor *mon, const QDict *qdict)
     qemu_input_event_sync();
 }
 
-void hmp_mouse_button(Monitor *mon, const QDict *qdict)
+void hmp_mouse_button(MonitorHMP *hmp, const QDict *qdict)
 {
     /* HMP mouse_button bitmask: 1=L, 2=R, 4=M */
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
@@ -71,16 +71,18 @@ void hmp_mouse_button(Monitor *mon, const QDict *qdict)
     mouse_button_state = button_state;
 }
 
-void hmp_mouse_set(Monitor *mon, const QDict *qdict)
+void hmp_mouse_set(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
 
     qemu_mouse_set(qdict_get_int(qdict, "index"), &err);
     hmp_handle_error(mon, err);
 }
 
-void hmp_info_mice(Monitor *mon, const QDict *qdict)
+void hmp_info_mice(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     MouseInfoList *mice_list, *mouse;
 
     mice_list = qmp_query_mice(NULL);
@@ -148,8 +150,9 @@ static void hmp_info_vnc_servers(Monitor *mon, VncServerInfo2List *server)
     }
 }
 
-void hmp_info_vnc(Monitor *mon, const QDict *qdict)
+void hmp_info_vnc(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     VncInfo2List *info2l, *info2l_head;
     Error *err = NULL;
 
@@ -189,8 +192,9 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
 #endif
 
 #ifdef CONFIG_SPICE
-void hmp_info_spice(Monitor *mon, const QDict *qdict)
+void hmp_info_spice(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     SpiceChannelList *chan;
     SpiceInfo *info;
     const char *channel_name;
@@ -260,8 +264,9 @@ out:
 }
 #endif
 
-void hmp_set_password(Monitor *mon, const QDict *qdict)
+void hmp_set_password(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *protocol  = qdict_get_str(qdict, "protocol");
     const char *password  = qdict_get_str(qdict, "password");
     const char *display = qdict_get_try_str(qdict, "display");
@@ -295,8 +300,9 @@ out:
     hmp_handle_error(mon, err);
 }
 
-void hmp_expire_password(Monitor *mon, const QDict *qdict)
+void hmp_expire_password(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *protocol  = qdict_get_str(qdict, "protocol");
     const char *whenstr = qdict_get_str(qdict, "time");
     const char *display = qdict_get_try_str(qdict, "display");
@@ -366,8 +372,9 @@ static int index_from_key(const char *key, size_t key_length)
     return i;
 }
 
-void hmp_sendkey(Monitor *mon, const QDict *qdict)
+void hmp_sendkey(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *keys = qdict_get_str(qdict, "keys");
     KeyValue *v = NULL;
     KeyValueList *head = NULL, **tail = &head;
@@ -456,8 +463,9 @@ void sendkey_completion(ReadLineState *rs, int nb_args, const char *str)
 
 #ifdef CONFIG_PIXMAN
 void coroutine_fn
-hmp_screendump(Monitor *mon, const QDict *qdict)
+hmp_screendump(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     const char *filename = qdict_get_str(qdict, "filename");
     const char *id = qdict_get_try_str(qdict, "device");
     int64_t head = qdict_get_try_int(qdict, "head", 0);
@@ -478,8 +486,9 @@ end:
 }
 #endif
 
-void hmp_client_migrate_info(Monitor *mon, const QDict *qdict)
+void hmp_client_migrate_info(MonitorHMP *hmp, const QDict *qdict)
 {
+    Monitor *mon = MONITOR(hmp);
     Error *err = NULL;
     const char *protocol = qdict_get_str(qdict, "protocol");
     const char *hostname = qdict_get_str(qdict, "hostname");

-- 
2.55.0.543.g5ebe2ebe4ea8

