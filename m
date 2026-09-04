Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F4314B66
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482186; cv=none; b=WxuVR1SyoehG73IZ0Wd/NqvKmIAO8v+UR5L36z3ITRrhvZTDBYwAun7kTWRDAs/XY2r+P9D4w24qRmSzvq8Yz5sM5xKOmGS5vrL5Op2eua2Q/C54iGbX2lZKmfad2cgzq30yzZ8EF14JJD43ERj4fj4/S533q/bmfA02qWqAgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482186; c=relaxed/simple;
	bh=6Hlr1V7JvswVfksmwdnHxxG7o3AyrcGnowecfr5nh7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZSYqL5x5p8hAiikXSqenoqK6yja3OJnCJyGBvz4QdmHdCRZSLpLGHCzy1InmjUFkQZSVlZPUSMQw+W9GS96YbjLhrvo/jSQjlMR98jco1Qb+bTedFyX78wlRUFtvHX/Tv90eXnuMk9mmZWH4rLwXLOZdIzO5uZDybJRV44oVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLVwTqmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLVwTqmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0021F000E9;
	Fri,  4 Sep 2026 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788482184;
	bh=eiRF95bGs8W8ClC56Vs3BkMHl92uOGaw99w2GY0IjD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iLVwTqmT+UkL5MzChYqqa9hY/ctX5DMAtnsMgyVuUsGham3CzDYeGfHvvx2XZ/YXt
	 D3i3u5DXzVFXeMM5BK6Rgu6Kbnun+CKzGaj4DHio0uwtmMM21Q2iqjXv548e3MDq+/
	 DYLQ+G/t8lxSbgM1bLCnSDCBskL4/AyeMWr43Hr4h64x5woNBvQiIHogep4Lr07hz/
	 kEVerWQldQmc+aeV0/ZfNdP/mbh6NHdJeIe9AKRZyu78zfF8qKTAlYEIynMjJ+P6JQ
	 8A8mCl8vOvz+/xeJoPCxffmlTShTLNWrG7sBbxVStyg/273C0UUlriorzFvrSKduN9
	 g2j3DoaWIpHCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/17] KVM: selftests: Always assert that vmreadz()
 succeeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904002423.3154436-18-seanjc@google.com>
References: <20260904002423.3154436-1-seanjc@google.com>
 <20260904002423.3154436-18-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 00:36:24 +0000
Message-Id: <20260904003624.7F0021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo in assertion message: 'vmwread' instead of 'vmread'.
--

commit b99bd290de04e34e69f57ca551e7c07af56c2b56
Author: Sean Christopherson <seanjc@google.com>

    KVM: selftests: Always assert that vmreadz() succeeds
   =20
    Rename vmreadz() =3D> vmread() (and vmread() =3D> __vmread()) and have =
it
    assert success instead of returning garbage on failure.  While the eVMCS
    path avoids clobbering *value on failure, the VMREAD path unconditional=
ly
    stores tmp to *value, without ever zeroing tmp.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index be10028c51b96..a4807e41fe69c 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
[ ... ]
> @@ -399,18 +399,17 @@ static inline int vmread(u64 encoding, u64 *value)
>  		: [encoding]"r"(encoding)
>  		: "cc", "memory");
> =20
> -	*value =3D tmp;
> +	if (!ret)
> +		*value =3D tmp;
>  	return ret;
>  }
> =20
> -/*
> - * A wrapper around vmread that ignores errors and returns zero if the
> - * vmread instruction fails.
> - */
> -static inline u64 vmreadz(u64 encoding)
> +static inline u64 vmread(u64 encoding)
>  {
>  	u64 value =3D 0;
> -	vmread(encoding, &value);
> +
> +	__GUEST_ASSERT(!__vmread(encoding, &value),
> +		       "vmwread[0x%lx] hit VM-Fail", encoding);

[Severity: Low]
Is there a typo in the assert message here? It says 'vmwread' instead of
'vmread'.

>  	return value;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904002423.3154=
436-1-seanjc@google.com?part=3D17
