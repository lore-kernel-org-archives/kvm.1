Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1A4C33FF
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827740; cv=pass; b=hJofBPCNKIsz8hRWzk2e/LniIOc5rv6d3sqy1rsxE9nAA9DpF6ImNg7kfi+Uvh8aezVTKPlQFCl9bsIjnwivBrcrwaEJPL6mNC0XOa5IzWrf/uSmt5xF4c09XqjTq+paEf1X3Ll3NnHUmuZCKq8um0KCY08qkTJiZP5Q18AgpG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827740; c=relaxed/simple;
	bh=kZdS4dF4wn+JWIPITemwpdYnrEbvaGpLaLJey0JUXyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDdCyRfP3ej19TvrXeJOfk4QiiMYhLuCLOuG63fK8DBF44K+P+jMDocGo4vVyOtbgY49TbV2qwfOncaspud5pq7yl6rp6tOjYrps9piQliqVVw5UUQLWA83CP0jeJ0bT7z6HRgag9n7KkFQYXxJeYYht9lZfUZ3VSpjrnJW1R5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS38XM3v; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS38XM3v"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3156e7705cso347297666b.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 10:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791827737; cv=none;
        d=google.com; s=arc-20260327;
        b=gPXiuzEY2Whaqtq4gAqswAxnlaHDuDUuhjEwl7e9/9JiQtRILK6RmqE0oFLKmBtgnb
         S9qEEPZdOMKGkC0wZTtG4MHYcC5HjdTQjAmOaHuZBT69nHi9JH6t9R0aJcGSe3TQpJ/I
         bqe4LyMTXu4vUgNu6qT2bsOET0TRWpp6UkYdfPDEIX+sMZmhjJSD7Fw2fIuPxzVmxKwW
         Oxe8e+fcdVEqfGAklOmNYl0LEKaQYDRtQa/1CamL7mHdbz8Trfp6Z69ZoBzVKmYc7fsE
         nPb+A4o4dotUnPgOEkbxyP1yDpGkf38adDI8ljq+tc0dj/1Xmv5aab50QuFGxcPvt1XU
         zs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sxQuVKRIInAc/Z3AzZWZwMxHNHQeTzSvMjD6+JaMyKw=;
        fh=1BnIY3I3WRsCEMgPutB6yFcHRwsCz46HFNs3C37mqZY=;
        b=k8lfGO/oQOSClfvAJldk3H+WjSaER/TSdv0ZrutsQiWhMqxFnsMNC/PETbFEbjlLyo
         sf11+NFPg0WFVsBu7zgwD4SLZM8y5dHP5ApcVRPSzBk5BFYJibCmp+i3HNcOIn9s4Lqm
         hiFiQr/CH8xwJgmYzagOQsPIXWIRSaXzMGSXGTYIK1Bg3mEFSkhCxIXdGlDrMVMCB/dX
         NWZPXy516gwbin7cQJ0r3CWjCkBjgx/BiSGZj1DBnH1lUyrhdQmR055uLE6feaLqBiA6
         1Eeb3aUiAL/xwI+KooH/h1cIEdoTN8kV4emsFpTPHdKRYDD3DMpb0PtabB+j2ClGGLOB
         ObQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827737; x=1792432537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sxQuVKRIInAc/Z3AzZWZwMxHNHQeTzSvMjD6+JaMyKw=;
        b=CS38XM3vh3vljlm8rLNG7/wvoBHKg8Ph75VOB5tc48ohOqPqyM/+RBRZymZvLuhl+g
         jj0qCF9synkpB1x8iscbq5tNtlAep55nJgOUi46ZECRw4wJy9jENhLp8eXhnXf/NXUm6
         pFILQA1sKX8uxmjuLqmsZ7VpIVid29nHNk+CPL23UTvaGekSxApIu8R9aYDaWUM+/CMO
         5WLfglvDdIMS3YUS8GQy1UZ5bp/nHgphvvURYLj81L0lRB0Mf7uDBhyLhqQHkJveTg3N
         BH4d7QnQzjbYJom7KPjNP+YVI2PfxOs35OcdKmIKcbv1Iq3+rYc6lepme6DcU8q36pwk
         Ya4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827737; x=1792432537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxQuVKRIInAc/Z3AzZWZwMxHNHQeTzSvMjD6+JaMyKw=;
        b=wjCs6x0p21vKXiX6NphoWWKm/rztU/9KU7wZeGLEd3XpP0x4pH/qLzU6JDOe8P1Ske
         fBX7nie6Jnh5VI9HyqG8jmoj88jQ/oPwl3MT254XbY3dcSDKw97b64oiqmpVlnpb6hIy
         figcncNuVUVQYMaqxGf+aw3xumExW0IeX9idZNc6swtmChDdBu5b15iMfotWnM0sXFXs
         wYPu+UxIy5zfLbwpS8f0ko1UcUWRsky4R05gPRpe88eHhghJR8GXVLoU8ICKFx9SP7Z4
         IOUs4mCbp/qiGw/GJlTK0VhfqWoa7AT+HqhELQA3A7uOcikLN/IVVC+533HSnfknd8El
         9Ztg==
X-Forwarded-Encrypted: i=1; AKwUvBz9t1cGsBtw2JqRcbh3xMJ9rTxpjKRbLHtruMCHlQYui0u31hAaQkFnt/jVpyzcYBztHrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKosuoWsMRc9i3Mrdp6DGg7GE4ulFxujYoc+psIqAV5UIoqIQXW
	uNo3FXpPoS/kDOXngeVQ/KXLDcoSDDcgCSKCbmTBAdyEzwV9J4eDRmbJgpFbtC5wS/5iSFxh1b0
	u7uitUC427E640MP1i1C/aGTzp6tBJ9k=
X-Gm-Gg: AYBFou0x2ILcjhXuSqOGpEOVwX0eeNd0jJ1ZbicDxU1EMy00qiBlGyHKSca1k3ZjTaI
	0j/EFobE5rFBsTtdB83O/eKxLE/V1Dvbl8Iuq3UgveO2BNVn1Io9suJd6l+8AXlOCl7ELZ6nFtt
	w5zlM9gu1bcsJW5ZSYCWPkblzL11Ag9Aevc0b37sebk+1t1hgp+5CO9nyhf6xhedHRFew2dd0Pd
	10pdAaUmIU8fEdu1AV59xmq0yaKgfl58RtNOjEmqj3RGlPfA20KhMKUZHxUaGF1353091ejdCvR
	qrIqkI3G76ePGJkfoswl8ZRz3nP8x9t7Qh3oEFxhaBqSsZ8Nh4d0MJLz93PjKSfQgryMQtVpZwF
	NwpIf+TYL7IDm140Uio3xuPs11ac7KMtNwiItmvF0Nd4I045r/4k918vrqAXiQACvaLjF
X-Received: by 2002:a17:907:c0d:b0:c2e:3ed7:7db4 with SMTP id
 a640c23a62f3a-c31aa00dc1bmr971765166b.23.1791827736975; Mon, 12 Oct 2026
 10:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003223237.513456-1-voytikd@gmail.com> <aszHlWi_aLIh8r9F@thinkstation>
In-Reply-To: <aszHlWi_aLIh8r9F@thinkstation>
From: Dmitry Voytik <voytikd@gmail.com>
Date: Mon, 12 Oct 2026 19:55:10 +0200
X-Gm-Features: AclHuK8QxOWUKD8tjoKoD_vULn_acAenrN-17lB0n0Wf19SoI_dhhDRr9qFGuro
Message-ID: <CAAX90H0PGW_PF53FpWYExaQPKmDdrAP+_b89gq5+a0wK=AicMg@mail.gmail.com>
Subject: Re: [PATCH] coco/tdx-host: add Kconfig description
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-coco@lists.linux.dev, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiryl,

Thanks for the review!

On Mon, Oct 12, 2026 at 1:42=E2=80=AFPM Kiryl Shutsemau <kas@kernel.org> wr=
ote:
>
> On Sun, Oct 04, 2026 at 12:32:37AM +0200, Dmitry Voytik wrote:
> > Fix the issue when the driver always gets compiled as a module.
> > How to reproduce the issue:
> >       make mrproper
> >       make defconfig
> >
> >       ./scripts/config \
> >         -e CMA \
> >         -e ALLOC \
> >         -e KVM \
> >         -e KVM_INTEL \
> >         -e KVM_INTEL_TDX \
> >         -e INTEL_TDX_HOST \
> >         -e TDX_HOST_SERVICES \
> >         --refresh
> >       make olddefconfig
> >       make mod2yesconfig
> >       grep '=3Dm$' .config
> >
> >       returns only this driver as module:
> >         CONFIG_TDX_HOST_SERVICES=3Dm
> >
> > "make menuconfig" doesn't let switch from =3Dm to =3Dy either.
> >
> > Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
> > ---
> >  drivers/virt/coco/tdx-host/Kconfig | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx=
-host/Kconfig
> > index 57d0c01a4357..5a13ec6f51e8 100644
> > --- a/drivers/virt/coco/tdx-host/Kconfig
> > +++ b/drivers/virt/coco/tdx-host/Kconfig
> > @@ -1,6 +1,10 @@
> >  config TDX_HOST_SERVICES
> > -     tristate
> > +     tristate "TDX host user interface driver"
> >       depends on INTEL_TDX_HOST
> >       select FW_LOADER
> >       select FW_UPLOAD
> >       default m
> > +     help
> > +       See INTEL_TDX_HOST for details.
> > +
> > +       If unsure, say N.
>
> I would rather keep it hidden and make it follow KVM_INTEL instead:
>
> config TDX_HOST_SERVICES
>         tristate
>         depends on INTEL_TDX_HOST
>         select FW_LOADER
>         select FW_UPLOAD
>         default KVM_INTEL
>
> INTEL_TDX_HOST depends on KVM_INTEL, so this gives =3Dm with kvm-intel as=
 a
> module and =3Dy with it built in, which covers your mod2yesconfig case.
>
> Does it work for you?

Sure, I've retested and sent a v2.

I also rechecked that it still can be built as =3Dm:
./scripts/config \
 -e CMA \
 -e ALLOC \
 -e KVM \
 -m KVM_INTEL \
 -e KVM_INTEL_TDX \
 -e INTEL_TDX_HOST \
 -m TDX_HOST_SERVICES \
 --refresh
I did this because sashiko produced a false warning that it can't be
built as =3Dm.

Thanks!

> --
>   Kiryl Shutsemau / Kirill A. Shutemov
