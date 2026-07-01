Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B13955C6;
	Wed,  1 Jul 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938368; cv=none; b=tV7tA25ICIMdrnllipmZwgBnSV/7582EdqoJqaHO96Cxv0sWHRsiQwWIjChNL1QQPhdRhQF5YIxKiE8lcw3/GMmQpcRoGPfJZbtJHkudrdOd+2VYW/ZzqcUEo0b83fHrvKJKYzmFjZRpac8ojG9+GP+QFYj917NIVioH5hrJgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938368; c=relaxed/simple;
	bh=K2JyJxCXLtM1eTdlopzD3fjkU2xPZMINicFo0HL5CgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/uI6peXbqzGKkuQSoY47bCoVaoUXvQ2QpGjsI8+6/YjevlMklLHzRFp9gjRRQHwag6cD/j7dCW7WoLHRKnz4tikoMwbCB3A6lz809c3V7nBlzWMqfzONIHhKPXaZ/qKkFNkE8Cz4nQ+uVXl5d0sTLojADZMYjj1CtrCf4hIiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJRDi4cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJRDi4cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC711F000E9;
	Wed,  1 Jul 2026 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938367;
	bh=f6QVBJJnOqTAmv9bGgn42fUJj2cY0FZxJ1ME1xdC+T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJRDi4cwA05SdSW+713uFlPiyHLZCwR49gpm/dBeCn1+LQodBzos5L0rNrOeB3byQ
	 WYhZPYks9Se42SWieNvBWgUMjEsqBcwWOs4xOFFLRMbHi6ddQDqKg30NUNu0SRnybo
	 Dxb53nC6CoI0/DRmyz5F3NPVghBQyDdplb73P47xUpH/v/YS8//CW0poBUhA6iC8QZ
	 umZIFhJEUn1UA3tMpqYUH5xGl95l2jJ2JSaktuQKz/5/5/JCb3OwudfJXCtAean9jS
	 MjQR6siiOHHeuqOsor+6mVOYZFjNM2kgMm41a5faaSghy28LcMtS8/BW+wK19MQomK
	 Bdzqn1x2pljIA==
Date: Wed, 1 Jul 2026 21:39:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	devicetree@vger.kernel.org, spacemit@lists.linux.dev,
	sophgo@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 08/17] dt-bindings: riscv: Require block-size for
 Zicbom, Zicbop, and Zicboz
Message-ID: <20260701-squiggle-aging-459cd99cb2dc@spud>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dKXZ0SKTAmT4FGH2"
Content-Disposition: inline
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>

--dKXZ0SKTAmT4FGH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 08:52:21AM -0400, Guodong Xu wrote:
> Zicbom, Zicbop, and Zicboz have no default cache block size, so a
> devicetree that declares one must also provide the matching
> riscv,cbom/cbop/cboz-block-size property. Make it required so a
> missing block-size property can be caught by dtbs_check.
>=20
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>
> ---
> v5: New patch.
> ---
>  .../devicetree/bindings/riscv/extensions.yaml      | 26 ++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 5ffc40d599c02..f4dd34d446c02 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -1142,6 +1142,32 @@ allOf:
>            not:
>              contains:
>                const: zilsd
> +  # All three Zicbo* extensions require their block size property as the=
re's no
> +  # default.
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zicbom

I think the way to fix this is to add
  required:
    - riscv,isa-extensions
to each of these if conditions
(not got time to test it right now, sorry)

> +    then:
> +      required:
> +        - riscv,cbom-block-size
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zicbop
> +    then:
> +      required:
> +        - riscv,cbop-block-size
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zicboz
> +    then:
> +      required:
> +        - riscv,cboz-block-size
> =20
>  additionalProperties: true
>  ...
>=20
> --=20
> 2.43.0
>=20

--dKXZ0SKTAmT4FGH2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakV69wAKCRB4tDGHoIJi
0qZuAPsE7PpkS7Q9Q/QdOXMXVi0vMgDYbeEgMRtzf0lMlv6w6gEA1JDV5vGVvkwY
e3dZ2Ec1Eq1CjjFHEnDtDfSSbocyhQw=
=AQmB
-----END PGP SIGNATURE-----

--dKXZ0SKTAmT4FGH2--
