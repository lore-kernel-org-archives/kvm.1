Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D317A30A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939766; cv=none; b=LsFA59Bmr29pDWkTJkRzfsPz4ieP1I/NHkbjeRvIFfuTKs/8En3WvSnrl0CFBHx9VzktHlqLJWE0R6W1X0gyJ6ZveuuFxM2SmrUoAzbPjYkBWZeBINFT4umYgMJLGNK1ISsxrAqm1TWBGYtEUiXkUWwi6nrR0umt9DDgwM21GZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939766; c=relaxed/simple;
	bh=dG5bJef4WjzduW8/n49MGPPPL2IPMdgsM13RGWYT21U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SP43aR9RVyHGn/D2H0vbPY8NDH1putikvfIstYlbFsqkITT447HIVHvRVynBfmYPZLlW+/ZxkQDBLW7deEm7Oaa6EdfzmQmJ3n5+mcFbgVW+uME3/bJhv/KVYEnDRDNlgGVLxDZ8CzL6EskX43IcVsLVDBYP8hHa4n36ELCXiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/JNk3TL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/JNk3TL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8041F000E9;
	Thu, 28 May 2026 03:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779939765;
	bh=gi0JgZZNCZNSVuD/3U7eXQbsBoJOFFX8cnDQjo7B09g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/JNk3TLVoXMGUzStYMJd6tE5FUP5sJAE1ZDoTlfOeWf9iTH3v9SBNeZxxNDnQ0Pt
	 fyuebR65bPS9OYqelY4lkz7KqpjwhBn8DYY4zEO8GXk/afAiJNsLzaW/qeEal9s69x
	 ZID/wXKPRSJhUMs2oDYqgG+EaDLapHaYu3vuMUlSSFB7qImiR2yF2Pq9WRR7bVbGLW
	 S39qeyCr4aWJBv45f64+xcxAEXmmOxrMPQN0TfzDGWnOAfhP7fKZd+HKe5jA3gxQ9I
	 BgKLLMmmIsF1vFLE0b+enINuYPdAAk95yBThlSUO5qiA0xTHvyNfCT1sHdE/XDcgIo
	 GdasoF/zJJLoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ewan Hai" <ewandevelop@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528032234.1322565-2-ewandevelop@gmail.com>
References: <20260528032234.1322565-2-ewandevelop@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 03:42:44 +0000
Message-Id: <20260528034244.DC8041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch modifies `arch/x86/include/asm/cpufeatures.h` without syn=
cing the changes to the tooling copy at `tools/arch/x86/include/asm/cpufeat=
ures.h`.
--

commit 17e8fbfd326bc812ee6f132253d520b0c7201874
Author: Ewan Hai <ewandevelop@gmail.com>

KVM: x86: Expose Zhaoxin SM2 CPUID feature

This commit advertises the Zhaoxin SM2 algorithm and SM2_EN features to KVM
guests via CPUID 0xC0000001 EDX bits 0 and 1. It updates the CPU features
header and the KVM CPU caps initialization.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 1d506e5d6f46a..20b33413189c2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -136,6 +136,8 @@
>  #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a =
hypervisor */
> =20
>  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word =
5 */
> +#define X86_FEATURE_SM2			( 5*32+ 0) /* "sm2" SM2 algorithm */
> +#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* "sm2_en" SM2 enabled */

[Severity: Low]
Since arch/x86/include/asm/cpufeatures.h is modified here, should this patch
also update the tooling copy at tools/arch/x86/include/asm/cpufeatures.h?

Without syncing the tooling header, tools/perf/check-headers.sh will emit a
warning during the perf tools build process indicating that the kernel ABI
header differs from the tooling version.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528032234.1322=
565-1-ewandevelop@gmail.com?part=3D1
