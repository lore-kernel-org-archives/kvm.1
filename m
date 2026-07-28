Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5684473C79
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266836; cv=none; b=Fru8bWr/bFak+jUNS9+DxHM/2dwym784aG6p6SGVwUt8scJBYo3k8Rli+/73C/DYmdDQ+q2nfsuRkFN8VbqIQZMqPzfgZrXtpKvfwevZAWnG10gHgghDaa7GcSwyBIEnLtRIzVD025vIpTo6tOVaWOMMHyu73+SbiM4CE0M+eys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266836; c=relaxed/simple;
	bh=c3pO/ludjpkyy4lifSAGPTBVhHlPLAYlyaIcV8NGJTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGOBFa/YNsnepMNSsZK66eBBlOXdoYNmi0gYOjBPF+tetuMHiJLH2S2Y4Iyv0ub/Bxu9ZMUjwIP+FbB13/7D94BO3IP5+nQvDro6UgE0uloVi+uEheNLoDHJAv8svL3oQ7jCNFCjqiJkUTQSHtZXPVntelRkXcXFWh6l3H+F7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/f8Vqir; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/f8Vqir"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38deea72eebso223665a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266834; x=1785871634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/s2MhOVNf5tNx0QLnD9DD7cZjOjKqSbP0aTOIvlKbQ=;
        b=A/f8VqirFJvlbx4z+WV39z3I2Zokp+sKlzGqAZRwEikOEERWV8aDVZ5h4O/AwIJYeC
         Q51G1pnQ9LVClN6tMZXfZeqdYXdCxgFi220JKltqXtUcafkxKlUKuAiLqLmMLNjOJaBn
         bIFoKXMA4rUKPZ7xHh3BQSoE7O4nYon9X5s+pL8JO9hqEj0CzVvf7pGnoLovLbiI2NAh
         lwJsjTqSivHFkNqtqi8yHlEWkTK7YxIKh9wdTFfUTc2hkyJDL/kXHrWOBe3Zn+Mue5gl
         +ZFhNxJhSvp2sCujPm21qcBP3589BIP7U2YMtmSHP2N8hUbH5FHeDEeDU7vDBJkALxWc
         ijHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266834; x=1785871634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/s2MhOVNf5tNx0QLnD9DD7cZjOjKqSbP0aTOIvlKbQ=;
        b=HxadzXlIEzjI8yXDem+ol1zTSWcQ2Ek+s2Vnj7HIAGkSUTsl3FscIfYpoYLwnxXyY8
         UKPiXWYYunlngP1V5Fxp1XxqigMB0BsIyyumlrD9EOVzO5cPceGRzcpqWL7HtA5EK7XA
         AiK7j+bekDLTZyMbiES7D3okiesSs6dCKG/GBQaIzzXN2DMmpKwqOjf+7IA+zOLvTjii
         ldcRrMkfmV4uqT71udO4sIjelB74Yf67czwcKvk3mGyjW7+ZsxrYSG5PZYuNRsMESus6
         WYhn0J7t7AZl6u1Nav9HgTgMkjrdHi2JCLeKr5lmYBijRp3FNSUem+U0GadQN+jEQ15V
         pa7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq16Ku98ih6o6E4+F8icQ1J3ZDUmAyJbRMr81OmK/J7r3oRWZ/YficK63abxGxVrmwlj0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrsCFr4P/V5hvVPfQWY06q0h0ZWBggYwbUP0ceO+xQD/djF4BC
	S4RSeBqcciqG/NKl1WYaOsr8L246WWlzKY5IKFI5XhH6vPIiYeXvtB2y4VDnCnEKOS8=
X-Gm-Gg: AR+sD12Zy6TqGjvX3LDuDhCm6twCUQG7GJDTw80Vvbsucb2EOkB3d7aYV9K0s1PaaiS
	jSR6OcfX1LPNYegSTj2RRGCCSDkNkB2eunYMb2ATNIytZmxjgo8rUtw4xoGQ06hUlKQ9QFPzcH2
	E5iaP5T3RJNNWy8+jXvGoa/DifLk6FaIf3ixCxOqqtHgaVw7NZvtVV1B1FdHc+BrvafafWdvEj2
	YZptdLXQ3+0NLBhdDPtnebi7jukGQP0BZ99/f9e+QWwpYy3FnLf4RPs2g+WrQoWtkZD0wIxdaqE
	0N2E8+tU3fdEnkebWNQEbgWSoi3PyaRdHnITy/idOhhqiYmQ0uDQw3SLiVP7z8D+g9Nu2eDZZZY
	1E/lMD892di6r9JEZYzYslzMUWPCHu/50asTsNCh65fpqC2ICrQd/DU8QjaUpN9nPOlyPd1PVe/
	2TDeBwOSDRc7qM2jgAiro7sAb03Woc
X-Received: by 2002:a17:90b:4a06:b0:38e:69f8:cc49 with SMTP id 98e67ed59e1d1-38f6a569e3emr3771045a91.40.1785266833744;
        Tue, 28 Jul 2026 12:27:13 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:13 -0700 (PDT)
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
Subject: [RFC v2 18/24] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Tue, 28 Jul 2026 13:26:24 -0600
Message-ID: <20260728192630.240375-19-mathieu.poirier@linaro.org>
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
index fa6cd62a335c..65ed8573f8b1 100644
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
@@ -4343,16 +4357,16 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
 
@@ -4415,9 +4429,6 @@ static void virt_instance_init(Object *obj)
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

