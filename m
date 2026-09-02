Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59C47D92F
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351443; cv=none; b=Z4/HFy8l6li9e5UFCJnzZVJXk1Ct/bPBJffSeor4jb81HhrlQqYEGy/pAwzZyOM7enE6/raDtYoSvem8P8KQgETKVwOvcK3l20RkkIyJhfNf/wIysb576EcTGnIVSN1quXnrR9pNPa5RPz4FFOUq8zcaitAzFTfzXy8sAXsk98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351443; c=relaxed/simple;
	bh=WrgD2gCeiJBqGL/RpG9c9vEdvlvPKPViQl98njwAPpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFhoiVFDOnmh/Ph8ewvHYbQlOYFv2eOa+oWQ/fZfvY7B20fBHoVHhvVxLG7134pUFEEsNPuc9DuL535Cu989f+XRz/jxFzmtiq9i0r/WwqJ1rXeSkCYGBVHF2Z69WQtN7SQ+14XPPoxEB9u6B73jRaTsvGv98byEaHcgzUiqrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/+lGMjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/+lGMjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2FD1F000E9;
	Wed,  2 Sep 2026 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788351441;
	bh=tF2mDH95Pk+XzO1xrSpaqkQH/IQijWIdkylZecMvEXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/+lGMjpYW0p81UltQceIy5NBEoGaX03AsSDB3fJe6am7ZjG+lAw8c9uOO3k41Nhk
	 SdCm5CbxDp3NyWVktAY3bXn0IRZj+hBctMLwHZUvjsTSj9cqZagNCS4Ym2TfKAWn7Y
	 hfJQomqgbpurgYIMLOs+Llm9ixyrqpG+QEzKH/ke0O0nEi1/4Cdxdlye7C+Q31Zj8f
	 K8rDgIOvyDCTKi/Y0tfda9DTJMnzxsb02ZDdoDl7sjrTYaNjkcyxGVMt3keuWWZg42
	 9hnCXOvoN+76yIIiVM+2r74zE3oeBLDiHD8sPvgqVRYEuxAalYuJbabyQqVN1oMAl6
	 LaVmtN3/hcWeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 15/21] x86: mm: skip collapse_pud_page() when
 CONFIG_X86_DIRECT_GBPAGES disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902-dummy_ptxp3-v3-15-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-15-5d8f5b17c25c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:17:21 +0000
Message-Id: <20260902121721.9A2FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect Kconfig macro name `CONFIG_X86_FEATURE_GBPAGES` uncondit=
ionally disables PUD page collapsing on x86.
--

commit e72cd2f328b1fab1c51fad6dcdfc5273b0764f4b
Author: Yeoreum Yun <yeoreum.yun@arm.com>

x86: mm: skip collapse_pud_page() when CONFIG_X86_DIRECT_GBPAGES disabled

This commit skips collapse_pud_page() when gbpages are disabled to prepare=
=20
for compile-time folded page table changes.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index a1a061d995b31..07a873775279f 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1315,7 +1315,7 @@ static int collapse_pud_page(pud_t *pud, unsigned l=
ong addr,
>  	pmd_t *pmd, first;
>  	int i;
> =20
> -	if (!direct_gbpages)
> +	if (!IS_ENABLED(CONFIG_X86_FEATURE_GBPAGES) || !direct_gbpages)

[Severity: High]
Does CONFIG_X86_FEATURE_GBPAGES exist as a Kconfig option? The commit
message mentions CONFIG_X86_DIRECT_GBPAGES, so it looks like the Kconfig
macro might have been mixed up with the CPU feature flag X86_FEATURE_GBPAGE=
S.

Because this Kconfig option does not exist, IS_ENABLED() will resolve to 0,
making the condition unconditionally true. Will this completely disable PUD
page collapsing on x86, preventing 1GB huge pages from being collapsed in
the kernel direct map?

>  		return 0;
> =20
>  	addr &=3D PUD_MASK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-dummy_ptxp=
3-v3-0-5d8f5b17c25c@arm.com?part=3D15
