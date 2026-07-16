Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05501279907
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167420; cv=none; b=aMKMRvHthCueIq+BrVKb5Nc70JkR3f+1woyfInfMak2pVGxQ9LEwjmOMNYpesjOuD6WYvtMaW5sqKNtYf/ovA8rOpBiEWwlz3SNoSOItCRTWWNf13RUKrH3phnqkzKiHRITan27p2taFSOotHCAfkct6fpUwl6jk5xzKghPmTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167420; c=relaxed/simple;
	bh=y73vfl3U7Plp6XzBROCFPlQQMxeA9BKYhkSPgxPRcHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HVi2calVM2R+70OpU0JwtdK3KACcXSn1JgGLuJ3Fn/Nmb1KjpBbyW+ohFQXPgzf4HXcnBonKOKK0BYhpGbCnBcsdeBCIQRDhAzkgSdbj18Scj3+GPG2mKyh46G2e+zLw5j5swfg3c3ymjLCoerj7xjSycAxiBkKx65+tayANdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXyRn3/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXyRn3/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888241F000E9;
	Thu, 16 Jul 2026 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784167418;
	bh=YUx6ZfQUHgNOSspkp7gfRVM59I4M8ght0GGJPWctNXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXyRn3/MlzdyLxRAhhtwJy2lMjCniuLxM96SXmw0r9J8bCJIGINSwsT+qFQgYjfYk
	 d0n3hZtioPrVftO8MDPXuMEcjxpTjDlvY4Xx+3obCfjPNaPook47dEZNLy1XAJ6oHa
	 /u+UWhl57Oe6Y8zzkORby3EWmL1Q71FBBBAUXXejitEWpucCTE7igeMyZ6iQNvfCEJ
	 Fpt8iArkxPf6u1Zz6ni5aYkzsl5YlrodiQzCY6iwyXNzklMNiYITAtKLH/S4Ad3mMB
	 +855La4b3ajr/btdPcJc2wspTG0TezUC5pjUqQtxrCmM2ppOW/vUNBuEDqSHQpunmZ
	 bF8g1ASqPya9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716013823.3259816-1-maobibo@loongson.cn>
References: <20260716013823.3259816-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 02:03:38 +0000
Message-Id: <20260716020338.888241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Per-vCPU execution state is used to protect VM-wide configuration,=
 allowing malicious userspace to modify PV features while the guest is runn=
ing.
- [High] The enforcement mechanism ensuring all vCPUs use identical PV feat=
ures has been removed, silently allowing cross-vCPU mismatch.
--

--- Patch [1]: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU r=
un ---
commit bf9fe2ebf34418b4704a3fcafd58fb42df1697c5
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Allow to set pv_feature until vCPU run

This patch modifies KVM on LoongArch to allow setting the pv_feature
multiple times during VM creation. The restriction is relaxed so that
features can be modified until the vCPU starts running, which aims to help
with VM migration.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31a..ce6a1b06d50db 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c

[ ... ]

> @@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
>  		if (val & ~valid)
>  			return -EINVAL;
> =20
> -		/* All vCPUs need set the same PV features */
> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) !=3D val))
> +		if ((kvm->arch.pv_features & valid) =3D=3D val)
> +			return 0;
> +
> +		if (vcpu->arch.ran_atleast_once)
>  			return -EINVAL;

[Severity: High]
Can this allow a user space process to modify PV features while the guest is
running?

Because the check in kvm_loongarch_cpucfg_set_attr() uses per-vCPU state
(vcpu->arch.ran_atleast_once) to gate the VM-wide configuration, what
happens if userspace runs vCPU 0 (setting its ran_atleast_once flag to
true), and then invokes KVM_SET_DEVICE_ATTR on vCPU 1 (whose
ran_atleast_once is still false)?

Wouldn't this bypass the check and mutate the VM-wide kvm->arch.pv_features
while vCPU 0 is actively executing?

> -		kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED;
> +
> +		/* All vCPUs need set the same PV features */
> +		kvm->arch.pv_features =3D val;

[Severity: High]
Does this silently mask misconfigurations if userspace sets different
features on different vCPUs?

Without the LOONGARCH_PV_FEAT_UPDATED latch, if userspace configures
different PV features on different unrun vCPUs, it appears KVM will accept
both operations and simply overwrite kvm->arch.pv_features with the latest
value rather than returning an error.

Could this fail to enforce the architectural invariant mentioned in the
comment that all vCPUs must have the same features?

>  		return 0;
>  	default:
>  		return -ENXIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716013823.3259=
816-1-maobibo@loongson.cn?part=3D1
