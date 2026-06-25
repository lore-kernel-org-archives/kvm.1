Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06145345CC9
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430731; cv=none; b=HOnY76s3BxxHOwPdJpxWRlArDtTrALcT8O48b9k23T0siX73+UEiYMJ39bq79KnSdtuAyy5TAiTgbLvRf1b13FeL0gELYa4ETzNJevrPBZWwDSHyh4HH62IRd5vNNQ6JPBQdppFL7pSgeqiGcu+PK5w8XBRn2PfLmbTeK9db3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430731; c=relaxed/simple;
	bh=FJK1hvciw80QOY6xpCGROLsoY9Vu9CvbZULGZu2jKNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MA5usydEpiZQJ2sHj313NeGGNCv6zKoo+tHgXZ1I1RryRBcGiHpJg3SvOGnc1XnOa5P0voGRTOpJ/06tqOY+CPeoK65HS7/etJltnHpFUS4tzs3hXEe84aySyUSs7Wy0WYohmPpUy5vWpZNKehHTwnSWLf16WG8cCwhbRX+QS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVIhWFnI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVIhWFnI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso227260a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430729; x=1783035529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tZsf/kVM3uzl+IfL0/RYiugpT8VJMpZAex4og4Whr3I=;
        b=lVIhWFnIrhKMJBtY8+BDqNXl+WrDXwl/FVIs5Bx/2Et6gWy+h8qR29lL/gsAh8+8NV
         eZ3DF2dBeXtUJg8QRfkS+WJPJtRiXKtzuQDdVeumtmqB3NgqXchNDlilemb6XLNtQceE
         hTL6Ik2iAlUudazeHMmreRjgxpEj7KB6UYYzv2O/RC4uSI654mZqIyhyPBzp5BVwk70i
         J2wFmCovWykBv5OxDRZKs/DBUvjpBG+xTYd/xQir/vuGnCmeR+XfzuzWmoOpQrbJpZHo
         64UY4F7eZdbPKw/30HjFP1a25Zq15ibsuGcuAJ90Naw3/qKlFOGg36s+oBA+AbSBZ8jU
         CiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430729; x=1783035529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZsf/kVM3uzl+IfL0/RYiugpT8VJMpZAex4og4Whr3I=;
        b=sB9GOvkE27qPjHR+LwYQRg/Nw+0U2SYi2MOVEgIT0ci9seb4fDMku1gq0boWYmNfyU
         GpHKunvgIyMTaS6sBCliBmgK3WMnOTeK/HiQG4+KEoL3mnOl1JaIKhwX2zjjwd8JCwNb
         2XGzvOLQzXiAEWJ+zmfKJ8Bi3eS8GiIoB6jdpKV/3T0R9b6Eyhctg08I7cd7+jKC9HcV
         IBgtRCmuMB66ooHv1p1B+sgZDR5Kei2SMgZfhhy2BPvnbM78L56Qm/ekNRR5mZntMf1o
         12d2skJHD1saprg50taBP1ymEdaxtb1VZDWzv1XyFNnIqBcbzRNLQFiof6B5D/9FsPd9
         wuPQ==
X-Gm-Message-State: AOJu0Yz+VbDOrt51Ji5gsfPOu2yFqsg5xzXvmc8Z6NS+thLn0NNlXPkP
	e/ereezEqWt3pBOaOvj044edmrGOY9zzYymEsxkaqQLWqZ86rrpsCXvTCPWR1eg50Xn5EZnomwQ
	TclMm6w==
X-Received: from pjvd15.prod.google.com ([2002:a17:90a:d98f:b0:36b:dc35:1b43])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c50:b0:36d:bbe0:de7c
 with SMTP id 98e67ed59e1d1-37dfa2363femr3936293a91.12.1782430728827; Thu, 25
 Jun 2026 16:38:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 16:38:44 -0700
In-Reply-To: <20260625233846.3407303-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625233846.3407303-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625233846.3407303-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a flag to explicitly track if nested virtualization is enabled, and use
it enumerate that various nested CAPs are unsupported, and to reject
enablement of said CAPs.  When the nested ops hooks were moved to their
own structure, KVM's NULL-by-default behavior was deliberately dropped,
with the changelog asserting that all was well.  That wasn't quite true;
there is no danger to KVM, but now KVM is over-reporting support for
KVM_CAP_NESTED_STATE and KVM_CAP_HYPERV_ENLIGHTENED_VMCS.

Fixes: 33b22172452f ("KVM: x86: move nested-related kvm_x86_ops to a separate struct")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 12 +++++++-----
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..36de689a579c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1906,6 +1906,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
 				    u32 error_code);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1ee0d23f8949..fe951c196706 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2787,7 +2787,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..163440fca59f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5646,6 +5646,7 @@ static __init int svm_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3681d565f177..ef9e1bc39edb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8786,6 +8786,7 @@ __init int vmx_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..cd9a5ff47f6f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2346,7 +2346,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
@@ -2354,7 +2354,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 #endif
 	case KVM_CAP_SMALLER_MAXPHYADDR:
@@ -3366,7 +3367,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			uint16_t vmcs_version;
 			void __user *user_ptr;
 
-			if (!kvm_x86_ops.nested_ops->enable_evmcs)
+			if (!kvm_x86_ops.nested_ops->enabled ||
+			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
 			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 			if (!r) {
@@ -3732,7 +3734,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -3762,7 +3764,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

