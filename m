Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2CB13A3ED
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779841156; cv=none; b=Zl9Vuks+Ud8Z17A6i0pSEBirtHh+ijpv7Ldolpow+hUCEI7BkXj3pYxLVqc/zK0yLwBfA28ohRjA9KHL96MnwvKKKLK6pq2/0V3F9w6+BdUbcWKOqOrK7yo+5wYa/TUCfj5uM59fJfxzeAoOvmWe4YzFF2IArmUfiC093wttBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779841156; c=relaxed/simple;
	bh=Q3ZSzoTbbhQQfW1/0T8VLRCcztyPU5yCT5010pTfJ2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VLn5a6ZANJ1+TkN5X4lbh4ThMVOvm4wg4NSrZzU9AlNqwYespjQ9aYO4AF3TzAas/5buUKHkxwohcmKf6vjX4MjxfttTYdmXLwfmawO4V9zljWvc+zft83caKWQ7VkZOTUFwQEKBHSpdQ8Lo6US2L94VL9dF+rHgkUme6Bi8Vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjQ2g6/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjQ2g6/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B6F1F000E9;
	Wed, 27 May 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779841150;
	bh=92avpitt571Ac/uoUrGGQoTvDlH7Cr/0mZOcnWd15C0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjQ2g6/oy/9SKUWstODE/5QWHt0697lTPON9KvY4CscWTht62JME1qc38vmzvBwQF
	 XuiU2WV4bdjTivCQmiHhEaIw3H/V7bewH+P4OuwtACAt/rgxKWv9u0oKNsBXiSli6+
	 KNnijDVkR0+wmId8xWjvx1oNkmF5d3FR/2HqZZ3HCJgfx7PpPx3rArXioahx85NuVL
	 dfgDVW2DSMbF43udkKl1QbPJ+Q5sDffUfd0x9Kzx4DLjMMQY5JsygzQ+FQAy0yNY+o
	 xYkQKOuE1C06UoQEhqq+eQfZg+ZOiP9PRbdqnP+szDcIF2G0KgYyGS6ZkSNDhZ05ZO
	 tKsCRYhAUOXVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] selftests/vfio: igb: Program MSI-X interrupt
 routing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526235417.2058313-5-jrhilke@google.com>
References: <20260526235417.2058313-5-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 00:19:08 +0000
Message-Id: <20260527001909.C0B6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] igb_send_msi() was overlooked by the patch, causing a state regr=
ession due to auto-masking and leaving a magic number unreplaced.
--

commit 059a9f7e058b59c775b2202ffd0af3e078efbd8a
Author: Alex Williamson <alex.williamson@nvidia.com>

selftests/vfio: igb: Program MSI-X interrupt routing

This commit programs the full MSI-X routing sequence for the igb driver in =
the
vfio selftests. It enables auto-clear and auto-mask for vector 0 and replac=
es
magic numbers with appropriate macros to match hardware behavior.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index c0f9cefb23e59..a8f2072b68200 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -271,11 +271,32 @@ static void igb_init(struct vfio_pci_device *device)
>  	/* Enable MSI-X with 1 vector for the test */
>  	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> =20
> -	/* Enable auto-masking of interrupts to avoid storms without a real ISR=
 */
> -	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
> +	/*
> +	 * Program MSI-X interrupt routing per 82576 datasheet:
> +	 *
> +	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
> +	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
> +	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> +	 * applies on EICR read/write).
> +	 *
> +	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> +	 * Without auto-clear the cause stays set after delivery and the
> +	 * test can see spurious interrupts on the next memcpy batch.
> +	 *
> +	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> +	 * MSI-X assertion (effective because EIAME is set), so a single
> +	 * interrupt is delivered per memcpy batch even if the cause
> +	 * re-asserts before software re-enables the mask.
> +	 *
> +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> +	 */
> +	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
> +	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
> +	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0);

[Severity: Medium]
Will this auto-masking configuration break software interrupt generation in
igb_send_msi()?

When igb_send_msi() writes to IGB_EICS to generate a software interrupt,
the hardware asserts the MSI-X message and auto-masks IGB_EIMS based on
this EIAM configuration.

Because igb_send_msi() does not explicitly unmask the interrupt before
triggering it, will consecutive calls to igb_send_msi() silently fail to
deliver the interrupt if there is no intervening unmask?

tools/testing/selftests/vfio/lib/drivers/igb/igb.c:igb_send_msi() {
...
	igb_write32(igb, IGB_EICS, 1);
...
}

Also, does the hardcoded '1' in igb_send_msi() need to be replaced with
IGB_EICR_VEC0 to match the other magic number replacements in this commit?

> =20
>  	/* Enable interrupts on vector 0 */
> -	igb_write32(igb, IGB_EIMS, 1);
> +	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526235417.2058=
313-1-jrhilke@google.com?part=3D4
