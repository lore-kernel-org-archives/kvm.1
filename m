Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792812384;
	b=OAiP9FizGxqC6ryR9ciXyOuhkSG0EVK/KqNpbgvkwAcmA+6KlB7Ym6cs9eVCd0baE3Hw
	 a/kEgK/ua4ESORlttN08cF2KVv2yNiNNb3zL8IUIb/h8TnhtGDmZM70sWWUr6/z3ZQve1
	 by3gb+UHIb1bUekccCuUjyAIA2KhU4V4U9M1tT2A/e+oHvuHQonW2LTtCQwv86iu8HqYn
	 zziUidaE/D7yaRtAJJd6LyTNsOGlLwmx0GLHVxGcDlQYQNb8QlRn5pxbYMOCKkBK08nRE
	 WRJwzNCgz1Qzr2mr2lI41l9tIRL9pMpz4/YJBkRPEa5xjNqLGF5/yBhbmvYx9DCJ5+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
	b=d/jRGUIedi1c5NTkSY+qdpkK+rn5POh+uMm0ryztEgWtMnf70G2GotitpEYTX4W/Thhe
	 pb0yeT91AYsSBg1qILWfGvhjgiflEj4Jn7iBUOFFK3lXYW6TjTBjQzUbVQZ4l9jaz/ZaX
	 KBgyibVZdJ/jcv+kYjVsXXY+GWNrYYH3t6Ec64MT8l0p1Qyf3Kc14R0Qyle6TmQwY9LJB
	 uVdmjCOKP2+OmWG37lvERSKI0jGNej9DcBfW/MdgWKPsohNeltD+rv74m1WwD9ae1Ej5N
	 TKjVVl/7aZSxvZVYEebvDkD8NNlAWB6Uw2QvXsIv6ThlvAsi15a13ZkYaHy5JByvVtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JPkEfqc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4B606A31D
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 03:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B4B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JPkEfqc3
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53512cd2f85so15662501cf.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 20:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792812383; cv=none;
        d=google.com; s=arc-20260327;
        b=EZPeSjBcGJhXAjASGgmuNKdIAWvY68TJtH6KNNu+bKsW30Pce/UL9tzwOAMfBzUMVo
         JtG3c3lMCTuISG7z3d+RakrbeCWy0+E/F6fy594vGdpnNjhAU7Hzm5sBvARE7glEfukh
         thrZoV1rObfdFxmcdVWIozdBAZ7vp5AGHmN4SRMhQNZgLzZXDd/AXZN4rLsquzx22E4d
         E0x6Dzd5Tgs9uLNf6Y4KJ1y2tb6cUqxWdqfKrZlkbZ8E0/683bDpiNw5WH9MGaLipGSB
         +/0KN1tlJtn8Reffj1/IZRle9bzAlf1ueyrm51LuRtqjMynIykHhW/vBJhdHiIDakqkS
         sfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        fh=KSwtYyo89I8gRBn0/jcGvryxCKyTduTyOGgjfcAJHCk=;
        b=WXjgbHcfuzStFng9b4c3ADqVx5Y94hjkGgzHJm0t/+AFjPy9pC7Pf6sbUnhoz4ctW/
         G9WX++tnnbwkXOjUC7pbYQ7Kv5JlAlL+hvyF9J+NXyXqmPP/ukJXC6hEedOQBBqnOSb6
         vMiwovKNqzdxI3cExTHlxcl+e69iowEJNfrDS+ubewchOYbfcbmFr07aGJc8090rXkW6
         VUvOANz60zuU2KAfVvvHIoLHEfc9xazZX3q/7gGQmE4UQ3LUOHXzMGhekNBie51dwQzH
         Whw2bGgQavUACeexja4ENBExawE6qHkfqNAbiiPLXEeEbcdyn76DeAdwYmcq2i2b15J7
         ThpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812383; x=1793417183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        b=JPkEfqc38rmVYfBrogvq0HcazTissN0pHHCPFvXuEHZAFWWFfqeXm++eSjOmi06YDL
         SJcUq8tZjdWdtztCDSE4OnOhc7+JupfiOahyimATsNI2DfpxgRDl5VikOe1KqEa2bxRb
         x1Rag0wSOPQT489sGmvn7vOkDJuwKRhf+nSYqDBb5NDmOkXbbnhTvioy1WS843k1+m+c
         xKeJxq8dwAHDkVgGayc+kNBX3ADw63+op6lwCt6enK2g45SEnzjzijeu+PztTXcvcSlW
         W2dxvy2YcGbWnjqU8E64E6zMvOffo43W9UpFDUpygE8FkeyCWGKHL2+ICOJZuwYBlmkv
         Mu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812383; x=1793417183;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FicJIZs2+/qCTDE+0FRHSg6kJmTqD7XGGr4iZ+o1ZRU=;
        b=g4+RSGMSgPJF5AdjvjDYSAL5kPFirsuDNCi9lzpRMX8hFZzingK7v4Y9MbfHqluIRh
         OcXJYFoo3Rqd+te2Q+dX45dgN67PMhjxh6UsmvCR2u/HfgqiLE/3xpYSvsRNxv4ckSaf
         KBOmy0ZU+DmVXm6+0SVh5PJesnI9b6uj3KYWrBWQd+Aa7ki1xfAvUuFQLdxJFp1B8kyw
         6V3rcvfzEqn1h6XDEr5rBCq5TbIzpzf4FavQs6Y+HUdgKr/TKTgiPFkxb+o5eMcfbOMR
         8/ZpiH2jyZ6Z/46e/yuswKaMmHJ45WnGQezBuaovaSUcReaVuuviWzY06NuWWDdTdCRo
         UXCw==
X-Forwarded-Encrypted: i=1; AKwUvBx1x2wq9X2ypa54W9Rc706UnZCQEQdpcDdH0IVMUlmiw44JtVzeuSLPW4ULqIsGPcmvFDk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1Tlk2N3KUS/REVEYxBBUxL9rCfb2B9YMuVLX03NEIwo/AmeaC
	NRzRrOrXelUhRMwUyLTUVm7J2HWfTuJMDzd5UJEY+jmr2WQmYpwMi/tMHwAKzksKOzMouk/tayf
	1TzeilgnjCINzQE8/krnwlOn4J7zlB5U=
X-Gm-Gg: AYBFou2310xJmqIUO4RQQlWV3LeySCmydkce4dn1hycz4yxTlKgno7h5AaHSiR0Ml6X
	pdWbfnJK9LQbJGw7XIEIExqmQkJfnuKjhpdqvIipVoIfSrWQ/NPvuIJZmnpB5pzfk9hz00m/1Y7
	L/mgV/lAbSDDD9vITEJ4kaD4cSLZbMYApMqbo1l0g136EQsljZmvkoegsalUl9N1rcfgMPc3Zee
	DtxtpW8rnQp/Y1K3uQjEemRVfovtZ2UjlksJOdFR3ZNkqqezPT+0kP2dJ82g6MiZPYH6FVTbhbg
	lf37gJPDdGZ57XHBDvrchxvaYy+03rkLzZZt8acFlWTpGCnwLRS/bPAmzayZ3FuXp0kHfpA8F+j
	RtxamQ6f2l3Isb6vQU3NYu5/xX/3ALKrU5JYWnWYrZ94/7hsuH1NVYNccaSULGP6hELHyEWWg/c
	SXs1HQnaiqz3kGwB3bXvU=
X-Received: by 2002:ac8:5f93:0:b0:535:11e7:fdb3 with SMTP id
 d75a77b69052e-5383b4fd48cmr11061231cf.34.1792812382943; Fri, 23 Oct 2026
 20:26:22 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018201727.96924-1-williamwoodstock79@gmail.com> <20261019141053.7b2d8e23@nvidia.com>
In-Reply-To: <20261019141053.7b2d8e23@nvidia.com>
From: William Woodstock <williamwoodstock79@gmail.com>
Date: Fri, 23 Oct 2026 20:26:12 -0700
X-Gm-Features: AclHuK-yfT4LvkJ-ln5yWRznOXG4xObhTaFvAUkqkJ-ddhw8muvQiG6pyIjtX5o
Message-ID: <CAC_eNMPu=3Tez6L0jO2f-OkRWPL9-ub8BS+7uftcRqSGKbCFQA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
To: Alex Williamson <alwilliamson@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending because html was rejected, and I also tried kernel 7.3, with
no success.

> What's your RTX 5080 vBIOS version and system information?  Is it the
> same Asus X870E as the other 5090 reports or something else?

vBIOS: 98.03.3b.c0.0b
Card:  Zotac GeForce RTX 5080 (10de:2c02, subsystem 19da:1765),
       primary PCIEX16 slot, bifurcation Auto
Board: Gigabyte X870E Aorus Master, BIOS F14d (not the Asus board)
CPU:   AMD Ryzen 9 9950X3D2, GPU on root port 00:01.1 [1022:14db]
Host:  Proxmox VE, kernel 7.0.14-20-pve; guest Windows 11 Pro,
       GPU passed through with vfio-pci

It reproduces without a VM. On the host, with the link at 32GT/s x16:

  echo 1 > /sys/bus/pci/devices/0000:00:01.1/reset_subordinate

brings it back at x8. A bwctrl retrain restores the speed but not the
width; only a cold boot gets x16 back.

> Is the issue still present on kernel v7.3?

Yes. I built v7.3 from kernel.org with no patches, using the Proxmox
7.0.14-20-pve config (make olddefconfig, LOCALVERSION=3D-stock), and ran
the same host-only test with no VM running:

  uname -r: 7.3.0-stock

  before: 01:00.0 LnkSta: Speed 2.5GT/s (downgraded), Width x16
  after:  01:00.0 LnkSta: Speed 32GT/s, Width x8 (downgraded)

  [  211.617016] vfio-pci 0000:01:00.0: resetting
  [  211.617225] vfio-pci 0000:01:00.1: resetting
  [  212.898377] vfio-pci 0000:01:00.0: not ready 1023ms after bus
reset; waiting
  [  279.586064] vfio-pci 0000:01:00.0: not ready 65535ms after bus
reset; giving up
  [  279.587022] vfio-pci 0000:01:00.0: reset done
  [  279.589284] vfio-pci 0000:01:00.1: reset done

The 65 s "not ready" wait didn't happen on 7.0.14, where the reset
finished in about a second. On this run the guest had been
force-stopped just before the reset, so that may explain it rather
than 7.3. The x8 result is the same either way.

> Disabling bus reset entirely should be a last resort, it has
> implications for device isolation when no other reset mechanism exists.

Understood. What I measured:

- 01:00.0 (GPU) reports reset_method "flr bus"; 01:00.1 (HDA) none.
- With only .0 assigned, FLR is used and the link stays x16.
- With .1 assigned too, vfio falls back to a bus reset and the link
  drops to x8.

So the bus reset is only reached because the audio function has no
reset of its own. Would you rather see a quirk that gives the HDA
function a usable reset, or keep the bus reset and restore the link
width afterwards? Happy to test either.
Thanks,
mark-ship-it


On Mon, Oct 19, 2026 at 1:11=E2=80=AFPM Alex Williamson <alwilliamson@nvidi=
a.com> wrote:
>
> On Sun, 18 Oct 2026 13:17:27 -0700
> mark-ship-it <williamwoodstock79@gmail.com> wrote:
>
> > NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
> > 5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
> > Secondary Bus Reset the link comes back at x8 and stays there until the
> > next cold boot.
> >
> > The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset meth=
od,
> > so when both functions are assigned to a VM, vfio-pci falls back to a b=
us
> > reset at VM start and again at release, and the GPU then runs at half
> > width. Assigning only function 0 avoids the bus reset because the GPU
> > itself supports FLR, which is why the problem is usually reported as
> > "passing the audio function breaks x16".
> >
> > Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
> > 7.0.14, Proxmox VE host with a Windows 11 Pro guest:
> >
> >   boot:                         LnkSta: Speed 32GT/s, Width x16
> >   echo 1 > /sys/bus/pci/devices/<root port>/reset_subordinate
> >                                 LnkSta: Speed 32GT/s, Width x8 (downgra=
ded)
> >
> > No VM is involved in that reproduction. Stepping the link speed through
> > bwctrl (Gen5 -> Gen4 -> Gen5) retrains the link and the speed follows,
> > but the width stays at x8. With a VM started frozen (-S), the link is
> > already at x8 before any guest code has run, so the guest driver is not
> > involved.
> >
> > With this patch applied, reset_method for the GPU is "flr" only, both
> > functions can be assigned, and the link stays at x16 Gen5 across VM
> > start, shutdown and restart, with the Windows guest driver working.
> >
> > The same symptom has been reported with an RTX 5090 (10de:2b85) on an
> > AMD X870E board, where passing only function 0 was the only thing that
> > kept x16.
> >
> > Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-=
bug-with-rtx-5090-vfio-passthrough.178461/
> >
> > Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>
> > ---
> >  drivers/pci/quirks.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 1aa87a3ef..a4adcc3e7 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3769,10 +3769,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, =
0x22D0, quirk_no_bus_reset);
> >  /*
> >   * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
> >   * prevented for those affected devices.
> > + *
> > + * GB202 (0x2b80-0x2bbf) and GB203 (0x2c00-0x2c7f) GPUs train at x16 a=
t
> > + * boot, but after a Secondary Bus Reset the link comes back at x8 and
> > + * stays there until the next cold boot; a link retrain restores the s=
peed
> > + * but not the width.  Function Level Reset does not have this problem=
.
> >   */
> >  static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
> >  {
> > -     if ((dev->device & 0xffc0) =3D=3D 0x2340)
> > +     if ((dev->device & 0xffc0) =3D=3D 0x2340 ||
> > +         (dev->device & 0xffc0) =3D=3D 0x2b80 ||
> > +         (dev->device & 0xff80) =3D=3D 0x2c00)
> >               quirk_no_bus_reset(dev);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>
> What's your RTX 5080 vBIOS version and system information?  Is it the
> same Asus X870E as the other 5090 reports or something else?
>
> Is the issue still present on kernel v7.3?
>
> Disabling bus reset entirely should be a last resort, it has
> implications for device isolation when no other reset mechanism exists.
> Thanks,
>
> Alex
