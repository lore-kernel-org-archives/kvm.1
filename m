Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552D473C90
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266841; cv=none; b=ap/9bZWRPKniZlwgRZdGmsTKcWkgcMikXohXWfT7JFMRcRuMl8IYZJXMBSIVMqIx4ORolcFBpYxPhzZZDeSNquq8NV25K/aXKTp7Xsuwlv6KdXSwOW5+uqH0cz63QBWiRTo8sKrKUeceu054iPzjJqo1CGc+4/Soitv7sANgYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266841; c=relaxed/simple;
	bh=1AsxpXcworjn8nRnDntyhfBuXwfpTUqARck0wU7cQoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUZOztIw2HeP2fEIMTkpVK+4rlg7Qr+d0QlokqNWXoSWUHfYSzoWv12PCL7uWHTeZrifFCE1tgYZJansE8MzlaGThfGKMjXvfTCpSkFV7EUjwtfcH3HafcT6X/3eLfTzDk6mVst28U3+xz7in83pPi4zQh0TJSUWPe9HiObauMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxPY1Slw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxPY1Slw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso183793a91.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266839; x=1785871639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9HsMvAh/qkeYI9JbPnuTDiGCok2SGFh9CrU4gL7bDU=;
        b=NxPY1Slwy8L7QBsSzqT8N6mHZVdp4LtfF6ztLfI3SXnXmPiTveomJj+HgHnu1WaGjb
         0VGYTQ8pEiIaNnGVkEsqRqHveR4ng3FD8BnmztmbcJaz6T2IUrQ7MXFxBWrxaLHdXlHT
         Q/pnvd2e7YJFSI9vZCx2QOtgZi+hWbCexi1eKtGw2DAbylhnJyelinE8EPe2xkAhpc6Y
         rmyk5Sbeagla/x3s1nJar1Dch592DbIV8vdQKEKy43YWuM/TbgunKl76dMxmDQxijiHv
         ad5tl/eylrnin6hMdlsqlqLBCCjRV5BcPsaGJRDuC2mr6dPGnSPSZDqdSCV2mZuP1AE9
         fuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266839; x=1785871639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9HsMvAh/qkeYI9JbPnuTDiGCok2SGFh9CrU4gL7bDU=;
        b=IlZgYPlV7pjLoKcVm1BKKXbqCd1WVFvM5EWS3azoawN0XIzMA5OtWR9fWKmzA27/vg
         97o7U8TCb5R2/PjywXInoDaqZGuMKuQ/+7Zb2LwXjubhilrPXQ7Is/iZ/2Oe1VJXN0e/
         OAR1V6KHva2uaXCyMs/kWu6XhyyYc42BqvqnXzO/QwFPENJeMClUQPpZMIcQnBJPavcw
         sSk6THeBNCThwh/PxEZdJttfBEC4j5qwxc6kUzg0DBjzoSTM9Lp9Am+zcGX65Im9uVGq
         qz7pHaKezbcYxO5e7leE+fgRQZt+sNGpICjeqCQ+jNqdAXfiWmJGn6Rx+ZV+GD7hfSBK
         ScxQ==
X-Forwarded-Encrypted: i=1; AHgh+RptrLpkEcboycuxt1miAINFs9ZY2qO2F0icQaDuOWYphDaZJg0y3KRiJemNH7ZUho0otL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzec0rEoW6SXC2l6g0x2hPAS+OHyX5sUoOsDszrOjFb+IfM+CUv
	dTzi/v/jcDbCuzRYCGw2B9Ef7kC6G9tmLBNyno8z5mFPv3UMYaeLlYv1iS7YL0tSkm8=
X-Gm-Gg: AR+sD10KhFkx8p2XYGpqnyygrkz/QlU6Lwsfj8sgZdIWCmP6Q+GfbCkoyXN6rXjJ17i
	hqqbBmHalGNjGwmFW7H9g9IhtVVeJT+G8si9Y06pDG0Zl7IEwquPBxy4nUI3KnM7KX0vxpTUr/R
	nEmqZDvOHqmAqbwtRqvDjUqGcrezgi92wl+pu3k5CvViTWRWafIKfDjI5zBTaMWIMAZAQ2DaIGH
	MUeA91LnCtyspBEwS1ssbsek1dVspRzC/Pwel+XDixXkp2rRQgV6C/dKJOodl0SipTIwg8ZtyjG
	DDOody69nRxtok0XvfCoeC4ujZG5e+736UbWpl3Kd10zqWzRuMfCZsapKGY8xTGDs5Q/wvwMPQv
	3DHuyrBeFxG/2TaTxMYkdY0N4tdssXema2qFDg4ppr0PaUItrolt9My4VOMbcz2Yza5/KKZjCoI
	oety/w59iHWKFEYLR19uBYnIS59V11QgRwIcen91ZJq8AETaXXOrqEuk2ov/jfUshCiuiIeAu/a
	mqgwJlK5EJP6MQ=
X-Received: by 2002:a17:90b:2803:b0:38e:79f:76c6 with SMTP id 98e67ed59e1d1-38f6a4e2786mr3548232a91.24.1785266838605;
        Tue, 28 Jul 2026 12:27:18 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:18 -0700 (PDT)
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
Subject: [RFC v2 20/24] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Tue, 28 Jul 2026 13:26:26 -0600
Message-ID: <20260728192630.240375-21-mathieu.poirier@linaro.org>
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
index 74fe21712d4f..ae663d051ac3 100644
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

