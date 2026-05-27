Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDF390205
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863632; cv=none; b=ia2Kd1wBbvvYuRHoJzQHvEMAbB1fWQ7eOQgWB8BDOo7ojVBQhscgYkSqulaNAtaTu+wXmq2Cy/+4TEIWrR+/aNxhiiJTBrzCqVXNQDXUsgSYjBEQV165DvoNloGKK1x0bbXPbrvQc4Qeq4u2tRMfBXbxLFdztfa2d8grnGaiSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863632; c=relaxed/simple;
	bh=Di57p2d8mm1e9FS3FqEyA3WRW3rSa8huQvwUyH2FPZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7W4+9/YL24ki2g1VRIIPU9SYCxZyiEuSw0GtMkZ0lr2ETmbx32+IyX5WnlkLEK/7KF/8YxNfA/4nGEUDrHgET+wVkP9cDJ5P0QSezIAtW7ztvYPFsNGiKTdoL9LLszTDrg/z70qJHLAW6au8kfo7+Ju5S7YUVDkuwhHdnPDfYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Im29Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Im29Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028AB1F000E9;
	Wed, 27 May 2026 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779863631;
	bh=dYRzvQFui2JnN/3x0y+6TN8lYP3zSXb384CYAztEhnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6Im29NqetBCe2qQYJYkmqB4588QSe0eC8FmCn/g8Xj6cyVkdbSXeIgc1YRCMpQf9
	 rHCREmQJJyu9pxr3ywz5M/rnYryamvNDGCtFuoqAFPNt0zYfi3/NCMExZ9S/sDs02K
	 cqMC79Rs4WPgOP2jnRqOIcgfRL/ZMadNe33njWv1MRwpDc7X9Da26w5SYWHfrT5RZv
	 RV8y2cbzfwxlTCkIlFFkLsGvAc0Qe0iifnTgtRVaGYfbyGiqrUA2AsWUIx1EVDomZL
	 7//NAwDSSjKBLUtYDlhNHVcxqdjIWMRPgTXVtUpa7tkn5ZVc70WOu5fUf44LSt7tSE
	 xt6MZTYAD/S9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] KVM: riscv: selftests: Refactor ISA and SBI
 extension sublist macros
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526-kvm-get_reg_list-v2-v2-2-7940a401454a@sifive.com>
References: <20260526-kvm-get_reg_list-v2-v2-2-7940a401454a@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 06:33:50 +0000
Message-Id: <20260527063351.028AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test configuration name for the RISC-V Vector extension was =
inadvertently changed from "v" to "vector", breaking command-line compatibi=
lity and CI scripts.
--

commit 04b9ab70c63f573228b2b6329b688555ba3e3fd3
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: riscv: selftests: Refactor ISA and SBI extension sublist macros

This commit refactors the get-reg-list test to use unified sublist macros
for ISA and SBI extensions, aiming to eliminate code duplication and improve
maintainability.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8d6fdb5d38b89..cb16c638ce1a1 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -1057,37 +1057,17 @@ static __u64 vector_regs[] =3D {
>  #define SUBLIST_BASE \
>  	{"base", .regs =3D base_regs, .regs_n =3D ARRAY_SIZE(base_regs), \
>  	 .skips_set =3D base_skips_set, .skips_set_n =3D ARRAY_SIZE(base_skips_=
set),}
[ ... ]
> -#define SUBLIST_V \
> -	{"v", .feature =3D KVM_RISCV_ISA_EXT_V, .regs =3D vector_regs, .regs_n =
=3D ARRAY_SIZE(vector_regs),}
> +
> +#define SUBLIST_ISA(ext, extu)				\
> +	{						\
> +		.name =3D #ext,				\
> +		.feature =3D KVM_RISCV_ISA_EXT_##extu,	\
> +		.regs =3D ext##_regs,			\
> +		.regs_n =3D ARRAY_SIZE(ext##_regs),	\
> +	}

[ ... ]

> @@ -1153,10 +1131,10 @@ KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
>  KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
>  KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
> =20
> -KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
> -KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
> -KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
> -KVM_ISA_EXT_SUBLIST_CONFIG(v, V);
> +KVM_ISA_EXT_SUBLIST_CONFIG(aia, SSAIA);
> +KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, F);
> +KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, D);
> +KVM_ISA_EXT_SUBLIST_CONFIG(vector, V);

[Severity: Medium]
Does this inadvertently change the configuration name exposed to users from
"v" to "vector"?

Since the SUBLIST_ISA macro uses #ext to stringify the name, calling
KVM_ISA_EXT_SUBLIST_CONFIG(vector, V) sets the name to "vector" rather than
keeping the original "v".

This changes the user-facing CLI configuration name, which might break
backwards compatibility for anyone invoking ./get-reg-list --config v or CI
scripts that rely on the old name.

Could we keep the test configuration name as "v" to avoid breaking
command-line compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-kvm-get_re=
g_list-v2-v2-0-7940a401454a@sifive.com?part=3D2
