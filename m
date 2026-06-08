Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C43FFADD
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932499; cv=none; b=gFb67Q20Xtvbrn8veJtS6XuF/tPsPv8VrkuSsbwoVGJISjYI6TpXGyX87FQGJVedK0MAxxedoi97H9I48XyavP0L1IqSkXPctQHW4Je0MKjGHnRhLDlvzLgfz/7FfEOH8hr9oW+Egajf/hwfNQQRyiZ0+gLfyM466cNP00fKGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932499; c=relaxed/simple;
	bh=sKyOyRT2Rng3lzNiVirGCNSfNQ1SmgVaUDAGXI2yfZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c4nwWT2xn7l9OIBRfG6FS2G/AnAuOD29u2AnX8s8YjxCexoZ+UCMIuahbGLYObCgR4t7IUrkG6UoVfwP1iZrhhxZqz+PDPY+INarIBCc8+W/ZCSjdAFOMGsNqZ72uVbML/mq1e9gWLGua87NvHLl4lIRBC2JXO2SROkCR6cmImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj9MDURa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj9MDURa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CB31F00898;
	Mon,  8 Jun 2026 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932497;
	bh=cEbk0kRk2UJ+cTe/9b8/Z2nTnC1T5MR4/S3O358ToHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aj9MDURamcQduh4sBte34ILe428b3ObjFkredqWplYFTfI9fhBxSesPKkG62ZHNwo
	 0Tjt+Bc1SUWZgeetymmv0j0j3SDSLA7NCuoQUuwCxTgY0RP4Ik+Ng428oqJBODFJD+
	 lRQgdsfscAaGm2T6p+1b3rYJ/l1GK+Igm2yr0YKADcUHj8VqSTWX/8q9Szur1seJWX
	 GwDAqCguQFtulINB9+McnrHQHZqJEjm9my+kotONw6evd91xJ7Hg42lT7p01C45RE4
	 JNkAo5xmzOGDnaEyCT59GD1XxBasIhjCpPgnehedi2jY9q3QgkGcG3Ku0yqnv2XZrc
	 abc2TfeFdGfEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/60] KVM: SVM: Inject MCEs when Restricted Injection
 is active
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-6-joro@8bytes.org>
References: <20260608144252.351443-6-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:28:16 +0000
Message-Id: <20260608152817.69CB31F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deferring MCE injection bypasses clearing `vcpu->arch.exception.pe=
nding`, triggering a host `WARN_ON_ONCE` and silently dropping the MCE acro=
ss VM-Exits.
- [High] Priority inversion during event evaluation causes multiple doorbel=
l events to be set concurrently, leading to bitwise corruption during cance=
llation.
--

commit 92a79deb45b58e8dfe9005d032cb1b5d2cd5935c
Author: Melody Wang <huibo.wang@amd.com>

KVM: SVM: Inject MCEs when Restricted Injection is active

When Restricted Injection is active, only #HV exceptions can be injected
into the SEV-SNP guest. Detect that, and then follow the #HV doorbell
communication from the GHCB specification to inject the MCEs.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 44be2c9b8286d..17168a145d18b 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -5493,7 +5500,7 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
> =20
>  	/*
>  	 * KVM only injects a single event each time (prepare_hv_injection),
> -	 * so when events.nmi is true, the vector will be zero
> +	 * so when events.nmi is true, the MCE and vector will be zero.
>  	 */
>  	if (hvdb->events.vector)
>  		svm->vmcb->control.event_inj |=3D hvdb->events.vector |
> @@ -5502,6 +5509,9 @@ void sev_snp_cancel_injection(struct kvm_vcpu *vcpu)
>  	if (hvdb->events.nmi)
>  		svm->vmcb->control.event_inj |=3D SVM_EVTINJ_TYPE_NMI;
> =20
> +	if (hvdb->events.mce)
> +		svm->vmcb->control.event_inj |=3D MC_VECTOR | SVM_EVTINJ_TYPE_EXEPT;

[Severity: High]
If multiple events manage to get injected at once, will this bitwise OR
corrupt the exception vector?

For example, if an MCE is blocked but an IRQ is injected, and the injection
is subsequently cancelled, this could bitwise OR MC_VECTOR (0x12) with the
interrupt vector (e.g., 0x0C). For an IRQ vector of 0x0C, this produces 0x1E
combined with SVM_EVTINJ_TYPE_EXEPT, which synthesizes a Security Exception=
=20
(#SX) instead of the intended events.

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed798f..4b6b628efa219 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10794,6 +10794,12 @@ static int kvm_check_and_inject_events(struct kv=
m_vcpu *vcpu,
>  			kvm_update_dr7(vcpu);
>  		}
> =20
> +		if (vcpu->arch.exception.vector =3D=3D MC_VECTOR) {
> +			r =3D static_call(kvm_x86_mce_allowed)(vcpu);
> +			if (!r)
> +				goto out_except;
> +		}

[Severity: High]
Does jumping to out_except here skip clearing the exception queue?

If mce_allowed() returns 0, bypassing the assignment
vcpu->arch.exception.pending =3D false leaves the MCE pending.
At the end of kvm_check_and_inject_events(), KVM unconditionally evaluates:

    WARN_ON_ONCE(vcpu->arch.exception.pending);

which can trigger a host warning.

Furthermore, because the exception isn't propagated but remains pending,
is it silently dropped on the next VM-Exit?

svm_complete_interrupts() unconditionally clears it:

    kvm_clear_exception_queue(vcpu);

> +
>  		kvm_inject_exception(vcpu);
> =20
>  		vcpu->arch.exception.pending =3D false;
> @@ -10801,6 +10807,7 @@ static int kvm_check_and_inject_events(struct kvm=
_vcpu *vcpu,
> =20
>  		can_inject =3D false;
>  	}
> +out_except:
> =20
>  	/* Don't inject interrupts if the user asked to avoid doing so */
>  	if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ)

[Severity: High]
Does jumping to out_except bypass the can_inject =3D false assignment?

If can_inject remains true when an MCE is blocked, KVM proceeds to evaluate
and inject lower-priority events like NMIs or IRQs.

This breaks the assumption in sev_snp_cancel_injection() that only a single
event is injected at a time, potentially leading to the bitwise corruption
mentioned earlier if an IRQ and a blocked MCE overlap during cancellation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D5
