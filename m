Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A032EC0A7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539723; cv=none; b=fVgh46sRzdnkyveGJSLAo/kxYcG2ilQXRZDaDZjhCL+rS1kdnES1nDsLnrWxqZ0Ta0SRt2uaK6ZQQIw9QyQ8thteIYWiIvD2KO1JnuUXcUGv152Tn5uJp4KqPJz3s0+J1Bu94rKntOYrX7AKBA0smjy/msXALigfeNiuFkaV3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539723; c=relaxed/simple;
	bh=JW+qB4GsuGptWQIbVdKVyFi+SpiTD+KRY5z+OEg2JQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DV3IfkidFILTUtmLQZoOHf3P3VAI8UJcy7BXlGKpqqn7KGKyZXmBGzklbmIfpTl3qgDs3UtEHJjN9zTlgVjbA7aYVATbXD8gDN8LzEVg5jUkmFPOQF96+l8UqW6Qssun8I1NmxGHRzQDImSX8dK1bNN3tCxJkYgn+OgAy2WnfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkiwkd1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkiwkd1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8F11F00893;
	Thu,  4 Jun 2026 02:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539722;
	bh=FjdjX51shvQyfvG198te+ChqrQqTufU+GR7QeVeXDMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hkiwkd1FktqlOvNMjgPtDmeb8EIQWHqMiYaGxeGk93/Pmwx/m7/tLm5paTrihb1ac
	 tR5pAD8odl+BNbACrqjvSbBDCee28H81uzFgZZ3L/QYGxNnb/6LmfE2veY+T2u2D7L
	 LnPaUwJuYgkd3FmtPFMuJVxEHgi3a03JKAP2bwZw2gYkephPtw8t9288h3/JzR4x94
	 sR7vk56g+Pqw3xJJclOSMY8709W1RY4i6HTwV//rOBUd3o9vH95BMlSqmdwLKtmav7
	 Wf81mEYBuY9YD63QuteZim7YYkEQmUj3x/VYTrBRQGo6p8cX5L8/w5S8yld3VmyEY2
	 ImQN6MuNoruNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/21] KVM: selftests: Add xAPIC support in IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-22-jrhilke@google.com>
References: <20260604020143.748245-22-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:22:01 +0000
Message-Id: <20260604022202.0B8F11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test will silently hang when run with `-x` (xAPIC mode) and =
`-v` configured with 256 or more vCPUs due to 8-bit APIC ID truncation.
--

commit 5d7e9bc4aa987e66842949c22b1af4bb4e8fff94
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Add xAPIC support in IRQ test

This commit adds the -x flag to the irq_test to configure the guest to use
xAPIC mode instead of the default x2APIC mode. This expands test coverage
to ensure that IRQ injection and routing work correctly when the guest uses
the older xAPIC interface.

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 41c50caa928e2..7e421cb7bc69b 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
[ ... ]
> @@ -31,14 +32,20 @@ static bool done;
> =20
>  static u32 guest_get_vcpu_id(void)
>  {
> -	return x2apic_read_reg(APIC_ID);
> +	if (x2apic)
> +		return x2apic_read_reg(APIC_ID);
> +	else
> +		return xapic_read_reg(APIC_ID) >> 24;
>  }

[Severity: Medium]
Does this truncation to 8 bits cause the test to silently hang if run with
256 or more vCPUs in xAPIC mode?

For vCPU IDs 256 and above, the 8-bit xAPIC ID will wrap around. When the
guest signals readiness:

guest_code()
    WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);

it would update the flag for an aliased ID (like 0) instead of its own inde=
x.

The host would then spin indefinitely waiting for the actual ID to become
ready:

main()
    while (!SYNC_FROM_GUEST_AND_READ(vm, guest_ready_for_irqs[vcpu->id]))
        continue;

Should a bounds check be added in main() to ensure the number of vCPUs is
not greater than 255 when the xAPIC mode flag is provided?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D21
