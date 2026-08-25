Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3426ED46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695288; cv=none; b=DzbhnTstLUnCKmWG5AiFDWfZ5FZ69C9YEpR4bYk9kvANLXbWUWm28ZOVDZgU1p37kFWJXe4DdxjoBfosS5ar57VO8ovzQeGKYfCwRhrfYwUjZ50FWw12C4SVIH2TONMDjtNIMRuDEkI+JAszX4rM/E06LVFACuFz1BYAHL/3mtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695288; c=relaxed/simple;
	bh=guO1zeCSBg85H42rmN+9n5UEJHjD+1p+XAYOlxAE3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPfRGHED+H3HTms18DchANukSoh2YxI7Xfuh6bdVmvzEL9tM28drheWyMkXz4Au5IyR/dOdqPhgyEOlp90WkE+uA35TtR+5Chh8KMDvAFpyrqVwbQ0wXTTkGgv6I3UJqGVmyNFeI59MmsjpN3iqBC36LDXB24GegU26IoZ8o0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCwipa5S; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCwipa5S"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1112247a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695286; x=1788300086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
        b=jCwipa5SG/je+qJoVmYchG6ppt0DSGkiyH+QddH2bbrsESzEVyA61EkKFJ0k/pP8p9
         ZqR4bBBl2QYO0kFPCwVTKz8mv1UuZ4JWikGWTGEOr1Xf6wgEpZSmB5OiCIGhnsAMvbQf
         U6daYR27w5C7rEfj7uOmnDr9Dxm3jP6KSgM5T0F/wzvmpGx1gxiBBtx0zxzRCTgfY/xJ
         s4px5OwNyEwbkavwdeD6KGnefjDbNnncfHqwW1foIaRtyx3OD3rrcdMxiTb2Y7t7uvw0
         9WQq8YzMfPD3Aw0K/zRkDlGHlpySg5UlD1Sa2KvPjMY8QJ8twQ/WXVR+bfQkRNcgAijp
         BJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695286; x=1788300086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
        b=mVCUgHLimJ3GZSYrTiiTDUikrYlOWFGG3jJr04yCktahllwRwEzmty3ElQOVO8ru7M
         GwFXhhZSTDU209lqKEnvQjop4MR41gv6V7q3lNjrlkDhlPmeA0EvoEdAokfqx8bX4O8a
         CUBIzj7sGRdoc2tEyXnlv8nFE2W2eqShyZKmSChd+YfENB2dYOdHUu05h7HXfHAzHjBM
         Ra29XW16pMF7hsRk41Sy+4VIbsJ4qsJdT5cnH+Tb1gQfzj5wW1iY7VtnvEFI7+UQBXil
         6kQLEK7K0AM+K50fyroJeQYmSxC9mr6BOFU6Q61O7JMDbynBaP1zX/C5B2qi9JfWYG0d
         KlOw==
X-Forwarded-Encrypted: i=1; AHgh+RrFVVmnVyMuCclDe0OEfKL7CAeDaEr9FdRFUQoviVdvs+MMLCa4y9BHB2IdaiFAGlJ8Qp8=@vger.kernel.org
X-Gm-Message-State: AFuF++mUqn+Ov8e+ASLuv34XXPbANhNrIVsYD7V+4OuXI7d/hPnWkGMl
	XZ54Q+SLx6kH/6JSxKJsbrbwGfQrD/2L7o7IIjRYDE3SpvdwO0C+XM1gW6OA7xh6dEo=
X-Gm-Gg: AR+sD13foy2/AebglEaG4Ju8aR9v0waR/rjj3BoATt2o77SICT9cVRBQSx21r+RwVq5
	AlxNiKmmALI+s8CSiSWoKwU1wL4av1HgEKVgAaSS+9108QKSQSvcSiPiRHPR3NU/d+H2nGB0bQm
	8WNZiUCqG50W+O6GrnyPfPQbimfa9rV187Sfa41RP9xmWBbJeCkADtYVXR5qTtFNaQ6teeHPrcC
	uLIfhzE0j2yugvxShDsO5jt0BXKTOIM8O7zuLFyKJpa7deG8dn+IemM6Dooa4YknNSRduDkAGpm
	9ulw+2Wyw9IEbtFHkV3/idw9HDIletg8leGyBNNzLH8fFFC8E5uNHQ99WaTR6BZmqobBuysUj9B
	Eg3YmkjQSfvSjZ60z3PD1OwrdbEkh+d3ET2cTVKXLLtWAkRgBTvKCizCUl0yViiybWiPMYufiln
	kxDvKvpe69r/xKzFUTrC1yO2W7mORdA+S9/kQiaenPn4vtW+Ulbr6HByK/Fv8vcQ0zuMOfoMKgQ
	xVEdVcRYYnzjBU=
X-Received: by 2002:a17:90b:2ccf:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3966d70a74fmr2259623a91.5.1787695286153;
        Tue, 25 Aug 2026 15:01:26 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:25 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 10/24] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Tue, 25 Aug 2026 16:00:47 -0600
Message-ID: <20260825220101.3443954-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
 target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f7c2cc786e2c..9985f5daba89 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -10,6 +10,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
+#include "hw/core/loader.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
@@ -22,8 +23,18 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
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
@@ -41,6 +52,44 @@ static void rme_vm_state_change(void *opaque, bool running, RunState state)
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
@@ -58,6 +107,9 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
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

