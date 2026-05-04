Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F83E6391
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919790; cv=none; b=HQl3pGG2kRrm8UMWhtQdCvGM7iCBkNhhNKU3Lafze6NERsZ7Ok9qb2yAbhdd7Rzi1goaZ1DgsB8eWuY+0+2LA6uukZMSYCVp4hZCXYdjsGO+cJpzWe6umAiKejlkzFa0LgOp/oJa3EL2YVuCrduWQQBcyDJcxPys20jbMj253zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919790; c=relaxed/simple;
	bh=QFPvIy6dlE9hXF3JqALn/T20CEYJqKHPTfb/KyZtBWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ELjmq7Nih7LnwEukiNEKEvPOq+bYYd2zfpiB3swBEkCz+feKjP9wW3Mbw5Rer7f7qb5NF+G+kmxN0HWWKMLhfvsY/tlBuiuaRGYG1pkqb8MWi6wPPYGryuTx3RYrD52FUO8VRelIq3VHjNiXAZJv9dJ/U4QVtr4n2O8PoNKjjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igQDUJKH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igQDUJKH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso41989935ad.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777919787; x=1778524587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jX6vrFPTAfudfQoypDuSTlSrBHCno/qbTt7eNIveuo=;
        b=igQDUJKH+1QmdZh4YcgSUSNrttMqt19334EgaNZGOKzZdnW4LtXxKqo2D9H5mIS3ck
         77SZb/tWE8YZYvmcfqDHHAIsv41NDJktavwIHUvpu25uqAM2QXRvw1VU//eoa2InF07Q
         PFn2Jpsh5aA3U5AEurfWoyfEs0eK2HKNuqaFXAHzQ5nlQA2U+laqlxP1O4tVYfbCq83N
         vYJxI3ooQuzHaeY5c1NEFHRFF9BDNGPGbGhp70cVAbckkJUFb6ksNwDdr6PgAr0NXyuv
         TvJY2OM3eFX7EsGkkQ6sf2Ac0jS8aTB2nYilc2vK1jS3VSCoKqD8k50fLj1JA9x8x+zJ
         Dp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919787; x=1778524587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jX6vrFPTAfudfQoypDuSTlSrBHCno/qbTt7eNIveuo=;
        b=VrfU10FVRlH/Pi6YxhjlY7WQciSgA9jSMOPCqyIgdDU/fDSuOjubcC4G3JITFdGRoh
         b+TDbNHX6lumSHjulRFuPhTOigUIXbN/ChNc6orKagUVkKc/fgmJSWUMoHHaJt9RyCI8
         piht4afy8ZakTrNBGnZqODEuj33hNN4TSJ04PvVVor+0CTan5SwbNzvBLZLULZ7Uxna/
         c/6+KqdZxfMBU0P0/5IF76H5g/VcuC5ndlq1qwqojeirDjDXRa0n6KIDuLprcR8wxgDH
         iDuB2/tadPRMuFRLZ+hzu816QrXeuEiColojC4et80lKvEr3IBwFU4sGWClD/GLSY9bX
         +n+w==
X-Forwarded-Encrypted: i=1; AFNElJ9ySoR77z8wDTaYzU46Gwyqsc2okY8+8a7A3CarGx4djMTfmMAqnjcHfL8SNha+a6FwxdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzUO7ti6XTegtO3E36fNktdR7cv3Kg9wlrROD0QAEYYhO8drq
	TFYI7hTF2vz3aEzP3HuPe3lU9nhamXK24M1drQMXu42laagrsgAiRDK4mL36u/Mbp2jr3a0plyi
	kcEXVKg==
X-Received: from pgbg7.prod.google.com ([2002:a63:5207:0:b0:c74:42:899a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d08:b0:39b:a997:9e40
 with SMTP id adf61e73a8af0-3a7f1c674ebmr10435101637.46.1777919786961; Mon, 04
 May 2026 11:36:26 -0700 (PDT)
Date: Mon, 4 May 2026 11:36:25 -0700
In-Reply-To: <afjW63q5KqkwHMK4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503210917.121840-1-pbonzini@redhat.com> <afjW63q5KqkwHMK4@google.com>
Message-ID: <afjnKSeSX2IegtW1@google.com>
Subject: Re: [PATCH] KVM: x86: use again the flush argument of __link_shadow_page()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 04, 2026, Sean Christopherson wrote:
> x86/mmu
> 
> On Sun, May 03, 2026, Paolo Bonzini wrote:
> > Except in the case of parentless nested-TDP pages, mmu_page_zap_pte()
> > clears the SPTE but leaves the invalid_list empty.  In this case, using
> > kvm_flush_remote_tlbs() as kvm_mmu_remote_flush_or_zap() does is overkill.
> > Avoid flushing the entirety of the remote TLBs unless the invalid_list
> > was populated: instead, use a more efficient gfn-targeting flush (if
> > available) and skip it altogether if the caller guarantees that a TLB
> > flush is not necessary.
> > 
> > Based-on: <20260503201029.106481-1-pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 892246204435..85bec8eeace8 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -2541,8 +2541,10 @@ static void __link_shadow_page(struct kvm *kvm,
> >  		parent_sp = sptep_to_sp(sptep);
> >  		WARN_ON_ONCE(parent_sp->role.level == PG_LEVEL_4K);
> >  
> > -		mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list);
> > -		kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, true);
> > +		if (mmu_page_zap_pte(kvm, parent_sp, sptep, &invalid_list))
> > +			kvm_mmu_commit_zap_page(kvm, &invalid_list);
> > +		else if (flush)
> > +			kvm_flush_remote_tlbs_sptep(kvm, sptep);
> 
> Duh, this is obvious in hindsight.
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>

An amendment to that: I thought this was just switching back to the more targeted
range-based flushed, I didn't realize you applied the version that hardcoded the
@flush param to kvm_mmu_remote_flush_or_zap() with "true".

If you take this through kvm.git directly, can you add this comment?

		/*
		 * Note!  @flush from the caller doesn't follow KVM's standard
		 * "collect TLB flushes in a variable to batch them" pattern.
		 * In this case, @flush is used to communicate whether or not a
		 * TLB flush is needed *now*, and specifically only impacts the
		 * case where a huge SPTE is replaced with a shadow page SPTE
		 * (KVM always flushes if a shadow page SPTE is zapped).
		 *
		 * When splitting a hugepage and the new shadow page is fully
		 * populated, i.e. every child SPTE is shadow-present and thus
		 * the total mappings are functionally identical, KVM can defer
		 * the TLB flush (until the ioctl completes) as no memory has
		 * been unmapped, and all mappings are still reachable, e.g. so
		 * that future mmu_notifier invalidations are guaranteed to
		 * flush the affected range if relevant mappings are zapped.
		 */

If you're expecting me to grab this, I'll add the comment when applying.
