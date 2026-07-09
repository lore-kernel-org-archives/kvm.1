Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E821CC58
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626504; cv=none; b=YqZuLnO4KgOgwVpWtvBpdINyCOPOS+xv1HQ4RAH0DZcdSPzEUP/30qxaM5jREC54BIgiGUvWfkZb2DMgi9ErGcMNtvkkYYWJ1q46tNQo+90qukdHBdxay6ihL1y5qeVY3I2rfhawHRHW88krvRxnf7uM7DqIAEk4IXEHbUdWu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626504; c=relaxed/simple;
	bh=Isj+sVIn0WQ9u37dGC1/XXt5rnc4AfXayric6SHvfQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfkyzf/jwzwCXQeRbplNGpC6HZP28hIk/OZ9mpncYoY6V67TNz2JP21ztKrX9M/sFwHUfARLTudAWeSDc6xYqMViAYtC3NtBn9TEJrf0MohBJ+GcGAw/ENQJZHKww2VF4gmgDxpISlpxHk98WGJbTJefpc+25uuqJmSDHyMhD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpJRY9zI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpJRY9zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5631F000E9
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626502;
	bh=FQZitkG6lO0CNiSqusb+9JRiTeUQ6AkjXd1j6PdODzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EpJRY9zIHEuSfeH8uKFk0wbcCLzLdno9u37R3rD7w4uSj/IhdgRNEGQ/47gH/Rrzu
	 ZnBz6QAG61nXL48WSa0UsOb4xgwTfhHcEzdJumDhcnxsGJ6qLqWD/kApGOfjH22TCr
	 c7a6/XMlT8LcJ5cB79o9CkoclqD6CEcngFUIEsInGPzPMBtbjX0j/V/ROt9Tvc9PPv
	 Ys7Ls+BiQtFN4Qci+vJafpQxxysN7q1IQ791L18o+n1UdhXBMLrhAll0jqDyg3ljvU
	 gqQcIVK0OpMiLTyvHptKQ/rFBFZkb0n4uKlVBg1mw9tc6XH1SCJC/GoSaBhCyn0viI
	 G2IXa30/0ZCgw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so254083a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 12:48:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85531Td9kTy1GtziHl+xg/O772M/5iYFah7eM6zmf/0nIUb7ha0yYY/4T8QFJRQr+oIzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwwIuO51mPzaM/WZYbO/7aK7Fpo8sNc6TxIqVblD+l2tZtDGK
	GolODehonQX3g1hLVZYGbk4sI4rSE16SFW7kXsK6yeNggWWnp2kgPcm1ZrK6TA1g90RAVAOTQs3
	qXXdm86NA+3f2AxuwyHeO2+CeR12HMkw=
X-Received: by 2002:a17:906:6a09:b0:c15:e137:d57f with SMTP id
 a640c23a62f3a-c15e137d75emr219720966b.54.1783626501428; Thu, 09 Jul 2026
 12:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709082953.69434-1-shivansh.dhiman@amd.com> <20260709082953.69434-3-shivansh.dhiman@amd.com>
In-Reply-To: <20260709082953.69434-3-shivansh.dhiman@amd.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 9 Jul 2026 12:48:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMxtKYFwmMcTgedrFu2gT+SECmFJaiPFmE5iuRAkxs_jw@mail.gmail.com>
X-Gm-Features: AVVi8CdcGJLc9fv95Y7pPc_RL8-lDAfRhRL90sV4tY9nBPPVL79OEwsibKci-mQ
Message-ID: <CAO9r8zMxtKYFwmMcTgedrFu2gT+SECmFJaiPFmE5iuRAkxs_jw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache
 when unsupported
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, kvm@vger.kernel.org, x86@kernel.org, yosry.ahmed@linux.dev, 
	jmattson@google.com, thomas.lendacky@amd.com, nikunj.dadhania@amd.com, 
	ravi.bangoria@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:32=E2=80=AFAM Shivansh Dhiman <shivansh.dhiman@amd=
.com> wrote:
>
> Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() whe=
n
> the vCPU does not support LBR Virtualization. This lets the cached value =
be
> consumed directly instead of re-checking X86_FEATURE_LBRV on every access=
.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
> Changelog:
> v3:
>  * New patch.
>  * Sanitize V_LBR in the cache and drop the redundant X86_FEATURE_LBRV
>    checks (Yosry Ahmed).
>
> ---
>  arch/x86/kvm/svm/nested.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d3df6b22bfef..84248e6665cf 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_=
vcpu *vcpu,
>         if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>                 to->misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;
>
> +       /* Always clear misc_ctl2 bits that the guest cannot use */

I think the comment here is unnecessary, the comment above for
misc_ctl should already make this clear.

> +       to->misc_ctl2 =3D from->misc_ctl2;
> +       if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))

Do we need to check lbrv here? KVM should not set X86_FEATURE_LBRV if
lbrv=3D0 anyway, right?

> +               to->misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_LBR;
> +
>         to->iopm_base_pa        =3D from->iopm_base_pa & PAGE_MASK;
>         to->msrpm_base_pa       =3D from->msrpm_base_pa & PAGE_MASK;
>         to->tsc_offset          =3D from->tsc_offset;
> @@ -551,7 +556,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_v=
cpu *vcpu,
>         to->event_inj_err       =3D from->event_inj_err;
>         to->next_rip            =3D from->next_rip;
>         to->nested_cr3          =3D from->nested_cr3;
> -       to->misc_ctl2           =3D from->misc_ctl2;
>         to->pause_filter_count  =3D from->pause_filter_count;
>         to->pause_filter_thresh =3D from->pause_filter_thresh;
>
> @@ -738,8 +742,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu,=
 unsigned long cr3,
>
>  bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
>  {
> -       return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
> -               (to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_=
LBR);
> +       return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LB=
R;
>  }
>
>  static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
> --
> 2.43.0
>
>
