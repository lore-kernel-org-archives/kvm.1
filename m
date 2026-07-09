Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B33793A6
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626849; cv=none; b=jUiu9VHxKRok5grSFMdliOa6Esxi0yDC/aW17MiGSlA7OAfmM+zN9/c9vtOtTbEHtiwfHx0V4fzyV89XduKk8FFO3aXujcLJHstlqX/LrDS1is6GaWb1pOcaB7yL+pBU+ouQWrDKYsoimQMkgvEZHX0WK0n5XF/TUbOU7I9SK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626849; c=relaxed/simple;
	bh=WNGmcRTGHnY5GfCH6GDmX8QSq8pxw+ysKJc5TtSS95E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMQb9aNLNn7HMnjINxC4iYCzyfKhuKdTxFP71W9LyXeVAmNihC2Z0WQxMrF1EuK3JagrVfIuoII+jdRqZylRRdCuGuzKleMc6eBDR3tnOeNAIuENCt8pXxECxgqXDsi0rB6mUNScl8iZPeeVI4F3BGbWcQnJ76ofvDfdaZncP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIMAttZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIMAttZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46B61F00A3E
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626847;
	bh=nOFy1uHV+NQl46guA9lx1UHXG/tr7s8gJ0WE+G2M0Rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oIMAttZx6N8sGVsrdxK721UR0TUAo3evAfE9N6oz4HjGCc/hxlpATviqrSZrKR4LB
	 y91Y3Az8dGXYgKJwyAmPHaXhLL67o4JvYicRqd7pqZFnNVGgABYDx79DPCntyCozPO
	 Ts4yyIeq7LThGwN8Y8x1F3ppzSBl1cHsPDxwQBUaX2gikIUKlFLvT3YZsATOd1N8Ts
	 V69p6/Xp6jLmkksBgpQ0an2iyhRWEuXMFBBlVBzH+UvOwStmQrE+RP/62qs4cmsane
	 3Q7J7vCyiX6UvA8l72AvlV9gXcpD4ymDz0aXk0V90sefNwI0nAmf804vjEy+PY7SJC
	 PEaZo8uofGzkg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15e3141d02so29707766b.2
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 12:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpMFhUSWeRssoI/ShIFylXmSVY7iWE1bj25sBXnirmi9T70UQFused36B3XC/mWL2gqZXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLi6COrpJqeFt/rbtv1UtfdxA1nOgTGZ0T6CZSrA7wKzAuH7Vj
	Clsj38SZClClSqQcY/5J+p3AJBxlECF6NEjohQ2Is0tX+C0l8p+uvwl9LqtquG4AiSGHBefgHyR
	shNFcvzMuNufCorcw1Dg9Y5t3BLO4Ey8=
X-Received: by 2002:a17:907:6ea6:b0:c15:f005:63fb with SMTP id
 a640c23a62f3a-c15f005718fmr138274366b.3.1783626846658; Thu, 09 Jul 2026
 12:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709082953.69434-1-shivansh.dhiman@amd.com> <20260709082953.69434-2-shivansh.dhiman@amd.com>
In-Reply-To: <20260709082953.69434-2-shivansh.dhiman@amd.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 9 Jul 2026 12:53:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOE6m-G8fmNSTnCcvXpzYvR8Egx3PkM2uSaJcZj8PVLqA@mail.gmail.com>
X-Gm-Features: AVVi8CdNT4WFDLJcpYUCQoK_uqHWvoit2fGW9Lei8EVYq1OHk4LP5qp367fQ9mc
Message-ID: <CAO9r8zOE6m-G8fmNSTnCcvXpzYvR8Egx3PkM2uSaJcZj8PVLqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] KVM: SVM: Refactor svm_update_lbrv()
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, kvm@vger.kernel.org, x86@kernel.org, yosry.ahmed@linux.dev, 
	jmattson@google.com, thomas.lendacky@amd.com, nikunj.dadhania@amd.com, 
	ravi.bangoria@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:31=E2=80=AFAM Shivansh Dhiman <shivansh.dhiman@amd=
.com> wrote:
>
> Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
> 'if' statements, and use nested_vmcb12_has_lbrv() instead of open-coding
> the nested LBRV check.
>
> No functional change intended.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
> Changelog:
> v3:
>  * New patch.
>  * Refactor the enable_lbrv computation into 'if' statements (Yosry Ahmed=
).
>
> ---
>  arch/x86/kvm/svm/nested.c |  2 +-
>  arch/x86/kvm/svm/svm.c    | 10 +++++++---
>  arch/x86/kvm/svm/svm.h    |  1 +
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index c1485c3e691c..d3df6b22bfef 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -736,7 +736,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu,=
 unsigned long cr3,
>         return 0;
>  }
>
> -static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
> +bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)

We might wanna rename this function now that we are exposing it
outside of nested.c, but otherwise this looks good to me:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

>  {
>         return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
>                 (to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_=
LBR);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f..cead8f99d856 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -880,9 +880,13 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
>         bool current_enable_lbrv =3D svm->vmcb->control.misc_ctl2 & SVM_M=
ISC2_ENABLE_V_LBR;
> -       bool enable_lbrv =3D (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) |=
|
> -                           (is_guest_mode(vcpu) && guest_cpu_cap_has(vcp=
u, X86_FEATURE_LBRV) &&
> -                           (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE=
_V_LBR));
> +       bool enable_lbrv =3D false;
> +
> +       if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
> +               enable_lbrv =3D true;
> +
> +       if (is_guest_mode(vcpu) && nested_vmcb12_has_lbrv(vcpu))
> +               enable_lbrv =3D true;
>
>         if (enable_lbrv && !current_enable_lbrv)
>                 __svm_enable_lbrv(vcpu);
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 716be21fba33..8d77c10cf4f6 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -899,6 +899,7 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_sv=
m *svm,
>  void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
>                                     struct vmcb_save_area *save);
>  void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
> +bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu);
>  void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_=
vmcb);
>
>
> --
> 2.43.0
>
>
