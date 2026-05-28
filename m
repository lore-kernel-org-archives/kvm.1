Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852A2F8E93
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984268; cv=none; b=qyq/a+GV2jsiYvKrOrWzlcD8QxSkfUWK7ofxrhEVdQch72IjpvGqgrXOF45vnp1uCWPmGT94Xey42S7cxpYM16h+sNKEIriUEQLeqqwHCNmaKRK9rhr0QHvjExqoSXKkfn8G0+nWo8XMBPrww8Gjvp8P9TSoP9nLaZqMxkFYnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984268; c=relaxed/simple;
	bh=eKUvg/G5IKi/8bWdHHPVA9mSQbUVivO2us1BVsxbM7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMSdCSVL3zHZqotd4eGDGXw7prBmnqfRYU3P1Sqed8pa7qk36YHPldl91QaVw1k4lbXI9cD1coXsLmf8YrfUVD8PF/G2v67hNKsINN425ZAjl9eWu84EAQSw1cbwAKXcJilT3dYxH1avb0P30T55eRmRr2wQSm8OxeYHR0VR6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+kYZURg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+kYZURg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0DF1F000E9;
	Thu, 28 May 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984267;
	bh=P5QPrEgXfm+Y2Iz1URDNCOQd0d4yChpgPIKYgRFIIh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P+kYZURg+77P4iY9UfG1Timg6vX7+uH/6R6tZ/T+uXYhnmnJm2ateYWU1ycWDkUy+
	 695eF4ZnbD99sVtrl4KJ/M0SvDOIsGrkHSaN5rem6/8zwe5Q8qhy/XBRxTW3+MrCpo
	 imCq0muqNEYOaWtZvC+i62ynvuSZfxLuaMM+fxvQNImgoADKQbvFBeDF3pPriuAlBD
	 Enf7mZ4BQ+4Uub4rWHrdV7I3B/qK5XAjtJxCigQ8MlPgH82NTEOLPDtmtcq4IvGjdj
	 /iTPmDeSLXAUNpoiwCprPg/VjD3bZP2WaVHfzmltKdSw3opAZkVeMpzK3IVeWkojA7
	 jGukjCpx3wLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: selftests: hyperv_tlb_flush: use swap() to swap
 PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piotr Zarycki" <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
References: <20260528154003.3594107-1-piotr.zarycki@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 16:04:26 +0000
Message-Id: <20260528160426.DF0DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding the `swap()` macro to `kselftest.h` introduces a macro redef=
inition warning in the mm selftests.
--

commit 677f4e84e8344f4b974940d4980c2813e71714b6
Author: Piotr Zarycki <piotr.zarycki@gmail.com>

KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs

This commit replaces the open-coded variable swapping in the hyperv_tlb_flu=
sh
selftest by introducing a swap() macro in the shared kselftest.h header.

> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftest=
s/kselftest.h
> index 60838b61a2da5..7f53751523d89 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -64,6 +64,10 @@
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #endif
> =20
> +#ifndef swap
> +#define swap(a, b)  do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D _=
_tmp; } while (0)
> +#endif

[Severity: Low]
Does adding this swap() macro to the global kselftest.h header cause a macro
redefinition warning elsewhere in the selftests?

The tools/testing/selftests/mm/uffd-stress.c test includes kselftest.h (via
uffd-common.h) and unconditionally defines its own swap(a, b) macro using
__auto_type. Because this patch adds swap() to the shared kselftest.h heade=
r,
compiling uffd-stress.c will now trigger a compiler warning for macro
redefinition.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528154003.3594=
107-1-piotr.zarycki@gmail.com?part=3D1
