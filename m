Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C62E7386
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914469; cv=none; b=h6Qa0W4/Qa1FFNLzPN1ArL3J2UQpQHjubNH2mCLhcJ2QE+YYPaTdjtEan/DAS3S+gWRft6LAMOU4HwcnQLI4XrRqVQouDTc5t1HzZNAcLvGQLa4W0rxUyU+V+EOtp5aUNkk1wy8l0vi+Ig5zaK5+AozYAVSl+DYIKTs4t3dzvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914469; c=relaxed/simple;
	bh=P/vz4YlFPpQWKS/Iy2gHb9O7M5CQuGY/6CWVmMfyjQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5eHbo1Fdn0nURVich4EuApL01WTjkL2bj8+AkPiv10dp9iYL/a3f8ElJK82KqfcpCnyoUWYN8Tu7foUOamd/ru4yFuFCWWMKpoO/EA0S+Nko9vs+2nf/xcgS4ebe5DqOznrr3nNJZ5F5DwA05XN426QaEQtCtrtBFVii4tBmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzbu6oEH; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzbu6oEH"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so853527a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784914468; x=1785519268; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wLT7gNHgdr1B3mxcznzuNraCWdUDx8twv8dXwpur9iw=;
        b=Pzbu6oEHP5xIGrx+MIXSmcpciV8eylKCRJLfTFxYqiPa6UvGcouWYuKrYiET55Uuc7
         UetiRycqtmZRGsG6PvqIc9OHgz6utR06lu+yyd7uR++YY2dnOyxW839cdZlYdDPo8qir
         oD31Ps+QA1cUMTSrPUS1o9K5MlFdoJz46xvhmJzoVuBPvNpLjVu8L8S5ktFwrQALADn5
         PtGDNRwonP/6NSocdwj69nxay5h3liBmCbky4DiijCOdN1iJEocAJWdUKIBxQy6n9tly
         AOkLgWyFbubN972tNVhbMgWkIEKq3obN8RnXaW+gd8Ecoha/pagzUxtLkUCkXMSa0F6a
         bm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784914468; x=1785519268;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wLT7gNHgdr1B3mxcznzuNraCWdUDx8twv8dXwpur9iw=;
        b=rtGUu4aRITjMpTVvhr6X2cUhOtVIb8Z/Gcbq17YCxBINhAa+qxZyl3ZMLFzckKIqp/
         3F9uHbgiCeHjflHQ3748w3neg65/WW2DkZ/Bu0saXtJafirabKne+pZz15bvWiJzLcj+
         2EW3Wo5QQ1GJMBw/oCBkAwPwOHLXIzvRcNHDhRhsACYpotUnNTy3473XmXh/9Mt9zSZx
         g2D745KMuCBrpU/EpUfKfxULlvIirl8MEUpn0gOLsQjTXldMYyZ4dLO402/cjTkV0B3O
         GIyUo3WJjzwEb9OUrfMzNxVBeCTi61zaNhl1KGtqASlNPyYbEEx8BJ9llPwj/kSAFEz2
         hIKw==
X-Gm-Message-State: AOJu0YxHbmX7jp1P4xKL3aeSMh8YE7AimGYjfaewqzyQviKJx1ry4NR/
	hpRzdgj1J7MDIilVvLx+XcK9/tLSylfSj0UuL73GVnNMv73qd2TdsrjrASYHgcfh+daXXG55YqZ
	KjiYjWw==
X-Received: from pgbcr2.prod.google.com ([2002:a05:6a02:4102:b0:c8a:8cda:bd59])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:610f:b0:3c3:ac9c:9a6e
 with SMTP id adf61e73a8af0-3c44b2ae3bemr9304061637.68.1784914467661; Fri, 24
 Jul 2026 10:34:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 24 Jul 2026 10:34:24 -0700
In-Reply-To: <20260724173425.278753-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724173425.278753-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724173425.278753-2-seanjc@google.com>
Subject: [PATCH v3 1/2] KVM: x86: Don't WARN if IRQ disappears because it was
 cleared from the PIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+dd769db18693736eee89@syzkaller.appspotmail.com, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When getting a to-be-injected IRQ, don't WARN if the IRQ disappeared and
the VM has an in-kernel PIC, as the ExtINT handling that's routed through
KVM's virtual PIC is tracked per-VM, not per-vCPU.  If another vCPU grabs
the IRQ, or deasserts the interrupt (which is level-triggered), then it's
both expected and "fine" for a

Keep the assert for split IRQCHIP VMs to help detect KVM bugs, as userspace
is responsible for routing ExtINT to the intended vCPU, i.e. once an ExtINT
is pending, it can't be cleared without holding the vCPU's mutex, and thus
false positives are impossible.

Fixes: bf672720e83c ("KVM: x86: check the kvm_cpu_get_interrupt result before using it")
Debugged-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dd769db18693736eee89
Closes: https://lore.kernel.org/all/6a360fdf.871e809a.2d6dda.0000.GAE@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.h        | 16 ++++++++++++++++
 arch/x86/kvm/vmx/nested.c |  4 +++-
 arch/x86/kvm/x86.c        |  4 +++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 1a84ea31e7fd..eeaf527cecc4 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -118,6 +118,22 @@ int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_cpu_get_extint(struct kvm_vcpu *v);
 int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
 
+static inline void kvm_warn_on_lost_irq(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * WARN if an IRQ was lost between detecting the IRQ and grabbing the
+	 * IRQ for injection, unless it's possible the lost IRQ was due to one
+	 * of the exceptional cases below.
+	 *
+	 * If the VM has an in-kernel PIC, the ExtINT handling that's routed
+	 * through KVM's virtual PIC is tracked per-VM, not per-vCPU.  If
+	 * another vCPU grabs the IRQ, or deasserts the interrupt (which is
+	 * level-triggered), then it's both expected and "fine" for an IRQ
+	 * seemingly be "lost" from this vCPU's perspective.
+	 */
+	WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm));
+}
+
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 0635e92471c8..c28a3ec4e4b7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4464,8 +4464,10 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 		}
 
 		irq = kvm_apic_has_interrupt(vcpu);
-		if (WARN_ON_ONCE(irq < 0))
+		if (unlikely(irq < 0)) {
+			kvm_warn_on_lost_irq(vcpu);
 			goto no_vmexit;
+		}
 
 		/*
 		 * If the IRQ is L2's PI notification vector, process posted
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..e97b76b7794f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7686,10 +7686,12 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 		if (r) {
 			int irq = kvm_cpu_get_interrupt(vcpu);
 
-			if (!WARN_ON_ONCE(irq == -1)) {
+			if (likely(irq != -1)) {
 				kvm_queue_interrupt(vcpu, irq, false);
 				kvm_x86_call(inject_irq)(vcpu, false);
 				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
+			} else {
+				kvm_warn_on_lost_irq(vcpu);
 			}
 		}
 		if (kvm_cpu_has_injectable_intr(vcpu))
-- 
2.55.0.229.g6434b31f56-goog

