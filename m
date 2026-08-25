Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD32C11FA
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695310; cv=none; b=HWrWUVD424Gl58cQDovQ2sIMJ8KJnFMO1+qzdeZJtnpvzIo33F+TVlpRrzIXgMbD8RWRos5MaIzyrd+eNnrTWpAECA37TBhJ8JH0ZZ83LMztehkjOYNxZ2RprW5bfsh/OKjQD9ol1Tw/aOPtupHBaBEO7ZeN92FLxI5FbcJZ+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695310; c=relaxed/simple;
	bh=q5JxDstUu48vUjXLQsoJKY5T2rRF5T8zBzHIQPM2DyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/XpNF2FFL7B4wm36AdL+/RTrC1lNaTgxXOTh3fotra8+YahH4AMFCFR1XAD+txXP/8p3pKwDG5Q1068FE5NmWA+VErRhcQWpOwz6tAoRpb0n2AQtasNMBD1h9qflJhm/rXHxnAfOIlSP12/ORmQK5Ut+tzWNNwvKRVSLRYowxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfutzHOL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfutzHOL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1042228a12.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695308; x=1788300108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GUEb8qrMFDYRu4TEpO3RbtQ1bMhwP3ADMRIC7mpS2I=;
        b=nfutzHOLiEW+5PkOICCl45GeoDveHKmIcY1RqLQmO+MBc0a/9p08v0XtsI1m/Wghbp
         8/Pr0JUnhNocEEtfgFRi0HHxWzpYIptEIkuFx1eLWYB86zSd/GyVEb9e3Z6PuHMBzhL1
         9I9K82gS4C56mPfp2Gb9A82Cs4UsBCDTChLEACDVTCvuo2wG9af1B3YFod0sVjgl8nKe
         ui4qy8hx5ELsiSrsZuydqX9Ft4aGFqN2+fZqNyFMAlq6n1cyyFl8+wAP9PG7xxoxfyD3
         oK3Wlh7TbaydGYSuc6wCN84O+fWUm/RG4j7cK0E9plkIe7kYEVkO2wv9L01Kfjt0dqSQ
         UdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695308; x=1788300108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GUEb8qrMFDYRu4TEpO3RbtQ1bMhwP3ADMRIC7mpS2I=;
        b=a71BV1AvKAkUXMknoKUNZOCRwCOQOlDrbbXmJcDrm1st8WcIO2FO4qaF1EWLL/NfSh
         K9/7OsXn3O6hYwe/wtiL5fB34M32AqMIwGgfcjT3S0dmAEuWhRjlN2Ax6A/V5pZcvVOO
         woncgsj+EMTIWS44iGWEhPMIsVVU6Y2MIaUoJC7Py/rWPlFaaShaoJj1cmdBaxIbnyAf
         vMickpzGJSzW5rT+gODaPzLML+yXczf9bORTyvcrck28aGqtXrsAge2pqOIq1k2B1Dl1
         bwMo5ylGcBnk8qW+Ktule0ebeJ6dRCXUxZDNchighhq0sN4Ixei/G5JjkHUbszMDLB2I
         ILjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZoqQ1LxWuehZhpY/FBNUi/z8PIAznZPSCjHfjywfKCjxZ8u2R9U6HjoLH9eaHtN3M/EE=@vger.kernel.org
X-Gm-Message-State: AFuF++l7kPfss1HRYcMVe2DCTsfMGISDqIypm91jafsfQlo6SVryWyM1
	NlBYGaVTGPRxYmgZLaDD29d39sebTokcj4sT1fe2dS+O7GRQ2cndkIPbNKniItO1qjg=
X-Gm-Gg: AR+sD12GRA/VIuP7Pi2wLhbB3e1bOa+dMNGAiDUiNSn4vqqWGe/k3uDgYD/28l8zn0G
	wZhR/BK7sajyPYVb8LUDtjwY9yAUzeI8Uz3dzHdKLHg38BA2gdSieQCEEwej3Naj5e4ul4UmyTS
	MR60L+yvOnbHjqHWAhenX+bE5SJcQceh8JRaKgq5yYZCseGrisyfd7J7JZCD+7OsbSMs3gnTZyD
	vQUvpwLqNYf3AN6drae3hvi7coDzyFSoNuzSHtwuxXC+ZmdaQDYn56Sb1zL/DCfRApLPtP5F+dp
	Li9qcKsz8CjkLaoRzMUfkIRyTQv3fqmCSk4rsYrwPQG0gLq1iIe7QEKSOCoTlCZLrwhHUTsjCu7
	c1NAM9noeqIP1CYh6n3dv06dKS4KkycWIiVdvkolcQikgv9NlbrufaF1U/3E2UWRJaUvL/ZWm0T
	5wUrQgwz4h835UXQiruSUTG2CLj8IyDKfE8grQVYDTy13kJEhNnPy9UzhDGuFoYEUCveNvHb4ax
	Po4f9Br12YZIyk=
X-Received: by 2002:a17:90b:3dcf:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3966d372bf7mr2542412a91.2.1787695307862;
        Tue, 25 Aug 2026 15:01:47 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:45 -0700 (PDT)
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
Subject: [RFC v3 20/24] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Tue, 25 Aug 2026 16:00:57 -0600
Message-ID: <20260825220101.3443954-21-mathieu.poirier@linaro.org>
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
index 780b6be63718..5e85be2bb462 100644
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
 
@@ -1163,6 +1192,10 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
         }
     }
 
+    if (info->confidential) {
+        arm_setup_confidential_firmware_boot(cpu, info, firmware_filename);
+    }
+
     /*
      * We will start from address 0 (typically a boot ROM image) in the
      * same way as hardware. Leave env->boot_info NULL, so that
@@ -1206,7 +1239,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
-        arm_setup_firmware_boot(cpu, info);
+        arm_setup_firmware_boot(cpu, info, ms->firmware);
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 966577d6a66f..b799e5f44432 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1816,6 +1816,16 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
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
@@ -1866,6 +1876,16 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1901,6 +1921,32 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1909,6 +1955,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
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
@@ -3228,7 +3283,10 @@ static void machvirt_init(MachineState *machine)
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
index a2e22bda8a57..8a1bb1106930 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -112,6 +112,10 @@ struct arm_boot_info {
      */
     bool firmware_loaded;
 
+    /* Used when loading firmware into RAM */
+    hwaddr firmware_base;
+    hwaddr firmware_max_size;
+
     /* Address at which board specific loader/setup code exists. If enabled,
      * this code-blob will run before anything else. It must return to the
      * caller via the link register. There is no stack set up. Enabled by
@@ -135,6 +139,11 @@ struct arm_boot_info {
 
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

