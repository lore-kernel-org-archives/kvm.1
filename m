Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC5299923
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629820; cv=pass; b=EsDUrCi2VvkyRDHT78yN2kqRYhv2wVTStfnfZwdpx8s+H2184xXiV/tBfi4ahAWD8Fx5mi3hkLRMKhoBgJ+gMJbMsTLepQ1yb9f8L9waC4Z6whhlaS1lBLKoxMGSGysZy6tNWzEkoF94WrLbrmFPcY7nmLgGkr9Oulw/+EukI0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629820; c=relaxed/simple;
	bh=iiYdG63QJ19HQIaUgO9plT5uCdf5kYDA5G+cQ6mO7Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS5Kle+TryJuVz04iu41RPD2tjET0p6pR0niQii7b7iFr4XoAdOBRA/PwN1tOBpXO0FAUoMzkuNWL51x/l6PS7SogP7JXsnHTcwXkbubFhrKmIFYHhLepb7M+SbnLoXKA0b7haOdm7KUqbok/5aXRgpLnsdA2tvLlk54BVD5gTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUSSiurP; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUSSiurP"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so679e87.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:43:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783629817; cv=none;
        d=google.com; s=arc-20260327;
        b=V2lHGyuGZtRKQny+3t7dmQU2KoIDOASI7PH4CdoJAOyYbE3eL/L768iaEB2/V5Q4m6
         4f8afEX/trel8xwN/FbFGVJ40CyN/l3DJQGlaotSFkgHVNVQQrWbzcr8pjuF6jyM3ET+
         y84KEuAYm3IwguLc4ZwxgF7cL2GnxQdGLArhnpKNs8AQDSravJDzeLGoMNmoRex9CEWn
         gL78CZ8th2acufR7WkX5fG6LWZULxLQcnB95WiT+VFobN4+2vpwCmOkoXkMSO0RlcZpx
         vqJym1iPl/0gB8dntr5j9uQ+JO0HMnJfZwvyK56z38dlk0xmy/3xbCnCyKhutmpwDwnr
         tYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oCKQy7ar3VkHULBVDK4MeVf44xoaKW3SejbQkM8f67M=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=QBlaSAhngWmlmQfnEcLWfukk31JC/d4s0S9SQCv8HaYX9u509qEjtp3gTGssmQ+G6z
         nV7bQtzLjuQC3pM7VelbvknFe1+yMlfQx2MS77gKM6tC7DPrTHE3junGLVqReVBrh8e9
         Sx4EqP2ztr/D7dqoWXqurzAKoVyo4ChPyukLU5ovJh2qA0B7tkeqIEGHS3H+Zi3GrmfK
         KlC4ZNx1HWBYC2DpUTkEkFeEFwLbdXYmEYBJQlNVaQYaQJlV26FGxfrX7cTk4FqStimq
         n+RRvjFDqCKww7PQnyJoyFhSJyY2GOvOiL5zYTp5s/3Bxjd2JCw4uvkJJC/0PNDP8cOI
         rwvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783629817; x=1784234617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oCKQy7ar3VkHULBVDK4MeVf44xoaKW3SejbQkM8f67M=;
        b=wUSSiurPs0BQT40SMKFrkag9a7hs9PtDR+TQ7fT5an4MthHInCeTdCshgw2/0noOqB
         JEzmzKKiXd/DqRF2ZksN+OxdWoulUyWlksDH5u2GVaBswpYyusWoJMMIn7LQy9QBL5y+
         rFNvopUj7Etv3GTP5xLhubq7ify1vN+OEQ6Ba3njdaLYqre9Uu80Nbzdr7srTu8mLwmn
         U4Vn+7XqheC3FwB5H3DVN2nS5a5Me/ahRL0OD8dZsxWzNdLzy2i+YoyYU0uSXL1ZqVUD
         u1h3o730gUli1Th6QhdzCVeJa7+xHNPytblq2yNo3tyXZs6ZhAndhcLnNCnxVbrRwtPE
         +sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629817; x=1784234617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCKQy7ar3VkHULBVDK4MeVf44xoaKW3SejbQkM8f67M=;
        b=c0Rih7mxBMco1mHR3F7RB9aHxc8r8Q32PmH6lIzoOfNFdmX5tabkimjp0E6/YFTSae
         ji+9Jn9oxV5yyxQtTR+N4Qd2dJuCKcq3WKJQSKreqX4eRwRqquWKgfFAIlSGHewVVrDy
         sC9vso+y8vwbGRmX6oQQYMvyhztQH2CqPX93tqfqEAeiHumTqey/gs31gUKwQw/qcf/A
         r8VGxOqlx9l4PEiOrTA4EY6cnQdOgW7sN357mmU9LKdps9lIHWZFWOa+Lx6zG3K7tz0f
         xDY12prltwp1VS8CwSeNtd6aIBR1e789bW+NiPZukCeoeBuhwEK1GtJpzlpka9j7J7it
         25wQ==
X-Gm-Message-State: AOJu0YyH7y19G30x09J1VfdZgpvoxzRb9At07oW7bu90aifOn7YTAdTX
	lmJV43dTg/mKgc5k3G8GWEdBf/P9CC7n1wYaBbF84KaDW+gXXbxak3as8y0bYswH3i1J0iGN5zM
	s/5Um3WiFeZ0iBT/oN5o+pIL+w5QmI8AUpQHTZ9s=
X-Gm-Gg: AfdE7ckkwDxJYZww6fU3jG1K55avsQyNNrwa+uOAUMVEuLvTmRZLoPnDBoZAztBXShu
	GyfzJsMq4V9rVD77AjbpV/tAJZ8v2kDFPac2xYdCFc32Ao5FtRV5yn0u5s6hdH8XXuiPP/bjIWN
	xImNWp+X111irf9KRuKZTLWgzOxl/X/nv9/WH81CrTgU/ol7tGzAbFeiiRBf2JHr9F7Wpgy5iEo
	aLJt+pNyguwYMbWWP2+h+jmTWNBkUYFKvjRpF4OgzIkDtGStwYfh1AAcgS2nT9VAx2l/JbR8/rc
	Poo=
X-Received: by 2002:a05:6512:3d03:b0:5ae:b0ee:f737 with SMTP id
 2adb3069b0e04-5b01cd4f47cmr8777e87.9.1783629816632; Thu, 09 Jul 2026 13:43:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-3-1272650ca614@google.com> <20260708232925.D2AE31F000E9@smtp.kernel.org>
In-Reply-To: <20260708232925.D2AE31F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 9 Jul 2026 13:43:24 -0700
X-Gm-Features: AUfX_myJvnDtxDlB3D6ADaOhePgyrRxAKJgPJquTRxogEv4Aj7fK_j9f_7Uc_A4
Message-ID: <CAAdrzjvUcSZqq4y5dvCihFv2K-jQ27g=A3wuO83PVjSAPG1jzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX descriptors
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:29=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Programming `SRRCTL` with `E1000_SRRCTL_DESCTYPE_ADV_ONEBUF` o=
verwrites the register, clearing the `BSIZEPACKET` (Receive Buffer Size) fi=
eld to 0, which violates the 82576 datasheet.
> - [Medium] The commit message incorrectly claims to add new header macros=
 and remove legacy CMD macros, but the patch contains no such header modifi=
cations.
> --
>
> --- Patch [3]: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and R=
X descriptors ---
> commit 44f58d3e0349aa95894e8741ae9ff09ee319dcae
> Author: Alex Williamson <alex.williamson@nvidia.com>
>
> vfio: selftests: igb: Use advanced TX and RX descriptors
>
> The submitted driver builds a partial legacy TX descriptor (just
> DTALEN | CMD_EOP) and never programs SRRCTL.DESCTYPE.  QEMU's emulated
> igb tolerates this by treating descriptors as advanced regardless of
> DESCTYPE, but real 82576 hardware does not.
>
> [ ... ]
>
> >     Remove the legacy CMD macros (IGB_TXD_CMD_EOP, IGB_TXD_CMD_IFCS,
> >     IGB_TXD_CMD_RS, IGB_TXD_CMD_SHIFT, IGB_TXD_CMD_LEGACY_FORMAT) that
> >     become unused, and add the SRRCTL register offset, DESCTYPE encodin=
g,
> >     and advanced TX descriptor field macros.
>
> [Severity: Medium]
> Does the patch actually include these macro changes?
>
> The commit message claims to remove legacy CMD macros and add new ones, b=
ut
> there are no header modifications in the diff.

I'll update the commit message. I removed those macros from the series
when I added the real IGB headers to the first patch of this version.

>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index 58c6aceea63a9..f4f6d2ee262da 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -235,6 +235,17 @@ static void igb_init(struct vfio_pci_device *devic=
e)
> >       igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx=
_desc));
> >       igb_write32(igb, E1000_RDH(0), 0);
> >       igb_write32(igb, E1000_RDT(0), 0);
> > +
> > +     /*
> > +      * Select the advanced one-buffer descriptor format.  Per 82576
> > +      * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to =
a
> > +      * value other than 000b for the 82576 to write back the special
> > +      * descriptors."  struct igb_rx_desc matches the advanced one-buf=
fer
> > +      * writeback layout (section 7.1.5.2), so polling rx.wb.status_er=
ror
> > +      * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25=
].
> > +      */
> > +     igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBU=
F);
>
> [Severity: Medium]
> Will this overwrite the SRRCTL register and clear the BSIZEPACKET field t=
o 0?
>
> By clearing BSIZEPACKET (bits 6:0 of SRRCTL), real 82576 hardware may see=
 a
> 0-byte receive buffer and truncate or drop received packets, causing the =
test
> to fail on hardware.

Alex already addressed this here:
https://lore.kernel.org/kvm/20260529142439.5bd03e5f@nvidia.com/


>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b=
4-v3-0-1272650ca614@google.com?part=3D3
