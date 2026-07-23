Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BF3E6DCF
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843325; cv=none; b=oBKcMgkGqpvVVhWE2wy0FBNemIr9ogy9OYZc56lKXLvnzbMoEuCV7pJugtLfjYbaUzxrATSs2Y5pRvpPJLxpTBXHpjLQGtkPAu6aJqXJGWwTW2ear1Ii1hSvNxtBNPhyX5t4weR3fQGDh2bUR6ixkBDV6TZWWq/RVloQN8I8GPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843325; c=relaxed/simple;
	bh=l5rpXvvcDbPs1Q+ZU8sWjiTUODQJThHga+knzNf1840=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4b1atO4+dQwR0sG/9wAPA1H0BOtcPwds9NPekFFEtwXtFQdH8vbBgf6JN0d6wDO8mKA3Oadu+LKmwmYMaIV/xl582Xhj6WU58fBssgddWXhhd1PcBtUWgSYyTJz7tnBI0UxxYKJDq5Nr9XnNdqlAU5i9OXai60cpRCh/fj8r3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLFZJSFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLFZJSFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391541F00A3F
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843323;
	bh=BWV9EPSmzHQjtMOMlGqqeSoxgvQ2kqwrbCDgXGAvomU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gLFZJSFRPAs76FF5fFenEj1Qoo8trEPuphOGjX5NNSy95lZXRtS7Qj6lcvjAdF2Mv
	 Ef8/lDp3mnuVSnrJ1pibnAqBNVyinCTrpjdAPHbN0zy+FQ8qOYPxur2ZOtdrwnjfww
	 0KaIYcWeIqucvi3qqBMQffho9DKF6FEgx9IpEaQWtMvydVnjyld64MZD39djDINcDd
	 pwh0q+nNRV+jPmdtLrL4MzfPSKnvvqQ7GCMkxqHI1iAqbO0rLAHT3SPDY4rmuqfMdM
	 hxz3NSRg7Nze5kXIPnnAZpILykqp11RRnzhboNWrsAfLH8YC0u2MsXzfF1d0m+YJ5P
	 kEijV1eQIqN1Q==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so119539066b.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:48:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrNK3ufQoMO+2TWiI8uo7VtMfmfrvqCACCQasbudwDPOlF73DJ62Ql0mOG3kRjTG+0wHqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8KpNMwi8jTCN2eni7zwUKO+H+ZD2eDBLQBNxxo0iJHZB+6AH
	ZXfanaRoRGLnefF5ulQ4NPl9Ju8D34oQoI7nVCB2CfSMGN3rrCualTD/BdBVtmxei3UaO/UR4h2
	+5NPGnM7muua21HZOypq/rEDDbYAvdY8=
X-Received: by 2002:a17:906:f595:b0:c15:e07a:eb4b with SMTP id
 a640c23a62f3a-c1c506e8a83mr215495766b.3.1784843321987; Thu, 23 Jul 2026
 14:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
In-Reply-To: <amIx9Ki6gv-wgBnX@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 14:48:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com>
X-Gm-Features: AUfX_mw6z34ldVF9V-91bWuB2izy0OSrLLXGBT86_j0aIMVg7co5Wdkshk4nTMk
Message-ID: <CAO9r8zOd6vLA+rYwQx9n86Hc+4wZUZNO+0EPeDry-GDhG8OLTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Actually, isn't there a pre-existing over-flush when handling kvm_mmu_invpcid_gva()?
> Oof, and a missed flush?
>
> To fix the over-flush, I think we want this?
>
> diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
> index 6c13da942bfc..7f3e0eb33b29 100644
> --- arch/x86/kvm/mmu/mmu.c
> +++ arch/x86/kvm/mmu/mmu.c
> @@ -6672,7 +6672,8 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
>                 if (is_noncanonical_invlpg_address(addr, vcpu))
>                         return;
>
> -               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> +               if (roots & KVM_MMU_ROOT_CURRENT)
> +                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);

Hmmm why?

AFAICT, if the gva has a shadow mapping, then the rest of
kvm_mmu_invalidate_addr() will make sure the shadow mapping is
up-to-date and do any necessary TLB flushes in the process. So I am
assuming the flush here is intended to cover some cases where the gva
does not have a shadow mapping. Not sure how this could happen, I
assume we always flush the TLB when a shadow PTE is freed.

If there are cases where we can have TLB entries but no shadow
mappings, then shouldn't we flush regardless of which cached roots
match the target PCID? I assume if none of the cached roots match the
PCID it's not an issue because KVM will create a new root and flush
the TLB before switching into the new PCID.

>
>                 if (tdp_enabled)
>                         return;
>
>
> And that highlights the missed flush: if the PCID isn't the current PCID, then
> flush_tlb_gva() neglects to flush the hardware TLB for the target PCID, which
> could leave a stale entry in the TLB if the guest switches to the new PCID with
> MOV CR3 + X86_CR3_PCID_NOFLUSH.

I also don't follow this part flush_tlb_gva() ends up executing
INVVPID or INVLPGA. In both cases, all PCIDs for the VPID/ASID are
flushed, right?
