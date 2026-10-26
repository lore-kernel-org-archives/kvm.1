Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038674;
	b=0axjd87f8H7/oK+Lzy8eH3AgSqtEwJq2gfovHgSg8DyWp3BMh70UjUQGF15aU06YtUOX
	 SG/sk4SlbBzS3Qc2V+JbyGkNIiA1bbM5cP1yX6mf7mYWaV6JSrnHg5SwZuxwLQ7OmYrvF
	 5yksyqwJpq2+wZ/PAPKXwcP6NkD8ldFT+YLmGxfKN786fkWSCR5KvGy9lsGC0JqzG4KEt
	 V+dVd9Did5d/Klf4vBu5thE2+cAT1SlZpv2L1pJlzBbkUQRBky82Z3o4tIJQD+k7DpnOA
	 U2vR69SvisfpmF2NcX1c73JpzXnyArsxAoMtN5XzOvNAMdc29P7GnAClhU+SMBqdjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+810WkircImBIe3VU71W9hrmgj4SH7ngZDsWYJv5UyQ=;
	b=WTx1qZQOQFB8G5xwAE57B6Wr/W9OVWfygXG6kIABfeEiueDckBSIuVcuWSoteKxyNcrW
	 XzlBZBAsnBMu7m5V3oLZiV3spXp8BmsiU9qQDtmEbxKyjkHstndY/HX/B6HSFzVCpFbB5
	 DDwT/INtfptIQoBa8vKrrH/THJxCK7Qm5r6GsX4uWv5VRctHUO6qafsu1XGfH2I2dkYbt
	 7I3kwc76ejjSQ2Z0zVeM2yhJy42vPkLKYrPXAcHenyBP8WSyS9eGEqbUyBnyPdx+p3Aag
	 2faokzznrmAq7NiSPgPOmq2L639OODololnzTpMrHmHTE5OCSVQla7hqqv//MoyPE7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UoJxOcsh;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C105606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C105606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UoJxOcsh
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eabb908860so13966595ad.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793038674; x=1793643474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+810WkircImBIe3VU71W9hrmgj4SH7ngZDsWYJv5UyQ=;
        b=UoJxOcshHws/CekYQMajqLwyRp0BA+gyagwDM7+bUxvICAMK+hl7/F8c02JXAjV1Mc
         4npaV41Z3Twk1FGoa0Wg3Q2db6coTA8OOVco8XS7PyQCeIwJYcAkQkoemYwzTVP2vxlI
         HC/9gWZRBQQCVkQefwQoCvys9/bSJwmcwitpZk9EnLNog6h6yO1jGhGZdwc/7ci7QKzK
         naaVLfKQPNiiqxxixwYewZenIUdDuhKeIWoDy9PYTU5sZE767es8LsjVkE1wY+dyc10V
         m9BeYbBi1u89/WMGnA+K8os8FmxT5t1SZxlKa+3IXlDCG/v3QvkOTOoMfs16mMQWj/Z8
         ni5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038674; x=1793643474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+810WkircImBIe3VU71W9hrmgj4SH7ngZDsWYJv5UyQ=;
        b=Lh3J+JRllelic6Tq/LFQjocVISx+zvtqmMshOsyb1zcHjrl/ILraa58SlipRxV2bBD
         W1I1n/7wm/S6Kq+I8owAvHTk5FJHMlhjFeF4uUqUAWm1spSAngsCP3rpEnVwpX/RMlWx
         RilzuXuCqJktMp1Ub2qB5v0jfm0MZpEsqaZsTEbQ2IguuPhxw8xqQtaeQGBg2MOnEfrh
         rT5VeO3/99lHSGFm8hJqh/Q8IzP01m4Mp5Lx4lnlo2iNr2tYxtN8KcO2gh4QZNaWo+/D
         imX4DycyQnlP9pN3DbpCz2pKhmdktkKzco8lqpWsWQcaAWvXgCwoeUsVt3bBZPmRyQuc
         JGIg==
X-Gm-Message-State: AFq9FYKTAxD8i2kBIxLLwL55uX6mEM5FUsc+KCL9SXNhoSK8VEZT/WWY
	+IQeyU+Z954nGvMK4FVq6IXvC45qt59o+OBBaEdtd0PwDOD3fh7uI8cWnbVjHIuXPDfz2Nm06U5
	3HP/i4w==
X-Received: from plso3.prod.google.com ([2002:a17:902:bcc3:b0:2e9:4eb5:953d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40c:b0:2e9:c569:7050
 with SMTP id d9443c01a7336-2ea9c839fcemr62722095ad.47.1793038673423; Mon, 26
 Oct 2026 11:17:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:17:52 -0700
In-Reply-To: <sashiko-outbox-182127@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com> <20261022223052.646891-3-seanjc@google.com>
 <sashiko-outbox-182127@kernel.org>
Message-ID: <at-ZULrPFH0XoCrM@google.com>
Subject: Re: [PATCH 2/4] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2
 attempts to clear EFER.SVME
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 487897ef11dd6..a6ff9635677a1 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -227,17 +227,12 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
> >  	if ((old_efer & EFER_SVME) != (efer & EFER_SVME)) {
> >  		if (!(efer & EFER_SVME)) {
> >  			/*
> > -			 * Architecturally, clearing EFER.SVME while a guest is
> > -			 * running yields undefined behavior, i.e. KVM can do
> > -			 * literally anything.  Force the vCPU back into L1 as
> > -			 * that is the safest option for KVM, but synthesize a
> > -			 * triple fault (for L1!) so that KVM at least doesn't
> > -			 * run random L2 code in the context of L1.  Do so if
> > -			 * and only if the vCPU is actively running, e.g. to
> > -			 * avoid positives if userspace is stuffing state.
> > +			 * KVM is supposed to synthesize #GP if L2 attempts to
> > +			 * clear SVME.
> >  			 */
> > -			if (is_guest_mode(vcpu) && vcpu->wants_to_run)
> > -				kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> > +			if (KVM_BUG_ON(is_guest_mode(vcpu) &&
> > +				       vcpu->wants_to_run, vcpu->kvm))
> > +				return -EIO;
> >  
> >  			svm_leave_nested(vcpu);
> >  			/* #GP intercept is still needed for vmware backdoor */
> 
> [Severity: High]
> Can userspace still reach this KVM_BUG_ON() during KVM_RUN via
> KVM_SYNC_X86_SREGS when a vCPU is in guest mode?
> 
> In virt/kvm/kvm_main.c:kvm_vcpu_ioctl(), vcpu->wants_to_run is set before
> calling kvm_arch_vcpu_ioctl_run():
> 
> 	vcpu->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit__unsafe);
> 	r = kvm_arch_vcpu_ioctl_run(vcpu);
> 	vcpu->wants_to_run = false;
> 
> Then arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl_run() syncs dirty registers
> from userspace while vcpu->wants_to_run is already true:
> 
> 	if (kvm_run->kvm_dirty_regs) {
> 		r = sync_regs(vcpu);
> 		if (r != 0)
> 			goto out;
> 	}
> 
> When KVM_SYNC_X86_SREGS is set in kvm_dirty_regs, the call chain
> sync_regs() -> kvm_run_sync_regs_from_user() -> __set_sregs() ->
> __set_sregs_common() in arch/x86/kvm/regs.c bypasses set_efer() in
> arch/x86/kvm/msrs.c and calls svm_set_efer() directly:
> 
> 	*mmu_reset_needed |= vcpu->arch.efer != sregs->efer;
> 	kvm_x86_call(set_efer)(vcpu, sregs->efer);
> 
> If userspace clears EFER_SVME in vcpu->run->s.regs.sregs.efer while
> is_guest_mode(vcpu) is true, wouldn't svm_set_efer() trigger the
> KVM_BUG_ON() and return -EIO (which __set_sregs_common() ignores) after
> already updating vcpu->arch.efer = efer and without calling
> svm_leave_nested(vcpu)?

Oof.  I think the right answer is to straight up disallow that?

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3621f1a47d37..e53496fdeb82 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -738,6 +738,10 @@ int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu)
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_SREGS) {
 		struct kvm_sregs sregs = vcpu->run->s.regs.sregs;
 
+		if (is_guest_mode(vcpu) &&
+		    (vcpu->arch.efer & EFER_SVME) && !(sregs.efer & EFER_SVME))
+			return -EINVAL;
+
 		if (__set_sregs(vcpu, &sregs))
 			return -EINVAL;

Ideally, kvm_is_valid_sregs() would disallow that, but the risk of breaking
userspace, e.g. on save/restore, is too high.  Whereas I really, really hope no
one is using KVM_SYNC_X86_SREGS to yank the vCPU out of L2 during save/restore.
