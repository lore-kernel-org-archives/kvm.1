Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3E368D55
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414610; cv=none; b=Xn9lmNGmKHj/mxb8DvhX6L5zYLAfQBenks/7uuuQpNKssqkJAKRBUNWM0gS5yWVtdozWtAH1VcbbZSm3FYkdOTsY8X4ClNqQM3d8+USg6VDx8d78+Q+LADKoJ3CuMPXG8WWcRIlYLEPgAf/giUsMwmTD956zw8TK2gl3QzsuQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414610; c=relaxed/simple;
	bh=+rb+Qejjch8pSWelPedBYB9dsoYEwfkWAproJk0MKac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KukgNgdUrxhrFyKI9sdPqHR36DaWPBFYviOnKn6O+RBsm2L9GOtYfkKqiB+gNsdwtiEjAjXmVQQcLLLo38s+/GdbtOMXuIN18YzEenAWDaBQhNiiCifytxQcIi4Zk3QJsYKo/t7dp8QSDr2k0I7UD5sdfhhfS5Wc4I+jj4dCg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXmycjAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXmycjAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C58B1F00A3F;
	Thu, 30 Jul 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414608;
	bh=GwdeDEXtNbVqmHJbFB80ejbaiZ8PSQT3KngFiYrPyS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZXmycjAU/96jTK5xhtKONOJhqhKEFWO1LJOgHLAntF6KGz/lXDFtabtyXGGGJWufE
	 iizstRY7kuOkovghC85ZAiIYaLBQ9myeRZBxSRP2N3OQPZQa6WxwgXTHeAUN6m4HI0
	 2Hg9mQXAIIuNCbBciItMpuceZJW5WS7QTSzEq9oL98QflJuJLJQ9VubH4qDiRj042/
	 ee0OzwPHABMpnozX4T0psIU45Vj47zel8hPQlBLgr7MI6dptmEW61OsmvBCXxkKQ5q
	 YO4XeGvuwMCCJqhXbkjJWbsKGlKDGbehALvGqLl1fjqCMYhUHNOExx7OYfjIyWM0WY
	 5PMTvz7kvImzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <31fd4e46d29c57b004b635d8e6a23020cc9ba0fb.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <31fd4e46d29c57b004b635d8e6a23020cc9ba0fb.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:30:08 +0000
Message-Id: <20260730123008.9C58B1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Synthesized EXITINFO1 is incorrectly populated for SVM_EXIT_CR0_SE=
L_WRITE intercepts triggered by MOV CR0, violating the AMD APM.
--

--- Patch [2]: [PATCH v3 2/9] KVM: nSVM: Synthesize DecodeAssists EXITINFO =
for emulated intercepts ---
commit 60593c4facd0e8bdc8b0aa501c98449feeced81a
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts

This commit populates the architectural EXITINFO fields when DecodeAssists
is exposed to L1 and KVM synthesizes a nested VM-Exit for emulated
instructions. It targets specific intercepts like MOV CR/DR, INTn, and
INVLPG.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d68cba12c772b..b63234a2feb8d 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4822,6 +4822,52 @@ static const struct __x86_intercept {
[ ... ]
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

[Severity: High]
Will this incorrectly populate exit_info_1 for selective CR0 writes?

In svm_check_intercept(), the exit code can be dynamically upgraded to
SVM_EXIT_CR0_SEL_WRITE for MOV CR0 instructions:

svm_check_intercept() {
        ...
        cr0 =3D vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
        val =3D info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
        if (cr0 ^ val)
                icpt_info.exit_code =3D SVM_EXIT_CR0_SEL_WRITE;
        ...
}

Since svm_prepare_decode_assist_exit_info() is subsequently called and
only checks the original instruction intercept (x86_intercept_cr_write),
could this wrongly populate exit_info_1 with decode assist information
instead of leaving it zero as required by the AMD architecture manual
for SVM_EXIT_CR0_SEL_WRITE?

> +		break;
> +	case x86_intercept_clts:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D2
