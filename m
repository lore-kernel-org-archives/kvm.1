Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68690EEC3
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905648; cv=none; b=N1XFwdugKPy+l8iSVbwABjJ0/fsJiYKod9XWEMX9Sr3ahSL+RJ5eWv/WCx6eSRO1Ek+IokjQPIx1eRX35mRqaztib5U42Zv0EzDuhgnpb54VOSBSLXfYlMeiM845ZIH5T3IWzb1ypXYZHQGQ3PS54MUydhXriuppuymQAMc2KuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905648; c=relaxed/simple;
	bh=myd/PzPkOyYLfnK7oW07XCFRgaLvDRXtQ5SBXafS2Do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BuusWxQ8ZoDBVmK7HC77aXtIO9bfsPRA+dooh9Uo7TxY6ikf5GfNJjnCyvyHW5YsTt+Nco11OD+OM2c0oFyLQJE4VcagNlfjcT8XEg2zXekrNYzMf8cArQCec8rp8rN9XOWk2tWCM1pwkTxSfCT7ccG9MDb3aMhhXmlJKN3H34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTlEeaNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTlEeaNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286EE1F00ACF;
	Mon, 13 Jul 2026 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783905647;
	bh=zT7BEwI1+CtWbQQ1ugOL1Mc8pnVOsTjZx4oPkLudBio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTlEeaNS2dIeVeq1pS/97HrW86fPLRSzQpo5trFHvvKh5mMXNpAtgQMRLhKAif7W9
	 d6BoA8VZ7Zc/SHbC3s/gLPln2QHWOw0nBv2za4+iVL/fFHrlmSa7E8wLK6Tu2Bf9sJ
	 03/kqLPvyfHcqLDURwr/z1Rd36zD5eTzsn0yWSwcdPO7Gi+L6E3d9qJkViYBG5RqXL
	 X1j5y0UF/YFDFjFv9FjdnwcXp9eXxrUrKZcLe/zojz1KDb/4rnQtRgFpqiEE839VQM
	 3Y+Z4sHgSPnGGGfJGr4F5rwdsGRbuybPqQvafToOWOc+GWuvXJ/llZF2eteEXiCO7f
	 TQOFrr1tZwP/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] RISC-V: KVM: Add ssp context save/restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713010302.303278-5-inochiama@gmail.com>
References: <20260713010302.303278-1-inochiama@gmail.com>
 <20260713010302.303278-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 01:20:46 +0000
Message-Id: <20260713012047.286EE1F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM exposes the Zicfiss extension (shadow stack) to the guest but =
fails to enable it in the hypervisor environment configuration, making it u=
nusable.
- [Medium] The patch adds a new register to the ONE_REG UAPI but fails to u=
pdate the KVM RISC-V `get-reg-list` selftest.
--

--- Patch [4]: [PATCH v6 4/8] RISC-V: KVM: Add ssp context save/restore ---
commit 1dccefe0c0e59cdb4b3a936e440649fc566ba10e
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add ssp context save/restore
   =20
Add ssp context save/restore for guest VCPUs and also add it to the
ONE_REG interface to allow its access from user space.

> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index a27de850fa4cc..fd4c816976177 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
[ ... ]
> @@ -266,12 +271,15 @@ struct kvm_riscv_sbi_fwft {
>  #define KVM_REG_RISCV_CSR_GENERAL	(0x0 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>  #define KVM_REG_RISCV_CSR_AIA		(0x1 << KVM_REG_RISCV_SUBTYPE_SHIFT)
>  #define KVM_REG_RISCV_CSR_SMSTATEEN	(0x2 << KVM_REG_RISCV_SUBTYPE_SHIFT)
> +#define KVM_REG_RISCV_CSR_ZICFISS	(0x3 << KVM_REG_RISCV_SUBTYPE_SHIFT)

[Severity: Medium]
Will this new CSR subtype cause the KVM get-reg-list selftest to fail?

The get-reg-list test uses a strict list of expected registers. It appears
the new KVM_REG_RISCV_CSR_ZICFISS register subtype is missing from the CSR
identification logic in tools/testing/selftests/kvm/riscv/get-reg-list.c:cs=
r_id_to_str(),
and the new ISA extensions (KVM_RISCV_ISA_EXT_ZICFISS and KVM_RISCV_ISA_EXT=
_ZICFILP)
are missing from the filter_reg() whitelist.

Could this lead to an "Unknown csr reg" failure when the tests are run on a
Zicfiss-capable host?

>  #define KVM_REG_RISCV_CSR_REG(name)	\
>  		(offsetof(struct kvm_riscv_csr, name) / sizeof(unsigned long))
>  #define KVM_REG_RISCV_CSR_AIA_REG(name)	\
>  	(offsetof(struct kvm_riscv_aia_csr, name) / sizeof(unsigned long))
>  #define KVM_REG_RISCV_CSR_SMSTATEEN_REG(name)  \
>  	(offsetof(struct kvm_riscv_smstateen_csr, name) / sizeof(unsigned long))
> +#define KVM_REG_RISCV_CSR_ZICFISS_REG(name)  \
> +	(offsetof(struct kvm_riscv_zicfiss_csr, name) / sizeof(unsigned long))
> =20
>  /* Timer registers are mapped as type 4 */
>  #define KVM_REG_RISCV_TIMER		(0x04 << KVM_REG_RISCV_TYPE_SHIFT)
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..acdb12fcdb69a 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
[ ... ]
> @@ -720,6 +721,7 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vc=
pu)
> =20
>  static __always_inline void kvm_riscv_vcpu_swap_in_guest_state(struct kv=
m_vcpu *vcpu)
>  {
> +	struct kvm_vcpu_zicfiss_csr *zicficsr =3D &vcpu->arch.zicfiss_csr;
>  	struct kvm_vcpu_smstateen_csr *smcsr =3D &vcpu->arch.smstateen_csr;
>  	struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
> =20
> @@ -727,10 +729,13 @@ static __always_inline void kvm_riscv_vcpu_swap_in_=
guest_state(struct kvm_vcpu *
>  	vcpu->arch.host_senvcfg =3D csr_swap(CSR_SENVCFG, csr->senvcfg);
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
>  		vcpu->arch.host_sstateen0 =3D csr_swap(CSR_SSTATEEN0, smcsr->sstateen0=
);
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS))
> +		csr_write(CSR_SSP, zicficsr->ssp);

[Severity: High]
Does KVM need to enable the shadow stack feature in henvcfg to allow the gu=
est
to use it?

It looks like the henvcfg register must be updated to include ENVCFG_SSE wh=
en
the Zicfiss ISA extension is available, similar to the ZICBOZ/ZICBOM
handling in arch/riscv/kvm/vcpu_config.c:kvm_riscv_vcpu_config_ran_once():

	if (riscv_isa_extension_available(isa, ZICBOZ))
		cfg->henvcfg |=3D ENVCFG_CBZE;

Without ENVCFG_SSE set in the hypervisor environment configuration, when a
guest attempts to use shadow stack instructions, won't the hardware inject =
an
illegal instruction exception and potentially crash the guest application or
kernel?

Additionally, it seems SBI_FWFT_SHADOW_STACK is missing from the features[]
array in arch/riscv/kvm/vcpu_sbi_fwft.c. Would this prevent the guest from
dynamically enabling it via the SBI FWFT interface, causing it to receive
SBI_ERR_NOT_SUPPORTED instead?

>  }
> =20
>  static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm=
_vcpu *vcpu)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713010302.3032=
78-1-inochiama@gmail.com?part=3D4
