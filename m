Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA63BB118
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426994; cv=none; b=bfls01mEGHb1gYQvzNKtIQy94VawNYRiiNJXlFXxAVkM4dxtQ52/u3onqWWiOhb0//Ui9diT9TqamhVD0eoktH2HVYsMLUAWNzj6813TtAN1xuXDiMFPAvg5kHrCdc3J7yQGWWxGuiylCDyko3wn+zg+StUCw2URwe5IJIl7sGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426994; c=relaxed/simple;
	bh=sEqo9ipyNHXqGElckHhyPshYyntkhkEipYpT06/s6LI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emmmN6eLK1EajdqI0IIJHUgTFeo5aWGl4AWgPRpsc8T4n8DAyvR+Rq6An3Z+FyRehse2Xk+hRqN/NFAnmsyqOjfEMCm/EdhQ2VhlV6P4exTlQ3lb2F8uQKo/TTYIyWN7YP2UUGg0FUVMYfxjnX6FXpZBIJPtQ911dVRSqxPGJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgg6Bsnm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgg6Bsnm"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e09f9c4dbso222237a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426992; x=1783031792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m5JKVap7NXaXDR3kbNPE0TD3ZfAZJnRDS516RKmwD6c=;
        b=hgg6BsnmMJa9ilwfeYSXQsn6q1ujHsjm4Di7/JFHkonp+GT0CdGg16XIDkiVTFQZXV
         vZaKL5PM7G9ll1JR3kcS9ddMdsqdfBl09yZXaDWdWqeifWSzj1QHG5VP+NTSeRTJEpzL
         ygCUoQ/8ejLlFYQK7zv5ch4OvYRH4ZaDl4IDwJ9y6KPOhU6ZR5NPp+bcWjKl503SRFdX
         HmVNauC2EccYt7/xonRoFJN9zOhgPP+tGuF9KChlhL6pFe5gWno5yFQ5zEj8ugbgunqS
         6iofiRMsFvojCR3k7vzHjKT4Op35L8xd/V5we9C2hsrtOsg2gCj5xoPwcght4Q24UC0s
         vT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426992; x=1783031792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5JKVap7NXaXDR3kbNPE0TD3ZfAZJnRDS516RKmwD6c=;
        b=fnITZxwoQ0WVxWO+BCj9GOVFm35Cp0/Vd/js1crDGUsGziEYrJwiUoiKiC6IUc4sy6
         rUX8IH3v7FWtnKWZ5cQZgS9AZ3Tfmzy6dxwmyZLbsPJcWIHWO0Aqsi+F4+HJOits4OoC
         szxyuz8O/g6Sg23ULvM2h9OMW5b3pm8p87sE/+kemBxm7eU6NClu71886aOHw4kymzFS
         qdeJo6xfKwjUHQdasadj3xhmCqYCzLvBkDBs2jVaIKNLdmdw1kdUq/gzyL4kGHDd+Vc4
         8UY6Evj8tK7DenO+eFiV4/MFXIcPMAkjLJQd1HesnYcHpGpKtVDX+AwZd4/duFW/3vIJ
         m8+w==
X-Gm-Message-State: AOJu0YzAH6EY23krEJvNRQ17Cxn+sH1zIehDU3UA7D6z7JlcWW9tzq5q
	UliZAJeselyHtQN8z3Y5n3NrlJDW1dY/DALJR+9jVH7a+0QVVo4UvFLke1XzlntZjQ4+JBlicbC
	Re75g7A==
X-Received: from pgkj14.prod.google.com ([2002:a63:e74e:0:b0:c8a:b173:5516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8c:b0:368:1064:62f7
 with SMTP id 98e67ed59e1d1-37dfa1a5204mr4008930a91.6.1782426991615; Thu, 25
 Jun 2026 15:36:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:19 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-7-seanjc@google.com>
Subject: [PATCH v3 06/10] KVM: Initialize a vCPU's index to '-1' while it's
 being created
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Invalidate a vCPU's index immediately after allocating storage for the vCPU
so that KVM doesn't incorrectly treat a vCPU that is the process of being
created as being vCPU0.  This will also allow detecting that a vCPU is in
the process of being created and thus otherwise unreachable, which is
useful for avoiding false positives in lockdep assertions on vcpu->mutex.

Unwind the index back to -1 if insert the vCPU into the array fails so that
kvm_arch_vcpu_destroy() sees the vCPU as unreachable, i.e. so that teardown
logic doesn't hit false positive lockdep assertions.  Opportunistically add
a comment to call out that the "real" index needs to be set before making
the vCPU visible to other tasks.

Note, kvm_wait_for_vcpu_online() naturally does the right thing thanks to
vcpu->vcpu_idx and kvm->online_vcpus being signed values.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..98da4c889ffc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4188,6 +4188,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto vcpu_decrement;
 	}
 
+	vcpu->vcpu_idx = -1;
+
 	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!page) {
@@ -4216,11 +4218,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
 		goto unlock_vcpu_destroy;
 	}
 
+	/*
+	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
+	 * Unwind the index back to -1 on failure so that KVM can use the index
+	 * to detect that the vCPU is unreachable, e.g. for lockdep asserts.
+	 */
 	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
 	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
 	WARN_ON_ONCE(r == -EBUSY);
-	if (r)
+	if (r) {
+		vcpu->vcpu_idx = -1;
 		goto unlock_vcpu_destroy;
+	}
 
 	/*
 	 * Now it's all set up, let userspace reach it.  Grab the vCPU's mutex
-- 
2.55.0.rc0.799.gd6f94ed593-goog

