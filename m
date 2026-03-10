Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04F3B27E7
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178650; cv=none; b=oFKEPjZ0qQsROd6sQKA3k1cxN0Jm3oPr2in/QlH5HxKX9vsyw3VBo7J9/pEGcryuPCczRQEFSwytO9yHTYPsyY9ndEtcm8YfXAKFtM9B5uNb4aA9BG4fKhfLxx+wm+TD+xh9ocL6x98phS/7qI2y2hNBTBgmJTPTeAJTAVedVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178650; c=relaxed/simple;
	bh=vi2Qvmf3Zq0oIDMP34elGkN+LcArNOp2egai9DJBBfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baIEC/IOrVdPDzSHItK5gypoVhuzDHNaHM4YWN3p/0d6P0b+1djIaAJPi7jZZuGNLWfcVSvwGsnrhZeWbNX622EcoYy5l8sqvt5Vxv+0S4h0iWjn+8xQ9NU5FkklgJtBKU1vTpV4RT3i8RzoLw9wLExopPYO4/W+sUJG50JyDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiqWOm9i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiqWOm9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A9CC19423
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773178650;
	bh=vi2Qvmf3Zq0oIDMP34elGkN+LcArNOp2egai9DJBBfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PiqWOm9iNzqquK7yF260rL12kHFvc7/a048oZg8MOeUeVERQ9sCzW62zKL5F46MQq
	 rqi4AfHRxbJFy0ktXkq2h7AL54x2DRN0vmuTta2R/jnp9+3THSBCKGceFN2HAH24mv
	 apP2veSBPWrre7tuEArRBKsW7OXk51v/Oi7oQDqJrJT7+eIM34dEgJ/DCYByvO/tKv
	 OTVWlQqKFCO9mcQ9t+HGL38JYHKa6gUxBI6uandyaoZy6vqnAITTq/MzpLCD2Mhrfs
	 M+XAirj9JiXWYPwC4p3/jQzMh0VR+5UtwDwuzstlt+8M5YhqHAsN7+czjJxi+wbQoA
	 oK6Q78jGaOawg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9431300833so694890066b.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:37:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo9ZEQwD7m8HBnoAc0UDBCEmv77XqbaDBCXp1O6l/N9ukMnGRGO/V9DOEHYxD/Ycygzfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9n4NGLplOM9qvy/RX6vX0m4zjEhokpVbnAd/91VFuLf05Rs8
	2ptSGGKHSR/RKnLZbF5Wpc73/pWBQAG7A4RWPcygi95vYB91xtMtWUz9U+9T7CFl9wW0MPVw2yh
	ty5/Xx5oLR9Jlvbp89aae/PwuRoumyPw=
X-Received: by 2002:a17:907:8692:b0:b86:f3d2:efae with SMTP id
 a640c23a62f3a-b972e4f7745mr5608966b.35.1773178648922; Tue, 10 Mar 2026
 14:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
In-Reply-To: <20260310202414.406078-3-pbonzini@redhat.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 14:37:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
X-Gm-Features: AaiRm53nunzZPeKBuLRdmx8nvaIFMefKdOsgKkVNj1gA_JuToYvT0Y8wannWhGg
Message-ID: <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	xinyang@anthropic.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:24=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The VMCB12 is stored in guest memory and can be mangled while in SMM; it
> is then reloaded by svm_leave_smm(), but it is not checked again for
> validity.
>
> Move the check code out of vmx_set_nested_state()
> (the other "not a VMLAUNCH/VMRESUME" path that emulates a nested vmentry)
> and reuse it in svm_leave_smm().

This chunk probably needs to be:

Move the cached vmcb12 control and save consistency checks into a
helper and reuse it in svm_leave_smm().

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
>  arch/x86/kvm/svm/svm.c    |  4 ++++
>  arch/x86/kvm/svm/svm.h    |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 7b61124051a7..de9906adb73b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vc=
pu *vcpu)
>         return __nested_vmcb_check_controls(vcpu, ctl);
>  }
>
> +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> +{
> +       if (!nested_vmcb_check_save(vcpu) ||
> +           !nested_vmcb_check_controls(vcpu))
> +               return -EINVAL;
> +
> +       return 0;
> +}

Nit: if we make this a boolean we could just do:

bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
{
       return nested_vmcb_check_save(vcpu) && nested_vmcb_check_controls(vc=
pu);
}

> +
>  /*
>   * If a feature is not advertised to L1, clear the corresponding vmcb12
>   * intercept.
> @@ -1034,8 +1043,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>         nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
>         nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
>
> -       if (!nested_vmcb_check_save(vcpu) ||
> -           !nested_vmcb_check_controls(vcpu)) {
> +       if (nested_svm_check_cached_vmcb12(vcpu) < 0) {
>                 vmcb12->control.exit_code    =3D SVM_EXIT_ERR;
>                 vmcb12->control.exit_info_1  =3D 0;
>                 vmcb12->control.exit_info_2  =3D 0;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 477fda63653b..95495048902c 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4890,6 +4890,10 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, co=
nst union kvm_smram *smram)
>         vmcb12 =3D map.hva;
>         nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
>         nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
> +
> +       if (nested_svm_check_cached_vmcb12(vcpu) < 0)
> +               goto unmap_save;
> +
>         ret =3D enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, v=
mcb12, false);
>
>         if (ret)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index ebd7b36b1ceb..6942e6b0eda6 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -797,6 +797,7 @@ static inline int nested_svm_simple_vmexit(struct vcp=
u_svm *svm, u32 exit_code)
>
>  int nested_svm_exit_handled(struct vcpu_svm *svm);
>  int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
> +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
>  int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
>                                bool has_error_code, u32 error_code);
>  int nested_svm_exit_special(struct vcpu_svm *svm);
> --
> 2.53.0
>
>
