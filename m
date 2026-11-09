Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263508;
	b=s9AugOi4+TZA3wvrqQaF5l2TiwlO26z+R6M8pgGqPIEIDg7XX9sSwf4bYooxg1YEtYFw
	 hnbSVJ/LhNw9mchCdC18IRQdMzxcfux8hqZirUr7J9Cf2mvCnJFWkKRNDzX47FCoKlAwM
	 VOCODFptIvB13Ryk0sYb8DEH8Pv8yBQJKnhWez9WpB58UuPD21ndVtrn7by+TSEg2UAKN
	 uIRuQKaF0RnEsQNttALPzugc2ytDpK1CzIrDA1NnBUxMsUTi77vgwuBwfsRnHQgBHVaH7
	 2ZHbJGMRW1PMYa8ETT97GWm0ge/CUNU9Fp2ANwI6jkxnOM3VQuQniIGFX3NYhfLJcPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h5Uqi6g/D0f15AV2QVQ/dcG50oz8u/1r9m7QJ4cPsVg=;
	b=iKjM7kYsa7dROZvmM+3DPu1BjW+hGq46JN2hjvr1wkcofiv+ZeksKBFrENXOhAKw+01H
	 O4vV/E81RL3AhsSJp3eVTNEmvmIEoUR1yM498+6c2jd8btRESD8IeXHBn5T992l4UlTgV
	 nOmLEJNDLA9A6O6mnFoIkUYVCR1rAA3uEkt8hf8Pya3YnOw7oUnvIAaKNUgtHg5nkpmZU
	 0bkXwpyGJJ/v/ZMJG7YuuoftC1sIbr3p3PHUu5+DP5YnZXPZXgPCXAmOTR1yHE0Rw8qq9
	 4KYl5kA/tLgs4KJmwD5TUUyHGyJhl3+9y5IEHC1TEdBR3QQxM7MszfopzywOSB3aAlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ye1Av+3X;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2A60A260F
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE2A60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ye1Av+3X
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so586415b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263508; x=1794868308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5Uqi6g/D0f15AV2QVQ/dcG50oz8u/1r9m7QJ4cPsVg=;
        b=Ye1Av+3XMyE8Gu1YCYQLcw9fe2e7WoH+8E0zGSq8ZIt/nmKkKfKJPpqFdWl6PHLoOE
         m4STTsgbP3Jdyf1fCB5KzADCujYQlLNuPduiHq/AJ3InFrq1s6OH72r6Q381a4/cUTYO
         77Wk1YZpk47R+ssGGsjXWI9o5hkokSslRWG4ZSNvJmkB8uGHCjZZEPPl09lqVKVSuY2Q
         fVtkaythJgyhgzXA8VulDTKH1WS6/uGbLEP2qCTif5OJY0FjeCiUpK+o+1V94jDyVce4
         dbjRT34xfdjLFa2i8bLWzZngNXBrwzZIckKGDV9qqgFqmKQHZFg9F6J695NGOOjstnk4
         ZfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263508; x=1794868308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5Uqi6g/D0f15AV2QVQ/dcG50oz8u/1r9m7QJ4cPsVg=;
        b=AuxjVlTdPWbxIWDhGKgQC1ADiFuzcfk6jqMcCv81cPnvW8b5scquvwq7h887AyYxQC
         DiCGh2eLwFGE3cvoxxiZ9ycbaq2eXkCWU4wot/el8WS80NanbcYcXsKf4pedKY97T2e/
         kHw/VnDEi3uzWImZOJceNZNExESxv40AsrjjUnoUKBmCTqwStF52jZrpTT6VIf8of/Ph
         w5OO8ZnbCHlp8L8nz8TEGtwhwF5FiigxTzLhWMa4P9o5y5qCQP5B0GIqdRzyyQI2G10i
         n6EFFdVwV1gL3jPSth/8HZ5MdF4d35j2KzxTog6uQVSAwwyhVl3rPouxG34ensFYIESE
         LGkw==
X-Forwarded-Encrypted: i=1; AL+hErG7BQLgb55Vf2HR6zjb19gcs0/FC10A91bzSwnp83ZW8Y2qbTf+xsmpvC9Ds4OuPwTIbc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w86BLSH6F6Ov1Gg+nwVoTYxXfhijwdNfA4W+gfiCXiMUqTSaY
	KTCHGHsveaoYsf5uCThdaAjfMUr6HYJfIttRwVnGZ3M1nzpjOlutNnW0FGMl/mRp6f8=
X-Gm-Gg: AYBFou2FPNGgtjASt9qiXLO9MHkVNhodFmp0FSWiJAje/JDbqO7NarfwbYn/3z5DeiZ
	fHfNBo2iQeBDoWfagGU+SGPAIqmTa8fxGR8Qcd3TK7SW9rWnk0qUmM/0sRi8yHUMRW9XEBkPw3w
	jL9PV46aveUw1P7pLEyMBJ5z32ZDVeLUEX6tIlNFvftyf2o6K9tFbRKE0ZGgKxvWXF0G9ompMUS
	nQGkUjtc1ADUZ3oTPxadYP6a3nz5DNp69S2WoQ8LBErZ7E3a6kKMCgErxwVZr/G/l5So88zN1vY
	CnQJVPte7TbM8khQeCP1uwDQs4tNOufnBiEAnKYgau9CP5j6eDl+G3vuN+B7sC2JBJIpRYO6XkM
	AUx86kt1Jq6FcdaTSw2xF6+1skgz8+fiy53OuECRD6cDLG2QTp6QeNqfc5CSIy0Rge6v7Bh2Ze+
	eWmmhIOqK9HoeWU7+ylLCfBhkj8CQ/r7ZCNobigj1sh8LysfVxfufqKmOVMnJG8fskWpPFCU+vU
	tWxEb55rNc/VKhzrPmKNuBVcZa8k2t0AgRy7VasEbm028BSxtwrfER/szQ+BU58IXMhLBllrG1Y
	EMX0Q+ZroQFn8FEEQtXwwNc9oj2SnoPytYlny7Mk4XCACx8uEvm7yA==
X-Received: by 2002:a05:6a20:7351:b0:3de:7add:653f with SMTP id adf61e73a8af0-3f18fd8b4bdmr489637637.44.1794263507627;
        Mon, 09 Nov 2026 14:31:47 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:47 -0800 (PST)
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
Subject: [PATCH v6 19/23] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
Date: Mon,  9 Nov 2026 16:31:06 -0600
Message-ID: <20261109223110.1619504-20-mathieu.poirier@linaro.org>
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
index f1ca233a1566..dbb5d2d6fc0c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1832,6 +1832,16 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
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
@@ -1882,6 +1892,16 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1917,6 +1937,32 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
@@ -1925,6 +1971,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
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
@@ -3289,7 +3344,10 @@ static void machvirt_init(MachineState *machine)
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
2.53.0

