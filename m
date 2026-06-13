Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56F30C17E
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309053; cv=none; b=hmyPkUUTwH0yA0bV1WL8yRFwO4C4DvEulYLjZUzTisCqke9ecK3LNPjuFuoF0ul/qHpNsExNv7FBvsjIEwsJQEKeWVUQxDL1xJ78sqWFcCm7NEO3VtWIW6RsvpFR98m0gVzJMiN/TGL1VL88cAKI9RMczQC1OZgFQ5ANzgtu5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309053; c=relaxed/simple;
	bh=VLPFE3d5+MWFE73Aeh4k+ZcXMnNj4fLH24O6wwXd6/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z94EpSGl9l168PMuGXnLESHz87cdED6rrMNNHCBCYatW+z3W40UWEEgnAHnLITBJZr35i0/Zv9SPihIDWsWGyL2OVREJuQl0uH4vXY+t3k1/ggvlDxF3FKMeeBIqcLk65w1ixfgh9t5AWzAWCAKc/AfTCfRjslAT7K1qC4VIABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKKhUk9r; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKKhUk9r"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2064133a91.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309051; x=1781913851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrUwTTXFBw8wHMHMdaAEujEtvp+5TOf8REV1jotnC4=;
        b=rKKhUk9rKSSs++eVOfrJ/tYFwXur0cPJ+s8DLy6/T5/2y693VIUtoezhzFp3bkFksX
         gwHw2geXhJIs/gvj3kIJ/361s2IunG7sYvpm6G1DTN7AcItsWu5m4HMHY8mLsXxAt0jB
         0INmAAv+PHgX1G8iHqbn3s5WkeTnRneax1y3fqr3aJUShLThc0ZxS6Q/SSUuxlreD7He
         uBGQC3x7PRkvpc4cZiMDFMsbB3sa3Zh0epQcNT2YZuKbNydZNiHjuLpZDthjOM+Zzkgm
         UhKG9lKq3zrWhXTCzi54dCLv9BzKI0cNYHncaJrmvfPgLe+2cDDYHiVY0+rayek1G3Vx
         0GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309051; x=1781913851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yrUwTTXFBw8wHMHMdaAEujEtvp+5TOf8REV1jotnC4=;
        b=LaZSIMCD0Uk6w/bRTGzsEOhnJ50ooqPmWrx6ujnRbzgp4WpsrC0HNTRIXIs+U7GdCI
         Ec5FzbMR5O34gJ19tdNHFbi+wAgOBUgQJ07djaOgIyhvVm55h6tU35XckfU4Bi51FDCe
         GYfYQh/LE0hSGX2jMraU/3fNwytIqLOQe81MjmkvCsGXjYQJhwk/vi0AZvG0D81NNoLY
         AEw4D+RYKtOUR5hn7UTGd1m4+hI8ZSVniCN/6By6dmdp9A1/Qs3rGG5xc1FgthTY2x6p
         HFiFWYca2yhl3axzen9+RJlzGy8Q7v2iVQQyFR+hDaoen9yroBauy4ZccbWSchXpno8G
         8jTg==
X-Gm-Message-State: AOJu0YzoSOV/Vc310RmUGteVnDIFXb1L77cfCRmA9CoVtFPbuK3WI0lO
	WTPEKPENmp5UbIwfbexJBlCBeAiMYPQf9YJTj/LXFY6vmIhWGctpXmUAwMhfiA0+ZLZwk88uXEY
	g7vz+qw==
X-Received: from pgnr12.prod.google.com ([2002:a63:8f4c:0:b0:c85:b75b:a85d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7353:b0:3b4:640e:f6b1
 with SMTP id adf61e73a8af0-3b79624b553mr1704981637.10.1781309051281; Fri, 12
 Jun 2026 17:04:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:25 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-27-seanjc@google.com>
Subject: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

When querying whether or not interrupts (IRQs) are allowed, check for a
pending nested run _after_ checking whether or not interrupts are blocked.
If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs can
be blocked while running L2, and interrupts will indeed be blocked once the
nested VM-Enter to L2 is completed, then KVM should treat interrupts as not
being allowed.

For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
immediately request an IRQ window, instead of forcing an exit and _then_
requesting an IRQ window (because after the forced exit, KVM will see that
interrupts are blocked).

For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() is
affected in practice.  kvm_vcpu_has_events() is unreachable when a nested
run is pending, as KVM clears nested_run_pending prior to calling
kvm_emulate_halt_noskip() when putting L2 into HLT via GUEST_ACTIVITY_HLT,
and SVM has no equivalent to GUEST_ACTIVITY_STATE.  I.e. the vCPU will
always be runnable if a nested run is pending, and thus
kvm_arch_vcpu_runnable() => kvm_vcpu_has_events() is effectively dead code,
as is __kvm_emulate_halt() => kvm_vcpu_has_events().  Oh, and TDX doesn't
support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
KVM shouldn't be faulting in memory with a pending nested VM-Enter.

As for kvm_vcpu_ready_for_interrupt_injection(), incorrectly treating
interrupts as being allowed could result in KVM prematurely exiting to
userspace to accept an ExtINT.  But, KVM will still hold/block the ExtINT
and request its own IRQ window.  I.e. the net effect is more or less the
same as the for-injection case.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 526e0fdcd16b..883d5f703391 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4055,12 +4055,12 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (vcpu->arch.nested_run_pending)
-		return -EBUSY;
-
 	if (svm_interrupt_blocked(vcpu))
 		return 0;
 
+	if (vcpu->arch.nested_run_pending)
+		return -EBUSY;
+
 	/*
 	 * An IRQ must not be injected into L2 if it's supposed to VM-Exit,
 	 * e.g. if the IRQ arrived asynchronously after checking nested events.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c120ff47790..9b277e36a521 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5254,6 +5254,9 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
+	if (vmx_interrupt_blocked(vcpu))
+		return 0;
+
 	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
@@ -5264,7 +5267,7 @@ int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	if (for_injection && is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
 		return -EBUSY;
 
-	return !vmx_interrupt_blocked(vcpu);
+	return 1;
 }
 
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
-- 
2.54.0.1136.gdb2ca164c4-goog

