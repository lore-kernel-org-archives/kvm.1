Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B130C632
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572131; cv=none; b=VzGuHywUKHPIdxrHmClczunQYLK1jZaTlz7uee1+NM/EjtQx52V9q+WKT1E0hjx1FAhLhD+ZonMcCjohvw6tDmHzgO3Td2X+yx75/gMkT1z9mBhpOkcaGK0mCcfGdzL8sBPB2+bnFOv0RFxGSSzUk9fRV4WSXLoo0Fvpbdpuaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572131; c=relaxed/simple;
	bh=WqeTzjzNP6uWyoBdw6zLuim5fGaN/kESzR6j8nUt5O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NTy+WhkmLBgzmktKUSO+QX13RF0o8/hJltQZ3tr4M4CNn3J6YTPCfvv18K9BcrifwoxCfAtaeJI1EFxswwUukmTXde7/jkNNdrOkNDj6UeczmzLHvsD3Eik2tXjZO5dkRule2Plggv0mU7k/0/VIpi/kCsKwvuxHcGQSoXAqV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSkiKM6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSkiKM6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DE41F00A3E;
	Tue, 16 Jun 2026 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572130;
	bh=SvdhAlU1ABbyuPG9w9aS19mGwFq0An8N+2UglQp7FIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSkiKM6kvhpVGg4HMmw0gEVp0XJMCn7/epm0u8Vsx5RPgpHDiZjLTgcrn2P8lmnRk
	 6qLJrPHYC0Ys//+5ki+r4NhuDyfdMQI88b46aQJFn9Thg0FZ/IecpMDEms+XNJ7IJp
	 HjaCOSqSVDl9WO39yk9pIwOu+1CshiQhqozdXby+nNu97InThC2pjnjX7P0fihOu+2
	 EYhdb7kS26NpvGQMW1VK2DpHhg8QwXTETcjhR+4f5NyXEoQJ0Ip6H/1kwqR7e1thQ/
	 KGsx1BRIdcuBi0hDf4hfbqzE0WKfx5OsqV3RXObX8YQ1WkvCfNnMTvp7SAm8ozqa/3
	 4hBSpq3yoACoQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/25] KVM: SVM: Use a static ASID per vCPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-10-yosry@kernel.org>
References: <20260616004155.1435766-10-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:08:49 +0000
Message-Id: <20260616010850.12DE41F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM fails to load on systems where all guest ASIDs are assigned to=
 SEV (`nr_asids =3D=3D max_sev_asid + 1`), breaking SEV-only environments.
--

commit 6e1ef9a91f738606e7d8f9e36c1659d383c52061
Author: Yosry Ahmed <yosry@kernel.org>

KVM: SVM: Use a static ASID per vCPU

This patch switches KVM SVM from dynamic ASID allocation to a static
per-vCPU ASID to avoid full TLB flushes and simplify the code. It introduces
a fallback ASID logic and relies on TLB tag tracking for the pool of
available ASIDs.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 5d4c45d788b54..fae5cb7102010 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -5751,6 +5744,17 @@ static __init int svm_hardware_setup(void)
> =20
>  	kvm_caps.inapplicable_quirks &=3D ~KVM_X86_QUIRK_CD_NW_CLEARED;
> =20
> +	/* Consumes max_sev_asid initialized by sev_hardware_setup() */
> +	min_asid =3D max_sev_asid + 1;
> +	nr_asids =3D cpuid_ebx(SVM_CPUID_FUNC);
> +	r =3D kvm_init_tlb_tags(min_asid, nr_asids - min_asid);

[Severity: High]
Will this cause KVM to fail loading on systems where the BIOS configures all
available guest ASIDs for SEV?

If max_sev_asid equals nr_asids - 1 (a common configuration for cloud
servers dedicated to Confidential VMs), then min_asid will equal nr_asids.
This makes nr_asids - min_asid evaluate to 0.

When kvm_init_tlb_tags() is called with a count of 0, it returns -EINVAL,
which causes svm_hardware_setup() to fail and prevents the KVM module from
loading entirely. Prior to this patch, KVM would successfully load in this
configuration and allow SEV guests to run normally.

> +	if (r)
> +		goto err;
> +
> +	fallback_asid =3D kvm_alloc_tlb_tag();
> +	if (!fallback_asid)
> +		goto err;
> +
>  	for_each_possible_cpu(cpu) {
>  		r =3D svm_cpu_init(cpu);
>  		if (r)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D9
