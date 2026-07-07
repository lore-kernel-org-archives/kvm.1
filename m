Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F2399369
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464233; cv=none; b=oQxWwmzlpe8BrM7gCXT61fmWqNqBvDWU7nnL1GrqPDoVuiWnG93QRQCoHf6SpGGt2wRLuSyXRoae8zUQa78bXOQsZQFNvsTOgiqe/eiYT8ka55u0Oy54HyUYzTuCwVvBYqwWWaBtoQeqtRn9hVoD5V0gQpyCX550HrIqpmV9ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464233; c=relaxed/simple;
	bh=0WcyfDNK2nzWsLC9B70vKufRjQe+QkSIMH34mo0T8HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhTnYyfmqj8YJVkHAIfJE8kqULftGhoQ19QIMtEYKi2Cg0Q5QL9yPsZOuCfffCn0WqL+c5z6Yc7u2QqZ05QdzNCxXi9fkBSsAat8kM/lZD8nLNZfuEDDLvchOI2o8MTCP2LIpJksgc8efUboU5sAFwasnMTlWZZIHggWFcye63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkYswN2J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkYswN2J"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso1144345ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464231; x=1784069031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szLdFhlpH4Hli47T63h+38xa0y28rVtNKLzkycxlo6A=;
        b=EkYswN2Jc56CMgY0Q3y55VzPRUd8hVS57qynodrtYC1imJeIqP9giM13D512jHjdgT
         DEQc0tgrQ6HYzmTtsfBs/8yImPBGUYNwPUPt6wp01ZVoU/Fnk3xJsUOKBn+GMAxlaD6x
         7dqpKg3gz1UM/pAWMj9tLkBBk8Nsg0lyxnfKjfga5TUS6GY5iKDBdc5Ig26vOs+UQsEm
         A+h5NiLLek+iQ6ncYlczt97T1bD7eIhy62nnaM05dko5X/GmAbeYONIzVQeGeU1hdf1Y
         kUXVmrv2DuiTbWPbG8yvQnvwPkB9R0WDWCs+elIGxSpZbfZ2+v/blaCcT2DY3vxpGcpz
         eH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464231; x=1784069031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=szLdFhlpH4Hli47T63h+38xa0y28rVtNKLzkycxlo6A=;
        b=AHmRquazxo7MQEwLYIjY2vJPRl+o6fDS6atqE5okvZxCf8SMT/tOF3Zu3Ty/+1gUEm
         K92xUlJraAe2kNoD6fvRJ0V1zmqoELp+HG6CkJHw5SAz091JPdDAxpu/QS07ls6tXiC2
         W5ao6XQeppeS/ZI/R1/NL+LLpD2S0aEWpjAgOq8nj5UGyhmF2TSwgiFvvrDBKIiCo1tr
         0Nm6t5B9skV/N08eY8xUPAxt1GoJgrlBV9VfNVFXkUgUn65gGZScMaBMocdZEGvFruue
         tw5fwXwRln53NMGNeFKc34JQrBcCCwQ/GoVQeqf8bEQxENkdoYiCg7YNrZTu3rwTnRsD
         6oNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqbum/P6tKE86/3vthDUkZrpLHxSg4iz6Fq19PhNriK6IxUSCzJh0Ns5awJxNXRsni5TW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTcqfz47NAVe53b3nQbj5SP0iphK7ziUwuH0jEXhpRgs923Yz
	yTBVvnoKTbEolU92mFSekD3x5WAM/Oyx210PJTUzMkqCQAhT1V+7ViSb3/tlYBiq3ww=
X-Gm-Gg: AfdE7cnCVOOiTLtMJio3YLehglccuODawe93ZoaFZiwH+iCIFtYpeS4AioFQHkflP7f
	sJufbT2CW4nHUd84ea8Kq62Pg18IWstF+XvwV099yQ9nq9wrDmzE2R7t8gfc9gvGg1408w1YICj
	Tf0TYAs4vKFpRziBRNz7g7sEFW3aVWbQlfPBXbDspFC1XHRuI9eA2nZubIGK4YuSvXnncx8wn4u
	hOUrvmAzeZA7mZ6v5iOMalgQ+zUz8+g7CNkcxugqcwKyw7yKtVlqTEcK5WoQIzHuxrT1Joyn4Wp
	2xP+3H/dMg4dKXju5d8wfEng4xkF3VjfBLOw4bBVbfgxRlqHn7Z6o34MAF2K3NGhXtfOrUWNMyn
	kVkIVwNr7sS3c4RbVvL50onBCvdzBI8oSRePEE0lZFgC9WvOaVF635rmgXwICSxI+L5D+nFkEHO
	CXDm5ZVpHgZU2e0UzDfopLSVDjHp24qV2cjAt7+3A=
X-Received: by 2002:a17:902:eccd:b0:2ca:a284:a136 with SMTP id d9443c01a7336-2ccbf188823mr59188875ad.42.1783464231074;
        Tue, 07 Jul 2026 15:43:51 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:50 -0700 (PDT)
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
Subject: [RFC v1 21/25] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Tue,  7 Jul 2026 16:43:02 -0600
Message-ID: <20260707224306.1202330-22-mathieu.poirier@linaro.org>
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
index bcab21d349b4..aea044fbed9a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1113,7 +1113,36 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
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
 
@@ -1169,6 +1198,10 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
         }
     }
 
+    if (info->confidential) {
+        arm_setup_confidential_firmware_boot(cpu, info, firmware_filename);
+    }
+
     /*
      * We will start from address 0 (typically a boot ROM image) in the
      * same way as hardware. Leave env->boot_info NULL, so that
@@ -1216,7 +1249,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
-        arm_setup_firmware_boot(cpu, info);
+        arm_setup_firmware_boot(cpu, info, ms->firmware);
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2e8e29244284..8b79c3ea28e5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1821,6 +1821,16 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
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
@@ -1871,6 +1881,16 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1906,6 +1926,32 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1914,6 +1960,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
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
@@ -3276,7 +3331,10 @@ static void machvirt_init(MachineState *machine)
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

