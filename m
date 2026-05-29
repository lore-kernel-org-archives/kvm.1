Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1A44102D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093385; cv=none; b=J7OZiFBII2gsaVIMKW0XTVQFFZoub34z/RROYkF53Z1pWi92WNBUPxnteAdKhdbYKvjWiWCSI2cNdcpM3zNMdtJgDmGN/NycxtzHI4eq+8GgPtBY2SouZsJjAws6ayP9PNvjoWSqUG7KHde8qESSiNo7sHxbKlot8ywLCqigA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093385; c=relaxed/simple;
	bh=zgjEBonFpYyfZEeJOfnNulnQALKYg2PSbkfjIHq2VTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjP7u16CzdJYwSBkP4FHXn8pFh6vE/sL/Uhf80Z1nhxfNdfM7P0rEMqA2ieR2r+l6oydNqmOpeZ2Ay2t9/3ziy6/r+eJ7BCxY49BHYDaHqSyvueMv8hQBygOjZT33n2ca4Yt4xcUe2LAp5YKL6Kjj59Z7gAWpxbDhTJ965O6DBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfXn8aWF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfXn8aWF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso148690495ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093382; x=1780698182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=L8jJfO93jBjZBPQnPLlI5VrnRwAv6dVrWszogTbYM3M=;
        b=FfXn8aWFEt/vn/a57i8E3xgo99bk6AMsmdiJluIej3yjB6Iv8kxXZj1m8S9g4lnjuy
         lTCiAYQsr/67q+SWKkEYxBqgpQsB6hl7NZUgam8Itau+kOC6hr2CKQndSfWkkEEHIx9k
         5fM0B5ghmqDfEj+fGonnOxghSoAcGsXez3XzowRDhMImMS8n2pgyv4OBmgd5TU7cyewN
         hKE7bjVDf+6QaPYOxdAnrAFGo1RvQqVAXnpDBhJbpYsiZaWRxBNPno3UpCOSayRT4jOb
         IpIl5EPFEJWAHZvbDGqkjlGQSyyU/16WbOciDS4Rqsl/DlOFZ75cyLpYMfp57qcJknJB
         qbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093382; x=1780698182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8jJfO93jBjZBPQnPLlI5VrnRwAv6dVrWszogTbYM3M=;
        b=e91gO3KQN2+wZ4brCS3yV7MDlx66fwWODaqOxUfmFvYHxnAv+hp1qQdHqJDdX2a0Q9
         fUJUDAyNsPbeJmUTwBVKX7e35uDpYAuW2Cf5lqHAlM1zYWcuCyVeIYlvNV3kD2SIvjx0
         kNm/QWAUvvFZi1WBxyl1emkfon7J30GnitUpRx1dif8ycUVgeCrMFUxmkdzFd+QtogDb
         UxospSgagBO4mdaIbPUH+ZUbQKfGD/1WjPoNsq3w27UvB9iGXBrjT1o9uIZS45XPnx9I
         FmQLqQoE5mBjcevwjpBBhGgw+hTCVwaicPKGGXGfe9bFwnUqeYzg+YlnXDw+BR10M2PI
         ia9A==
X-Gm-Message-State: AOJu0YxVJxQmTi8p8KJdZFEoKcSNhGP8U3u5czQV3dtZOsI/PUjVXb2y
	v2zNzyiJjQnWUXgUUWo+YP2xLi+2wHVpp3ARRPRWgDFfXyUzdDpFXSOLQdIzZtjxMJiyN4r9xYs
	4OPoDxQ==
X-Received: from plho6.prod.google.com ([2002:a17:903:23c6:b0:2bc:bdcd:c51f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc84:b0:2be:22cc:e227
 with SMTP id d9443c01a7336-2bf3679e713mr19921875ad.4.1780093382161; Fri, 29
 May 2026 15:23:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:59 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-17-seanjc@google.com>
Subject: [PATCH v3 16/40] KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move single-use local APIC IRQ helpers out of asm/kvm_host.h so that they
are co-located with their user, and not exposed to the broader world.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/irq.c              |  7 +++++++
 arch/x86/kvm/lapic.h            |  5 +++++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 983bdc84f9f9..ee205f8ad5af 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1772,11 +1772,6 @@ struct kvm_lapic_irq {
 	bool msi_redir_hint;
 };
 
-static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
-{
-	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
-}
-
 enum kvm_x86_run_flags {
 	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
 	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
@@ -2510,13 +2505,6 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
-static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
-{
-	/* We can only post Fixed and LowPrio IRQs */
-	return (irq->delivery_mode == APIC_DM_FIXED ||
-		irq->delivery_mode == APIC_DM_LOWEST);
-}
-
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 	kvm_x86_call(vcpu_blocking)(vcpu);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..2b4e68e7cadb 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -423,6 +423,13 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
 		kvm_make_scan_ioapic_request(kvm);
 }
 
+static bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
+{
+	/* We can only post Fixed and LowPrio IRQs */
+	return (irq->delivery_mode == APIC_DM_FIXED ||
+		irq->delivery_mode == APIC_DM_LOWEST);
+}
+
 static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			      struct kvm_kernel_irq_routing_entry *entry)
 {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 71970213dc1f..32f09b25884a 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -237,6 +237,11 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
 	return lapic_in_kernel(vcpu) && test_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
 }
 
+static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
+{
+	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
+}
+
 bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
 
 bool kvm_lapic_suppress_eoi_broadcast(struct kvm_lapic *apic);
-- 
2.54.0.823.g6e5bcc1fc9-goog

