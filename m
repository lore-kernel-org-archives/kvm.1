Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792950743;
	b=arLxliLGuTTovEhlaJeXlylROpX37acSHwkTYuinVA83P5+AkjAHAsp28UlZ9tDkwOJ+
	 KvgyVTirVu/pf8PbyRIqVYkYs4WMSg51Q23Nxf1NaWuwGJbiri8XkpENSU8OEv6A/oHiR
	 On+8Jv05Az9Pe2JGNrMRAC1KUKlyoAcUsXMxvESfVYg2j3Sayt2Pr/VB5ZDdSvtm+KYsd
	 F2vupjjNCJxNLO3nDsoVrLwCUoo4nblVFbd9i34WPGNRSCp8LNIeGFBRJwzP4QXcnTUyg
	 YJnSpWl4+KJzlCy51ecwYL4GDbH7hjJSlPSKJg0CTfu/iHZRkidLNzXcYC9kEEnZ4ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
	b=QREU+PIAEbTB6jNu++UZq+wv+IAl6xZ3k3XuTGW56Yq76Y+vrlWojOaLjRdhBmP+kGNz
	 n0umiXIQsYVJHEJn/12447mgZscFx68nJFv1cjzsgoTT2s+9PHFaxJBQaphKbWZ+Do/D8
	 uBomtJZO6KQn6xRr+kfYg7+rVxe7Mhl4NBsROz9wUhQQTQhfjg+OyW9AdfxqQXjpwszy8
	 GbYsouPV6rlPw21OCUVQKrESmq5ov1p0InExMjXqJ40IB3OXUd0bNqktIrncDLL98HwyM
	 GFESmbNKtYkQUrNefDOepJjC+PDL88lIJlaWUjJ3n9wQaauwstzRurzJ1hQBM9LsrEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FC6HUzYm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B7606A31D
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 17:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FC6HUzYm
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4550d8ab15so288799566b.2
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 10:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792950741; cv=none;
        d=google.com; s=arc-20260327;
        b=qbAh8Xw456IMVzxK7QPfWHf97BGiFEUEvikk7XV/WyqXDPxwtpiF9ecBw47ZbrgYS1
         tgTb5FZOAfMM5qsHckkxK4KiArL0mSSraHtHoRZRgaw4FPLjRMMKswpudqTXtZi7uzPy
         6UPZC2wm3JHjvAnnhAsAd0stmnOIIGuHjTWgBCXudtlLOS5a+BWx8ct+gGFqwWBf0yVt
         GroCvnATYtJBgVT0+CHHh6t8nLCBNcFTO+5O9jZBCMYAmoVEI3ZJVrMMgtfFSWPKc451
         CFdV0PAN2RAvVaDtpNSBMCXpwT+ePTQwUsgftFZAhifIymdly4yCkDaUFjDzoi+QSTNe
         R6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        fh=oxJ6IYdo/uDdO7mcLQaNtaKk7mlri/YOvNlciSElX7E=;
        b=T0fgM2HyxoWjpGoAKJqWhQEjsmhjtbrASjqcmvsV95Z8IV7b/MR1hs3ryMPi/0I5rI
         teBfbDgHPofeYvbI7uzyMbz9qKW1Y46rNISVnSFjfebvwrbq4tIEKP2NPQmKt6soMcdz
         LjQ7jRDbZqmGTOTFarQBgUWTohuNrELDBouRBvZ4dzw5Md/D7hD3yQw/ZSGBRJbGm/WC
         Vm1P0eOeYJecIaSI+4VfmiZKnFWBvFJaVOavH/X6NjT0WHAUSJtd3vYvMLW1bX3C0ITT
         MHDv6fE6HAbO2gKOLlFb3ZDhJbnAzUVGHnPRy0yfQuPBUxUldUm61xNn1zx/rQmjmHJQ
         lp6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792950741; x=1793555541; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        b=FC6HUzYmMNQxSMmCXmfY45ZCuO/QTfl4IX7GWuzE+msxmYINvXAo6QHDZeyEiSHCJX
         L2PHiLT28UoHFEosGOk9U4m+39P4IKoyBS5McHyEcRkFC+3hV4BsXrEjmRk7DEzawapX
         VSuY0cUGX3gBsgSAdNjNzyMKf9fOPNMzn6Z1c8jMvlxdAYMTMExd+UI9ZLeGnH8PqUCN
         y4Y0RridFPMkvhRla0ZTxu+O9HQD9fK08Jnf1N/UtW43eyx8wBe6CqhXP3sXSjmGFf1h
         yw4V1AcDslf+F5ZpJPBH3UAUlMPpHHKQdgRYj/P2dc/YlzRLEd20N4BbEpmhYC9iahwA
         TbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950741; x=1793555541;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        b=CYGeLdMwo4RGzjBOVSkHh8JXlR2+3AOkau95XPJpuqaP5l2gXGUlqYUSjPmyIEeirb
         RxiHDEDYGPjNPf/VIpqE5JpALByXO7LOIzN57m/LkXh1Rvvnu9brl07k3jxxxIQ0pass
         DSe4vbnLGdllRO2V1MBv/aObDuLcWVq65vVtlqAuC7nSJ+ZPyM81McsekNnxLFWiJXWt
         i8ioe3fdxr0jRHCfAVYq5onrCvP+8QihJMgC8sCJyCtmzZIbpLOVRtK99zLXy+HQ2Uwv
         YVmOzccbuQxMnWM2DWHPW71xriCFOBcRWOQ8SgKhQbW914BJzL2LPOc46sxWrnGgb2fv
         kgBA==
X-Forwarded-Encrypted: i=1; AKwUvBywxKnrEvY3K1jmDSnFW6PkL1F/OCJRfS+6pXXorbqMYU48kPlwaMiPpQQfINvy6ZmLFhw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6+q92Q4WqcIRNfNVGC86k5zt0maXQpRV9qK5klhRTW6VGLa3q
	77OKF5eutuaDS/yyDMCrTBf2/PJMCq73FgWazK7BfaqZ9IRHBtcXodKQO4BkR7kxoTvdoh69fyU
	29Hr6U3VPASS46dJ5Avu1ybAqs8Aeu78=
X-Gm-Gg: AYBFou1vRN27jtrTgbUHypeJvShChJ0c9fxiZQiR5XiSuLEw4BMho0l4teECOVRI89x
	w3tJ0QaxxZw0ybkUM1UJIY8b6peOaKkPXxOkAZUHg2tX1rZvIhFQpExzbqvFmQjONGP/KE+t3Qr
	x+uQ9sKrOcfB5+AaMaTy7bVHkJhkFDFbeovq9Zy1oBfgpB5Iuo74FAGH1gxCWxK1DXjD3ttT/P5
	H/DRVxUAr5m3aWDsuud5B9JW9uUNV9sMaONVC4D3tIKv7a8leFBZntroPADGdxKdX8DI43Yp2hE
	oBdD3ziMxgY0RaxBrx2Qr9nesIMKjf2Ac4eMgFP2v+fRsJ6/rfoCZmdpgmhtyLKc2OrDce34R5D
	qWFYpgDlLx748uhpR6/4dM+xCzd8bbu2NTczlmmk22QD7BwaFvOcj5dDknpvVOGh8gO+OrxpY6l
	szjQb3ILCVoxCIVrvDa/NMCg79rvqBQShnEx+Ys74VXjkpegVW0kE=
X-Received: by 2002:a17:907:9711:b0:c46:7b82:27b4 with SMTP id
 a640c23a62f3a-c46bddc9600mr600371766b.19.1792950740660; Sun, 25 Oct 2026
 10:52:20 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>
 <at41Hdy8ATMj9LRC@wunner.de>
In-Reply-To: <at41Hdy8ATMj9LRC@wunner.de>
From: Patryk Janik <patrykjanik1710@gmail.com>
Date: Sun, 25 Oct 2026 18:52:09 +0100
X-Gm-Features: AclHuK88Z2QavAmx4mSXDSBISgT_e3iYcuZ7GDfDRBk8SUdPo9i421telRTgTEI
Message-ID: <CAOz=NNVW9khnnt40Bm_ddiNeZ+4Jr6pEPjSLb5Ezq0gAi6Y7uA@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: Don't restore state of a device whose config
 space is inaccessible
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, alex@shazbot.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 25, 2026 at 05:58PM +0100, Lukas Wunner wrote:
> Config Space Writes are Posted Requests. There are no Completions
> sent in return and consequently no Completion Timeout is observed.
> So the above paragraph doesn't really make sense.

You're right that the writes aren't where the time goes; the
paragraph is worded badly. (Strictly, Configuration Writes are
Non-Posted on the link and do get a Completion, but with ECAM the CPU
doesn't wait for it, so they don't stall either way.)

What stalls are the config *reads*. The trace is in pci_mmcfg_read()
with RCX = R13 = 0xffc: when every header reads ~0,
PCI_EXT_CAP_NEXT(0xffffffff) is 0xffc, and
pci_find_next_ext_capability() re-reads that offset until its ttl of
480 expires. pci_restore_state() does about ten such walks, so a
single restore issues several thousand config reads to a device that
no longer answers, each one stalling until the Root Port's Completion
Timeout. On this host that was ~56 minutes in pci_restore_state()
(and another ~33 minutes in the subsequent save for the bus reset).

I'll fix the commit message in a v2.

> The outcome was that there's a firmware fix available and a quirk
> should at least differentiate between good and bad firmware.
> Or the fix is to update the firmware and then we don't need a quirk.

Agreed on the FLR failure itself, which I'm pursuing with NVIDIA
separately (for this SKU, 10de:2bb4, no newer VBIOS is published yet).

This patch is not a quirk, though, and not NVIDIA-specific: it doesn't
touch the reset, it only makes pci_restore_state() bail out on a
device whose config space reads ~0, the same way pci_save_state() and
pcie_flr() already do via pci_dev_config_accessible(). Whatever
firmware the device runs, once it has fallen off after a failed reset
the kernel shouldn't spend an hour in soft lockups restoring state
into it. The same applies to any device that dies during reset.

I left dev->state_saved untouched on the early return so a later
restore can still apply the saved state if the device comes back.

Thanks,
Patryk Janik


On Sun, 25 Oct 2026 at 17:58, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Oct 25, 2026 at 05:37:39PM +0100, Patryk Janik wrote:
> > After a failed reset, vfio_pci_core_disable() unconditionally calls
> > pci_restore_state(). When the device did not come back (FLR timed out,
> > config reads return ~0), restoring state walks the extended capability
> > list and rewrites the whole config space. Every one of those accesses
> > stalls for a completion timeout, so the host spends minutes in soft
> > lockups instead of failing fast.
>
> Config Space Writes are Posted Requests.  There are no Completions
> sent in return and consequently no Completion Timeout is observed.
> So the above paragraph doesn't really make sense.
>
> > - "PCI: Avoid FLR for NVIDIA 5090 GPU" (linux-pci, 2026-04-16), where the
> >   underlying FLR failure was described as a known device firmware defect.
>
> I assume you're referring to:
>
> https://lore.kernel.org/r/20260416070707.3242381-1-yuan.gao@ucloud.cn/
>
> The outcome was that there's a firmware fix available and a quirk
> should at least differentiate between good and bad firmware.
> Or the fix is to update the firmware and then we don't need a quirk.
>
> Thanks,
>
> Lukas
