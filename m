Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CB1DF75B
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621638; cv=none; b=buyOhKtFt8nja2rwyK1n/9yZpPMo3zzMVrBVJ7/APDDHkWSpXROGWX7Maxn8LLstqMif9EyxZJZWgeOITJBijh5knSiJMPJpPoa5/t37nKqXMwN18Yre1FoEL0DQSzcUXKcHm7ZBt5SiPkozkNbLdvdle0uAbAOmrVhEaaKUsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621638; c=relaxed/simple;
	bh=nf5LaBv/q1yBV2WRernYjv6lnDcXTDPc+W5b1NXMv3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PpogvvGCzRCirHvAh42QQd5cmUdui0Pb7RmHs88VXrnZyEZOZ00hNMvkxXGktqEmW5x1YL7Qdr35STtLJClZQ52qYql8snzx6cgHgsMJ0jbGBvBqj7vVAv+mNG2lRUB38iv9wKyvEqphvfwDaASJLLsS03iFy7jBZ42vlWBDqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5ldaXJs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5ldaXJs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8291230235so3115697a12.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778621636; x=1779226436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUyDM/wX4+q24OYtylEh1N7LuXBizzR7BVDWaiwz87k=;
        b=p5ldaXJs4vL3fyNZrTY2GJF/mE4FtZRREghulMCnkFExaBvp6WOoeaafi3Ay4jWDpJ
         z3nY/ZAd9uFcbjiCcvsxOMSyD/Hk2G9Ac/5J9KWl2O0wvxdT38Bt7MSnDJmkCEmTsvdE
         Ijsy1q9GcTksyC1ByZf1f0hFuytBwEUN6Mst/vlFTwZOmdnS2F50Z9wv0ycuhUqa24ig
         EpG7ToEyXt2C7lwEdI9gCTfPta4GARRWfv+3CE3ID6X0iB+mMKRCi2iL/VpvOKcVnAiW
         NJwLEsLRkG+hCDqh5FO1Lv7XHToeicSh5we3rLTQ7dZ0Oqv2wcj/hzqbrqougnEoXBgV
         3t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621636; x=1779226436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUyDM/wX4+q24OYtylEh1N7LuXBizzR7BVDWaiwz87k=;
        b=TAwePhlECXDOD8bf1zWr3xs2wQpMHm9ZH5SbjDJyHq0Hl7LX53sz834B6yWyxrYRYu
         KTvCOorlkr6+U5tYom2xUv6PW52xTW8kFSJBC3I6xoMnTr7MN97CaarK/+pdItjb4k21
         nHhamkyXIpKXAKWZMy+sI4aFub0VA6y0BeSqwwnFkAb+GCKvn2l1MVvzuM/FTOAwcR47
         yXJ7EqVZ85QJ/1h0CM81kgzdEE9SSNOJNwZUO5YOMONOA/senRNeD4SzjnGj94ubyxIV
         tKtwvpRnXfioks+d485MDLLPDs6Hdr0CVfiUaJqDc0o6zLCbzVoCuaPuUiey30JKrTOt
         LLSA==
X-Forwarded-Encrypted: i=1; AFNElJ8ERapKtAXP+7wTsobiYqfJF4uniuwn72imhPYTiCUzT4i+PbKU/VjPvJJcrsesyIyhVGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Qy9baD+7sE0qEjSN0uYZhlPqHDInveiISsk+W/+28N4uBNwn
	HdZOnQpDvoOV4Qrle8i0mXlOh+SA5IUR4oFx9KjBaVdJMlVW5ooYNQLJXgN42tf4zZNw1toqmT5
	YS0B6Wg==
X-Received: from pfbem37.prod.google.com ([2002:a05:6a00:3765:b0:82f:b53f:40d7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3286:b0:3a2:c685:f9b0
 with SMTP id adf61e73a8af0-3af83e43fa0mr313442637.49.1778621636348; Tue, 12
 May 2026 14:33:56 -0700 (PDT)
Date: Tue, 12 May 2026 14:33:55 -0700
In-Reply-To: <20260508170714.489136-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508170714.489136-1-jmattson@google.com> <20260508170714.489136-3-jmattson@google.com>
Message-ID: <agOcw9ZIXALKrs_a@google.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: Virtualize AMD CPUID faulting
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Jim Mattson wrote:
>  static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8c6cc0406d6..127d031d3310 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3593,13 +3593,15 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
>  static int em_cpuid(struct x86_emulate_ctxt *ctxt)
>  {
>  	u32 eax, ebx, ecx, edx;
> -	u64 msr = 0;
> +	u64 msr[2] = {};
>  
> -	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
> -	if (!ctxt->ops->is_smm(ctxt) &&
> -	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
> -	    ctxt->ops->cpl(ctxt))
> -		return emulate_gp(ctxt, 0);
> +	if (!ctxt->ops->is_smm(ctxt) && ctxt->ops->cpl(ctxt)) {
> +		ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr[0]);
> +		ctxt->ops->get_msr(ctxt, MSR_K7_HWCR, &msr[1]);
> +		if ((msr[0] & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
> +		    (msr[1] & BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)))

Hrm, this is all rather ugly (definitely not your fault).  What do you think about
adding x86_emulate_ops.cpuid_fault_enabled() to at least get deduplicate the MSR
lookups?

Gah, we should do more than that.  I was going to say, "If it weren't for
kvm_emulate_cpuid() using kvm_require_cpl(), we could roll *all* of the checks
into cpuid_fault_enabled()".  But that's a rather stupid reason to duplicate the
code, because kvm_emulate_cpuid() is literally the only user of kvm_require_cpl().

Pulling smm.h into cpuid.h isn't great, but the code is much nicer, especially
the next patch to add AMD CPUID faulting.

Compile tested only...

---
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 May 2026 14:20:47 -0700
Subject: [PATCH 1/3] KVM: x86: Consolidate CPUID fault handling for emulator
 and interception logic

Extract the logic for emulating CPUID faulting (where CPUID #GPs at CPL>0
outside of SMM) into a dedicated helper and use the helper for both the
full emulator and the intercepted-CPUID paths.

Opportunistically drop kvm_require_cpl(), as kvm_require_cpl() was the one
and only user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/cpuid.c            |  5 +++--
 arch/x86/kvm/cpuid.h            |  8 ++++++++
 arch/x86/kvm/emulate.c          |  6 +-----
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/x86.c              | 18 ++++++------------
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..a9005c61619b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2285,7 +2285,6 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault);
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
 static inline int __kvm_irq_line_state(unsigned long *irq_state,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..1c95d1fa3ead 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2161,9 +2161,10 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
-	    !kvm_require_cpl(vcpu, 0))
+	if (!kvm_is_cpuid_allowed(vcpu)) {
+		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
 		return 1;
+	}
 
 	eax = kvm_rax_read(vcpu);
 	ecx = kvm_rcx_read(vcpu);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8b64d863e19c..95d09ccbf951 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -7,6 +7,8 @@
 #include <asm/processor.h>
 #include <uapi/asm/kvm_para.h>
 
+#include "smm.h"
+
 extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 extern bool kvm_is_configuring_cpu_caps __read_mostly;
 
@@ -187,6 +189,12 @@ static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 }
 
+static inline bool kvm_is_cpuid_allowed(struct kvm_vcpu *vcpu)
+{
+	return !cpuid_fault_enabled(vcpu) || is_smm(vcpu) ||
+	       !kvm_x86_call(get_cpl)(vcpu);
+}
+
 static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8c6cc0406d6..3ba09093b5ab 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3593,12 +3593,8 @@ static int em_sti(struct x86_emulate_ctxt *ctxt)
 static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ebx, ecx, edx;
-	u64 msr = 0;
 
-	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
-	if (!ctxt->ops->is_smm(ctxt) &&
-	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) &&
-	    ctxt->ops->cpl(ctxt))
+	if (!ctxt->ops->is_cpuid_allowed(ctxt))
 		return emulate_gp(ctxt, 0);
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..45d4a03b202e 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -225,6 +225,7 @@ struct x86_emulate_ops {
 			 struct x86_instruction_info *info,
 			 enum x86_intercept_stage stage);
 
+	bool (*is_cpuid_allowed)(struct x86_emulate_ctxt *ctxt);
 	bool (*get_cpuid)(struct x86_emulate_ctxt *ctxt, u32 *eax, u32 *ebx,
 			  u32 *ecx, u32 *edx, bool exact_only);
 	bool (*guest_has_movbe)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7d5b66287593..c60773349f35 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1021,18 +1021,6 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_queue_exception_e);
 
-/*
- * Checks if cpl <= required_cpl; if true, return true.  Otherwise queue
- * a #GP and return false.
- */
-bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl)
-{
-	if (kvm_x86_call(get_cpl)(vcpu) <= required_cpl)
-		return true;
-	kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
-	return false;
-}
-
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 {
 	if ((dr != 4 && dr != 5) || !kvm_is_cr4_bit_set(vcpu, X86_CR4_DE))
@@ -8819,6 +8807,11 @@ static int emulator_intercept(struct x86_emulate_ctxt *ctxt,
 					     &ctxt->exception);
 }
 
+static bool emulator_is_cpuid_allowed(struct x86_emulate_ctxt *ctxt)
+{
+	return kvm_is_cpuid_allowed(emul_to_vcpu(ctxt));
+}
+
 static bool emulator_get_cpuid(struct x86_emulate_ctxt *ctxt,
 			      u32 *eax, u32 *ebx, u32 *ecx, u32 *edx,
 			      bool exact_only)
@@ -8955,6 +8948,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.wbinvd              = emulator_wbinvd,
 	.fix_hypercall       = emulator_fix_hypercall,
 	.intercept           = emulator_intercept,
+	.is_cpuid_allowed    = emulator_is_cpuid_allowed,
 	.get_cpuid           = emulator_get_cpuid,
 	.guest_has_movbe     = emulator_guest_has_movbe,
 	.guest_has_fxsr      = emulator_guest_has_fxsr,

base-commit: 41a2602f2947b91e237cd1ce85afcd162274470a
--
