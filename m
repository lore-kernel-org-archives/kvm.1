Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950C34F255
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804635; cv=none; b=ieE+R14g1DfnWxRR/6Gyaatt9w7GqVO1zC0vpoZELbf3/59v97cnCv7myc9PvTYK/RQdSa+1qKqQSY8YkW8nLuh+50i4jp5pOV4ivw1Dpe2ETtzsKzZOani6uRd0w5QdF4Rjc7qbe8shimJWSZBcu1Es0LT+coX8+KD4lY86kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804635; c=relaxed/simple;
	bh=HzxG+i3uTWwjYIX2vizOWA7dQVEPzs8eRhTLwH/Cadc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B9mKovAMiOXmM3jkoPPf3Net3y6UZYg/BBP+cVch5xofetkOtVTi8ec4V77hkcoB0f0KviO9TDYZ1F5s9zonUQLBssmAi5jRI5df1E2pl5jinH9p1p459lUxRTzHCdXafn/u2WAj09dsA2Elcp9MwYrD9NCbWkW/6xldnkNhUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hkCEaQho; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkCEaQho"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso28668785ad.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781804633; x=1782409433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RScD2Zz8PI9MPjNsr0Z+oEb7e4vOkPNgBdl3z32Si0U=;
        b=hkCEaQho86+mxwPjoj18y4E2+3Eyj/JTKNGKp0XeDAcdHqxizJW0u469i1AOuRfK4l
         FN1nnkg96c0koIXun+c7Dx6RZ1dKEtgGYyhz9PIwZkou0ge9h4I3LCAFdJIFCuPBrNse
         jBS0YkgSA4g+QqTGj2/IdjFceHJSyWI5W8k/je56EpWJT18bjkZ1h1CjLY9mI2dtK6yQ
         J1aMnuDJ1JNfLMPS1fEZEKAOtNQQF5pAgKBjGw5BMWghcdeefWts2C/7LaPplIM/jNeP
         1T3f4hQ6YusR4kvQrsRCyt34kngmwm5JUKtj3QwpcNJNxgxcOMHVi9kGgf26XgDUWILj
         c6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804633; x=1782409433;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RScD2Zz8PI9MPjNsr0Z+oEb7e4vOkPNgBdl3z32Si0U=;
        b=Rzs0RQs6YORFSNDeSIGaN8KaNkN4ZuironYBN+D2nBU6j2M/OEJV4XQbEqP1j161w/
         m9utYR3K42m/XhZD7OcP6LUXX1uLrVWtiUT37mxgpGQ+/LGlciSk5uStOmj21QklT07e
         dmGx47N7IuUHTMtJDugUn97jjTBxRp1nGMUOc0QC8AOM3Je5q6GV0s7o2020xEuZSGj/
         EGQcNiQWYEoad05Tizgq0AL5FMiGt8H9WWWheZfLVBiokYy/tv1G3DJvydkAK5XrUhep
         EZdw691zzOu4gYPeesOHGR3kdRof7JnA5eC9W6S8/MicqyFCjayKX93IaXBWfchKADZW
         OO0A==
X-Gm-Message-State: AOJu0YzRP/zmUuyhArBgk/m3kdPrqKucMmrr8NFbvFv2PcsjtNTKfX1C
	j/GgZT9iN5AJg5T6XvQVjX2U3kZEd8XJ/Ns9kEY3RngF1CBuHZMAgzx+Ri9p0V9nrR+m7C+4xXX
	EHi4Afw==
X-Received: from plzv4.prod.google.com ([2002:a17:902:b7c4:b0:2bd:40d4:e407])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b8f:b0:2c6:b816:43ba
 with SMTP id d9443c01a7336-2c718f60988mr2204475ad.21.1781804633284; Thu, 18
 Jun 2026 10:43:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 10:43:47 -0700
In-Reply-To: <20260618174347.1981064-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618174347.1981064-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618174347.1981064-3-seanjc@google.com>
Subject: [PATCH v3 2/2] KVM: x86: Unconditionally recompute CR8 intercept on
 PPR update
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot ci <syzbot+ci493c6d734b63e050@syzkaller.appspotmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Carlos L=C3=B3pez <clopez@suse.de>

The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
when the guest's virtual TPR falls under the specified threshold,
allowing KVM to inject previously masked interrupts.

KVM handles these VM exits in handle_tpr_below_threshold().
Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
optimized this function by calling apic_update_ppr() instead of raising
KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
a pending, deliverable interrupt.

However, if there are no new interrupts pending, apic_update_ppr() does
not issue the request. Thus, kvm_lapic_update_cr8_intercept() and
vmx_update_cr8_intercept() are not called before VM entry, which results
in a high, stale TPR_THRESHOLD. This is problematic due to the following
sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:

  The following check is performed if the =E2=80=9Cuse TPR shadow=E2=80=9D =
VM-execution
  control is 1 and the =E2=80=9Cvirtualize APIC accesses=E2=80=9D and =E2=
=80=9Cvirtual-interrupt
  delivery=E2=80=9D VM-execution controls are both 0: the value of bits 3:0=
 of
  the TPR threshold VM-execution control field should not be greater
  than the value of bits 7:4 of VTPR.

This error condition is typically not observed when KVM runs on a bare
metal system because modern processors support APICv, which enables
virtual-interrupt delivery, and which KVM uses when possible. This
causes the processor to no longer generate TPR-below-threshold exits
and to no longer check TPR_THRESHOLD on entry. However, when running
on older platforms, or under nested virtualization on a hypervisor that
does not support virtual-interrupt delivery and enforces this check
(like Hyper-V) this can cause a VM entry failure with hardware error
0x7, as seen in [1].

Call kvm_lapic_update_cr8_intercept() if apic_update_ppr() does not
find a deliverable interrupt (and thus does not raise KVM_REQ_EVENT).
Remove calls to kvm_lapic_update_cr8_intercept() on paths that end up in
apic_update_ppr(), as they now become redundant. This ensures that any
path that updates the guest's PPR also figures out if KVM needs to wait
for a TPR change (using TPR_THRESHOLD on VMX or CR8 intercepts on SVM).

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 ++
 arch/x86/kvm/x86.c   | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9d2df8623f6d..f6a289d01a26 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -980,6 +980,8 @@ static void apic_update_ppr(struct kvm_lapic *apic)
 	if (__apic_update_ppr(apic, &ppr) &&
 	    apic_has_interrupt_for_ppr(apic, ppr) !=3D -1)
 		kvm_make_request(KVM_REQ_EVENT, apic->vcpu);
+	else
+		kvm_lapic_update_cr8_intercept(apic->vcpu);
 }
=20
 void kvm_apic_update_ppr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..96c465040756 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5317,7 +5317,6 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *=
vcpu,
 	r =3D kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	kvm_lapic_update_cr8_intercept(vcpu);
=20
 	return 0;
 }
@@ -12418,8 +12417,6 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu=
, struct kvm_sregs *sregs,
 	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
=20
-	kvm_set_cr8(vcpu, sregs->cr8);
-
 	*mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
=20
@@ -12448,7 +12445,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu=
, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
=20
-	kvm_lapic_update_cr8_intercept(vcpu);
+	kvm_set_cr8(vcpu, sregs->cr8);
=20
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) =3D=3D 0xfff0 &&
--=20
2.55.0.rc0.738.g0c8ab3ebcc-goog

