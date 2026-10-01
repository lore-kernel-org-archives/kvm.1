Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0A370AC8
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816916; cv=pass; b=GeldVqL3dLC/TvHBUcPeyrNE+6KKsAKZazAbs6en2+rYhOApkwIqYXpP2xGSH23kb68ssnJaOBwKFAEwd/LvRoSzDOJnQ4WBB3JIwwW4tC1mM9WjIT1WpKHdGUXQtQ2YtfrlI21sDNwxzCWoyQMtpBSgL/NsepranA6PJtD2MM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816916; c=relaxed/simple;
	bh=EElVO0SyMWfbu0TO/p9IG8++sd29PlCl+ReAKWNQ0Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEI+mDsc63v3yRSxdOVqeGSkHCk/MhZdZGo4E1h/WHLcq8+NRQuNoABfYW34KAKr+JqzUBdN4MPVwG2DKYcxuLY5WYB8sAqTrGOWScSQiZpNawcN2cYUzgSRHMZChrgFgg3mvlRg3Re2hwatoc18KRxrraLTb1L7dt0yy66Lau0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1qvFaOH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwC5G5N9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1qvFaOH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwC5G5N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790816911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
	b=J1qvFaOH/RPV6CeGVEkyUf0x+N8q3FSzEXHzvl4qkS+YfpkPfau7aPxVWzA20bDMUhVa/J
	1q9WsuLm2UYTnyOQmBUqIafPOpFDPIMjCb/mWE/IKT2eat4rpICchTlctwme2o07aJclLZ
	xHcPh8u2aa4MDBJzq2KuPqwNHCBpHFg=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-GYb7_nk6Mb6nvFeZC2ntiA-1; Wed, 30 Sep 2026 21:08:29 -0400
X-MC-Unique: GYb7_nk6Mb6nvFeZC2ntiA-1
X-Mimecast-MFC-AGG-ID: GYb7_nk6Mb6nvFeZC2ntiA_1790816908
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34344599f01so6290763eec.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 18:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816908; cv=none;
        d=google.com; s=arc-20260327;
        b=er9Id9r4zAPmlXGOwarGojbTq3ZhZjroN87QTEZ4VhuLWDth1rLFH6IB5rb1dkUIS5
         WPS9vKNSQDPmRLOtNDsXpGRKMNZzX9wIs9PstJn9nbo3SdpFSkWTG5oW27J4XZFEaZJy
         VwKShttetVs4GFBb+S1InkTmW0mlIcQWSuxfEDA8WN03/M8A+X6MNGaPPfHpYuw0c8ba
         6LNuHcccCqQDjLxvhmn3ovlTC+pRvk58YVlrVWXDtzm/TDTyMIab6gpc3QDp5bBlEJTR
         iz3N7ActNZr862zf8guivZ6ZbwT/V7PNeRMnQBnzE54xxbwVP1OT4gKKQxK2utpruhnv
         OvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        fh=n+TMF9qvuTBZTSuCwPTrJkI85kyt3+q5LkOlNbrTCBM=;
        b=J4Q5M9DNsD9Toago9d/onnvZqDxnj2WVCG8Q58L5NTp4jw5mjTCIy8YdGNswvM+9yc
         kyTsPPXXYXgwMZuw/I2PmSp+ol6UvQd5OzosDx6OLAwp3aSkVnaWsO8qusZxOk6/9S6W
         jPMutVaFQ0YQVAoFEnwwMfn3scnUtdEY2PixGwWExopZy14NuPfTJMm7jEWg+H3lZjOc
         pwDPKepavm+xoZN4DmVDBcvbPemvPrjSA11Eocge/288kd1epTVMwn+DIlcxdnYq1dGk
         N34Uq88BGh09XNXnp8FuKXxs+TO9M/Lztq+FY328gm+/S/PLaH3Uzol9PRW7BDsBOeLG
         6CsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790816908; x=1791421708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        b=MwC5G5N9LXKcAvgOKxeK9dd9ij90H4qO5wZCt33ZQLZjkCtV3FvoJYQ97PkJPi21Fj
         9Nvh4tNtHXnhigUR1/rSaAfsb5pMef/F136zHTonyewH13J/r7qBeC9XON1QONKwsNgJ
         XkMqUzG8/t+MBR34JJWKiaHVcfqXjhZZauLEGvz8V0Lty9nGlDuDcyUJPEm3CWm5J/Md
         EDvvBtR+yb32/xRKNi4l7Cei2n8bk6JOamnOn+edPNRTcapPOL1lhS0qjhR2/7DVE1Ex
         aPBNWV950Vd9IwOMJjwO67m9Irm7DizXxLAUn0U0AU8p14Xy8AzK3AbHGEnOj7kYXi4x
         f7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816908; x=1791421708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6337Slr26G9fWAkknUzN8X+fyx+rX5+fV3KYKCnIUr0=;
        b=wUcC8dSvxbBe18sXFrDic9tn6AUf3CRt6S3KMshzSz+GN/ziiKtC+Fb9uw9lO9lYKS
         woBrC6gAKiwUSaUu3u27+MbzM8/WgvWZVAbcckrvaB/K47Ta1cvf1H/CcZkKcejpF0eK
         kwKMZA5wuWUldLuHX5gIYvbP6XMmzDUf/0t2owVzQEdS2dXKohIAlHpt9BM+dzpyuoZH
         Pua47m3XLobxXSsksvdarRCEh3M7LnC2bqTy6ZVfjr9bL6UjupvxHOASbqQX3yJH/KEN
         b2+gPpdRESeT1eOioolpuVaRke6MYfIrCWcrY8KlP/tGrd19Pj0NqglFSZuzyLz9BE1h
         Kycg==
X-Forwarded-Encrypted: i=1; AKwUvBytthG/qTxgdIYReWUX83/bjngnI1AyeQsMzmoa0tba9IvjsLCbab1Jz1kzNjpa7/NH4s4=@vger.kernel.org
X-Gm-Message-State: AFuF++lFTn0weAQ7QIRSgYgajE0eGfJZTbK6oBBfmAsSwdO1eM8nJirz
	tikcDJ3y0zGU7Eznn4ynwtjjTISD87Is0Ijiy7rVsQ3q3v5GmZezatNLevK/ljBVUaCuLbQ6f7N
	3thLaXg2pPl2ONDRS+pmGdTHYM8iMFH6L1qYWIYBE14UI3IrgHHwaEkTYNqN/T8xcapW3z71ajr
	cEuiy6ZQzOGzDmUvXYT+4oiPWZkn+N
X-Gm-Gg: AYBFou2VfmK/+0TNgBa6LHLX84l5vJNBsHNKLukb93Va5+zT7XqIKZ5WX/SEz8L0nbf
	V+fQl756pEv2qOdgmpWGNBBnZhAlFOM6T+gUwR9GH3mtvITYzcus1on3MfeEQTYBqrG81FKuntJ
	HppneSN3i9/JzG4dhyB72S3ZEsimUjBowPyslCc497oMfKFCCnlwwfIeIrVWFtQIpnbiffNIMia
	iusae393O2YdYMw
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id a92af1059eb24-14d3214813amr3682605c88.17.1790816907953;
        Wed, 30 Sep 2026 18:08:27 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:13d:19da:9370 with SMTP id
 a92af1059eb24-14d3214813amr3682563c88.17.1790816907221; Wed, 30 Sep 2026
 18:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922071807.2533884-1-airlied@gmail.com> <20260928140028.02900e68@shazbot.org>
In-Reply-To: <20260928140028.02900e68@shazbot.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 1 Oct 2026 11:08:15 +1000
X-Gm-Features: AclHuK8H40xGZ7LDm4tWEaoZ7Fx41p0eMmMGmCD_ZHFdFpJFjKlkMOkwot6pi94
Message-ID: <CAMwc25oCKJaYaUOt32-xegXOjLbWMpk2RAASyZDj1ooh_41hnQ@mail.gmail.com>
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the decode
 callback (v2)
To: Alex Williamson <alex@shazbot.org>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"Simon Song (SW-GPU)" <xinmengs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 6:06=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Tue, 22 Sep 2026 17:18:07 +1000
> Dave Airlie <airlied@gmail.com> wrote:
>
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This changes the vgaarb client API so that the user can pass a
> > private data pointer into the register that will get used in
> > the decode callback.
> >
> > This allows a bunch of pdev conversions in the drivers, and lets
> > some future vfio cleanups be nicer.
> >
> > I'd like to merge this via the drm next tree but also fine with
> > it going via pci.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > ---
> > v2: fix loongson (spotted by sashiko)
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
> >  drivers/gpu/drm/i915/display/intel_vga.c   |  7 ++++---
> >  drivers/gpu/drm/loongson/lsdc_drv.c        |  4 ++--
> >  drivers/gpu/drm/nouveau/nouveau_vga.c      |  6 +++---
> >  drivers/gpu/drm/radeon/radeon_device.c     |  7 +++----
> >  drivers/pci/vgaarb.c                       | 13 +++++++++----
> >  drivers/vfio/pci/vfio_pci_core.c           |  9 +++++----
> >  include/linux/vgaarb.h                     |  8 +++++---
> >  8 files changed, 34 insertions(+), 26 deletions(-)
>
>
> Acked-by: Alex Williamson <alex@shazbot.org>
>
> Preemptively, could this get merged via a topic branch that we could
> share in case further drvdata cleanup arrives in vfio-pci this cycle?
>
> I'm imagining this might also be a good time to push vgaarb
> registration out of vfio-pci-core as well.  Thanks,
>

Thanks Alex and Bjorn,

Okay I've cleaned up the last few bits from Bjorn, added lines and
created a drm topic branch

https://gitlab.freedesktop.org/drm/kernel topic/pci-vgaarb-rework

I'll send a PR merge this into drm-next and you can work off it as
well if you need to.

Dave.

