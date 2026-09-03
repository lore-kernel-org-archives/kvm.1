Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCB50EBF4
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464211; cv=none; b=i1n3OMCf8xB5swSGj22WZ5MyW8yaQJE6fLa4jGS+7LlLctnKc0Fbe7piegEOqLFFimrFd82i31ZFat+H1fJhbd/rvzexREh0pXa/ykSVoGs8BdSVL67J5oAgchPya3OhKjUV/SASH8UHqVmgiusJBJa+DpSzoNu8j1NopsscCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464211; c=relaxed/simple;
	bh=guO1zeCSBg85H42rmN+9n5UEJHjD+1p+XAYOlxAE3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnxNETvB6WCmI7vQM4jT30loR+NChW4tGOGcyuRl4y0bP1fvxiXraz4s3UrkBlvr8lCl1jnQPsZET5SCsOmxawhJdlT+rwG/DndXIEQoBeAS+DllvU1qT61l6lPkqnk+cxqK+j4+pDWEF6fv6Zgywclp9KYK1IUWQzbdOSyNaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJlgd+Ws; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJlgd+Ws"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39675172593so138718a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464191; x=1789068991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
        b=AJlgd+Ws1yhRdvw0Vm98NQKvl8LPVbzAlXfuguBwf7NryweDXtAaDFa9liE4Nc8tDm
         /78QwE7j1TxDmgX0DSIZQADHruwOhvNX8bIrkGthlQ+al8iCwyhCK+RDkRX+uZj/VIkB
         /cjdWlkWbUY0kx50KXPPE9+NvRKXUwcoUfp+qxNp3Ehre06I9AshMFdmy2TQh/NlKIGK
         JMN39HDy77ApfRIc91zs3a0a8sbIYQWl+getlFSrlOfnkVkLK+06X49F9iiwvdP7EnEk
         NbXAb0GUKD1oRy4bwzI8178CS/8czbxgFZJoZqeneouEB5jo6M6uBqO6POkvzz2E51vJ
         RulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464191; x=1789068991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6yAZYi7h64i0sOWTrsMVth4dHq383ltCyuAo47L2qv8=;
        b=aWuVUbHVdRhGliou/HLDEui8e5Sio1USnQeI1BfmsNt/2hRxmyh4HOkbaKqN6kjEwG
         LQR/82l3IMIJJu8V4a/Iele2nFZoGAcRCIglGrqo2pLNcw41dGctSiwx3T0uFLTGNwXF
         FyB+KDmDCpNN5eJg0d8qNRfKJ6FKXt6Iudvfs3A7HHrtI1mJDJFSGUFBID+Q0MX/eLDS
         YpFAh2V3jSwz4KD0NP6iL1dAlaYWWchXMDCgGttvyAdlH+3xKfWVKF9MZ214CP6cd7/l
         04Bo7S8Acu3ULz4L1685bxvrjgmip19zitLHvnaduVruGGw1c8BF5l2v8DB1C5VQIjHb
         Bb2A==
X-Forwarded-Encrypted: i=1; AKwUvBwQkej07bFrmGv7EhzE5gM0Ls8wEjaFSRBKYvuzSZbVN7RcBVTfNboecACEXAZYUBBvWsE=@vger.kernel.org
X-Gm-Message-State: AFuF++kZhI/8ZZBM4K6RjfXfQWS5FlsryXMZmZRoC7lPmMiPAGxsdaLR
	JsX++HTQvzDMyt9o5U8RR/cGoAlk4FhqRsC/j4PWVYBZasz7FC1MsRTIhEHLu5TQ+Xc=
X-Gm-Gg: AYBFou0GVHjrm901b9u5qnZ5g9pqBa8/sU5VP8ZbwjGlcsQux7Ae/bpQzfG6G3zFjKF
	1VJ0a4cYLZkjTYAuhPl+JNQYo6IzhKCck628qBfX1N7NWLN8M7B0BmorOIQ88LggHr5paZBjj+C
	Rzr2HY2SKOzctaHLpY2jcKpomQJCucGElQJjMG4BZD3oDhNGf8J2KwUl05wLdfJMFC3MZ/7YYcB
	9lMb2ckwbkfPkG/aQzXQqIHSQ8p0eT64pETFDf1zsmO4CoGNEnZqsaBV9fVbpz46Fi6wgJ5W1Lg
	q1waZbAs6QRknyGULbhRt97KmVcb5Jjko9O7wJQD9+Y+qIn1C8xbLGR/rUxg+RoGCxKE7V/+erY
	xla61nvLiYmguDx1DcQWh4bnjczf9x1PZUZ7uLQMSo8bGCDn2IbM6QZbdkUzyAZt72VHv6OX7we
	WhyWiuRA7VLiJEXbK1ubIlB5p5tcTsWefXK6kyPC5XRil9wdXd+EAW+IZY+tkr/37xIkTrLq3JL
	+gxoD9Afl9fI60=
X-Received: by 2002:a17:90b:17c2:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39b25f1c5bdmr1024392a91.0.1788464191280;
        Thu, 03 Sep 2026 12:36:31 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:30 -0700 (PDT)
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
Subject: [RFC v4 10/24] target/arm/kvm-rme: Keep track of images loaded in Realm memory
Date: Thu,  3 Sep 2026 13:35:57 -0600
Message-ID: <20260903193611.1058589-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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

