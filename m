Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263493;
	b=Ob/dUDyDhjQ+As6Ie+OfQUDpHB/Pxa0RVNBrKbuMPPFL/VEhSE7GimTpKkVpI5NwDjRf
	 gNO5rgj1eHLH2W+b4BcyIL9VFKOXc4q1mp8R23jn8maSyXY0ePRBVI18EWI7ElRIpLIew
	 zjGhKNygWsGJHWUIYLEsP7KDuxRmez6NVRkfRozH24mrio7GtLUw7i1mZdycfV4zmnmHp
	 qLRAgTlHgu2mwW4poPIEps3i/Ul9wgo/qJ4Jc8eWn/HgVWtT7A3DJdXChjvQaNDA/qFHS
	 raRys8Z20pM9MH375w6LqquXQPwyVMoMTE9+Y1BBJlG+fZly9Y+nT1zCJFVLnxk8Hng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l7cfw0TdjsR+3R0sW/rw9uWVrC9z73bNOgT/MeSJe90=;
	b=XXSsENhFaOZWeHokmsFY0oXC/eQdvUXTdFUqzYj88aTUbNf9SN4xFgg2gGBTso4wb5yl
	 IgZMVjoYKyPN/ST4gBaoVI7SJmfLci7IzEZhqRMssDI/liySUANaI0dXVd08M795sSj2b
	 BNBNXgpI4iuucFzQOD9/JC4uqPXzhEcYwepAPJINFmuuTN4DYdbtKEugSQqMKofguw06K
	 EmLuXWyfLcQMPpIVFaecTmCTEUUaEE9nLpIxZiByiTSprkbnNA5zrYMOknr0PojYUi2ut
	 x+UbASdVd5W8whu67MUENXLbkQHgBK30zxN/XPdFYNGt6xyX72ARm03YCYuk6c0Jezw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tLanvuIX;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04AA606A331
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F04AA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tLanvuIX
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89d6bd67045so703088b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263492; x=1794868292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7cfw0TdjsR+3R0sW/rw9uWVrC9z73bNOgT/MeSJe90=;
        b=tLanvuIXxbYYeUaaAaa31VSuUDHXaNMPKyV9EmyCvL+YD5fJQaqFYr/+/yiGM3pA2V
         ZOjZoD8cv8tNZT4eZ4ZfhItladfJTrBsbeaPUA77yS3yIbyGHxsW2NYQmM2rWGYKDp/6
         da9126kE/uq2kTBMEc82Lf8gZesSujMPUai4OadYbAVDTeJ4PsTbVrM0WLhpSHSs09ra
         1rhPq6pgMViONseajdZBIjxldK2NmTHX9pkCoDm//QDm6SJRqkblU0cQTrIStuT86NJz
         Ry/gyMobia6rDbdQnLzhFGYFaazMjn7mESg52/LjXUSqWM6cL92kfTlx3KpgaQKBJP71
         ft0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263492; x=1794868292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7cfw0TdjsR+3R0sW/rw9uWVrC9z73bNOgT/MeSJe90=;
        b=IOlTjOjQq1dBBp78U9BpKZH1fJL/fyyWK0Df1+OUE/1u4Us0v43t1ZBPuHAAJIRU8F
         lMr7TXcej8ydIndp6QqeD/qWB/GSXtUZpIi/9/mCuRaQdBGaH2+my/jH/8qtlfaneObw
         qsrYGmypU9P/hZrO1SPvtDvocMREQkv1R2KfdK+c6FfrlmcXjkYUe2avIrd3ijGo7CjR
         O4y+jFUaUDGu5tebnwNG89kpI+SHdpCLljmIGzgQmYUlRxP21nqWbcuLvHk6/8kNHzjE
         ivS7lo16V3fDXnL8T4X1a/gnSdquwL9GQeCAW4bW1qv3Hbb9Row0UcjbqSbgjJo2HjBI
         VvbQ==
X-Forwarded-Encrypted: i=1; AL+hErFJuqsNN0vRqcSdu59TqZafxHdncmLTVlKxm9pak4AcSO0yxMuezc74LSudTtTOO95TfD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZCYW4odvarTg7hlpuKvxcdXCJQc8Pg8M0twC/75spndnN162D
	tFraoTYoKEPpxys4Osb0ERCCtd2r7DuAVt4ldadbXLEQM7MgDbqO7nhAmQu/ylhRMSE=
X-Gm-Gg: AYBFou1KRMq33NIOVHJIwgsuHCQ3DtqcR26tXtqdcWiDCNxwK7rYcEWOnBY+WEibO3H
	mYFZRUBz2oOiz0uJcm3IFKulmNr5MOvNq9zPwUVw6Lsdsif0ryLgZ5j5/foHM2bCnI4qAiLVOvv
	dbSEwXQs51BW0DHrZVm8e02CnvcVhKdwFUaFv/jocTi7RAweo92P5ZKiMYfFwF9MehvW9NRjC0z
	pxza7q1O53xgHhyqozSP9+J7WDIyg0NHtgsYUdC/6NQbxCMA92F5YfF1bJZObDBfZ31P5DG9p6x
	6mA53PEB79tX03VbHhe6Tq7getfs+Z4v7eTDArQFnsq6yf6SUQ7IhAa+HWsNSCL4DT+6PXRP47n
	GTX/xkF7MyeFJ7Ifa4Jj4vfvtTgD1jhyLiuhvtOatE2c9VcxpI9rBx8vT/Q4MJgPzt0ByyTphEa
	daf1k6Sqgik11v9YIrdYDdcMp/goGeHEptYW0snQ6JVP3leiKUt+iRVWhneD/NSSDPtAtEjyuaq
	hu/+9ZOTXimHnYmR25jdg2PrzROnMWDbRg7608X3puEH9w+Xw4ucMsgbpDTW/ynWi4W7/C++KdG
	8i7Jfs0Pvnx4VD3DNehNy6Fugd00rtyDaV8IaZPp/QrzH/u2FXJcJg==
X-Received: by 2002:a05:6a00:b610:b0:881:e266:c3d8 with SMTP id d2e1a72fcca58-8ba98c48edcmr546467b3a.35.1794263492240;
        Mon, 09 Nov 2026 14:31:32 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:31 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 09/23] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Mon,  9 Nov 2026 16:30:56 -0600
Message-ID: <20261109223110.1619504-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 24 ++++++++++++++++++++++++
 include/hw/core/loader.h | 14 ++++++++++++++
 target/arm/kvm-rme.c     | 30 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d2..644d55c9e0ed 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -74,6 +74,8 @@
 #endif
 
 static int roms_loaded;
+static NotifierList rom_loader_notifier =
+    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
 
 /* return the size or -1 if error */
 int64_t get_image_size(const char *filename, Error **errp)
@@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
     return mr;
 }
 
+void rom_add_load_notifier(Notifier *notifier)
+{
+    notifier_list_add(&rom_loader_notifier, notifier);
+}
+
 /* This function is specific for elf program because we don't need to allocate
  * all the rom. We just allocate the first part and the rest is just zeros. This
  * is why romsize and datasize are different. Also, this function takes its own
@@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
 static void rom_reset(void *unused)
 {
     Rom *rom;
+    RomLoaderNotifyData notify;
 
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
@@ -1290,6 +1298,22 @@ static void rom_reset(void *unused)
         address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
 
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
+
+        if (rom->addr == -1) {
+            /*
+             * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+             * Instead the firmware will load them via fw_cfg and measure them
+             * itself.
+             */
+            continue;
+        }
+
+        notify = (RomLoaderNotifyData) {
+            .addr = rom->addr,
+            .len = rom->datasize,
+            .data = rom->data,
+        };
+        notifier_list_notify(&rom_loader_notifier, &notify);
     }
 }
 
diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d9431e8a8d12..e22f587627f5 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,20 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    hwaddr  addr;   /* Address of the blob in guest memory */
+    size_t  len;    /* Length of the blob */
+    uint8_t *data;  /* Blob data */
+} RomLoaderNotifyData;
+
+/**
+ * rom_add_load_notifier - Add a notifier for loaded images
+ *
+ * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
+ * each blob loaded into guest memory, after the blob is loaded.
+ */
+void rom_add_load_notifier(Notifier *notifier);
+
 /* This is the usual maximum in uboot, so if a uImage overflows this, it would
  * overflow on real hardware too. */
 #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index b3edfa8e0a95..ca90bf5af890 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -24,6 +25,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -41,6 +44,30 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     kvm_mark_guest_state_protected();
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+    const RomLoaderNotifyData *ra = a;
+    const RomLoaderNotifyData *rb = b;
+
+    g_assert(ra->addr != rb->addr);
+    return ra->addr < rb->addr ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RomLoaderNotifyData *region = g_memdup2(data,
+                                            sizeof(struct RomLoaderNotifyData));
+
+    /*
+     * The Realm Initial Measurement (RIM) depends on the order in which we
+     * initialize and populate the RAM regions. To help a verifier
+     * independently calculate the RIM, sort regions by GPA.
+     */
+    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
+                                                   region,
+                                                   rme_compare_ram_regions);
+}
+
 static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -58,6 +85,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
-- 
2.53.0

