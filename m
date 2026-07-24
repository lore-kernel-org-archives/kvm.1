Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61908484228
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936963; cv=none; b=tey9F4OAhH16CsF8RnV8me54D654x9s2BDsSIaklmm8wI8DVL82NzE217BKd7Mu7BvPhZncwuuvBQJq67GCOobaWlbgm+sngZ71ei/lqU/+whGhd7OD2BZ3agBp4kLu5IKK/vn1vCZOMu1Wk+iB+mhAEddTLBDsfcARCSm4YOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936963; c=relaxed/simple;
	bh=bHvBedjZ6Cqkr3QabtYPtLUKypmvcPwYnrzucQpTKRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rwn6aZZrsiuuMjb5lY0Vw/qsAtq66k50EG5sMpb2W9XKje2mEQsOrfSYZIfb0AS7R3coAmOYeMR+iVhJ5KaE5U1fHPANOuNA0EyH+Py4VI7JWiL0doqLvGnTF6/+GMruKuIKN9wW6wmtcNgtwdTzdi7pm+UgiwyCnkakSYWqtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FX0PM88x; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FX0PM88x"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1474109a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784936959; x=1785541759; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRDWG5LJfTsM4rsEH3kaNCcnI3Fztx/5Il0r4lt6YMo=;
        b=FX0PM88xvtcpXTz8uRn/YZn1dZRQgWt0e5hL2t6ztPEEXuHhWzkcq6/u8+4mA/nEfX
         CMkwuHK57ZrBpdn6a6V2aLFUtLTrIGZ/kmTlsoJL8e//HptrVAOqh7xJEInzSjrqKL0D
         5d4ru+ZdijRvSnJr1QL2E2G2+8LqTNnL0GWXao3LglNXSFfHNbgqmHT943K+m7QxO8Li
         lUssNPfgyfP2J6xsXcIbuvI1J80t+luhUskQpJmS+t3d3VlLg+DcJdGG9mOwInObSssJ
         U2QbnX5P2yL5R5d0JOjXz2gOOymabif1UUJHAVdmy3CWYGJQtlWsRXhviWvI7CX9dgml
         bzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936959; x=1785541759;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRDWG5LJfTsM4rsEH3kaNCcnI3Fztx/5Il0r4lt6YMo=;
        b=OzncimQrhPyPwaoIHAgvH5WPVJHNjQkbVaF2ta2UNU63/+ViRHcPiQbJsTEs+eiLol
         XTRqeDc9Q9SAaP6fLZbUmifF6ga9h4h0u6jy/iRenmOY3+qkVHRUQeEX1ILAHVIDj/5k
         VrqdiD1NObiAMDUOHm/Wf87bhCBvM0PY7+meqbVubSl+QclxENw1sBmGOyk5BZcBE0LH
         OxjQD9W64x1i0Dbu+97qoBgFbHETqqeXYTKqO2BZXCbtHA2Vi3QlUJYAT9UcEC3HY2zs
         81DNotVKXkczqm5iwapcwHIuJ68AMUChGqFHiD5XQ+KPNyFys7MYIqfWPEu11MhigE6L
         veWg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8cU6Qays/gq/pksgpOFrEY5aqausDt7uaywCv5eXjxdIlc9II9yoObrcR+0EkDxP4Mps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNF4xedxsaDZ5NnpI4UT8IFk3N8Irt+gD3V4EUW6BigpDkxRNq
	ocpyk3LB/Qqip4sabr18rDx8IhBScO2TqForbCWri7eoPnwKkpLbzATe0xp+QseVFkRhpnSpeXp
	ehdmZD1AOfbpelg==
X-Received: from pfwy11.prod.google.com ([2002:a05:6a00:1c8b:b0:848:4460:aed3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f1a:b0:847:982e:cca0 with SMTP id d2e1a72fcca58-84e594439c8mr308378b3a.19.1784936959292;
 Fri, 24 Jul 2026 16:49:19 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:49:14 -0700
In-Reply-To: <20260724234914.987987-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724234914.987987-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724234914.987987-3-jmattson@google.com>
Subject: [PATCH v5 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
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
 arch/x86/kvm/vmx/vmx.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a07faa066ef0..ebe83a641473 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -153,6 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 #ifdef CONFIG_X86_64
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __ro_after_init preemption_timer_limit;
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #else
 #define enable_preemption_timer false
@@ -8306,6 +8307,26 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
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
+	return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
+}
+
 static __init void vmx_setup_preemption_timer(void)
 {
 	if (!cpu_has_vmx_preemption_timer())
@@ -8317,6 +8338,8 @@ static __init void vmx_setup_preemption_timer(void)
 		cpu_preemption_timer_multi =
 			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
+		preemption_timer_limit = calc_preemption_timer_limit();
+
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
 		use_timer_freq >>= cpu_preemption_timer_multi;
@@ -8326,7 +8349,8 @@ static __init void vmx_setup_preemption_timer(void)
 		 * value.  Don't use the timer if it might cause spurious exits
 		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
 		 */
-		if (use_timer_freq > 0xffffffffu / 10)
+		if (!preemption_timer_limit ||
+		    use_timer_freq > (preemption_timer_limit - 1) / 10)
 			enable_preemption_timer = false;
 	}
 
@@ -8363,12 +8387,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
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
@@ -8402,7 +8426,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_limit - 1);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
 	}
 }
-- 
2.55.0.229.g6434b31f56-goog

