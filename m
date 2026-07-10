Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE3431E59
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722212; cv=none; b=Pnu+t+mh/l9SaAwOYSfPQmVMh3AqklIgqo1GnUYh9FFkd+Ddf9chckv4esb1f+gZF3tRJTKg/2fNRg0Z+wTAyiRdwYYNNED7+bliM5JQpjppcGvvEZcWdUOxAEhs5hYa3SsEFtWaARp00oXBs64eJgyvAoWqx4FsQt1FDDUgZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722212; c=relaxed/simple;
	bh=Z7WKBvsYejzofn0zvmRz0aw6ZDvA33XK3UskbfjMhMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8L2pAVS5TCvaeihMu6bR0R04u/2VVqia/8d3/E5pncmcue8aMgJWrfR7vrMoIDQU5Kh3/VBZX4cNrG4FWFK+/JZSMIKY5RvBFkYcRL7nQrTViFVBtR9t9kEL60Er/A5x/7o/4eEEMQe0eX2NjQ8To0kPhlt0DV1jhwX+Vglw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiJQZFLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiJQZFLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADCF1F000E9;
	Fri, 10 Jul 2026 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783722210;
	bh=UWnB6Vwi+LpySdJ3+Op9GSmelHWH+7eU2PgE7sgsazo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iiJQZFLA5FoNxzyWPsFxLevnU+7U36RPqcaxGyTyS9xd7dWumAGtmterd34rm10KC
	 o5bnEtmEKU+tfg7NFffBQnnN00ZCOzmC5iPHVgYR5ENwL8ZGe93dwZDloTwRGl4KRX
	 AKQ2WlLQuBLVaQFjosZPp0ZOie8ZqH8k3k46XCQpqDqEc9EeHEUNNqBGtXusYUJrx7
	 JmXrI33v/xwCvOuzJd74yznKDkT8gIdI6NtXEaw5yLA9vuvCVUhrNAYIOi6GcqSI6h
	 J9/OYrQ/UbEMA+3VJ3dN1x0AD4/n9on/KgDAMST/e0ULh89SVKfBsUn00BQqr3N209
	 J8Oj5XfkV/yPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] vfio: selftests: igb: Program MSI-X interrupt
 routing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260710-igb_v3_b4-v4-4-56e7e2576cc1@google.com>
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
 <20260710-igb_v3_b4-v4-4-56e7e2576cc1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:23:29 +0000
Message-Id: <20260710222330.5ADCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch replaces magic '1' values written to the `EIMS`, `EIMC`, =
`EIAC`, and `EIAM` registers with the macro `E1000_EICR_RX_QUEUE0`. However=
, in MSI-X mode on the 82576 device (when `Multiple_MSIX` is enabled in `GP=
IE`), these registers expect a bitmask of MSI-X vectors, not a bitmask of E=
ICR interrupt causes. `E1000_EICR_RX_QUEUE0` represents an EICR cause flag.=
 Conflating an interrupt cause flag with a vector mask is a semantic error.=
 This only functions correctly because the test uses MSI-X vector 0, meanin=
g the correct vector mask is `1`, which happens to identically match the va=
lue of `E1000_EICR_RX_QUEUE0`. If the test is ever modified to map the queu=
e to a different vector, using this cause macro to mask vector registers wi=
ll silently misconfigure the hardware. A vector-based mask like `BIT(MSIX_V=
ECTOR)` or `(1 << MSIX_VECTOR)` should be used instead.
--

--- Patch [4]: [PATCH v4 4/9] vfio: selftests: igb: Program MSI-X interrupt=
 routing ---
commit 338ad799b7305bfc613faa1dd3cb310b0417433a
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Program MSI-X interrupt routing

This commit updates the MSI-X interrupt routing for the igb driver in vfio
selftests. It configures auto-clear and auto-mask for vector 0 to better
simulate real 82576 hardware requirements.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -296,14 +296,35 @@ static void igb_init(struct vfio_pci_device *device)

[ ... ]

> +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> +	 */
> +	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
> +	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
> +	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);

[Severity: Low]
Are we conflating an interrupt cause flag with a vector mask here?

In MSI-X mode with Multiple_MSIX enabled, these registers expect a bitmask =
of
MSI-X vectors, not a bitmask of EICR interrupt causes. While
E1000_EICR_RX_QUEUE0 happens to evaluate to 1 (matching vector 0), this cou=
ld
misconfigure the hardware if the test is ever modified to map the queue to a
different vector.

Should this use a vector-based mask like BIT(MSIX_VECTOR) or
(1 << MSIX_VECTOR) instead?

> =20
>  	/* Map vector 0 to interrupt cause 0 and mark it valid */
>  	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
> =20
>  	/* Enable interrupts on vector 0 */
> -	igb_write32(igb, E1000_EIMS, 1);
> +	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);

[Severity: Low]
Similarly, does EIMS also expect a vector mask instead of an EICR cause fla=
g?

[ ... ]

> @@ -326,17 +347,24 @@ static void igb_remove(struct vfio_pci_device *devi=
ce)
> =20
>  static void igb_irq_disable(struct igb *igb)
>  {
> -	igb_write32(igb, E1000_EIMC, 1);
> +	igb_write32(igb, E1000_EIMC, E1000_EICR_RX_QUEUE0);

[Severity: Low]
Does EIMC also expect a vector mask rather than an EICR cause flag?

>  }
> =20
>  static void igb_irq_enable(struct igb *igb)
>  {
> -	igb_write32(igb, E1000_EIMS, 1);
> +	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);

[Severity: Low]
And for EIMS here, would a vector mask be more appropriate to avoid tying it
semantically to an EICR cause flag?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-igb_v3_b4-=
v4-0-56e7e2576cc1@google.com?part=3D4
