Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C950E587
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805453; cv=none; b=qHZxka2AFcjKpyr40MuXZKvp3u4BPTZSZ+C02RQbxJnIxiPjW4lrw7APMFvvxch5XtWNsFuogVw/ieoiimRMOdljOmbKsv/Yc88V4Ej3mwBlAcpVHgx1Oa3VtiAdUdgDkzOQgBdy3qzq9veev6HXMoqDPQuZMRJJQxmB50OV/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805453; c=relaxed/simple;
	bh=cV726+1KMuLqhBwQMTDR+IHLtMMtQpnaaYuf9ddneTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rz1oAaPWKAvWinYqhLkieY2XTXptlTk/tjLu+zCpVqxi3h82uenf0kctxOMI5+QWCP4j1S+ES76RNUskiYKGrVGliTqLl3VOU6I3EXyYsEPFSgWwUMmoZE4IBN0PTD0oW1bkGHyMyFRHZjD5sTi6VnxSio2ZaXWVXPtSYvADI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhQx2w3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhQx2w3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6A51F00898;
	Wed, 30 Sep 2026 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790805452;
	bh=/BM8xiv0kY4X41sikdMFT/OLlVALNrGpng/kkhPEDQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OhQx2w3uBQZZFxMCnac2Lt+5e0J7ZEv7HFfjJJwfa15fciTuc3k0ArD9saVm9+ukb
	 axNwXER+K8V6ulwiFJbxlRJw2DGwVOyCNDAH1CRuqNUvl5HvTvRZgFHvsamLBX8GlG
	 9flDBfPEtJqzJIOU+m0RooYpspYModF1tQzbXRyino5HZlHJyBbLifH4botbat2gDf
	 sKpqBGjUFKgCVwBulKcLrJMTJpnMFxdVK4QlRklE3xPqZ7XRwt1EQcaxiyoEU0fTOA
	 zkI5F70QqrJ5E6puUzrDWT2IEc0R06mKC/3LSbmb8fkdToAnR3udJz8yAMaL5xNz4i
	 5qBiveAtk8m0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-4-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-4-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:57:31 +0000
Message-Id: <20260930215732.4F6A51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/kvm: stale APX registers (R16-R31) on KVM_SET_XSAVE
--

commit 589bfa90166bba201eeea61923abb798785e7f3a
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Support APX state for XSAVE ABI

This commit introduces a facility to copy APX state between the VCPU cache
and the userspace buffer. It establishes copy functions to ensure APX state
is properly handled during user ABI interactions.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..0df74422759f8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, =
u64 supported_xcr0)
> +{
> +	union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
> +		return 0;

[Severity: High]
Does this early return leave stale values in the APX registers instead of
initializing them to zero?

When a guest is restored via KVM_SET_XSAVE and the XSAVE payload indicates
the APX state is in its INIT state (the APX bit in the header is 0),
returning early here bypasses zeroing the extended general purpose
registers in vcpu->arch.regs. This can lead to guest state corruption
across snapshot restores or live migration, as the guest might observe
stale non-zero values in R16-R31 when it expects them to be zero.

> +
> +	if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +		return -EINVAL;
> +
> +	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <=3D VCPU_REGS_R31);
> +
> +	memcpy(&vcpu->arch.regs[VCPU_REGS_R16],
> +	       buf + xstate_offset(XFEATURE_APX),
> +	       xstate_size(XFEATURE_APX));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D3
