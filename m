Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B638DD3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872617; cv=none; b=HA9k5sSm0iRct3fHtSUxBesRB7JZrAXzf3uS6RdKCwLH+4Y64QOjCqJile76dBp3BBD8AyPehOGqwAyiyF2F22QG3eWwQgqJmDFF8fF40x0mYbCAkvog3OWr1zFxhQJXTCOXeVWnKE882lMensIaRHh+zw+A7he/zvplzTZxXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872617; c=relaxed/simple;
	bh=hwnILhA+UcHVvOA7Mh8zUajGwCOnh/QEUhHuC11MKEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXfY9FCeWKLjPChTqQPYk+7hFQ2NxmV48nssOIGzE4PkbLfgTEEUOT/2IyR3bLd8qAexHfFDmgA3athlB3d0NVltZgp3UkYP656FGQiglV38DcXnWoVgc3uUjk8ObwhjwKzM3BxrdTHUkcQjLvxlghP087Wa8bHE84iTDTyVGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExjgunGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExjgunGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1A1F000E9;
	Wed,  1 Jul 2026 02:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782872615;
	bh=rXisQV6pkpD4p/h9feEvYqzuHysBRezkI5XwLv033fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExjgunGVMo5Dvx7W7fOGnOyKCBT9NrLOUsCUag8zcUQtPPkLkumpRc+JmynSMZVYn
	 Yig/eTIJ49O/T1NZLsn5qTYVNexNAPVdhy5EGOlLWNmrnJdtD0GcvnLn4XWLrhIidJ
	 4pkO3KvoToAQFwXBpyptvdfGL375Dz1/objbTAzTv1mFT8w2tP/wRztATCBLdYmZg6
	 pcuW8zdUWUMXvR1zVat2KX1knfbp8hjMwOihpOUT4i+CGTE7KaDA3dpNgmQN8+r3At
	 hchqnhW2pIA3ZdEBPfQmQ/b+lJmxCaNekeEiTno9yRerTzGIHQiWtpoiXKadKpsC9T
	 tEoaf6Pe7IF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] KVM: riscv: selftests: add Zicfiss/Zicfilp
 extension to get-reg-list test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701020746.170157-9-inochiama@gmail.com>
References: <20260701020746.170157-1-inochiama@gmail.com>
 <20260701020746.170157-9-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:23:34 +0000
Message-Id: <20260701022335.6DD1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing base FWFT extension register in sbi_fwft_landing_pad_regs a=
nd sbi_fwft_shadow_stack_regs.
- [Low] Incorrect struct name referenced in comment for zicfiss_csr_id_to_s=
tr.
--

commit 277e1fec57d15d21d187626b4aa2c8ebecc81e21
Author: Inochi Amaoto <inochiama@gmail.com>

KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-list test

This commit adds Zicfiss and Zicfilp extensions support to the KVM RISC-V=20
get-reg-list selftest. It introduces parsing and printing of related CSRs=20
and SBI FWFT configurations.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 94e33b2ee7963..5963f62ce7302 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c

[ ... ]

> @@ -425,6 +429,18 @@ static const char *smstateen_csr_id_to_str(__u64 reg=
_off)
>  	return NULL;
>  }
> =20
> +static const char *zicfiss_csr_id_to_str(__u64 reg_off)
> +{
> +	/* reg_off is the offset into struct kvm_riscv_cfi_csr */

[Severity: Low]
This isn't a bug, but there appears to be a typo in the comment. Should thi=
s=20
reference struct kvm_riscv_zicfiss_csr instead of struct kvm_riscv_cfi_csr=
=20
as defined in the KVM UAPI headers?

> +	switch (reg_off) {
> +	case KVM_REG_RISCV_CSR_ZICFISS_REG(ssp):
> +		return RISCV_CSR_ZICFISS(ssp);
> +	}
> +
> +	TEST_FAIL("Unknown zicfiss csr reg: 0x%llx", reg_off);
> +	return NULL;
> +}

[ ... ]

> @@ -954,6 +980,18 @@ static __u64 sbi_fwft_pte_ad_hw_updating_regs[] =3D {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(pte_ad_hw_updating.value),
>  };
> =20
> +static __u64 sbi_fwft_landing_pad_regs[] =3D {
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.enable),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.flags),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(landing_pad.value),
> +};
> +
> +static __u64 sbi_fwft_shadow_stack_regs[] =3D {
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.enable),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.flags),
> +	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_STATE | KVM_REG_=
RISCV_SBI_FWFT | KVM_REG_RISCV_SBI_FWFT_REG(shadow_stack.value),
> +};

[Severity: Low]
Is the base FWFT extension register intentionally omitted from these sublis=
ts?=20

Looking at sbi_fwft_pte_ad_hw_updating_regs defined just above, it includes:
KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_=
SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT

Should the base FWFT extension register also be included in=20
sbi_fwft_landing_pad_regs and sbi_fwft_shadow_stack_regs to match the patte=
rn=20
established by other FWFT sublists?

> +
>  static __u64 zicbom_regs[] =3D {
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RIS=
CV_CONFIG_REG(zicbom_block_size),
>  	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_REG_RI=
SCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701020746.1701=
57-1-inochiama@gmail.com?part=3D8
