Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB6253359
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797831; cv=none; b=cZUNDMrlaewB+VER6pgSVziwZER+zLZXUR/VSE88SAda5qHvit5nglB91Juq2oRg63WSUCbe4VM/QcpRjFrVKGmewzFWxz7t5urFOdp44IxOI5vIOnV2aKGA2foGM36TjSBjkLfL6PuQfcEbgF74be9cAgkm+g/J7k/zYb0gQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797831; c=relaxed/simple;
	bh=TzsJfr7pCIntQMSaDmlkEoArEx7G8FjtiVdDOqi3N8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG9ZqvglESKDHOdoIEmOiA1hnobdEEmi2/aF6cjHelFBzy6WcDbM3fbeFVaVfZtkG3T5KOnalv3LsUi5qlCNjzgnFm8A7K6X7CFFg2cQZG6Scrp5hI1ZkjiPG2heHVjfmEuA/DDtkpvtgAdZgwh0ylWXJEvp/9C++Pv1XCWCEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRa3YNQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRa3YNQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C00C2BCFB
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797830;
	bh=TzsJfr7pCIntQMSaDmlkEoArEx7G8FjtiVdDOqi3N8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IRa3YNQjfipd46N24kj7o6S9emSMmJwLf0A52bZcUO4muZ2iNcnSknZT/rK0+7j0Q
	 iC66jO4n/ao1NAIQzlyVi0cVqFQpJNFikHom/DAqxC/dvNxYedS5ySvGiK5GxGbvWB
	 HNDP7cBmrWuVPhGxUGrnFdYgbghZkhf11p10jSRDqZUq7xKwaBTvLipEGqnxwOlBgd
	 JUjCUr69wT36qIlSpjnQ4tNDZcaNYqOcHxsaWEOBk+jEs0qgAZ4rsn58zmMgm4gPmg
	 SjNlAh6ClFHOFuYWvJeX9DmvZORCMU2FtiHbFauw7RjJN/VlgknSPPyhn1DsIBOFY6
	 30bXQ0h24aUZw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd01481e592so669502866b.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:30:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ChVQXiCN0AnXvm07xXpxRskb/ZGWyFvvEN27L8eFBCs6CRumFpjVizprkEmbu9tWdJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPaUIdRYCWSogyix/SmbpWka+gKm4p7oE/3jv+L/+CuwDi5BP
	hi1YJiWsr3PZ/LS235cBln7gEtSny2iUvFcJxL3Urqn7e5cVH/FSYdYCv7VSlbDJzZjQ+ZWuZcN
	9W2FBlfUMifHsy41y1htMk1j84rWrmK4=
X-Received: by 2002:a17:906:6a26:b0:bcc:855c:52f2 with SMTP id
 a640c23a62f3a-bd51796ead6mr65733266b.35.1778797829527; Thu, 14 May 2026
 15:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-8-seanjc@google.com>
In-Reply-To: <20260514215355.1648463-8-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 14 May 2026 15:30:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMh2rN2m8D=oqJxiv=gN=0u+UNEYgaLK7qVvXQ5NL=b+A@mail.gmail.com>
X-Gm-Features: AVHnY4KZbMVe9dnMDdA0kUfzVaX2MkYo7jUJeVdOmLXOdkVvTDjCPSCowhae9jY
Message-ID: <CAO9r8zMh2rN2m8D=oqJxiv=gN=0u+UNEYgaLK7qVvXQ5NL=b+A@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] KVM: x86: Move inlined CR and DR helpers from
 x86.h to regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Move inlined Control Register and Debug Register helpers from x86.h to th=
e
> aptly named regs.h, to help trim down x86.h (and x86.c in the future).
>
> Move select EFER functionality, but leave behind all other MSR handling,
> There is more than enough MSR code to carve out msr.{c,h} in the future.
> Give EFER special treatment as it's an "MSR" in name only, e.g. it's has
> far more in common with CR4 than it does with any MSR.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/regs.h | 108 ++++++++++++++++++++++++++++++++++++++++++--
>  arch/x86/kvm/x86.h  | 102 -----------------------------------------
>  2 files changed, 105 insertions(+), 105 deletions(-)
>
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 4440f3992fce..ecc66b577e82 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -16,6 +16,37 @@
>
>  static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
>
> +static inline bool is_long_mode(struct kvm_vcpu *vcpu)
> +{
> +#ifdef CONFIG_X86_64
> +       return !!(vcpu->arch.efer & EFER_LMA);
> +#else
> +       return false;
> +#endif
> +}
> +
> +static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
> +{
> +       int cs_db, cs_l;
> +
> +       WARN_ON_ONCE(vcpu->arch.guest_state_protected);
> +
> +       if (!is_long_mode(vcpu))
> +               return false;
> +       kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
> +       return cs_l;
> +}
> +
> +static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
> +{
> +       /*
> +        * If running with protected guest state, the CS register is not
> +        * accessible. The hypercall register values will have had to bee=
n
> +        * provided in 64-bit mode, so assume the guest is in 64-bit.
> +        */
> +       return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
> +}

This is really stretching the meaning of 'regs', but it's not that
much worse than 'x86'..

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
