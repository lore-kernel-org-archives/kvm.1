Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69047B408
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851318; cv=none; b=MERj3ieDUp7S0PKz0K/MNA9y8B0IxCRd5AW+XHct1VBES5z2zwZkhDJ9aQ68Dl64mMXdZI6+bPTiDaenTWRNmiyWk0pI3vFOUg/QwhHPJA/GIQVWwy6b7gIagh4d/S1ugQYZStTHm5mMhJWtNfzLgWcCUcPG/fCV98z0M0R7SHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851318; c=relaxed/simple;
	bh=+/WPvGlaBx56RAc8Xl4hP75Il8JKjdwNWAjOiwChNu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hi9a+norQexuE+Iu9qJSjLCVXo8Se35LUHjmQ6msNZd3DJWLveMAAo/qHRU7etWMoVjOl+dUf8oq+xmnQGd6BOwXUfLo/Z+XT84Y+nXgpJKjs1so+Y+ejqW5yhfLJR3kdD+Z6DnebJEOEnNMgMB8e5y4F2Y/00JqXgkZ7xlUI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lr62dmDf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lr62dmDf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847ad67cc51so576487b3a.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782851313; x=1783456113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BY2HGTc9PvGpCwg9X+koWgqeC6W29ZDMqcZqEmAlEOE=;
        b=lr62dmDfzk32VyurkS0OQYSdOjdXybkPAkhmICGYomntdoc0URWD3WKdLFqYhUiQ5s
         6+BSJhmFLg4cqeLoT2yk2xfzwE4Hv1hS8+fjPr7BUNq4sgFJc91EhEyVckhzdQ7mJmpK
         zCf/Z7uvLPd1YGTVYKeOI3vbL+2GsLt056V0iQjwPQlGv+bfhYy0g4v+qPPM9dvJ/XdL
         IY86J2pFByJ9mMdGkU71j6tYCY81nHUHuqWUTUzkZ3VciNZRcXsYnK45cYt0IqydYyx0
         c5wcaj24cIw32WS7VzoWzlK3TYxpEPcsDCv/torZUDZAQw+kFidHRzO3A18MC7Iiy4wK
         hnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851313; x=1783456113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY2HGTc9PvGpCwg9X+koWgqeC6W29ZDMqcZqEmAlEOE=;
        b=ok1/9D7NLCrLOEasRVAVU+n4HMkXk8cLfJCSVYRrNN7M5MdLaplEr6TvDU+RM2+9MH
         WNWhtItbXYRrmakHtPcAP2ZHvTdJmJg+sKwmAS23iFnLGIR2s0+CTImy9z+9DFdXyTnH
         e534OEJAD57M2s2wD9MViAXM2okxpPP69G4Ezk7xdOWQfN59vZJlhqRXG6j3WOymnoz6
         QJi4EU5MJXJWn+AXX6Z1Qc6gBT6Kaj7OVbo+EFLZofufBU65Vmg+09If3+zk+7ITV3a+
         rSJnmQ0DK7Krq9Iu3D6sCgJKLX+9/snqLBY8dFZYPLhM5gkgNjgbf31J5H3xnFwPSLy1
         pL7A==
X-Gm-Message-State: AOJu0YzA05rxrdZYX3qzM8E5UF0h7ZlSndFpOH/aykkGxIZ5W/Y4Rb3G
	KodL8XoZhvSqZoI7dZVaYvpyMGExGmv2fY9yuHrj4oVjDNEAUz6n1JDct5r8wqOKmHhksuEHSLD
	jrcgfOg==
X-Received: from pfnd10.prod.google.com ([2002:aa7:814a:0:b0:846:7503:7352])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:300d:b0:847:712d:19ac
 with SMTP id d2e1a72fcca58-847add67022mr1872727b3a.8.1782851312774; Tue, 30
 Jun 2026 13:28:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 13:28:28 -0700
In-Reply-To: <20260630202828.440724-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630202828.440724-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630202828.440724-4-seanjc@google.com>
Subject: [PATCH v2 3/3] KVM: x86: Move nested_ops out of kvm_x86_ops, to
 global kvm_nested_ops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rework KVM's handling of per-vendor nested ops to copy the vendor's ops
into a global structure owned by common x86, i.e. treat nested ops just
like x86 and PMU ops.  In addition to providing consistency across all ops
implementations, making a copy of the ops prevents changes to the vendor's
ops after KVM is initialized, i.e. guards against goofs where KVM *thinks*
it is updating nested ops, but which won't take effect now that KVM uses
static calls to invoke vendor hooks.

Ignoring the side effects of tagging {svm,vmx}_nested_ops as __initdata,
no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/svm/nested.c       |  2 +-
 arch/x86/kvm/svm/svm.c          |  3 +--
 arch/x86/kvm/vmx/main.c         |  3 +--
 arch/x86/kvm/vmx/nested.c       |  2 +-
 arch/x86/kvm/x86.c              | 25 +++++++++++++------------
 7 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 25b1e3c1b344..7e07a9c259d0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1842,8 +1842,6 @@ struct kvm_x86_ops {
 
 	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu);
 
-	const struct kvm_x86_nested_ops *nested_ops;
-
 	void (*vcpu_blocking)(struct kvm_vcpu *vcpu);
 	void (*vcpu_unblocking)(struct kvm_vcpu *vcpu);
 
@@ -1939,6 +1937,7 @@ struct kvm_x86_init_ops {
 
 	struct kvm_x86_ops *runtime_ops;
 	struct kvm_pmu_ops *pmu_ops;
+	struct kvm_x86_nested_ops *nested_ops;
 };
 
 struct kvm_arch_async_pf {
@@ -1954,6 +1953,7 @@ extern bool __read_mostly enable_apicv;
 extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
+extern struct kvm_x86_nested_ops kvm_nested_ops __read_mostly;
 
 #define kvm_x86_call(func) static_call(kvm_x86_##func)
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8b396ccd847e..b010dca37b9d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2787,7 +2787,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->enabled)
+	if (kvm_nested_ops.enabled)
 		evmcs_ver = kvm_nested_call(get_evmcs_version)(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ba985a02208a..5f6d9971a3f2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2162,7 +2162,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
-struct kvm_x86_nested_ops svm_nested_ops = {
+struct kvm_x86_nested_ops svm_nested_ops __initdata = {
 	.leave_nested = svm_leave_nested,
 	.translate_nested_gpa = svm_translate_nested_gpa,
 	.is_exception_vmexit = nested_svm_is_exception_vmexit,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 163440fca59f..d3807f4abb49 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5426,8 +5426,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
 
-	.nested_ops = &svm_nested_ops,
-
 	.deliver_interrupt = svm_deliver_interrupt,
 	.pi_update_irte = avic_pi_update_irte,
 	.setup_mce = svm_setup_mce,
@@ -5773,6 +5771,7 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 
 	.runtime_ops = &svm_x86_ops,
 	.pmu_ops = &amd_pmu_ops,
+	.nested_ops = &svm_nested_ops,
 };
 
 static void __svm_exit(void)
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 83d9921277ea..04f986e3d439 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -995,8 +995,6 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.update_cpu_dirty_logging = vt_op(update_cpu_dirty_logging),
 
-	.nested_ops = &vmx_nested_ops,
-
 	.pi_update_irte = vmx_pi_update_irte,
 	.pi_start_bypass = vmx_pi_start_bypass,
 
@@ -1038,6 +1036,7 @@ struct kvm_x86_init_ops vt_init_ops __initdata = {
 
 	.runtime_ops = &vt_x86_ops,
 	.pmu_ops = &intel_pmu_ops,
+	.nested_ops = &vmx_nested_ops,
 };
 
 static void __exit vt_exit(void)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0635e92471c8..cbb209d8a8f0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7484,7 +7484,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
-struct kvm_x86_nested_ops vmx_nested_ops = {
+struct kvm_x86_nested_ops vmx_nested_ops __initdata = {
 	.leave_nested = vmx_leave_nested,
 	.translate_nested_gpa = vmx_translate_nested_gpa,
 	.is_exception_vmexit = nested_vmx_is_exception_vmexit,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 792afd15582b..5ba4aac37640 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -154,6 +154,7 @@ static int sync_regs(struct kvm_vcpu *vcpu);
 static DEFINE_MUTEX(vendor_module_lock);
 
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
+struct kvm_x86_nested_ops kvm_nested_ops __read_mostly;
 
 #define KVM_X86_OP(func)					     \
 	DEFINE_STATIC_CALL_NULL(kvm_x86_##func,			     \
@@ -2353,16 +2354,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->enabled ?
-			kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
+		r = kvm_nested_ops.enabled ? kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enabled &&
-		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_nested_ops.enabled && kvm_nested_ops.enable_evmcs != NULL;
 		break;
 #endif
 	case KVM_CAP_SMALLER_MAXPHYADDR:
@@ -3374,8 +3373,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			uint16_t vmcs_version;
 			void __user *user_ptr;
 
-			if (!kvm_x86_ops.nested_ops->enabled ||
-			    !kvm_x86_ops.nested_ops->enable_evmcs)
+			if (!kvm_nested_ops.enabled ||
+			    !kvm_nested_ops.enable_evmcs)
 				return -ENOTTY;
 			r = kvm_nested_call(enable_evmcs)(vcpu, &vmcs_version);
 			if (!r) {
@@ -3741,7 +3740,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->enabled)
+		if (!kvm_nested_ops.enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -3770,7 +3769,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->enabled)
+		if (!kvm_nested_ops.enabled)
 			break;
 
 		r = -EFAULT;
@@ -6913,13 +6912,15 @@ static void kvm_setup_efer_caps(void)
 
 static void kvm_nested_ops_update(const struct kvm_x86_nested_ops *nested_ops)
 {
+	memcpy(&kvm_nested_ops, nested_ops, sizeof(kvm_nested_ops));
+
 #define __KVM_X86_NESTED_OP(func) \
-	static_call_update(kvm_x86_nested_##func, nested_ops->func);
+	static_call_update(kvm_x86_nested_##func, kvm_nested_ops.func);
 #define KVM_X86_NESTED_OP(func) \
-	WARN_ON(!nested_ops->func); __KVM_X86_NESTED_OP(func)
+	WARN_ON(!kvm_nested_ops.func); __KVM_X86_NESTED_OP(func)
 #define KVM_X86_NESTED_OP_OPTIONAL __KVM_X86_NESTED_OP
 #define KVM_X86_NESTED_OP_OPTIONAL_RET0(func) \
-	static_call_update(kvm_x86_nested_##func, (void *)nested_ops->func ? : \
+	static_call_update(kvm_x86_nested_##func, (void *)kvm_nested_ops.func ? : \
 						  (void *)__static_call_return0);
 #include <asm/kvm-x86-nested-ops.h>
 #undef __KVM_X86_NESTED_OP
@@ -6940,7 +6941,7 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
-	kvm_nested_ops_update(kvm_x86_ops.nested_ops);
+	kvm_nested_ops_update(ops->nested_ops);
 
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

