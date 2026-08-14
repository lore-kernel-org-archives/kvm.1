Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD43A3821
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706508; cv=none; b=MLkQqQzbqIWxJ+WZ2oDxLSMQycE+mLO3hXsEYze0O6ZRFdTNcjfi04MyihyYShwhAO3/MJIxG/Ed5hF6zCeV6clnWBR8zq7XWy/c1KYS0ZUZ+T1NS/v9tTITx67yxEBPO9FHvMF2Vk4gt/b1x6Grb1/M5Ta+AbUk5tV2JeVkhes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706508; c=relaxed/simple;
	bh=i7XjwH9in2ggWlQRZtfBqlLLFrYo8SijTub6Wpozhjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O2NFeXWi6SpbxILnTONDeZpScy/rFCOj7CE+hmCJU5SONZXbj637oBUfV0IpObkAhkK8yuFgzwvj9+MKj2z5HwywT+lt0wM6reNEAChdbwByOJAqUcgsrfeo+8/8kDBBP9VmlldK2dD5o+a8CPC5cFIaCgnsarFktggn4Ju4xk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=femG14tE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="femG14tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F15F1F000E9;
	Fri, 14 Aug 2026 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786706504;
	bh=aMQHO0UzkLOR6cl4Enjv+k4f+MyEIaoG9eRFVyJjTzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=femG14tEeIrUYLibJF7elpuL7oj2CAhCjxPum8ad1YJfsxmD2Jl3g++dtdeSVZWNa
	 SKNnEuVHHNH+QCYCiU1vGefsSHUmz/BfBgLPVhEglqjr3jlV10G7UXQf79STe3tNNb
	 ZRPBILjEnm0ueCDKRr+7qSDUaFiF+0Nexir00BNFlOFMzkhqN+sTEAV7P4cMi3tn0k
	 wwH1BUX7fXldBMuzQ+UkUDs7Vvsm/3YjMqX+F75fov9/HYNQPch7bYaHeP9RQXelkh
	 NBVwQWacTCFlB9nlDmtYMeA/r+JEVuF3O5QhhU+vtIoAEncl+hrtFOCpIy/+rkKK+b
	 m6KKCmHFnStZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Avoid overwriting existing G-stage tables
 with huge leaves
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <jinyu.tang@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814105752.565325-1-jinyu.tang@linux.dev>
References: <20260814105752.565325-1-jinyu.tang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 11:21:44 +0000
Message-Id: <20260814112144.7F15F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `-EEXIST` fallback logic incorrectly maps the base 0th page of=
 a Transparent Huge Page (THP) instead of the actual faulting 4K page, caus=
ing the guest to infinitely page fault on the same instruction.
--

--- Patch [1]: [PATCH] KVM: riscv: Avoid overwriting existing G-stage table=
s with huge leaves ---
commit b862a43d3100b276d3d9db5fb9e061641914af1a
Author: Jinyu Tang <jinyu.tang@linux.dev>

KVM: riscv: Avoid overwriting existing G-stage tables with huge leaves

This patch adds a check in kvm_riscv_gstage_set_pte() to prevent replacing
an existing lower-level page table with a huge leaf mapping. If this confli=
ct
occurs, it returns -EEXIST and falls back to installing a 4K mapping for the
faulting GPA instead.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index b0474fcf065aa..af6b469718eb6 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c

[ ... ]

> @@ -287,7 +294,18 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gst=
age,
>  	out_map->pte =3D pfn_pte(PFN_DOWN(hpa), prot);
>  	out_map->pte =3D pte_mkdirty(out_map->pte);
> =20
> -	return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
> +	ret =3D kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
> +	if (ret =3D=3D -EEXIST) {
> +		huge_page_offset =3D out_map->addr & (page_size - 1);
> +		hpa +=3D huge_page_offset;

[Severity: High]
Does this calculation result in an offset of 0 when handling Transparent
Huge Pages (THPs)?

When a guest faults on a GPA backed by a THP, kvm_riscv_mmu_map() calls
transparent_hugepage_adjust(), which aligns the gpa down to the PMD boundar=
y:

arch/riscv/kvm/mmu.c:transparent_hugepage_adjust() {
    ...
    *gpa &=3D PMD_MASK;
    ...
}

Because out_map->addr is derived from this heavily-aligned gpa,
out_map->addr & (page_size - 1) will always evaluate to 0.

If the fallback mistakenly installs a 4K mapping at the base physical
address (hpa +=3D 0) instead of the actual faulting offset within the huge
page, will the guest continuously fault on the same instruction when
attempting to access a non-zero offset, causing an infinite page fault
loop?

> +		out_map->level =3D 0;
> +		out_map->pte =3D pfn_pte(PFN_DOWN(hpa), prot);
> +		out_map->pte =3D pte_mkdirty(out_map->pte);
> +
> +		ret =3D kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814105752.5653=
25-1-jinyu.tang@linux.dev?part=3D1
