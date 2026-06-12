Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EC31B80E;
	Fri, 12 Jun 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253716; cv=none; b=AUq6sZJd6E7ETT8PVCP+jmJEpbCVLMBbP+k15MlVG9Aw4at3rQ6UBvuAiph85YrJZRgsPdW/+QPIdB3N9CvxEZ7eXECaU6rVXV8KuGi/Du0F8v9yU21vWvcifbXH7rMM/pB83n9IamYAADN8Baee69EL9fuzj1fUX4loMUopYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253716; c=relaxed/simple;
	bh=cJS4+U+Lvd9JiTFvDEcycO1GrMxgHTDXXvhAFBUdHBY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3uagPofKmJ8zg14Occ6viFjskuQMTwf3MSlOU5Kz2OHvA19i4vyfwqDQabx2q8hOMIb7dgSQ7coA9nrtmiIBqWcLOF69UDVHWA8wFLJTGHEFqOglE39VFNnykUhCuqB29ipQLsmuk6vZ2jVQTwD54qcyysCc3/VF8Vj0FfOycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rn5Vab6u; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rn5Vab6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781253717; x=1812789717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJS4+U+Lvd9JiTFvDEcycO1GrMxgHTDXXvhAFBUdHBY=;
  b=rn5Vab6uWHYXd1rjInpzacx/i9ApDbJQIQ7WtIOeC3zQXDO+WTCSL/a+
   p8tVZiSkk53fQr0hMwaWkiCfTqyj+tSTWG6evFK5wnJgtSGrrd/B/fsFQ
   f2ckYMxMvl2UA97xxXtQwX2TjjjptF4gvHouvS4N3RhEKjj8zsbF+ltXj
   9rqfMuWoIEn/z9XDbDR8/f3XP2LvUmOTtHbJfS78rxYptrns5AJ1bSC9/
   YNUnsYYU5R2bfBWTKkvujfVUD6RWoE2G82RS63PMLdDROFgY818ER3qoN
   QZ2l/rwwwX0LrYToVVAPfxLfG7QnIC0Vtb9NEUPKX0nQM4Y8t0F/8d9sd
   Q==;
X-CSE-ConnectionGUID: XuaeUrWDQs68NJpIlx5NwQ==
X-CSE-MsgGUID: /IzbyA5FSWGqN1HaIZcVPg==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="asc'?scan'208";a="59017390"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 01:41:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 01:41:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 01:41:48 -0700
Date: Fri, 12 Jun 2026 09:41:02 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Guodong Xu <docular.xu@gmail.com>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Zong Li
	<zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, Anup Patel
	<anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Chen Wang
	<unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<kvm-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Conor Dooley <conor@kernel.org>, <devicetree@vger.kernel.org>,
	<spacemit@lists.linux.dev>, <sophgo@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: Re: [PATCH v4 09/16] riscv: Add Zic64b to cpufeature and hwprobe
Message-ID: <20260612-frays-feast-e631e3aa047d@wendy>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-9-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yeEbaUwKYQ4BJ0tH"
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-9-3f01a2449488@gmail.com>

--yeEbaUwKYQ4BJ0tH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:12:46PM -0400, Guodong Xu wrote:
> From: Qingwei Hu <qingwei.hu@bytedance.com>
>=20
> Zic64b mandates 64-byte naturally aligned cache blocks and is a
> mandatory extension of the RVA22 and RVA23 profiles.  Allocate a
> RISCV_ISA_EXT_ZIC64B id, parse "zic64b" from the ISA string with a
> validate callback that requires each cbom/cbop/cboz cache block size to
> be 64 bytes when it is present, and export it through hwprobe.
>=20
> Link: https://lists.riscv.org/g/tech-unprivileged/topic/question_about_zi=
c64b_and/119631059
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> Co-developed-by: Guodong Xu <docular.xu@gmail.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

> +static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data *da=
ta,
> +				     const unsigned long *isa_bitmap)
> +{
> +	/*
> +	 * Zic64b mandates 64-byte naturally aligned cache blocks; cross-check =
the
> +	 * cbom/cbop/cboz block-size (when declared) device-tree properties to
> +	 * avoid inconsistency.
> +	 */
> +	if ((riscv_cbom_block_size && riscv_cbom_block_size !=3D 64) ||
> +	    (riscv_cbop_block_size && riscv_cbop_block_size !=3D 64) ||
> +	    (riscv_cboz_block_size && riscv_cboz_block_size !=3D 64)) {
> +		pr_err("Zic64b detected in ISA string, disabling as a CBO block size i=
s not 64 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

I'm inclined to object to this, but we don't have validation on ACPI
stuff to be able to mandate that people fill in the rhct entries.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--yeEbaUwKYQ4BJ0tH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaivGHgAKCRB4tDGHoIJi
0lFLAQDha3cantxsp/CPLOnAf10qvhl6aJAKsPOLD54gW9K0AQD+I9ggy4JDJWBL
AjJkB9ffVB058Go53e93Vc4lz51wNQw=
=4eTb
-----END PGP SIGNATURE-----

--yeEbaUwKYQ4BJ0tH--
