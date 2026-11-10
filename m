Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339013;
	b=5MoTGjtnhO3p+wac97saGBOyWFL7Cot1KnW9I4L8llhuYPlz2119Rq9akNmLCr5qu0vG
	 iFpIEIy991ltLGlSOytDag3XwabsQ1z20ukgcYYpBtueWZFldB12DvFVdon5RKUbf3Uos
	 dAVjTOuwF13XDzh5hHDAQdrUQsLpRT+mX5HNNt1cmbid+pnuFURIqNY23iBBJMHplasOs
	 MI1FYj3PBvXZkcG+4CgtR+Hjz9+HL4c9hmoCDea3mef97MPmt0bdNYQshlE/tpB/K7XIY
	 0fDYHGL6BbiJvXOfg9uUYziQze2nbV/231DwQMGsJ4cO39TjLvgvsmxY0AsuJky2iIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339013;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LGPIl1X2938Koi0DR0rm/YsbCnI/0WOoEQgD2bU/dEM=;
	b=SdV85ZKHon0zTu7f/KA8d64W146G15kiBjkQA61/PIQQ2OEn4BVYlzb0vRCRLqUW0g+g
	 ywxWegTzf39UvC3JkvoGKwpbXGftnC0gau7Z7utcHgkMEZ2+p2sNEWCPf0XgBTps8aoDJ
	 lpNGl4hoiJYg/4rOwnLBhghbYmBFZcKQpmEI7mzWCR4jy+0qIw5/22NsXMeF0igC+nRm4
	 wzzEi7Vj4WKvaxgjoYnAoMnU6XqMRwRzFR7CZO8GiKPOMFmhef1clqysP5cvm83Xz3PfP
	 UAqb05WbbtFYMCjQVSc1gGw4nrVQNefZ7PEjy8MmOADR6rusw3KREcAsBd4ko/sRTWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBP3n8Ip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFE606A326
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBP3n8Ip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4B71F008A4
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339012;
	bh=LGPIl1X2938Koi0DR0rm/YsbCnI/0WOoEQgD2bU/dEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IBP3n8IpUOKN570ejMS1wTKMubTQbrYborJlAKacYFBb3RkCQJKF9bFu567TqFwF9
	 WvtZJw2pTmDpuCWySoKkB5DbvxuzMeJVx5bg8W8OWpytajZIn2tS+H5V3Zrb2DyVTJ
	 jjp791kF7/1g3A427A/5b1LKcyHt0k6XuaJzXrX3UincO5dbMUqAnFUM2BJ60XCEVf
	 FOTmc7A7MbEPEmin2NVL8+9gIXUUjXR/YkEG3HEptsjeFs58PlmSEL4u0gslwswFiz
	 tS2A2lEMXpuYfY/zzEImtlFB4WljBKsH2sga/uaVUcXZirubnEfPt7w3VmVXa5gJ/k
	 ObfJhC1Iau6sA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c411e139259so127399066b.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 11:30:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEv3w1S7n6gnSOSD/1h4bSRbNd1rCZfA0mgCxpIPyUQGwKA7lLeTmYp2fQY4a/alg2TvF8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MUFbszvx+aSJoMvpH0HxBmeCF0ZUD4skUNx4jBgh+0CxcC35B
	m1OoTUIrcV4bwTeD/HF011lS6xQxD3wsDP8ziFTuMtq8dIex4539tT6os0eH7cii2W9jPzHLGWW
	1zug+rJJ+Dgy8MU2QJqMoUBPZMh8UqIM=
X-Received: by 2002:a17:906:f5a4:b0:c2a:ad55:b3fa with SMTP id
 a640c23a62f3a-c5066983ae0mr9587466b.7.1794339011019; Tue, 10 Nov 2026
 11:30:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110004037.125692-1-jmattson@google.com> <avNYjOevOv5s2o5k@google.com>
 <CALMp9eQAxDhnJGrxt8MquPKE2jsUzezn+nbRXV7E_OiATFhsow@mail.gmail.com>
In-Reply-To: <CALMp9eQAxDhnJGrxt8MquPKE2jsUzezn+nbRXV7E_OiATFhsow@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Nov 2026 11:29:59 -0800
X-Gmail-Original-Message-ID: <CAO9r8zN6W=95uOEUhzSenbJeBECjWk-HRgX7PSewwJZgfmQLoQ@mail.gmail.com>
X-Gm-Features: AclHuK_PZKyUeReg_hid0eJ_EJBgYl9g5LBEmic378BD6K5Cm1sdvKm6xOKGm0Q
Message-ID: <CAO9r8zN6W=95uOEUhzSenbJeBECjWk-HRgX7PSewwJZgfmQLoQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	John Allen <john.allen@amd.com>, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:18=E2=80=AFAM Jim Mattson <jmattson@google.com> =
wrote:
>
> On Tue, Nov 10, 2026 at 9:56=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Mon, Nov 09, 2026 at 04:40:37PM -0800, Jim Mattson wrote:
> > > Per the APM, "Canonicalization and Consistency Checks,"
> > >
> > >   [t]he following conditions are considered illegal state combination=
s:
> > >
> > >    - CR4.CET=3D1 when CR0.WP=3D0
> > >    - Any reserved bit set in S_CET
> > >    - CR4.CET=3D1 and U_CET.SS=3D1 when EFLAGS.VM=3D1
> > >
> > > Check these conditions in software before trying to VMRUN vmcb02, so =
that
> > > the illegal states result in a #VMEXIT to L1 rather than an exit to
> > > userspace with KVM_EXIT_FAIL_ENTRY.
> > >
> > > Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/=
from vmcb12/vmcb02")
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index af0ef678433d..20ede403b62d 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vc=
pu *vcpu,
> > >       if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
> > >               return false;
> > >
> > > +     if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
> > > +             return false;
> >
> > Why aren't we checking X86_FEATURE_SHSTK here as well? Do we know if
> > older CPUs that didn't support CET had the consistency check?
>
> CR4.CET is reserved if an AMD CPU doesn't have X86_FEATURE_SHSTK.
> Hence, older CPUs without CET support cannot fail the consistency
> check.

Oh I missed this, thanks.

>
> > > +
> > > +     if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> > > +         CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
> > > +             return false;

I wonder if we should clear the cached s_cet based on
X86_FEATURE_SHSTK, similar to how we sanitize some cached control
fields in __nested_copy_vmcb_control_to_cache(). Mostly orthogonal to
this patch tho.

> > > +
> > > +     if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)=
) {
> > > +             u64 u_cet =3D 0;
> > > +
> > > +             if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_ce=
t) &&
> >
> > If X86_FEATURE_SHSTK is not enumerated by the vCPU, then whether or not
> > the consistency check is done depends on ignore_msr. If ignore_msr=3D0,
> > the MSR read will fail and we won't do the consistency check, but if
> > ignore_msr=3D1 the MSR read will silently return 0, so the consistency
> > check will be done but will always succeed.
>
> If X86_FEATURE_SHSTK is not enumerated by the vCPU, then CR4.CET =3D=3D 0
> and this entire block is skipped.

Ack.

> > Instead of this implicit dependency, should we check for
> > X86_FEATURE_SHSTK explicitly?
>
> That seems superfluous.

Given the above, yes.

>
> > Also, if X86_FEATURE_SHSTK is enumberated by the vCPU, and the MSR read
> > fails, the consistency check will silently be skipped. But I don't thin=
k
> > this can/should happen. Maybe we should WARN in this case.
>
> You're right; failure to read the MSR should result in a failed VMRUN,
> and a warning would help triage the failure.
>
> > One last question, in the restore path, the MSR may have not been
> > restored yet, right? Can the consistency check mistakenly fail in this
> > case?
>
> Not with a legal snapshot. Note that on the restore path, the 'save'
> area holds L1 state. Hence, RFLAGS.VM must be clear, because VMRUN
> raises #UD in V8086 mode.

Oh that's subtle, but yes, makes sense. I was going to suggest a
comment, but I can't find a good place for it :)
