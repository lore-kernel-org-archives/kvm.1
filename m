Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504553DCD8D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464229; cv=none; b=pwJwrJdu8GXjrxgQQ2VTJca870xK8Iv6u1hR02dri2D+uXxoXEJxKGCxCAGWAH2z6gGik8wxqOOX6T5aNdkpeQmQqzmSi1AsflT9JQQJ2GqFUI1Sf9SWbOb4RLXuqqsGVWdNTTpJxWoU2PD0BnNdlmF+JoUyn0cSuvmbDQ3f6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464229; c=relaxed/simple;
	bh=GPAyVKltFqCDMHr7HOeTdVrvnL9vkB3SQ0XOW0OnnY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5S7qGGRJ7SbhdxREysOprZFt/TXstf9b99dU5yzJzYgvK/0XlzQAfVZp69uONNqOvVgnPbY/J+kNyfD1wmMMkxGYYkddDybh71h0qxWyq3JY7NfxXN/QNfmN8KF6CA14J4o9rVaLpwLzTBe8AGvoPsY/XoLrfWZ1Y/ZVfN+h9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqQVsTuY; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqQVsTuY"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso70480a91.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464228; x=1784069028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBlWGabD4GkOvznv4dVAU2c7SOIX7YRSJZ4YheOCNfg=;
        b=wqQVsTuYz7KyOsIrG2iL8L62opYW4q3NSR0JgSBHoEcCCMZKFX4USSDm8bcwSmD8hY
         ZgCmn54K6F41DoSPogVgJgOcdXRpLsZaQ+9Otn4O7vdJQlbRAoimHjK0mMZUVEkm3W8H
         Xx1m9sw8VToOX8PwOYzm8sQfXc/5NVYDSeGDEO8rmft2z8c2r9AWhcHpSejZrj9n6CTg
         LTJCP0Fx40XJTa2+vIdt8TnQ2v/9r6rZDmlGEftKqwu3poUJCndjiKMkzWM3nKDz8IsK
         dIa24+uFO6FUlRaCQeoWd1ZRR3RjwS/IcoENLwPGMu5voW697lToDRagtnLFzsp/Te+E
         ZaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464228; x=1784069028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBlWGabD4GkOvznv4dVAU2c7SOIX7YRSJZ4YheOCNfg=;
        b=Z1krb8NzMr9u9XCvQjzfj+2xTz23oGhQfmimX+ql53S9uuT5igZvjFpx4OXFq+mRNR
         KbpJdVcBT/FwJm46QBzlubSfzTsLmAtLze/nmXfOK9FdIG8WSPpLp6psXFZFn6UdRD1Y
         qw2EaPg0HlqbMxv6s/P77MgHmfH+kTcusTrINwdYoJEhP892u/RJBnwhLy2JDzBR55bZ
         7cn5i4h/BnHSEPyKxLFbIOCJg6wGL0uJ0IrGhW8BluawvyG00flK4+t2Hk6v2R0e9KeF
         +48eXAJuguPFOFNsHl5PNd8aWqIIoBhq4VnvZd34zULlgfsEe+dKgGsT4RJ4V/tM+6c/
         3cxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rofe24/Qh/Zdyvc/NAi8Hfk9LzeaoATjNv2jGdTj4j8eQr07w4pAib0jWvaac0xua9V4xI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7KqPzebxBfENPNI2v/y5dl40JOHz5eCL6n37UQNo4Lu/Y4dW
	kUsXyL86i2iFDsHGl9afGljE36Uf32ISMReWknbC7lA1BUq4v1W9JJqclEGJhIzwYDE=
X-Gm-Gg: AfdE7ckpBtYAEgNzn61gR7ZHEgESZj7K2Q8pzgd6IDuLSb42mLhFzT9zTQsJ0KahLbg
	siz5loR5qMaFq9wkzTZSuUBRgb0YCkz86hJZ/1+zudQAQnIpUTmVQ2ZfOMphkFDy+5c5hnT6PQK
	PQK5nrgIl+YoTQxHqyvjajdbTWQUpeiSUMLuNwBL6qnv0vM6HoqgZEClvNsOEtfuN27dTcJSXko
	vHMnnNEuP6KoxRPFCpifOGEymkuvF+G5GXhdxUQxK7EeQw30Tu8wiOwCGHXr93xh4Y/h9yb8a0r
	KBFmBOT7XkZ2Hz/sRnZTVwui+K9Z3q8Ywo6L8MOKeHG++D+CB+BT+1BjZmORW8w2BY4iB0fNYQC
	HicCRGMU8Mx09nhplYKZgo6tS4Z+m4036NrzfPBjlAzIpEPFxkAvxE/vgI3t0d3nlgYuHzyZOdB
	vXjt1pkBH5x6JQPcGJW6RZKjjsV0YcroXnGYvIqXQ=
X-Received: by 2002:a17:90b:17c5:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-38752d63ac9mr6904172a91.0.1783464227551;
        Tue, 07 Jul 2026 15:43:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:47 -0700 (PDT)
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
Subject: [RFC v1 19/25] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Tue,  7 Jul 2026 16:43:00 -0600
Message-ID: <20260707224306.1202330-20-mathieu.poirier@linaro.org>
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
index 5f6dd1797862..9882b842ddd5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -238,10 +238,11 @@ dtb-randomness
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
index d98d8108c8d2..0f104447e008 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -399,6 +399,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -408,6 +409,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -429,13 +440,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -3510,18 +3521,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
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
@@ -4339,16 +4353,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
 
@@ -4411,9 +4425,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113c..d4c1aa04f664 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -176,7 +176,7 @@ struct VirtMachineState {
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

