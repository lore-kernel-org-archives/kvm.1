Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A43375C5
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860195; cv=none; b=TGbuXfOBQasjd2zzzQEq77Dr34DoHIleYDCF6WLuvrPtYg0F0Wvb8UTJWaFryxv40RIRVjXMiWoLXG7Pn+kNue8Beg59GPD2+gejsxV4GxhY7yFEWHKZTZnHvGLWvleeebISOlnfiuUTCUcEA59G+FqdxwpbzeLiWE/rDnea81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860195; c=relaxed/simple;
	bh=V75SHra9VGRQmxCJJnEi01828Yrrz1sE2AE38QrP0w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IVOgjM/AMbxNOtGD5UwonebTO+heP4AJXdmqIMKd72zt4CesgEbKAx0dqh/rAsD1+c9gXANQIPlPLOa/V/CWtIrl7p8asz6eBtZjmb48uPbM0XtTqzxcriYK6HLEUwdAqRttT5k01JU5pEGajfCI6rO3gp18Qtb4AppydU/918Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai1XQIUf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai1XQIUf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9667280edeso1653638a12.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860192; x=1783464992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UeadhBfV9V0Nj7tYx0kx2CoFCei/ZQCY4DJOehfMJzU=;
        b=Ai1XQIUfCNQN1jeHxaYrOXjBi7JtctfHK/JPFig/2+DwzK8VCVSJnb+eXT7qvKDOFT
         c+MSdm2CAq8YiaHvkvFpQFjHmnQCKY9sy3pTlkIogg+e+W+MorZ5Qq9QPoDn61oOYIlI
         Chxv4e0qykRK7JHpXrOyOv6wFQTMwEt+3anmYdfFp6/5bKDC+PsjveLTQvSA4R4a3+El
         LttrCNrXo++IB/ReyaIARPOs62z9fiN5DAO3Ga+6vhotRHFoR+dmX7ILPmCngEp6rsUc
         zyFhtkwxDAaETsur1Js9RWx8Ve9QsEywTwocYAujtGAYSn5Veq+KEJdew5+dUEywP/WR
         AdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860192; x=1783464992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeadhBfV9V0Nj7tYx0kx2CoFCei/ZQCY4DJOehfMJzU=;
        b=f9dJn0zWNhAj0cWZtpdDEhnXvibIKl8SCTYXtvnayo0pagwB2DlhruZVrDxlBIEp/j
         w2g5Br3Ozw9F9JMSt7c9ToRi4AAIcVKzhqLr0t3ljLIztdnitoS+R5Gc++gheu+BrJmQ
         R3l2rHSWfWhJjB4d/Obdhm6gRX9QzV1nCVXw08fadhYZhFpwjkVwl71yeuJjOwX8j6cI
         j3LlQ7uAlMJVzNyKaIOgbEkTijW7yyhJVxInwGvznpWM1XSeYgp7j5ffh2r/5TLyXe2l
         WE1BTJ9uNrRwJEizY8XqLzzQbMDqiB7q/A8QHDZYFtopWe26fzF19uBr1ta+IW/y7PwZ
         Jjqg==
X-Gm-Message-State: AOJu0YyUvL4Att5w1jwH+NomuQE2fTznRPmQhjkBrzvu8bS+ioNLRsbJ
	UaOpfEbErhhaXZL6TvG+5mRPRC90GcCV6Uv3Sl55/s+PUBOrdIpytOvFuxFBLk+77frAqIAYlYR
	rRTLQyg==
X-Received: from pgnb5.prod.google.com ([2002:a63:7145:0:b0:c96:6f3e:49c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e97:b0:3b3:10e1:a870
 with SMTP id adf61e73a8af0-3bfc52de584mr4639879637.32.1782860191596; Tue, 30
 Jun 2026 15:56:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:17 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-11-seanjc@google.com>
Subject: [PATCH v4 10/11] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
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

