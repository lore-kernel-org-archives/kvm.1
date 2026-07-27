Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8842BC2F
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171101; cv=none; b=tAh6816D7OxY7UDOwIGNI1iAKLUPc0PYRwbgn4Jjh2eIBkvMtFF/gElWrv9jPmypTm0oUKh4wphsgoFAOJpZ6glub7Tn1y/nXFtsgnxyk3b9Q7ZXQMdizXFczRGD2zpTN8bSAiw8IazvV4dV6y3ox6QXTm1pyLBADb1rzbZj7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171101; c=relaxed/simple;
	bh=7DmERzS3jAeNuSCORVhbYHbCYuDZXNlJJwGl7oTm95I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3MIMeXNZq2Ntci8qmf0IDsgL3ZfifELYFhi9njoDzDDvR8QsRU0woFOHRp95T6PgxQ8skoByKJfErruT/BjX2D32RVNWMt9Z9byQE7uAYCC6yxOIN5iElNekkZnXo8BTyfMYq6OBRcu455PhDTy9bu/PGEgLT8YiQkcRZEqTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAHtcCYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAHtcCYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC021F00AC4
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171099;
	bh=xxJEZg7vUALjJuP8RoVIiQSVR2Zrzga/oBqizYY9xTI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bAHtcCYEPLLZMcB12uriiK9CeM1tDIud+edM/OOPsFCsd73ujkTWp1xIJeaENrAPT
	 7DozkQDG6X9tfeEJB4HFBQvHSv8FUFnYe8gmCb62xdmaQNB0rHEfAP66VDT9h0oWfu
	 cXjvKyBI1ccNVDFh4yxqpSSPKrAjo8LrdYUeT26krAnVYF0ODNuxaQz/GsNOdzS5uH
	 3ruzuNXWWzsCwtnqBNy+zWvsVHH1WybPRXJ2IG1SrpqjDurmejKRp6pU+NBltqYWIi
	 jrs5kEUFh9VvyoknyTFJFpaDsOXAHt42ehs7Q8iKOUyj3omYXLOPaVGndj7Pta4A4d
	 OpW06MeL5V5dg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69f7130b47dso5090069a12.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:51:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpVqPv6WwCnp6OgSjWOKmwDm6deW5o6VosdWPr8HNjJK9xMuoRB5mzGd9Q6at3p312kEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznEpYxeHQX3kYX5X+dOR/r5JmZIt9lAl8WBBc/+keMM8XVYm4k
	bVEiMYohmiqp8ka2iwetr47sfwZkxMt8Euu1DfHpkEAF6+y4g9BcN2NLZCPhNpZPlBMQdzNPcOs
	/nHpDc0NjCNFC0WQb/lhIy1hLeVvuCqQ=
X-Received: by 2002:a17:907:2684:b0:c15:cee4:5244 with SMTP id
 a640c23a62f3a-c1f1ed4d28bmr438177566b.21.1785171098345; Mon, 27 Jul 2026
 09:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com> <20260724004757.131420-2-seanjc@google.com>
In-Reply-To: <20260724004757.131420-2-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 09:51:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM+8yZaBgTWU7+1hkH05xKB5HXTA_LfL3XufAsmbchfBg@mail.gmail.com>
X-Gm-Features: AUfX_mwlM5e4kOP6Ulc-v-gUb2eG_h55GI6PTI7lcg4kw_x84uqtH3R6cnOk_Rg
Message-ID: <CAO9r8zM+8yZaBgTWU7+1hkH05xKB5HXTA_LfL3XufAsmbchfBg@mail.gmail.com>
Subject: Re: [PATCH 1/6] KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is
 cleared on VM-Exit
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Always check and clear KVM_REQ_GET_NESTED_STATE_PAGES when emulating a
> nested VM-Exit to ensure the request is cleared, even when KVM was built
> with CONFIG_KVM_HYPERV=3Dn, as KVM subtly relies on the "check" to clear
> the flag and thus avoid double-mapping the vmcs12 pages, e.g. if KVM
> manages to bail from VM-Enter without processing the request, and then
> emulates VMLAUNCH or VMRESUME.
>
> Fixes: b4f69df0f65e ("KVM: x86: Make Hyper-V emulation optional")
> Cc: stable@vger.kernel.org
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b5460de4b1a7..f2518d67e7de 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5066,8 +5066,9 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>         /* trying to cancel vmlaunch/vmresume is a bug */
>         kvm_warn_on_nested_run_pending(vcpu);
>
> -#ifdef CONFIG_KVM_HYPERV
> +       /* Note, "checking" the request also clears the request. */

kvm_check_request() is in dire need of a rename.
kvm_test_clear_request()? Then we wouldn't need such a comment.
Obviously not as part of the stable fix, maybe another patch or even
separate from this series? I can also send a patch if you prefer so.

For this patch:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>


>         if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
> +#ifdef CONFIG_KVM_HYPERV
>                 /*
>                  * KVM_REQ_GET_NESTED_STATE_PAGES is also used to map
>                  * Enlightened VMCS after migration and we still need to
> @@ -5075,8 +5076,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>                  * the first L2 run.
>                  */
>                 (void)nested_get_evmcs_page(vcpu);
> -       }
>  #endif
> +       }
>
>         /* Service pending TLB flush requests for L2 before switching to =
L1. */
>         kvm_service_local_tlb_flush_requests(vcpu);
> --
> 2.55.0.229.g6434b31f56-goog
>
