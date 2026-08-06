Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE533195FD
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036444; cv=none; b=QFYwRZ8fAvG8zlfCZG2rsPatmbpkhXwM7OHrJx9+pL6eMmrq/savWS/PLeq6crc1EYQowq3SSLeXN88osYWi4P3eCK9ESmFGH2EjPj1xFhBnJZ5zVFy+KFp7UX4nG9dGBgEuKUBA60YIxwDOw9t8CvwIke26Hb6dZk0rY0kTUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036444; c=relaxed/simple;
	bh=BSW9VlWy7RGXWGfVtlph3tBzT27DKzeu81yVoq7tL7k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IzLg0oSdp8a55CekOsXNbS2Gydt7Qw6RMl51N1t7Rw0H+LwZCRogpZDpuOrdjCmWCV+PMT4U9Puc4D0sqAH2maprCZHtSOOEEOm2E1l0E+hX0YScOVahKLcBA6+3Jz5WkWI8t7EPOJpL/fqOMYRz2tSI27R+HDPrhjiSCIcRXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHufdsZF; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHufdsZF"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1959416a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786036442; x=1786641242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIsR1jQAsco29/Iy31lyCdc88bdktGG5sWNT7XHMcn8=;
        b=eHufdsZFgaAm4KP6XTnpdU11Gbnc19hoo8ZG4VeRli01yLDu64dAG0skFD7drZiIgg
         Fi9Pt6QY00UvsMD+45iM7/huDwHD+nKqsZdunss8sq3aoYw71FH17o5Adezeett8ASZm
         5+MtgMISOT8iLWSIr5m3lM+cmYvub3gIado154ZDwA2ESQAArRmGPeFHXWrhC3UR4Z/0
         E9c2v+KjxMDpQ1qd4ibTcjwsHUYr5nZEABzH8A19wuQtE0JpcNySkFO+MfVeUtxcf9Kn
         ky61dVMdV/swjSL98i4IJedN5dFSyQF18+7aemyEX+tJKnQFAAA7lN+b8lQYbeBdKhoC
         LB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036442; x=1786641242;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nIsR1jQAsco29/Iy31lyCdc88bdktGG5sWNT7XHMcn8=;
        b=oZRZoulCNfq3J0YjKBITMABa3kQ9Dv5hbxgvKZdzY2Sm6Ai9B6n4SYRSqPYpshEgoV
         Qg2rQA5bR6oY4puEfHXZubJhxBSD49m3dIjZgGxSx9eV57kmxAQYKCh349k1F9Va4/72
         929oApKdklBVFkCu8vK9tjPmVwopbUnzSEPJdL9vUnHpG4Avpy5BV57XeES35we52K2u
         NOtM0bgG2k2SZXf4fd+Dwd6R+xK1s9FC+qBBnQIlVkR7D6eWeSt2f4fQzxBDbvgUy5l/
         Ex0sSj80gTBf+uqRomUY5bJoB/9LSliQSxiYucaa0GwiYuRMmugWNUnpwdf7KaxFGwE6
         uoTA==
X-Gm-Message-State: AOJu0Yzg72mGTtRgiyVAm/Dg+GxH+nVjzhXjoKcyzx4TV/kjLdShitwc
	UEpJIvKfeQKUZeiFvxEwh1zbqxCZ3Nj37YNW85sK2cRm49aFdO2AV5iNw6cxCgCRyI7uZeJj+84
	nVS/O7A==
X-Received: from pfbgo23.prod.google.com ([2002:a05:6a00:3b17:b0:847:87ec:2a9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4507:b0:842:6004:3fd5
 with SMTP id d2e1a72fcca58-84f4fe9f556mr3837725b3a.25.1786036441692; Thu, 06
 Aug 2026 10:14:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 10:14:00 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806171400.4119301-1-seanjc@google.com>
Subject: [PATCH v2] KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a u8
 to drop dead BUG_ON()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Track the vector associated with KVM_EXIT_IOAPIC_EOI as a u8, as the vector
is zero-initialized and is only ever set to a legal vector.  I.e. unlike
many of the other vector variables in KVM, it can't be -1 (and can't be
greater than 255, though that should hold true for all vectors in KVM).

Drop the now fully dead BUG_ON(), which aside from being completely
unnecessary, was also useless, as it wouldn't guard against a negative
value, i.e. wouldn't detect KVM's magic -1 value.

For all intents and purposes, no functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Use a u8 to make it impossible for the test to be out-of-bounds. [Paolo]

v1: https://lore.kernel.org/all/20260618185515.2021642-1-seanjc@google.com

 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/lapic.c            | 4 ++--
 arch/x86/kvm/lapic.h            | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 3 +--
 arch/x86/kvm/x86.c              | 1 -
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 283847619ff8..9614314fd237 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -973,7 +973,7 @@ struct kvm_vcpu_arch {
 		bool pv_unhalted;
 	} pv;
 
-	int pending_ioapic_eoi;
+	u8 pending_ioapic_eoi;
 	int pending_external_vector;
 	int highest_stale_pending_ioapic_eoi;
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 586a5cee29e1..87bb8e5f4ca1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1552,7 +1552,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
 	return test_bit(vector, apic->vcpu->arch.ioapic_handled_vectors);
 }
 
-static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
+static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, u8 vector)
 {
 	int __maybe_unused trigger_mode;
 
@@ -1622,7 +1622,7 @@ static int apic_set_eoi(struct kvm_lapic *apic)
  * this interface assumes a trap-like exit, which has already finished
  * desired side effect including vISR and vPPR update.
  */
-void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
+void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, u8 vector)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index bd1098c89d99..db071d0b172d 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -177,7 +177,7 @@ u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
 void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data);
 
 void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset);
-void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector);
+void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, u8 vector);
 
 int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr);
 void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..c1fdfccd20fa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5886,10 +5886,9 @@ static int handle_apic_access(struct kvm_vcpu *vcpu)
 static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
-	int vector = exit_qualification & 0xff;
 
 	/* EOI-induced VM exit is trap-like and thus no need to adjust IP */
-	kvm_apic_set_eoi_accelerated(vcpu, vector);
+	kvm_apic_set_eoi_accelerated(vcpu, exit_qualification & 0xff);
 	return 1;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d94b59140c45..8b23f342a1fa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8151,7 +8151,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_NMI, vcpu))
 			process_nmi(vcpu);
 		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
-			BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
 			if (test_bit(vcpu->arch.pending_ioapic_eoi,
 				     vcpu->arch.ioapic_handled_vectors)) {
 				vcpu->run->exit_reason = KVM_EXIT_IOAPIC_EOI;

base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
-- 
2.55.0.679.g6767b8d81c-goog

