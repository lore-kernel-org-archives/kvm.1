Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573333262F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042225; cv=none; b=qjXhF1IH8odNl2/oiYrHyI9TpzS1MYGR69e4/cOGRSRji8vgRb0AglPR8sES3KpmT2uiC/jc0dOf+kUNQCmFcM9fzSX2PQUFqPpjwJUvCR6vPYG1hOoFBcM6hp7j69PVqW5zq3gH0JKWn3oiLHGPfHrkaku7jRD5eXsF9ScQ/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042225; c=relaxed/simple;
	bh=0NZc8Z0vgQ5+jxTY1JF1zxuDoGXNv6Adx4bTCoMCk18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGnX6KLn8sLY8JPegZM4hThUpvnqdVHa/ivPzLEfnfbj6J2EvTuHw/h0BcUs9vRnUcWqKwB7ZUrHdMgU70GNQ1vCXViavNdI90Is25KuFu1jQtiMzUNsxMyH7fcXcRrthjTXcpo8hDI/fYGvtHahuivPmwYq/bWPTvYLPJPa0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRQhRbkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRQhRbkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE75B1F00893;
	Fri, 29 May 2026 08:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780042223;
	bh=GqBrqoooknXqKQxjIW4SWAopcbunBPYM8ewDz32mFrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRQhRbkSetNlnKs82hd3moPm5QI8csFAJSDXMFHb5RqVn1wGYqOFSGR9gd1JVUDmQ
	 oq/ySkudbY+MfTgvDXHLUaLDVz8TL++FiX2de+jJKwRxRUnAXf8MbAK5FvIQIDS+XG
	 Sr9bGK5ESW8ywPun5iRTX25+56rO+0JLfcGoJbAT1xfDZdTYAU0EJ0dxYWDfLOEdPK
	 aHf2FxlMO1kgBFFC79cSTiQXuQD+OSxz5+I4hdkZmcsDw6MhtIeXdmNETbRVa59IOT
	 IthXsZIoCGPfKDmPd/y7xRfZWon+oXhElJIl+hkVzVrYLFUdf8WxQ39KVScYHhAQAv
	 pjrM505yWWcVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528-kvm-get_reg_list-v2-v3-3-170969a8599f@sifive.com>
References: <20260528-kvm-get_reg_list-v2-v3-3-170969a8599f@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:10:22 +0000
Message-Id: <20260529081023.AE75B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] FWFT pointer masking registers are incorrectly handled in check_=
supported_reg() instead of filter_reg(), leading to dead code and potential=
 false positive test failures.
--

commit c0f0519ecd25fb69f07c9b166dfd4ccf59ef2905
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublis=
ts

This commit divides the monolithic SBI FWFT register list into separate
sublists to test features independently. It adds check_supported_reg() and
check_fwft_feature() to validate register and feature availability at
runtime. This prevents tests from failing when only a subset of FWFT
features or their dependent ISA extensions are available on a given
platform.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 5033c09201ef1..7ae55fbad29aa 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -27,6 +27,23 @@ enum {
>  };
> =20
>  static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
> +static bool isa_ext_enabled[KVM_RISCV_ISA_EXT_MAX];
> +static bool sbi_ext_enabled[KVM_RISCV_SBI_EXT_MAX];
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
> +		return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT] &&
> +		       isa_ext_enabled[KVM_RISCV_ISA_EXT_SMNPM];
> +	default:
> +		break;
> +	}
> +
> +	return true;
> +}

[Severity: Medium]
Should these pointer masking registers be handled in filter_reg() instead of
here?

When testing the config_sbi_fwft_pointer_masking sublist,
check_fwft_feature() iterates over the expected registers and invokes
__TEST_REQUIRE(!rc, ...) which skips the test if any are missing. This
means the test exits early, and the core loop that calls
check_supported_reg() for missing registers is never reached.

Moving this logic to filter_reg() also seems necessary to avoid false
positive test failures. If a user runs the config_sbi_fwft_misaligned_deleg
configuration on a host where the SMNPM ISA extension cannot be disabled
(isa_ext_cant_disable[SMNPM] =3D=3D true), both FWFT and SMNPM extensions w=
ill
be active. KVM will naturally expose the pointer_masking registers in this
state.

Because they are not in the misaligned_deleg sublist and are omitted from
filter_reg(), will the test incorrectly flag them as unexpected new
registers and fail?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-kvm-get_re=
g_list-v2-v3-0-170969a8599f@sifive.com?part=3D3
