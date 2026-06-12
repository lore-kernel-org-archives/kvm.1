Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845135675D;
	Fri, 12 Jun 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252004; cv=none; b=I3TsyNptKGImCqd50lVcrKA0Ob4wHWRDr9YETvITrsSoEO/DD7NWgydRaopHmGqaUuzGit8A53kiM+ODUDseGbg4Mc1UXaqKejreMG5r9fzpje+tvBW8VXPqmNMed85vAhCU0bTTPMlMxnHXH8RtuxSOC3vzcceQuiNhmid3954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252004; c=relaxed/simple;
	bh=EtJZAYs6E/WZgQq7Sg+kISDy17uxy7ak03wdp/fu4Ik=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JS+42z7AdA7ZKY3CgXDJfJf7RPSC7l2iNusQ/lrkjsZcPzvAUzHGsWAGfF7pUkhvdxl0nboqeK5bEifBjaQkOtQL2CX2RWHfVPcPKwXtv8qZaHAn6C1XL46Fe6sPANu3Y4f8/GgB6U8TYVK5uCD95IFzHoyV3dfqP5CxN9YiJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=flrv6BBr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="flrv6BBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781252003; x=1812788003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EtJZAYs6E/WZgQq7Sg+kISDy17uxy7ak03wdp/fu4Ik=;
  b=flrv6BBroa09S8MtaPcglDtTAvyNg+Hc3j2E7nPWZRDdfoZYeu+yLQtX
   Ql+u/bT/54fK4G1yJyIEfXG2mUxhxtZtf/ni5/kN0oGBOtEvM+RAWe763
   tKLBKDg7/Z7c+p1kMXKgcMFeUemyjvQZh4UJGVQwwzO4S1+oPyRSBDgs+
   dPqTQjB7xkQqYaWUEcMrvvJMDFldG9XZruprr2qmg1N1FbcGX+Y583UJA
   e2iNXrLNEGevZBYpW5gpgULPMXZg06kYKFY8+t26mrF4qsM/ZnHE7v5h1
   r4dHtBRaB1uN2l42JBi8PA7ZX5amyKhwPdJj+21NSneumJQkm++yPBlEp
   Q==;
X-CSE-ConnectionGUID: pgiZR6tuTNqjfYasAurGdA==
X-CSE-MsgGUID: DLJWxWdJR4OYwN1yOiQ8Ow==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="asc'?scan'208";a="290396387"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 01:13:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 01:13:21 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 01:13:16 -0700
Date: Fri, 12 Jun 2026 09:12:30 +0100
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
Subject: Re: [PATCH v4 07/16] riscv: Add B to hwcap and hwprobe
Message-ID: <20260612-unsorted-sequester-6a4ec6b9d583@wendy>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-7-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PQqI/ma7D3SyX7fS"
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-7-3f01a2449488@gmail.com>

--PQqI/ma7D3SyX7fS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:12:44PM -0400, Guodong Xu wrote:
> From: Andrew Jones <andrew.jones@oss.qualcomm.com>
>=20
> Add B to hwcap and ensure when B is present that Zba, Zbb, and Zbs
> are all set. Also expose B via hwprobe (RISCV_HWPROBE_EXT_B in
> RISCV_HWPROBE_KEY_IMA_EXT_1) so that userspace can probe B directly,
> mirroring the F/D/C/V pattern where each is reported via both hwcap
> and hwprobe.
>=20
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> [Add B to hwprobe]
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--PQqI/ma7D3SyX7fS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiu/bgAKCRB4tDGHoIJi
0qW0AP4zDRXj0LcaBFyBnGq6O7UoIBzoElEBlRQMmlD1lzUdDAD/WDVIu88sPWvA
kcQWsFvqgBTiL+CUQBbWI3amTlmHgQI=
=nHj3
-----END PGP SIGNATURE-----

--PQqI/ma7D3SyX7fS--
