Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B82EEE92
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309049; cv=none; b=aAy3oCuQcdHC6a5i8zKb9aJ0xaXyv0kAh1Bp9p3yv4dpzEgADEWTR7UqhIHxWZEEld68eQIqKG84U2kBXGzpqeddYmnImBiGfKNzE32N6CkiIYfRIrs8zsdl1vb3YF8qOTyE6aVvmpmftxPJ6Q4pqSLwEdj0mZGiNF0QFLgq2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309049; c=relaxed/simple;
	bh=mT9EwItzZ02BMef+DvbbUG/noR3Wy+QzQNQXEWD/4J8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qmqd2tOfJk0BiETWyCefR4dnDS6dM3JgEBT9ol1q1lquGXNNpWET6rr/1NGkRKvag9s8fSsR2zRpvjhXsnom+nAX+wIsDxERbbW0V6GT9KFB7zywHjGOTas7DeuLK4K+ctzDGjz26ar/b2oO1gvXsWFrzNbOc2U35o0Z7z3MTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M70TAM8N; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M70TAM8N"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857ebbb0easo1434949a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309047; x=1781913847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mpjRMGry4hwZ4DyBtZXDEvXArio0cItc7zSoJ7iJP1Q=;
        b=M70TAM8NoCLLAbtw8ub8PBbm3d/Np0HHbuXaQ6dzNeAVyto0LH63le3VZK85JxNEI2
         u9BNg7B/hFEeBMYZnw6a8HsR6wg3xj9Fzw+NJ4L9857SotitEw0vqnFA6krlzqbsFqZs
         desbTD9W729rutsuJVG7ZdYF0acCJpbOl1Mx1UpJsb+Ft6qW61oJ+WCAyGE5aS33kLW7
         vbXqkOqVIj3mQaZ7+2Nqh52Ve4H4mCLa7O4EJfmzANTO0TVTPeH5sglzLg/F1cN4164i
         TLiOeZBMNdxUh/Rb/eTeAJbyJavVdDvP7uqnBX7IFiOiedA77oW19Azblljfj9c051Bf
         t85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309047; x=1781913847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpjRMGry4hwZ4DyBtZXDEvXArio0cItc7zSoJ7iJP1Q=;
        b=E5XEh4O4nlx2FyxqYifpLxSQGV7R+k3Xf6rRP5R3CrMGifiNx/GalTb+qFL2fUMmwS
         EsR9u03TlFTezdPjdj6GECFG9DOKQhElWU52pK6sUMVwkhjqaZQutbNbRPWTlWYCPbGq
         3Bfef+sUqVoqmoD5WOOI1VmVXh0EZxlL1Y10QKGShVtGE5GeIwj5iWClrwKjB85dWbyR
         XOauuN9YPbCfl2iIcEavvOVXC/zJQMAwCk+Qu+pyxN+vrw0htoFSTq4ONO518iYnsLne
         ItT0trM+WLzUH5MujGHMpfbToHW9YKSIC99de1oPWKOAhsyfGd4q700wah0onLnRwpTG
         o/TA==
X-Gm-Message-State: AOJu0Yzo6J+S7Y3qqi39/NvAXyirTBj3rRDQbjSOrw7iZnpvRyGDqD+c
	yu7WOwWw5v+2+ClRbyBqtgsvspFKbYWmlLY3ZJIApLUn6K2AWO4tcpe3C/MBweRCAMu5wbx4kCy
	9i6vUAg==
X-Received: from pfbkm55.prod.google.com ([2002:a05:6a00:3c77:b0:842:3c77:598c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4321:b0:3b3:23b4:6950
 with SMTP id adf61e73a8af0-3b78583188fmr4591909637.18.1781309046836; Fri, 12
 Jun 2026 17:04:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:22 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-24-seanjc@google.com>
Subject: [PATCH v4 23/30] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Bury __kvm_irq_line_state() in CONFIG_KVM_IOAPIC=y code, as it's only used
by PIC and I/O APIC code.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/ioapic.h           | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 72f8f8933ab7..2b96ab0f46f9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2253,18 +2253,6 @@ static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 
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
2.54.0.1136.gdb2ca164c4-goog

