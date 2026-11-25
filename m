Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641483;
	b=LhCo691gzcmSQWMwSKjUam9HuKGT4zUq2gOTHGe/+ru4lfuk4yQFOXx+rKXVrw0xO3We
	 Bx1hYtX3EP/4z/QUNmGoyeZdIU0xm/NLdTzMmpr/N7LJwjQjKEZGnplSXXIB/e6/GEFz7
	 hRnVGw4wqp725NJG6VGyI/gDMXkIqjF/4C7uaFE79WcAqLSjdjYNcU8qvZ34ziUwjZ0S1
	 QpwFjbCBQh+/fJT7P7SCVT+fZ83q3BsieZf78pG79xRHhQFukA7NpcTz7K7AFw5iZmWo/
	 fFuL9aMu3TocZnlKex9QKLcR0YHk5X9YVxJcHtekKMtqVFtt4+mxRC/px77uOFP0+EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641483;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=r7sDq8J0zfU/uTNsJIrUV+6ziVd/3T8tim5KxuL7pw4=;
	b=hQmeXZIJZLS2SIWOOePF1HyeDRUcsFysxqUEpIjH2F24F80JmlIHDu6M/zV/HN1JAXxP
	 oXRbcvGMkS8tvCDN5gAHAI+Rjqn6Gc28EgtsHN+tbKdvFGQYfDd1wK7nX7o5fulq2BnLr
	 +pslR1b2ApMNrc2Trh3qiW6d0SPqYkclSDPy5h9d3WY2b/YnngAJn/VXNrE5UVF4bDmhe
	 tBPrWUNfofguCM1w/eiTO4AN+7ceHERkKZl2Ey/fJZzULOeq5cBJoGk652Et960BvFQ6r
	 oEY/zQw8mQhnM9sh5mRH1xa2vKYs3rQ7VsI6JwjPV1rF6Q4MvS5b7ZcEO7b9+oe3Vkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J71tk0D2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2673606A33D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J71tk0D2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A91F0093E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795641482;
	bh=r7sDq8J0zfU/uTNsJIrUV+6ziVd/3T8tim5KxuL7pw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J71tk0D2RV/09NtolG0/jle5lqLsHKtfXJwR2pKNryqhecG6V9ZzRuGQtunbZ2ok/
	 GIHbO677NGv8hg8Ag1uePBj2YpV0hEiuQ/zdnVJQeTs84bujSopmfjnQTw8Rz5p7So
	 /66nLRYDKDogTbIz/XmqE6fX26HDJXdyF6dR1kpQB8l1z2MY2tgpXnjOFuzNI+dGlc
	 kSm/teb/lms4uToBHmrBhDIOQjy7qgANd6Cdhc8xx4/SYyV33mbil5kg3OlZ0SH6xd
	 EHRAiYnFIX7no22soODFodKq11PeELdRcD0Ua8gk733qWdT7iytNBzwAllmrjsQ1XG
	 zybtkRnqqu/CQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4395d31228so1064547166b.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:18:02 -0800 (PST)
X-Gm-Message-State: APuU4Z+4IQ/x+tNAFzZIXgdT6Ck5maMx8y62hgKrfgzx7i4P20OIIIev
	TSr+ACi3SoftT4YRINk4NI63rzzPM+2/v0qDWNyYBwIxcbZ4aBCiiQOx3q+GhERHDKZjqUlYB8P
	cHmCJ53rNuB6xVZb3j+5tfgGVcATWbKg=
X-Received: by 2002:a17:906:2a17:b0:c50:f28a:8407 with SMTP id
 a640c23a62f3a-c513aac6733mr1412280166b.42.1795641481714; Wed, 25 Nov 2026
 13:18:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118133741.1185904-1-manuel.andreas@tum.de>
In-Reply-To: <20261118133741.1185904-1-manuel.andreas@tum.de>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Nov 2026 13:17:50 -0800
X-Gmail-Original-Message-ID: <CAO9r8zO480eWUqDA6a-4P_tKv2D9Bd5tKNdG79uUBAVtmT15aw@mail.gmail.com>
X-Gm-Features: Aa3M54o56KCY0rPayR0-_bu0dQ_uGClyPymVArvMykhcTVEEhbyV3a07BiXR39o
Message-ID: <CAO9r8zO480eWUqDA6a-4P_tKv2D9Bd5tKNdG79uUBAVtmT15aw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Reject EVENTINJ of #BR/#OF into a 64-bit L2
To: Manuel Andreas <manuel.andreas@tum.de>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 5:38=E2=80=AFAM Manuel Andreas <manuel.andreas@tum.=
de> wrote:
>
> nested_svm_event_inj_valid_exept() treats BR_VECTOR and OF_VECTOR as
> unconditionally valid for TYPE=3D3 (exception) injection.  However, the A=
PM
> (Vol 2, 15.20) states that injecting an event that is impossible for the
> guest mode, e.g. #BR into a guest in 64-bit mode, makes VMRUN fail with
> VMEXIT_INVALID.  BOUND and INTO are both invalid in 64-bit mode.
>
> Because the check depends on both the control area (EVENTINJ) and the sav=
e
> area (EFER/CR0/CS), add it to nested_svm_check_cached_vmcb12(), which cov=
ers
> both nested VMRUN and RSM, rather than to nested_vmcb_check_controls().
>
> Fixes: 7e79f71bca5c ("KVM: nSVM: Add missing consistency check for EVENTI=
NJ")
> Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
> ---
>  arch/x86/kvm/svm/nested.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1cecb82702e2..c69d334e3c3c 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -378,6 +378,8 @@ static bool nested_svm_event_inj_valid_exept(struct k=
vm_vcpu *vcpu, u8 vector)
>   * set and:
>   * - The type of event_inj is not one of the defined values.
>   * - The type is SVM_EVTINJ_TYPE_EXEPT, but the vector is not a valid ex=
ception.
> + * - The event is impossible in the guest's mode. However this depends o=
n
> + *   save state, see nested_svm_check_event_inj_mode().
>   */
>  static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_=
inj)
>  {
> @@ -398,6 +400,31 @@ static bool nested_svm_check_event_inj(struct kvm_vc=
pu *vcpu, u32 event_inj)
>         return true;
>  }
>
> +/*
> + * #BR and #OF are invalid in 64-bit mode, but not in compatibility mode=
,
> + * hence the CS.L check. VMRUN ignores EFER.LMA and derives
> + * long mode from EFER.LME, CR0.PG and CR4.PAE, so do the same.
> + */
> +static bool nested_svm_check_event_inj_mode(u32 event_inj,
> +                                           struct vmcb_save_area_cached =
*save)
> +{
> +       u32 type =3D event_inj & SVM_EVTINJ_TYPE_MASK;
> +       u8 vector =3D event_inj & SVM_EVTINJ_VEC_MASK;
> +
> +       if (!(event_inj & SVM_EVTINJ_VALID))
> +               return true;
> +
> +       if (!((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG) &&
> +            (save->cr4 & X86_CR4_PAE) && (save->cs.attrib & SVM_SELECTOR=
_L_MASK)))

Why not check these conditions in nested_svm_event_inj_valid_exept()
for BR_VECTOR and OF_VECTOR?

> +               return true;
> +
> +       if (type =3D=3D SVM_EVTINJ_TYPE_EXEPT &&
> +           (vector =3D=3D BR_VECTOR || vector =3D=3D OF_VECTOR))
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
>                                        struct vmcb_ctrl_area_cached *cont=
rol)
>  {
> @@ -488,6 +515,11 @@ int nested_svm_check_cached_vmcb12(struct kvm_vcpu *=
vcpu)
>             !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
>                 return -EINVAL;
>
> +       /* This check requires both save and control state. */
> +       if (CC(!nested_svm_check_event_inj_mode(svm->nested.ctl.event_inj=
,
> +                                               &svm->nested.save)))
> +               return -EINVAL;
> +
>         return 0;
>  }
>
>
> base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
> --
> 2.56.0
>
>
