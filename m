Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCE7503BE8
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464233; cv=none; b=Fuw874N+VVRvkHlq0ETLWnPvOHiXoSjRnSRYzhZxpR/OKv/tB8AfadtYvAfBLq2VvzcghhIe7t7AKTPJ5I3K+TCzMR0bPYnRl6Z/lgPmNAXjdEgGLS9fIUwLveDwqHrBEQFNBcgoovVlaRdbYFyxO1DEwnc54Z71+fzi2hYIqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464233; c=relaxed/simple;
	bh=d3AnoyfBnWyVs/pBe2LKwcu/T+ugotgtFgT2gl7Hltg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3QpzExrcTTbq8ehBaZq0Up41OfjAyhp0t4KtbqTygYEcja1FcLk1bGtPGlQQ2SxutSoRtkg6nZfWPaaSU4IPlO+kBkTvJuKfSBNsljPsQddyL2zVMR9paskhAGJUBnaYmEHETLkLN4FAlUHEmgUSCxmtyOH92H9zdxnx3IRj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrM+aHFM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrM+aHFM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d72ae08fa1so1948245ad.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464209; x=1789069009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4s+gWx3Z7SGHYqFVsHJPwfsd2AZQGSH0lSxZmriyQ6E=;
        b=nrM+aHFMbIOJSidSap5OC3QW2k2qXLJd+BHuR1jhk1AZyEz6z3g36j4uupx6UmBCWi
         u1BqRHgGvtuOQuhunj7khyTChNEovtoQCofPomAGvr7DoXneY62OhOQA6FxxaTbJbDAT
         kioWFTlYQxgn9BXWD2iN7+gPwKsW4wMIBWWJFeBrYb+LC+WNaf+bmicMGXMDaFmUgy3Q
         R4Bh3ARt1PsjA7mBBKOXZXH4CkByUM/FRenrK1SCH7Tf+NpozHf6gjub2Aq4A5XPkpC0
         w0o4Rul6OAXRlmDFvlRhToPYmQccHir0Y8MVGBKSARske/QXL8WuPexIfYyNiJSOnz8i
         gxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464209; x=1789069009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4s+gWx3Z7SGHYqFVsHJPwfsd2AZQGSH0lSxZmriyQ6E=;
        b=VNwpn+VLCc0/uoViPAlGGT6RtNkfDOsQqQ8oLcjqTyoqEYU6MPpdbJFOVUokWGrHsR
         e+4jSh2MCPEoBRYTfB2ETv/LZMdn96bhwY7xkABWhW2tOL2HXPeQsdQmbhTLFhcOeXio
         1dEABWN9QAhyZ2hVsypDP1OC3a7uxDI6yIVRO1DY1ao8oamaV4tK24sgLsmH3Pm6wJmA
         bbkQN05cR+ybH9PAPsZVl97yH8ZK2Y3vfHtE/cq0UTcBJsSVRrJz1YUmnFzcHqoazjCi
         zfK+htTPBbgHkiEMX/Y00vK4t9xo7IC4dUxLmZBg8I5qQAD9EfMMHFFLSd3BEo0Dgr2z
         Z4yQ==
X-Forwarded-Encrypted: i=1; AKwUvBz87lOVHZkEUT/BOz6uMxR49mlPHTs/oJZ/2ImIPkTlHACRDjhbBqtu9DLOMYDFv3VUQs4=@vger.kernel.org
X-Gm-Message-State: AFuF++mgiRyVemae6HozWj/Mc55rXDniDYQ55tbdWBdVME+6iwJGJ0td
	OEqtdZ1y62bdCKtdrV06U5Pt2R333JZUjmDU2xqZ4QQMLYYyP73YU99HYUtw9hJiLzs=
X-Gm-Gg: AYBFou22jcp6cSQx3Wmr3W6uHBVzg76HWZVwOIgSyHSCHPxGvmTj8t/5HqZ7rO8jZP1
	svFadvX3jlNPldSLE2UNZMmyKsYvj+DUNpcVAxp2PDhDIMFwSY9Snk/o4YOK7t08sMw3Ho5e4KS
	xvqoOZqB5pS4788Lo+2D3SOywh1dWApmYp/Wu+DC6xeQhFpPZwimSfXm2eL68Zug2UNlGiw2naJ
	eAD0qBe/c7ulbE9PCbP+3NEOcClrMQlCq9ox1gq0cqSO9DQML+epGwAM0SCbaqndpMt194cEkyd
	oRQLlWYYrxA9xnTRhMHPf/BP7BzlSz3oD1SQgyaAlOyfFDLQaMFltm4ZK+kaxmLgJ4O7fZ7Y7FS
	wE080YqdhTvBqj1jFD53D6xcXjrOth6fGuiazErgRCBwnNNmE/QOdo8rCWm+u/JXZWqwkJBtHxz
	h+IFQSPHPKnr6n0JcjUJyTIyY/jkm3njorjMRi2mkOfB/aIoFK+i0ruzBwibq2Qf5fTlEkFSlV1
	OoTl5FQ9MRu9Dk=
X-Received: by 2002:a17:90b:2e4b:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39b26151b89mr1118745a91.6.1788464209329;
        Thu, 03 Sep 2026 12:36:49 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:48 -0700 (PDT)
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
Subject: [RFC v4 20/24] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Thu,  3 Sep 2026 13:36:07 -0600
Message-ID: <20260903193611.1058589-21-mathieu.poirier@linaro.org>
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

Use RAM instead of flash to store firmware image and boot information,
including UEFI variables.  That way the firmware can be measured and
included in the Realm's initial measurements.  It also prevents
variable stored in flash and modified as part of the boot process to
be leaked outside the Realm.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c         | 37 +++++++++++++++++++++++++--
 hw/arm/virt.c         | 58 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/boot.h |  9 +++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b7553dde5e1..1e8efada209f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1112,7 +1112,36 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
 }
 
-static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
+static void arm_setup_confidential_firmware_boot(ARMCPU *cpu,
+                                                 struct arm_boot_info *info,
+                                                 const char *firmware_filename)
+{
+    ssize_t fw_size;
+    const char *fname;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+
+    fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
+    if (!fname) {
+        error_report("Could not find firmware image '%s'", firmware_filename);
+        exit(1);
+    }
+
+    /*
+     * Load the firmware image in the Realm's address space.  Mapping of the
+     * firmware area in the Realm's address space is done in function
+     * virt_confidential_firmware_init().
+     */
+    fw_size = load_image_targphys_as(firmware_filename,
+                                     info->firmware_base,
+                                     info->firmware_max_size, as, NULL);
+    if (fw_size <= 0) {
+        error_report("could not load firmware '%s'", firmware_filename);
+        exit(1);
+    }
+}
+
+static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info,
+                                    const char *firmware_filename)
 {
     /* Set up for booting firmware (which might load a kernel via fw_cfg) */
 
@@ -1168,6 +1197,10 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
         }
     }
 
+    if (info->confidential) {
+        arm_setup_confidential_firmware_boot(cpu, info, firmware_filename);
+    }
+
     /*
      * We will start from address 0 (typically a boot ROM image) in the
      * same way as hardware. Leave env->boot_info NULL, so that
@@ -1212,7 +1245,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
-        arm_setup_firmware_boot(cpu, info);
+        arm_setup_firmware_boot(cpu, info, ms->firmware);
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f3ece746916a..b1f425f8935c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1823,6 +1823,16 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
 static void virt_flash_create(VirtMachineState *vms)
 {
+    /*
+     * For Realms, the firmware image is placed directly in the guest's
+     * RAM area.  The association between the final location in the
+     * guest's RAM and the system memory is done in function
+     * virt_confidential_firmware_init().
+     */
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     vms->flash[0] = virt_flash_create1(vms, "virt.flash0", "pflash0");
     vms->flash[1] = virt_flash_create1(vms, "virt.flash1", "pflash1");
 }
@@ -1873,6 +1883,16 @@ static void virt_flash_fdt(VirtMachineState *vms,
     MachineState *ms = MACHINE(vms);
     char *nodename;
 
+    /*
+     * For Realms the firmware images are stored in the guest's address
+     * space.  As such there is no need for flash configuration in the FDT.
+     * See function virt_confidential_firmware_init() and
+     * arm_setup_confidential_firmware_boot() for details.
+     */
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
@@ -1908,6 +1928,32 @@ static void virt_flash_fdt(VirtMachineState *vms,
     }
 }
 
+static bool virt_confidential_firmware_init(VirtMachineState *vms,
+                                            MemoryRegion *sysmem)
+{
+    MemoryRegion *fw_ram;
+    hwaddr fw_base = vms->memmap[VIRT_FLASH].base;
+    hwaddr fw_size = vms->memmap[VIRT_FLASH].size;
+
+    if (!MACHINE(vms)->firmware) {
+        return false;
+    }
+
+    assert(machine_require_guest_memfd(MACHINE(vms)));
+
+    fw_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram_guest_memfd(fw_ram, NULL, "fw_ram", fw_size,
+                                       &error_fatal);
+    /*
+     * Map the guest's firmware image directly in its address space.
+     * Copying of the firmware image itself is done in function
+     * arm_setup_confidential_firmware_boot().
+     */
+    memory_region_add_subregion(sysmem, fw_base, fw_ram);
+
+    return true;
+}
+
 static bool virt_firmware_init(VirtMachineState *vms,
                                MemoryRegion *sysmem,
                                MemoryRegion *secure_sysmem)
@@ -1916,6 +1962,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
     const char *bios_name;
     BlockBackend *pflash_blk0;
 
+    /*
+     * For a confidential VM, the firmware image and any boot information,
+     * including EFI variables, are stored in RAM in order to be measurable and
+     * private. Create a RAM region and load the firmware image there.
+     */
+    if (virt_machine_is_confidential(vms)) {
+        return virt_confidential_firmware_init(vms, sysmem);
+    }
+
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(vms->flash); i++) {
         pflash_cfi01_legacy_drive(vms->flash[i],
@@ -3278,7 +3333,10 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.get_dtb = machvirt_dtb;
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
+    vms->bootinfo.firmware_base = vms->memmap[VIRT_FLASH].base;
+    vms->bootinfo.firmware_max_size = vms->memmap[VIRT_FLASH].size;
     vms->bootinfo.psci_conduit = vms->psci_conduit;
+    vms->bootinfo.confidential = virt_machine_is_confidential(vms);
     arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 94386fdbea6c..fe7e14e94651 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -113,6 +113,10 @@ struct arm_boot_info {
      */
     bool firmware_loaded;
 
+    /* Used when loading firmware into RAM */
+    hwaddr firmware_base;
+    hwaddr firmware_max_size;
+
     /* Address at which board specific loader/setup code exists. If enabled,
      * this code-blob will run before anything else. It must return to the
      * caller via the link register. There is no stack set up. Enabled by
@@ -136,6 +140,11 @@ struct arm_boot_info {
 
     /* CPU having load the kernel and that should be the first to boot.  */
     ARMCPU *primary_cpu;
+
+    /*
+     * Confidential guest boot loads everything into RAM so it can be measured.
+     */
+    bool confidential;
 };
 
 /**
-- 
2.43.0

