Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7E3BCD1E
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426997; cv=none; b=oCAEtcHtDhWG2rB0ucq15xvSQUpcmfCWBtYxeAQZtPh8tqOgM5o9nGFH528HtDmqQQp2GulIEcODVGTQYjGfpJ/BOREweOel/y2Mld1oTdiVKQ1R4mwxeQGGE8bqkzY5TN4948qAleCOls2ldAYcJsC6gXb6imcwzWCYqxBNB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426997; c=relaxed/simple;
	bh=V75SHra9VGRQmxCJJnEi01828Yrrz1sE2AE38QrP0w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2Nu0ssAb5j+Zwu4hHD2C3J0+K9FHI7tH/OUao7bNSGWvQGBIB9rC1Z05B7E9Yo1uMrqs3PSEoJ8+ezQILsv/RTa6DdEFd7e+p5syQy8PGUjfi69VIrcPXVHSi6F0T2Y9W6e9hyscrKPhaxzsQEFI4mYxCwnhdvR5rMbrtwgYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVUDn0sN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVUDn0sN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so250177a91.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426995; x=1783031795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UeadhBfV9V0Nj7tYx0kx2CoFCei/ZQCY4DJOehfMJzU=;
        b=eVUDn0sNcyAWImEwA9Yis7na3OfiG4h307t6rk2OLXFKNRsA3aaa8HYN87USPma6fu
         7DdZ7BS0s3xDPSc/QoFCzoNpEbplFJiM2WGxVF/FR0AcCVfKvmq5vQqgRKvDp0UBF9Ig
         YAAP0fSK7nXXFTQCGEk2eb1xSsE1r7z16+Gx6pRD9duJyoSkaHk6as2lj8qzZw9EH87i
         I5AqFH2eDU+w4O9U5dVoWLy2m/MlWNnT8HmKSLhdVWbBYl2vImVP18gf5BIb54VQgIFy
         YD0DO5ZmpRbIQfPHfAwqaemZACrPMK96efk9/ECROeYLckiuJiVO9AIsY3ygVeSYb6Y8
         m4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426995; x=1783031795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeadhBfV9V0Nj7tYx0kx2CoFCei/ZQCY4DJOehfMJzU=;
        b=ApmGHt53SkLZ6GxX6IYi2lPT6dWYboxLWUgrQXRi5UAjm9pUdaSN0+pHTZsL8f2ZPH
         2SVZgm8DgEosTCoH3t2iBdK8shmZfTLoxpOBYV7rNkzmo0Dhg6rhdzhyf6abjmkxOWtf
         CSEUK4wQQErRanlC5YlgUcFW3UClvZln5kReqBqoUT8HeyzN75RefxHXzrib9HSdZHqT
         b9K8G5dd1LcJ8T1bc9oWCP1wGIzpc+PzixL4ENd/F7w6sucTeS+EInVSBrLOWG/ky2A+
         OwlWyPxsT2lGe2oeG4nV71zwdmzlzUZH0sUwfml76b0r7T9Fd7EOcDAJ0+aVvhv7v9NH
         CBlg==
X-Gm-Message-State: AOJu0YyujZI5sEzaojn+WDzzNM2Ba/QlikmpB+eO0/IpmPkJjhXzN6rC
	rzu/eJQ+iaHng6b+kZYS4cxX3GKxYgUymqiWAgOqXw2iJmaHNSos8qZvnOD5Z3eplUsIElBuHXz
	zhzyOJg==
X-Received: from pgbdr2.prod.google.com ([2002:a05:6a02:fc2:b0:c8a:604f:6851])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:36a:5d1f:7b6
 with SMTP id 98e67ed59e1d1-37df9f38334mr3699448a91.2.1782426995052; Thu, 25
 Jun 2026 15:36:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:36:22 -0700
In-Reply-To: <20260625223623.3376478-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625223623.3376478-10-seanjc@google.com>
Subject: [PATCH v3 09/10] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Assert that either vcpu->mutex is held or the VM is otherwise unreachable
when using the normal vCPU => HyperV accessor to help detect improper
cross-task usage of the HyperV structure.  When accessing the structure
without holding the vCPU's mutex, e.g. to send interrupts or to queue TLB
flushes, KVM needs to use the more paranoid to_hv_vcpu_safe() to guarantee
that it can't see a half-baked structure.

To avoid false positives, open code accesses to vcpu->arch.hyperv in the
Synthetic Timer callbacks (can be reached if and only if HyperV state is
fully initialized).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 6 ++----
 arch/x86/kvm/hyperv.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 888526ce4dab..f765c3bb9b1f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -599,8 +599,7 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 {
 	struct kvm_vcpu *vcpu = hv_stimer_to_vcpu(stimer);
 
-	set_bit(stimer->index,
-		to_hv_vcpu(vcpu)->stimer_pending_bitmap);
+	set_bit(stimer->index, vcpu->arch.hyperv->stimer_pending_bitmap);
 	kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 	if (vcpu_kick)
 		kvm_vcpu_kick(vcpu);
@@ -614,8 +613,7 @@ static void stimer_cleanup(struct kvm_vcpu_hv_stimer *stimer)
 				    stimer->index);
 
 	hrtimer_cancel(&stimer->timer);
-	clear_bit(stimer->index,
-		  to_hv_vcpu(vcpu)->stimer_pending_bitmap);
+	clear_bit(stimer->index, vcpu->arch.hyperv->stimer_pending_bitmap);
 	stimer->msg_pending = false;
 	stimer->exp_time = 0;
 }
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index ea9c81d76dd3..37a0bcf03e28 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -76,6 +76,8 @@ static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
 
 static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
 {
+	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);
+
 	return vcpu->arch.hyperv;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

