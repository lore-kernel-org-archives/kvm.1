Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B124316189
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953329; cv=none; b=gctgBgKfBUauUtbg2rXdWeEPoQUfEtbvoO2AcUvpTdCy5hzZ0sv2g/Of83KlDaah3vSrPNi1U2pwBR5db2pmfmXKs1juHObntUfBotxnLxKfjFp1xA2dWdpm1myR6u6ygNw8Gr0jeByqjwlxSD/Ln43vYkNHi419RynJbT/u14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953329; c=relaxed/simple;
	bh=/3cDx3aIf060SuHsn27j2Kp/Fy1op4c4/c+Wag2Nux8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aqDPq3w8hLWM3DBjNatq4KlVzPjjVQX1BhdVg2vx4U2w906ThOLYZvKrj7bh3QGgDH42OWioFwZ1xdPtEzU5JfQchhjPAEYm7GpbwX/qfyQyUb7BzWy+z7TLdxk8Guj1ThzBGJCbVFTKZbzVyOTIYOKV9mitj1ObzFyV/e+pQMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc3XDYuP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc3XDYuP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so7870488b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776953325; x=1777558125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vpe0Pwj50R8sAJb454RBdJG01v3qvgsTWjeq0H4u93I=;
        b=Rc3XDYuPzMpU4bqUT2flpGc4xy/7F6MCTbJwYPbz8Cwt2Z87Zr0AjddIRYzarlrA1t
         nrocpMyuGKTmV93e+FcNgiefJ5DvBoM02AH01Q6HNSsFICUSDmpjVslTlL68ViPsVqMv
         6pCDgHkitDLOJ7ORbYKhaxIjRCD+DFvDRcz7GuVwTBtBY5BKCPJ4Mjodb9mrEsLz2NAC
         RlylV+tLRPNiXKNr+6JuzhMwWtwly9ENjJxAFCZ+XxLNl/Qjx9BQdQ4fUnesoxfZtUnI
         eYnLN44rZzLnyqOkgTDdiCuvahQOc+jUgB+5eBYAsDaaYJgHrd0T3xnLbWyhgZZE3hxV
         50fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953325; x=1777558125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpe0Pwj50R8sAJb454RBdJG01v3qvgsTWjeq0H4u93I=;
        b=tR3zc4G9frptyzlAwtg7CPL1tCf270MC0/amjnfeTH8LTRqPKYrsdI2PiACLTKdPXZ
         0fdkfC0ZmBcKTNkh5ymovoRA1qSycZ/whze55gsB2wRq008xgMgfQXsLu7gbobFGj486
         AJJKhV+ibPOIFCg9KYJO2F8b8hsK96k/cQEiMUEpB8J5ApUY0yaUpp+Vb0yzeq+9Xug0
         Wxsc4TJbhjmeLJwTc4D8TLKZO7sjyjqL7n5Y5U5UJPpXoKaArWbX27kTsEiHw8t7Bm25
         dg1WQZ8Qbub+Iovz2oAPiqu7iKbxlHSAoy8Y1Tsppuba0VI7UOUQhMvlsAWFvWV8wKdD
         baXw==
X-Gm-Message-State: AOJu0YzkMe1ysI3fZWv883PzkFe8Qj1wuZ5SmjVDWi2/YnLeTksKqQDr
	0qvgzWg4qBcGX7nK4D/FRXUc9cyWSCzJKf8hmcHM869RpZd/rlNo62nEw337eJOEaQQKd2ln35m
	BCYGa/A==
X-Received: from pfbih24.prod.google.com ([2002:a05:6a00:8c18:b0:82f:36fa:1a58])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8a82:b0:82f:a6bf:bede
 with SMTP id d2e1a72fcca58-82fa6bfcb14mr14270676b3a.40.1776953325204; Thu, 23
 Apr 2026 07:08:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 07:08:32 -0700
In-Reply-To: <20260423140833.439512-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423140833.439512-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423140833.439512-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assert that either vcpu->mutex is held or the VM is otherwise unreachable
when using the normal vCPU => HyperV accessor to help detect improper
cross-task usage of the HyperV structure.  When accessing the structure
without holding the vCPU's mutex, e.g. to send interrupts or to queue TLB
flushes, KVM needs to use the more paranoid to_hv_vcpu_safe() to guarantee
that it can't see a half-baked structure.

To avoid false positives, open code accesses to vcpu->arch.hyperv in the
Synthetic Timer callbacks (can be reached if and only if HyperV state is
fully initialized) and in kvm_hv_set_cpuid() (can unfortunately be reached
during vCPU creation, when vcpu->mutex is not held, but otherwise is called
only when vcpu->mutex is held).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 8 +++-----
 arch/x86/kvm/hyperv.h | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 92a715d06d92..a79ccea05a65 100644
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
@@ -2311,7 +2309,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 
 void kvm_hv_set_cpuid(struct kvm_vcpu *vcpu, bool hyperv_enabled)
 {
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct kvm_vcpu_hv *hv_vcpu = vcpu->arch.hyperv;
 	struct kvm_cpuid_entry2 *entry;
 
 	vcpu->arch.hyperv_enabled = hyperv_enabled;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index ca5366341110..b7938d45f655 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -75,6 +75,9 @@ static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
 
 static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
 {
+	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
+			    !refcount_read(&vcpu->kvm->users_count));
+
 	return vcpu->arch.hyperv;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

