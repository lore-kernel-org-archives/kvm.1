Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157C3655F8;
	Fri, 12 Jun 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251417; cv=none; b=F5xcIRoAB1VD6FFJZtn6Pjwsb8catCm0z9Uk9lRG6GCCyICmjoh4tgII2YK31uzdOrO5lUYMLf3g9Y3WCeItC3x3aklXruo+kPuOyxbfU44pfDZ4o7f3u9aXCceja4bsTyN4e3mL316DDK+xaprAYKlcPgPyDwQKqHxUPOEfewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251417; c=relaxed/simple;
	bh=P4iVxiPDmbhbJzaqrUHlLYRHYp3weiZW/it8LSxUNyk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHg8TDqcAfurZRnzzaJwEOyxaJmqTBedbOQ+hnDOWp224E2Wt4XdSqfqVK9Gzy/73JckkgbRdC/d10ou2PUxwXu3FbM5DkrEGJHlPXbGu3mbCsO6EoZiiN8OLYBlf73EQtBBxCtzWyeQ8KKPas1gZ1VoUPo6TDpDLgnsC4UZxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wpoXW6eY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wpoXW6eY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781251412; x=1812787412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P4iVxiPDmbhbJzaqrUHlLYRHYp3weiZW/it8LSxUNyk=;
  b=wpoXW6eYrX31Z4q6ScGwG1tUik1NzrEzngtpN5DTugmdDTv62Gk5P/0Y
   r36/HXM3N2EgUfFT/Htfclf2A4QOkUSFf99p7oHBpieiKbRbXL9bLw5i0
   p9NGDGBvQZItdv+zMbAKea/+M+vsTGpu6cOctzgJ+ncrFpEqC6fODNocK
   XM+Hzn7r4yHdJdO37tPSat4rkCaFeAyZEv6z7fUdXuwbHpMtC1FNj8E+M
   jW2t0ySPz0FWKIH0l1gbI5NYUPI6dnVArwGY86kqX4CzTvxea/oQlc9/H
   tdgbbcKVXuuYy1tkTPeJ2pPdW3cLb03iUrKo4WviSAepO/1iPo09cKbJd
   A==;
X-CSE-ConnectionGUID: OS0RNmxnQE6XK0OgLov9Ng==
X-CSE-MsgGUID: l5iiYcgQRueWpaWqOIGeaQ==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="asc'?scan'208";a="68064594"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 01:03:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 01:03:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 01:03:20 -0700
Date: Fri, 12 Jun 2026 09:02:34 +0100
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
	<linux-kselftest@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v4 01/16] dt-bindings: riscv: sort multi-letter Z
 extensions alphanumerically
Message-ID: <20260612-strength-body-303e6a57218d@wendy>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-1-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/HoYz/XLHMn+tyAX"
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-1-3f01a2449488@gmail.com>

--/HoYz/XLHMn+tyAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:12:38PM -0400, Guodong Xu wrote:
> The multi-letter extension enum is documented as being sorted
> alphanumerically (see the "multi-letter extensions, sorted
> alphanumerically" comment), but several Z entries have drifted out of
> order.
>=20
> Reorder the affected entries so the multi-letter Z list is sorted
> alphanumerically again.
>=20
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: na

--/HoYz/XLHMn+tyAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiu9GgAKCRB4tDGHoIJi
0v7zAQDekEYV7GQZKWhpOKggyOP7/VEDaNNIVjsPa4Gj++QaKwD/VvZF9CIz96Nk
FWyOnzPaRHO4UyHIBXkZHWJO29UlYA0=
=WZTL
-----END PGP SIGNATURE-----

--/HoYz/XLHMn+tyAX--
