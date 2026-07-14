Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB833D505
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007102; cv=none; b=qF67SRvNQfPE4nY59Zdjtq4vo85Hq+G9ZiUCH7mu5iS3+KBvgo4zFUT9CgIChiDcJIP7CPAhQXT5T0AzWZagLF6WVpn6zDndN9c0OBkyFqYEZuY3oxDXcwEbxI9EdNxFBlLHzm4b2OBE2dHJtxIUZQQEJb9FJ0/OOrd28UqmK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007102; c=relaxed/simple;
	bh=NuLOQQ9uj8nSNuss3cM41x4Tn+RPWxHyhBUr/PuIsdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kjtf3hnBoOzC1wQcwM93rh4y2vvEJ38H1uFkX0FCdLVG6lW2aVjn80LVKJ+3EMl5n4KJrZtmQGeQtyyzVSkTkjciR65NhD+r4Dv9UTuhW7OLUN7eKPwq0hv5vP6C/rF7AKvdIOgCtbQz80a5nvKMiRI3IYrSWFePpfU43yVu/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLLtcLDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLLtcLDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5813C1F000E9;
	Tue, 14 Jul 2026 05:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007100;
	bh=qfKecvsecQPKjn0H11b6v5jSRMwbjMY/A/COX7IrAWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLLtcLDnJYE+6VpkLmXjnJhUAw996wGbEtmSkpTEQ6E134LMGifRGsY9dMrQRakve
	 q63PBKllVQ4nI1LLJfWmdwhlMdKzCNIjvmIKSlNEJTreWkd17CH4WIPB7smHmepc4S
	 eCinNbMwLGMOe3Wi9st+5MTY04QUBeKz58U11mDG1/rwcbE5W9ImE7sbECUlIOivGk
	 s0MeGhytIWwOSDQcfeMnddciHHozsfWPIN0t2p6CRhjimA7AhtliO4xEYKud/5ziqM
	 Kn04QHu+eg5unSG7c9pwEBJ65l+WeIygpoJjLtiMMTI3Ef0Cd+ouYvJcyjWhNJ86hU
	 ILNyPovS66A8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <f794550ecf8a78ce7095d699a7508bc8cc955679.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <f794550ecf8a78ce7095d699a7508bc8cc955679.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:31:39 +0000
Message-Id: <20260714053140.5813C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally setting bit 63 in EXITINFO1 for CR read intercepts.
--

--- Patch [2]: [PATCH v2 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO =
for emulated intercepts ---
commit 12fdeb07951db9a20a07afc60e302f9b9e4fcaca
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts

This commit populates the architectural EXITINFO fields when DecodeAssists =
is=20
exposed to L1 and an emulated intercept occurs. It generates EXITINFO1=20
depending on the intercept type, such as CR/DR accesses and INTn.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e02a38da5296e..cc35afb59623f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -4754,6 +4754,52 @@ static const struct __x86_intercept {
>  #undef POST_EX
>  #undef POST_MEM
> =20
> +static void svm_prepare_decode_assist_exit_info(struct kvm_vcpu *vcpu,
> +						const struct x86_instruction_info *info)
> +{
> +	struct vmcb *vmcb =3D to_svm(vcpu)->vmcb;
> +	u64 exit_info_1;
> +
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
> +		return;
> +
> +	switch (info->intercept) {
> +	case x86_intercept_cr_read:
> +	case x86_intercept_cr_write:
> +		/* MOV CRx: bit 63 set, GPR number in bits 3:0. */
> +		exit_info_1 =3D BIT_ULL(63) | (info->modrm_rm & 0xf);
                ^^^^^^^^^^^
[Severity: High]
Does this code incorrectly set bit 63 of EXITINFO1 for CR reads?

According to the AMD Architecture Programmer's Manual (APM), bit 63 of
EXITINFO1 for a CR intercept indicates the operation type, where 1 means a
write to the CR and 0 means a read from the CR. By unconditionally setting
BIT_ULL(63) for both x86_intercept_cr_read and x86_intercept_cr_write,
wouldn't KVM report CR reads as CR writes to the L1 hypervisor?

If an L2 guest executes a MOV from CR instruction, this could cause the L1
hypervisor to corrupt its shadow CPU state or misbehave, because it will
be provided a malformed EXITINFO1 and handle the event as a write operation
rather than a read.

> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D2
