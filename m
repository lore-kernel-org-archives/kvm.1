Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644563EFFC9
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559894; cv=none; b=JQLfLgIw3bjn1GQYNwm/TYvfbx5nSABYP81QaR88WbVTuiQfptceItolHxdsA9eTHYERUeUctcIVctKm4Y+gRaRqyEvVy763pG1tqdU0/tRs1GREA1FEji+XFVkSqCRqH6PgWTwsGQSQot9Ethl3l4vhyfhqBKBa0I3HyE0U9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559894; c=relaxed/simple;
	bh=WXDZgOwmXyGwFAowa5H4ij+iHpclQxQOXxtaEJxOvZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mt91eWalW9ENgnaVlJYZ39xt/jAR9PMCWLHrRpp3cetLUZtWz+qLjiLIcCHwPnKkk4E35oTI34FH08+hpdNLo/Unb7nfIwxPrPuP++5fWfTIEpC4Anc3Tl2baKCQR2F6Kwqs3n6kR2Qo47biQzi0g0ip5HS74rYq7QBmQMCG10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Vv32Qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Vv32Qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA51F00A3D;
	Fri,  4 Sep 2026 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559893;
	bh=u2KCX5JhCAHfLfq7NDfn3GCe3i4ug9Pq7PcEp/DzWjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8Vv32QwxqmAWmoPtwrFYnWEh/UqVx/a4rnmXDOhqG8SzDqriX1PV1Xc8+xbDhjJ/
	 akzpfJqG8Ikhds1dgQhUSeLZpYX3a5fEuoRwwXM/v/SP9XegWYP/34SCzU6Ii4NWLh
	 feK9bFZkS0c/vaFV/vEXYV61YPnukJN51+gB16KJp3jwWv8xA+bKWT1YrF0jUXWhPN
	 vAvAb2ZF0NnM19zVzjkaBxHsxHHkTWJTdh8TfGDhIJZIcQ4bw0XzLiaEerktvCNfiA
	 wIKbKh4T5DQ0XcwPO6Rr1kBdyBwMG5+5yVL2z99cT6OT2tiyWkenilPtWmYbIYgtCP
	 MekCifBAfFyBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/11] x86/virt/tdx: Enable Dynamic PAMT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904215841.303070-10-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
 <20260904215841.303070-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:11:32 +0000
Message-Id: <20260904221132.D3EA51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dynamically allocated PAMT pages (DPAMT) are not recognized by `=
is_pamt_page()`, causing Machine Check Exceptions (MCEs) on these pages to =
be misclassified as generic memory errors.
--

commit 4f5c2aeed6b267952a921a886ea2792c5ac1fb4a
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date:   Fri Sep 4 21:58:39 2026 +0000

x86/virt/tdx: Enable Dynamic PAMT

The Physical Address Metadata Table (PAMT) holds TDX metadata for
physical memory and must be allocated by the kernel during TDX module
initialization. This commit enables Dynamic PAMT (DPAMT) to reduce this
memory use by allocating part of the PAMT dynamically when the TDX module
reports support.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 221e54492bf16..a77b72c4e06a7 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
[ ... ]
> @@ -1059,6 +1061,12 @@ static __init int config_tdx_module(struct tdmr_in=
fo_list *tdmr_list,
>  	args.rcx =3D __pa(tdmr_pa_array);
>  	args.rdx =3D tdmr_list->nr_consumed_tdmrs;
>  	args.r8 =3D global_keyid;
> +
> +	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
> +		pr_info("Enable Dynamic PAMT\n");
> +		args.r8 |=3D TDX_SYS_CONFIG_DYNAMIC_PAMT;
> +	}
> +

[Severity: Medium]
Will enabling Dynamic PAMT cause Machine Check Exceptions on DPAMT pages to
be misclassified?

Looking at is_pamt_page() in arch/x86/virt/vmx/tdx/tdx.c, it seems to only
iterate over statically configured TDMR PAMTs:

arch/x86/virt/vmx/tdx/tdx.c:is_pamt_page() {
    ...
    for (i =3D 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
        unsigned long base, size;

        tdmr_get_pamt(tdmr_entry(tdmr_list, i), &base, &size);

        if (phys >=3D base && phys < (base + size))
            return true;
    }

    return false;
}

If a Machine Check Exception occurs on a dynamically allocated PAMT page,
is_pamt_page() will return false since it ignores dynamic PAMT pages.

Will this cause the hardware error to be treated as a generic memory error
instead of a TDX private memory error, thereby omitting the debug logs
for TDX memory corruption?

>  	ret =3D seamcall_prerr(TDH_SYS_CONFIG, &args);
> =20
>  	/* Free the array as it is not required anymore. */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904215841.3030=
70-1-rick.p.edgecombe@intel.com?part=3D9
