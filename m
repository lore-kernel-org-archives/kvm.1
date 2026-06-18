Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5863CEB84
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808737; cv=none; b=TTlBcA6t4ojCZ3sALjcE+bBS2T/LoMgK8WdR3xCZHpruOm8lUsTlIyG0WN8xvRxPF5mZc/tpqlHRaavrfafdJ6YuAKYp2j1Oy9h65z+VsPE45PsHNTKiy5oUxyEgKs5rFGWv/ZSnixhI9DO3U5QCon3A8j0WW/rm7AfoZ/mxvBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808737; c=relaxed/simple;
	bh=qQrAsr3sQbep9ShkOCXZ743wxWtE1jL7XjZSHE4RfqQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YQElGwybxGtgBznMC6m2YsV4rI79FJ6jkbzX1xiIMTE+7pqTluOUHKP15EKRsgB3SbTevhxZa1r62t/9nfHJQfCH7S7C0M1rZ3lH0iO8WjAn03faHX1qyYXpknkb5FiXpVmTb3v8yXmlHlX5W5TaXROFM4U6Ww8tW+vlAsLic+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Msn0KoZS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Msn0KoZS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1027016a12.2
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781808735; x=1782413535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+W2ppM0uVePNx0td3UyF5B9F+I6DRWx5/6bKaNDO8M=;
        b=Msn0KoZSO+ZsA9fPcoye7h79g3yMjULMJG4GNKEKBjuweZlkL5YJHhBqRFFOeFTY1w
         nC6MOm5+uSjVTE9aGGowumvqeBmU5YY9VgYPmmFPwINKiR4DICWB/gw5qh8mqbOwixDd
         0/RD//3FJwz8SLy4bWOaFWrmOskpvmfBCfZvxPmEJlpMTQ5oUrgaWqHpZEwL4epqjQFM
         RkUq+GojeOF2nfKHtT5IDlK6EGzg0+sRI58sn6+tpu6DgJR2mukERULuwaK3rVYVgxbQ
         D8KJ0Ue0OkB400zxGt/GFHL0fT5goJVc43nw05M2lMryhIdb611wjl3fQhTqmL5yJtX8
         4d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781808735; x=1782413535;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+W2ppM0uVePNx0td3UyF5B9F+I6DRWx5/6bKaNDO8M=;
        b=eyI3K8cw7PYtkX/Fc3TthI8lnYYHJyyX4BOyKuiEXR9NbJeqz8wEaYMkJUyVd6ryVs
         FRtMCxZiOrIQqnY74f5CNp/DBI+UyIWtfX5VY0GHy689RtwP9/zGjOyB7nh2RiNI0R6v
         4gv4c7yFzUlIE50ZOulFxOdXbOlx1iM5roy8EycCBHiH6pbSm2cRhOPdmOJgdmLqnArr
         0KfzSJg+qRkvXmU3IcDrHtg+tn2uOFooqTdjpGjyqDfec/KJfZrpN+djtIetXEbMvgF2
         6BfX0iYNzrGMJquZaP44maMM4TazG2GAkyPmm9nOkCrIyANvJjvdJuj6eBxorCUXtWA+
         a2Wg==
X-Gm-Message-State: AOJu0Yzinp4PiXBfkKPNSckeGqsqiqPNFMo9aGZ0C/g7cQgVrhG8V2Cp
	KH1G5R/hZ7ly1sc1FlQl0loqXMHAkTCPtEOtSycTKCcnzpFpqU6aHGh51nT0V917rbU0CY3kvY8
	qNpRHhQ==
X-Received: from pgbl25.prod.google.com ([2002:a63:5719:0:b0:c85:6deb:ee45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9e11:b0:3b4:71c1:ab29
 with SMTP id adf61e73a8af0-3bb3221844emr359621637.16.1781808735067; Thu, 18
 Jun 2026 11:52:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 11:52:13 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618185213.2019937-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: WARN and fail kvm_set_irq() if a PIC or I/O APIC
 vector is invalid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

WARN and return an error up the stack if the PIC or I/O APIC encounters an
invalid vector when injecting an IRQ, as there is no danger to the host and
thus no justification for potentially panicking the kernel.  Don't bug the
VM either, as the risk of corrupting the guest is minuscule, and the guest
might even be completely tolerant of a lost interrupt.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/i8259.c  | 3 ++-
 arch/x86/kvm/ioapic.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 59e28c45d7dc..6a942ac622d5 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -194,7 +194,8 @@ int kvm_pic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 	int irq = e->irqchip.pin;
 	int ret, irq_level;
 
-	BUG_ON(irq < 0 || irq >= PIC_NUM_PINS);
+	if (WARN_ON_ONCE(irq < 0 || irq >= PIC_NUM_PINS))
+		return -1;
 
 	pic_lock(s);
 	irq_level = __kvm_irq_line_state(&s->irq_states[irq],
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index f3f4a483ca15..88bd226f3b73 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -504,7 +504,8 @@ int kvm_ioapic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
 	int irq = e->irqchip.pin;
 	int ret, irq_level;
 
-	BUG_ON(irq < 0 || irq >= IOAPIC_NUM_PINS);
+	if (WARN_ON_ONCE(irq < 0 || irq >= IOAPIC_NUM_PINS))
+		return -1;
 
 	spin_lock(&ioapic->lock);
 	irq_level = __kvm_irq_line_state(&ioapic->irq_states[irq],

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

