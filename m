Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176F57C9F
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643322; cv=none; b=SeAi35Bw4/CD9qX11Ojuv7m4p6NGvIHWV1DbmyD1eB6fX+tnJZhQ0meOql5h0XMXAjdYXlCcK+ghfmNSZRQu5p+3meDXMrb29R0yFfObDbxSxqAhbUKFuyKnTworyZCZdw2IeJUoTYjMmQuTaPIaX3dG45VMR1G0AG1Qui5+WOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643322; c=relaxed/simple;
	bh=oudXyYGsAIqzBpHjdzCL38npN627lf3g6I+42msjg/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K6QqMlc678KwsCEUimOGuiQLHMfR8ey5gAI3nl5LSJLsDXpedW2knnpmgDCNVdXor27fADTmYm6Gl4J1eTTP195I0cFqCwRRv+FpQVznK4k+0oIdWRrvL5gVrCuYmsBPTeyCL4zpAbcEMA53a/9TNo5pMhKoeTc7hSjeDTGPr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3WNddHw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3WNddHw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc5faecf01so6118605ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 17:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643320; x=1784248120; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vu6YzA2G9RSK45wx0bMoFgL65zeMC9NfowhXiVy+sE=;
        b=l3WNddHwXtzZ1+JoPeCWveEUCYYhhZrDhlQZlrQl4uNhrsm4xaTpeAX6NChtPu0Dxs
         tXwqY0s/zdsKJ7LfaMI5yuJmvxRDpg95zs1G8ThOVIU9v4wDXvUPJYBTOVOnEKOG3xrF
         7B+Pao97RoXIU5io9kcnmW1SdNAl8c/XTs4Z+C47MOa9lmkOhzxLDaTVr8k6h084L0nR
         zHoIesDEaPp5HNryVIxj8PvfOMmcyzdr/E6Rm9kl/kOkP6XxMzSJIiP7gYP0MPy1T8J6
         Tcj31lPkixcaUUOlWPkv9zrmHw//6Rf25ST67Aja0fPKgPZPhuHUuTuUmJCRfQoHu6Si
         koFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643320; x=1784248120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vu6YzA2G9RSK45wx0bMoFgL65zeMC9NfowhXiVy+sE=;
        b=Blv5zqi1KnEtHi0ufJH29LfKChoHMUE8K3n6SyZ9p987quaBHsAtceQ+QXaQU2BOyl
         4wVmxw32IqBqQ99oxGEGJcoCCSxnLpHp76g5DhyiJnN15L9F8lpDO4HEtgkNVrbF8O7J
         1mJf+H6NF8Z0uw6y7mpivn198EhrUl14mot+DHSPxUNiIdOVzztdDNVZumwdnLXSkIcl
         gOIvkRhpN2QwWEPXLwMmmQm+AcCmQwFzYZdm3SMcTTagwdUkhIWh9XvOx9VVXwP41jvP
         Bv0+hm9i7/9mr83oR8givI2TAXwmN0z+olyo69IMmYbkiejyCYXroZWURsXltHFwlzGN
         5yCA==
X-Gm-Message-State: AOJu0Yz1CmQaFDqJhst8Ejb1ZrDnFRwaFwQgVjq6HI3Faluwp4AaXP+C
	RgwtR3i1cmeXuK//I0pwNzQ5XIve/WXkRKg/9Nv7AHCknsEpgLI1OwxF0doOJDHgFqMj3G+xoAU
	+Alv7hg==
X-Received: from pllg6.prod.google.com ([2002:a17:902:7406:b0:2cc:6fb4:ce5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0f:b0:2cc:670d:9b1f
 with SMTP id d9443c01a7336-2ccea4290f0mr92923155ad.28.1783643320075; Thu, 09
 Jul 2026 17:28:40 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:28:39 -0700
In-Reply-To: <20260709210728.1205A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-2-seanjc@google.com>
 <20260709210728.1205A1F000E9@smtp.kernel.org>
Message-ID: <alA8t6uSyUw8oF5k@google.com>
Subject: Re: [PATCH v4 01/18] KVM: SEV: Track the GPA of the guest-controlled
 VMSA used for SNP guests
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 09, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 74fb15551e83f..827f5dc061023 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
> > @@ -4039,6 +4040,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
> >  	svm->sev_es.snp_has_guest_vmsa = true;
> >  
> >  	/* Use the new VMSA */
> > +	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
> >  	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this bypass the MMU invalidation retry
> protocol?
> 
> Looking at sev_snp_init_protected_guest_state(), KVM resolves the PFN via
> kvm_gmem_get_pfn(), directly installs it into the hardware VMCB, and drops
> the page reference:
> 
> 	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
> 		return;
> 	...
> 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
> 	...
> 	kvm_release_page_clean(page);
> 
> Can this race with a concurrent guest_memfd hole punch if kvm->mmu_lock isn't
> held and the invalidation sequence counter isn't verified?
> 
> If the page is freed back to the host allocator, could the hardware continue
> to use a freed host physical page for the VMSA, leading to a physical
> use-after-free?

Read the cover letter?
