Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746544CAFC
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518376; cv=none; b=jInqiH2UBAePcDD3R89NTTFTrQfI49hSUrHP0HxqJz6L82hYdrD2md+n2VOyXVRY5FFbAb6WJgUuzNPNotPPzOPAEmLaqnu+lYraPIqTnqcJgm1KtioIhldLD5gC03w8aRgrZgoHYD3eohObOAG6LUuzmUufL4vMVVZeLfwd07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518376; c=relaxed/simple;
	bh=uYFUivxPYUYbmgO3jVkPEYX/2SJgZBAfO4E2lQNbJ5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P83miY1+hVRpVnB8YpGFlIAozrQMAFSrcw4xBYe92y6/GxD2UY5dySErxuvFbH/liUW9zD4/5CHznsBQ0+zJ850vXMwY43bal5LjhSf/16zA5hksQANuSIGH0ainqg2QUtRrAhUnW87UNg7mrEWLZ77TgrWgrizOtrJ4mdD8H6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5DHJfvg; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5DHJfvg"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cce14a21faso15229235ad.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785518370; x=1786123170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xWrk4GpBsMY+nAsfOPZnb8P50AG697NWSPek8RL0lYI=;
        b=l5DHJfvgpQ0djOy9WNoY1qDFSNYbfXNf6SFFdZVIYo+t5mX19bjWzoMgRU3PigmVQd
         xxwmA13LNiI2THYEdJKiRlsp+IDPjdOxYAbN4GQHcbwkbUxgbh/AJmU/UhsQ/JUYWgFT
         1ljnyo78G6HlLXKX4AcRw7CJLkg9/vWROxzaEZe+gmbrxh7cZMUvHLyJum88CCBzXKab
         CZA7GS4C8HdWwuhVUg3dytI4TeZOWadz3WfP9McwUJX6WwXBMZhZSAs+jLX3fReFOLRO
         yNsXcBnTgHdnCHM/j3AwXI6oHS0gKmEj89/XFwygKxHuZ6/jVO46P264rdSg2xpsYZ5A
         AbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518370; x=1786123170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWrk4GpBsMY+nAsfOPZnb8P50AG697NWSPek8RL0lYI=;
        b=piU8ydQqOPEOckIM/b3vctJktF0MRyUa6i0jEb8uRNAH1ZhXSu/JQqwRzOJ1X+WLCn
         KKsem8w4F+LuJX81BLttGPdQdv/w/4f9TGWDUXLeOAdu6P4yQXUKGKnlrIYgl3qmCQqd
         HYwjCpYY3ZtzbYSsvlRzuoFwXAdSQm4BcoHTeaiTFJLswnaqDlMrgAcCcaLCggE2YRIK
         Fk1/q0PJY4UXH1ev1diRDxTWqpA0Y+CSHPNlU3jKss/KEqgYoXFBW+G1KBLkQu4lflkO
         ZogP4XAqAUjPq+eTvHcogLouasTe0sNoWDVVEQDR/BTp9HpE+h2q4kfE8BxIWEN36NNV
         k8Pw==
X-Gm-Message-State: AOJu0Yw24amcsFGXG0ziR2+icq9MMjV/UznRhCl8fZs5MS2Zf+59BGMg
	67VJ5n8RYRvFMcfuE9mFA9E/g519iTsQs2lhPgraJCStv+O/gOpy093+3PREqhPrD4zw29hQIaf
	aLC3bSA==
X-Received: from plbml4.prod.google.com ([2002:a17:903:34c4:b0:2ca:ddb3:59fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0c:b0:2cf:41ba:96c2
 with SMTP id d9443c01a7336-2d05366b5dfmr3813555ad.12.1785518370302; Fri, 31
 Jul 2026 10:19:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:19:26 -0700
In-Reply-To: <20260731171926.2629627-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731171926.2629627-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731171926.2629627-3-seanjc@google.com>
Subject: [PATCH v7 2/2] KVM: VMX: Cap VMX preemption timer to work around
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
index a07faa066ef0..6432d1329357 100644
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
+	return min((((u64)ebx << 25) / eax) - 1, ARCHITECTURAL_MAX_VALUE);
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
2.55.0.508.g3f0d502094-goog

