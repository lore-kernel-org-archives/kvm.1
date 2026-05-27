Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F627A477
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865049; cv=none; b=UylSmnoCuFe/A9Qf6neLfsxkXp40z+tIJxvj4oSzHsRu4D+43ziXt787j4Y6/LjYNnlzBICknmZR1meBaFCKhlJAZsmF+5F0LbqAZ5wlS2UlP/ltGseaaSTKQ82MluS8C2JsWWqqQz5vWuFdZGQR1N/8t7MYA4YlPQyEax2PxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865049; c=relaxed/simple;
	bh=JtacirnZozy1XkAITF/QQo38LmobrtLE7fu3ZS72f5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAWqmHU0Vs0TK7cUbJ/ugF4MR68uiHYY0PR9QHCYBlG8e1mewA2oxRbILvLFusUJHD5S6kQ21VD/sHpLusIUDtUgN1wQPvOj/wtVVVDYD4M8AVqGb8hEN1rsXGNC7kF6xWVtJ9Z3goodPwn6qYjQqIPn4P8EFBsOepmsvwNsgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsL2BUHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsL2BUHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FEA1F000E9;
	Wed, 27 May 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865047;
	bh=Nf4yerjtb+caUDkK7YSE2WmnAwMe8RXAVHvdZh18gHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RsL2BUHW5T197WBBy+EjBks2qyJ8WKlegdQRxzoGnqplVTmu/2mBzuqMmrht5/NwP
	 SutHl6q8ZciQRJB+KGQhw0r02JoK1IbqYrOPAtoa6SYiFCu1TMMblTvLw7yjV+k0EO
	 +9s1Q2E74hcMesTtX2yo3NuiZbJm2DUSQjkiYb7//Es8z54K+0rHTbD5BQ8rLkc+KO
	 TTQL3SSeubCT2CQOWu7CuAKct/IlKiJ3cTtiwzgvVMVIJ9JESQgh/4N1B+rKsPOVEU
	 Cblw4r2XvPKHwIcW/F7g9u/Lv0UbWkoeTOSd5nyVhuf1vdQZo6Teq0FeiQFOXDs0Sj
	 mhgow21zKR48g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526-kvm-get_reg_list-v2-v2-3-7940a401454a@sifive.com>
References: <20260526-kvm-get_reg_list-v2-v2-3-7940a401454a@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 06:57:26 +0000
Message-Id: <20260527065727.33FEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `pointer_masking` FWFT registers are omitted from `filter_re=
g()`, and the logic added to `check_supported_reg()` is misplaced and effec=
tively dead code.
- [Medium] Missing feature type check causes feature ID collision between S=
BI and ISA extensions.
- [Medium] Repurposing `isa_ext_cant_disable` breaks register verification =
and `--list` generation for explicitly enabled extensions.
--

commit ba1aed433b2df20ab7d8eb63190423aadeb18701
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublis=
ts

This commit divides the monolithic SBI FWFT register list into separate
sublists to test specific FWFT features independently. It also adds helpers
to validate register availability based on required ISA extensions and
checks FWFT feature availability at runtime.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index cb16c638ce1a1..6a34320be78c7 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -26,7 +26,21 @@ enum {
>  	KVM_RISC_V_REG_OFFSET_MAX,
>  };
> =20
> -static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> +static bool isa_ext_enabled[KVM_RISCV_ISA_EXT_MAX];
> +
> +bool check_supported_reg(struct kvm_vcpu *vcpu, __u64 reg)
> +{
> +	switch (reg & ~REG_MASK) {
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(pointer_masking.enable):
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(pointer_masking.flags):
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(pointer_masking.value):
> +		return isa_ext_enabled[KVM_RISCV_ISA_EXT_SMNPM];
> +	default:
> +		break;
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
Is this check placed in the wrong function?

When the SMNPM ISA extension is enabled, KVM dynamically exposes the
dependent pointer_masking FWFT registers. Since tests like config_smnpm do
not explicitly request the FWFT pointer_masking sublist, these registers
appear as unexpected new registers and cause test failures.

The check_supported_reg() function is only invoked to pardon expected
registers that are missing from KVM's output. Should these registers
instead be ignored in filter_reg() to prevent false failures on hosts
supporting both FWFT and SMNPM?

[ ... ]
> @@ -148,7 +162,12 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_=
REG(siph):
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_=
REG(iprio1h):
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_=
REG(iprio2h):
> -		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
> +		return isa_ext_enabled[KVM_RISCV_ISA_EXT_SSAIA];

[Severity: Medium]
Does repurposing this array break register verification for explicitly enab=
led
extensions?

Previously, filter_reg() used isa_ext_cant_disable to hide unrequested ISA
extensions that leaked into base tests. By renaming the array and setting it
to true whenever a test explicitly requests an extension, running an
explicit config_aia test sets isa_ext_enabled[KVM_RISCV_ISA_EXT_SSAIA]
to true.

Could this cause filter_reg() to incorrectly filter out all AIA CSRs,
breaking test coverage for these registers and preventing them from being
output by the --list argument?

[ ... ]
> @@ -229,9 +274,15 @@ void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcp=
u_reg_list *c)
>  				goto skip;
>  		}
> =20
> +		if (s->feature =3D=3D KVM_RISCV_SBI_EXT_FWFT) {
> +			feature =3D RISCV_SBI_EXT_REG(KVM_RISCV_SBI_EXT_FWFT);
> +			check_fwft_feature(vcpu, s, feature);
> +		}
> +
>  		switch (s->feature_type) {

[Severity: Medium]
Can this check trigger unintentionally for ISA extensions?

Because ISA and SBI extensions are defined in separate overlapping enums,
KVM_RISCV_SBI_EXT_FWFT shares a numeric ID with an ISA extension. When
iterating over a colliding ISA sublist, this might incorrectly trigger
check_fwft_feature() and issue KVM ioctls meant for the SBI FWFT extension.

Should this condition also verify that s->feature_type =3D=3D
VCPU_FEATURE_SBI_EXT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-kvm-get_re=
g_list-v2-v2-0-7940a401454a@sifive.com?part=3D3
