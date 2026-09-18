Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA32FABFB
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720573; cv=none; b=ooXu/vXjr09nObCEVLA3zLIhUzJ5Ei3Rsi6x9U7ECD8YXTN4fCtIEKXxvedLU1j1wF8xU4oKMmb1+tmO1ZXNFgc/JZKF4edMy1c2wU9QY/wUp/QZTc47qHTHoH1RfHcmN5pJBBtlh6aTVNXNrkfF1uESrisu8DdUOU3+lpk4PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720573; c=relaxed/simple;
	bh=WqXqmhBpPrLijvFhSguRZpQa1A1+JJ1eHdCmpAyw9C8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuwadQJdYFbx8P6WVnJpJuGfMhOeugtSBGExLXNgu3Ct7kYC5n2vsmyJAkTTnl/YIR66cW0rO2Cfla/KLWDNZoYvkeit3VjvfL/oxCMoW1FttNO4QRm+oP22MtIYsaujK5z7gIXY4asgt36eaKYFcX6DSG2uyubZGllqBuH0odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2DjpjW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2DjpjW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8E61F000FF;
	Fri, 18 Sep 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720571;
	bh=O5No9IRzhD59an1QR1YGJjY4qrXW4GWwjFayfs7waEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2DjpjW8Ivja3EOpIhfSpRpHCpS4RwQo/7JcS1sI1w21EoA7r75Luwwu+hcQ/pmcm
	 FxSHGgVCr1Hidl56SwrZ2VJJagkFmlZh2K+qJChMePy57IzTZwyHxqfSh17nGHkATs
	 hOIsxRLZgtdqKU2LEdL89Xsq7ift7Rx0w5Zy+9U6z7yRYGffvupuJmyxL0QuFokNPw
	 Jozg80DjoeXmUJkH21p8G2Ly7YyL3UFTlQdslq8p/SMoWa1D9qjd6agq94iJCl0gUZ
	 pgNEN4z08TY/NhBzPltjS3VAovOPng/QFH3LFv8XYzWWSJ1QGdW7umuXevRD55zQpS
	 Gxs7XklobYGyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/28] KVM: Introduce NR/NW/NX memory attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-13-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:36:11 +0000
Message-Id: <20260918083611.7A8E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: API Misuse in WARN_ON_ONCE with string literal
--

commit e4ff873cd187bd01c3fc362fdaed04c8d470baa7
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: Introduce NR/NW/NX memory attributes

This commit introduces memory attributes to map guest physical memory
regions as non-readable, non-writable, and/or non-executable. It also
adds an architecture-specific callback and a basic implementation for x86.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 50e042c58246f..452ec3a99ba6f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

[ ... ]

> +
> +bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsi=
gned long attrs)
> +{
> +	WARN_ON_ONCE("KVM_MEMORY_ATTRIBUTE_PROT requires kvm_arch_mem_attribute=
s_supported_prot()");

[Severity: Low]
Does this code use the WARN_ON_ONCE macro correctly? Passing a string
literal as the condition evaluates to a non-NULL pointer, which is always
true.

When an architecture implements memory protection attributes without
overriding kvm_arch_mem_attributes_supported_prot(), the weak fallback
triggers this warning unconditionally. It will also fail to format or print
the intended string as a log message, producing a stack trace without the
descriptive message.

Should this perhaps use WARN_ONCE instead to print the descriptive warning,
or pass a proper boolean condition to WARN_ON_ONCE?

> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D12
