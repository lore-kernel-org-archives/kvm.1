Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA938F230
	for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786907750; cv=none; b=WjxfDTWZ9rzD8TbjZlUHNOc/Jf+lWcIlcH4xx7QA//9klxScq7QRdSjAo4IR1d5rr/42nzTCHDiAK+NHVL6un/QhxqMToBtKgo1ypGAnEvlKhxNRMkZY3sLpe2Stsnbb4TEDBltMaAay/yecTLPNv2/K4mIbwIfKMV0ZCrLENwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786907750; c=relaxed/simple;
	bh=Ib6IfJ0HEinibhIBSyX2zg3ClEePEgT13ZARpoCDBaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hReFs6cAusUD0tF1z5E9fdZhoXuTjouglJ051llry60DGCS/ivldkwYw5Nk2vGcDK5Mjd/TSLOgYfBT9GFJfBKOUwa04EZD8XhXhAn7WPkWIPMjDCw8MPziHkrQuEAvKzD5zX4AKCpdKW2C6iofDf+j6H0aHENyXN2RBSBNlOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RS6xT9hZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS6xT9hZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786907744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p62GCegeiAbN8avbY+rYDFyGzkNBZgUvUaLFnpCm4zk=;
	b=RS6xT9hZTUel3dveQuUqCLG8blv9Adsglv/ORHobtnB3w7bgm42g5V/3pl98EpLgPMpoCI
	7jQidC6JM+k8xTB9U/PfoSvjhtTmUKkZUM/YVFagJbVC+Qx/KeSx65utYF9csX8O6Fwh5d
	0WyZBUsv2RjInail4Zm/BRPLF8gySRk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-RoaN7fViPqi2ip21ij3Dxg-1; Sun,
 16 Aug 2026 15:15:40 -0400
X-MC-Unique: RoaN7fViPqi2ip21ij3Dxg-1
X-Mimecast-MFC-AGG-ID: RoaN7fViPqi2ip21ij3Dxg_1786907736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B75DD19560A6;
	Sun, 16 Aug 2026 19:15:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A28818005BB;
	Sun, 16 Aug 2026 19:15:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:08 +0400
Subject: [PATCH v3 41/49] Guard HMP command implementations with CONFIG_HMP
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-41-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=20643;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ib6IfJ0HEinibhIBSyX2zg3ClEePEgT13ZARpoCDBaQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggu0jdPYRUG1PHQ7Aba9yeCjPknjKg2WvKulU
 hxRfFOJEhyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILtAAKCRDa6OEJdZac
 5RZwD/9LL5Sl4mdrZrNjtVdu/w2gAa9YGZ4NV7H98Rv78ROfgaZGNhOblRkLPbXJbOaX81y0W6K
 /G0cdPkozuTPYOFnhektogGlXlruev94HiFu0uwyeBFmP+VpREwWxwdW/cwBGG+LuRRW7Qq855F
 4mXUNSLPA9NKr6BDli+Pj/zAHbhdVp38E6zel1x339SuByhfIe17MQTWL6UN/pPIZvO8flCzFcA
 NNHQlB5YTgcpgpEBIkFa4yI0+WUWer3eKLbTh40YZVTILIsYi6u2JB9KIbhXBBALdCmpkUvED+j
 NydM+3+wxV23rW0YH/rf7vUkxZdVwuNL4o0i3qWQEohFFSwiHvCFU5pgUPfgZ+lVGFWIKhYNBvy
 gWjrjGy/b6g3mweMuLi1aDsV/LGo6nlvbTuUnNXqudeA2620Eb3z+NIJ42FCUMvvNIpRvppwM1I
 B/xGJPRgZi2emhFJ4pRWtD6BW/gKAsnu1ZLG+5RTVhYPVKTwICw7NyE0I/9+fdvuzsbUooAbor+
 t106GT+4KB3Go2gfyxJ5TQWu6LKXPvib0f+fOx5kLqr+hgIcVI9aInnTdRBhTYClB+/RZlBNiRw
 HOCnRQ4qUJ31qIPHoJVC8V6NsdTJ+aOaXgbAgeI84FEWw5atYIESPEcXCy9vBJOVtDux63cwuNz
 qwIldCUOayI7F9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add #ifdef CONFIG_HMP around all hmp_* function implementations and
their HMP-only helpers across subsystems.

This covers monitor_register_hmp* callers, hmp_info_* handlers, and
HMP-only helper functions like slirp_lookup.

To link succesfully, use empty cmds tables in hmp-cmds.c (to be removed
once meson build-sys is updated with !hmp support later in the series)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/accel-system.c      | 2 ++
 accel/tcg/monitor.c       | 2 ++
 hw/i386/kvm/xen-stubs.c   | 2 ++
 hw/i386/kvm/xen_evtchn.c  | 3 +++
 hw/i386/sgx.c             | 2 ++
 hw/misc/mos6522-stub.c    | 2 ++
 hw/misc/mos6522.c         | 2 ++
 hw/pci/pci-stub.c         | 2 ++
 hw/s390x/s390-skeys.c     | 2 ++
 hw/s390x/s390-stattrib.c  | 4 ++++
 hw/uefi/ovmf-log.c        | 2 ++
 hw/usb/host-libusb.c      | 6 ++++++
 migration/dirtyrate.c     | 2 ++
 monitor/hmp-cmds.c        | 5 +++++
 net/slirp.c               | 7 ++++++-
 replay/replay-debugging.c | 8 ++++++++
 replay/stubs-system.c     | 6 ++++++
 system/qdev-monitor.c     | 4 ++++
 target/i386/cpu-apic.c    | 2 ++
 target/i386/monitor.c     | 3 +++
 target/i386/sev.c         | 2 ++
 target/m68k/monitor.c     | 2 ++
 target/ppc/monitor.c      | 2 ++
 target/riscv/monitor.c    | 3 +++
 target/sh4/monitor.c      | 2 ++
 target/sparc/monitor.c    | 2 ++
 target/xtensa/monitor.c   | 2 ++
 27 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 977804c4048a..1325b23864c8 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -109,7 +109,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
 
 static void accel_ops_class_init(ObjectClass *oc, const void *data)
 {
+#ifdef CONFIG_HMP
     monitor_register_hmp_info_hrt("accel", qmp_x_accel_stats);
+#endif
 }
 
 static const TypeInfo accel_ops_type_info = {
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 74170ddef708..5570d60753d6 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -30,9 +30,11 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+#ifdef CONFIG_HMP
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
 }
 
 type_init(hmp_tcg_register);
+#endif
diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index 5ed71583281a..a68c739a9496 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -40,6 +40,7 @@ void xen_primary_console_set_be_port(uint16_t port)
 {
 }
 
+#ifdef CONFIG_HMP
 void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
 {
     monitor_hmp_printf(hmp, "XEN emulation is not available in this QEMU\n");
@@ -49,3 +50,4 @@ void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
 {
     monitor_hmp_printf(hmp, "XEN emulation is not available in this QEMU\n");
 }
+#endif
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index b2135020f27f..9379383e5325 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2344,6 +2344,7 @@ void qmp_xen_event_inject(uint32_t port, Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_xen_event_list(MonitorHMP *hmp, const QDict *qdict)
 {
     EvtchnInfoList *iter, *info_list;
@@ -2391,3 +2392,5 @@ void hmp_xen_event_inject(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "Delivered port %d\n", port);
     }
 }
+
+#endif
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 634e33e819ce..11bcc7ad9a5a 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -234,6 +234,7 @@ SgxInfo *qmp_query_sgx(Error **errp)
     return info;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
@@ -265,6 +266,7 @@ void hmp_info_sgx(MonitorHMP *hmp, const QDict *qdict)
     monitor_hmp_printf(hmp, "total size=%" PRIu64 "\n",
                        size);
 }
+#endif
 
 bool check_sgx_support(void)
 {
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
index 154cd32ed88b..d1c141450e67 100644
--- a/hw/misc/mos6522-stub.c
+++ b/hw/misc/mos6522-stub.c
@@ -10,7 +10,9 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
 {
     monitor_hmp_printf(hmp, "MOS6522 VIA is not available in this QEMU\n");
 }
+#endif
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 1c20c7582c34..3135761a0f7b 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -497,6 +497,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     }
 }
 
+#ifdef CONFIG_HMP
 static int qmp_x_query_via_foreach(Object *obj, void *opaque)
 {
     GString *buf = opaque;
@@ -597,6 +598,7 @@ void hmp_info_via(MonitorHMP *hmp, const QDict *qdict)
     }
     monitor_puts(mon, info->human_readable_text);
 }
+#endif /* CONFIG_HMP */
 
 static const MemoryRegionOps mos6522_ops = {
     .read = mos6522_read,
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 7e2797300ba0..5fc3322627e3 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -34,6 +34,7 @@ PciInfoList *qmp_query_pci(Error **errp)
     return NULL;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_pci(MonitorHMP *hmp, const QDict *qdict)
 {
 }
@@ -42,6 +43,7 @@ void hmp_pcie_aer_inject_error(MonitorHMP *hmp, const QDict *qdict)
 {
     monitor_hmp_printf(hmp, "PCI devices not supported\n");
 }
+#endif
 
 /* kvm-all wants this */
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index b5e56a16cce1..c615c9dbc8a1 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -104,6 +104,7 @@ static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_skeys(MonitorHMP *hmp, const QDict *qdict)
 {
     S390SKeysState *ss = s390_get_skeys_device();
@@ -144,6 +145,7 @@ void hmp_dump_skeys(MonitorHMP *hmp, const QDict *qdict)
         error_report_err(err);
     }
 }
+#endif
 
 void s390_qmp_dump_skeys(const char *filename, Error **errp)
 {
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 644298f7f0b2..e47a8ea36597 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -32,6 +32,7 @@
 #define STATTR_FLAG_ERROR   0x04ULL
 #define STATTR_FLAG_DONE    0x08ULL
 
+#ifdef CONFIG_HMP
 static S390StAttribState *s390_get_stattrib_device(void)
 {
     S390StAttribState *sas;
@@ -40,6 +41,7 @@ static S390StAttribState *s390_get_stattrib_device(void)
     assert(sas);
     return sas;
 }
+#endif
 
 void s390_stattrib_init(void)
 {
@@ -59,6 +61,7 @@ void s390_stattrib_init(void)
 
 /* Console commands: */
 
+#ifdef CONFIG_HMP
 void hmp_migrationmode(MonitorHMP *hmp, const QDict *qdict)
 {
     S390StAttribState *sas = s390_get_stattrib_device();
@@ -110,6 +113,7 @@ void hmp_info_cmma(MonitorHMP *hmp, const QDict *qdict)
 out:
     g_free(vals);
 }
+#endif
 
 /* Migration support: */
 
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 0249eea2cfe9..c4e6a5064106 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -256,6 +256,7 @@ FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
     return ret;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
 {
     g_autofree gchar *log_esc = NULL;
@@ -284,3 +285,4 @@ void hmp_info_firmware_log(MonitorHMP *hmp, const QDict *qdict)
     log_esc = g_strescape((gchar *)log_out, "\r\n");
     monitor_hmp_printf(hmp, "%s\n", log_esc);
 }
+#endif
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 9b9f26a1078e..564fe9a54795 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -184,6 +184,7 @@ static void usb_host_attach_kernel(USBHostDevice *s);
 # define HAVE_SUPER_PLUS 1
 #endif
 
+#ifdef CONFIG_HMP
 static const char *speed_name[] = {
     [LIBUSB_SPEED_UNKNOWN] = "?",
     [LIBUSB_SPEED_LOW]     = "1.5",
@@ -194,6 +195,7 @@ static const char *speed_name[] = {
     [LIBUSB_SPEED_SUPER_PLUS] = "5000+",
 #endif
 };
+#endif
 
 static const unsigned int speed_map[] = {
     [LIBUSB_SPEED_LOW]     = USB_SPEED_LOW,
@@ -1815,7 +1817,9 @@ module_kconfig(USB);
 static void usb_host_register_types(void)
 {
     type_register_static(&usb_host_dev_info);
+#ifdef CONFIG_HMP
     monitor_register_hmp("usbhost", true, hmp_info_usbhost);
+#endif
 }
 
 type_init(usb_host_register_types)
@@ -1920,6 +1924,7 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
 {
     libusb_device **devs = NULL;
@@ -1963,3 +1968,4 @@ void hmp_info_usbhost(MonitorHMP *hmp, const QDict *qdict)
     }
     libusb_free_device_list(devs, 1);
 }
+#endif
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index bdbb2aaa99db..776611fef79c 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -856,6 +856,7 @@ struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
         has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND);
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
 {
     DirtyRateInfo *info = query_dirty_rate_info(TIME_UNIT_SECOND);
@@ -932,3 +933,4 @@ void hmp_calc_dirty_rate(MonitorHMP *hmp, const QDict *qdict)
                        " seconds\n", sec);
     monitor_hmp_printf(hmp, "[Please use 'info dirty_rate' to check results]\n");
 }
+#endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 1834e3c1f697..3ac70c3f1123 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -42,6 +42,7 @@
 #include "disas/disas.h"
 
 /* Please update hmp-commands.hx when adding or changing commands */
+#ifdef CONFIG_HMP
 static HMPCommand hmp_info_cmds[] = {
 #include "hmp-commands-info.h"
     { NULL, NULL, },
@@ -52,6 +53,10 @@ static HMPCommand hmp_cmds[] = {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
+#else
+static HMPCommand hmp_info_cmds[] = { { NULL, NULL, }, };
+static HMPCommand hmp_cmds[] = { { NULL, NULL, }, };
+#endif
 
 HMPCommand *hmp_cmds_for_target(bool info_command)
 {
diff --git a/net/slirp.c b/net/slirp.c
index 6fbefa9ed1d7..451c0fd1ba4a 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -711,6 +711,7 @@ error:
     return -1;
 }
 
+#ifdef CONFIG_HMP
 static SlirpState *slirp_lookup(MonitorHMP *hmp, const char *id)
 {
     if (id) {
@@ -801,6 +802,7 @@ void hmp_hostfwd_remove(MonitorHMP *hmp, const QDict *qdict)
  fail_syntax:
     monitor_hmp_printf(hmp, "invalid format\n");
 }
+#endif
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
@@ -957,6 +959,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     return -1;
 }
 
+#ifdef CONFIG_HMP
 void hmp_hostfwd_add(MonitorHMP *hmp, const QDict *qdict)
 {
     const char *redir_str;
@@ -977,8 +980,8 @@ void hmp_hostfwd_add(MonitorHMP *hmp, const QDict *qdict)
             error_report_err(err);
         }
     }
-
 }
+#endif
 
 #if defined(CONFIG_SMBD_COMMAND)
 
@@ -1224,6 +1227,7 @@ UsernetInfoList *qmp_x_query_usernet(Error **errp)
     return head;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_usernet(MonitorHMP *hmp, const QDict *qdict)
 {
     g_autoptr(UsernetInfoList) list = NULL;
@@ -1237,6 +1241,7 @@ void hmp_info_usernet(MonitorHMP *hmp, const QDict *qdict)
                            ui->hub_name, ui->info);
     }
 }
+#endif
 
 static void
 net_init_slirp_configs_host(const NetdevUserHostForwardList *fwd)
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 965565715ef2..4b741ea1027b 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -31,6 +31,7 @@ bool replay_running_debug(void)
     return replay_is_debugging;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
@@ -42,6 +43,7 @@ void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
             replay_get_filename(), replay_get_current_icount());
     }
 }
+#endif
 
 ReplayInfo *qmp_query_replay(Error **errp)
 {
@@ -103,6 +105,7 @@ void qmp_replay_break(int64_t icount, Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
@@ -114,6 +117,7 @@ void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 }
+#endif
 
 void qmp_replay_delete_break(Error **errp)
 {
@@ -124,6 +128,7 @@ void qmp_replay_delete_break(Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
@@ -134,6 +139,7 @@ void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 }
+#endif
 
 static char *replay_find_nearest_snapshot(int64_t icount,
                                           int64_t *snapshot_icount)
@@ -209,6 +215,7 @@ void qmp_replay_seek(int64_t icount, Error **errp)
     replay_seek(icount, replay_stop_vm, errp);
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
@@ -220,6 +227,7 @@ void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 }
+#endif
 
 static void replay_stop_vm_debug(void *opaque)
 {
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 15e7411591ab..70eaf1834032 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -63,22 +63,28 @@ void replay_vmstate_init(void)
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_replay(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_break(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_delete_break(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_seek(MonitorHMP *hmp, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+#endif
+
 ReplayInfo *qmp_query_replay(Error **errp)
 {
     error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 13ac9f8f3be1..5c87fda50939 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -763,6 +763,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return ret;
 }
 
+#ifdef CONFIG_HMP
 #define qdev_printf(fmt, ...) \
     monitor_hmp_printf(hmp, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
@@ -865,6 +866,7 @@ void hmp_info_qdm(MonitorHMP *hmp, const QDict *qdict)
 {
     qdev_print_devinfos(true);
 }
+#endif /* CONFIG_HMP */
 
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
@@ -1002,6 +1004,7 @@ void qmp_device_sync_config(const char *id, Error **errp)
     qdev_sync_config(dev, errp);
 }
 
+#ifdef CONFIG_HMP
 void hmp_device_add(MonitorHMP *hmp, const QDict *qdict)
 {
     Error *err = NULL;
@@ -1044,6 +1047,7 @@ void hmp_device_del(MonitorHMP *hmp, const QDict *qdict)
     qmp_device_del(id, &err);
     hmp_handle_error(hmp, err);
 }
+#endif
 
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 5d69ece15034..b6ddb5e268de 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -80,6 +80,7 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
      }
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUState *cs;
@@ -102,3 +103,4 @@ void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
     }
     x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
 }
+#endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 46762540ba65..ce61132e0f53 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -31,6 +31,8 @@
 #include "qapi/qapi-commands-misc.h"
 #include "system/memory.h"
 
+#ifdef CONFIG_HMP
+
 /* Perform linear address sign extension */
 static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
 {
@@ -595,3 +597,4 @@ void hmp_mce(MonitorHMP *hmp, const QDict *qdict)
     }
     hmp_handle_error(hmp, err);
 }
+#endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 36a62e58be95..3c6a19b79784 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -754,6 +754,7 @@ SevInfo *qmp_query_sev(Error **errp)
     return info;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
 {
     SevInfo *info = sev_get_info();
@@ -787,6 +788,7 @@ void hmp_info_sev(MonitorHMP *hmp, const QDict *qdict)
 out:
     qapi_free_SevInfo(info);
 }
+#endif
 
 static int
 sev_get_pdh_info(int fd, guchar **pdh, size_t *pdh_len, guchar **cert_chain,
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 23c25283b27a..e8b1b25a43c4 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -10,6 +10,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
@@ -21,3 +22,4 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 
     dump_mmu(env1);
 }
+#endif
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 6e8a075f5a41..5a21c01593b9 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -11,6 +11,7 @@
 #include "monitor/hmp.h"
 #include "cpu.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
@@ -21,3 +22,4 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 59cc04b3d0fb..7e61ae2a4717 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -39,6 +39,8 @@
 #define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"
 #endif
 
+#ifdef CONFIG_HMP
+
 /* Perform linear address sign extension */
 static target_ulong addr_canonical(int va_bits, target_ulong addr)
 {
@@ -244,6 +246,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 
     mem_info_svxx(hmp, env);
 }
+#endif /* CONFIG_HMP */
 
 #ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 62998a9a57cb..14261c059706 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 static void print_tlb(MonitorHMP *hmp, int idx, tlb_t *tlb)
 {
     monitor_hmp_printf(hmp, " tlb%i:\t"
@@ -55,3 +56,4 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     for (i = 0 ; i < UTLB_SIZE ; i++)
         print_tlb(hmp, i, &env->utlb[i]);
 }
+#endif
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 36f109cbb568..ed1e76fe73f8 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -27,6 +27,7 @@
 #include "monitor/hmp.h"
 
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
@@ -37,3 +38,4 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index b9c4089b0fb1..e0fcac8565dc 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
@@ -36,3 +37,4 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif

-- 
2.55.0.543.g5ebe2ebe4ea8

