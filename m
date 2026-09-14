Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EF3B961B
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366937; cv=none; b=FHJdYd2jI5NwOsp0kZ2+oaXRrDsccWmOgbITXAPsQMaT+eS2lnH7YgkaeNaqCYmUW7jEZ8A5X5u9d2DzutIaLCXyfQ365Y3whNI2olS18YrB5sdHaSLX8MmC7fJyGU5pLdcDDLHj2oGr8Eq+m2M4Sxu8cKG1ckjjujx7oU5BWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366937; c=relaxed/simple;
	bh=YGvsDNEZ8wP/8ypm2NPVCLGDt3X1lcYgemprCOJ1z5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kreb8h2S6ka+EkWzTEajteFGItExuPR9ZfKDPxAg6YnE4OSjuE5/+L+4xY0Np9xOlc/OFmkpbhyvCTEv/C3bB3DLZJ0MPU8peOmxWb48J1Xy5m16d835EvQxU63lXWDRxrZQa9+pX7FRLzQjUlJWCwHr7Uvwz0Hc/7RdAsKVawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFaKWchm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFaKWchm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A191F000FF;
	Mon, 14 Sep 2026 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789366935;
	bh=Jz8RqvhJKyDquFwridoQAlcx4+M13XznYyHfSYIQjtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RFaKWchmE8wsF6hXe/pRXbe3VxRNXxshBr+byYinmiuhywJtCS8sTqayYKbgjEMlI
	 LFnyPmeW7spnFixFN/vBubsQUWemJ7M0xBDgaeIZ6mdn9E5O/L1g9IicOvOD3wQrPi
	 kI6Pqm+4JjLfuOMj2sHPWmCG4eQ8xfc1Aq/iRlBGIiV3qp5fpgFDTXQqdNzC2oKyIc
	 gKY3w612oXhECR63ES9TXmqLdxqydwZ+zQySrZLBMgX2DWveds7sxm0QEyYvqej5Vz
	 WhFNJ1OeFD8FIVQ7Iz8hCvnAh2qEOr6P7Mawfu+YuQdiNSS3DlsZ1Uf5VtSmH3B97+
	 ep09lSML3iaVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] RISC-V: KVM: Recover gstage huge page mappings
 during disable-dirty-log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260914055936.3672758-3-wang.yechao255@zte.com.cn>
References: <20260914055936.3672758-1-wang.yechao255@zte.com.cn>
 <20260914055936.3672758-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:22:14 +0000
Message-Id: <20260914062215.65A191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reconstructing huge pages leaves stale 4K TLB entries, which can c=
ause infinite page fault loops.
--

commit adebe96417592e1fb6f444f66872994bafd575bb
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Recover gstage huge page mappings during disable-dirty-log

This commit recovers gstage huge page mappings when dirty logging is disabl=
ed.
It is intended to restore vm performance to pre-dirty-logging levels if a
migration fails or is canceled.

> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index e5002cb9cbef1..2bbe052b97806 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
[ ... ]
> +bool kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
> +				   unsigned long target_page_size,
> +				   unsigned long *page_size)
> +{
[ ... ]
> +	for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +		child_ptep =3D (pte_t *)&next_ptep[i];
> +		if (!gstage_pte_leaf(child_ptep))
> +			continue;
> +
> +		huge_pte =3D make_huge_pte(pte_val(ptep_get(child_ptep)),
> +					 i, target_page_size / PTRS_PER_PTE);
> +		set_pte(ptep, __pte(huge_pte));
> +		gstage_tlb_flush(gstage, target_level, addr);

[Severity: High]
Does this tlb flush leave stale 4KB entries in the hardware tlb?

When dirty logging is enabled, a 2MB huge page is split into 4KB read-only
pages. If dirty logging is then disabled and kvm reconstructs the 2MB huge
page by replacing the non-leaf pte with a 2MB leaf pte, this code calls
gstage_tlb_flush() for the target level.

This passes the huge page order to kvm_riscv_local_hfence_gvma_vmid_gpa(),
which executes a single hfence.gvma instruction for the 2MB-aligned base
address. Because hfence.gvma with a specific address only invalidates
translations matching exactly that address, could the 4KB tlb entries for
sub-pages (like addr + 4KB) remain cached in the hardware tlb?

If the guest attempts to write to one of these stale 4KB pages, it triggers
a guest store page fault. The kvm page fault handler checks the gstage page
tables, observes the new 2MB pte is already writable, issues no tlb flush,
and returns to the guest. Would the guest then retry the write instruction,
hit the same stale read-only 4KB tlb entry, and fault again, creating an
infinite loop?

> +		put_page(virt_to_page(next_ptep));
> +		recovered =3D true;
> +
> +		break;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914055936.3672=
758-1-wang.yechao255@zte.com.cn?part=3D2
