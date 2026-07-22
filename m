Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F7311C36
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730630; cv=none; b=MFGrguhyO9RvP70T4R4tliGMKXbJIuQcJ+kLDuGVIANmQKC7bnUi+xQya/Zyq4xi3gWYCLNDpsNNh/j60lxXJvQHarbpEqJXmDkOrMiPNsFotoZqHOsYak+0j5shsWE2SBD2f7/b1eN4DISbb1CBkCTND3VOr6euD5OP0F5ASoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730630; c=relaxed/simple;
	bh=JWRJd60AQQbjcgrMl+fFUY8DSPqlgDcQKyHTlvM84WM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t6kzW4wdNJKSgmxumB/mihEcWkMbLUwlOJGh6MlkiP5jbuvORqdTGbi83mxOQjZ1YsIqi44XzLDjN46wlFxvcbUT9RaWa+1GUu/KeiDOM0QgVGOaCyu3dFjBEvThxNy2Sp92SSqxP3OsBXUhpFUAPtAfQSTTVHTxqbPSGNK5k9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pokOhyNS; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pokOhyNS"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so10922286b3a.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784730629; x=1785335429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3+xMvoLTytXA+BYL89pFMN+Ws4RLZyCA0Rg/ymRWsM=;
        b=pokOhyNSJxVg+uAhiotNdAYo8af9AkRr2HOFujJnEW93MutN+tGqmh49P6U+9OKTEi
         SSko50cPj+VAcL+zdnGfbVC8HdMSBoQGa3jhrgc5ps8dd2eF0xi1PS/I8f6COD4xeb8k
         7wkpn86bVyXgyzcvxm39TkgXA9j+0B7lFR/G8wuz81iwNZ45XQ7AzgOT0wkE8hKISzFK
         oWG5Tepo0CYHZ7YBUYJ4ki5wGtA0DXKMokFIOECqQEKUYYKIAgbf/H722pr6Ne6f+ZB7
         Oq9quQGVFNup7l4LEL7iV77f0E3RCcbRfudrXTIESyPDKRSi+gcEYdQwV8Fr2vgBX5xw
         GiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730629; x=1785335429;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3+xMvoLTytXA+BYL89pFMN+Ws4RLZyCA0Rg/ymRWsM=;
        b=JMoCtnn2BeozvYP1jD7ZMmcNQoArF0styugpHDr/XETSnUSOSjWt9Ii16O6HViSC/h
         1Ycz268JFBbFYnUZB6oNaf8II1waXIn9C44SUSnpPxA5qIzpQaeuuYtKDYwXT4pe7M+7
         +p97rguy/999CZksOtR4gMq2M2/X8TYmOXOsG3W19nl071X19fiNodklt4U+Mx1Jds02
         2byXO8kb+D/P+NuqIhe+XPq7PELIhrPANsDG/znoR8CpmCaQWF49gKb0YyNSaXoVnifs
         JCZAx94tLOAIrOUSwPWWwzXRETvWiJeg8nnQrSUEbBMbKvtAJRHzwEpNBpkzY1ZFhLJt
         qUTw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9rxhzFvwgAKAJq1g41jjERTiJMqW/CaNMdGjq0yVuiKDeeZWEWUhjcDCXFncQP2e1oAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaX7t2Eam7W17W4B/fRKVs0HeVTlWdGhPrdWBEwA75LPX2um8C
	rznFkIoG0jBgRID34Tte7PzV6WhZdvz/IkdmQUQZ7mf8811zFJicHerhMOnA+Yv1w7G5z9fHPM8
	TD2QjlQZgDUZ33w==
X-Received: from pfbih8.prod.google.com ([2002:a05:6a00:8c08:b0:84b:50b5:d431])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:400f:b0:848:6ba2:4139 with SMTP id d2e1a72fcca58-84c29487c9amr23809675b3a.36.1784730628447;
 Wed, 22 Jul 2026 07:30:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 07:30:24 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722143024.3938899-1-jmattson@google.com>
Subject: [PATCH v4] KVM: VMX: Cap VMX preemption timer to work around Intel erratum
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

Use preemption_timer_limit - 1 instead of 0xffffffff when soft-disabling
the timer and when checking the timer frequency limit in hardware setup.

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
Suggested-by: Chao Gao <chao.gao@intel.com>
Assisted-by: Gemini:Gemini-Next
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
v4: Disable preemption timer if preemption_timer_limit is 0 [Sashiko]

v3: https://lore.kernel.org/all/20260722040311.3369898-1-jmattson@google.com/

v2: https://lore.kernel.org/all/20260720231639.1592848-1-jmattson@google.com/

v1: https://lore.kernel.org/all/20260720205230.1457146-1-jmattson@google.com/

 arch/x86/kvm/vmx/vmx.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..61017f759d61 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -151,6 +151,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __ro_after_init preemption_timer_limit;
 #ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #endif
@@ -7412,7 +7413,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_limit - 1);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
 	}
 }
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
@@ -8735,7 +8758,8 @@ __init int vmx_hardware_setup(void)
 		 * value.  Don't use the timer if it might cause spurious exits
 		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
 		 */
-		if (use_timer_freq > 0xffffffffu / 10)
+		if (!preemption_timer_limit ||
+		    use_timer_freq > (preemption_timer_limit - 1) / 10)
 			enable_preemption_timer = false;
 	}
 
-- 
2.55.0.229.g6434b31f56-goog

