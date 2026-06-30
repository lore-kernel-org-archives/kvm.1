Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A23E8C74
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851312; cv=none; b=CQRUCFkaUfLiIapvjHXlacdI/kt5DUuN5mlTCpqOi+87io2mvQGH9MYXM3T0XNExhdjoI1SKkM0zkyIk0Is4n0j5Ul4SBJRODruqRM60yJehxoE7udnWPUXR9nhoEUn25Abho1r+tSenQ5zgltjoPqE7Lh6Ag6MAIqdthh5Xngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851312; c=relaxed/simple;
	bh=ciwaSvQ5xizqNFNiN2c0vAGUqTyYnP7mrMvuCa/IIbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvqiGelqhkQjxBQdjZP43cg/5zGqv0gzaJgsDPjWdFBrAU4AzS2g9VN33glX8Cy112j6MJMXrxQvrigfUlN4JgeG2YzGoJYtUHagXj6nKqRSBIGb14ZALe75fuojVXP/xgziznrvkQlVBES4S1O5OfqlGNiLAArxH0q0YpYG7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIJh7nXG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIJh7nXG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c9e9cb6a44so16899575ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782851311; x=1783456111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7btJ5oXC+SKYPWns8D9GNOc6pxFK2ZTtdnpFzC23924=;
        b=wIJh7nXGRbAPqiAtcFRIKU0BjD1Ict4pAsOLGpDjtyNmX8r/QvvtGk7Nd0J4l0dyI1
         obJLbOLN4wSgJu7gyDQm9PCzLhPLG3hhIkDo/U9dNk3Ex7bWTkZYPOY4rn2ZzRAEv4HB
         ZwBYXSEsMihAjMxwjovyetXNLjZznaQj/Oqwml4DoOzG0LJfpGe5UJpLboOYSN67H1yr
         a5ydC7qMhktl6WJmGd6bVt5C27Pj3HqXGNVdIBfJEsGNs1lj99JHWK0y0yPhDLgNQgbs
         BpEx0eU11/SrJ5vGeGd5BYfBNEVGI9NrjCS27Sq2bdrBtMgXIqAnX4HMggXrbkU5U465
         gcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851311; x=1783456111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7btJ5oXC+SKYPWns8D9GNOc6pxFK2ZTtdnpFzC23924=;
        b=Nb8FEO4RZ7vu24RIzV66pJWfg79VlSR7rQ+8qXJXKE6LthvOZ90czHuu5DiWVlAsSQ
         jIci07P1zDhyMRNEejgiGDsH2T7pzUA8824S9Ofk+GfgCXHIRfnyWimprw48w0XS37gD
         oLCeVn3sDuGzTOprbd/TQeaPlP+M/1rUveJfI2XIogvLXRwvg3ddxFFVmIDoZu0wBCMF
         Nj0UXVU3er4OeMADP6mT/lymoi3EH+249FeJyvVl0LDFKSLbVespR/RW5J88ePiCGsN+
         CG9280owZrygdRMtAO41yn/b0BiA/EKAEoO4bEgWJNvrJMYjGBgCtdtHrnD2iGuxnVSQ
         1YHw==
X-Gm-Message-State: AOJu0YzDDeQVe9cXHXP1lTEcGxFMakpptTwK2YF2dw56fxsS8VQwcNFv
	rGKbH4Fz/FKtQ3U4Vk4n4wzkg5l5c/sUw1aVRbwXEEYFY6E3sps/1V/0Mq1XahojN3WF2nG4oNZ
	ZxzT/5A==
X-Received: from plbe19.prod.google.com ([2002:a17:902:f113:b0:2c6:be2c:e9e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94c:b0:2c0:cb0e:ac3a
 with SMTP id d9443c01a7336-2ca2e71832cmr44449675ad.23.1782851310438; Tue, 30
 Jun 2026 13:28:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 13:28:26 -0700
In-Reply-To: <20260630202828.440724-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630202828.440724-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630202828.440724-2-seanjc@google.com>
Subject: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
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
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 12 +++++++-----
 5 files changed, 13 insertions(+), 6 deletions(-)

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
index 1ee0d23f8949..7184622992d0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2787,7 +2787,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
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

