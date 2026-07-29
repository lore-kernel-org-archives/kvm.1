Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A433FE09
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355730; cv=none; b=NNFkd7EiYId7DipMFhCJEsdMYSjAuuIq/a+SQniS3xvXXesqdDCN0tlTVfr5LIFftskZUmSFXYxetFmCBycR5sLA4R/zk6x8pq5yxjIMF5iaufFM5m5C+kbcPCaxHBnz25nm/c8PsVl5QQd1iYV7OFVl4ZT9GhZxIizKpTTPFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355730; c=relaxed/simple;
	bh=04ubE+Ym+kJpYm5+fLJYZDm52Gr7jZEuPGCQtRUhAaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9dWqsqzHhTyv8LMYj9ZFpp7zgwYYwsC9dZTAF/ff4iL3duNft7nQVi1ar4Zik3Mkhur0eUUjPpR+uJrytGnCDi7kvEzf3K9jPLpSKapwkeJdvZ5mbMROg8I6kvaYK19QcK5c9ZqFv2UYLaI4kr7pdh9l0ZwmILhwlMV6JusFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi3F05Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi3F05Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F191F000E9;
	Wed, 29 Jul 2026 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355728;
	bh=H/y0ln9zSc+1MjE1/ICWrxXlOgC3MkepOceTozBz5Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pi3F05HnSPpjluzJrV5n3BL7+UU0Hqk7uM1w2nzulc6+yOhy+OAKn8e+D/GI+W0Yy
	 wiS3iGwYI2CfWySSM1MD6u7wBAnfd4QcEtYxm4FkrPWlILHf4r907qsAO+yr3ZanJ8
	 PG/J6iRWf2z+uzdYFlYfpviyu4ulTwlp28rU8ZLlV6P9vMNKGRcTfKS7neRJqoXmvQ
	 yiUtnYgd84EgaQbf2Hd4864GtTdHT+aNdRMm8b/43AOivO5nMkOtuqAJist54ZdmG2
	 OCWGAooQYwNqhdPPtAaQpF2Nk+PYEh0JXAS3GI1Jz2gMIdftwD+RQH2M+UqsxM8Q9Z
	 BYRIUqswgzocg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 19/20] KVM: x86: selftests: Add APX state and ABI
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-20-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-20-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:08:48 +0000
Message-Id: <20260729200848.81F191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The inline assembly in `read_egpr` lacks the `volatile` qualifie=
r, allowing the compiler to cache or incorrectly reorder hardware register =
reads.
--

--- Patch [19]: [PATCH v6 19/20] KVM: x86: selftests: Add APX state and ABI=
 test ---
commit b6d4e7dba224ce722415441a2fa9a8f67f8cb213
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: selftests: Add APX state and ABI test

This commit adds a selftest to verify APX-specific behavior and ABI
interactions for EGPR state. It tests state transitions across guest
updates, userspace updates, and guest APX disable scenarios.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 7d3a27bc0d842..5f5acc33486ab 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
[ ... ]
> +static inline unsigned long read_egpr(int reg)
> +{
> +	unsigned long data =3D 0;
> +
> +	/* mov %r16..%r31, %rax */
> +	switch (reg) {
> +	case 16:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=3Da"(data));

[Severity: Medium]
Since the inline assembly in read_egpr() has an output operand but no
inputs, could the compiler aggressively optimize these reads?

Without the volatile qualifier, GCC treats an asm block with only outputs
as a pure function. This means the compiler might cache the result across
synchronization points, as a memory clobber in GUEST_SYNC wouldn't
invalidate pure register-based expressions.

Would adding the volatile keyword here be safer to ensure the test
always validates the actual CPU state rather than a potentially cached
compiler value?

> +		break;
> +	case 17:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc8" : "=3Da"(data));
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D19
