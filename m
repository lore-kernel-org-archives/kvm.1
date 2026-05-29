Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66047DD4C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093407; cv=none; b=cfUsGgkhrZYJIJ/bobtlnnugh4DpzjcV8RESkZGt89iTf4XpKWPaO1ZoyE4wMJ5N7S+AhfXqXORiVyicylLkFZl4UVFWp5bavdwLZrPWJNTtChlfoUCwatLoOc673QyUxsokl/xRiKa14R2Yo4rwYFCdlrxHNQVrhssjbOnKSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093407; c=relaxed/simple;
	bh=cAVTA4X118KjTxfXzG4OtoKCmSjIFhw3tbSFgguW9S4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dP1rojhXCupa+g2XUzNI+0iAfFFWaaVYVp8IlRe+5xLXOkVkPPD6OSf7wpu9opVsa1uUZ5Tu/l4fOJmiBwxNKTNfShNwrjyg7Ae6WrLV/WDf24F8HO/ilvLLgRVgXgJInvuXQ5NIxcojlUpwovg7RnjbaZ0FZLok4dmjmLZfu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryR36NoH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryR36NoH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36603ad6709so12067019a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093406; x=1780698206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bZ/xu/SiWZyqJK5vauNXTcwVMA30rU7kWatOu0HtYnk=;
        b=ryR36NoHtsbmncAApR7IgfQlDl6RwVUsZlBGjToHDhyHWdaH6j0/uWD6W0Etsgj7ry
         wDdoJpd5Dx6i4yhV4IEZjBXguE3DJpYSikjTbiC2ANs2lTShPVHtkfen7dtw3kEFB3fE
         +h4+KFxqfy7QUr1+T0YPcG469YfR4HW0ycfyItReo/jE3tv4oh0bXAGtD8mpWQWASGbw
         lam8Vy9rgrA27P83oG/QfNPCbFkl8IrV/p8TBMOxDR/q65qmvz1wW747cxRgM+vpstPc
         9psQ5xteP4bTXv25p6hSoYwzsIrJVzygnsk9XUDJkWOKBmDyV0WEeXW+dsoZL4NofkOo
         e1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093406; x=1780698206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ/xu/SiWZyqJK5vauNXTcwVMA30rU7kWatOu0HtYnk=;
        b=HUuGDu6yHjWNkL/l+qrgQyiHWnJbPYy28IW3xykOJ6z1toTvL+3bxjArN1+saUe5V0
         o+Ttd99dpS+AWXHXedximJJb9DWXJ78a3GSQD2nI/ezNom85DXAgXVocyUwafmHVFYB6
         yIh9sE4D48LA8IvzjNlCz9vc0kNRtgwpVnGccamgXcsbTZNkoxtUX1oz4C2W9Erg5jDu
         y6f4TZAWGfcCBidbXWLBvu/4ynTWcChROBT05OiFtGT79MMl6Xk9hX4tgPYnq1aA5KCx
         fnv7Zl+2xxUC5tmUYM62M8lwdrJ2tq4QAAUUeCJBNLJeCeEOWH7L5zT1RQrvnzmHSvKZ
         9tRQ==
X-Gm-Message-State: AOJu0YxQNZ3dSMXDmR0En7U/yySxr0OluV9Z91zQic7pfH1EOMy1iqkM
	TSIktZ1YAwu58TeSTGzampu9mPkeO7z3+cJlz42k2Yqct0300uwo81JyCUp6THWiPXZ7JW1NhC3
	ebSH3Qw==
X-Received: from plbmo16.prod.google.com ([2002:a17:903:a90:b0:2b2:5117:a3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c949:b0:2be:1c3c:72bb
 with SMTP id d9443c01a7336-2bf36860a25mr21141965ad.33.1780093405558; Fri, 29
 May 2026 15:23:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:18 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-36-seanjc@google.com>
Subject: [PATCH v3 35/40] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Bury __kvm_irq_line_state() in CONFIG_KVM_IOAPIC=y code, as it's only used
by PIC and I/O APIC code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/ioapic.h           | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 53994b8292fc..866d33abaee0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2275,18 +2275,6 @@ static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
-static inline int __kvm_irq_line_state(unsigned long *irq_state,
-				       int irq_source_id, int level)
-{
-	/* Logical OR for level trig interrupt */
-	if (level)
-		__set_bit(irq_source_id, irq_state);
-	else
-		__clear_bit(irq_source_id, irq_state);
-
-	return !!(*irq_state);
-}
-
 void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index 3dadae093690..81b576513116 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -113,6 +113,18 @@ void kvm_get_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
 void kvm_set_ioapic(struct kvm *kvm, struct kvm_ioapic_state *state);
 void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
 			   ulong *ioapic_handled_vectors);
+
+static inline int __kvm_irq_line_state(unsigned long *irq_state,
+				       int irq_source_id, int level)
+{
+	/* Logical OR for level trig interrupt */
+	if (level)
+		__set_bit(irq_source_id, irq_state);
+	else
+		__clear_bit(irq_source_id, irq_state);
+
+	return !!(*irq_state);
+}
 #endif /* CONFIG_KVM_IOAPIC */
 
 static inline int ioapic_in_kernel(struct kvm *kvm)
-- 
2.54.0.823.g6e5bcc1fc9-goog

