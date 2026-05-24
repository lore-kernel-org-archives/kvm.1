Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A26222584
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630469; cv=none; b=ErmKGoBmgF6InbxJJnhhjpFJS2mO7STC3wodA2nXEkB4OqPlPxMRVCp7CC3diXca819aNMuzdcNXb7DUxlkEvfT7qGi712uKYyM2qp/Id+NMkdTIhWH4AAuVgJ2nn0neVl33XF+55c4l4VyoTg09XcbDQVBGSpDUjvyaXKHLc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630469; c=relaxed/simple;
	bh=Qw0ZTDV82bexidZxaGAIfoU1delMmDlhZMmywnkZgL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6HwEWMOvNjcHnrciweF7+UovsvQbjIuK292hfTg1xzSpmdghmv9xW/omYScjgpxBr8v/M/pnTNg6gtwVChqIcvL5aEI/01gxoJy6AnTyDvJsCx5FeBaQdpfceRDxwg/x4mvG1IV/umHpoeFqC1LaZAUsTMwhH7/pmMsgMgaa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFSHenR8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFSHenR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477AD1F000E9;
	Sun, 24 May 2026 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779630467;
	bh=qp+0xP45WOTe/QEoairdXkSGX04lWYxN1QC7ZiE6zFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFSHenR8g50moJOh51mZYUcEm5RBw6m2dCzqu3b3nwyR4Az4P0Q0p3xBE6BP1whjU
	 uQ9DpKAkHmnZ42ocgrhQVt5oE0NViWkSD+Nvd9Uav0l4fn3MuFvTNOEqEuSse60pBW
	 l1LdT3u7ImR62N5rkGV31oE4KU0hj0+GYxhPpWXRkQgbM8QeruwFkgxlNB0gbUWXa2
	 rEzr9uhNCxAkkuAfjycSWmBkrVJrAnZ/ZnG3hojzh3ObCKm6+K5zIYTByDp7OM3/ie
	 hgJAaWYfEw0BeE3VpV4CkunJSTaJfn953jKczTVYt1j1op9QY6uFqE5SJmV4gCacwd
	 WlU2IKouWgSJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] irqchip/riscv-imsic: Add nr_guest_files in
 per-HART local config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260524132057.2425034-2-anup.patel@oss.qualcomm.com>
References: <20260524132057.2425034-2-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 13:47:46 +0000
Message-Id: <20260524134747.477AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential integer underflow in nr_guest_files calculation assigns =
maximum guest files when none are available.
- [High] Dereferencing a NULL mmios_va pointer in the error handling path i=
f allocation fails.
- [High] The loop condition for finding the MMIO location has a typo, actin=
g as an infinite loop and leading to an out-of-bounds read.
- [High] The computation of reloff can overflow unsigned long, leading to o=
verlapping MMIO offsets.
--

commit 4aa8684284dbd80a435c597515b94064848b6a3b
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Subject: irqchip/riscv-imsic: Add nr_guest_files in per-HART local config

This commit adds nr_guest_files to the per-HART local config to represent
the available guest files on specific HARTs. This enables KVM RISC-V to
utilize asymmetric big.Little systems correctly.

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index e3ed874d89e73..b8d1bbbf42f73 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -920,13 +920,12 @@ int __init imsic_setup_state(struct fwnode_handle *=
fwnode, void *opaque)
>  		local->msi_va =3D mmios_va[index] + reloff;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the reloff
calculation slightly earlier in this function:

reloff =3D i * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ;

If guest_index_bits is large enough, could this multiplication overflow
unsigned long? On 64-bit systems, this might wrap around to 0, causing all
CPUs to be mapped to the exact same physical address.

[Severity: High]
This is a pre-existing issue, but looking at the loop that finds the MMIO
location just above this code:

for (j =3D 0; nr_mmios; j++) {

Does the use of nr_mmios as the termination condition act as an infinite
loop? Since nr_mmios is a non-zero constant, if reloff isn't resolved
within the valid MMIO regions, could j exceed the bounds of the mmios
array and cause an out-of-bounds read?

> =20
>  		/*
> -		 * KVM uses global->nr_guest_files to determine the available guest
> -		 * interrupt files on each CPU. Take the minimum number of guest
> -		 * interrupt files across all CPUs to avoid KVM incorrectly allocating
> -		 * an unexisted or unmapped guest interrupt file on some CPUs.
> +		 * KVM uses both local->nr_guest_files and global->nr_guest_files
> +		 * to determine the available guest interrupt files on each CPU.
>  		 */
>  		nr_guest_files =3D (resource_size(&mmios[index]) - reloff) / IMSIC_MMI=
O_PAGE_SZ - 1;

[Severity: High]
This is a pre-existing issue, but if the available MMIO space for a HART
is strictly less than IMSIC_MMIO_PAGE_SZ, could the integer division
evaluate to 0?

If so, subtracting 1 would cause an unsigned underflow on nr_guest_files,
wrapping it to the maximum u32 value.

> -		global->nr_guest_files =3D min(global->nr_guest_files, nr_guest_files);
> +		local->nr_guest_files =3D min((BIT(global->guest_index_bits) - 1), nr_=
guest_files);
> +		global->nr_guest_files =3D min(global->nr_guest_files, local->nr_guest=
_files);
> =20
>  		nr_handlers++;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error
handling path at the end of this function:

out_iounmap:
    for (i =3D 0; i < nr_mmios; i++) {
        if (mmios_va[i])

If the allocation for mmios_va fails earlier so that mmios_va is NULL,
could evaluating mmios_va[i] cause a NULL pointer dereference?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524132057.2425=
034-1-anup.patel@oss.qualcomm.com?part=3D1
