Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE99319617
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779641502; cv=none; b=cCt1ja7cAUyyKuxlwQ9cP+4YeTcU62cyWZZI0EqcJxzpM36H+A5IJ13BBc8X6J6YiHbu+IalTDABdUS1PuN9ujLhRbQ3MgTn/RNo5uEhnH14eMS44puZQTupK3EzJaiFcC6h0tbgDG9JAFYNv2yha3//281shGHvY9h8ke4pT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779641502; c=relaxed/simple;
	bh=c+rPaz/CWnp0JZeH1Nlr32cqZ8Y43DLwnqNAIn1jxgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbApcW6yDVtrQYKhu3wOTwGiS2Yg/uUl9uve5O02t9G3nC4KFC+wWYwrzt+X4oScIRybqjTQaW4wp7zte2dSGrYsIJgMSO6WVhQG0Ee18zElPQ6ekuCYqhoDjxcEglUSQYZys9JwiI0kfmEwiLK66mnFThdgVWQJdo0MIw8DaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXjxvj53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXjxvj53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05D01F000E9;
	Sun, 24 May 2026 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779641500;
	bh=XOf8FY7omscHZy2vGoeQHHC/TIufDhmRq9GZ6d4nT6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aXjxvj53vVQFpQ5D927ZXY2wQh1aAo2IUa6wPsEfRY/fe+A+M6ieBWgo+7YKqufla
	 ASJ4fyCaeQBilmQ5wAGv6xAhcGu5Xs+bblt7NwrKaTP+Es5cWo48bXDKaa/vbDMbOW
	 e0VtmybR2aPFNK0BaNNqEnC/I4faW7dLPpA5Q1N2r02NaR0KsiM7Xus6diDo8b6VnE
	 6L6wUrhq12ww/McDSA2UNKKmTXUtvmk1ZbmeyPv6SUC0IsS19LqbaJd/fv4CZJd2bu
	 32erKmAAYsvxRGUafshPrBswJnTLlOsP5amPvQPdUAGdySPObEujniKk8czKYB+L4J
	 qNoy9UzLAQQuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] irqchip/riscv-imsic: Add nr_guest_files in
 per-HART local config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260524162009.2602535-2-anup.patel@oss.qualcomm.com>
References: <20260524162009.2602535-2-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 16:51:40 +0000
Message-Id: <20260524165140.B05D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential infinite loop and out-of-bounds array read due to incorr=
ect loop condition in `imsic_setup_state`.
- [High] Integer underflow when calculating `nr_guest_files` causes incorre=
ct allocation of guest interrupt files.
- [High] NULL pointer dereference in the error handling path if `mmios_va` =
allocation fails.
--

commit be454e3625a328aefbec2427cced41abc7e30128
Author: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
irqchip/riscv-imsic: Add nr_guest_files in per-HART local config

This patch introduces a per-HART nr_guest_files configuration to represent
available guest files on individual HARTs. This enables KVM RISC-V to
support asymmetric big.Little systems by using the local configuration
instead of a global minimum.

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index e3ed874d89e73..b8d1bbbf42f73 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -920,13 +920,12 @@ int __init imsic_setup_state(struct fwnode_handle *=
fwnode, void *opaque)

[ ... ]

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
This is a pre-existing issue, but I noticed an integer underflow risk here.

If the remaining space in the MMIO region is smaller than IMSIC_MMIO_PAGE_S=
Z,
the integer division will yield 0.

Because nr_guest_files is an unsigned 32-bit integer, subtracting 1 will
cause an underflow to 0xFFFFFFFF.

> -		global->nr_guest_files =3D min(global->nr_guest_files, nr_guest_files);
> +		local->nr_guest_files =3D min((BIT(global->guest_index_bits) - 1), nr_=
guest_files);

The min() macro will then evaluate 0xFFFFFFFF as larger than the guest index
bits limit, potentially tricking KVM into mapping non-existent guest interr=
upt
files.

Could this underflow lead to out-of-bounds MMIO accesses when KVM interacts
with these files?

> +		global->nr_guest_files =3D min(global->nr_guest_files, local->nr_guest=
_files);
> =20
>  		nr_handlers++;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
imsic_setup_state(), I noticed a potential infinite loop earlier in the
function:

drivers/irqchip/irq-riscv-imsic-state.c:imsic_setup_state() {
    ...
    for (j =3D 0; nr_mmios; j++) {
        if (reloff < resource_size(&mmios[j])) {
            index =3D j;
            break;
        }
    ...
}

Since nr_mmios is used as the loop condition instead of j < nr_mmios, the
loop will never naturally terminate.

If reloff is large enough that the break condition is not met within the
array bounds, could j increment past nr_mmios and lead to out-of-bounds
memory dereferences when evaluating resource_size(&mmios[j])?

[Severity: High]
This is a pre-existing issue, but I also spotted a potential NULL pointer
dereference in the error handling path of imsic_setup_state():

drivers/irqchip/irq-riscv-imsic-state.c:imsic_setup_state() {
    ...
    mmios_va =3D kzalloc_objs(*mmios_va, nr_mmios);
    if (!mmios_va) {
        rc =3D -ENOMEM;
        goto out_iounmap;
    }
    ...
out_iounmap:
    for (i =3D 0; i < nr_mmios; i++) {
        if (mmios_va[i])
            iounmap(mmios_va[i]);
    }
    ...
}

If the allocation for mmios_va fails, it returns NULL and the code jumps to
out_iounmap.

Because nr_mmios > 0, the cleanup loop will attempt to evaluate mmios_va[i].

Since mmios_va is NULL, wouldn't this cause a guaranteed kernel panic on
memory allocation failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524162009.2602=
535-1-anup.patel@oss.qualcomm.com?part=3D1
