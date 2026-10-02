Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7845187C8
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972461; cv=none; b=g2G/aO3RDamB4t6ieswKmotuKvd4P8GnXTkat9Vd5TCVgUP92X6D2kd1oJIzWi6cuMsuqMaNu9Q5nLOLbQD+WdNkSr8xgxKPfqHQndh4EsGtZx3RPE5l9qMyxRCWwflMj8+YBEDIU3KrMCsLwgFOrGSpiYBbQ6dqsCqyBcBtF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972461; c=relaxed/simple;
	bh=xRaDMG+BuqyQgI22fEXu2Y/TesZJkxwobCffYq6k/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4o7ZuTrbUyCH5WNJGgwCsMwXJs91z3M7NEJ+A0z1GiIwT0fghxex6j4xKRIbalVdh47aO4S5SHXZ03iZw/CcCrSgKY6Dew9LQllK8eXl5KJRgBpWby1Qzve9KiYIYLdwZ5nnLfstu4SVTMhtjWkacPEmnePsL1Ui++m++539L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZIsV8Vc+; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIsV8Vc+"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d58a3b05so23185ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972459; x=1791577259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EutMuVi05q7D0n6FZ3Jv8HMw5DGbhkWXN2U7LRtbrK8=;
        b=ZIsV8Vc+HpA9bilip0obK1YfA6WSV3dTayMaBk+0YvYrQuaBQ6MP99aWO5WBLpGrvZ
         QmIVlsrQg9jy1eFqQln5a1SmqoqyhZCqVZ4P2Jhbjzht5zfiaC8/FzZnlkhlSS9I/ql+
         xQtnlIU3T8epPnSGK+XAdd6owQrkC8ZeRu/yX8Llpf3gdnJHwILg1WNwJfH2FDMebvar
         DPo+YA2Q8oMstTAR9ZD609gWeJwncbauCJdEkHlcdoHDTvpoMCnbmLH1ZJDVIVZg9tvv
         5EgtFkXpDwdhSFvDL032Bflgzadku+H3fyc1TkYqdiiBSogkHs0/jA54QxHdkWeO5j/o
         XfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972459; x=1791577259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EutMuVi05q7D0n6FZ3Jv8HMw5DGbhkWXN2U7LRtbrK8=;
        b=VxtZY797oUs428YfSXOtrme46GCcBXULkZ7glSF5kLr/jxTunJcIQDLn1XHWkIHLUF
         OHAyLlfR8MfTuD5G0wq9W/Q4z3DE+C4udZjupkkxOIE8UAW6J61sHEUyFauFUbQy2TIY
         R5OfaiXFULW9WJjmDw/h9QW5n8j9j13xbnXD6GhiXO0Yx65OqG0ZAGTpzhOz5W7q9rBW
         SUWRtzUP8vHrSXu4bNIG3w2VB6khn52MsIJmMbQ1r3UOwbnWi8tE+KoK2IhdTN6LVniN
         MFTHFSTIKP6/4vspHkvq/mxJMnr6gdJdZFOhhjwTbyeh19asfpYj4gJP5x0dF2JwEXLr
         jsgw==
X-Forwarded-Encrypted: i=1; AKwUvBxoiAHZ43V9ygGz35L1wuQnMbxK756c7R4zywAPNgJrkZjlH1b7e07SUcnFcehN+3JDZUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHuonP1IaHNwlJYEa5R4M8B3icAm3KexuEX9ImqI78mWoe6V0Z
	Wy4EgZ4zzKOxaWrj7MVRMtsSUMvF1A3ML/abKAX7ecvbNS4iND7YSnjxtmUPv5wl2as=
X-Gm-Gg: AYBFou14umIgVw2VQgbvB2jlVODD5DN0MNsWIhzt6azCxeGhBduyNmHLZopqRE0Rj9w
	w7mIdHei14IRweva4MAFGW3s01ebyoxTf7jaZuLnT3u590AC5xAykKQY6JjBl2DoO2GnrL373Ec
	D6TtV6DB2YW4IpoXs2jJjYz6pQoR7QYqoBu1wa9BPD99vQUQmjsZoK8ZREmJkiWo42KxvR+Eq+Z
	0sodb9o7Ba3B32ke9i15wGLCDv/IfRSR0jaVZtBfcgtn+rVhma0W8UOmI18Ho8ve6jh7IUU7Clx
	EDzpY/VGbb5fIsLMtazIkTTH0tdCdvEDwEwKbCuJ4N1gU00hlHY78yYg6AXBkzk2BGj+2B2G7m0
	1uLVQRD6oYIB61cVpjZMMdARWLLT+xo7DTCf8Up5u9gaoBgxe8bD+YPma1yGy3dh3+yHz0WNi0P
	PZoIplIpWwfvEZaGM89Yaev3EH0JbSkMOCv+hyOFKTixFbaPnd9KpVIwRG4BAY5kPLA3V+Q5y69
	e5w6OKbtyaFq8myIgH2XDkL
X-Received: by 2002:a17:903:3d0e:b0:2d8:d4ce:7e40 with SMTP id d9443c01a7336-2e49b64e249mr33210835ad.21.1790972458684;
        Fri, 02 Oct 2026 13:20:58 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:57 -0700 (PDT)
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
Subject: [RFC v5 16/22] hw/arm/virt: Disable DTB randomness for confidential VMs
Date: Fri,  2 Oct 2026 14:20:20 -0600
Message-ID: <20261002202026.1204110-17-mathieu.poirier@linaro.org>
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
index b2cca73dda6f..35e76951dafd 100644
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
@@ -3505,18 +3516,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
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

