Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343D2BB13
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768182; cv=none; b=q3nCUCmaZYEP6AgnsF/92w/7AYq6+Lq2t0vfT//5jyqzykcDlZJ+iINIBUheJAnpylusA7T+mZEIhj8KiS7HJHykLZYLZE8WDT2T6k8pvK5O0z0NAcDjVZ9eF62No/juI91OkyvnCTwQC/a/fFvlxCRAUDvXzbPTxPAyanc/Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768182; c=relaxed/simple;
	bh=LHdVCehwG3HvJYaxZhqKZcT5rZZsELkJdogfR1KfAMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZFRZQuAsQXNYARLAyVsuoUdB6wHudg4Q/unZDCGQwTHF6DHdXRDXAgop/6C9Zs8cnoEkDkzZAMJKe5p4A6wIOTiZiE1oMfjXUdVyo7cT3rBLqNzLxAb3+O74IJ0FLprUZPoEDTZpDJ5ExqZuVlxmGTAqmxxwXdKAUeg3dOyDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4Fm7ZY4; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4Fm7ZY4"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e058ff6cfso183502b3a.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784768180; x=1785372980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBVSNQ6EdYayMHw9yILA6H3pFc9jV95YBn1yRdp33VE=;
        b=l4Fm7ZY4kCH2/D+4/oWNWMMt5gNuIJ13+OV/zUm0ZNwPJJYm1zf6z72MzUL3O38gje
         1io2aX20RPPzP7npUbtvCKBG/HO2q/mNItSNQPJt2qyk6WkbyBTo9USPsAjTqzDYykzJ
         6iY6cuqsRmFdSHNtK5EieR3gDMoih1ZhuLTzBctzVilQhlFMMA9AO9dEABHl5L7Z7v+O
         QslAxUBQemNuzPzPvuYnYYCY0qwbIb2lAc2nZMajrF2sfAyzeS9UlQScYHhMrGcOZHYS
         sLW3fKiT6HyB/T3itm19SJAhYtJ64rzm1MR/gXglwwHK6MMC19UwWWOeKbzP9Ro8zNJk
         GK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784768180; x=1785372980;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBVSNQ6EdYayMHw9yILA6H3pFc9jV95YBn1yRdp33VE=;
        b=JWz5lZhHqFo5zjsHF7arh77fTTa8c/5s2zpqXlMRk1YMb03JkjZ8Wnv8OPR5VrqphB
         Mdbduv93xi4wyeqnXjZLZMgqFkPZpxuJ4qbIlUm7IBoELfb5BHrdRtKIkCytH9g/E32F
         Mb4BSNTldyB2n7z/H7vEetN8YB9+tz3+dXoxguMaTd9U0N429nI/4u2w2N7fgSWLOKyj
         liCbk7VMLuQ5bcuHQ8qqDP498pr7jrBSYTiZgaQWOnqPlSHVOe7gxlGPtj9XPOhwxpVa
         2W/32YRm54D1/CjMMt7dj31v1r9u24eXHQxKV51i8pVh8lFIkeTDHRWthrfP72QtDu/V
         jcqg==
X-Forwarded-Encrypted: i=1; AHgh+RpM+5JmU9AtGHkTPKl8GICKiMXBRvz6Ypes7v69DD9qNx9gbP4ulbqYDtbftJVHAuIkfKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzextHiBkvRlH1hxafcc+QtMOnasnR5anCSBm4u1G9Fyz98Vu
	c8dddWm8IKcxaOuUO8JAwvIWjcD7HbH4Aelfap6mXOI/hKJK7hUbjkeXBniwDyKHsLyyke1gvAW
	AycON8g==
X-Received: from pfbhj14.prod.google.com ([2002:a05:6a00:870e:b0:845:e683:1287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:181c:b0:82f:50cd:e586
 with SMTP id d2e1a72fcca58-84e2bbeceabmr1218273b3a.13.1784768180132; Wed, 22
 Jul 2026 17:56:20 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:56:19 -0700
In-Reply-To: <amFl89ch5Iej63L3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com>
Message-ID: <amFms2CnzhDUuRCk@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, Sean Christopherson wrote:
> On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> > Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
> > that take in an extra argument to skip the GVA flush.
> > 
> > This will be used when invalidating GVAs in a different context than the
> > correct one (i.e.  invalidating an L2 GVA from L1), so flushing the
> > current context would flush the wrong TLB entries.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 65c35ed8f4a01..3feb75732f7b4 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> >  	write_unlock(&vcpu->kvm->mmu_lock);
> >  }
> >  
> > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > -			     u64 addr, unsigned long roots)
> > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > +				      u64 addr, unsigned long roots, bool flush_gva)
> >  {
> >  	int i;
> >  
> >  	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> >  
> >  	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > -	if (mmu != &vcpu->arch.guest_mmu) {
> > +	if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
> >  		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
> >  		if (is_noncanonical_invlpg_address(addr, vcpu))
> >  			return;
> > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> >  			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> >  	}
> >  }
> > +
> > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > +			       u64 addr, unsigned long roots)
> 
> Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
> kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
> to have the "in_root" version to a quad-underscores helper, and IMO it's more
> obvious what's different between the one-line wrappers and the inner helpers.

Hrm, or maybe I'm not understanding what "flush_gva" means.  At first glance, I
was assuming you were using it to differentiate between GVA and GPA, but IIUC,
it's literally skipping the flush for the current context, which just so happens
to be done only for GVAs.  I'd still like to avoid the "in_root" helper, if at
all possible.
