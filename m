Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56099257459
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310897; cv=none; b=krivHhAQjDQkK9vXwfeyiE3zW5xfbd1cyT0PGc9/0sW9wYSoD/m8FpRHRWcx0ELYHv7drHjvnaPD1/Qz1pfvq/ptlEOxHJZBkxPDXKb0OEYtXT8MxCYxAU6LStJmfM3FcJP5mLkr0UgxnGBa844Ml/mQCQ+u86L/8hxK3ZamYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310897; c=relaxed/simple;
	bh=LCawHvd4xlFGyT2F3h1A1BrNeXG51aFNbA/kf8OXmkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qTLw4UHcZbzXUJv3U3mgjxmcU/1ZGhHN5Loi/8L6QqfQJT4pctLxVsUIAb2jSUFciKuj0ACLtRU31zy4aO3N71ImhgaRwyx+8L+m6pn30d6miqF9y2VYtMFLNeR7EFHeEIwtte40k07elUXYy880jBs4OwW1A/7KqjmOtUOclN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxWp/0xL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxWp/0xL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E099D1F00893;
	Mon,  1 Jun 2026 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780310896;
	bh=Hmu+mGsiw9QZXRwTXTpQOBKtM8SRyTCbjyf6A0TWCgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxWp/0xLuSMOkl32uMJKbQ938J0yYxmAYFgBM4NFILlCJXwuFjfjgMJy1yVTUmVke
	 UnuMo1H2j0ZKMr+w/2jfSvcBUooqDnveHbefnt+lfWYBrUIakKwQWGq+/XdZu/EfVv
	 AJksf0YICfpIEPc5lurOeSnGSfpNmi5y6+Ug+0FK+nC6pa9KozeIF0thESl5LHVrRm
	 XkZIpmSiqqjr3yawtg06Dblr5RAA207YW3Vc6UlVeH1oG3y2lfR4ekVlM3kNpJiImj
	 y+dxrS6taAsrZkvjGv0Z1R4xosuEZs2hS6yuEDEWCKMaOtAs1M/dL2qKOu3sFz+LSH
	 d8dZoW8Q+3o6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] KVM: riscv: selftests: add Zicfiss/Zicfilp
 extension to get-reg-list test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601084336.2601675-8-inochiama@gmail.com>
References: <20260601084336.2601675-8-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:48:15 +0000
Message-Id: <20260601104815.E099D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit adds Zicfiss and Zicfilp extensions to the get-reg-li=
st selftest but completely omits defining their vCPU test configurations, m=
eaning the standalone tests for these extensions are never run.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but KVM statically c=
aches the supported state of FWFT features at vCPU initialization, allowing=
 a guest to use Zicfiss/Zicfilp (and other) FWFT features even after the VM=
M explicitly disables these ISA extensions.
--

commit c2918e7cd002c4f98c92703739dfdfd8015014a7
Author: Inochi Amaoto <inochiama@gmail.com>

KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test

The KVM RISC-V allows Zicfiss/Zicfilp extensions for Guest/VM so
add these extensions to get-reg-list test.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index d88edef77ccfd..4fab3d2d0b433 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
[ ... ]
> @@ -911,6 +921,12 @@ static __u64 sbi_fwft_regs[] =3D {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.enable),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.flags),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value),
>  };

[Severity: High]
This isn't a bug introduced by this patch, but KVM statically caches the
supported state of FWFT features at vCPU initialization, allowing a guest
to use Zicfiss/Zicfilp (and other) FWFT features even after the VMM
explicitly disables these ISA extensions.

During kvm_arch_vcpu_create(), kvm_sbi_ext_fwft_init() statically caches wh=
ether
an FWFT feature is supported by calling its supported() callback (e.g.
riscv_isa_extension_available(vcpu->arch.isa, ZICFILP)):

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_sbi_ext_fwft_init() {
    ...
	if (feature->supported)
		conf->supported =3D feature->supported(vcpu);
    ...
}

The VMM may subsequently disable the underlying ISA extension using
KVM_SET_ONE_REG, which clears the bit in vcpu->arch.isa.

However, the cached conf->supported state is never re-evaluated. When the g=
uest
later attempts to enable the feature via SBI_EXT_FWFT_SET,
kvm_fwft_get_feature() reads the stale true value:

arch/riscv/kvm/vcpu_sbi_fwft.c:kvm_fwft_get_feature() {
    ...
	if (!tconf->supported || !tconf->enabled)
		return SBI_ERR_NOT_SUPPORTED;
    ...
}

Could this allow the guest to bypass the VMM's configuration and trigger
hardware states that were explicitly disabled, violating the virtualization
boundary?

[Severity: Medium]
Are we missing the vcpu test configurations for the Zicfilp and Zicfiss
extensions?

The get-reg-list test suite relies on the vcpu_configs[] array and explicit=
ly
declared configurations to determine which subtests to run:

tools/testing/selftests/kvm/riscv/get-reg-list.c:
struct vcpu_reg_list *vcpu_configs[] =3D {
	&config_sbi_base,
	...
};

While the commit updates filter_reg() and adds the registers to sbi_fwft_re=
gs,
it omits the required KVM_ISA_EXT_SIMPLE_CONFIG() macro definitions for the=
se
extensions and fails to append &config_zicfilp and &config_zicfiss to the
vcpu_configs[] array.

Will this cause the standalone validation for getting/setting these new ISA
extension registers to be silently skipped, leaving a gap in test coverage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601084336.2601=
675-1-inochiama@gmail.com?part=3D7
