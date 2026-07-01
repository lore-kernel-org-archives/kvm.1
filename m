Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68D326D65
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872912; cv=none; b=OGtQypRWUA2EscoZp2Jn4mptnyfxcny7xXKoW1tD89C8W1gkoWkzLZsXytjNQX3FtClFS4z52EHNPC8U9JbFvFIVRBaqHy4ouD28iMQpC4yrfoJ5APPJShmvUJyIPImjJSaQ9iSHpfSkgnuAbXIfOG4YiLL3wHPDY+mevU3a0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872912; c=relaxed/simple;
	bh=FZ4873317Pr+shg2VaGIYvk69RuynjD8OYHCTt4+rec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ajw6+0LIxOkJYKwwcHNKJ7i0motXHtvt5Z9SzYxuIt8LKj9Gh2P/jImeulxooMbE9kdkKY5AOoUZmGeS85BTN7WDZ5WthU3ReZCTjREjps2wE15QThLQIzOYKuPCnelYszKd9F2dsGWWNuzVIIrX1j8pLaB9sjnTxtcwnbPi5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLi9f9p+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLi9f9p+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFF21F000E9;
	Wed,  1 Jul 2026 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872911;
	bh=cbIQblnRws4Ab/6XEVbt87D+8YLjbXFJk8bR1XDPprA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLi9f9p+0XzJ7CDURGqGZfECA4zy3smGd0SYjTjXCxtM8eVqVL+CGlbTpO7lF8fuI
	 2vFOGlUoMwxc2uYT1huQoFR+Zr/QvpWZFOJ7OL5mm/l1jzKWnsKh8Ao/1CQ8ZdLPah
	 t9SuHT/a1WTKjUUogS0VW7CBfmyImGat/9w40aA53QWH31dNjOZmGf/LhJGLc6iJm+
	 9ymugjWyDH1u9WzILkVujEKVBO3Wy8HB+frAFT3qukeh92T/pEUBFySwSKZpwr4jZQ
	 jLdnN1BQtWpu6mOKy6J4k7kZcprg4/JXkibFCQMf3mZ2ynXh3foyntpY8WViRlrH8c
	 mTV3PzK5o9ThA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] RISC-V: KVM: Add ssp context save/restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-5-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:28:30 +0000
Message-Id: <20260701022830.DDFF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing addition of the ZICFISS register count in `num_csr_regs()`=
 causes KVM to under-calculate the required register list size, leading to =
an out-of-bounds write during the `KVM_GET_REG_LIST` ioctl.
- [Medium] Modifying CSR_SSP in C code before entering the VCPU assembly lo=
op, and zeroing it upon return, overwrites the host's active Shadow Stack P=
ointer, potentially causing a host kernel panic if the host utilizes Superv=
isor-mode shadow stacks.
- [Medium] The guest's ZICFISS Shadow Stack Pointer (`zicfiss_csr`) is not =
cleared during VCPU context reset, leading to guest state leakage across re=
boots.
--

commit 3d9e79d289458c01fff126fe0b09e2d1859aeecc
Author: Inochi Amaoto <inochiama@gmail.com>

RISC-V: KVM: Add ssp context save/restore

This commit adds ssp context save/restore for guest VCPUs. It also adds the
Zicfiss registers to the ONE_REG interface to allow access from user space.

> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d2a..e5ed3b0e5a55b 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
[ ... ]
> @@ -203,6 +207,9 @@ struct kvm_vcpu_arch {
>  	/* CPU Smstateen CSR context of Guest VCPU */
>  	struct kvm_vcpu_smstateen_csr smstateen_csr;
> =20
> +	/* CPU Zicfiss CSR context of Guest VCPU */
> +	struct kvm_vcpu_zicfiss_csr zicfiss_csr;
> +

[Severity: Medium]
Is the zicfiss_csr structure cleared during a VCPU reset?

Looking at kvm_riscv_vcpu_context_reset() in arch/riscv/kvm/vcpu.c,
it doesn't appear to be zeroed:

	memset(cntx, 0, sizeof(*cntx));
	memset(csr, 0, sizeof(*csr));
	memset(&vcpu->arch.smstateen_csr, 0, sizeof(vcpu->arch.smstateen_csr));

Could this lead to the guest's shadow stack pointer being preserved
across warm reboots or kexec, leaking architectural state?

>  	/* CPU reset state of Guest VCPU */
>  	struct kvm_vcpu_reset_state reset_state;
> =20
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e25..1c2775a4834eb 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -720,6 +720,7 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vc=
pu)
> =20
>  static __always_inline void kvm_riscv_vcpu_swap_in_guest_state(struct kv=
m_vcpu *vcpu)
>  {
> +	struct kvm_vcpu_zicfiss_csr *zicficsr =3D &vcpu->arch.zicfiss_csr;
>  	struct kvm_vcpu_smstateen_csr *smcsr =3D &vcpu->arch.smstateen_csr;
>  	struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
> =20
> @@ -727,10 +728,13 @@ static __always_inline void kvm_riscv_vcpu_swap_in_=
guest_state(struct kvm_vcpu *
>  	vcpu->arch.host_senvcfg =3D csr_swap(CSR_SENVCFG, csr->senvcfg);
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
>  		vcpu->arch.host_sstateen0 =3D csr_swap(CSR_SSTATEEN0, smcsr->sstateen0=
);
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS))
> +		csr_write(CSR_SSP, zicficsr->ssp);

[Severity: Medium]
Since this modifies the host's CSR_SSP while still executing host C code,
will this cause any subsequent host function returns (before entering
assembly) to use the guest's shadow stack?

If the host kernel utilizes hardware shadow stacks for Supervisor mode,
this could result in a host kernel panic from an sspopchk failure.

>  }
> =20
>  static __always_inline void kvm_riscv_vcpu_swap_in_host_state(struct kvm=
_vcpu *vcpu)
>  {
> +	struct kvm_vcpu_zicfiss_csr *zicficsr =3D &vcpu->arch.zicfiss_csr;
>  	struct kvm_vcpu_smstateen_csr *smcsr =3D &vcpu->arch.smstateen_csr;
>  	struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
> =20
> @@ -738,6 +742,8 @@ static __always_inline void kvm_riscv_vcpu_swap_in_ho=
st_state(struct kvm_vcpu *v
>  	csr->senvcfg =3D csr_swap(CSR_SENVCFG, vcpu->arch.host_senvcfg);
>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SMSTATEEN))
>  		smcsr->sstateen0 =3D csr_swap(CSR_SSTATEEN0, vcpu->arch.host_sstateen0=
);
> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS))
> +		zicficsr->ssp =3D csr_swap(CSR_SSP, 0);

[Severity: Medium]
Will hardcoding CSR_SSP to 0 here overwrite the host's shadow stack pointer
rather than correctly restoring the saved host state?

>  }
> =20
>  /*
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index bb920e8923c93..bd59aebc8b2e9 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
[ ... ]
> @@ -688,7 +732,7 @@ static int copy_csr_reg_indices(const struct kvm_vcpu=
 *vcpu,
>  				u64 __user *uindices)
>  {
>  	int n1 =3D sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
> -	int n2 =3D 0, n3 =3D 0;
> +	int n2 =3D 0, n3 =3D 0, n4 =3D 0;
> =20
>  	/* copy general csr regs */
>  	for (int i =3D 0; i < n1; i++) {
> @@ -740,7 +784,25 @@ static int copy_csr_reg_indices(const struct kvm_vcp=
u *vcpu,
>  		}
>  	}
> =20
> -	return n1 + n2 + n3;
> +	/* copy Zicfiss csr regs */
> +	if (riscv_isa_extension_available(vcpu->arch.isa, ZICFISS)) {
> +		n4 =3D sizeof(struct kvm_riscv_zicfiss_csr) / sizeof(unsigned long);
> +
> +		for (int i =3D 0; i < n4; i++) {
> +			u64 size =3D IS_ENABLED(CONFIG_32BIT) ?
> +				   KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
> +			u64 reg =3D KVM_REG_RISCV | size | KVM_REG_RISCV_CSR |
> +					  KVM_REG_RISCV_CSR_ZICFISS | i;
> +
> +			if (uindices) {
> +				if (put_user(reg, uindices))
> +					return -EFAULT;
> +				uindices++;
> +			}
> +		}
> +	}
> +
> +	return n1 + n2 + n3 + n4;
>  }

[Severity: High]
Does num_csr_regs() also need to be updated to include the ZICFISS register
count?

If num_csr_regs() doesn't include the ZICFISS registers, userspace might
allocate a smaller array for KVM_GET_REG_LIST, causing the put_user()
calls above to write past the end of the userspace array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D4
