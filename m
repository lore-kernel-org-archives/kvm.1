Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80D8BE9
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309017; cv=none; b=Z9UEEUXLjFr6ixuLZdfX86zCRnDspmvyMcpVKvBvvfiOxQ2yG7+LsttFN9dTHKSlDEzfZwPN/HRS/Yb5EGLc5agch+Wj6KdUjQ4gJHqQJE2iiPjCrlN9L1qJ+C43/E93qBN8XE9C1lorAumxL44MP0Db0UzJepW1x/OhJ+uvAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309017; c=relaxed/simple;
	bh=zJvmetUuYDrNCvV6vj0E6+778oJbH10JC7P+TMt4iLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hizA5hBV3ihq9fq7DTAOmdc6FpFjvXmFifaFhIXjhKHuE43qe8pEElVO2UwxHROhzCbxDqcyBxz5NdRivreL0G+IC/EsKY3kihmOQzSSPb0M6ZGLFfT+aO0oFa+9xqfAXavRy4I68pf/3Es30biFqKHd85wtuq6cPpIQtUt5SAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hm6mwg3y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hm6mwg3y"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2b64850easo28391035ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309015; x=1781913815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HRpeuX3hg7q8wIj3QzNIG0ThyDzZrZHJ1KdjFxz8oy8=;
        b=hm6mwg3yLd9C/ykbjJ6U89iknZ9O/Er5B+mmWDgumnsMTdBjJgAilzgvqrZIVXjHhL
         wupWoqL9/W4c8LZ8WHuY+tm7xghboFBieXrxZ8hX9UXB+2LIECQ/9YEy1zWHOq5DoVhG
         9cZ9kv/q5km2tWYcrmPESxgntLu4ymR3AWDMf2STLsQtjsB1Q00YjykX4MbkYCq8HvKd
         rA/l+tmB+PQMZymtfi00masRr34qorqSrexrUS9Smrt6fJui3Smy/J3rK57TVUCtJlXf
         hl4mRLKkqUAe6D1/uM2yMZ4OkXLeP9LyVHBiJiw9KL/8x+y7WXdGuBbfr+9+aH3hojzW
         LmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309015; x=1781913815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRpeuX3hg7q8wIj3QzNIG0ThyDzZrZHJ1KdjFxz8oy8=;
        b=TChmcZmV40rmq/tFxJyGbbRP2dKfm35pHa2Fxqvknm4oNGG7tp6yLSLf+Z5XHEi4a9
         zKYn7BtKF6wFyt/1Cf901Qvu8jO71PPg4yCKqLMhmxMuaGZT67a/tMkCLdjV0UO58uAw
         5yeDqeIGnC0ImlWKKVbFReayidUiUPpIoIJE4b6te6COlEqh+GnyyVdGHzV8ps0z6Snx
         uOtCMQOOx3sWOBkgCRXKravnZW88fzRQeyviXZh2LCf9WRjHtluP52itGhiaQUOUKQLK
         hly64iLLr1D8n9IHmo6iDshQkxxNPRxV4147pcf7CG/s6FKUF6ckos7qAoCJ4Z4kzW7w
         o2TA==
X-Gm-Message-State: AOJu0YzWNQxXaQZIeBlyPj8h/aMT6BMMzB/aVgUkHcJfGRCIG6WOgInT
	pfPgbK3xjzMxvHRI3nqCwku7mvsQLZ+jC5bb5lSV+h707KyJr4/85nOxZYlyqxJG5Bspfaglh9w
	DNphuCA==
X-Received: from plbkc11.prod.google.com ([2002:a17:903:33cb:b0:2bf:693:47b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f45:b0:2b4:656b:aeb0
 with SMTP id d9443c01a7336-2c66429b0c5mr18216605ad.35.1781309014692; Fri, 12
 Jun 2026 17:03:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:01 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-3-seanjc@google.com>
Subject: [PATCH v4 02/30] KVM: x86: Move get_segment_base() to regs.h, as kvm_get_segment_base()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move get_segment_base() to regs.h, as kvm_get_segment_base(), so that the
bulk of the register code can be moved from x86.c to a new regs.c, without
simultaneously needing to rename "public" helpers to explicitly scope them
to KVM.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.h | 5 +++++
 arch/x86/kvm/x86.c  | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index a57ba26279ed..e5b16a0826d9 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -412,4 +412,9 @@ static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hflags & HF_GUEST_MASK;
 }
 
+static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	return kvm_x86_call(get_segment_base)(vcpu, seg);
+}
+
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74b8f98dcb24..0f48cd630c32 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8492,11 +8492,6 @@ static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
 	return emulator_pio_out(emul_to_vcpu(ctxt), size, port, val, count);
 }
 
-static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
-{
-	return kvm_x86_call(get_segment_base)(vcpu, seg);
-}
-
 static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
 {
 	kvm_mmu_invlpg(emul_to_vcpu(ctxt), address);
@@ -8641,7 +8636,7 @@ static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 static unsigned long emulator_get_cached_segment_base(
 	struct x86_emulate_ctxt *ctxt, int seg)
 {
-	return get_segment_base(emul_to_vcpu(ctxt), seg);
+	return kvm_get_segment_base(emul_to_vcpu(ctxt), seg);
 }
 
 static bool emulator_get_segment(struct x86_emulate_ctxt *ctxt, u16 *selector,
@@ -13839,7 +13834,7 @@ unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
 
 	if (is_64_bit_mode(vcpu))
 		return kvm_rip_read(vcpu);
-	return (u32)(get_segment_base(vcpu, VCPU_SREG_CS) +
+	return (u32)(kvm_get_segment_base(vcpu, VCPU_SREG_CS) +
 		     kvm_rip_read(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_linear_rip);
-- 
2.54.0.1136.gdb2ca164c4-goog

