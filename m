Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE2412C17
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764136; cv=none; b=k1jDdszway1S8l3J7Q7ApfkhO9EyKwDidtVuQ2GJfkaUMwhOSjYA7aMkhrMiBpHHg8zcYasDkBexHzUk58Kdyk+1uGtqO7aq0oqKSBTy3DjRFrgNwiPH1+BJIpXq49JkjYWDlkyoMPV9amPTH4lrItvd90++E+TkCqL9SlZd9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764136; c=relaxed/simple;
	bh=5gcZCxVaLoGbFtuUTVs9uf2JJcAHrT7H1feMiJ8kezI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ldVnsJHc8OoHuKWoM16UY/9gN6d05SFCEwTp+4EODBni10TAuCw4iSIHwi2FO+vhGuAuh8gV7AAbUhzvwkBeamh6gO01MljiHFql3rH0iWi8masuMUP8/fFDy1ZStnQUsfceL3Z0X/9pFpyfjFX+hF1aFWC4Wmdt33NaGM8Hjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuIbT+zf; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuIbT+zf"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d5d00fd19bso23952575ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764115; x=1788368915; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dR4gFAPNlwUIZIAyQcENnxSzx6A0fm/I/dCW7TyYhXo=;
        b=cuIbT+zfQloDxXI3T+3/jJObTvm0optSrXBUNt/rgta6Sqqz1gLGjfVqeAAClRusLV
         t36kczGRC1+4kB1FGdn1uA87gUK9mPS9EB3vcLaNUSUBH5OlnSJpvb7wFA03nK1ghgJr
         pAqfqQZ/25iDHzWpTsXpJ4K1G6s8ZsY2uVSCjaOJFCn3Geb0hG+GgZf+fJdF5HQEh7+O
         aiR9onDktq+1AtA0uGPrHvH4xJ5gKKPn3lyd5pv4Y7U+p7bq/iJXRmCyFs22dATHvk8j
         R4hnoEeLcFLDyPHT+5gVbAxCOMThjikdJANR3Ru9z11465muc+/tm2aDkL1FMBvTzLAI
         kdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764115; x=1788368915;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR4gFAPNlwUIZIAyQcENnxSzx6A0fm/I/dCW7TyYhXo=;
        b=FCBpPoJreKMduvUJ0rbSyv5mty2bKvd5F5FKdxPsrFhT1WedP6M1EMkCw1fuE14rvm
         IhDOYBl3+bdYgtyak0/DTg2bcTR51Q8cks05+nJzbngQiB5yl3tCVldJZnQ32zpM5aAa
         UW2N/4c7dmMNtMOSJTvAN+x3YA+xgsOHWvq85fvEduFBNcmJRViojMep33UpKgMv48YH
         kWo6eG0MjcnSz5KQUOzb95fIdugUUrPXQ4DQZLkgcvo0VTaUnpJ0loQnzf9gsBuXBM60
         ZeOt/GmnTQxXvfbj3QnxVpkeZ3ekimLvM77tJSU3xoy4XQpJt0GEnvl7KBWiMmyElIyK
         vfwQ==
X-Gm-Message-State: AFuF++nj7K+QdZREsLN0F+98pZ7yjch6NW+kfgviXiLvlvqbkYCPmiQN
	6oEewRR5YSjeiJAeYK/3HXc7Q624veTPfUDP8oy35pxwRhf27j0nFXkvGhP9oa3A02924md/Nn/
	eG36HOA==
X-Received: from pluq15.prod.google.com ([2002:a17:903:4b4f:b0:2d5:d335:6d96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:2d3:104b:1acf
 with SMTP id d9443c01a7336-2d707a8c210mr170794815ad.8.1787764114874; Wed, 26
 Aug 2026 10:08:34 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:08:34 -0700
In-Reply-To: <20260826165948.31EBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com> <20260826164214.756512-3-seanjc@google.com>
 <20260826165948.31EBA1F000E9@smtp.kernel.org>
Message-ID: <ao8dkl_JLNLpzSEf@google.com>
Subject: Re: [PATCH v2 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 3220f05387b58..1969c26861e5a 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> [ ... ]
> > @@ -5224,10 +5220,22 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
> >  			return -EIO;
> >  
> > +		r = kvm_mmu_reload(vcpu);
> > +		if (r)
> > +			return r;
> > +
> >  		cond_resched();
> >  
> >  		guard(read_lock)(&kvm->mmu_lock);
> >  
> > +		/*
> > +		 * Because slots_lock is held, it should be impossible for *any*
> > +		 * roots to be invalidated after the initial MMU reload.  WARN,
> > +		 * but continue on; the above MMU reload will do the right thing
> > +		 * if the current root is actually invalid.
> > +		 */
> > +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> 
> [Severity: Medium]
> Will this WARN_ON_ONCE ever trigger?
> 
> Looking at kvm_mmu_reload(), it calls kvm_check_request() which consumes and
> clears the request bit:
> 
> static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
> {
>         if (kvm_check_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu))
>                 kvm_mmu_free_obsolete_roots(vcpu);
> ...
> 
> Since kvm_mmu_reload() is called unconditionally just above in the same loop,
> won't the KVM_REQ_MMU_FREE_OBSOLETE_ROOTS bit always be cleared by the time
> execution reaches this check in kvm_tdp_mmu_map_private_pfn()?

More than likely, but not always since it's a cross-vCPU request.  As stated in
v1, the goal is more about documentation than about finding bugs.
