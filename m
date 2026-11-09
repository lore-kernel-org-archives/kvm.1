Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263505;
	b=1gOTx7jFyTxZ+QqWPrXv39AFrUuXEpkgqe2VikHWRIEQsKs2FLBmOe4cCNZ1EqS/pyya
	 9tZCjHyhIhOA3oeXWTa5S88SrJVMXWdmni/V0Xf+q20yQt1ZBmK65wYOUBRVrtWmAZFLI
	 HKUQ+RYaTJcYR0U06v2mitMZNaqgKAB0ZHMsgiTf1dAhmeuSBS4FrEcaulEz9NFEDypBz
	 y+ThX5nHRHBCVQkJRrXpOXxtMO2IWLUdqO/A3bk6Re0+nXkoWL4qLDRxWOJCQor8Vxaud
	 CbGm2Dt+SDBtDUyrJwYkLI8ZF7f3RG3/jDey255MJYEVx68BOUxtGndtVDncN6aEx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2v6GFCmmyVopOT4+6X7oJautrva+0tDipmVQjAHAiYU=;
	b=GxdWLe588RI+bNH29aSBwyVAhgvnSlQLNJTelvSMlmIYNW/KhR2fGWSO6MnIsmOhFYD+
	 NozYpc6pEjuXSwn67yDbmnSq5sG6sLkd6sZ0AuvhMjTv0AHueOyM5vTkefnuB+efqiF/p
	 hy0MdP6kjWuj38tHqWYELBlgV/e0rqDP+xhbXFE6H73wi7C8mfyFLrJo3qR1XvgvU9t42
	 jEEjJofGZiy/fJCeWs6CgBMFEBqUrG0OotFov+f5ciVsGNEfjRW82k7BOZ9nu/A/TIV53
	 b8Jrm6twUEHOKMsrL6W4InY4ARggQSmmDZddrjZx133WsAMXIZivIoHHTXsuYbkqMaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KbdN0GpE;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263260A2602
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7263260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KbdN0GpE
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b5efadd183so641144b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263505; x=1794868305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2v6GFCmmyVopOT4+6X7oJautrva+0tDipmVQjAHAiYU=;
        b=KbdN0GpELmF4wRAbbpuupZVRg0eBOury0a5T4azSUk5//6KWlrWcgGDP27xUrusjsd
         nWRBFjJNGxsadFn9VD5S9ri8iYKTLu1a3kpjkSAeDv5l8Cbi9IxkpSQU2bTxpQrzk5Xm
         dzyXqcDH6nd6N2E+CAogjNcV+J6KiCISDSRqWYROIb8z5EJ89rXk6tM2AyK5cXPGrO91
         5/b11ft2Z3Z9xPbEKm0jLHyud6eGgikZ9umLZ8AWmzmMKoVKoJwv6qRzoMu4yQqQ7EYi
         zG0q/5bde5FKRGZjSWnWCPXnSbqgiCrp4QcznnrgBEoaAJlfajVXy49yP383Vf6w2nPq
         19HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263505; x=1794868305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2v6GFCmmyVopOT4+6X7oJautrva+0tDipmVQjAHAiYU=;
        b=2d44gWnIeyz0mX3WYyL5oZx1IsJMOfNEHrddwPn2w9OQP87hHM5XPf4dW5Gm2g9tPZ
         esOnMe59YdYBqSE48jOCRjLRMZgTk8+pvqMIMUOKkKCU7bSJYKmkFRLz9TJaz9miktDB
         7LCuH7d/NlaaNwUoFkGZDHLawlOCeMM4fSKcBbaqQ3/Zx7I8U6t4eiD/YfMHLF7ad0Wo
         61OW+H93nS4PJKQ6CxgO9IZP3Gt+AmEmLiEzapXmCOsr6s3JK0GL0uNV4Z42FvrRybiY
         CqZCAn6OUjgSukmlIIudVvwbBAo0D478P42DeMa2tsCwHSU2FT6K2V8M9zSy/r/CqlCL
         fRtQ==
X-Forwarded-Encrypted: i=1; AL+hErETx0b01+dKdWmccfeZF44k3+WOxaYtENIc3s3AGjRX2WS9EaVkuLzW4MxyoyFWHlTGZkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fXN3cn+Sj786JsA4UBf3BmENp8xLXqNzoIKMJmVaoI6UOX8WY
	HMM67UJG7B0YxKVx0TElVwZd/YwbK6Up8+H/iZJuwX5tcsGmYepxxN3r1SEDoJZyFSI=
X-Gm-Gg: AYBFou37C/h4s2PjPkvqmzDyk8Nc3T1CXj/CxP7gPjxwIeB0pF42ZvrN3qv68Eu/ckx
	ZwOfXtpz134rgXX7HNx8eIy8EfC7sXIBGB67BEWHrtuTRe6BxLDlFe1Otrb5aO1qJzUgnjcwQIG
	zan8fcoVP/t7wgJ8AW8lST9ZxLd5O+nwyRtb8Su1J+jCE1TXXNZwy2TEJulAkCEgPy5idfs2jLL
	7fI4Apjse72z3gJXGyUMmsZSxoTUMlqBfMITQtsRoCGgF+PLMPkuJ5zP7OgS8gs4ngpfIdA2U3Y
	uCcpwL28DUFkHiys0igriH33T0YqoBDbm7zt8RNv4m9KZIrghHG8A9MVzhi7xwqofhbIygkGg1g
	SQvzmwD3J8wp0uaDk822KvN+fCOUnXsKWzAlvNOIrBAGvp3vrJ0qNWntPAgKroP3rCLyUYVTzAv
	gLHu7HKQoQxKsTZGjUg+5R+071gbGOhxosnJSowAq7PKziZiPGTHRRqmzSyJL3oZjSe65ierQqt
	Gy/N2e9zzqQeLFA7Xu6nkFclyiDN3wepCxsU12oBqEvfXqM6Ne/Pf+LyLEh9gZrGabJMEdW+MoG
	iF9EJDY0Ux7fltZUzGiTsNm2P+2+hhKCrnIly8Q2AuL7f1IcZmMAr4M=
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id adf61e73a8af0-3f18f4ac9aamr338799637.27.1794263504634;
        Mon, 09 Nov 2026 14:31:44 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:44 -0800 (PST)
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
Subject: [PATCH v6 17/23] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Mon,  9 Nov 2026 16:31:04 -0600
Message-ID: <20261109223110.1619504-18-mathieu.poirier@linaro.org>
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
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++--------------
 include/hw/arm/virt.h    |  2 +-
 3 files changed, 34 insertions(+), 20 deletions(-)

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
index 9dd89f39a044..9d53ed4d51ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -410,6 +410,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -419,6 +420,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -440,13 +451,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -3523,18 +3534,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
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
@@ -4352,16 +4366,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set MSI settings. "
                                           "Valid values are auto, gicv2m, its and off");
 
-    object_class_property_add_bool(oc, "dtb-randomness",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-randomness", "OnOffAuto",
+                              &OnOffAuto_type_info,
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-randomness",
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-kaslr-seed", "OnOffAuto",
+                              &OnOffAuto_type_info,
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-kaslr-seed",
                                           "Deprecated synonym of dtb-randomness");
 
@@ -4424,9 +4440,6 @@ static void virt_instance_init(Object *obj)
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
2.53.0

