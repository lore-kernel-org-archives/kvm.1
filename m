Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBB1F5842
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490151; cv=none; b=ncwliLjZuZoXJ03foWwkkgvsQbxDjwiwnixXe5Ibv2qB4GpLMwo0/sTd38Bgks5RnaubjG1o+HuqmxpHkjVkhm0duLBT5uuROH89Isxi28rzv8SzISBaHccqZ+WJA/Zl19r8dG774bTBeUZ3WFudRYD+WIgklheQ6kqXpdoLt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490151; c=relaxed/simple;
	bh=Oiflha8eA2F0IMZTAad+Zib/bZRgQSLqSJcVuc8adKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqc9I+Jjxnvefk9zn7xb6m1xScHFKhmSUKhdkARwCwKoxMAGY8zIdc9Gq6m0a4YZHOhpzxo9h5Z7f7ihTOnJPts7kcQXtDH82fuOuAi5V3I5d0WR6M+sZ1OvzZtcM3Gyp2QDx3p4s9xy+kb4S9xYu+DJxfjVP2m4l9x8tMhEmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdtnCqOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdtnCqOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD61F000E9;
	Fri, 31 Jul 2026 09:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490149;
	bh=pQ6jxLzObqmnsmO7pAgvveXxjNfanxtx1p5zMC5xuIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdtnCqOVIGpPycCFOSPAIQK9R3KfvGswt1OHgqK2ETFy6051+qu1DPV2LCUtKjspQ
	 xtR4NjX2+BFGohwUzLYZKl4lvPEO3dX2bNAVOTW5FjOu0fJ4XXgCUdQoXvUJgRhqA3
	 JT0YpiFXhQGCvqQQKxP1q+Ka5a3CHr5tQRdqrseS+D5dpnwBX3A4Ji8liL+VY3S4Sr
	 2PU0cJyu9eyDRg3jbONki/+exaZSO2UXpm1Js69uAS5+3tk7nZ9CvXY4+OITGA8S4k
	 BDVkOX3VDve9GwO6+ci01o4bmLzJpiDTGuHN4ZxaVtvEtKl7MjXCyXGP7IU3ADNc/9
	 mbzkv5LgZFjtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] RISC-V: KVM: Split huge pages when dirty logging
 is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731091215.1549430-3-wang.yechao255@zte.com.cn>
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
 <20260731091215.1549430-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:29:08 +0000
Message-Id: <20260731092909.48BD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silent memory attribute corruption occurs on T-Head SoCs when spli=
tting huge pages due to pfn_pte() injecting default PMA bits.
--

--- Patch [2]: [PATCH v5 2/5] RISC-V: KVM: Split huge pages when dirty logg=
ing is enabled ---
commit 6ef4b85b2886ab213f69a407ab338186b408f754
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Split huge pages when dirty logging is enabled

This commit splits huge pages eagerly when enabling dirty logging to avoid
doing it while faulting on write-protected pages. The benefits mirror the
eager page splitting optimizations already present in x86 and arm64.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b0474fcf065aa..01679aef53289 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -337,27 +338,35 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *=
gstage,
> =20
>  		ret =3D gstage_level_to_page_size(gstage, current_level - 1, &child_pa=
ge_size);
>  		if (ret)
> -			return ret;
> +			return need_flush;
> =20
>  		next_ptep =3D kvm_mmu_memory_cache_alloc(pcache);
>  		if (!next_ptep)
> -			return -ENOMEM;
> +			return need_flush;
> =20
>  		for (i =3D 0; i < PTRS_PER_PTE; i++) {
>  			child_pte =3D make_child_pte(huge_pte, i, child_page_size);

[Severity: High]
This isn't a bug introduced by this patch, but does this call to
make_child_pte() incur silent memory attribute corruption on T-Head SoCs?

When splitting a huge page, make_child_pte() in arch/riscv/kvm/gstage.c
adds the child PFN offset to the existing huge_pte like this:

    child_pte |=3D pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));

On T-Head CPUs, the ALT_THEAD_PMA macro hooks into pfn_pte() and
automatically injects default PMA (Physical Memory Attribute) bits when
the provided protection value is 0.

By ORing these injected PMA bits into child_pte (which already contains
the memory attributes from huge_pte), could it create conflicting or
invalid memory types if the original huge page had different attributes
(such as IO memory)? This might cause the hardware to treat memory
mapped IO as cacheable or vice versa, potentially leading to data
corruption or hardware aborts.

>  			set_pte((pte_t *)&next_ptep[i], __pte(child_pte));
>  		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731091215.1549=
430-1-wang.yechao255@zte.com.cn?part=3D2
