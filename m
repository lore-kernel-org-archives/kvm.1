Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765C18FDBD
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053705; cv=none; b=PsFYdh0fv8kV9da79UcrfXBQdG4D7t3PmdmTzfRgzP5Wd65Ee67VUikIhbQk++3gA2ZCS8tmJ+URlZWJcCIFM5mSNNhh0bDxy3MWk0FT5vsXXFZhGVO/5bGhOVV1G2iNms3SyL3FXCuWAgiuHZZDS5bQAT+e6IJANhxCckFUPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053705; c=relaxed/simple;
	bh=RAsHGQJCtYZD9JyEGcEIgAU5bWSlADsLzg4t+DfIXLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOtpESwq3/ogpRwtiKAc9qvOmEzsDU73HoR0RUFI7zsi8gCLqhDAn30W1suDlqC3fcHPcPpQn88zXLqC8s6maaXBn7CCKEOpfLlzhtB+bJbRLEHteoATCx2j4meVtd7GJE7tXae1r7dTdERV/E1Y4+BBu8zFkjgSxYMG5uhB55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0ZG1a8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0ZG1a8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A0D1F00893;
	Wed, 10 Jun 2026 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053704;
	bh=puYDxufLr10GtcrvN+c9PgLATSz4YIweDKstVFGRNPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q0ZG1a8zxMPGBGgBNOaZOJ29tgsznn5oSr0uNnxrGK7Ts7XS14F+7kEz6DhE4YLI8
	 MpSyhbWc3hYIqCwFa/Gxb8YxjZJwWDKp86GwMMklorzDXTw+y3rG//5mvEZ4mIe1fc
	 sKGe8A0gKkoOyLebnvBYpWb9ibPu7ZLGm2GTT0V9bcYoI/Vilp6OghCUmxfYvcMDzR
	 HebkD2JWLke4Gy35dT4AdApm5fvW6SYAv7tUuBxttwlImJQMvZm4Wc8/9R+uESpglj
	 kef61gM8IqfUSma3o9Vh69MonufQvqWz3NOGdiGUuvB5FB55MYPJRzxe3fsEUEekCa
	 tGp6LrM9fhW4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/18] KVM: selftests: Add an irqfd send+receive (and
 later IRQ bypass) test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-6-seanjc@google.com>
References: <20260610005338.2967132-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:08:23 +0000
Message-Id: <20260610010824.47A0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The pseudo-random number generator (`kvm_rng`) is queried before=
 it is initialized, causing the test to deterministically use the same mini=
mum values for GSI and vector.
--

commit ac6e0b75a6ada77cf5a450f7c4989256698f5cae
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Add an irqfd send+receive (and later IRQ bypass) test

This commit adds a new simple test, irq_test, to verify that KVM correctly
delivers interrupts to a running vCPU when triggered via an eventfd bound to
a KVM GSI.

Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.c=
om

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> new file mode 100644
> index 0000000000000..9f8895b898214
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/irq_test.c

[ ... ]

> +int main(int argc, char **argv)
> +{
> +	/*
> +	 * Pick a random vector and a random GSI to use for device IRQ.
> +	 *
> +	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
> +	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
> +	 * defined NMIs and interrupts.
> +	 *
> +	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
> +	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
> +	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
> +	 * KVM_MAX_IRQ_ROUTES is exclusive.
> +	 */
> +	u32 gsi =3D kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - =
1);
> +	u8 vector =3D kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);

[Severity: Medium]
Is kvm_rng initialized before it is used here?

It appears that kvm_random_u64_in_range() is being called before
vm_create_with_vcpus() executes later in this function, which is where
kvm_rng normally gets initialized.

Because kvm_rng is a global variable and zero-initialized, the RNG algorithm
will consistently yield 0. This causes the variables to always evaluate to
their minimum bounds (24 for gsi and 32 for vector).

Does this defeat the intended randomization for this test?

> +
> +	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D5
