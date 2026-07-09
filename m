Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3B3D16EF
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629862; cv=pass; b=MgV2/tDnBQfyQZg7gO9FBrnt+4/5iGS5X3bwWenR31mRJNhpdVddH1GgCbi8o28j76c3LeZ4s+5P0BexeCcTfshk9qXVX62xuOhJnrLYAfdzfl4tXH+7QYSgFKdgqMB3H6OTrsuGMBMPXXb4fWBxIcnykIQl2dhkTkytnqTOPSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629862; c=relaxed/simple;
	bh=YQYkZTA/hC42ziJpmTdONXxoZwGTPZtprA9i04fY5G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOvVDIxxSzJ4YYMDvqQNZzfXL6ltQAvaUvDNzyVjp6t40uMTwggTflpUyQXKGke6B/lKI3nl9obKioM0WVGdDsSj+Lfl8S7fIh1VIFDt5QaQyKWu9uUrMQ+e/aSmLxfk9AuAt1ErZsguCVkIJBaPft9KRJA1K5Ajx9jPnY4Ya4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBPLLj4s; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBPLLj4s"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b0077d7053so841e87.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783629859; cv=none;
        d=google.com; s=arc-20260327;
        b=RkPsWdig21y+OUazsFN6qvLCrw2t9DBFAfhYlbbkO8KK1RD36U++9Qknu0SI8d6OHI
         qxDIklxHitYxv+xj3lvLDk0vaJefIkttaqdI+sNFupRWsv8eJI4T3vRrl+A2WakdreQo
         6qJN3qlJv2Vajdcg6nkaGT2WYoOWIgahM8RvDiFYN+rWOSSTm+4u05LLg9rFit+RotbT
         He5mTYecYki9S8RPepRPpQpwXgdyOZNf/hqay76JcpMLm0I2U/11jcytayVtMA5chz8r
         FUyCMozgtunbvg7oIqoRYjcF+vuTfEaJZuwZfQ2PeKv2EpH65VMFAXQsqZ4mZj314Ls+
         vehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sz/TS3U0255GtOYfFG18AkoFtfEgSpwa44l7VVdAJ14=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=T3Ggvc38nkuafPTiJMc9uevAMdABvXPHoizFCkyNERFRInV0wjtaYahF86iOaaWB/e
         NzX773H3zr0C7MTYfJy6qYSsw2GYaYvsBRfkR62kxxAA8NYqQ6a/cQf/mHyMAUwVkf4q
         tJPafHwMPNrgG6jpDcPiX54n1UosBSd2gjr/dGfQTmdYHmW3q4AuVXYbdGiBv+Rg0jqK
         M3kVauBKxRTXQ1rSikayTwEbHn/qY5lqtQdUo9Kf7qXB1Y9aWHqKLffgopC1nhje6upG
         Lv4sAa99cKiBQU8wE2ZGtXF9rY6TT9vmIwoo35aAcxrlOUnqokGYmWAHXs9RJy2Z67O7
         Rr8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783629859; x=1784234659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sz/TS3U0255GtOYfFG18AkoFtfEgSpwa44l7VVdAJ14=;
        b=oBPLLj4s6YJOLjJqxRGdyjsP6fq/0cW8C15s0BZfozrn9TWTvoMZ3CTKsm3TyBljOv
         ZxVY/oyjrhLVP1tpLix0tsaVXFBzK+1f2QBLVW2mrhvlBuH31N7uptFFk1ZGNzZ/Hx20
         upHcwrvmZAr0EWH1RUk7Qg2yPTEKVeqLj4tjjFZYOPeMBF3LJuccZBmV9oLR5CbwK9LO
         ITJDBwOhmM5JKUoYWCY1sDR7v8FatpATGgXBW/aFf7gUYcLRwa7/dbg2kVLYFK/SvVDZ
         Bl3Z+jZPwYHF80GXLxb2s8JOXGpInVjVw0MW9sdnOiGXzw3r1nHZxvUA6xFayNTFprKA
         2QJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629859; x=1784234659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz/TS3U0255GtOYfFG18AkoFtfEgSpwa44l7VVdAJ14=;
        b=hMm1mhRXkfBd1xrq339ozLmNs9CqJhJgTGgzZlLKqjxBstXgtmSdVvnii+EaX3zJwr
         4/w+GTaplshqqOEN1hGr1ZBvjVPO+rcd9wboLASCQHMNiGu65MMh0t43lWyGY8hV21lY
         hhDsz/x8JfSYOHEIkAZ02/kBpG0k0Fhua6puqZcl0+TkYCIWzDDf34Fu2x/I/l70d1HJ
         kqNsNtQmKlP9OassrZ0kgOhCvjKA4t3zERcdQQP7jyhIivGJMk40klEllGKdGsDZcQHX
         cT0uh61R5BEkVNXtVxh2yZ0EWpEKAF0JOKK7tY3ROGLkoGS+Ih5H755LZMClCiPfFW15
         UzjA==
X-Gm-Message-State: AOJu0YyFDYhFyfpHcATPDeLzocUwXQuLchTsvjH2wTClAfIxBBUuXKcR
	Rqazih/x70cFR7Hug2D463wLZcpQ4MXxHIUaCw4ra8Y63VOfhZPlLmmmeDICYxdkTB2Fp1FZERz
	SMb28uLIMBkyeiWMGNwd5cAJ7LITkJ7g9hbeH1vWB89J/E/nb62zzafU=
X-Gm-Gg: AfdE7cl3+BdjWxXJU1ChaUQP1FyuZEH2dhhTe7I9qL+kqfM/RFi2amycvz6a4KjbCsm
	PY7mSSkY1We8ZQe2vWNIGr3t5oF9NEDoBSpzqD0FXSB2SfkQdKhaYBTqOA8BG4Ky/QiM02xHIM5
	mEo5/2h18MMnNpOiGqYwn+WNXxsSR4vz+uiLE4Oh6tD5jNEI307IroHxeYUmZ7Nb9VivDWwjCzC
	RKlIat5/uM2w/ws4Npp6UrsnwAOk9bKE36P0dxQ26LLNfGDZIbiJ4JwIcQOmduruZZe
X-Received: by 2002:a05:6512:3d9f:b0:5ae:b99d:7df8 with SMTP id
 2adb3069b0e04-5b01cd4df96mr12690e87.9.1783629858661; Thu, 09 Jul 2026
 13:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-4-1272650ca614@google.com> <20260708233341.5238F1F000E9@smtp.kernel.org>
In-Reply-To: <20260708233341.5238F1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 9 Jul 2026 13:44:06 -0700
X-Gm-Features: AUfX_mzAwjHYVaNENrwJ4wPekK1dOTjvFtVMgeRzOwmUMSIvNXAKtENbgJmqdQc
Message-ID: <CAAdrzjuKchGGhVtwZZ8dn_4M=LrtTQQKpVo1_JPo0YBbF8eq9w@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt routing
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Commit message and implementation mismatch regarding macro def=
initions.
> - [Medium] Hardware Initialization Order: Unmasking interrupts before rou=
ting is configured.
> --
>
> --- Patch [4]: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interru=
pt routing ---
> commit f99b27fd1b6bc3801803a7e5be3ec664facafb7a
> Author: Alex Williamson <alex.williamson@nvidia.com>
> Subject: vfio: selftests: igb: Program MSI-X interrupt routing
>
> This commit updates the IGB selftest driver to use the full MSI-X program=
ming
> sequence required by the 82576 hardware instead of relying on synchronous
> QEMU workarounds. It configures auto-clear and auto-mask for vector 0 and
> changes the EICR clear mechanism from read-to-clear to write-to-clear.
>
> > Replace the magic '1' values written to EIMS/EIMC with IGB_EICR_VEC0,
> > add the GPIE/EIAC/EIAM macros, and drop the wrong-valued IGB_GPIE_EIAME
> > macro (the new definition lives next to IGB_GPIE_MULTIPLE_MSIX).
>
> [Severity: Medium]
> This isn't a bug in the code, but the commit message mentions introducing
> custom macros like IGB_EICR_VEC0 and dropping IGB_GPIE_EIAME.
>
> However, the implementation uses standard kernel definitions such as
> E1000_EICR_RX_QUEUE0 and E1000_GPIE_MSIX_MODE.
>
> Could the commit message be updated to match the actual code?

I'll update it in v4.

> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
>
> [ ... ]
>
> > @@ -280,11 +280,32 @@ static void igb_init(struct vfio_pci_device *devi=
ce)
> >       /* Enable MSI-X with 1 vector for the test */
> >       vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> >
> > -     /* Enable auto-masking of interrupts to avoid storms without a re=
al ISR */
> > -     igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
> > +     /*
> > +      * Program MSI-X interrupt routing per 82576 datasheet:
> > +      *
> > +      * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4)=
 to
> > +      * route interrupt causes through IVAR mapping, and EIAME (bit 30=
)
> > +      * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> > +      * applies on EICR read/write).
> > +      *
> > +      * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> > +      * Without auto-clear the cause stays set after delivery and the
> > +      * test can see spurious interrupts on the next memcpy batch.
> > +      *
> > +      * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> > +      * MSI-X assertion (effective because EIAME is set), so a single
> > +      * interrupt is delivered per memcpy batch even if the cause
> > +      * re-asserts before software re-enables the mask.
> > +      *
> > +      * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> > +      * cause 0 to MSI-X vector 0 and mark the entry valid.
> > +      */
> > +     igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EI=
AME);
> > +     igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
> > +     igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
> >
> >       /* Enable interrupts on vector 0 */
> > -     igb_write32(igb, E1000_EIMS, 1);
> > +     igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
> >
> >       /* Map vector 0 to interrupt cause 0 and mark it valid */
> >       igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
>
> [Severity: Medium]
> Does unmasking the interrupt via E1000_EIMS before programming the routin=
g
> in E1000_IVAR0 risk unpredictable behavior?
>
> If an interrupt condition is met in the small window between these writes=
, it
> seems an interrupt could be triggered before the IVAR mapping is valid.
>
> Should the mapping in IVAR0 be established before unmasking the interrupt=
?

Yes, but the behavior is introduced in patch 1, so I'll fix it there.
