Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5523645D
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589408; cv=none; b=eqr3gh5gCbYL25sn2V1S92Q1dXW+5bBcNVYNltYd1q4DzMRRBQ2GEyHXzsfkSN3jv6atfYHusI6XyUzBOfERCk/CSTbUIWLg1v9zbjcpjvRI4SpVOfW3vQaOcveOpfX/+Z49qkxgYDd0J4NIuVSDkk2qNPkY3x6NYRMIWmlOxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589408; c=relaxed/simple;
	bh=T/wYrUpQW8F/lllaLnZaDztmMDaVEEQjCEn8u/pX20w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bKbwCeX+ccS60KEpMXxEROnjKIpnACGp3BEF+K7/Ww/HJGtj8bO5np9ItbrgHirUBM/wJVIEBmv72FA1kWUJ5AHIAuzFQ2hZ/Kq2c0LNaVCO2GogzIO7mD0q0WOhdmutoPE5diRGYPJlxYoUF5YT7434TkBv4w3fAdO90u4g+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9XyGi40; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9XyGi40"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8482b95574dso13698539b3a.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784589406; x=1785194206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0rNHUIQxvCDBCxW+prkWHFFfvgbo5LJAKBlno9VZQc=;
        b=A9XyGi40Jn6xE3HpYpecobsVdjHYQYmpCqpb7BiaTz1pAmkqO+rNlSUI+Wfcx5Yhk/
         UEFaEBkm0J/R96DNHIWhZ1ZWFDWk1DQ3xPpMhKtcIjU7/Ktq8nvPQtdlrCx0GisbHePO
         dp55YQvpi4ADcZfZTxCnortl7b7wWTfwvu8GjS1eofdVTY/ObwU1ZUjZPOgjlVjLCg1X
         CuodtCFSvVqgN4utonfS/8DhdCYBiI6wQF5qAU2yEB/dqS1G1+vfyGztttX2xnSCLc9M
         VQQowm/OkcY2wBmu8pV6NHIW5WzmzyF3DZzdhxQZsSolMDdUkN3uCwTErvRw3t6e+YCq
         sS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589406; x=1785194206;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0rNHUIQxvCDBCxW+prkWHFFfvgbo5LJAKBlno9VZQc=;
        b=f2PUcw+qSqpyKkIrVov20U5tZxjD3965FoTuhWdDGfxDhycD11TQMkNuhlTqL1YooV
         JIdmK0dC0zPoN2VxlZXnCbM78XlOvOfQA8wFgwd/bVfBUpgOj8WMlS4xT6rDXSpUmC0R
         dNmzTVQCsRh9xlBsDTyGrp/r/eQzuV0MePepRd1ikZu22EnaxAZgDJSM2B95jdDoG2eu
         +s9tj5reQTKixyfaM+xa2bR6mw/VmQJvWPEL7fGdXBUkZ9Q8KOx3LQWqaXnrTAH56PDk
         2SkM1ayTZAMpSHV1TQBhjua856eY3mbwvIeFm29zoNb+Qop026qydrlYOWUDY3jdV2u/
         SOTg==
X-Forwarded-Encrypted: i=1; AHgh+RqqpvHj9hrxWDr7MGm+XFi3e1XfDypeScKzuBQIsNn76hRxNrZrD8qUyp1nXyLl+BWtX7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CX2d2UjuTTHaM3RfpIF4cA1N7kPeZ0Z6sBEfZmpKrJRlDqyg
	36ZTCifkVvvN1EGee2+D83ye+bHHMv5VOXRkxeCDrxlPkEy5kWMnCcNTmRaMATbAWCutW8yBnE7
	IQQCdYHY0LfIbhQ==
X-Received: from pfbdn13.prod.google.com ([2002:a05:6a00:498d:b0:84c:1460:ab72])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:908b:b0:847:83bd:6671 with SMTP id d2e1a72fcca58-84c29334b34mr15308965b3a.19.1784589406347;
 Mon, 20 Jul 2026 16:16:46 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:16:39 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720231639.1592848-1-jmattson@google.com>
Subject: [PATCH v2] KVM: VMX: Cap VMX preemption timer to work around Intel errata
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: chao.gao@intel.com, kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Due to a widespread Intel erratum (e.g. EMR158), programming the
VMX-preemption timer with certain large values may cause the timer to
expire earlier than expected.  The recommended workaround is to cap the
VMX-preemption timer value to strictly less than 2^25 * CPUID.15H:EBX[31:0]
/ CPUID.15H:EAX[31:0].

Calculate preemption_timer_limit during hardware setup based on CPUID 15H
when available, and return -ERANGE in vmx_set_hv_timer() if the shifted
delta_tsc reaches or exceeds preemption_timer_limit.

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
Suggested-by: Chao Gao <chao.gao@intel.com>
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
v2:
 - Use div_u64() instead of 64-bit division '/' operator to fix link-time
   error (__udivdi3) on 32-bit x86 builds. [Sashiko]

v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com/

 arch/x86/kvm/vmx/vmx.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..e43ed863d5f9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __read_mostly preemption_timer_limit = 1ULL << 32;
 #ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #endif
@@ -8338,12 +8339,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		return -ERANGE;
 
 	/*
-	 * If the delta tsc can't fit in the 32 bit after the multi shift,
-	 * we can't use the preemption timer.
+	 * If the delta tsc exceeds the preemption timer limit after the
+	 * multi shift, we can't use the preemption timer.
 	 * It's possible that it fits on later vmentries, but checking
 	 * on every vmentry is costly so we just use an hrtimer.
 	 */
-	if (delta_tsc >> (cpu_preemption_timer_multi + 32))
+	if ((delta_tsc >> cpu_preemption_timer_multi) >= preemption_timer_limit)
 		return -ERANGE;
 
 	vmx->hv_deadline_tsc = tscl + delta_tsc;
@@ -8585,6 +8586,26 @@ static void __init vmx_setup_me_spte_mask(void)
 	kvm_mmu_set_me_spte_mask(0, me_mask);
 }
 
+/*
+ * Workaround for a widespread Intel erratum (e.g. EMR158) where the
+ * VMX-preemption timer may expire earlier than expected when programmed
+ * with large values. The workaround is to cap the timer value to strictly
+ * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
+ */
+static __init u64 calc_preemption_timer_limit(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (cpuid_eax(0) < 0x15)
+		return 1ULL << 32;
+
+	cpuid(0x15, &eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		return 1ULL << 32;
+
+	return min_t(u64, 1ULL << 32, div_u64((u64)ebx << 25, eax));
+}
+
 __init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -8726,6 +8747,8 @@ __init int vmx_hardware_setup(void)
 		cpu_preemption_timer_multi =
 			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
+		preemption_timer_limit = calc_preemption_timer_limit();
+
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
 		use_timer_freq >>= cpu_preemption_timer_multi;
-- 
2.55.0.229.g6434b31f56-goog

