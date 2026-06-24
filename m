Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B330FF31
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322089; cv=none; b=n93OdAh9JoLaO+up2SgfumiLJWtEmlkXwkI/xysSkq1GxnNYUIQ2XX+szDvzyckCd/+lYVFKjlBWQ9BZD9dUMWFYoTCPxEkBO797NIjXUClR3cHWuqA9vm4QMjx+VB4xCk9vd6ymRc3TBbeY+qKLSJU7jql/PdnaJaLQic+qsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322089; c=relaxed/simple;
	bh=HGSEFcA/d19naeuQDccq7srbWiK1/uYQbzu177b7Wr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1r3r+9c5G/8akTPtRukgAZ6q0/0ivYsTOGYDBlGBvsCdci6KSqaTyzd0FlA/x+tkn5tna8c8Sg6vEoG7bIFGUGk5kQB0PjUi/HAwiHPJq2FxZ+fq3OWBgXFTdD++U26qGZ6zGDySpUd3GYovOAZzl+m/gvYK55yC0++8PRkkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouCDKK3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouCDKK3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190341F000E9;
	Wed, 24 Jun 2026 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322088;
	bh=pvyiZLqyBzJqQ5BsO6U9x98FQu5DitCesrcZ7GeWAKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouCDKK3orB3SPgn2bfBgOUEjL/uemUxix2YunGp+i3IrATGzjpHiABUMnKB4AMscB
	 exrd32jeRwG+65CBB/AjS0njgKNvM90p9ShoYgydijuIGoWD0DDzbf82yoeMzbttTH
	 zjccSCS2Z5H96dBqOtlt1eKnCQvkXV9hCPFxtoL+Ba7CygXub/ohCxx4gKc8SaveZ7
	 VizzIjwOHkFWC917eKSSXMiJfVjidGiuFqPp/nROxM/DpcK/cJRR1qFH5InXFZV0m3
	 CHOlHrBiXLl9NpAsX3YkOyXl2MqCuFXqUV1nImEmadUTiNR8CobwTSx8tYceVW4w6j
	 CW9k9FddXuOGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] KVM: selftests: Check dirty-ring size before
 enabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leonardo Bras" <leo.bras@arm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624171656.1737580-3-leo.bras@arm.com>
References: <20260624171656.1737580-1-leo.bras@arm.com>
 <20260624171656.1737580-3-leo.bras@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:28:07 +0000
Message-Id: <20260624172808.190341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Format string type mismatch causing undefined behavior on 64-bit bi=
g-endian architectures
- [Low] Misleading error message contradicts inclusive boundary check
- [Low] Misleading assertion failure when dirty ring capabilities are unsup=
ported
--

commit 8555e295b2631adeaf18b3b867988e6adc58eb4c
Author: Leonardo Bras <leo.bras@arm.com>

KVM: selftests: Check dirty-ring size before enabling

This commit changes vm_enable_dirty_ring() to dynamically fetch the maximum
dirty-ring size via KVM_CAP_DIRTY_LOG_RING_ACQ_REL or KVM_CAP_DIRTY_LOG_RIN=
G.
It then validates that the requested ring size is less than or equal to this
maximum and is a power of two, printing a specific error message if the che=
ck
fails.

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c

[ ... ]

>  void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
>  {
> -	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
> -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
> -	else
> -		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
> +	long cap =3D KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
> +	int max_size =3D vm_check_cap(vm, cap);
> +
> +	if (!max_size) {
> +		cap =3D KVM_CAP_DIRTY_LOG_RING;
> +		max_size =3D vm_check_cap(vm, cap);
> +	}
> +

[Severity: Low]
If the host KVM subsystem does not support these capabilities, max_size
will evaluate to 0.

Since the assertion below will then fail for any positive ring_size, does
this create a misleading error message about "smaller than 0 entries"
rather than indicating the feature is unsupported?

> +	TEST_ASSERT(ring_size <=3D max_size && is_power_of_2(ring_size),
> +		    "Invalid dirty-ring size: Should be a power of two "
> +		    "smaller than %d entries\n",

[Severity: Low]
The condition checks if ring_size is less than or equal to max_size, but the
error message text specifies it must be "smaller than".

Does this mismatch make it confusing to debug failures when the requested s=
ize
is exactly equal to the maximum size?

> +		    max_size / sizeof(struct kvm_dirty_gfn));

[Severity: Low]
The expression max_size / sizeof(struct kvm_dirty_gfn) evaluates to a size_=
t,
but the format string uses %d.

Can this cause format warnings, and result in incorrectly printing 0 on
64-bit big-endian architectures since the format parsing will read the most
significant 32 bits?

> +
> +	vm_enable_cap(vm, cap, ring_size);
>  	vm->dirty_ring_size =3D ring_size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624171656.1737=
580-1-leo.bras@arm.com?part=3D2
