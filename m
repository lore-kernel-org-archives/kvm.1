Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02F3A5420
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794280; cv=none; b=mZ+eyKHW3CKIqpFs/X4UxxLV2V+g4QcMyWPwKppwjkHvbR0NWvyugyh7KE1k0BZaOn785e/vCt6UrFOsWNlZ1Blexoxu+AExr3yxt5JEh/ESjue1Rf6BF9rLFNNTuF5dCtdq1VVzGAUz+Kjmjo0vTOA8o+awOYwsWEtA6IFWC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794280; c=relaxed/simple;
	bh=zP8FG7gR4kQSYlMKsnzHDVfBp2RBSnmLhcQ8x+sRKY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPsgRRZ2yy+ZgGaVtkZjBGQisbickb7H6+lVNZREwPEoyIDlB2LECeNBRmkfHi9LjFefPTiA9NPLKsj7mdyi9I99Kzb2TGmiRUoFHfKJPgWUNndsnXOVaxtlOw1FiiFkm94dSXbZQlNyEcXn/6iZAZjO29voHqh82M81DrCHyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZPgd/OS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZPgd/OS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso8025769b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778794279; x=1779399079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XG/6b/TOztbBZwZn8k6Bl/hK/PyTdi4YhEYhzuDxK0k=;
        b=fZPgd/OS8rU3tq99Xe2L94LZXO+ORMg9cDhUx2CGE/UeKGRfna4f2iZVYLBeKaN7+U
         eJzPNXDfbx6AzWa6J5g28s8pHy0+PFvUKuBwO2qSvkuzOkiMm6bFOiX0pIiIomiD4Zng
         VST57hMq4X1t1C+3BiT0GpezwA4ZSjd75JLxFxzoy6cAPIQOaYI5Zb8Rzb3HUMR1FMJI
         d03QnLV3iZw13k4u6nlNbi0lF3Lmr7kY0A+sH3/3oOhOR/yRwF3+rSJgPhKb/1jCMpZ0
         PlEFw3bMUGthGVbFSoiuSTAs9NN6tYPGthM53JOOC1yV9bAf11q2rnTtJnsugZ5hM+za
         yK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778794279; x=1779399079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XG/6b/TOztbBZwZn8k6Bl/hK/PyTdi4YhEYhzuDxK0k=;
        b=ecrND/8huA7DoXsXKW9tIYPvHg1HdjqD0ddAVvQc67If35LrqD2Ihv5ZjGCcV539Vv
         md1RXbcQnKuN98Xma0sAqzQukKlTN+yJhNNyAWMAKLjWyPyrIqX1iDK2PoJKy3uH+pln
         VO5ysQqLK32GVrqTlSvICN+UnCzqj5mQ65AbeJeQnw4r93vOgpY2Q9MrzeUFB3GQ/DGZ
         MYrYvFkDJ+ItmVkk+CYMgFaxrMlfgH0jkNfptP1QTh0a8uKAOXeBqCU1/9ByU4vS1GJ5
         +TCko8qUZY6nodnYzAU3eUI0sgpsAfywBas9DKyerP5nTyFLGtXdz10hledWsvatqW2C
         CFmw==
X-Gm-Message-State: AOJu0Yz9Kn2RnSxtxWz2wUUUd33tBFSrSOj3UUgC2FNfRz5YTDKeOEiQ
	QqQnQYtterOmTKLJ+2rfCreWoE4TkC6c08cYSIeReCMH2xv6BnohqZOR+xInFg08gDwklIYyadB
	1OB3qwA==
X-Received: from pfblu7.prod.google.com ([2002:a05:6a00:7487:b0:836:6e32:7280])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:35ce:b0:835:3f51:7305
 with SMTP id d2e1a72fcca58-83f33cb3b90mr1144398b3a.15.1778794278325; Thu, 14
 May 2026 14:31:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:13 -0700
In-Reply-To: <20260514213115.1637082-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514213115.1637082-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514213115.1637082-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: x86: Add dedicated API for getting mask of
 accelerated x2APIC MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated local APIC API, kvm_x2apic_disable_intercept_reg_mask(),
to provide the mask of x2APIC registers whose MSRs can and should be passed
through to the guest when x2APIC virtualization is enable, and use it in
lieu of the open-coded equivalent VMX logic.  Providing a common helper
will allow sharing the logic with SVM (x2AVIC), and as a bonus eliminates
the somewhat confusing code where KVM enables interception for MSR_TYPE_RW,
even though only the READ case actually needs to be updated.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c   | 21 +++++++++++++++++++--
 arch/x86/kvm/lapic.h   |  2 +-
 arch/x86/kvm/vmx/vmx.c |  3 +--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4078e624ca66..4e34f75e705d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1730,7 +1730,7 @@ static inline struct kvm_lapic *to_lapic(struct kvm_io_device *dev)
 #define APIC_REGS_MASK(first, count) \
 	(APIC_REG_MASK(first) * ((1ull << (count)) - 1))
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
+static u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 {
 	/* Leave bits '0' for reserved and write-only registers. */
 	u64 valid_reg_mask =
@@ -1766,7 +1766,24 @@ u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic)
 
 	return valid_reg_mask;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lapic_readable_reg_mask);
+
+u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu)
+{
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)))
+		return 0;
+
+	/*
+	 * TMMCT, a.k.a. the current APIC timer count, reads aren't accelerated
+	 * by hardware (Intel or AMD) as the timer is emulated in software (by
+	 * KVM), i.e. reads from the virtual APIC page would return garbage.
+	 * Intercept RDMSR, as handling the fault-like APIC-access VM-Exit is
+	 * more expensive than handling a RDMSR VM-Exit (the APIC-access exit
+	 * requires slow emulation of the code stream).
+	 */
+	return kvm_lapic_readable_reg_mask(vcpu->arch.apic) &
+	       ~APIC_REG_MASK(APIC_TMCCT);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_x2apic_disable_read_intercept_reg_mask);
 
 static int kvm_lapic_reg_read(struct kvm_lapic *apic, u32 offset, int len,
 			      void *data)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 274885af4ebc..f763cd29a508 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -156,7 +156,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 int kvm_lapic_set_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_exit(void);
 
-u64 kvm_lapic_readable_reg_mask(struct kvm_lapic *apic);
+u64 kvm_x2apic_disable_read_intercept_reg_mask(struct kvm_vcpu *vcpu);
 
 static inline void kvm_lapic_set_irr(int vec, struct kvm_lapic *apic)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b02d176800f8..a23a144eef13 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4156,7 +4156,7 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 	 * mode, only the current timer count needs on-demand emulation by KVM.
 	 */
 	if (mode & MSR_BITMAP_MODE_X2APIC_APICV)
-		msr_bitmap[read_idx] = ~kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+		msr_bitmap[read_idx] = ~kvm_x2apic_disable_read_intercept_reg_mask(vcpu);
 	else
 		msr_bitmap[read_idx] = ~0ull;
 	msr_bitmap[write_idx] = ~0ull;
@@ -4169,7 +4169,6 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 				  !(mode & MSR_BITMAP_MODE_X2APIC));
 
 	if (mode & MSR_BITMAP_MODE_X2APIC_APICV) {
-		vmx_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_RW);
 		vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W);
 		vmx_disable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W);
 		if (enable_ipiv)
-- 
2.54.0.563.g4f69b47b94-goog

