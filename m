Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285D348C7B
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940961; cv=none; b=RdDKJvQrld6a0+uCRFrF3LZaM58b1OqsTOCddaQ/ALajnPSpgRlGTlztW2OmdsazsThu6RHyF++IbK7kzSIKo+RWjVG3wkoRNOIsGBf+KSKgYYIwx07GkKak9YkNXIDwXR74WQEV+zrOCwVJ0x6ywSuB8B7+svZTNcybnTF9lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940961; c=relaxed/simple;
	bh=kip77Md7PwYITJnOOQMo7p3iswnskWypncJ5FdSTB1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NyFXyLxRnlsVoj1nVI7xZyljX05K6qluF1On4kjpMJZXNCQnrRVvwsNQNZ6sik16DL0xRNUrwfFX+DEkMN6hro/az16+5NOXkBlrIOrD7ntS6gf/S1F49FjK9NRT+Q7gn2chG1rcJSISAAYkTZaRT3GdYyWpLHmCy1lOT4t6BP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXjlBlDx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXjlBlDx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0481106cso12742485ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782940958; x=1783545758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=haHjTZYd6eldytH5GfA3G4FAjy8Nb18IhisBBKGE6LY=;
        b=YXjlBlDxGGZQ/U7bzPwwwBm5Wvs+yo4JStpltpYrIpLC0ip0KtY2df9KaCxWxROxtp
         umbHlteeMARpvMf21AYmuBS+gWVni2GZITK4KZ6kjegA3XkEOIom9vHCA9kPVnPhTg0G
         1tt11P4k0l/xBdIqc/twiV0Ha6slfLfMlRIuBEGFgL1GlEBJ9zepdMdSyPK7jl4QXva8
         lBzPM0Joyx+52YWdWuTcOCv3ceC2cOqKwk3ADZJJIFHU5AUeK4odMM7nLr/Kgvgno2rD
         8afR4MGhTJgLZD54+wcCl8L+xN/HPp/yy67o+IgDbCKPSnZZjF8KhelpnKgNMH4lvRiz
         ZX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940958; x=1783545758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=haHjTZYd6eldytH5GfA3G4FAjy8Nb18IhisBBKGE6LY=;
        b=aEAbWhtfeESNjKdA8Fh9tu688XpSqlTC8jiy3wUqRHXMr1qpqxnIvyczyGIMKMmZDL
         yP2DVa50YOVY/cNanIS/uWQNj+Jh1jX+QDKWsUZhw7rXw4exrfP5Np6C5btK1W3c9YgT
         yNweUjiuHCJ12stHm6/+PwpJ+pipjDxmoRMBSIh2iHrytvHZ+q36ly1zeZFh8M2hS8XD
         eTFHFYffjeCjjDI2ihHtflSm7Uoj6YfsDEbdyUIdB+V61S/EGKqzM8gIeGtO280+fmyN
         5fE0FPsiKPGrqG6aZeozLbGrYB/269r1BrIE5SZNQAmlOx6exDJLkkjth9NQlvrC82Ph
         ygpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyAPmTgXbK9MLUq506RDZp10+Etk2cEKVyKOXc5zXhcfR/UsXxYT305heMqhjxCMwvn8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDLQlPfKujiCpHdikOT6QOxInaqKeAiBN1iuL7gpDs0ihu8rD
	dtMnpu63qRKT24L/xa6g8utrDW50SKr/B0kvRqQEttOk+TQ4UA6HEb3NZ3MxAhaZBnJLVXd8WU4
	VOfpv8Q==
X-Received: from plnx15.prod.google.com ([2002:a17:902:820f:b0:2c9:9db6:88e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec6:b0:2c9:e846:a57e
 with SMTP id d9443c01a7336-2ca90c2d830mr24586315ad.0.1782940958029; Wed, 01
 Jul 2026 14:22:38 -0700 (PDT)
Date: Wed, 1 Jul 2026 14:22:37 -0700
In-Reply-To: <CAEvNRgEK+LH+M32LrxFSbN3Nf9sYtAVkr2c2vYq5FHzJmJqL7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630213711.479692-1-seanjc@google.com> <20260630213711.479692-2-seanjc@google.com>
 <CAEvNRgEK+LH+M32LrxFSbN3Nf9sYtAVkr2c2vYq5FHzJmJqL7g@mail.gmail.com>
Message-ID: <akWFHf8_ovEEPBWi@google.com>
Subject: Re: [PATCH v2 1/2] KVM: SEV: Explicitly disallow NULL user address
 for SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>, 
	Joerg Roedel <joerg.roedel@amd.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 74fb15551e83..621a2eaa58f2 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2330,9 +2330,6 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >  	int level;
> >  	int ret;
> >
> > -	if (WARN_ON_ONCE(sev_populate_args->type != KVM_SEV_SNP_PAGE_TYPE_ZERO && !src_page))
> > -		return -EINVAL;
> > -
> >  	ret = snp_lookup_rmpentry((u64)pfn, &assigned, &level);
> >  	if (ret || assigned) {
> >  		pr_debug("%s: Failed to ensure GFN 0x%llx RMP entry is initial shared state, ret: %d assigned: %d\n",
> > @@ -2421,10 +2418,12 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
> >  	     params.type != KVM_SEV_SNP_PAGE_TYPE_CPUID))
> >  		return -EINVAL;
> >
> > -	src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL : u64_to_user_ptr(params.uaddr);
> > -
> > -	if (!PAGE_ALIGNED(src))
> > +	if (params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO)
> > +		src = NULL;
> > +	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
> >  		return -EINVAL;
> > +	else
> > +		src = u64_to_user_ptr(params.uaddr);
> >
> 
> I think separating validation from src assignment logic is better, like
> 
>     if (!PAGE_ALIGNED(params.uaddr))
> 	return -EINVAL;
> 
>     if (!params.uaddr && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
>         return -EINVAL;
> 
>     src = params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO ? NULL :
> u64_to_user_ptr(params.uaddr);
>
> This version is also slightly stricter, since it enforces that
> params.uaddr is aligned even if params.type is ZERO. 

That's technically an ABI change since KVM fully ignored params.uaddr before
this, i.e. is a potentially breaking change.  As noted in the changelog, KVM
should have required the address to be '0', but unfortunately we can't do that
without breaking userspace.

I highly doubt requiring the address to be page-aligned would break userspace,
but KVM also gains nothing from such a requirement, and from an ABI perspective,
placing restrictions on a value that is completely ignored is rather bizarre.

> (unless the intention is to really not care about uaddr and permit an
> unaligned uaddr?)

I don't think there was any intention (which is the whole problem).
