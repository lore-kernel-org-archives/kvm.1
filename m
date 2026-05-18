Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088738F927
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131681; cv=none; b=OqUtVQ+8xWLN0kxrhtQReZr+7kfCzqK6KdYk37NPsJtg2vVkz+aNd0FjAOyYtzQzmBBsCroDWM5zaJcLliO72OnQaRv6a+BdupssdoABafcr4qzwK+QaeOuqV7rlrcZgyP8HbSmDca4d8tBt8zhiytBGd+JoBzrhxeNLS9mgFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131681; c=relaxed/simple;
	bh=oprmgku8si+OLXrL/12KBtH9ObDkdjBSzOrFL4VhpNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb24l7CK18GsSwJsifAZf6Ole5qSceuLQVET04RpVw12kWrHC/vMDqu2bHzT8ID0B7WwnLkL9XMKresHXw90D5RMIlMtekOp29kx8xtqhXg1+cFfNEu2e6OSOaGvQLJaDs1ulfxUe/J15Dbkgfc1eGU9CjyDdpRqdt7vjM/6yfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2iERGx8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2iERGx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99EEC2BCFB
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131680;
	bh=oprmgku8si+OLXrL/12KBtH9ObDkdjBSzOrFL4VhpNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d2iERGx8VM1zP3Kb70GnbBexBHwHDS5QMKx2rFEZN+WrwaVAaf9afeH+OdN8+AE0N
	 ARQQeJuYJkZA1DlCrvIYWAG2Isr90yl6RkZGMaRYzmPU3Gm34/w+kHJWOZJ3F3bRxD
	 G2vTGnMjQw+6rHC040pcKkmCZpAZuEgXWcRQwUJIYW6v7jBcmiAQG+OzqtwO3u9LQm
	 gUfGp+iltcrSAZR96m3ANqSLkt163e5wJCq+frgyITWxiMOo38rl3Wed4GJbNnd2n5
	 msDYdXmvEq7ayUdgSWOGhMTaPkna2rhxjbH82WqLVIttC4TE4lOK64fuzTluRKJL6N
	 GDCuS7ugzAAEA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso5795324a12.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:14:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/OQJxe/G9inE04tFWTg8dmb58R9jdxzFhaOXxrxaIM/dyGwnOP9evhrZVYxzu7otRbLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEAvM4LOkeTvOrvwCnExkMF+lQ1AD/DSQ1FWiKEDKA+/GKzGLj
	Edl62zkm6/K6Hq0OiipJa+Zbr7ydcbsF/gojyht1avMjHocijLjyf0y4ZvimB4yaESAwOyzvl62
	+ht4dPDPBNu9EYveKAwPTqsrqYtYv768=
X-Received: by 2002:a17:907:93d4:b0:bd4:c6be:5f2e with SMTP id
 a640c23a62f3a-bd51777c81fmr647770466b.3.1779131679529; Mon, 18 May 2026
 12:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518045916.2988667-1-nikunj@amd.com> <20260518045916.2988667-8-nikunj@amd.com>
 <agtGh82vLu4G6pWI@google.com> <agtgltn2wLNFrS2f@google.com>
In-Reply-To: <agtgltn2wLNFrS2f@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 18 May 2026 12:14:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPtZdgo-BKr0Gc8znWvuJksYgSZFTwgB+aaPStU6q5GZQ@mail.gmail.com>
X-Gm-Features: AVHnY4IvAW1HjTIGgS6qZG99xx51X_nd0jT31RKiPnI3CCQ_h_vVLhu0mdzPrpI
Message-ID: <CAO9r8zPtZdgo-BKr0Gc8znWvuJksYgSZFTwgB+aaPStU6q5GZQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] KVM: SVM: Add Page modification logging support
To: Sean Christopherson <seanjc@google.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="UTF-8"

> > So maybe something like:
> >       /*
> >        * PML is never enabled in hardware for L2. Make sure that an
> >        * unexpected PML write would trigger a PML_FULL VM-Exit.
> >        */
>
> Hmm, I was going to say we should drop the code entirely, but I do think it makes
> sense to set PML_INDEX to -1 to ensure a VM-Exit occurs.
>
> Actually, even better idea, at least for nVMX.  Rather than write '0' for the
> address, which is what I really dislike (bad past-Sean!), we should write -1ull
> so that unexpectedly enabling PML in vmcs02 results in VM-Fail, i.e. don't even
> rely on the WARN for safety.
>
> If SVM has a consistency check on the address, then do the same, otherwise I
> guess just go with setting pml_index to -1 and WARNing on PML_FULL?

Yeah this makes sense to me.

>
> > Also, the above commit also hanlded a PML_FULL VM-Exit as unexpected,
> > maybe we want to do that here as well? Or is that too paranoid?
>
> Not too paranoid.
>
> > Annoyingly, the unexpected exit reason handling is in
> > svm_invoke_exit_handler(), but the guest mode check is in
> > svm_handle_exit(), so if we do that we may need to move some code
> > around.
>
> Why's that?  Oh, if we want to reuse the unexpected exit code.  What about this?

I actually had something different in mind, I was going to suggest
that we move the unexpected exit logic to svm_handle_exit(), and key
off a specific return value from svm_invoke_exit_handler(). Then we
can bypass the whole nested_svm_exit_special() logic in
svm_handle_exit() and jump to unexpected_vmexit.

However, as I was writing a diff, I realized this will get gross
quickly. So I think your suggestion below works.

>
> We don't even have to document the same thing in two different places, because
> the reasoning for nested_svm_exit_special() can and is different.  E.g. even if
> we decided to utilize PML while running L2 (which would be possible, we'd "just"
> have to translate the GPAs), the exits would still need to be routed to KVM.
> Ditto for if we did actually enable PML in vmcb02 on behalf of L1: we'd need to
> remove the check in nested_svm_exit_special(), but not the check in
> svm_invoke_exit_handler() (though the latter's comment would need to be updated).
>
> diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
> index 4ef9bc6a553f..401a0ac44018 100644
> --- arch/x86/kvm/svm/nested.c
> +++ arch/x86/kvm/svm/nested.c
> @@ -1782,6 +1782,13 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
>                 if (nested_svm_is_l2_tlb_flush_hcall(vcpu))
>                         return NESTED_EXIT_HOST;
>                 break;
> +       case SVM_EXIT_PML_FULL:
> +               /*
> +                * All PML full exits are handled by KVM.  KVM emulates PML in
> +                * software for L1, but never enables PML in hardware on behalf
> +                * of L1.
> +                */
> +               return NESTED_EXIT_HOST;
>         default:
>                 break;
>         }
> diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
> index e74fcde6155e..6bcb191d725b 100644
> --- arch/x86/kvm/svm/svm.c
> +++ arch/x86/kvm/svm/svm.c
> @@ -3635,6 +3635,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
>             (u64)exit_code != __exit_code)
>                 goto unexpected_vmexit;
>
> +       /*
> +        * PML is never enabled when running L2, bail immediately if a PML full
> +        * exit occurs as something is horribly wrong.
> +        */
> +       if (unlikely(is_guest_mode(vcpu) && exit_code == SVM_EXIT_PML_FULL))
> +               goto unexpected_vmexit;
> +
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>         if (exit_code == SVM_EXIT_MSR)
>                 return msr_interception(vcpu);
>
