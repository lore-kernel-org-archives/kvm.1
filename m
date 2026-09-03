Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2A50C2B0
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464223; cv=none; b=HCp0GJyHA2Ra6j93ZacP/HIaMDvcBBJEnrRuK0TqJs3G1yuf6fs2u2xGDTmqmXhg86+IhLGh6TBtDxycgTSj1Es9sppwbo4/DIjL7tzLtLsVYLL4zcH0Aq/O3fORxL8nQAAckKDB2AzhG5v28NF0Ww4vUOsPIoEizJBXiOoJyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464223; c=relaxed/simple;
	bh=EhrPYx9aHhqH4bTY1zUXmVti5Qfcvwwxzmkr98EbYLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcyMb68qn8wBqJKOpszcRe427RySCCx5DwiHS+caFZ+pjPQHIWV3sVxd8+hcZsxA2dw/gOaTdZzEI/PgDBSwHs6dcqfQx8Lsi6QdfBBvaB1SZ7FEW1mw4I0F6kR8xO1nU3vH+aYU6y9/QDpC0iJ1+5ZD4//kH+3cQ+Lb0fS0Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q7s8Eu3q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q7s8Eu3q"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so315441a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464206; x=1789069006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqEMLe/F4bhf+smjGpRF2fQvXrs0fPuNu8A5xb4n6+c=;
        b=Q7s8Eu3qjVrtgkThVElFx9mM3gzqFED2vnzngONxxiwCPfWjfsdIav37MDLd175GsX
         N87gYogL0QVysgUlA2IE6tLYrbFQgUW3aNpKPTbMwr6LMMiz8HvbxAQDRHHXHSetO4+W
         7kq9BUI/+FCzBGInNnv5rfxb3eOuTXLLSbLlNybJlVErsn0EC8/LfoPzmHsVs4bxK/sn
         q/0vg9+ay5py/PV9D55oQQ7G0K2ASQ86TMnMtXiFk7bsmxAIrZLn23RX3jJlCIoMjwhR
         Inn2Q74G6f7bkmglqLUt/lHXtVHJR37ju0sq6oLIqQV2G3yWYekNQkB5w8O8QMWVaZoQ
         bjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464206; x=1789069006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqEMLe/F4bhf+smjGpRF2fQvXrs0fPuNu8A5xb4n6+c=;
        b=GjN1t4H1InL1mX5J5l30hMKBrkBgRA3yXyfYCQXcuAaSvRzOkgcADRgsSBrtIQCZTc
         SoSBvU6lsm7U/2MziJlUZVJJovdX2xDdFb0/ETpK4kOGfzt3kyoRbQd6wfBIuL45t3bR
         hdeT5ZOU3ZCjqz/MoAr/YYBgxoo3Q1zNkOEMtCs3WLFZNYRJdW+itHVNN2CJg2rfB4kq
         xP1vl5Opw0YrSCtb2RNxq/TFGcGoQuD8DTj+8UXWgn44guws4hIs+OR0nyTCzNvU/rya
         y+ssWgm4sUWUVjqR20Qy+JH6EXfOo8p/ukFBnQqAcXLzes3MhqqFetRfAOLMTinNbECa
         jw2A==
X-Forwarded-Encrypted: i=1; AKwUvBzQ62fzCkFHxBoGu+vvB5PwpnoQs5kIMeKR6KI8RVKuBQ+490IzlHOcGeKtRCfpqtC1Ja4=@vger.kernel.org
X-Gm-Message-State: AFuF++naxN3HtPbRB9pXUAed53zOhSG3rZR9ZhsmOY+pcJsZIiOcb7Bt
	hnm2a2/wRzTZ1Zoph4TEqGsN0J6OgluJrH6SV4yHZ03inIi+Vo6rJv5ZkUgohyZuek0=
X-Gm-Gg: AYBFou3DVA4RY4dCnAfM/XYgjgvwPET4tYf7QvLDC+6CqSHD57Pih9r52GGE4bJp+I5
	S5LwEBU2/pUE4W35UXPJLWw+yMEP4c8XZ8mxyTuVBSX/RUnK3EZ6mCeFGczaA6wcyQ+jfqEGwbF
	VDecUNTBSkySc54IBxXmbIK/Xv0fVS4MM2HF0SP/VtFgDbSULOtjkp2RY2bQKbhzUFgoY64dkBE
	TY8o3lAKK1Sx/JYOMMY19wD7pQqwNU4Jqs2bGjNoO7uzStXJtR/23x1EB0r3cqyRREwfNye+7ai
	+KTa1qFuH89tE49wYZKjSPBjZoOmtTUvMt5uAuf6leD68weuvuBPz2lHh6SrPfki8fnZV6Ind8p
	GUcBK+MPbFtGCQggNFf6LkQ35FCHBgQjx+tk4hI6Hz9rqHGlEgNE2wv/vyRWz0LVc+i/L683ou2
	eTIGmB+sfWE7XQVy+luOq58q7CbZ6tcKDjsivu8pUrW0smP6Ou88iry/hGIdjFQV1zj/iIq9xG1
	wyXTFq6Nw2bh6knHRejsTrAeQ==
X-Received: by 2002:a17:90b:3943:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39b26273e31mr1288750a91.23.1788464205719;
        Thu, 03 Sep 2026 12:36:45 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:45 -0700 (PDT)
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
Subject: [RFC v4 18/24] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Thu,  3 Sep 2026 13:36:05 -0600
Message-ID: <20260903193611.1058589-19-mathieu.poirier@linaro.org>
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
index cf3a9320dc3a..329c881eb91a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -401,6 +401,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -410,6 +411,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -431,13 +442,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -3512,18 +3523,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
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
@@ -4345,16 +4359,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
 
@@ -4417,9 +4431,6 @@ static void virt_instance_init(Object *obj)
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

