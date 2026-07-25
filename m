Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332D30F535
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939627; cv=none; b=eYEOPl10GXti7+RzousuCcuiOStQQOQU9EL+cEUWS6lsggBwz3h+Wn7koGMa39qk0FcJv/gxZGcvGtvUEYEKicDGyrJRfepyMHlGF/hOI4X/maLFlA8kRiNvFSULhMHmn5dACwne4lcq6gEROo307TvsUql2k7FyDcxDKrNrOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939627; c=relaxed/simple;
	bh=eK10WS5k2Fd6yAJ1yzDhwtOfymVQLpEmMpt4m2ilVPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtMXpVE2LfGH821YelAAPJTmpRSUinUJqlOcboNxJmb1FKYzm4MKMzQyTe6COIQDTPn325Xx43/r3QAmP4a3tRfm7eYhcLIXHhTp1rxtxbl4LPZRsdieenK/RAvhuKinhHYxE2GmjMZQ+qaQAdig6oGv4cZ4gPOGgHsAqKOhF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBC5h/yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBC5h/yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E951F000E9;
	Sat, 25 Jul 2026 00:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784939623;
	bh=5xhZsqVaz+tj4+/M1eOhlPt9LJ8l27az6Kbt+3NjQSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBC5h/yqgrCBuVbnH2vMpqrEN43mEYCjDS5iiLWDBKWv2tbJZ7ezkaGhMCIPisG9F
	 a1pmTb3/aBY/RuuYxeOcy2zWGcvw/bjeDp+mj1YozBj5IWWhsOXh5gKrdaVti6dDFQ
	 AVHoLLOhhC31SgIwIpABijZNMNXRhO03ECbAAlB/FELPh64WrySrGPBfDdIGWGYfNG
	 B6ZQUxM5xUGJwZ2HC/Mx4eMUEDr253tQgbO3UbT2yTgUPCO14CKA3hytA8gNHvwfAj
	 A0INJsYl7NIieujhBA/mN0lltdREpLbsFU3m2tbXZPJUqZC7smfD+e4N0AQoX8VrNz
	 frgfLagY4IrZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic
 PAMT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Edgecombe" <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260725002302.3337017-3-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
 <20260725002302.3337017-3-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 00:33:43 +0000
Message-Id: <20260725003343.65E951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 16-bit TDX metadata field for 'pamt_page_bitmap_entry_bits' =
is silently truncated to 8 bits, potentially causing severe memory under-al=
location on future TDX modules.
--

--- Patch [2]: [PATCH v8 02/11] x86/virt/tdx: Allocate page bitmap for Dyna=
mic PAMT ---
commit 88c7f3b3a7c606e18ce66049ee20b819855d481e
Author: Kiryl Shutsemau <kas@kernel.org>
x86/virt/tdx: Allocate page bitmap for Dynamic PAMT

This commit begins implementing Dynamic PAMT by reading the bits-per-page
metadata required for Dynamic PAMT and calculating the needed bitmap size.
It then allocates a page bitmap instead of the normal 4KB PAMT if Dynamic
PAMT is supported by the TDX module.

> diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/includ=
e/asm/tdx_global_metadata.h
> index 41150d546589c..2a42551fc33cd 100644
> --- a/arch/x86/include/asm/tdx_global_metadata.h
> +++ b/arch/x86/include/asm/tdx_global_metadata.h

[ ... ]

> @@ -21,6 +21,9 @@ struct tdx_sys_info_tdmr {
>  	u16 pamt_4k_entry_size;
>  	u16 pamt_2m_entry_size;
>  	u16 pamt_1g_entry_size;
> +
> +	/* Optional metadata, if Dynamic PAMT is supported */
> +	u8  pamt_page_bitmap_entry_bits;
>  };

[ ... ]

> diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/=
vmx/tdx/tdx_global_metadata.c
> index e49c300f23d43..8393d2aa59dbe 100644
> --- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
> +++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c

[ ... ]

> @@ -33,6 +33,18 @@ static __init int get_tdx_sys_info_features(struct tdx=
_sys_info_features *sysinf
>  	return ret;
>  }
> =20
> +static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *=
sysinfo_tdmr)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret =3D read_sys_metadata_field(0x9100000100000013, &val);
> +	if (!ret)
> +		sysinfo_tdmr->pamt_page_bitmap_entry_bits =3D val;

[Severity: Medium]
Does assigning val to pamt_page_bitmap_entry_bits result in an unsafe
truncation?

Since pamt_page_bitmap_entry_bits is declared as a u8 in
struct tdx_sys_info_tdmr, and the metadata field ID 0x9100000100000013
specifies a 16-bit value according to the TDX ABI (bits 33:32 are '01'),
a value from the hardware might be silently truncated.

If a future TDX module increases the required bitmap entry size to 256 bits
or more, wouldn't this truncation cause severe memory under-allocation for
the physically contiguous PAMT memory?

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725002302.3337=
017-1-rick.p.edgecombe@intel.com?part=3D2
