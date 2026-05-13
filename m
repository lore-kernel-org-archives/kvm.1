Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFE2253FC;
	Wed, 13 May 2026 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702861; cv=none; b=k3N+1k4FTpDzqPEkT1jWmE0JvERX7zlIJwtY2g5ijwtpK92rhZW+M2ltct6pwqcGkrFD33OTaDROerOhZnLM6iqhUwZYuooU82hlDaz0nS/76GkGZ7+J5bW9M+sQZXv7zRto9eSLqZMdL73AkjKTmF3XEcK5Zu9C27IeM6T6co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702861; c=relaxed/simple;
	bh=J0mAqijFNFLdUWPYIh1s2gKwT8l8nyInIiB+eSjjdoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoXhi0jgDXoTFD9M49NE6RHh36A4yhSFvHR+Mg2eBiaYVpbD38LG/eoUH/WOQLjyWqI1I6gN/VuLMyCbMpxcx0ifIu/4M64EiTNROXQj2yYj796DMifsm0bFs5C4Kg2BmtbEwfwUHBGKQQYVhdVRu5PyHUEwiTnYeHvgmaxQYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YMozGyFQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YMozGyFQ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73E9040E00C2;
	Wed, 13 May 2026 20:07:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Yphsx2uLLhQl; Wed, 13 May 2026 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778702846; bh=uhqod7nMzIBOmkzPYgOCMxxE1tt8dwN2H4ulv7fvVDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMozGyFQcWL9VF58/+OM/R6BRC7Dq8XFu++f8Llq3gWHHU2HglcMhltVxNJj6tzKk
	 AGoK6P7DAWc6HTFYzPJlCpD3EtYZ87x7TFIXibQ1P5bTsfKgWsA5vEWftOozHPzQG0
	 RRkQSyksF/avHOmGT1s74ZPqqbG1psZTcYDyvp9iU61le928TewMutyCP8BCezSnpP
	 eihGKythF25xtF18lY64g1y6svjmDVYgKnYZgbGqAj/Q9UWj2DxMIQobEnyza6OeFn
	 MzCSxJ6NYndUwfM/C/eIlF7Jbxukkp3kMuMRajSmXRMCy2jZ5JSnVm1wgOMJR+K4Cg
	 +onH2EskYuO4msgH0CKGlA7FbhW76/iSJrIMPSjQ18uFfM+0P1BOAzm+LYmWf/Qa1/
	 BLFwNZgUYL82gqR21y1F89B+7A+8ffJd8SbnmhCe6zhFOS9AM8SYeq/ratMsekJZ7g
	 J7i3ptuUoNBIHmTydnzaLIfGyp0dvzj1g6WrOwZzrLaqJxWMMBh2/C98+kSHFi9Qqc
	 8ql0FjTxe5pus+6CpKrm6k86lpThHXhiQy7Eu0Af7ae6dvgFkPrfNLXSAxst+IhVJH
	 vq4GHvGnJTEYx0Ul0Nt0FCKIDUqlSSTSquNHgIRDrQQXXcCkN1tz2f8ApdB848f4VW
	 q6f5nSI3nbpJdJOGHWQAEFTs=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C3DBD40E00BA;
	Wed, 13 May 2026 20:07:14 +0000 (UTC)
Date: Wed, 13 May 2026 22:07:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: [PATCH 2/2] x86/cpu: Move intel_get_platform_id() to cpu/intel.c
Message-ID: <20260513200713.GNagTZ8QI_BHBeZXXr@fat_crate.local>
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

It is not only used in the microcode loader anymore and the platform ID
is cached in the cpuindo_x86 structure so move the getter to
Intel CPU-specific code.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/microcode.h      |  2 --
 arch/x86/include/asm/processor.h      |  1 +
 arch/x86/kernel/cpu/intel.c           | 35 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c | 36 ---------------------------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 3c317d155771..8b41f26f003b 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -61,8 +61,6 @@ static inline int intel_microcode_get_datasize(struct microcode_header_intel *hd
 	return hdr->datasize ? : DEFAULT_UCODE_DATASIZE;
 }
 
-extern u32 intel_get_platform_id(void);
-
 static inline u32 intel_get_microcode_revision(void)
 {
 	u32 rev, dummy;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67dd932305db..1a68a955863d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -237,6 +237,7 @@ extern void early_cpu_init(void);
 extern void identify_secondary_cpu(unsigned int cpu);
 extern void print_cpu_info(struct cpuinfo_x86 *);
 void print_cpu_msr(struct cpuinfo_x86 *);
+extern u32 intel_get_platform_id(void);
 
 /*
  * Friendlier CR3 helpers.
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f28c0efb7c8f..3473b89e6907 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -199,6 +199,41 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 		c->cpuid_level = cpuid_eax(0);
 }
 
+/*
+ * Use CPUID to generate a "vfm" value. Useful before cpuinfo_x86
+ * structures are populated.
+ */
+static u32 intel_cpuid_vfm(void)
+{
+	u32 eax   = cpuid_eax(1);
+	u32 fam   = x86_family(eax);
+	u32 model = x86_model(eax);
+
+	return IFM(fam, model);
+}
+
+u32 intel_get_platform_id(void)
+{
+	unsigned int val[2];
+
+	if (x86_hypervisor_present)
+		return 0;
+
+	/*
+	 * This can be called early. Use CPUID directly instead of
+	 * relying on cpuinfo_x86 which may not be fully initialized.
+	 * The PII does not have MSR_IA32_PLATFORM_ID. Everything
+	 * before _it_ has no microcode (for Linux at least).
+	 */
+	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
+		return 0;
+
+	/* get processor flags from MSR 0x17 */
+	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
+
+	return (val[1] >> 18) & 7;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a4c0a0cf928b..f55ff81682e5 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -120,42 +120,6 @@ static inline unsigned int exttable_size(struct extended_sigtable *et)
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
 
-
-/*
- * Use CPUID to generate a "vfm" value. Useful before cpuinfo_x86
- * structures are populated.
- */
-static u32 intel_cpuid_vfm(void)
-{
-	u32 eax   = cpuid_eax(1);
-	u32 fam   = x86_family(eax);
-	u32 model = x86_model(eax);
-
-	return IFM(fam, model);
-}
-
-u32 intel_get_platform_id(void)
-{
-	unsigned int val[2];
-
-	if (x86_hypervisor_present)
-		return 0;
-
-	/*
-	 * This can be called early. Use CPUID directly instead of
-	 * relying on cpuinfo_x86 which may not be fully initialized.
-	 * The PII does not have MSR_IA32_PLATFORM_ID. Everything
-	 * before _it_ has no microcode (for Linux at least).
-	 */
-	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
-		return 0;
-
-	/* get processor flags from MSR 0x17 */
-	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-
-	return (val[1] >> 18) & 7;
-}
-
 void intel_collect_cpu_info(struct cpu_signature *sig)
 {
 	sig->sig = cpuid_eax(1);
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
