Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC337DAD6;
	Fri, 12 Jun 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252648; cv=none; b=FEJyUj+1MBhvMjHsTjtAFuzOi/y3AjPKynsVa+a8bTC0VPdWkLeAYQT9rRyvRz5gwJHGFxIYU4GJ2c1fwsRXxr6ZlQql7IkMjcQb8NodrZi7q0GrmCkoASdo2CCRsdhzl1WxAnaIyWroVR4bEOhf7rLl6Q1dmAKM3n9h3bSxT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252648; c=relaxed/simple;
	bh=aik1yZWSrKo57yjYoAjGg1WiRNqIySZleRfYd2RGgiY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgYkNEW6QEzoOkfYQN5FmJnIVcCr/7GZGdIb+4zNO4g8gk1nZ3B9Pcm0pHT52zGBaEMSCr6Zn/c733DAt0wa3BpAMLqlyDCxH1IQqytKvPFYtAgKNqQMSXUBiNYdx1OFY0PgkkjD1G0mB5Ac7qXVMAvD44ZXBP3gaH2NaSwO/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M/qYnh2+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M/qYnh2+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781252646; x=1812788646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aik1yZWSrKo57yjYoAjGg1WiRNqIySZleRfYd2RGgiY=;
  b=M/qYnh2+vzN1VsNIX0tPDvOnW85ecMAt3gC38tmwrBiJoD+dgPWvOaBa
   PMZNaTjI1RR6qFedYC0gVKFcQYc2+01pomTsCjt6VpoN9UNa5AqJTZ+fc
   CkytOOD5UZSqCCEYTgFR90iyJftYn+k0aOYtWJ7kYAyneB8IsOnqY220z
   gzrsu3b+7ry76uClLhzUYaya0ZZH8EXBIUq2czovOec2ov42UubNLijTb
   tiwhh13GCY0Z42cw11+tDd3z9RpThKbpCzWvIKw0R7E/0B2cidbpu9xU9
   eB5CIw2nai+X9JLd3P2kYOGF4doxx8PPRgEfDSBoYSacW9x6Ac1RErXxf
   A==;
X-CSE-ConnectionGUID: 5MrWdWtvTtS4GM0us5yIIA==
X-CSE-MsgGUID: szhd3KRbRoylTsr8ICyu6g==
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="asc'?scan'208";a="59016839"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 01:24:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 12 Jun 2026 01:24:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Fri, 12 Jun 2026 01:23:58 -0700
Date: Fri, 12 Jun 2026 09:23:12 +0100
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
Subject: Re: [PATCH v4 08/16] dt-bindings: riscv: Add Zic64b extension
 description
Message-ID: <20260612-scarcity-willow-c073342b5ac2@wendy>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
 <20260611-rva23u64-hwprobe-v2-v4-8-3f01a2449488@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dm2P8/tZRoFsL+eF"
Content-Disposition: inline
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-8-3f01a2449488@gmail.com>

--Dm2P8/tZRoFsL+eF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 04:12:45PM -0400, Guodong Xu wrote:
> Zic64b mandates that cache blocks are 64 bytes in size and naturally
> aligned in the address space.  It is a mandatory extension of both the
> RVA22 (U64/S64) and RVA23 (U64/S64) profiles, ratified with RISC-V
> Profiles Version 1.0.
>=20
> Document it so it can be described in the riscv,isa-extensions property,
> alongside the related Zicbom/Zicbop/Zicboz cache-block extensions. Since
> Zic64b fixes the cache block size at 64 bytes, also add a  schema check
                                                           ^^
Not that it matters, but there's an extra space here.

> requiring any present cbom/cbop/cboz block size to be 64.
>=20
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
> v4: Insert zic64b at its sorted position (before zicbom).
>     Update the commit message.
> v3: New patch.
> ---
>  .../devicetree/bindings/riscv/extensions.yaml        | 20 ++++++++++++++=
++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 5ffc40d599c02..1c24999beb59e 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -494,6 +494,12 @@ properties:
>              in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>              riscv-isa-manual.
> =20
> +        - const: zic64b
> +          description:
> +            The standard Zic64b extension for 64-byte naturally aligned =
cache
> +            blocks, as ratified in RISC-V Profiles Version 1.0, with com=
mit
> +            b1d806605f87 ("Updated to ratified state.")
> +
>          - const: zicbom
>            description:
>              The standard Zicbom extension for base cache management oper=
ations as
> @@ -1142,6 +1148,20 @@ allOf:
>            not:
>              contains:
>                const: zilsd
> +  # Zic64b mandates 64-byte naturally aligned cache blocks
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zic64b
> +    then:
> +      properties:
> +        riscv,cbom-block-size:
> +          const: 64
> +        riscv,cbop-block-size:
> +          const: 64
> +        riscv,cboz-block-size:
> +          const: 64

I think we also need to have
diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Docu=
mentation/devicetree/bindings/riscv/extensions.yaml
index 1c24999beb59e..bbd442cfbd904 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -1162,6 +1162,32 @@ allOf:
           const: 64
         riscv,cboz-block-size:
           const: 64
+  # All three Zicbo* extensions require their block size property as there=
's no
+  # default.
+  - if:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zicbom
+    then:
+      required:
+        - riscv,cbom-block-size
+  - if:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zicbop
+    then:
+      required:
+        - riscv,cbop-block-size
+  - if:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zicboz
+    then:
+      required:
+        - riscv,cboz-block-size
=20
 additionalProperties: true
 ...

because I don't think there's a warning generated at present* if someone
does "zicbom" + "zic64b" and doesn't have a riscv,cbom-block-size property,
only if they have one and it isn't 64. I think the former is a bigger
problem than the latter.

Probably needs to be an additional patch, because it has value whether
or not we permit zic64b.

pwbot: cr

Cheers,
Conor.

*: the kernel will warn at runtime, but nothing in dtbs_check etc.

> =20
>  additionalProperties: true
>  ...
>=20
> --=20
> 2.43.0
>=20

--Dm2P8/tZRoFsL+eF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaivB7wAKCRB4tDGHoIJi
0r+LAP95Lkh6JmlVNGkOMGiFZ+ds+OC4z1NCcvaGyDDMznHyEQEAk5bm8w0ICEyr
TwHrpZxora0ISSspUjdDg1Xmy+dJDQM=
=9gRX
-----END PGP SIGNATURE-----

--Dm2P8/tZRoFsL+eF--
