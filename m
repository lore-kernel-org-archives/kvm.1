Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C991D555
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767990; cv=none; b=OsYunZ4fLUhSsMW/UeBqYTYi8t4FCmWpR7tP51qJDeJD6J3hpLvQFUdRjKaCZRODG2sD7n05ctYcBMQ7mxauy6GachF2YATD8EV+9rpHyD2gTQ45FpGh5Q+BW/xIcBDYVBUUsQ8Ft+JOM42nAIDhoNf7/IhgyrsvQz/BuGwupuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767990; c=relaxed/simple;
	bh=W8zO0aEDv2+JIislquQ6WLUjQVKy+IVFjZc4VH0Dr4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RP5w7AiOr2cos90tmIS6MJwfXkyU7fe1zayMTDHWiwdodn/T3TIFxk6cq+tQD0EZZQVTp3MH7NXaXcrBgvBmTBYMW7xBBgi5NEv2j+1mHMMix17tBU/MEz6chLcYgPQJWADBl/lMNkpBluwOracZ/wNQxSqELK3LXoWNy/SkmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHjHiULA; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHjHiULA"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a67b16217so137393b3a.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784767989; x=1785372789; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opFEo/WyLvzTTBdcJgd0dRDPizwBHzhn8Zc4yWr1cd8=;
        b=IHjHiULARNSQoL/JlUTK/QNEL1eFBS7W/3ZHl9rfszBNkEULgNC0dyuYcI1kfb8brz
         sqbsHKMjf7lh31+m0PhREJzme/egXigljqt2FLtZY9VaP1OC8kkl9yBXmVvO2wKOdvlF
         YclAE+FgQu65kbappkISvdnLn7c72sN83CCiwGVfVO8J6up+ClKnBuOkUeyKQbKixHzE
         aHcNJR5egwMREo2mAANZjFTYoVll+5P7lWxnHyE2EPc/yvA5LzHTg9flyFCXEPJy+vVl
         CUOKyLcFDKk7jKB0nMy0XIqK5dUD5yHmnu9kkh7v9kVFIiFmI2E9uUhQVwzZK4jTCO46
         ABpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784767989; x=1785372789;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opFEo/WyLvzTTBdcJgd0dRDPizwBHzhn8Zc4yWr1cd8=;
        b=liRzNs7C0mtu9TkQ8n0jCmznuFMWgESDYYDTVRS/2PauAoU1CQvhPtFRIc+JLYXA6C
         OlcpewnxuOK+87oV9ssfcWwqR9g23jgy4Nfy4QkhVecK8Vhut9CE0blaXWXY/bNaEl4a
         vb2w3O9D7HLec2OHEAkS1U5vGjYkaiseubV2gewfnRRTeJ6StsT+6MW4ThTvPh2dSc/J
         GqwcPayhWy9+6kHZKPcYDLwjFrmB//M8jGWPTwHBl0sl3GsjsX0F4d/ILYOqpA09p0Kt
         h62bWdahzAmaQZOyYPZmHpGdi41ZeQ8joajmt05tFsNG4oYOD3RA8AuOYq93VtB2v/1t
         B1Ig==
X-Forwarded-Encrypted: i=1; AHgh+RrMMAMKNAprwcDqQzVk0YldpY3b4RrW31d6ajzcZ2t2DdMslDBmIl3ec8Ml+M4j+yrDRYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1Ew8XUYC8kGP1vOQXV/AHxmYDgIk9La757sT5pYr6dkuYytM
	pK3VxCzCI+UMTeudxLoIskGSBmZkNl4HuxWHP0jHgWNXzBYf3zFX7f+ar1o0cpidttqtXgbxFRY
	lXzR3Dw==
X-Received: from pgbca34.prod.google.com ([2002:a05:6a02:6a2:b0:c88:dea2:d511])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca0:b0:848:4810:2b71
 with SMTP id d2e1a72fcca58-84e2bbca960mr1187249b3a.51.1784767988593; Wed, 22
 Jul 2026 17:53:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:53:07 -0700
In-Reply-To: <20260616004155.1435766-23-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
Message-ID: <amFl89ch5Iej63L3@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> Refactor helpers out of kvm_mmu_invalidate_addr() and kvm_mmu_invlpg()
> that take in an extra argument to skip the GVA flush.
> 
> This will be used when invalidating GVAs in a different context than the
> correct one (i.e.  invalidating an L2 GVA from L1), so flushing the
> current context would flush the wrong TLB entries.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 65c35ed8f4a01..3feb75732f7b4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
>  	write_unlock(&vcpu->kvm->mmu_lock);
>  }
>  
> -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> -			     u64 addr, unsigned long roots)
> +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> +				      u64 addr, unsigned long roots, bool flush_gva)
>  {
>  	int i;
>  
>  	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
>  
>  	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
> -	if (mmu != &vcpu->arch.guest_mmu) {
> +	if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
>  		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
>  		if (is_noncanonical_invlpg_address(addr, vcpu))
>  			return;
> @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
>  	}
>  }
> +
> +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> +			       u64 addr, unsigned long roots)

Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
to have the "in_root" version to a quad-underscores helper, and IMO it's more
obvious what's different between the one-line wrappers and the inner helpers.

> +{
> +	__kvm_mmu_invalidate_addr(vcpu, mmu, addr, roots, true);
> +}

Make these one-liners static inlines to avoid the export, and because they're
trivial wrappers that should be inlined.

>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
>  
> -void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
> +static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
>  {
>  	/*
>  	 * INVLPG is required to invalidate any global mappings for the VA,
> @@ -6656,11 +6662,16 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
>  	 * be synced when switching to that new cr3, so nothing needs to be
>  	 * done here for them.
>  	 */
> -	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.walk_mmu, gva, KVM_MMU_ROOTS_ALL);
> +	__kvm_mmu_invalidate_addr(vcpu, vcpu->arch.walk_mmu, gva,
> +				  KVM_MMU_ROOTS_ALL, flush_gva);
>  	++vcpu->stat.invlpg;
>  }
> -EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
>  
> +void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
> +{
> +	__kvm_mmu_invlpg(vcpu, gva, true);
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
>  
>  void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
>  {
> -- 
> 2.54.0.1136.gdb2ca164c4-goog
> 
