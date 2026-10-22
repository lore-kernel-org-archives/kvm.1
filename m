Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706722;
	b=mrLLLA2Y2AltjCLuWsDwLsqMOsu5BDVGVrdSgOptgcjkxp9hGchIBaK7h9KZSCk3/Apo
	 yt2yIoRA95fZDAt9fLxVusx0+nGLrdeiEKo0LVwANR/cZM8kalw2GwFbTjlb9YCTcvfOu
	 0j0P38gflX8kP8ilJf2k+7tcJwXmUdhFCcRJMB/E9ewBE4muYFiQSPD7IpFjZh9QbDooJ
	 TU70cFcmsQVHaw+1XncJB78hvta3UOZtLY39UPPy5srzSqj/lNRZoCfOloJ3oEUZ44kkt
	 SuJCrLPwBuP2jlB+gR7yKYjSLXqrSwqkDRILGZ/+kc3+Jk6m/lnqecSoPKOkQv+mogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=aQpldUTNn86Cmtvp1C0Vo7oleaHSSPMS8g9EH60UkDA=;
	b=oOqo2kOBiMPYRhruyQaOf7tEVdX7WL5Zr3ZiS1ftF8op7V4pvBJuq++TsQ8c/ZdtdrIN
	 aZvR1nDSMsVKgYroJH67hPojLwdqRDpNN/q0SluOfYM+wS3xX0aA2Ys304uopNGRjdyO+
	 ba3GUIsU6m1DeIYRzFHaIFlQzY8uq6LI51XAvNvu6KhgjvrsTMSU/ybe79iYa0LMmI7Mc
	 v9XKKwIDKwwRO7R18vHaHEryvu1PgLls3UOxLNvq2y8wfUBDCqjT+/uBh9sJawo1f3qBz
	 zKU3Nxt+Gq57hBrsJwfCCA4himYoy7LInn8gvazAwkTzcO3wH+tDp11YYdWFfcYBN0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QjtnJFAY;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754B606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B754B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=QjtnJFAY
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so257908a12.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792706721; x=1793311521; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQpldUTNn86Cmtvp1C0Vo7oleaHSSPMS8g9EH60UkDA=;
        b=QjtnJFAY8XAekJ/ry4lFkR9KEBNydS5VRmso3sdF45KaYhNzRUMjpwyPuunJ52Tgrw
         WoVob114ekgN69uONTSS8z727ihN5IDTNzE1tKGT8qa4wvWYE8OOOy71MrjEGRSSwOsg
         77/xb6XW5zCEI7+BnAhhl5mSM+DpeH4aZQduSAs4p8jN0GhgbVHOu2Zea91i5HCaqG1U
         jcwVEhatqkRBv5NypM3+K0btJUUgBIFdTOdAGWuKFqn03kMA64ls3u7ClJptevgqQD6b
         EscZo9wimuQSBWLOat38gi6e90A/EJvEQ+kckwy/iB9m/7vIKss3mhwxlUQ7A0aNsckb
         xOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706721; x=1793311521;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQpldUTNn86Cmtvp1C0Vo7oleaHSSPMS8g9EH60UkDA=;
        b=JA0qKXAk3X/JgGf3eQ14+BW0PtPe22iWmahZev5IO2oCo2/dQpT6UWlJYhDrRF39lX
         60q0GCKcdd3oJKeCmljVn4Eo/FoIx5i26xyfjiZPALZb4RTY8dzDfwQvzbZICWedheX5
         C3DQcUAkUjnYJV5zCgSYGU91N4YD6S/pnRjlTR2S9zB1IfB7UNHi9XbQ9hhE+qmxueil
         tAax2c6auJDOqTyp77Kw32FMgcwe8W6o7Cgb0MgG/6m/Zt8M9G6j0SHN5aiSODFJsYuR
         g051b8MJC/Fj5wREAyjNR1gJAq7SI/H4pB37K4w+VPuRd6cNtFeOK7l/Bj4Pe7GwdrlC
         3S3w==
X-Gm-Message-State: AFq9FYKwSY4R+563dlTX5ctvEAi8+xVe8JtLGyfrRrByyoSytIm5JANy
	tqKKuCOIV3qImoIYCIR4Ao60JkRxRNTcw5P+ed25MMY1ECbS5XLH1U2MBOZRg9pVtFspn96yDJ0
	xqomTiQ==
X-Received: from pjnz3.prod.google.com ([2002:a17:90a:8b83:b0:3aa:ff61:94d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac7:b0:3ac:ba49:2fed
 with SMTP id 98e67ed59e1d1-3adce874318mr147979a91.58.1792706720890; Thu, 22
 Oct 2026 15:05:20 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:05:20 -0700
In-Reply-To: <sashiko-outbox-182093@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022215541.631694-1-seanjc@google.com> <20261022215541.631694-3-seanjc@google.com>
 <sashiko-outbox-182093@kernel.org>
Message-ID: <atqIoDulcBpCyqFL@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Convert all runtime WARNs to ONCE variants
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 44dad106fad19..945efc1cfaea1 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -1368,7 +1368,7 @@ static bool __kvm_tdp_mmu_age_gfn_range(struct kvm *kvm,
> >  	 * this helper must NOT be used to unmap GFNs, as it processes only
> >  	 * valid roots!
> >  	 */
> > -	WARN_ON(types & ~KVM_VALID_ROOTS);
> > +	WARN_ON_ONCE(types & ~KVM_VALID_ROOTS);
> >  
> >  	guard(rcu)();
> >  	for_each_tdp_mmu_root_rcu(kvm, root, range->slot->as_id, types) {
> 
> [Severity: Medium]
> Should the WARN_ON() in kvm_mmu_uninit_tdp_mmu() in arch/x86/kvm/mmu/tdp_mmu.c
> also be converted to WARN_ON_ONCE()?
> 
> arch/x86/kvm/mmu/tdp_mmu.c:kvm_mmu_uninit_tdp_mmu() {
> 	kvm_tdp_mmu_invalidate_roots(kvm, KVM_VALID_ROOTS);
> 	kvm_tdp_mmu_zap_invalidated_roots(kvm, false);
> 
> #ifdef CONFIG_KVM_PROVE_MMU
> 	KVM_MMU_WARN_ON(atomic64_read(&kvm->arch.tdp_mmu_pages));
> #endif
> 	WARN_ON(!list_empty(&kvm->arch.tdp_mmu_roots));
>     ...
> }
> 
> Despite having uninit in its name, kvm_mmu_uninit_tdp_mmu() is not a
> module-exit helper. When tdp_mmu_enabled is true, it is invoked per VM at
> runtime during VM teardown (as well as on the error cleanup path of
> kvm_arch_init_vm()):
> 
> kvm_arch_destroy_vm() (in arch/x86/kvm/x86.c)
>   -> kvm_mmu_uninit_vm() (in arch/x86/kvm/mmu/mmu.c)
>        -> kvm_mmu_uninit_tdp_mmu()
> 
> Other VM and vCPU teardown checks, such as sev_vm_destroy() and
> free_loaded_vmcs(), were converted to WARN_ON_ONCE() in this patch, so
> leaving this check unconverted allows repeated warnings on every VM
> destruction if kvm->arch.tdp_mmu_roots is non-empty.

Gah, yes.  For some reason I was thinking that was a module exit function.
