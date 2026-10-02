Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380E4AD4A9
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972445; cv=none; b=hv8PccHgHPSLlobIX9MgzWYRphLhP4YjQWb4/scs5f8kOgBVaN4sEu0nbbP9GjSPD9/OgnTJSiOJ7yVVDPMgDO9kFkltz0HHBfLi0iZXjZezSvVn8PHy/sciksVT6aW3XCIZaR1o3YTEI9f81pbI7BcA7/3YTuOYRDBH80X5iYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972445; c=relaxed/simple;
	bh=0rbWM1YzyeFukb2Vfq6+ntrBOuw/7JB1XfW++Ev/+hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBE6dho88DyubWCNUSAxMImM8TpYpUmwGs0eDElvRuzhjy3rwOzahSHePsvrmshVGBOK1bHi8OnTyp9c9+ENf6Ql9OSVFoA1kLESDSkqSSc02d/t09MWHQcAp8vo+ZdkJ2e3JNPPo+OygtO7TptpZ4NElevFy6sT04TEGCgZGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoVDZZRD; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoVDZZRD"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so39234965ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972443; x=1791577243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNP3jY90j0VdEmvR33fcLvA6g8lnID0iKbGWLsBD1aY=;
        b=BoVDZZRDJXMI5Sv5Gv2tUS575fvyud/m7/S5F/8umc0pjK7ONMittVB7AuV2dELje8
         eqcgTgbKUVXflJeUPT/d0oIbZRQyDpX43yN9Ser/uAJcgMaBi5QqyHaw/O0kzNJf/pZA
         ZpzCFc+gjM6eMU7ljuZsAi7zKzc9Wh+qUeQwARzrUPPBkbfs1dUJpaxxdMkFwPDP26cG
         cQ085FG0se8ecD67oy4rWxMAKFLBo9/crg74KFYyi22gI4MK7x9sxYX+yGBVDm8OfZ3L
         Bf55Bg0MwgaCogDB56a27i6Y7V1nZ1uIH9pR+xgXyMILkSIv2ZRPBSe+SSjqMaP5i84S
         kgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972443; x=1791577243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNP3jY90j0VdEmvR33fcLvA6g8lnID0iKbGWLsBD1aY=;
        b=xvLMC+VPRwdL4XE2SvpTxti1lbIDmxtrXSXsn7lfA4/1E/YUd7WzfGOvxlq3Nhekmu
         F+5+yaW4K7IO+30kaH7XqfnaSumZmk5J744C/z3fHhWOwrrRmpNmwti/D+IC84/NlZh8
         jlqG/m7Aa1l8sOukCTY/GE2/j+oFpVOeXQVwAe8AeEjG1zc1nFADBC2LMaitKhK3t4tz
         1j8KjOkjb9IWQL3jK0Ve+xLdn/IPT8zpjwfJpP/dP7eXejllMW+eO88aMIAs7mMy5xHB
         1cZDcFyxY/sONO84yQf2G+k6aIrGlDzdbTf3XYB1F0f7ggJqSedeOlO3+tPdzYJrrED+
         6sOA==
X-Forwarded-Encrypted: i=1; AKwUvBw7mXqz7csAlJ6u14l/eHqGwqmjxGYiXVNqAIk0GIBm10jWSngvJYyrUthcyqM+EsYodbc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYWKQ22I0u7/W6iy0wym5xYl+zTeKGoR81+6PY7IiN3x6DNNsD
	05+1wrr9FqzZAGxjUx4qYsyRzz6HPlR4xc0WGa5Qk4qFK4J/c++hZImKyan1znI6rGk=
X-Gm-Gg: AYBFou3IOoiYyNnEwyz5i8y6gR1amhzhOVPqAy/00qGgILqFeBtPjwZk7JIy9hu4733
	2XadMcrVJUXU0+eXSidxxVUB3kc6Qt3jz94Axq21TyPdLHNZ8CjDwbKCiX3aIMv52heBzm2p28K
	1T/OoLBNTv1TdeU7o5OeN9eIN0sGrtzl7WLxp6hOJ7qHRJiR7LanMzdKPjci3mRfR5cnRFf6lCj
	Q/gkohzjPWJ10SCDZiSdFcSh/F7/scDefeV+Hc6/WXosIrv1hA+8bHTdCNYpNeYuBgNIP8kF8CW
	FK+N/EuDaecA86fV13XGuk9TTHGnWduVdUtgegWU8k9Ob/QS7SbKB/p60MMrQIWs1EXGGz/D9tQ
	HvLd6q88XG7ULFZsvNYCkjhL7MLZlgBm2vxBUGxEh66u8MMuyfQirzRQc/746Np7TM6MPRWq9CH
	lx1IyLIfu9fVdGgRWmO9GolMGGMlAIEewkynKr52OfWyERdlGobhKg2hQuZ5HtsXBIMX+ZJcSfG
	NFaihKcNhA3BxVBUMXScoaz
X-Received: by 2002:a17:902:e5c5:b0:2d9:464f:d45f with SMTP id d9443c01a7336-2e49b0bf382mr35608605ad.5.1790972443297;
        Fri, 02 Oct 2026 13:20:43 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:42 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 08/22] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Fri,  2 Oct 2026 14:20:12 -0600
Message-ID: <20261002202026.1204110-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a Rom notifier to keep track of binary blobs loaded in Realm memory.
That way we can deterministically calculate the Realm Initial Measurement (RIM).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/core/loader.c         | 24 +++++++++++++++++++++++
 include/hw/core/loader.h | 17 +++++++++++++++++
 target/arm/kvm-rme.c     | 41 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

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
index d9431e8a8d12..fdfddfa7443e 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 ssize_t rom_add_vga(const char *file);
 ssize_t rom_add_option(const char *file, int32_t bootindex);
 
+typedef struct RomLoaderNotifyData {
+    /* Address of the blob in guest memory */
+    hwaddr addr;
+    /* Length of the blob */
+    size_t len;
+    /* Blog data */
+    uint8_t *data;
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
index f7c2cc786e2c..b1fb8957f3de 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -22,8 +23,16 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+    uint8_t *data;
+} RmeRamRegion;
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -41,6 +50,35 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
     kvm_mark_guest_state_protected();
 }
 
+static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
+{
+    const RmeRamRegion *ra = a;
+    const RmeRamRegion *rb = b;
+
+    g_assert(ra->base != rb->base);
+    return ra->base < rb->base ? -1 : 1;
+}
+
+static void rme_rom_load_notify(Notifier *notifier, void *data)
+{
+    RmeRamRegion *region;
+    RomLoaderNotifyData *rom = data;
+
+    region = g_new0(RmeRamRegion, 1);
+    region->base = rom->addr;
+    region->size = rom->len;
+    region->data = rom->data;
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
@@ -58,6 +96,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
-- 
2.43.0

