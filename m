Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491C4570E9
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391233; cv=none; b=USros7J2Zsqyzj4G+JM7AKfxJonBczovBVQovKREyH9SxqlR6K1SV6iS1Z23Dh1ipQXOF1PqHCqFeNeJ/3USMUdGgscg8TJ0cH4ps/wgXponuSs+fFlo/koj99mcCx/7BEyESRgtUBh8J/UXiIpyTNISrLrXBwegvHtErmiu6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391233; c=relaxed/simple;
	bh=rO1VhpjY+sD0s6cY1RGW2FsZ7eLK+0PYMsJ+6bCCG6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t50k8DrYSQOpOiLRBL/QnOQ1ZXbDICubzdakATRfh565MCsO3VfEc+PebpBcwa3V8D9Hfd2u8OOO7CrI7oL/h9LB8BTQ6fYGcI6foXjxH8eENlHyad+rwu5bqm+i27xH1ynC7lz4sHHbi1tRAcV6jBr2Qv6cKdvK72U5vMFvZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFBUfnWD; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFBUfnWD"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85321e37104so2263469b3a.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788391231; x=1788996031; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CXxJWNy5cOYGfFxugmTGZyVHmkAbs3asDYkKP0d8VCs=;
        b=lFBUfnWDw+jYkq8wz+LBGbW19unRcjA/lxUWlnZ9GLi8U4+oQYuq/Ukb0oPz4gVQSK
         ORrX4dj/zOvLHwRUblNtAg38qCCMEs47xlb6CnrrgtTeRFfXLUu2AY4xmzd5Bd8Jb2sr
         ugTwPEFZe5n5N1jMj8LAgdygYB04ldqIZ8Ll48moSgOJdywExyfrl/5h8qdiv1kAta9l
         OxNrLo+pYFN7CN0gK/Km1b/8vEOgDXgaoP9WMbIam162nyR2UtLwPI0QY/WnEnbOBbRV
         Z7Qy6szzfK+xh4K92hohZMejvyBz1ZFySTkx4ORvUkVhRKxLV+JyKUFkFvAd8Yiu7tRV
         D87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788391231; x=1788996031;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CXxJWNy5cOYGfFxugmTGZyVHmkAbs3asDYkKP0d8VCs=;
        b=N2RZ1f3ApW5W6k8kDIuXUDHq1TtTpAlZY/wA8+CRrxhpvTpFfjMS7TxIcTsJ8FnFYL
         5X09+JN1GzvwajtjTsdETqv9iHEccmQQ2iOQlKEKc3hL6b3yUSa97K06oOdTlFZf4HmN
         u2RK6Zf3FJPVVhBS0PentJp0RGWmeGPJ6HSj+C5m1Z9u8AudVymoY8rwh9n8sDyMNgCS
         s1FA1MBqOPFS+QeCwNJ5UHdzUL5xoWQkhbjsa/4VZbAlDYjrI4FWmqSLBt6RZkbDBI/I
         rV34COaBxffgx5yn52VqjK9z/rQZxdGoVb6gkE7tovOuYMg4iw7ZNBFrbTCas5Ybgmj/
         j9mw==
X-Gm-Message-State: AFuF++ktyJ1NNHqwrdM/DevPFiwJgJs4mLxe9+zomtJPLBnBooikDVhZ
	uvyztPBxZxmW8S6ONJwa7IdWYF5wn4gyT0YEHrEN+luUpN+PupoZN+PZFWDVm47mRmkG9F4KN3g
	Cv2G/Vw==
X-Received: from pfblc11.prod.google.com ([2002:a05:6a00:4f4b:b0:84e:2062:2edb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148e:b0:847:893f:2d0c
 with SMTP id d2e1a72fcca58-85ed1d0414dmr11974433b3a.5.1788391230832; Wed, 02
 Sep 2026 16:20:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:20:24 -0700
In-Reply-To: <20260902232028.2767071-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902232028.2767071-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902232028.2767071-2-seanjc@google.com>
Subject: [PATCH v2 1/5] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Reject KVM_SET_NESTED_STATE if the incoming L1 host state has what is
effectively an impossible EFER combination of LMA=1 but LME=0, i.e. if the
state says long mode is active but not enabled.  Unlike VMX, SVM doesn't
have an explicit consistent check for the illegal combination; presumably
hardware simply ignores EFER.LMA if EFER.LME=0.

Unfortunately, KVM doesn't ignore EFER.LMA in this case and consumes the
illegal state when constructing the shadow MMU for L2.  E.g. if userspace
also clears CR4.PAE, then kvm_calc_cpu_role() will compute a role with 4 or
5 levels of paging, but shadow_mmu_init_context() will wire up the MMU to
use the paging32 template, which maxes out its levels at 2.

Note, the "real badness" is effectively the same as what happened with the
nVMX bug fixed by commit 112e66017bff ("KVM: nVMX: add missing consistency
checks for CR0 and CR4").  Unfortunately, the sanity check added by commit
72e2fb24a0b0 ("KVM: x86/mmu: Bug the VM if a vCPU ends up in long mode
without PAE enabled") doesn't work for this case, since L2 state is active
at the time of the page fault, but it's L1 that has the bad state.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..49fb10ad1f9f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2028,6 +2028,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
 	    !nested_vmcb_check_save(vcpu, &save_cached, false))
 		goto out_free;
 
-- 
2.55.0.970.g62bdec98f9-goog

