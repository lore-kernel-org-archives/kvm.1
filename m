Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FF3C10A1
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626188; cv=none; b=h3+9JueuU4Efpjq1kIHmwIzOzRstp2qSt2dcl1W8YSBPGuKXqZYuuV+nYmU4/7Xv1Qnn/4Wi+y9H2bIvQIh93QUwyhSN9O4UX2IQ605i6VNtY6w1ly6kQc7y6WPs/GuNhfcGgYUxnKlEb4mr/hjYN2xej2ZhEvoYUYKDkeNVQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626188; c=relaxed/simple;
	bh=7VJwtCwUGgq5uxfOngUog/NWK7GZ4D4WWIiBIZXSk+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCQq0E476dr1dxnDgukAS6w8uwvnn78dDHpZRlA8WujDKBz0VB+PVzlMvUoYdGwkTc2NAyGNqw9jhrhtHa5ACJ26UvowmxyWE+GbWIMhfRsQzyg+9dhbk4CodTv0RvO1Bq2V7Uh27qgVPpPHsS2Y75V+h39Sc4QC9vJ0lYK9rrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpltDg8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpltDg8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD37C1F00A3A
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626185;
	bh=KGIck3rzIJcG9NVXz1czhOYpFV9gzH89xwk4VZVQF0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CpltDg8ulj9ybGxum8xp3wBs2yzlcSmUhiCVj+Owp3TlOH0E3Phr5FHw7/EOzSHNu
	 BlC9MSKEs1h9jtm81HDVG9tdvGRRfmEeRGtG4mYWgVeFg6q7W/0l+hNkJT2+0uWv8X
	 xKn8IUs1mtG59bEnG5eggJvlgKGaq1Mln3XZvxUyGT7+ptkWf/nOuEUe3HaMoCvLAN
	 3PUyc1kxZ9EmmOFxR6iqKPPZPyd9dMXo2sbUAfpplCbyrHYAvUhC0zDPakfSuKEBBw
	 TKTb0vNbsobQaYCADa/dc/btWKMQ3wWoHG1KaKBk726vsk5IE4F+GOTxRM45ctXA++
	 lrK8O4XL3/u+g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15dd4b9132so38443266b.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 12:43:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqnf6QDq2B9PGjgbRLZXlR5iVpqC3SCVvx4hB7fJ8tf1oFmUxptvXvo1rMFzWBBTlfNKXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPg2xXjnQivszM3KuHyaEbHI8dm92NZ6HeMU3D+wTHk5Jhn9z
	6EeRcRMcihklKq11v9V/ULpyoS6g7lcr0gN9/FbufA96Gq4CWlEFjvICHJIL29mZSj7Puj0yK6Q
	mRx69r8uxpzCPCrx0oGwghqzM7bRN2E0=
X-Received: by 2002:a17:907:fd8b:b0:c12:63d6:d287 with SMTP id
 a640c23a62f3a-c15ce11698bmr349598566b.42.1783626184784; Thu, 09 Jul 2026
 12:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-3-shivansh.dhiman@amd.com> <20260709085012.C802D1F000E9@smtp.kernel.org>
In-Reply-To: <20260709085012.C802D1F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 9 Jul 2026 12:42:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOV+9M=REzRSLLE_ZqcyFP5xdaNHmKti1N-SE_Y=8=VpQ@mail.gmail.com>
X-Gm-Features: AVVi8CfObkPo8pWWJdvOE7eiEWaAB1LuUINFbfTYSvm1WPl9Fu8ElUU-1DETd4c
Message-ID: <CAO9r8zOV+9M=REzRSLLE_ZqcyFP5xdaNHmKti1N-SE_Y=8=VpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache
 when unsupported
To: sashiko-reviews@lists.linux.dev
Cc: Shivansh Dhiman <shivansh.dhiman@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:50=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The `SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE` bit is never cleared in `=
vmcb02->control.misc_ctl2` once set, allowing L2 to bypass L1 intercepts or=
 causing host log spam.
> --
>
> --- Patch [2]: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control c=
ache when unsupported ---
> commit 54bf374923da671433d0174e1a9df561ac634275
> Author: Shivansh Dhiman <shivansh.dhiman@amd.com>
>
> KVM: nSVM: Disable LBRV in nested control cache when unsupported
>
> Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() whe=
n
> the vCPU does not support LBR Virtualization. This lets the cached value =
be
> consumed directly instead of re-checking X86_FEATURE_LBRV on every access=
.
>
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index d3df6b22bfefe..84248e6665cfe 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kv=
m_vcpu *vcpu,
> >       if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
> >               to->misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;
> >
> > +     /* Always clear misc_ctl2 bits that the guest cannot use */
> > +     to->misc_ctl2 =3D from->misc_ctl2;
> > +     if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
> > +             to->misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_LBR;
> > +
> >       to->iopm_base_pa        =3D from->iopm_base_pa & PAGE_MASK;
> >       to->msrpm_base_pa       =3D from->msrpm_base_pa & PAGE_MASK;
> >       to->tsc_offset          =3D from->tsc_offset;
>
> While reviewing these updates to misc_ctl2, I noticed a related pre-exist=
ing
> behavior in nested_vmcb02_prepare_control():
>
> arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_control() {
> ...
>         if (!nested_vmcb_needs_vls_intercept(svm))
>                 vmcb02->control.misc_ctl2 |=3D SVM_MISC2_ENABLE_V_VMLOAD_=
VMSAVE;
> ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but does this code leave the
> SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE bit set in vmcb02->control.misc_ctl2 onc=
e it
> has been enabled?
>
> If L1 enables virtual VMLOAD/VMSAVE for L2, KVM sets this bit via bitwise=
 OR.
> On a subsequent nested VMRUN where L1 disables the feature or disables ne=
sted
> paging, KVM correctly tries to set intercepts or clears NP_ENABLE. Howeve=
r,
> it appears to leave V_VMLOAD_VMSAVE set to 1 since there is no else branc=
h
> to clear it, and the vmcb02 page is reused across runs.

It would probably be better code hygiene to clean it, but I don't
think it will actually cause problems.

>
> Could this allow a malicious L2 guest to bypass L1's intercepts for VMLOA=
D and
> VMSAVE,

No it shouldn't, because nested_vmcb02_recalc_intercepts() will
correctly set the intercepts() if nested_vmcb_needs_vls_intercept()
returns true, and the intercepts being set makes V_VMLOAD_VMSAVE a
noop (see the comment in svm_recalc_instruction_intercepts()).

> or cause an L1 guest to spam the host kernel log with SVM_EXIT_ERR by
> toggling NP_ENABLE while V_VMLOAD_VMSAVE remains stuck at 1?

No, IIUC having NP_ENABLED=3D0 also just makes V_VMLOAD_VMSAVE a noop,
and a VMLOAD/VMSAVE will result in a proper VMLOAD/VMSAVE exit, not
SVM_EXIT_ERR, from the APM:

"""
Support for virtualized VMSAVE and VMLOAD is indicated by CPUID
Fn8000_000A_EDX[15]=3D1. When this feature is available, it must be
explicitly enabled by setting bit 1 of VMCB offset 0B8h to 1. This
enable bit is only recognized when the hypervisor is in 64 bit mode,
nested paging is enabled and Secure Encrypted Virtualization is
disabled, otherwise attempted execution of a VMLOAD or VMSAVE in the
guest will result in a #VMEXIT with a VMSAVE/VMLOAD exit code.
"""
