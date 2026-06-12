Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40A374198;
	Fri, 12 Jun 2026 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251888; cv=none; b=AI3SaalC6nDyWzljI9uOWWt3P1jGEoJYDmtlx8qhsEWDdO6hgJoaj3w18LFfrax5R6NU+hUK2E7/Aqm8Qc6MlOQhI8ecr8R+137cYIMLro4KpLncVm4XPNLj5zktKt7xZOwx0ogareTznIVM2awgrcgdNbxomIMdFaSd8KMCZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251888; c=relaxed/simple;
	bh=09IdOVLMNDB2JSk1h6RiniYc8xGkWsFYI0Azybko6vM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN68qsLfki2FFEyxlDbspCOqOX9osAhLy/TX6kgGeSmsmHwr5Smv+VvGc7c9wW9Yk32hwI63M8Idf8CkKmJPTYYv0GwyE5JQ/3HIXx+DNEQn1QrTCPH40+TC2ziSS5LZyfo/TIPhcPZpyC4o1+4xA6Xqbk9w8cydCig/slTCFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tbWeAlrf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tbWeAlrf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781251886; x=1812787886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09IdOVLMNDB2JSk1h6RiniYc8xGkWsFYI0Azybko6vM=;
  b=tbWeAlrfL6Ln09mUG89d1Iudb35p2h3WbIvsxolwEeR5+sT82PlkGMBX
   rP32URH/e1SHKvCF9wswBMtAQv+e8OvWVLexBM+eeN5jZFfUbyYu+5whk
   hhfYVHZYMqPqasx1ehUknScSIKqUI7crjLmoKK/YnYp/nJesjUGHUX/Uf
   etEHOiSIeCn5frAMrm1qzQbdv+osj11yzg3FF0OuGP42u4trH9wYvdKsL
   jTZgceoTndSoog+wcndTs8jKGQXtFQEkXhfL7s9wfrKwmJeclMQyikwq3
   x+htuuk4/PzXMH+gO5xPHYlNrqFiTgfVEGftT54ge5f3JyXX5pERgOErA
   w==;
X-CSE-ConnectionGUID: 7jMcURnnQSWYXlwofOiWTQ==
X-CSE-MsgGUID: uQQAS81sTPGD4Sp0EYLexQ==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="asc'?scan'208";a="59402913"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 01:11:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 01:11:19 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 01:11:14 -0700
Date: Fri, 12 Jun 2026 09:10:28 +0100
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
	<linux-kselftest@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew
 Jones <andrew.jones@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/16] riscv: Add Ziccamoa, Ziccif, Ziccrse, and
 Za64rs to cpufeature and hwprobe
Message-ID: <20260612-revered-statue-793228111bf1@wendy>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-6-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qxWNCqHoXJi6kp6h"
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-6-3f01a2449488@gmail.com>

--qxWNCqHoXJi6kp6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:12:43PM -0400, Guodong Xu wrote:
> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
>=20
> Add Ziccamoa, Ziccif, and Za64rs to riscv_isa_ext[] so they can be
> parsed from devicetree/ACPI ISA strings. Ziccrse is already present
> in cpufeature; this patch only adds its hwprobe exposure.
>=20
> Expose all four extensions via hwprobe through new bits in
> RISCV_HWPROBE_KEY_IMA_EXT_1 (RISCV_HWPROBE_EXT_ZICCAMOA, _ZICCIF,
> _ZICCRSE, _ZA64RS), so userspace can probe each of these
> RVA23U64-mandatory extensions individually.
>=20
> Rationale for the validation dependencies added for Ziccamoa and Za64rs:
>=20
> 1) Ziccamoa depends on Zaamo.  The RVA23 profile prose was updated
> post-ratification to spell out the Zaamo reference: commit
> 2b218613752d in riscv/riscv-profiles ("Improve description of
> Ziccamoa (#224)") reworded the rva23-profile.adoc (and other profiles
> that include Ziccamoa) text from "must support all atomics in A" to
> "must support all atomics in the Zaamo extension" [1].
>=20
> 2) Za64rs depends on Zalrsc. The unprivileged ISA manual src/zars.adoc,
> integrated in commit ebe06adc22cd ("Integrate profiles as Volume III
> (#2771)"), defines Za64rs as: "The Za64rs extension requires that the
> reservation sets used by the instructions in the Zalrsc extension be
> contiguous, naturally aligned, and at most 64 bytes in size" [2].

I think I made the point on either an earlier version of this, or a
similar thread, that the point of the validate callback stuff is to make
sure that the kernel is correctly configured to use the extension in
question or an extension it depends on. It's not the kernel's job to
make sure that the firmware has not reported having an extension without
one that it depends on (at least it is not in devicetree land, and I can
only assume that ACPI is by and large the same.

ziccamoa and za64rs don't depend on kernel configuration and neither do
zaamo and zalrsc, so these validate callbacks should be removed.

Cheers,
Conor.

> +static int riscv_ext_zaamo_depends(const struct riscv_isa_ext_data *data,
> +				   const unsigned long *isa_bitmap)
> +{
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZAAMO))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}
> +
> +static int riscv_ext_zalrsc_depends(const struct riscv_isa_ext_data *dat=
a,
> +				    const unsigned long *isa_bitmap)
> +{
> +	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZALRSC))
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}

--qxWNCqHoXJi6kp6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiu+8wAKCRB4tDGHoIJi
0om5AQC8Njoz4GNfpjgzPd4cWpxlA4c1jp3tdh2XAHtySRQDEQEA0ZBPLNZ+r6Ue
lM5ZxmXdd2griErGWLwGSLQDdTBztQ4=
=cqPD
-----END PGP SIGNATURE-----

--qxWNCqHoXJi6kp6h--
