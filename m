Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B30F43F4B7
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571477; cv=none; b=dZBfeZIvdib4KPCo7U+Gf2cmRw4xn27IoszLJqhxvyi5KgUoMZa6wUvJvl/SsL18H45xu4czUVAPf1gPp88mJEYfrumpayAI5hqS1rPITjs5ljR+akr+Ny0X36wEsKPbqNXcqw2mkVQ27RqGmzA2+HnsBarvRhBmht4oDlrabMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571477; c=relaxed/simple;
	bh=KIoepk22RoH2a8NB3lin7fc6u6996T1jzam+QWoThCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aY+NlukOQipwNxDbjl8HnVLsIgKk+Wb+gAa/kbZcL8p4zD8HYtaO/pAt8Ibk+BR22+WrG5/0lqz1uwzd0xHrXLw7zG4aa72fd2zPMQ27g9nHOY4iAYUOKhB8FD0RY5gln/TFIZIG5qKUZe8iYdrlAvsfi/br38AwmwiEPoOBtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY/5pS9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY/5pS9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2190A1F000E9;
	Mon, 20 Jul 2026 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571476;
	bh=96Gnv5dPp0NCP0WDWbpua1g8BNPMocrJj8xsUyGVj2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iY/5pS9PO4eXxzQeSE7k0HzsFj3ga6ni25YugG4lktBUqdBxX7ehrzqFC8eZiRVkb
	 3xBBJMaCh9ccpDwy7g2gOmqpYLKYhZeK/pxQBZsZnTuo5DvHLc2lNdWfDSXq9TLlbt
	 dunW9gxycv2MT7g1rmO+DurwfGhYpb3ul/DMPSbh6xGL11y3TxjzpJS4P4YN1cZwaJ
	 T4eUWZKWO1M7fL+fZqHHh9PnAqUcVNW3xIm6GQ1lZNosOZ0qFvnlT3V1IdWWa/QDRu
	 LwUOSeXEtBBW1Go/PTDCECNAqZQtG02PkJyKzN6J1hgBB8OwXQ1MhSOOB7yPUo1btY
	 +afkLoyEe0bbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/20] KVM: x86: selftests: Add APX state and ABI
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-20-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-20-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:17:55 +0000
Message-Id: <20260720181756.2190A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The inline assembly in `read_egpr()` lacks the `volatile` qualif=
ier, allowing the compiler to optimize away or cache the EGPR reads.
--

--- Patch [19]: [PATCH v5 19/20] KVM: x86: selftests: Add APX state and ABI=
 test ---
commit 7c0f33a315737d86b103b402a97744d82eb69544
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: selftests: Add APX state and ABI test

This commit adds a selftest to verify APX-specific behavior and ABI
interactions for EGPR state. It ensures that the state is saved correctly on
VM entry, retained when APX is disabled, and properly exposed via the XSAVE
ABI.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> index 7d3a27bc0d842..5f5acc33486ab 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
[ ... ]
> @@ -877,6 +879,124 @@ static inline void write_sse_reg(int reg, const sse=
128_t *data)
>  	}
>  }
> =20
> +static inline unsigned long read_egpr(int reg)
> +{
> +	unsigned long data =3D 0;
> +
> +	/* mov %r16..%r31, %rax */
> +	switch (reg) {
> +	case 16:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc0" : "=3Da"(data));

[Severity: Medium]
Since this inline assembly has an output operand but lacks the volatile
qualifier, can the compiler optimize away or cache the EGPR reads?

When compiled with optimizations, GCC might treat this as a pure function a=
nd
reuse the initially cached values across GUEST_SYNC barriers. If userspace
updates the EGPRs in test_userspace_update(), will the guest compare against
stale cached values instead of emitting instructions to re-read the hardware
registers, causing the test to spuriously fail?

> +		break;
> +	case 17:
> +		asm(".byte 0xd5, 0x48, 0x89, 0xc8" : "=3Da"(data));
> +		break;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D19
