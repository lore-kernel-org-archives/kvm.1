Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2333DC4CF
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464214; cv=none; b=RLgLeUDl8RIBT7Uo74xpreUjcZF7g2P71A/yp/5ooDC+GriI/vt8/fYXyDnC6Paoo+fsxihqckD7Gbe3wfj8t6jBmyBESFIK4NE8TY+yfmaZt8m4r1aWVkNV+3JgIOv/yuDgLHLNFzW64vexqc7LrE1dITvl0TkYDE3JkJQeIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464214; c=relaxed/simple;
	bh=stchT6L/K8dWZunu3oHZUO7a24I0yZ74WFvMxU+U4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+mz22kelM05aALQGX+Q0nqY08T/7PRPccOqbO/CqSAdgIYj696VRquDtZPUlEDAzRiZT9Kl3yYmBe8nhtpj/xhkgTywDa49GObVEkGxEY6Po9iyXLnV8zUObW+P3ELKT/ESZ/VpSf23xdcz/pGnM5/51frFAd+VqBhVk+IU8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HK8u6KFu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK8u6KFu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cace91f112so824955ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464212; x=1784069012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tjTKQ+pNbBLpWy4623zrp+MUjeVCpuJZYWOZQR0J4OM=;
        b=HK8u6KFuw0EMAcOSJuvfrM3orykF+ES7V06FQ8XIwvsOaCDDhl4zyc+Uf2f/Z4Akip
         80i9o4x9Pzu1UMnKlMFcCeCbiLkQPdGiUhJ6ZDy/Xl9vfOFWEuFBKelM6fd8/wo0CNS5
         QvJGNA2x+CpmxMWosOlTwIw8XgpANxoc5LV9TEgkx/qQ6+LDEf9P7CsL2HhZcYfkNgHQ
         AZ8u3+9nutH4XwhrK/sKNjIfaw2Ym/Du3K7Da3Et5lZRsyVOshuM1z2L61bXn4e+SzAp
         2tCgtNZKWo5Sccz1MsQAnqJr4pUpiZIiYRQzlL+s0/OKigHQtu4I8E9zP/1q/jLKqHr1
         K2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464212; x=1784069012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tjTKQ+pNbBLpWy4623zrp+MUjeVCpuJZYWOZQR0J4OM=;
        b=sKZXUj1sQCeuf5u4GWgyunjETy76YjH5la3SP9gN+2Rute2qzTEkyLNmoXBAWaCKPF
         a5llh+jhxNFqackT2QuToIaAULtVqSnkTHfNoGhu8VlSzKt7/LBV4jyJL89lfODBAoMJ
         XDIiJOmB5Yd12RPEbWz7k5kVAVOcZvCH+cHS7JMG+rMfZ/vp8Qiuu4ZM2mZcJhaSBwJy
         QQupzcVlLj7v9QJkPX/rGKBu2eNIt0mtW/ESpunZ6OMkAB4PgZbfBLZTrRrIKPIlRu7F
         OFOfa1fclc/2A07zPlQ/ZxDhpUrYHYdMLMWA5YDZezqBUNgL56Gu7OQkXiiMvdnJQ+2t
         wiEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/n3TwU+3qQGAzOq7LmtcJkCJZMCdGhO29gsuOrydnypowccrJsL1K5ORVIj+jDwlAHhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVFwHYfZ7QLoKGciMy3ddkgQQ3KgBDHY1RRTwkMbDs0UHMulu
	XcbI0AQ8ubH2Rwfg27ywSOlf3ufpVhCe50SR2qMrySlqbLijX1UFwmW9ftME5PExIUU=
X-Gm-Gg: AfdE7cmVgvGD2H2ymOg5rKkS+kMdd2GWakN1yVNAfnFZGtmhW+vXHyAPohpGI0AcYQ6
	ywvVFz6Xn50kSUfQ+XMhwV3PmToYFzLMFawrduIvHniaYIgyBEAGQS26TZGpx7sS/y7O2+2kkfn
	bKer7GSCXdNnvPdr4f/FFnwY6MdORazq/djqmvbqxRU83sE9i64+No9mhpv6BAPtadmQUbWGdDS
	5pOOokZGck6tRs/shGqQxy8kJDqu4k0vL53pI6Yu9G9HI2Y08mwB+LugrSZUkkDkw3nhc0qabVP
	VWjN0PtTg54Wl8qdhq3MiE+jtMghfFpjRPnSYFihQbjU6LG69YeEq+m6UV96YO5wTgvG5SXlz1z
	VbODdAaNxy9zFp6gDxC3yzbh0hKI0lNebGE3ChfTdvbmoSP5LKsXrOtVBXgoBOIYoquDzlz438U
	B6rN021hvI4tdk8nWQv2J4Dt7bg0yN9NWJpIib0zc=
X-Received: by 2002:a17:903:3550:b0:2c9:d539:61e7 with SMTP id d9443c01a7336-2ccbe6267f4mr64613375ad.19.1783464212055;
        Tue, 07 Jul 2026 15:43:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:31 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 11/25] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Tue,  7 Jul 2026 16:42:52 -0600
Message-ID: <20260707224306.1202330-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 697e7d507f0d..97ec7c8934c9 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -27,11 +28,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 typedef struct {
     hwaddr base;
     hwaddr size;
+    AddressSpace *as;
 } RmeRamRegion;
 
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    Notifier rom_load_notifier;
     RmeRamRegion init_ram;
+    GSList *ram_regions;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -66,6 +70,44 @@ static void rme_guest_finalize(Object *obj)
 {
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
+    if (rom->addr == -1) {
+        /*
+         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
+         * Instead the firmware will load them via fw_cfg and measure them
+         * itself.
+         */
+        return;
+    }
+
+    region = g_new0(RmeRamRegion, 1);
+    region->base = rom->addr;
+    region->size = rom->len;
+    region->as = rom->as;
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
 int kvm_arm_rme_init(MachineState *ms, KVMState *s)
 {
     static Error *rme_mig_blocker;
@@ -88,6 +130,9 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     error_setg(&rme_mig_blocker, "RME: migration is not implemented");
     migrate_add_blocker(&rme_mig_blocker, &error_fatal);
 
+    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
+    rom_add_load_notifier(&rme_guest->rom_load_notifier);
+
     /*
      * The realm activation is done last, when the VM starts, after all images
      * have been loaded and all vcpus finalized.
@@ -107,6 +152,7 @@ void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
 
     rme_guest->init_ram.base = base;
     rme_guest->init_ram.size = size;
+    rme_guest->init_ram.as = NULL;
 }
 
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
-- 
2.43.0

