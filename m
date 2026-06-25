Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB3376BE2
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430733; cv=none; b=HFLRQV0NDFJg3ivYJs6od0kcAyevuxeWEFenTCtoLi7yOs5UPpXi2rpKmoNk7MvSnDP7NWxV1u+YJunzVgWdokeh2nQ1Cy2cYyhAaIuF4NkFrvRYezhYXTRpEq193s3Wgt35i9w2pm7ohCHj/7hS/JVANxQvxaAMlUfYlpHd1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430733; c=relaxed/simple;
	bh=+/WPvGlaBx56RAc8Xl4hP75Il8JKjdwNWAjOiwChNu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxhzKp0+PgbTE49KdT6XPXChdrduw4NzZkyk75Ea2Xnd8d04DVSWDMHTGI6fUw2GfZA3eLlzczgWryXo6D9Mpw1Ayigt7FGqFUsDpwjlRwuH+dLZIkSPKcH76cRNT4XMI+ZlyY+DhdjSPuCqKxwKT4XH76RPgt9ldpmVxLBspck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KeoM07Lk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeoM07Lk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97955899so230216a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430731; x=1783035531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BY2HGTc9PvGpCwg9X+koWgqeC6W29ZDMqcZqEmAlEOE=;
        b=KeoM07LkRmZLKvgywrhFwKzTeKiBV470Xeqj2iwUZcByt2tOQfy39I3GOOxLtA5kNu
         ZV6AKckUp4bWix7n5+3za15OApOvyM82Binzu9H7f5ajLztEfJoMvOxxcINmPEhhlwkE
         C/KttCoVhxh2QZB/u27wr5ujAVf6fVHmU7rau4mJhsRl3EZKACmRGCCCU9Fz7IzXhDWb
         FV0gKag+Kt6L4MyBT+FdHS7+F6Sm/AGI7xocUwmHgWWCrdbNRehJWbTVrNSk1KIeAbUE
         TZZZ4lWUlQZMkHhi7ZfoCcIQlgpjOXPdiSx1TsvfutUyWV29oauB5EfrZGn8Kv28FbuP
         YvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430731; x=1783035531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY2HGTc9PvGpCwg9X+koWgqeC6W29ZDMqcZqEmAlEOE=;
        b=tZIZckqoI6fAmZ/Wip6dWr3Lnf5QYhpNIWR0xJ0BAOUKgN16kRn4uixcobVmml5w9w
         Ls/xWTj5RsC4qxk9oDbYTD2Yaiqd20kNjBcEpKa7cjgWDPizHT3jZfVFWh+kojEE6AYf
         rv+pPfZfmW+eoxu7CUSlcI7d02rNE/Qlo7MOm8FsHrN3p8a2JYki2rFTDMlybM+0D6pq
         DdX3BbqvwsdttOLtNPO4CMkmL0JahONvY8GrUtwEeCUOSuAew65zDk8lnxSDkKD6axQO
         dhRd6FHsRgk6rfCM68rjthAm2UfqY4cE05LmoVziuqLXBclv5cF7XjnRcXm4pL00BdiG
         hBNg==
X-Gm-Message-State: AOJu0YxuMC98YnPnLF9z/hSXTL+YBbl4VuzDkm94Rr8GupGc3lZXuIy7
	ZTBDBK6RVDDrxaEdHBCWAOewHrEwU0M7RsV7BfPvC9EULwzp77MGhQNrU9RjjOkGsmNI3mI6RA3
	xV80WmQ==
X-Received: from pjbos5.prod.google.com ([2002:a17:90b:1cc5:b0:37d:8237:cb36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e4e:b0:37c:83ec:1641
 with SMTP id 98e67ed59e1d1-37df9f2882fmr4044221a91.5.1782430731215; Thu, 25
 Jun 2026 16:38:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 16:38:46 -0700
In-Reply-To: <20260625233846.3407303-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625233846.3407303-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625233846.3407303-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops
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

