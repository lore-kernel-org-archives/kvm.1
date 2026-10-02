Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504E4AB1A1
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972464; cv=none; b=PGNEaop9ytR8FHGYeS0vwCfGbFOI8IuTNBBU6Mhj1psaPS5edCDdReXaQMUbK/BaDJalZqZIqzjaF1XwXbG0cgejQ3WpVELWnTPCLmNua8M8giVsbzAj5qeZauoP4LTTPw7F0Vwht65vP8Zcvf56Zrqoc52odxPY8zvIrKg50yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972464; c=relaxed/simple;
	bh=csTrm6evRtqsJB1sgYRRxecHhidXhZKzqLxLnu4b/54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSdn3x1lJ67zPwe4D7IrTf/5xlRjSaXdnCld0IoYuZ6r21VTKrO5Fcx02Hai5sVV0II22fzYr+2SFg3LUVzkztH63ZR/tNqO+JTkmxez6IznpaJU9XOzrnfI1kpwFUba68kXEkbctz9sLTk9mGT/j2PjQPkb/RJYQvNviHNhGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HQXaph/m; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQXaph/m"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so53353845ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972462; x=1791577262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+ANu5/w+3rJ4mUcgJRlo2PrYM3VCrz9wWUfzRyMbAU=;
        b=HQXaph/mQ5Uwe8KNYEazynzTWm+Ck3WaqWyBkNstOOq+PK9/TqzrpAjsErpXG1+Gkg
         yOy0vSor9o0OokdqXWc2SWvJJnDyNsjAYu3CEXpL2R9gRckV/siQGX7gXT1v+G7+E8GC
         7JfmOTYVKrCyApO+9RspOeDm5Wu7U8XD/btqHYKUAVz4WTawTzxOH4jznnQbWg+vJjZN
         DzfFuTUMjmQ3MxLNKoC3/ZsPZtEfpZeXYmmUHYMh+u6CzxOoQtaqtKaxLPnj1LlkGBkS
         cIGkCTAWSuSq3x1VLWzajqIO7K0slHgtL01DdO1DL+SJl68PoDGXurSkwvehHdo76rEN
         cPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972462; x=1791577262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j+ANu5/w+3rJ4mUcgJRlo2PrYM3VCrz9wWUfzRyMbAU=;
        b=J3d6QOMN/x6fTW5Z5drljG00acwhrQcUBGTeQRXiox0LMUF5N2rtZqAe2lhrR5XLNo
         tZr98Ngfikz92a7Y2QNABxX+59YLD7MrdVgI+GZgnmSIxQW6B1RTEH5COYwc+ouphmjN
         l9qcgAjVHI8igViDuSKaBe+PK0mjdZasUkYjWgX7Nk08mqvlAgQwr0SdWJM9K5yvBEKK
         jQteJuPGZEV8PBgv6Tqgw7NT9w6CynWwJSJJYLYwbd39M2bp1kMPVjfvGhWLYfuZxaL0
         jzKT+HDRKsE+ZR0G+9vGauZEwMM0+tQuOIhIJIxPB6uMBCGxesBRcbamq2VYD5+vBAgp
         XfPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGrfNdno8EeI7HJt64AEDQXV9YUSheXaLRmz7BvPsba3t3WUb8LEkabVm73H8J9KSZvOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb8bpbbVde1VoVcFHuobzmapU8ylPhu51j7Eh6MhLEdeW+Lf7l
	+2WCS8D1jw6mvjCz2Xhcs4UzJhOgytIFaJpcIC+Z5T/Vj5ExCB7kKMNK8/kWBTdMnY0=
X-Gm-Gg: AYBFou0dPqcjNTTd6R56GXJcqUXesufmVx9MMMDcfhw2DXV6JG6AIYWmD/3HgAajXSV
	kCzIGiCtxqXopdnXGWNQQDmOBBEsw+nb3x6u9g2P6x35LjqAZ8P1zQDanZaOHdRkNjUfUZk4i83
	7e3knbFPGieSBDSkypicUtqvcG28ll4iHQDWWfmvnKv+pl0w3c/PLGY7pNqiBZmsn1Z7ep6S8j1
	WkP9cmRDf7zbXGzKMcZTeDrn8JLwljehjQlDSiaSIVZ4e13+cqdw5prs+Uk/WhQXHrB0hp3BMAZ
	Es9pX26tq7KuXr/cKt7+y+SovdX40sZrbtBxRTpQ2rmSzEgqlj6rCLvIbeSsy/SD+FVIh24MeKd
	CMPYMoXGqQQgT/PTk7O6aYuYU1EQkdv0tfohkcoNh4QHLRC8YatQ9zkMlz2xv80SfXx5wj0lU1i
	QYXuYKZL1VTFFquaj7r4n32roZ6BvA0igo5crSoeHogZTcJRK//RjB6LTFQqkIYMJLxgehra+ZQ
	4BCWEwlPlK97jozhG8V0QTZ
X-Received: by 2002:a17:902:d98c:b0:2df:8b9e:f87b with SMTP id d9443c01a7336-2e49b64e333mr34944315ad.15.1790972462440;
        Fri, 02 Oct 2026 13:21:02 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:21:01 -0700 (PDT)
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
Subject: [RFC v5 18/22] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Fri,  2 Oct 2026 14:20:22 -0600
Message-ID: <20261002202026.1204110-19-mathieu.poirier@linaro.org>
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
index 886ea7a97ea0..7accb9f55ec8 100644
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
+    assert(machine_require_guest_memfd_private(MACHINE(vms)));
+
+    fw_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram_guest_memfd_private(fw_ram, NULL, "fw_ram", fw_size,
+                                               &error_fatal);
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
@@ -3271,7 +3326,10 @@ static void machvirt_init(MachineState *machine)
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

