Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A43ACEE3;
	Mon, 10 Aug 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405253; cv=none; b=Qo+Pv5EXMWgnL+GdKuoL58OogE8PsFEqOlBFQYfqvq7ZVqgOx6kVpuFCwILOV8Uru89GKMuiociyxB82qxpglDpxvTaJipZ16aYFVj+BSHKanQDjyKQ6yIlmZNzbnWuswsOZ+V5jDSyEcEfLPy/8MPDUUPhnbLdSWMjBNX6WQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405253; c=relaxed/simple;
	bh=aGHwrGUipdw8/57k51g8XciJA32CVX3nd6yRxbRJEow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmEFRuYRk1g+TD/zmfhnRfXksz0UXN3xwO9Ooc3rvHi1dI6IaTHeC/c2RnfgdMshOl2riwGjzBwUU7mUUtjGXVU1LCP8VvD389GRPPDsok+gsUpeeBafnr/HFBwlE3ePJRRLf6UGzrapjiNKmjTmZq+yTcRy/N6x5t6AnY2twJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RucuNH5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef3Fb1zB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RucuNH5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef3Fb1zB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A050EC0212;
	Mon, 10 Aug 2026 19:40:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 19:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786405250;
	 x=1786491650; bh=9k3iKQHBNAdQlxm9rTH0r+n47JU9e7XSpYd9RvZ9Aoc=; b=
	RucuNH5eppUigFaSxctqjMezcWylVAYQntlQy7ApQP3E0pE5fEMgUNnFX3pt9APq
	dqRfGOSzm1tyY3T2xBmKq/L3tPBYv0pV7R2MeNxlwlgn1owBDHbj2a0FZoqMoGKG
	ju1CETKuwBQwRmpn0qbRIWHxESz9p9BiuudrMNY05ruwiqRmwS2mFhnZdY/5DSje
	vOsmuVUwFGUM/DAHEK8khk+JfSCu/fvMc8qBVFKhrDK/cDlHEFTPEg4ANF75Phfi
	yeQdH0xO0rr6SbJHUjP09zIxVjr4LWzB8hVDzsi/qHQR8ydSCDWIM5nrJjEXkA1v
	fSZfPf8jEsEI/QBZ7+WRog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786405250; x=
	1786491650; bh=9k3iKQHBNAdQlxm9rTH0r+n47JU9e7XSpYd9RvZ9Aoc=; b=E
	f3Fb1zBscD2PbwI1NRa9xsgWHiilPL2OpzqQVOlPymrfQvanLr0AmRobKw2mK1ng
	XcZa1M+bb9Dy7yYlZ1xlnLTiMY9tdNLW7cCpceXRYx4WhkP0tuWAsOWDYLeXpoDg
	/LFTPFgCzBaabBpyrCTuaRT3+kmXELNyPBumBKPKETrXVJb4kY1LCfHD9+eaLjen
	DDU4GOOnkRWF2Ao2hjiqwptNwJwhi8EUsMT1yjXbFww8aQ1RSuFx+7ERfL/JzFRF
	3sZ0zzIHbVZyxgENVD05bfMYYiIx/w9GRjaNTrky0DK7T/tFX79vSR/7EmsBbHh2
	FtGdRAu7/mxu/G8qW/iAg==
X-ME-Sender: <xms:gmF6anrZL-qaty1VDGY5SnDlJReaZDhS-2dM4oQVcdk98D87CklUhw>
    <xme:gmF6aiHr3A3D06KK02nvr71w-b1lvxh4ypr3R2j2n4Uftf7Kml0elFd-iDBkGGruW
    2J8arJkWI8xXHXh1IA8Con3aiLUmlZC5ApkpY5pKZhNuyrO8x_xnA>
X-ME-Received: <xmr:gmF6ak6_wovlsfWOwmvVUrVW55K_LUkO3o7i-yfNxkyPP6Uek0ShbMkouKJWWw>
X-ME-Proxy-Cause: dmFkZTEdc0M5tYo5B3LMfb/Pw9I4WHXy5zXQfbC9vUbftuB8SUi+mXc5rSrgagD5xnEofX
    uYITiqwaxwTlaIS8lHB7oiaygsLwYaShEThgRKUMNhui58ZqnzoUxnUWVnDfUhtMZBP6nz
    gWVwuwTzfyDphl4XQ5g2EKPF4yqXLam0FtTmhUdZY7AsJRgc41XwzNuk+x6NaQIAGuwLW7
    b7BOgC9u+eWeUIUC6cQS4fFJ/zz7/GdVY91yhyQKe4K/M7DsM45Tr/oiNDGqjXL862M6/l
    mlk16eTS0XQlE5YZgyErGor0fiGi9fthSPZxvZeaoYLKSKLcLHdL1DRwq34snDGYUNJEP/
    OvkfdMtPBr2YWmuzLhAnu7IGgrI0qBZ3NINdW+wOeuIqHH5cJCB4c6zjxrNEBGcxMcj+Mb
    Rdas7KNPPFbXJU3fKwirXpNQ4+LYSTBXFhhsMQhfXAAN+5YIpFrepvNkwJnw9RAR63H8pM
    oQEFK8CagdWJuOKP93I31dhJzk04kB9RD9VM9g5De3xB0UqkH6gJXv9Gi7wPbxPMXFVDr1
    c8fhn0+jq4v2EQbvOtp4ST2xTr02x6z7OcfKHC94IvisFP+6NG6fo7XkG6nPH+L5WF71Zv
    OAhzRIHllhoi44eHQqfo1jqV2eiJqEP/RKn9doO17lf1qoHZ0gqD7TihjIXw
X-ME-Proxy: <xmx:gmF6aidvf_HjIb_i4JSKIr57kAS0J56W37r1da8kZaRnyZuh83GyXw>
    <xmx:gmF6an6WuQ6W0Jh67hOnbIanN4d0JAUHxyIEAABn5q-3ukPOAEvSlA>
    <xmx:gmF6av9I1zKdAa8XB6K6CThZ_RFNZcuPmFF3AgkerRyqMjvadJWEvA>
    <xmx:gmF6apEGcdqioZIC8GmZvgaDai7EKHYJyUQzGdfUG7We_irzCjv6Bg>
    <xmx:gmF6aunWdC7s4Wrp6vypeTWAeshxMdnqcy9xAlms5W2L85TnJSjj-ml0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 19:40:49 -0400 (EDT)
Date: Mon, 10 Aug 2026 17:40:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, Alex
 Williamson <alex.williamson@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v10 0/3] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
Message-ID: <20260810174048.4e83f24f@shazbot.org>
In-Reply-To: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
References: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Aug 2026 00:20:57 +0000
Josh Hilke <jrhilke@google.com> wrote:

> This v10 of a series which adds a VFIO selftest driver for the Intel
> Gigabit Ethernet controller (IGB), specifically targeting the 82576
> device. IGB is fully virtualized in QEMU, making it suitable for running
> VFIO selftests without specialized hardware.
> 
> v9: https://lore.kernel.org/kvm/20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com/
> 
> Version 10 adds an assert in the IGB driver to prevent DMA transfers
> smaller than 60 bytes, avoiding out-of-bounds DMA writes caused by
> hardware padding on short transfers, and squashes the recovery logic
> (previously Patch 5) into the main driver patch to keep the driver
> self-contained. Also add some logic from Alex to correct the ordering of
> Tx/Rx queue setup.
> 
> This series applies on top of linux-next, but the VFIO selftests don't
> build without this patch which fixes a compile error for the test
> fixture:
> https://lore.kernel.org/linux-kselftest/20260630213341.1664345-1-dmatlack@google.com/
> 
> Testing
> =======
> - VFIO selftests builds clean at every commit
> - vfio_pci_driver_test passes using IGB driver + QEMU. Use the following
>   command to run the tests:
> 
>   vng \
>   --run arch/x86/boot/bzImage \
>   --user root \
>   --disable-microvm \
>   --memory 32G \
>   --cpus 8 \
>   --qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
>   --qemu-opts="-device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on" \
>   --qemu-opts="-netdev user,id=net0 -device igb,netdev=net0,addr=09.0" \
>   --append "console=ttyS0 earlyprintk=ttyS0 intel_iommu=on iommu=pt" \
>   --exec "modprobe vfio-pci && \
>           ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 && \
>           ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing/selftests/vfio/vfio_pci_driver_test"
> --------
> Changelog:
> 
> v9 -> v10:
> - Add assert in IGB driver to prevent DMA transfers < 60 bytes (Ethernet
>   minimum payload size) to avoid memory corruption from hardware padding. (Sashiko)
> - Squash recovery logic into the main driver patch to make the driver self-contained. 
> - Set per-queue enable bits _after_ enabling global queue bits (Alex)

Applied to vfio next branch for v7.3.  Thanks,

Alex
