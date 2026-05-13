Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295039184B;
	Wed, 13 May 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778667320; cv=none; b=hlRfnPguioc6X/pZ0pfiWuxIKlmu19+u+BapNDR8c+4Vao4pAuxJK8DKKSJX/rPXiieBQQ6nIt5oM7IoJkcK+J5rT7xNqqOeT4TzrZ+uLC4maHLUKIwy1dYSQr16/QGjBw7zqj02cOC/9DSaP/vGkEh7ycEAEC7fWUSwY2f6Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778667320; c=relaxed/simple;
	bh=1HIQE/hv0iAyYiEX0JQdiCERsm/VsJk0i6TveWhtN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k47BQlmSffOTVyTB+5kEuwLOyAdRTXz1pCsTDbSfpljIrL1K4TxFNYgQJRst3uig2p5gnbkB1Np8vCZWpkuIEybxawmaF59qdUH1zAyAIity7mB79Pw2KltIZnvf+kcH2QGSNjGHYLMPUruKMG51ojcGoMWZ4TPtppl59ibkEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GMgn2S2n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GMgn2S2n"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33FFE40E01AD;
	Wed, 13 May 2026 10:15:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wj4NYAtTVI1P; Wed, 13 May 2026 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778667296; bh=YtGOIuNWqFb0V+nK63+U14BSByJr9bl8u6ABPbTzIMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMgn2S2ngAt70KXXD/4y2ATV7omokRw7yhaR/VWeA4YT4vJU4UR0FEnLhdCCWKUVM
	 vUnBo4+5T4HWY0o2t8BvClGLpnT1CJF+ukBYC+FxlZiA6m6OurQszHYOM1BKGHNbJ7
	 YHbmtkvHQzQfRHDo03thqNeGVhbuYlfEaMIz8/xtjc5zwubjJk9l/ZOuzra0SnsurW
	 cFe6WngdZVEORzYRNkVIP9ORPwxUNmwYePjVLgicp2hAaNK64mjM5ziwpAw05fiNSd
	 B4J8fPExwT56ak89Z921GnzeBz0KCPCtptaylUdUwfsvLcJ1Ws+yKV7+K9rENDauDe
	 MmoYhpbpHbjzE4bHhSrlxX5g7930+M9OuG0p/8Zphv8OEtIcpyHLBLHtxdWBKNq+vi
	 sBGL2V2mdWXY36S0IoBpT23lUQmiBShksjnteG5EvSPoO897iW8llfrdhHnl8ViaXX
	 ReCUT2AFiLJTA24XawaKuo6HOrXjHlBH3ARufUXGTqdT+6OZI38qBdghBZjhDu0Zl8
	 W+a3Nexmmbn16pN9PAI8XMJE1zcP7x1jxqsWHmlikfdeFUh/hYmrM9Yf8ceAIvBgDg
	 eq4mwuNGlUuxSrWjN3yFXiMGtovo0voOTjALxhxWh2gf2rOeNfvEOQ+Xg7XbjnLszi
	 RnA08HQhoBhknC4WK1dYAUKU=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1233640E00C2;
	Wed, 13 May 2026 10:14:44 +0000 (UTC)
Date: Wed, 13 May 2026 12:14:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Message-ID: <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>

On Tue, May 12, 2026 at 09:57:58AM +0800, Binbin Wu wrote:
> hypervisor_present could be uninitialized if dis_ucode_ldr is true.
> intel_get_platform_id() is also called during the normal cpu initialization.

Right, that needs more surgery. See if the below works instead pls.

We might as well do it - the question whether we run on a HV comes very often
recenly - might as well make it an "official" variable.

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
index 68a1a893246c..f6722c9618e0 100644
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
+	 * 1) The CPU does not support CPUID detected below in
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
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
