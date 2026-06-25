Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89232B11C
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430740; cv=none; b=mfS59jNNS3EMpWN3gze4J8hQSZGVzVMqlyjIA5laLtOJvAGKlxuLLkv71YueXPSB2Zn1Ee3jw4y6vncjhE/oRrC0ePSsxTUW5t8IVK6y35jv/r8qAiEKdOBYVlzP6zBr2RhD7LzqeYoH4UoVuTjylmisfBqw7l/XRww/WvQPVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430740; c=relaxed/simple;
	bh=gxFaXpMYs3Na8Iy+bEtvVBarMVa9qjWQBwpZld0cy44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O7QA70jKtFYwbcEs5Nymk8ZEUe0q7LrFOWUFqmYGAY+GvGxmgXYuSDkpB7jz3/LIm7ROG2ZGDDpwzGDNYdpd9htZjUhfsBcnHvtYEGLqy0nTs0fLTaoZB06AtHrqjEOiF7AX7LqmAXGL0RfiX6RPCB+I1+5cwMavlqTbSUEgq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qULn95yA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qULn95yA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so324078b3a.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430730; x=1783035530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uQSJL+YqiMeKlRRHW2ULzQBuGlW79ffbpzPhQwofY7U=;
        b=qULn95yAkKQhopVvmyx2uq8kEhTNA9KBZ90lkP3ovtsz9htlHlsCkzKq1+qPxYlZ9e
         7yVJvlJxDegGxaQBILz0ME/46E7dW3h40FnVLyE4qhqkWKmn+rmln4Qn70fdUVF9iaSh
         Ao4kyj1ixKJsXOgxi/AOIrjMpDxfgd7EowYlK4ofyIG8mR4yzyyZcOEvxuUSgF9XWscF
         o+iNG1+BOWXJeaQRg2G54d2o+UU8H+SAkIHc07vGHApM2cUoqz5fhea6gT7jA2XXnuyX
         tecVEP52VVXN1NvLLx75CbbTlYDrKHcSrp8J1LVXSuO/G969IizIGRp5Dq8CbYEZP8rI
         yXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430730; x=1783035530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQSJL+YqiMeKlRRHW2ULzQBuGlW79ffbpzPhQwofY7U=;
        b=Yz0dANWlkH1kKmcvhFOLT7IyNbu0g/NWO9+lGJTqZlHmJcuSQ+aqXcFjN0gaWbtL4P
         Ju3KeeqLGBp1Ucy6y/3j9R11ZUd60iJgTbaeDQRRmzyDn8OoG1qFkQm9fegyrkvJmjn6
         V1+m/VTQJMFp120+IueVZpbO/EoO14fgkgqNzX1JRYTOZRogaKH/FPkAltaeWPWeOI+U
         fK195Or7Hnu/aHEc3MMTfnH6dvfAR7L8AZa4wnIVxrFRdxllrjLz6T+mIKJVr5RYqtxE
         FJ7P8mvKBP9Lsyqx8HnnGT9TAqj5AiuVHeLapj0xcq+kLxyMC1T2nD4AWSXYNtHVd9Ai
         K5Mw==
X-Gm-Message-State: AOJu0YxnObtztXAnUy8VxxnkqtnRC8WOaAre92KC6WtwFF/D6c0Zw8eV
	MZyokCYl9HEanDb9PvaYMSddCDtKqyypdJMkr1ETbXGObXsjMiWwvCNlzl+36BbqjYQFSH6Qm8O
	W/vSPwA==
X-Received: from pfbgs5.prod.google.com ([2002:a05:6a00:4d85:b0:845:4368:93b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2344:b0:82f:3a1e:5618
 with SMTP id d2e1a72fcca58-845b3ab5607mr5621458b3a.22.1782430730078; Thu, 25
 Jun 2026 16:38:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 16:38:45 -0700
In-Reply-To: <20260625233846.3407303-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625233846.3407303-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625233846.3407303-3-seanjc@google.com>
Subject: [PATCH 2/3] KVM: x86: Add static calls for nested virtualization ops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use static calls to invoke nested virtualization ops, as many of the calls
are in relatively hot paths when L2 is active, e.g. checking for events,
and because there's no reason not use static calls these days.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-nested-ops.h | 36 +++++++++++++++
 arch/x86/include/asm/kvm_host.h           |  8 ++++
 arch/x86/kvm/hyperv.c                     |  4 +-
 arch/x86/kvm/mmu.h                        |  5 +--
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/x86.c                        | 53 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 7 files changed, 85 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h

diff --git a/arch/x86/include/asm/kvm-x86-nested-ops.h b/arch/x86/include/asm/kvm-x86-nested-ops.h
new file mode 100644
index 000000000000..19528548bb64
--- /dev/null
+++ b/arch/x86/include/asm/kvm-x86-nested-ops.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(KVM_X86_NESTED_OP) || \
+    !defined(KVM_X86_NESTED_OP_OPTIONAL) || \
+    !defined(KVM_X86_NESTED_OP_OPTIONAL_RET0)
+#error Missing one or more KVM_X86_NESTED_OP #defines
+#else
+/*
+ * KVM_X86_NESTED_OP() and KVM_X86_NESTED_OP_OPTIONAL() are used to help
+ * generate both DECLARE/DEFINE_STATIC_CALL() invocations and
+ * "static_call_update()" calls.
+ *
+ * KVM_X86_NESTED_OP_OPTIONAL() can be used for those functions that can have
+ * a NULL definition.  KVM_X86_NESTED_OP_OPTIONAL_RET0() can be used likewise
+ * to make a definition optional, but in this case the default will
+ * be __static_call_return0.
+ */
+KVM_X86_NESTED_OP(leave_nested)
+KVM_X86_NESTED_OP(is_exception_vmexit)
+KVM_X86_NESTED_OP(check_events)
+KVM_X86_NESTED_OP_OPTIONAL_RET0(has_events)
+KVM_X86_NESTED_OP(triple_fault)
+KVM_X86_NESTED_OP(get_state)
+KVM_X86_NESTED_OP(set_state)
+KVM_X86_NESTED_OP(get_nested_state_pages)
+KVM_X86_NESTED_OP_OPTIONAL_RET0(write_log_dirty)
+KVM_X86_NESTED_OP(translate_nested_gpa)
+#ifdef CONFIG_KVM_HYPERV
+KVM_X86_NESTED_OP_OPTIONAL(enable_evmcs)
+KVM_X86_NESTED_OP_OPTIONAL(get_evmcs_version)
+KVM_X86_NESTED_OP(hv_inject_synthetic_vmexit_post_tlb_flush)
+#endif
+#endif
+
+#undef KVM_X86_NESTED_OP
+#undef KVM_X86_NESTED_OP_OPTIONAL
+#undef KVM_X86_NESTED_OP_OPTIONAL_RET0
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 36de689a579c..25b1e3c1b344 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1963,6 +1963,14 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
+#define kvm_nested_call(func) static_call(kvm_x86_nested_##func)
+
+#define KVM_X86_NESTED_OP(func) \
+	DECLARE_STATIC_CALL(kvm_x86_nested_##func, *(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index fe951c196706..8b396ccd847e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2406,7 +2406,7 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
-		kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
+		kvm_nested_call(hv_inject_synthetic_vmexit_post_tlb_flush)(vcpu);
 
 	return ret;
 }
@@ -2788,7 +2788,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
 	if (kvm_x86_ops.nested_ops->enabled)
-		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
+		evmcs_ver = kvm_nested_call(get_evmcs_version)(vcpu);
 
 	if (cpuid->nent < nent)
 		return -E2BIG;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c9f628b97dae..fa05ca2c8549 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -385,9 +385,8 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 {
 	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.ngpa_walk)
 		return gpa;
-	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
-							    exception,
-							    pte_access);
+	return kvm_nested_call(translate_nested_gpa)(vcpu, gpa, access,
+						     exception, pte_access);
 }
 
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e73fc09ec4db..4ee7b03e762d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -235,7 +235,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 				!(pte & PT_GUEST_DIRTY_MASK)) {
 			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
 #if PTTYPE == PTTYPE_EPT
-			if (kvm_x86_ops.nested_ops->write_log_dirty(vcpu, addr))
+			if (kvm_nested_call(write_log_dirty)(vcpu, addr))
 				return -EINVAL;
 #endif
 			pte |= PT_GUEST_DIRTY_MASK;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cd9a5ff47f6f..792afd15582b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -165,6 +165,13 @@ EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
+#define KVM_X86_NESTED_OP(func)							\
+	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
+				*(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
@@ -454,7 +461,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	 * wants to intercept the exception.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, nr, error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
 					   has_payload, payload);
 		return;
@@ -2347,7 +2354,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops.nested_ops->enabled ?
-			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
+			kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
@@ -3370,7 +3377,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			if (!kvm_x86_ops.nested_ops->enabled ||
 			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
-			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
+			r = kvm_nested_call(enable_evmcs)(vcpu, &vmcs_version);
 			if (!r) {
 				user_ptr = (void __user *)(uintptr_t)cap->args[0];
 				if (copy_to_user(user_ptr, &vmcs_version,
@@ -3742,8 +3749,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (get_user(user_data_size, &user_kvm_nested_state->size))
 			break;
 
-		r = kvm_x86_ops.nested_ops->get_state(vcpu, user_kvm_nested_state,
-						     user_data_size);
+		r = kvm_nested_call(get_state)(vcpu, user_kvm_nested_state, user_data_size);
 		if (r < 0)
 			break;
 
@@ -3787,7 +3793,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_x86_ops.nested_ops->set_state(vcpu, user_kvm_nested_state, &kvm_state);
+		r = kvm_nested_call(set_state)(vcpu, user_kvm_nested_state, &kvm_state);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
@@ -6905,6 +6911,20 @@ static void kvm_setup_efer_caps(void)
 		kvm_enable_efer_bits(EFER_AUTOIBRS);
 }
 
+static void kvm_nested_ops_update(const struct kvm_x86_nested_ops *nested_ops)
+{
+#define __KVM_X86_NESTED_OP(func) \
+	static_call_update(kvm_x86_nested_##func, nested_ops->func);
+#define KVM_X86_NESTED_OP(func) \
+	WARN_ON(!nested_ops->func); __KVM_X86_NESTED_OP(func)
+#define KVM_X86_NESTED_OP_OPTIONAL __KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0(func) \
+	static_call_update(kvm_x86_nested_##func, (void *)nested_ops->func ? : \
+						  (void *)__static_call_return0);
+#include <asm/kvm-x86-nested-ops.h>
+#undef __KVM_X86_NESTED_OP
+}
+
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
@@ -6920,6 +6940,8 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
+	kvm_nested_ops_update(kvm_x86_ops.nested_ops);
+
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
 
@@ -7456,11 +7478,11 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
-		kvm_x86_ops.nested_ops->triple_fault(vcpu);
+		kvm_nested_call(triple_fault)(vcpu);
 		return 1;
 	}
 
-	return kvm_x86_ops.nested_ops->check_events(vcpu);
+	return kvm_nested_call(check_events)(vcpu);
 }
 
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
@@ -7698,9 +7720,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_x86_call(enable_irq_window)(vcpu);
 	}
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, true))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, true))
 		*req_immediate_exit = true;
 
 	/*
@@ -8023,7 +8043,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
@@ -8075,7 +8095,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			if (is_guest_mode(vcpu))
-				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
@@ -8493,9 +8513,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, false))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, false))
 		return true;
 
 	if (kvm_xen_has_pending_events(vcpu))
@@ -8898,8 +8916,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	 * a pending VM-Exit if L1 wants to intercept the exception.
 	 */
 	if (vcpu->arch.exception_from_userspace && is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, ex->vector,
-							ex->error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, ex->vector, ex->error_code)) {
 		kvm_queue_exception_vmexit(vcpu, ex->vector,
 					   ex->has_error_code, ex->error_code,
 					   ex->has_payload, ex->payload);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 8ece468087a8..b510b631f0c5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -93,7 +93,7 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 /* Forcibly leave the nested mode in cases like a vCPU reset */
 static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
 {
-	kvm_x86_ops.nested_ops->leave_nested(vcpu);
+	kvm_nested_call(leave_nested)(vcpu);
 }
 
 /*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

