Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393F39E6DE
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950469; cv=none; b=TsU4+dwpcjXWujcmUPoM3UWgVOJeBjyZ7KSv3DzqVYKFOY5gy1hA8QjwN8Bg96LBjlKGGWQ7CX02Zerp/PgrccFtuShsQf1WGtFRlbmkx2pXqRSofVtVvydwY8IRQ+VOMhpXTvdHS/zHLgyfFseyOJCgxd3wEG0PIEdB1kNEU1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950469; c=relaxed/simple;
	bh=+ru/mLlPFWt8te+Mak5rNfpMnEFYQNFLPOjZGEGHdLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mlkrll0l3m3m2MGg8veppFFML04WdzJzXS7iGwUQJqNJBQiurnNYv0tqGlojCuAMRjzXm4O+5Wupo4z6HNmU9JTSO+/wCW4l7sQToGDotdhIH1krN4ndllt/T1hcHhFQZ9D48BijKrA3A6+bZTZrc8UDGEbrNdiGRIDFgVEZSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQU/Gk+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQU/Gk+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E521A1F00893;
	Mon,  8 Jun 2026 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950468;
	bh=IbFJzL9O+gwSO3G/kILgFJwwktnbsOA7t47S86UnGjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQU/Gk+ojlrSpGQf5rxOBywKuqnIZdylOb+bX6888C+q105U6dBpF7s0cn6VHJQwS
	 v6DkdVhJtlN+AE84jJeUqRnkeWfwvxnuuHW2tVpMzlqY/Mq+uqp+/8gBz1G9UfecJu
	 9u49BkxTWW0QAiBGnS2O48dfC6bixtqlVQQkk72mpzyGry3ceO06QUziKaDXLYxzYG
	 iREmJfTPf+3tZ/FKEj3saF7vlogMYZ6EZrdxqZjPOVgRxgrixqLSAkImLREcYvN/IJ
	 NSv4AFrC9R4JAW8SOu/4LPbqpH1Lea4iCFtIegpNNYLoCw+vtFD9qMKseaaUma28cr
	 IXGaxZW2OEIxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608201001.65760-1-amachhiw@linux.ibm.com>
References: <20260608201001.65760-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:27:47 +0000
Message-Id: <20260608202747.E521A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional dereference of `vcpu->arch.vcore` in `kvmppc_sanity_=
check()` causes a deterministic kernel panic for Book3S PR and BookE KVM gu=
ests.
- [Medium] Bypassing PCR capability checks corrupts shared VCORE state on o=
lder architectures and inconsistently blocks sibling VCPUs.
--

commit 8aae14bd53c26cd9bec6b3a9d75dc94d32e6e296
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode

This commit detects unsupported arch_compat values early in the guest
initialization path. It sets arch_compat to PVR_ARCH_INVALID and marks
the vCPU as invalid, preventing the guest from running with an invalid
processor compatibility configuration.

Cc: stable@vger.kernel.org # v6.13+

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..f9380ef657500 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
[ ... ]
> @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *v=
cpu, u32 arch_compat)
>  			guest_pcr_bit =3D PCR_ARCH_300;
>  			break;
>  		case PVR_ARCH_31:
> +			guest_pcr_bit =3D PCR_ARCH_31;
> +			break;
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> +				arch_compat =3D PVR_ARCH_INVALID;
> +				goto out;

[Severity: Medium]
When jumping to the out label, the code applies the invalid arch_compat and
a restricted pcr to the shared vcore structure before returning an error.
Since vcore can be shared among multiple vCPUs on older Power architectures,
does this state affect sibling vCPUs?

While kvmppc_sanity_check() marks the current vCPU as insane, sibling vCPUs
might retain sane =3D=3D true. Could they then execute the guest using the
updated pcr and invalid arch_compat state?

> +			}
>  			guest_pcr_bit =3D PCR_ARCH_31;
>  			break;
>  		default:
[ ... ]
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..7e2d489af6423 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -258,6 +258,9 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.pvr)
>  		goto out;
> =20
> +	if (vcpu->arch.vcore->arch_compat =3D=3D PVR_ARCH_INVALID)
> +		goto out;
> +

[Severity: High]
Does this code introduce a null pointer dereference for Book3S PR and BookE
guests?

kvmppc_sanity_check() is a generic helper used across Book3S HV, PR, and
BookE KVM implementations. While vcpu->arch.vcore is populated for Book3S H=
V,
it remains null for Book3S PR and BookE guests.

During vCPU creation for PR or BookE, the initialization sequence sets
vcpu->arch.pvr and calls kvmppc_sanity_check(). Because pvr is non-zero,
execution will reach this check and dereference the null vcore pointer,
which can cause a host panic.

>  	/* PAPR only works with book3s_64 */
>  	if ((vcpu->arch.cpu_type !=3D KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
>  		goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201001.6576=
0-1-amachhiw@linux.ibm.com?part=3D1
