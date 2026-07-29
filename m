Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568274A2E27
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332530; cv=none; b=VGBF8hLeV2W0RtCDcOGKrMjTieX2OWmFX2kRfxJ31mdzjDcF0p+cyokMKGKxkOxh/aA5T+4j8JjIQorfEf3OAEb3exs08/FrgQVyIKFCwv/o2B/4ZUgCGxdt/sMlPR+dBTWsWqLqx5/04e/xewN2k4dyEP6Sjwx8UJfHRrUlB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332530; c=relaxed/simple;
	bh=W7j5bbeacqKqR4y38EBWlLQkxybSdtqm2pMlHDAkEM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddDNwkHVvmTk1w1DK0PCxUkHfXcxD++ine2A/lYBkEHo+LO8xjSzyCWPQ5j3LUEbSpNsGKj3R1pzY2zLi0x1zqCNZ1nLZYVZB95e7jw6Dx5ZzPbphiRnEN9R8Q3pA9VGmW+BMs2Zy5GbZsiaXltG1c1g4vsh0vR6iDP/hg6yXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsJFLIY1; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsJFLIY1"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8485d853b08so2206239b3a.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332528; x=1785937328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/DgZi0stIOKkjUQJoJAJmG4kTJ5Xok0D1TO/UI1qeW0=;
        b=YsJFLIY1hopE7U4vKNObBx7mDQxxN5McrCTnFdMB+1p7n7L+aHdhN7kVBfRPfEPGh1
         Xmt5a8SIkCeNL+ZPDJEBYQLaZH8go1yH1yFwaIeIz24Gvf2Xt9OyCBUxY8Bs7iJ6oRKF
         SECRIr9T5dCmWf+AGDpq89bGWxw+cIfPBRYj7kprejtUv7IYzY//+exIbovA6GF3PlaQ
         EKx1grB5X/04NyPF3hbzysZHbqxIt++jXyjpe7uxrIUuXyOvfO8HeXpoT56cQTgMhEvH
         oZyMAYyHdmPAobzQTcyO59nLAKjPb3KpDN3oSOauFRGj8VgFlFhbVC6RPqfR/mxCwZed
         9QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332528; x=1785937328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/DgZi0stIOKkjUQJoJAJmG4kTJ5Xok0D1TO/UI1qeW0=;
        b=pPPfxFAaZNgsaUJxMbUv0kh6AqR/Fhj+4id1HrU83cMcwLmO3ppE4C8NhdmugmpjTJ
         6DqA5eYCIaYyH+YUWGbmy/lw98L5tFKRDfu1IH04zzpj4jkGZo4Q7XFwV5VrInJIRBzd
         QGqxY+JT/8SQ+S5TxDLLUXD2mO+CpzJOvyuhJXhZQ3l7mPDR4DBlDqsUvGvKGxMd/i/t
         WyqNH6QqRzsv1p6XjUwsQcboZ5yfPU70SMahwb7dbuw8Jo7xu7tMFV+Ui/8B+x5cG9mC
         NlfkKKc3dQ/fT46LcO+zsUaFlwNprE76JEYCT0FIbJF8kGbcbUQcYadmLk5SZMnDqY8v
         asyw==
X-Gm-Message-State: AOJu0YzkE28B27t++TRvyHsZAtt9a+QdiL0bGjXjsTAARddMDgjvkE4f
	ERJvhNQ0dCQixHdVxwWNh0bHNQMho8N/jNHEYWxMiQujQY/vz+wK/uBOZJoRyZwzkCPXhfgK6qF
	0BJy5SA==
X-Received: from pfbay4.prod.google.com ([2002:a05:6a00:3004:b0:84c:2c68:6485])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:399a:b0:848:67ca:c03
 with SMTP id d2e1a72fcca58-84e932ccc6dmr7335211b3a.58.1785332527467; Wed, 29
 Jul 2026 06:42:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 29 Jul 2026 06:42:03 -0700
In-Reply-To: <20260729134203.1377606-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729134203.1377606-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260729134203.1377606-3-seanjc@google.com>
Subject: [PATCH v6 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Due to a widespread Intel erratum (e.g. EMR158), programming the
VMX-preemption timer with certain large values may cause the timer to
expire earlier than expected.  The recommended workaround is to cap the
VMX-preemption timer value to strictly less than:

   2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0].

Calculate the maximum "safe" preemption timer value during hardware setup
based on CPUID 15H when available, and use the adjusted max value in all
locations where KVM currently hardcodes the max architectural value,
including in the subtle case where KVM soft-disables the timer.

Don't apply the workaround when running as a VM, because absent explicit
enumeration to state the bug is present (or not), it's L0's responsibility
to faithfully emulate/virtualize the VMX preemption timer.

WARN if the above logic would result in a max value of zero and fall back
to the maximum architectural value, as the expectation is that real
hardware will never provide problematic EAX/EBX values (which is another
reason to ignore the erratum when running as a VM; there's less chance of
a false positive on the WARN due to L0 providing an unanticipated ratio).

Reported-by: Sean Christopherson <seanjc@google.com>
Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/
Suggested-by: Chao Gao <chao.gao@intel.com>
Assisted-by: Gemini:Gemini-Next
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
[sean: track inclusive max instead of exclusive limit, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a07faa066ef0..dae41842a9ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -153,6 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 #ifdef CONFIG_X86_64
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
+static u64 __ro_after_init preemption_timer_max_value;
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #else
 #define enable_preemption_timer false
@@ -8306,6 +8307,33 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
+/*
+ * Workaround for a widespread Intel erratum (e.g. EMR158) where the
+ * VMX-preemption timer may expire earlier than expected when programmed
+ * with large values. The workaround is to cap the timer value to strictly
+ * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
+ */
+static __init u64 calc_preemption_timer_max_value(void)
+{
+	const u64 ARCHITECTURAL_MAX_VALUE = UINT_MAX;
+	u32 eax, ebx, ecx, edx;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return ARCHITECTURAL_MAX_VALUE;
+
+	if (cpuid_eax(0) < 0x15)
+		return ARCHITECTURAL_MAX_VALUE;
+
+	cpuid(0x15, &eax, &ebx, &ecx, &edx);
+	if (!eax || !ebx)
+		return ARCHITECTURAL_MAX_VALUE;
+
+	if (WARN_ON_ONCE(!(((u64)ebx << 25) / eax)))
+		return ARCHITECTURAL_MAX_VALUE;
+
+	return (((u64)ebx << 25) / eax) - 1;
+}
+
 static __init void vmx_setup_preemption_timer(void)
 {
 	if (!cpu_has_vmx_preemption_timer())
@@ -8317,6 +8345,8 @@ static __init void vmx_setup_preemption_timer(void)
 		cpu_preemption_timer_multi =
 			vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
+		preemption_timer_max_value = calc_preemption_timer_max_value();
+
 		if (tsc_khz)
 			use_timer_freq = (u64)tsc_khz * 1000;
 		use_timer_freq >>= cpu_preemption_timer_multi;
@@ -8326,7 +8356,7 @@ static __init void vmx_setup_preemption_timer(void)
 		 * value.  Don't use the timer if it might cause spurious exits
 		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
 		 */
-		if (use_timer_freq > 0xffffffffu / 10)
+		if (use_timer_freq > preemption_timer_max_value / 10)
 			enable_preemption_timer = false;
 	}
 
@@ -8363,12 +8393,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
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
+	if ((delta_tsc >> cpu_preemption_timer_multi) > preemption_timer_max_value)
 		return -ERANGE;
 
 	vmx->hv_deadline_tsc = tscl + delta_tsc;
@@ -8402,7 +8432,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
 	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_max_value);
 		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
 	}
 }
-- 
2.55.0.487.gaf234c4eb3-goog

