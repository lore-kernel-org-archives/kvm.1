Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C02F6188
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722756; cv=none; b=AJeYIy5iwgtsTuslegWKve3EkpiX2DqRyjxt/YAqoMUmcde1wEpkEs/+6U/n0Xac88OUKW8iEM87KBGUfsgZrLc0EWHZryVBqTNapFANvcTasq2NgF4stdAPId5meiZ4k+acCRCx5XvU+HsRUyM5OdTCMWTZJ8oS+0LE0bXu9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722756; c=relaxed/simple;
	bh=F4XvBSLLWDzKn/S3WlCxvT8p1TSIXmf9hXfiZEWRMhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=slnKvACe70xI0TaxRn/hURIawlgfCN9xjAuGDHZq61cEZqCga+G090mar1d6oT+cV4rcB/vwYl2L1/cupRQGR3VRq0A5vPqdDSAksEUkGTMM/WwCUcYm1UmNTJBEttNBENaojtOgm4JXifjyChwHiWYmfJDoy7gMKIMKPZpI04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmkoRfi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmkoRfi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9731F0089D;
	Fri, 18 Sep 2026 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789722754;
	bh=Sv9MQB4uanOlet2bYWn2CBdrd7KEwFbeuh++cdQ/yDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FmkoRfi/YwXVO0x+uuQ5jhd4Mlb20lqVBOg9Qs7NnG7G2rD75FdHFnt9wHo4R3I8J
	 +AqGhWQNMSQhL1UFJi7FlLuqXpYTWypH9kp3O9WvAo/ZnTAl32+gc4JCwL9KezydeA
	 ZfSTpoVa2kRuwOT0mdMT/Nt3998BXA8tKlH3pZ8i+eRtvh6i+LL3TFJJB0Jt4Goocf
	 bjAO/iHa1w6pawoLZUUHhd5CGwGK9Y3bPrZA+pIMN1oCVjLjXuZoiSdPXqFyj/pxcS
	 VOJOdAtMloB2StqLze/xp8Q725r4V706XjCkLnZq/ZhuBBMJeuErMwgTauCJLvgtun
	 innE8zqZQ9MBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <2b30c180a7ec1fb22033cc1b89debc36c9f569d0.1789721173.git.zhang_wei@open-hieco.net>
References: <cover.1789721173.git.zhang_wei@open-hieco.net>
 <2b30c180a7ec1fb22033cc1b89debc36c9f569d0.1789721173.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:12:34 +0000
Message-Id: <20260918091234.9A9731F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kvm: nSVM: Stale EXITINFO2 leaked to L1 for Decode Assists and SWI=
NT/ICEBP
- [High] kvm: nSVM: Unconditional CR_VALID injects spurious #GP into 32-bit=
 guests
- [Medium] kvm: nSVM: Missing Decode Assists synthesis for SVM instructions
--

commit 426ea34e024e5747a2d0375a678f4064cd396fdd
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts

This commit adds synthesis of DecodeAssists EXITINFO1 fields for emulated
instruction intercepts such as MOV CR/DR, INTn, and INVLPG when the guest
CPU exposes DecodeAssists capabilities.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -4846,14 +4847,26 @@ static int svm_check_intercept(struct kvm_vcpu *v=
cpu,
>  	if (stage !=3D icpt_info.stage)
>  		goto out;
> =20
> +	decode_assists =3D guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS);
> +
>  	switch (icpt_info.exit_code) {

[Severity: Medium]
Does this switch statement miss several mandatory intercepts defined in the
hardware specification for Decode Assists?

According to AMD APM Vol 2, Table 15-22, Decode Assists also apply to VMRUN,
VMLOAD, VMSAVE, CLGI, STGI, and PAUSE, requiring EXITINFO1 to be explicitly
cleared to 0.

Since these intercepts are omitted, will they fall through to the default
case and leave uninitialized, stale garbage in EXITINFO1 instead of the
architecturally required 0?

>  	case SVM_EXIT_READ_CR0:
>  		if (info->intercept =3D=3D x86_intercept_cr_read)
>  			icpt_info.exit_code +=3D info->modrm_reg;
> +
> +		if (decode_assists)
> +			vmcb->control.exit_info_1 =3D
> +				info->intercept =3D=3D x86_intercept_cr_read ?
> +				CR_VALID | (info->modrm_rm & SVM_EXITINFO_REG_MASK) : 0;

[Severity: High]
Does setting CR_VALID unconditionally here, and below in SVM_EXIT_WRITE_CR0,
inject spurious #GP faults into 32-bit guests?

AMD APM defines Bit 63 (CR_VALID) of EXITINFO1 for CR accesses under
Decode Assists as "1 =3D instruction is 64-bit, 0 =3D instruction is 32-bit=
".

If a 32-bit L2 guest executes a CR access and its general purpose register
happens to have non-zero upper 32 bits (which is permissible), L1 will see
Bit 63 set.

If L1 treats this as a 64-bit instruction, will it read the full 64-bit
vCPU register and fail safety checks (like cr0 & 0xffffffff00000000UL),
resulting in a spurious #GP being injected into L2?

[Severity: High]
Should exit_info_2 also be unconditionally zeroed here when decode_assists
is true?

AMD APM mandates that when Decode Assists is enabled, EXITINFO2 must contain
NextRIP for INTn and ICEBP, and must be 0 for other intercepts like MOV CRx.

Because KVM does not zero exit_info_2 prior to calling svm_check_intercept(=
),
could this retain a stale value in the L2 VMCB from a prior exit (such as a
#NPF faulting GPA) and leak it to L1?

>  		break;
>  	case SVM_EXIT_WRITE_CR0: {
>  		unsigned long cr0, val;
> =20
> +		if (decode_assists)
> +			vmcb->control.exit_info_1 =3D
> +				info->intercept =3D=3D x86_intercept_cr_write ?
> +				CR_VALID | (info->modrm_rm & SVM_EXITINFO_REG_MASK) : 0;
> +
[ ... ]
>  	case SVM_EXIT_SWINT:
> +		if (decode_assists)
> +			vmcb->control.exit_info_1 =3D info->src_val & 0xff;
> +		break;

[Severity: High]
Does this miss setting exit_info_2 for the SWINT intercept?

AMD APM mandates that EXITINFO2 must contain NextRIP for INTn (SVM_EXIT_SWI=
NT)
and ICEBP (SVM_EXIT_ICEBP) when Decode Assists is enabled.

By not setting exit_info_2 =3D info->next_rip for SWINT, and completely
omitting handling for SVM_EXIT_ICEBP, does L1 read the stale EXITINFO2 as
NextRIP?

If L1 relies on this for NextRIP, could it cause L2 to resume at a corrupted
instruction pointer and crash the L2 guest?

>  	case SVM_EXIT_INVLPG:
> +		if (decode_assists)
> +			vmcb->control.exit_info_1 =3D info->invlpg_linear_addr;
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789721173.gi=
t.zhang_wei@open-hieco.net?part=3D2
