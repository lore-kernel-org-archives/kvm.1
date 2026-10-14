Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A014E8E0D
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982385; cv=none; b=YlqJ2cHRfcRa+IuompvY5tdErP9RdoPROg//YQS2qXWpSyq5zmsFk9tcTMAHgd0U1CGiPJQ8efa+8VQaBTI2FRSaI3xCh6y7pzMhsfrBKV8lHdKFX757+Dn+k27rXPNukLeo/vyJFBKSf8xl5PQKpgbBAw0iKymqBmIRi5pmoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982385; c=relaxed/simple;
	bh=aAgvRK91sijgkTZMKUFTnD0pPgXHNlwJelQvSsMqtL0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TM2XWWrG9ra46Vl06t/lgsTtY7YtQ46U35Hl/isxUj2KWOQ33ILp8aE2eauyAyXFXPjx8QJlbBnXDWr2esbAz4NyeSyVgcWznYt7CtYe7EvXMrgB5DhqObZqS7YHpE0cBzY6xe/M/R/rhGHWLi8GBKu84SS5zS2HsR7/wRuQ5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S36HrZfR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S36HrZfR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08071F000FF;
	Wed, 14 Oct 2026 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791982350;
	bh=jUdNW/s9tfgRZYmDLyn2h7vd0bdHMG0kdWHIqBY2rMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S36HrZfRwJgZpRrN7RPkBPrdfx8uWjkv7H2gWAYWP82B4UxRX4GG9xf17hvMS7jsU
	 chBSx/Eqp0qY5DftetoowIH1FGVY6W0NQRuQK/81ozbCebfyjJBtvmVnnoskH05ME0
	 RnAaR0Uq+KVEIT1nL2btCxV7bW0LsE1utRzZ5+6BT56J7eVxG0YPnNRk+PiNyxI0s0
	 n46ha/mP17jsgWyX4KyKqXqLhbnlo2n1NYdKOsphw7NVG4Pz5TNvEfP5BfstoC8Tpr
	 pV6oyVGeZR5OaL3YhEjx5R3diWs5pVlrzSVHcBd/60TgWUGQbg9WfOgbh5SUOVOo6w
	 xcmiZ0s06ZgJw==
Message-ID: <sashiko-outbox-171300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Adding support for hyper-v enlightments hv-extcalls and
 hv-memory-hint (hypercall HvExtCallMemoryHeatHint)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shmuel Fomberg" <shmuelfomberg@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261014123954.95181-1-shmuelfomberg@gmail.com>
References: <20261014123954.95181-1-shmuelfomberg@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:52:29 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] qemu: hv_madvise_walk_step drops overlapping memory hints
--

commit e5fd145c0d62c5737370ada9533f9341dfc23d5a
Author: Shmuel Fomberg <shmuelfomberg@gmail.com>

Adding support for hyper-v enlightments hv-extcalls and hv-memory-hint (hyp=
ercall HvExtCallMemoryHeatHint)

This commit introduces support for Hyper-V extended memory heat-hint GPA=20
range helpers. It includes the API for decoding and walking memory ranges,=
=20
along with corresponding unit and functional tests.

> diff --git a/hw/hyperv/hv-gpa-range.c b/hw/hyperv/hv-gpa-range.c
> new file mode 100644
> index 0000000000000..e6d3d3eb42f7b
> --- /dev/null
> +++ b/hw/hyperv/hv-gpa-range.c
[ ... ]
> +bool hv_madvise_walk_step(hwaddr *gpa, hwaddr *len,
> +                          hwaddr section_start, hwaddr section_size,
> +                          hwaddr *out_gpa, hwaddr *out_len)
> +{
> +    hwaddr skip;
> +
> +    /*
> +     * A hole with no memory region makes the section start past the
> +     * cursor; a zero-size section means there is nothing left to find.
> +     * Either way, stop -- do not advise or advance past the gap.
> +     */
> +    if (!section_size || section_start < *gpa) {
> +        return false;
> +    }
> +
> +    skip =3D section_start - *gpa;
> +    if (skip >=3D *len || section_size > *len - skip) {
> +        return false;
> +    }

[Severity: Medium]
Does this incorrectly drop overlapping memory hints?

If memory_region_find() returns a section that extends beyond the originally
requested range, section_size > *len - skip evaluates to true and the walk
is aborted entirely by returning false.=20

Should this instead clamp the section_size to the remaining length (*len - =
skip)
so that the valid overlapping portion is processed rather than discarded?

[ ... ]
> diff --git a/tests/unit/test-hv-gpa-range.c b/tests/unit/test-hv-gpa-rang=
e.c
> new file mode 100644
> index 0000000000000..70196f271b886
> --- /dev/null
> +++ b/tests/unit/test-hv-gpa-range.c
[ ... ]
> +static void test_walk_section_past_requested_range(void)
> +{
> +    /* Section is larger than what's left to process -> stop, don't act =
*/
> +    hwaddr gpa =3D 0x1000, len =3D 0x1000;
> +    hwaddr out_gpa =3D 0xdead, out_len =3D 0xdead;
> +
> +    g_assert_false(hv_madvise_walk_step(&gpa, &len, 0x1000, 0x2000,
> +                                        &out_gpa, &out_len));

[Severity: Medium]
This unit test appears to strictly enforce the behavior of failing when a
section extends past the requested range.=20

If hv_madvise_walk_step() is updated to clamp the returned size instead of
failing, will this test also need to be adjusted to expect the successful
clamped values?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014123954.9518=
1-1-shmuelfomberg@gmail.com?part=3D1
