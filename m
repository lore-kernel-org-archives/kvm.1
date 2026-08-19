Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C143CB2E9
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119529; cv=none; b=jcd5x2urfjfHS47W+CLaUNoZdc2zUOJIE7LwNZKrHW1dWXjNI0kp1a1//7AfuspUi+5bdRWB3sb7BzsiNObZPH+Bhsrzpn0k05gouMaigoB16tow8AViq5QaVFfLp4MlU2HMo3F+KYKFsYSvXml3s4LK8OtgHQEQLO9B25Rg7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119529; c=relaxed/simple;
	bh=Oxav8kzvMK9tygaky2TUNAK1HDiglj4wmQ6FAXvOgvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xoz4B1yqHkk4UwP5lYe/1t/anp7GQL7hJ7855OxzA7od70jqkdVPuFKEtfZt7nvxKla7Hm7hta5BDbCqXVgTc/Hk+BSY4yn53BL14R8WwkyptV3ffUempqy1vswAQWQijAR5pbwkD7evUoM9N2y8tquSWk33iQjHnAOMZmR6ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUdjdLja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUdjdLja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601011F00A3D;
	Wed, 19 Aug 2026 06:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119528;
	bh=WHp1GjxUIuZF7x7WbTvDg/3fDPIGAsiYiw3jcm9g6kY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUdjdLjaw+qNZNYZRpLoqSdKX+L9A9G2Fu61hsXWEEC2HBgCRhfkR4MoJrZpdR9UZ
	 J4SQZh9Hqy4eE1OU7Lmw77bwpOdScitVJfzUOC+ufQzj7rpwNVWEBGRWMxWqp9fkK3
	 bIzFnEIY70b9m2cpFszFNmhFS1qkI/H2c8fUHQ4h6xwAZKc+fogYF7hhPdnkuQe+ZX
	 eVsPLOOcnr7Bx68eFCEAcwAYGfjZ4afO25Tw7KkR95MNyZBu7gHbg0L1TtR29nrDvL
	 eY4QSUswvP5e7knTqIPBLC1CplmoCtAtJBWg9+04VaiRl5bCQ+GVkdnjgblCfGEMtM
	 M0J8AIhgZyrzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <083e80aeb0c49620871e719a0ee81a2b80338d96.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <083e80aeb0c49620871e719a0ee81a2b80338d96.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:05:28 +0000
Message-Id: <20260819060528.601011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The population of EXITINFO1 and EXITINFO2 for INVLPG and INVLPGA i=
s incorrectly gated behind the X86_FEATURE_DECODEASSISTS CPU capability.
--

--- Patch [2]: [PATCH v4 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO =
for emulated intercepts ---
commit 03ef081906dd422c2f595e7c28afbf6acdb25b23
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts

This commit populates the architectural EXITINFO fields during an emulated
L1 intercept when DecodeAssists is exposed to L1. It updates EXITINFO1 and
EXITINFO2 for several instructions including MOV CR/DR, INTn, and INVLPG.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4810,6 +4810,52 @@ static const struct __x86_intercept {
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

[Severity: High]
Does this early return prevent INVLPG and INVLPGA from updating EXITINFO1 a=
nd
EXITINFO2 when the guest lacks the Decode Assists feature?

According to the AMD APM, the INVLPG and INVLPGA intercepts populate these
fields unconditionally. If KVM does not expose Decode Assists to the L1
hypervisor, this return might leave EXITINFO1 uninitialized or stale.

When an L2 guest executes INVLPG under these conditions, could the L1
hypervisor receive an incorrect address and flush the wrong shadow page tab=
le
entry?

> +
> +	switch (info->intercept) {
> +	case x86_intercept_cr_read:

[ ... ]

> +	case x86_intercept_intn:
> +		/* INTn: software interrupt number in bits 7:0. */
> +		exit_info_1 =3D info->src_val & 0xff;
> +		break;
> +	case x86_intercept_invlpg:
> +		/* INVLPG: linear address of the target page. */
> +		exit_info_1 =3D info->intercept_linear_addr;
> +		break;
> +	case x86_intercept_invlpga:
> +		/* INVLPGA: the address remains available in guest rAX. */
> +		exit_info_1 =3D 0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	vmcb->control.exit_info_1 =3D exit_info_1;
> +	vmcb->control.exit_info_2 =3D 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D2
