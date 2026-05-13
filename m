Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37638B130;
	Wed, 13 May 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702789; cv=none; b=llntqzPCeYlvr1ePXd2YOAds00NyJL+3sSLgFkPdbzA5sjz3psrjyxJnMrWN+g/fmuF/gNuuL11jRd3E/l3ZhVF5g6XzRFDVwW9D1SBoSPWdz5R4UNDy4PfoIEMFoV+IpoHBEDcvm7jOXyGmmv3yFzvtKQ1vZbXpk9xdksrCVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702789; c=relaxed/simple;
	bh=7ZZECGxGNKYrybnvr3E5LIBcaCPRpPCrTjrY+Ulh7k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz9oNw+qIjlS5ycyq3H6Y3o1apprnHDN0OhgaXhZC2MtfrYvOs2zZBPxj7lZTKIJShJzlXrHT/p+o8ChK5i18orHfe36lWBV20giIlvmU+M+ah/QeIfpfqI8sYueJRxObUV9D1qe0q9gnk7Rz346tNhYyhEr5sv266MckXZ21ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E27WgCIi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E27WgCIi"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A52940E00C2;
	Wed, 13 May 2026 20:06:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P6djZ3YhYVZa; Wed, 13 May 2026 20:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778702774; bh=E/RV+iPtOZwfTRC2t3bRCqJjO4fw315yzEOYN0Qwj4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E27WgCIiqsp15bxcKdhssyPNxJ8SmeJ7LIkK7o+VrL7iTGdFgWMojDRtROCA+++SZ
	 lJsYPOkTSb7/k5v+HYLo0PmkUibZRrBy3Y+wcDOI8MgQViY/h3IHmjvcMXdJpweDtg
	 h8PvOzTCN7aI3ISlbnrM7ZBz7qSyhq8R88kKRj6IDy5cU3/aY11hAhQSYCCIInqCGA
	 BHejQKOiPVja3vCHbXJbUV8o/1AuD9NoMUw/P7oEZwoV8OJXaPeByuSw0TYO8e6w4Y
	 k2WY26McBUGsiBJZ3sTbK8Lmem4fsBYFF6IaP91sJoyf8nvz9dpFvx9VO1bAH0NiqV
	 i1PUi+F0LtDFk6yxqL6gMbP4q4xAq5mZtiBtQ3ciZM1b04yEEhK6kv9V/i0HmXXHjx
	 qsw0dn4gUNJCTcNMd/ZWy5XjGEmeFBhq01NC7+7//iJnuMhzpZQLYPd3IVvaIMb1P7
	 kY9xFdSJ2xFuXBa20kay7tkdbzBuEaxyxUt2X16ozNwEt3d3q9RWkJUJ5bbUpoA5xM
	 BgIh+P6TEYvQ+uRv98SC5IbHMb8V7OM+eHKgLr5djP1KRrsJWJUDoTpsse22QR171h
	 hx2BCq0Tah+3gP+4t5JVbQsM1RlXG5x/wq8ak0cAK5e7sPfE+26gH7UQsi8tVMMS1M
	 rXlYgzxwAriUbCUPOYKEbH0I=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8E0BD40E00BA;
	Wed, 13 May 2026 20:06:02 +0000 (UTC)
Date: Wed, 13 May 2026 22:06:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: [PATCH 1/2] x86/microcode: Do not access MSR_IA32_PLATFORM_ID when
 running as a guest
Message-ID: <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>

Patch in Fixes: causes the usual:

  unchecked MSR access error: RDMSR from 0x17 at ... (intel_get_platform_id)
  Call Trace:
   early_init_intel
   early_cpu_init
   setup_arch
   _printk
   start_kernel
   x86_64_start_reservations
   x86_64_start_kernel
   common_startup_64

because the kernel is booted in a guest.

In order to avoid it, this MSR access needs to be prevented when running
virtualized. That is usually done by checking X86_FEATURE_HYPERVISOR but
for this particular case it is too early yet.

The platform ID needs to be read as early as when microcode is loaded on
the BSP:

  load_ucode_bsp ... -> get_microcode_blob ... -> intel_find_matching_signature

and by that time, CPUID leafs haven't been parsed yet.

The microcode loader already has logic to check early whether the kernel
is running virtualized so make that globally available to arch/x86/. The
query whether running virtualized is getting more and more prominent in
recent times so might as well make it an arch-global var which the rest
of the code can use.

Fixes: d8630b67ca1ed ("x86/cpu: Add platform ID to CPU info structure")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://lore.kernel.org/r/20260430020953.1405535-1-binbin.wu@linux.intel.com
---
 arch/x86/include/asm/processor.h         |  1 +
 arch/x86/kernel/cpu/microcode/amd.c      |  4 ++--
 arch/x86/kernel/cpu/microcode/core.c     | 22 ++++++++++------------
 arch/x86/kernel/cpu/microcode/intel.c    |  3 +++
 arch/x86/kernel/cpu/microcode/internal.h |  1 -
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 10b5355b323e..67dd932305db 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -733,6 +733,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
+extern bool x86_hypervisor_present;
 void microcode_check(struct cpuinfo_x86 *prev_info);
 void store_cpu_caps(struct cpuinfo_x86 *info);
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index e533881284a1..5c0afae75e9f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -322,7 +322,7 @@ static u32 get_patch_level(void)
 {
 	u32 rev, dummy __always_unused;
 
-	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present) {
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && x86_hypervisor_present) {
 		int cpu = smp_processor_id();
 
 		if (!microcode_rev[cpu]) {
@@ -714,7 +714,7 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
 			invlpg(p_addr_end);
 	}
 
-	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && hypervisor_present)
+	if (IS_ENABLED(CONFIG_MICROCODE_DBG) && x86_hypervisor_present)
 		microcode_rev[smp_processor_id()] = mc->hdr.patch_id;
 
 	/* verify patch application was successful */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 68a1a893246c..dcc688f4d35f 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -57,7 +57,7 @@ bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
 u32 base_rev;
 u32 microcode_rev[NR_CPUS] = {};
 
-bool hypervisor_present;
+bool __ro_after_init x86_hypervisor_present;
 
 /*
  * Synchronization.
@@ -118,14 +118,9 @@ bool __init microcode_loader_disabled(void)
 	/*
 	 * Disable when:
 	 *
-	 * 1) The CPU does not support CPUID.
-	 */
-	if (!cpuid_feature()) {
-		dis_ucode_ldr = true;
-		return dis_ucode_ldr;
-	}
-
-	/*
+	 * 1) The CPU does not support CPUID, detected below in
+	 *    load_ucode_bsp().
+	 *
 	 * 2) Bit 31 in CPUID[1]:ECX is set
 	 *    The bit is reserved for hypervisor use. This is still not
 	 *    completely accurate as XEN PV guests don't see that CPUID bit
@@ -135,9 +130,7 @@ bool __init microcode_loader_disabled(void)
 	 * 3) Certain AMD patch levels are not allowed to be
 	 *    overwritten.
 	 */
-	hypervisor_present = native_cpuid_ecx(1) & BIT(31);
-
-	if ((hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
+	if ((x86_hypervisor_present && !IS_ENABLED(CONFIG_MICROCODE_DBG)) ||
 	    amd_check_current_patch_level())
 		dis_ucode_ldr = true;
 
@@ -179,6 +172,11 @@ void __init load_ucode_bsp(void)
 
 	early_parse_cmdline();
 
+	if (!cpuid_feature())
+		dis_ucode_ldr = true;
+	else
+		x86_hypervisor_present = native_cpuid_ecx(1) & BIT(31);
+
 	if (microcode_loader_disabled())
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 37ac4afe0972..a4c0a0cf928b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -138,6 +138,9 @@ u32 intel_get_platform_id(void)
 {
 	unsigned int val[2];
 
+	if (x86_hypervisor_present)
+		return 0;
+
 	/*
 	 * This can be called early. Use CPUID directly instead of
 	 * relying on cpuinfo_x86 which may not be fully initialized.
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 3b93c0676b4f..a10b547eda1e 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -48,7 +48,6 @@ extern struct early_load_data early_data;
 extern struct ucode_cpu_info ucode_cpu_info[];
 extern u32 microcode_rev[NR_CPUS];
 extern u32 base_rev;
-extern bool hypervisor_present;
 
 struct cpio_data find_microcode_in_initrd(const char *path);
 
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
