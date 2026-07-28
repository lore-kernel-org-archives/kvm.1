Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFA4734F0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266817; cv=none; b=HNQP2LcRrD18+car4zb+TnFThLvMO3TObUb3rre8rEgl78y9Lt8dOGtIZA1l1Aj25punzCgtB4zh1EPFyb+HDqqmCIGiRBJGcNB1iA6RGeAVHu+X/KeM44zzq40WSjW3VNZTbIs8xsHQBos72ju2GdH3MQmptlzHPiUmQncoWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266817; c=relaxed/simple;
	bh=Q5aOQM2pKvOxLUxlQmXFUB1Dj7uhfGEY0CjFx9Ef4bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKAfzuONbuetZbR1glJrieSp1tzENviPhFlq3BgWU6NVlFiqHk0GgztqtmrjaDksEhbiUCQb21HDqAtK9rvqM4xP345xpDQ7UO+rErUhOg9DRq5NLYWeOCzt7+UYVSTsFNshLfPgGrwLVDSxQptzO9BOuJCcqUyk38VJ2sfBMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MASnXSdp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MASnXSdp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso221457a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266816; x=1785871616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eK8Ckt90ew461zSdg6LQYBpQfbUxeqNFROzikiI270U=;
        b=MASnXSdpDMekhsJR8SbhIuY+MyJdLXLpD0TwhT3UYGL0rXQwpBCrEVpYqzcQWpCPgW
         cXVdIJ2a0EGe8Z7RIDvugwGQrmRYs7g6CNTmLgd7QkGWIx/Sbgl7Hv56sPw8rcnW2kbH
         vabh0TGqiFwwYbHCjxkkvac3qW2lXd9jKpAkkIpZ3X2dhRI0kl9KAJBQ7+olcldZFuQn
         6W//ugJnvYq0lh9XY9cWVLAiHqleKxU6PReEgGuVaqeAtQuEAT6HmqblQbAWEcWXtB7q
         44SCvFSCTqv6fJP1T+CNqMj5iMBkDocCKW36MNObvetS67gJoUxGJiiwXDHYZV4NcafD
         kAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266816; x=1785871616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eK8Ckt90ew461zSdg6LQYBpQfbUxeqNFROzikiI270U=;
        b=EaB1XHGsGRUDIt1qSjmSVcZ+ZqRaak8J+Qz/pGJVPCr+IGAneyYcrMX4QzDTPPcMQ0
         iQoh3r2IoNy2lzymLF0Q/IAWnMH4Jq6VM5WxhbLxk/8jWZCFjghDi/Z7L+z1wRtIY/YZ
         HWxsscHe5RBUI+zXtwTaazSc7i9Je465qkBYwj/FBzcmSwD+CQkegdWL/tnhoyh+Ayjh
         5yduMrVUzjFIzE0f9i+rIQ9jnZA8gwP1EAjmDufGOuDsgoXPMQG+MMa3HPlZyfBrsW/V
         GafEEjoyrDyuoVz1Q1TH7vzK819uHrquaRgmow3hciJpc7XeEd5xZGggP+iXKaOUr28m
         //JQ==
X-Forwarded-Encrypted: i=1; AHgh+RooWw4wUT+G9OBHPgJYT9lfxWxyYfbVZnELxz/nmOYLLBAg17vRYyDVMnclsee6x9P5R7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2nd1/2v77u+8Uq/4R+uNuV7FhXnE3oSEkbwu474zIqdPQLO1
	sJPmE8g1v7CI636YxbEG3p7nrFRTs+ohu5+uKz3Amh60TFizeel7vidfP3NTbjraHpo=
X-Gm-Gg: AR+sD13IQ9kG9r/GV+Y7l7PnlbXnKegv7oBrqdbLwAGt7cLGqtg8NCV0q83psfLoyrF
	8JVzVeSj4hsSPUKk9kuvD9r44BaaxTzdpqecc1ceYeckW/lhznL0IspP30MDLnj3W0RaSvADdvs
	kNw462RMCNb8y8CBhBn3R0Yg0cLheEQl7BZiWPFM5L+4DEvyTpeMJ9YencOtXRKAaz8XStBg8gy
	JtQv5t+D6l++y6SF6pLAMHARHSdbef/ZVYjBitMOG9vJhj1+LTsZObPoZ21WHEzC4TjdtdgLoRP
	EDrz7NuYoreVwHrged0sYU7pWaSTsLpd1PZYoPGR/Nd+CG6erGkyYjY1lxcHCgw9y7bx+1RjQHH
	UKj/8/7OB22Nij0wiuCHNz5BR7kqKI2xW6FeaC+A5IVnUx1vEyrGEBzMNAGwK+GyuWt0mLCRod3
	qlN+8PRV2vKRsf+w3a68h1eVFapEcv5ldYdF9qJrddI1t81K1e92LXSqufnPtt/hUwvIVgdmIfy
	CPSZs+VqW4xx5s=
X-Received: by 2002:a17:90b:6cb:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-38f6a3d5b08mr4041584a91.9.1785266815568;
        Tue, 28 Jul 2026 12:26:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:55 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 10/24] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Tue, 28 Jul 2026 13:26:16 -0600
Message-ID: <20260728192630.240375-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
 target/arm/kvm-rme.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 5d6814fcf9e5..10bca9a944ba 100644
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
+    AddressSpace *as;
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

