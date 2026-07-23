Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40B233134
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844229; cv=none; b=XiXU0TgdFEXDvf9rpzccF4XyYzbUqWO2uPFm8bvGwH6AgGGVjX1I1/uhQQjubjl5OkWEH/uMTZzNGr5Ya9HwsUAFT+qJnUqO1X4rJ3Q3lVvJZuflbTpFjGlzyzDsBvut9+A68L+2Tkc4RiKdRUQojlA353uYThSvZp7rAjBpm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844229; c=relaxed/simple;
	bh=cVLH7X8Z1nxr3iOntUVXaQnrzMWGXJZdgkdrJ76yWKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxjAsQ8lH3595Q5mgkLQCydxC45QDW73g4YGThJNK+0VtZBHfCGLieOs58ArZYMDVvNIuzFVbivkvNUdX+cmxbGb6lUavT06nqWJcUloKOJZgbHZFa0eONkQZ6V/2AU2UdjXpPuasYtvh5Ezl6YyRjLrfSTOybPYx/Nk06hcQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWIWM6EX; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWIWM6EX"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84877b362f6so1922300b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784844227; x=1785449027; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0znrxN/z/JOab22zS9dlYbNOA2+q+KFwgdUxfwSx7Ks=;
        b=IWIWM6EXTW6uBuIfl2SYyyaf1yi2IURqWHJytBhXmNzdEK2wL2xLdJ/wAyK1nnp75V
         fmgKp9WxcW3kZukTURc+Gy3nR39Szbc7yLv+NO1kWoJFDWUMvqYTNkDnjVCuEdxJC3qw
         aiX1I18dsZKIjp2xI2vF4tVsy+8rN03T/nmCOKtEl1Jk2wu203Fbxi20rwmLPRza22xi
         zhJAYq8LIQDCbw8S0TGHXyt4abgC/8KTuQ3XqmlN/eBKTdKUcqFidSuedjsppyXy5IYJ
         Yht4BKw9M7z/L8/U3yod5ZEEiRy6kx3V60276nIHzUlqR0vbxEp31+WFFW2IENHAOL7m
         gVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844227; x=1785449027;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0znrxN/z/JOab22zS9dlYbNOA2+q+KFwgdUxfwSx7Ks=;
        b=QkSzY4iMy9zhWohFZdRb/Z6/st7OkS4/hdrChzTeomy0nCU3REyaf49c/mDQbuvcc3
         gVzepDefiuIS0maPxigc2Lbax7t7l9vi72IfguOmE1bEHiqr72isTPuOuZH3ogGtqy+H
         H0rofwkmXdflv7ul5rF7p0Pu1iGj0m9Ym4y7DiBjjQBc/pSOHfmVJ8XUUwDQbmJuG4Q2
         NAOG1/6FPus8mcXbOP4Owi89qmxvettGB8TfiIzjIIqPS5V1jDhFx6doLfo8lm1xq8v3
         OzKgsjhIpCuI0Ykfj9rq8Gs8VEn5uyh8VpFhEfDPIk13Gu6qoUOxtdg3yfhf5VIopn0Q
         XBVw==
X-Forwarded-Encrypted: i=1; AHgh+Rq9mZ12HLwtSH1X1iPBg6vXLr6dRfCTjWbxKinWc4qWaZCYr4cETaBHMaDY6UScE9N3lJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyici8wjKXzcRKJYKI8xfppv5pwfk9GJ/eayZgqTkoBG8P0A9/d
	YEY8fqMuUghv3hZxxkWY4TXeSniE+26fUDqpKuTiYwrdmVVIgQeluVBifjkMAeXcssK3ANC9+yG
	cvkimaQ==
X-Received: from pfbdi4.prod.google.com ([2002:a05:6a00:4804:b0:84c:1460:ab72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12cd:b0:846:bc60:5bf7
 with SMTP id d2e1a72fcca58-84e2bbeebc7mr5433458b3a.6.1784844226854; Thu, 23
 Jul 2026 15:03:46 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:03:46 -0700
In-Reply-To: <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com> <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com>
Message-ID: <amKPwsAprgG_Pntg@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 23, 2026, Yosry Ahmed wrote:
> > Actually, isn't there a pre-existing over-flush when handling kvm_mmu_invpcid_gva()?
> > Oof, and a missed flush?
> >
> > To fix the over-flush, I think we want this?
> >
> > diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> > index 6c13da942bfc..7f3e0eb33b29 100644
> > --- arch/x86/kvm/mmu/mmu.c
> > +++ arch/x86/kvm/mmu/mmu.c
> > @@ -6672,7 +6672,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
> >                 if (is_noncanonical_invlpg_address(addr, vcpu))
> >                         return;
> >
> > -               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> > +               if (roots & KVM_MMU_ROOT_CURRENT)
> > +                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> 
> Hmmm why?
> 
> AFAICT, if the gva has a shadow mapping, then the rest of
> kvm_mmu_invalidate_addr() will make sure the shadow mapping is
> up-to-date and do any necessary TLB flushes in the process. So I am
> assuming the flush here is intended to cover some cases where the gva
> does not have a shadow mapping. Not sure how this could happen, I
> assume we always flush the TLB when a shadow PTE is freed.
> 
> If there are cases where we can have TLB entries but no shadow
> mappings, then shouldn't we flush regardless of which cached roots
> match the target PCID? I assume if none of the cached roots match the
> PCID it's not an issue because KVM will create a new root and flush
> the TLB before switching into the new PCID.

Gah, I conflated PCIDs and VPIDs.

> >                 if (tdp_enabled)
> >                         return;
> >
> >
> > And that highlights the missed flush: if the PCID isn't the current PCID, then
> > flush_tlb_gva() neglects to flush the hardware TLB for the target PCID, which
> > could leave a stale entry in the TLB if the guest switches to the new PCID with
> > MOV CR3 + X86_CR3_PCID_NOFLUSH.
> 
> I also don't follow this part flush_tlb_gva() ends up executing
> INVVPID or INVLPGA. In both cases, all PCIDs for the VPID/ASID are
> flushed, right?

Ignore me, I had it in my head that flush_tlb_gva() is wired up to flush PCIDs,
not VPIDs.
