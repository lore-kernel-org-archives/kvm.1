Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBB384CDA
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849244; cv=none; b=TRWqVI12/PHPeDpDDjFqowk2OP3KXM4elWq7FjfWAS9/k0fOQGiV8zlGXrG6fsV1I/qL+TnbHxNxQ5fyAjh4EL0RU1oQtbsoKRVebnd7+sAlvLY/Y5m3qPnWmUtTgWObLp9F0HYMOEiaMd3AjeltodaU116KvlimfuTCxA2En2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849244; c=relaxed/simple;
	bh=cbEsXnD7Lw2y1TQkQjWrSyrM8I7Zes/Qfl3pl01FbjY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rBL41TICaVyOq/1PUvYpcuCArgqGmyfjWMTHLI3+EjFZ2twQI/ty9IcFqSNVCZJd3nBp+AIpnd5UJUr0PjbLLrQhNEWIgBMzVxkcL2Rqe3o98kPtYQc4/7vo+MZlWAVaX7/pKu4PckQg5bk9kvF0OgLqZ00OTzyVj7tYJivKUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6nerVBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6nerVBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D15F1F0089B;
	Mon, 12 Oct 2026 23:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849243;
	bh=ewdNC+yeoPnb5BuqZ1al+MrOFuSulvgG6YjR8dxPMi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c6nerVBG9vheDhNfUXKpIVIZZwbuGqrpr1lhNiKOuQj5BMCQOASHNeS0dtYs09lZx
	 Ibe/Snr2aZ0d0aUpLhLAKGbD1K2LqDyHNSuXCD9xgK8cYrP3KVog6tP72Bf4toPFov
	 /9T0G+z2asTzG0bbJIDNcdMAtqgUBH9pivyG8tvziaLhiVyxzdgnDE2ZSFyaMz2qa+
	 j+iByHuz0IUKcTWD6+t3NkpNfKATdMhAYS2NNPL7/bpuaQ82mqvfmpFdy2ymQbQTUW
	 vaiTTAmvH1f5IMBU62jlrmNjCwF0erY9OmdO2CS5NNtfS5ThQVsqe16UMinKwX1XpO
	 wW2Reuc4yREBw==
Message-ID: <sashiko-outbox-168751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/27] KVM: SVM: Use a static ASID per vCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261012233638.2546339-11-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
 <20261012233638.2546339-11-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 23:54:02 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] kvm: svm: source SEV VM retains and uses migrated SEV ASID
--

commit 9452efa2aa9c0c4c26d340a238f30fbe12b3e4cc
Author: Yosry Ahmed <yosry@kernel.org>

KVM: SVM: Use a static ASID per vCPU

Switch from dynamic ASID allocation to a static per-vCPU ASID. The dynamic
ASID allocation logic is now only effectively used when running out of ASIDs
on a CPU, or switching CPUs.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -3875,37 +3868,24 @@ static void svm_set_nested_run_soft_int_state(str=
uct kvm_vcpu *vcpu)
[ ... ]
>  static int pre_svm_run(struct kvm_vcpu *vcpu)
>  {
[ ... ]
>  	if (is_sev_guest(vcpu))
>  		return pre_sev_run(svm, vcpu->cpu);
> =20
> -	/* FIXME: handle wraparound of asid_generation */
> -	if (svm->current_vmcb->asid_generation !=3D sd->asid_generation)
> -		new_asid(svm, sd);
> +	if (unlikely(svm->vmcb->control.asid =3D=3D fallback_asid))
> +		vmcb_set_flush_asid(svm->vmcb);
> =20
>  	return 0;
>  }

[Severity: Critical]
When an intra-host SEV VM migration occurs via KVM_VM_MOVE_ENC_CONTEXT_FROM,
the migration path in sev_vm_move_enc_context_from() transfers the SEV ASID
to the destination VM and marks the source VM as non-SEV by setting
sev->active to false. However, the source vCPUs retain the SEV ASID in their
svm->asid and vmcb->control.asid.

Previously, this was safely mitigated here in pre_svm_run() because the
generation mismatch (the SEV ASID generation was 0) triggered new_asid(),
allocating a new normal ASID for the source vCPU.

By removing the generation check here, does this allow a malicious host
userspace to execute KVM_RUN on the source vCPUs as non-SEV vCPUs while
still using the destination VM's SEV ASID? Could this break SEV
confidentiality and integrity by allowing the host to inject arbitrary
translations or read data from the destination SEV VM's TLB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012233638.2546=
339-1-yosry@kernel.org?part=3D10
