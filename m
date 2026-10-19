Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD74BB28A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405572; cv=none; b=LouzbLtYE5JSfEfmZztCRg4Qah7tn8aWJ9B4bXksXTMlUMv8qhkMSDUIESZw/kDZROAJnL0Nhr4IIrSzmJwaz/dCnRqgbwuj5hqjIp+Xi2mlV4x9Mgv7AchNDkMR7ascRd4l+7EsRRVhNuaO9tdSSwdB6m5dlyJpC7+AWEyJ+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405572; c=relaxed/simple;
	bh=rmkhjxn6evY87DojwQF3Aj4JGP/3s0aQLuBPZr8CmjA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bbUGOxPKIAH4mmCDYTtBcBNbIiBmS7ZRrkFYgpxbFiSL3nvM8QSLGTieGvU5iJLEHFirstAKg/1YJSF1b0iHpAXCP0YNW/DrMwHag+N2zHyHELy0TTSXUFelNzAqBgzfEF8wyHopPGMmudufjLzWBr1VNSRpUkKqeU5ExDm5KMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsG6QV0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsG6QV0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF11F000C4;
	Mon, 19 Oct 2026 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792405570;
	bh=iuuEVZQIo+T2EmzqE/L0S0Pbf8XhiqFrsn2H84YEgck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsG6QV0bCqZ/PN+1gZvFtmXNTj/44IbllLmuHYMjkrQcSVNebFwKrBQnCLm+kg5fD
	 8cft0nkR7cy5JoqjCHDiJtRHd4z5L7T1WRYgyyW3638Pps3eGYs4eudw3Lqj8LnKO9
	 l2yDRkUuv7N530lYS1kKuadCNhq0dnnty73rMzOa6EOuXRTrXb5OlbkShOnxL8XyU4
	 P8ighftiB/sZzNU/WLIWOAUGAII3WWJWIY2a6IskTdZ34DtGUU5motmEWAcHbyrBaT
	 iL3dpdRlTPEHM3snkl/OPh4KcqYZZcUmlIHkOyT3UZUfUEPxUupRk996vl88c1SUYd
	 zDuIsv0Boynag==
Message-ID: <sashiko-outbox-176983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] powerpc/pseries/eeh: Implement RTAS-based EEH
 error injection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019101813.45085-4-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
 <20261019101813.45085-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:26:10 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] powerpc/eeh: unused function eeh_break_device() when CONFIG_DEBUG_F=
S=3Dn
--

commit f6dd99f31147847bdca67c87e513a0d4e111ae24
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

powerpc/pseries/eeh: Implement RTAS-based EEH error injection

This commit replaces the legacy MMIO stub in pseries_eeh_err_inject() with
a PAPR-compliant RTAS error injection sequence using ibm,open-errinjct,
ibm,errinjct, and ibm,close-errinjct. It also removes the now-unused
eeh_pe_inject_mmio_error() helper.

> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index bb836f02101cf..369aad298f752 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1664,11 +1664,6 @@ static int eeh_break_device(struct pci_dev *pdev)
>  	return 0;
>  }
> =20
> -int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> -{
> -	return eeh_break_device(pdev);
> -}
> -
>  #ifdef CONFIG_DEBUG_FS
> =20
> =20

[Severity: Low]
Previously, commit 3af2e2f68cc6 ("powerpc/pseries/eeh: move
pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block") moved
eeh_break_device() outside the CONFIG_DEBUG_FS block in
arch/powerpc/kernel/eeh.c so that eeh_pe_inject_mmio_error() could call it
when CONFIG_DEBUG_FS=3Dn.

With eeh_pe_inject_mmio_error() removed, the only remaining caller of
eeh_break_device() is eeh_dev_break_write(), which is inside the
CONFIG_DEBUG_FS block:

arch/powerpc/kernel/eeh.c:eeh_dev_break_write() {
	...
	ret =3D eeh_break_device(pdev);
	...
}

When building with CONFIG_EEH=3Dy and CONFIG_DEBUG_FS=3Dn, won't leaving
eeh_break_device() outside CONFIG_DEBUG_FS trigger an unused-function
compiler warning? Should eeh_break_device() be moved back inside the
CONFIG_DEBUG_FS block?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019101813.4508=
5-1-nnmlinux@linux.ibm.com?part=3D3
