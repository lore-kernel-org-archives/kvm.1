Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50133EAC6D
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695305; cv=none; b=q/D+pURzP8fT7U+PkIKVVJzLawW6ASyZdU6K7pyuJGwBkevetbLGk78bBU61uvRystnBh7BgX+jGNvlbC1Crojj+nwnNUCKJKEhX8SeRv+S0BFwtgC4JG6pVIvFWufgZfs6D38YKL24iE2QQNRRz9EpBwCIUkbnAqIUS8j8fKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695305; c=relaxed/simple;
	bh=EVZ4dHArVHxRFJkg04Ikl1CYuUsUr/4YEtNKgJF8KEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVFwoI+zAxqCxeBjuaIoBpcu35aZ0Z3F27M4z//Tqpy8H/3/SdW6LVUumr6ARQtrdc3YGwH55lS0IsHYBthdeAt4uxROZziyhOTpm7KHPtTI6DBj9nj31wB1z/BBcfMOd/t5TRpDsBT2110hBN8YCLrMNnbkmR02Ex0vrzJnXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gpt+tDkO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gpt+tDkO"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso183449a12.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695303; x=1788300103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAzEL9ZlLXCfuWjde/xvRNITLPTF4bTeTvJhthxiQHA=;
        b=Gpt+tDkO0DZULeXgsHh7Ld77FkEF+g5F+qc4Drn8ZCogmnGf2Agiuvg9/KJ7B7LQ1N
         b0XwlCpZs9La7nfIBKtX2q+PiZQ2BpTBte6Alf60CNHEvqDNo5ez/j0w2zbk0EuxbALw
         uORiuo7UweakzeHNYUpw20R9kNqaImMnGZkxQW0e8yyXWNRt+rLyG5wYU39wtvJJwSII
         edAjtoa2rmcb2GWq1dLKriKoUrY4j1SW5IR2ebdZXgmT1a1kUiwWpiWhiN/0BpZOWM58
         u5ScsmxDlV29dDfD3yV7pjs+z3/9vbY7Fz3q/5UFqYhSBHtm+MHUnQyn2zAjnMmt8JNx
         yIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695303; x=1788300103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xAzEL9ZlLXCfuWjde/xvRNITLPTF4bTeTvJhthxiQHA=;
        b=PmvIixIfldKioQkVlYH168qe2ksB51dHjXFayFGxzaMsQMScf2WNHSwnVo+4xpX5Rw
         9kYo5l0OIJ/kBChgNGncj4LxmaxczTR/xaymVMo5EUYNTIIJLeJ5qju9rv+LAP2m0kd3
         406pPQDm1s03REWIOKHo07XrBRa7uaW8Q/0P983RF0+5Z/Lf5f9YskUJfR0NT8Hq3pwP
         9d9nnkMtmrD8IUZxhVgGnN5OktR1JUYk0XRlTaOqVzcdjBD0PZuVT0rOAL7kfLbIuNUQ
         anCFiC85S+KLuRbB2w9wDo+ZAZ0HelHp2Nw4nOqNKqwoR9pc52mfBFjx1vaM0J9YMGuE
         4e3g==
X-Forwarded-Encrypted: i=1; AHgh+Rp2kayVr0rFnMabXP9DXpc1w8Uj4xl06PAzmezMo+mEHI4SilNJd28DCPe2rUTrrasjz1w=@vger.kernel.org
X-Gm-Message-State: AFuF++l7vCduhZzr8WgembZ9n36Bp+6Oams/L2MLaTDU2lHAoAGpkuqQ
	pkCdxCVKM0YyokkhmORM9SP3w6pkkGeMgO1EEQJRa6TO2ZlWLPSF8OVW0PXPU86GBEM=
X-Gm-Gg: AR+sD13gh+7ddIA1UpluucqtoAs0Ok8RD2ag3Hgr2PAFDJ1WjDxKOoIu+nOJ7rQJ9cH
	wd8zTc4qSPO6CHZEelHZB3LaCA/kKLXfhu/INKT2/N57kIMAxfge/PSNJ5xPgWDvVSssaSgGZtE
	LM4Bp+rd/ETOmKtjqsS8VCsS/c0j3754lZSeAe4jT+zCLawYZ4UVllnwqp8qXdhbPSvTKaInYWJ
	vUOxdbCF6RuYATlfWAhxiOq/tpBgfemvKD1x4DV8jkVNH4lfXxwi+3JNbtXdXy81rAz4N7oo1u2
	AhT2cMEDHWa8SsgWdsPNeP0/tndwLo0o5rJrajth1g9+842kkPeDjGMp2njwBW+lfC26UyaqKO+
	aAJhaW9KmDSbTPd9g20UtitPbwXE9HSqOeDYLCAg0Kh2KW/P8wjHMc0V4/+mFiwCOAVHUE5yp3O
	I7aoWd1PdcfJMU79O3jShFvIeA7firLbAiawS/7wZNMdsmEBzu01M55iBhrIONLum5wIlRQhqJP
	aRO045f5+CObbhk
X-Received: by 2002:a17:90b:54cb:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3966d5b7c62mr4486212a91.7.1787695302766;
        Tue, 25 Aug 2026 15:01:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:42 -0700 (PDT)
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
Subject: [RFC v3 18/24] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Tue, 25 Aug 2026 16:00:55 -0600
Message-ID: <20260825220101.3443954-19-mathieu.poirier@linaro.org>
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

The dtb-randomness feature, which adds random seeds to the DTB, isn't
really compatible with confidential VMs since it randomizes the Realm
Initial Measurement. Enabling it is not an error, but it prevents
attestation. It also isn't useful to a Realm, which doesn't trust host
input.

Currently the feature is automatically enabled, unless the user disables
it on the command-line. Change it to OnOffAuto, and automatically
disable it for confidential VMs, unless the user explicitly enables it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/arm/virt.rst |  9 +++++----
 hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
 include/hw/arm/virt.h    |  2 +-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f811e662d68d..faae97848d2e 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -237,10 +237,11 @@ dtb-randomness
   rng-seed and kaslr-seed nodes (in both "/chosen" and
   "/secure-chosen") to use for features like the random number
   generator and address space randomisation. The default is
-  ``on``. You will want to disable it if your trusted boot chain
-  will verify the DTB it is passed, since this option causes the
-  DTB to be non-deterministic. It would be the responsibility of
-  the firmware to come up with a seed and pass it on if it wants to.
+  ``off`` for confidential VMs, and ``on`` otherwise. You will want
+  to disable it if your trusted boot chain will verify the DTB it is
+  passed, since this option causes the DTB to be non-deterministic.
+  It would be the responsibility of the firmware to come up with a
+  seed and pass it on if it wants to.
 
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2132e6595baf..c300224f19e7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -394,6 +394,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -403,6 +404,16 @@ static void create_fdt(VirtMachineState *vms)
         exit(1);
     }
 
+    /*
+     * Including random data in the DTB causes random intial measurement on CCA,
+     * so disable it for confidential VMs.
+     */
+    if (vms->dtb_randomness == ON_OFF_AUTO_OFF ||
+        (vms->dtb_randomness == ON_OFF_AUTO_AUTO &&
+         virt_machine_is_confidential(vms))) {
+        dtb_randomness = false;
+    }
+
     ms->fdt = fdt;
 
     /* Header */
@@ -424,13 +435,13 @@ static void create_fdt(VirtMachineState *vms)
 
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    if (vms->dtb_randomness) {
+    if (dtb_randomness) {
         create_randomness(ms, "/chosen");
     }
 
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
-        if (vms->dtb_randomness) {
+        if (dtb_randomness) {
             create_randomness(ms, "/secure-chosen");
         }
     }
@@ -3462,18 +3473,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
     vms->virtio_transports = transports;
 }
 
-static bool virt_get_dtb_randomness(Object *obj, Error **errp)
+static void virt_get_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    OnOffAuto dtb_randomness = vms->dtb_randomness;
 
-    return vms->dtb_randomness;
+    visit_type_OnOffAuto(v, name, &dtb_randomness, errp);
 }
 
-static void virt_set_dtb_randomness(Object *obj, bool value, Error **errp)
+static void virt_set_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->dtb_randomness = value;
+    visit_type_OnOffAuto(v, name, &vms->dtb_randomness, errp);
 }
 
 static char *virt_get_oem_id(Object *obj, Error **errp)
@@ -4260,16 +4274,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set MSI settings. "
                                           "Valid values are auto, gicv2m, its and off");
 
-    object_class_property_add_bool(oc, "dtb-randomness",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-randomness", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-randomness",
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-kaslr-seed", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-kaslr-seed",
                                           "Deprecated synonym of dtb-randomness");
 
@@ -4332,9 +4346,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3ba33b4bd274..ef9fe3238022 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -173,7 +173,7 @@ struct VirtMachineState {
     bool virt;
     bool ras;
     bool mte;
-    bool dtb_randomness;
+    OnOffAuto dtb_randomness;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
-- 
2.43.0

