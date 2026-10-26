Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038143;
	b=30aNX32FklKvE+Ye87VnqflRRljRDSNgkxuF/AP9I+bcgUUJXBHfYY8tCFOO6D79FCll
	 4hkH4nYDCxgMgWSic6+jPRizUfo/t3tOrY/M3Gn8iYJPn0kE5M8AmXJmpj9SPU1N3A9bE
	 4jRf6F070kPvEqFQia1oBBJCG5NcQNaDcYdpAj2qmmki8pa5vB+x97xgqd95fKZYGT9P6
	 rUzlDnEWX9eB6YSCgw237z0jN4tsnp4yzt32qfu5I9y1duwyh+S4V2k/q4aA6WUMG58O8
	 pdcS4drsoglXDUI5gD+3do5yZ+2KF4cbqyqDyJ5WI4IrfsA4Pw4nai9mFhU0AiMxTVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Kv2U2+i5YrqjHvWntz1heOg13a9Ao3/MyitVnANiQ8U=;
	b=1Xcfman3dMcGLaId8RTLSgHMiqwDUlh9U/fDj8isR0NfwrsD2cPuX7cpF2f/FsGcsga4
	 6JW3cDCvN7Vk4lnlbWilDyEm56zfTCEHT/+5pcopAEKwQqOMXzvVd+dzUBXcli4/gU788
	 y9OC+Sw0gMT3av4KCCCDvrcfYBJ6SA6QfvE8C+ugB/U6qyR3kUDkvWZF5UKGkk0cjWKgQ
	 mLRfQ9y2wXDADRXdt/i8DJr9Ek0oHKLcA747/z48uGQRK9eW0JFOzTOuE2fQPRzaotRGG
	 YP1kA/of7nR0eGgzy9o4FbQgHm5Dfh0QPIDveegiGkmvhOjX+Dp/oiuEEwYPq+Vyydg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DliIvp8x;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB2606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AAB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DliIvp8x
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd633da24f8so4090219a12.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793038143; x=1793642943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kv2U2+i5YrqjHvWntz1heOg13a9Ao3/MyitVnANiQ8U=;
        b=DliIvp8xZwpCxeLLbBVKBwCxl2+BnJZFfJHB/KWvUEynbKZCZbWe79Ov2VoPuPv8Ed
         pOkbuPHUm4UCT7u0riygjKSELjlVmlHUkVuF05jtyZdd64N0yu/MvmviC1KO9M7xPXz3
         hvZW2bVQFeuzhfeaQ+zvHtMJIdeZRqfbHtW/7ZVygJ7vAlWtYQa5PEr69Tg6bdedi4MK
         ZWcdkKBr1C5yiPGKVmqpJyZxyypLqa60E4Rz5rg55tlz5h1YCM0IuQ4OuodPq0/8IPbw
         zIXvdG2D0Mka7oR7LfOSwBPJnfFpSHg6ukRXPRbH/XGArqGqhe68bCR7D7SSuHCPcD9F
         rGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038143; x=1793642943;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kv2U2+i5YrqjHvWntz1heOg13a9Ao3/MyitVnANiQ8U=;
        b=HVzKHTzvMEcw4r8IXH+Fp4AXZ5G9jPW7SYVfuw3jyTlSluX8+ME33mFyArFm3sQciC
         N3Le6HrgAEInXbSBHxgLdznJGz54yWTKj9/Wymc7Gt+v3EKAsddVXVsxQMFy8EJhyi8i
         KzUIP0r7Q1w1nQOnLsykv7/2k2mgMc3A8NLLg1MrvAKxhQ/k4HG4hUnRxzlL9uaYAYm3
         hh+3wLwmVomPGDGDp8tJFKhv/T0iOkSvTBvQw+c5QG/TIjDDdg2MYu1EEUkUJ5YXzxp4
         Xc6JMCXS9IFW1EIU8YWtCAPrnsd2LHymSSXWXAlZ6DqBOKIsvzYD8BKUr1di4Byx/QOg
         EC4w==
X-Gm-Message-State: AFq9FYJKYaB90LhILrqZS0lvLDVesLM8fsyjUCFZ/nVWZTr3V53YlG1s
	PGV0075WIXkyOWS6MqBiPn9oIFR2w8lECUn1PjBIonatWJhtPX2Y2Ud0Mt6fn1jjnsQDEVIEF4Q
	sisXF4w==
X-Received: from pgli22.prod.google.com ([2002:a63:1316:0:b0:cd7:f985:396d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8e:b0:3e1:1db7:7608
 with SMTP id adf61e73a8af0-3e7cd5ee414mr6775984637.54.1793038142494; Mon, 26
 Oct 2026 11:09:02 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:09:01 -0700
In-Reply-To: <at-TP7Il6rWcd5Xh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com> <20261022223052.646891-4-seanjc@google.com>
 <sashiko-outbox-182134@kernel.org> <at-TP7Il6rWcd5Xh@google.com>
Message-ID: <at-XPai1zCM_Zr2z@google.com>
Subject: Re: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 26, 2026, Sean Christopherson wrote:
> On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> > Because svm_set_cr0() sets EFER_LMA without checking is_pae(vcpu) (for
> > example on an SEV-SNP AP created via SVM_VMGEXIT_AP_CREATE where
> > sev_snp_init_protected_guest_state() calls kvm_vcpu_reset() and clears
> > vcpu->arch.cr4 while the VMSA has CR4.PAE=1), 

Wait, no, kvm_vcpu_reset() also immediately clears EFER:

	kvm_x86_call(set_cr4)(vcpu, 0);
	kvm_x86_call(set_efer)(vcpu, 0);  <===

and svm_set_efer() sets vcpu->arch.efer verbatim.

> > or if a guest clears CR4.PAE observed via cr_trap() while EFER_LMA=1,

And I'm pretty sure Sashiko is wrong on this one too, as this can't happen.
Clearing CR4.PAE while long mode is active results in a #GP, and hardware should
enforcee that when MOV CR4 intercepts are trap-like.

So I don't think the vcpu->kvm->arch.has_protected_state waiver is needed (though
I do think it makes sense to WARN and continute, not WARN and reject).

> a subsequent efer_trap() ->
> > set_efer() sees EFER_LMA=1 with !is_pae(vcpu) and triggers the WARN_ON_ONCE()
> > and #GP.
> 
> Ugh.  I _want_ this to be a KVM bug, e.g. as is already pointed out by the comment:
> 
> 	 * Clear EFER_LMSLE for a related reason: EFER writes are *trapped*,
> 	 * not intercepted, i.e. hardware has already committed the write by
> 	 * the time KVM gains control, and the trap is enabled if and only if
> 	 * the guest is SEV-ES, whose EFER lives in the encrypted VMSA and so
> 	 * can't be fixed up by KVM.  Rejecting EFER.LMSLE=1 would inject a #GP
> 	 * *and* leave EFER.LMSLE set in the guest, which is strictly worse
> 	 * than honoring a write that hardware itself allowed.
> 
> "rejecting" a value and injecting a #GP is completely pointless.  The guest already
> has the "bad" value in EFER, and a misbehaving guest can simply eat the #GP.
> 
> But the issue is really just that KVM simply doesn't have visibility into EFER.LMA
> being set.  Heh, which technically makes this a bug fix, since IIUC, the current
> code will never set EFER.LMA in this case?
> 
> I can't think of any way to do the right thing other than to rely on hardware to
> not screw up?  E.g.
> 
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 41f3ec6eb286..3a6a0ebf1932 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -648,7 +648,8 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	 * it means KVM allowed architecturally invalid state at some point in
>  	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
>  	 */
> -	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA)))
> +	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA) &&
> +			 !vcpu->kvm->arch.has_protected_state))
>  		return 1;
>  
>  	r = kvm_x86_call(set_efer)(vcpu, efer);
> 
> 
> Hmm, though all of these cases make me wonder if we'd better off with just a WARN,
> i.e. no #GP, since the goal is to enforce a consistent model, which is what the
> new code does.
> 
> 	/*
> 	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
> 	 * it means KVM allowed architecturally invalid state at some point in
> 	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
> 	 */
> 	WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA) &&
> 		     !vcpu->kvm->arch.has_protected_state);
> 
