Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558BDF76
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156162; cv=none; b=PjtPCcQkxTz9XWNp12vm9y6iMwGptcfubR8PUHZewXBCBOjHOTKs3KIcKmdvUBxoGOTQ/1r1QUvr9oL+4ti23v2wBbKqAxDGaR3nzAp/QeSB+Nbex5gTK2XwApOj8gUta6yoY84ppriuLEX2qjPud5LIIuBnE8n5ebxI0lbGsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156162; c=relaxed/simple;
	bh=QFfOHL3uccqyhXJWhcN8Wu61ZCZz/lr4yMiL5z/X8nY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBtOpVWRLDtsJm8pnveYP3J2Cb07L/1KJAzs2f7pzwLFVHBigfXegPxircZXLqmSPjE7SRj0XEpB2eCjyv6gKj9WTYTQGYUrnj+p2JQUWa+EMCN7euJkblOl1ORTp+KDTB7HBY5D6TTU3hrCEQejW9wvW3hgM1PjIx1Kw7y1iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGfDre59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGfDre59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2C81F000E9;
	Wed, 15 Jul 2026 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784156161;
	bh=F/DL7zCENArebjdvkI5RWab2xQti+SwQTuWO30W4ilg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGfDre59eaVqNw8rTf2dXkoLDfR3trIAZigpBPEV8cc9OxwTsli8zkxrDxavDJiZp
	 4E1FQLEs23gRKwDc5Hn0qzPcOmXNwXdzXlOcqy1GSGT1ncHqsTCbPJ+fr6neLNXaWu
	 lCzGvMNFZdBxmzc3MIUyyW9kHIV/A1svAC9fo2ON+8sbh77edqPHlHqkRIw0o8sVBY
	 c1/E56JPdrdww1nFm5Nynyyfo1NC/mOZQ0byAwRPTxr08ck60o26mi/vSj26VCTJrl
	 03el8ydcSKOfgUYLt8CkSioj52K9OQMgb4ZlYpID5O2knKMAI1C9Wv3lN/VXt5fJUR
	 rLmCWqg2kPdyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Make AVX512_BMM depend on AVX512F
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260715224030.3772948-1-jmattson@google.com>
References: <20260715224030.3772948-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:56:00 +0000
Message-Id: <20260715225600.CB2C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure due to undeclared identifier X86_FEATURE_AVX512_BMM.
--

--- Patch [1]: [PATCH] x86/cpufeatures: Make AVX512_BMM depend on AVX512F -=
--
commit 5ec2859f67a824ceedb01518734f6afb9a711eef
Author: Jim Mattson <jmattson@google.com>

x86/cpufeatures: Make AVX512_BMM depend on AVX512F

This commit explicitly declares a CPUID dependency for AVX512_BMM on
AVX512F so that disabling AVX512F automatically clears AVX512_BMM.

> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid=
-deps.c
> index 146f6f8b0650b..e2e3d0a3abcd5 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -75,6 +75,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {
>  	{ X86_FEATURE_SDCIAE,			X86_FEATURE_CAT_L3    },
>  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
>  	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
> +	{ X86_FEATURE_AVX512_BMM,		X86_FEATURE_AVX512F   },

[Severity: Low]
Is X86_FEATURE_AVX512_BMM defined anywhere in the tree? It appears this
macro is undeclared, which will cause a build failure when compiling
arch/x86/kernel/cpu/cpuid-deps.c.

>  	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
>  	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
>  	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715224030.3772=
948-1-jmattson@google.com?part=3D1
