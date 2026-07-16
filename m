Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4929A3F4DF0
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194917; cv=pass; b=r7smlWCWp7DgMolm2h5RWVlztNilcxyOaWZSr2IyU0T0wl8gB8ZWrWQn34WxT2R/h4WGAaVJZgM0EqQfGEnFMm1f63s3ZbiFMAP6gi8H5efa8cE1m+gEHRztBgMzomwZoM4G4Nxb4BjOHzV4pTHwXjmvnHW2dZAbzEQx/X2Z3GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194917; c=relaxed/simple;
	bh=LqqsdM1x0Zd6TudpeBiM7tPh+032sxPHxb49LL/o6kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAbdUYtRyQ3/UIfmrDS7Axq0QDpGc6TeCgKVY4bwOHuA8SJWYU0FYo6lPx6IC0g8sTtKZUQm5RoUMgiTCWP/vN689oEszbBzvqqPHUPoHouszx88z+sqeYc1L/pSadFd0zN6dMC50/Oazy2ioScIJw0le5r18VVbBiEMoKhWrEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1f9jGbM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhJCKv9T; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1f9jGbM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhJCKv9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784194912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
	b=G1f9jGbMcwFJ0tDY9Df77AdUu0mrCFca2RyaslpcWANFnOTI7eXgBB+bNLXiG6fkGYKvcP
	PB1An7YaqVkVZmCznOIRqGnu8gBhtDTjX8WE0JiwWDDXgxvhNkgomJR8gG6uPPtPWVqjss
	IxFcn34Oj/sOIh7m0veu/Sz/oThzbJU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-eGbL190sNEylacgm8Uqkqg-1; Thu, 16 Jul 2026 05:41:51 -0400
X-MC-Unique: eGbL190sNEylacgm8Uqkqg-1
X-Mimecast-MFC-AGG-ID: eGbL190sNEylacgm8Uqkqg_1784194910
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7f582244e9eso198548847b3.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 02:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784194910; cv=none;
        d=google.com; s=arc-20260327;
        b=AvhZa29oa63nqECa25lfr74+ngJVXLPGfm1F2eMjcD4VnB/JR0XsPr0Mh4jskBY3wa
         4oLFBFyzOAFZc/QQvlglSBpt0lZB3CEP7Q2rZ0O/nmcgZYthQ98+F44cHhJHyuScVYIz
         JAe5/IkJUFrTBrn4GPkXZRLGTB5TTdR2hrrkbgKbSW0txNS5B0JaDSCRqAZSBgFlf9qR
         Lu+5jfspuO0ggU6I6p/puIO8FXrkvBlt35N186cy83oh/9vLPAMUr+/mnjZGcs7bLRua
         QbvISg8X6HiW/pvGrtI7H9f1Jl+kO5awQ8nRLpKGFToaJkGtMGPeBvnw+Rd7XZu0NmNU
         AOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        fh=JZ0JnCs4Fg567n8QvaMmKZh9il/UxPu/7EQEkExr+uU=;
        b=TMRoTIRVex/nOrd/IXdgZp4duVjzPlK7Fy6MAzcXuWTnvUasNDrhRaph+HKk9ghdT6
         1bLZ1nQ3YY6ayZBh6zxzQwJAfcrKO8PEtaWvir0qAVyPNsXQJZc/go70ehR9fM0pHJ/q
         rOA2H4xCkUYzwH+hac1sX2/FMtgT6MB79APgyXaIXdg3p5pb0FQzj7VlitDtC+Byt38r
         ue685U1fNev444O4tJYJ0YsI3fgOJaXoXM51axxkY2qsA8iqS44mMceKAiAjhDpFyPX+
         Re4euLGrKNjwEWLrDJNVB3R6LQuNzf+x+W6e1MQsyD4nSZfd9RqwnmAyfHn2M4P6s6CO
         4QTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784194910; x=1784799710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        b=BhJCKv9TXVDrgois5zsqTO0a+cs4+RQmeCu9YW20l+GA5pGHySFacdMFdbXyAOXEkx
         mPSJ10Y5ydJSFRH/UQCyclDY5QlmNcvTPZgub51ohs8llDG/3sDzkh1XiiWaNedpSLwl
         W6J3UYTXSG+lvu7WPkPIQypiVMnaOgC/cjV5RK6sZkAGWkgOQxMstSAa/QdcNuwwlxSJ
         RBcbzisv5yzmF2wxwIxYbUHKguiCvKvvIJVEdYlFtTMnKBEXgv0Ymp0Kf4eH8CqAME4G
         oPypXdiyE031+gnsPnLs7ipryj9O+fIHrJmT+s64vdKUlpAyh9FuFFZM4ZS509Phqb7E
         ORXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194910; x=1784799710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        b=Gqzd1hBvubWxjYdgx2iu0eHAngIaffxYU6FP0MEys3cg/TO9yYz229VrgtFUGgjhrz
         IRbpQYqCdXiwP3YlR9el8H7K9Z/eZQVQ1I3+xtu9XNi5VafAPAvwMGNEDf1lmW6QnjZa
         1av93RyJuvupTwpSi0n2cevbvguuoAfZHrgW2egTFXUWfgZjUyDYPNd15LZrw2sUC+up
         CL4KFPMOx3P8TaJXKo+kxkxhPQxL5gR5aEewCmYUM44y3y7ADP4dOFovQY+nUNCzTqTR
         H6m7nNWnZf3L76xB0XfoD07uwbO2TwskmsrO2lwCkS2CBLpCUWI6OgHzxSdeyt4u+Q7B
         US/g==
X-Forwarded-Encrypted: i=1; AHgh+RpKofQeMIVLkxOfcl4krEUGF0AhBFj0lwMYZtbZiRahAk9TdvlADVDHbZV8L5e3RmPBjjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+yi9qhjPi4DdY7gR0N17d7E060+rL5g7vNyC6czfjhARyRhl
	hEmKLVwaePO0wqwaJJ8Rq4SDh7v5iO5lO1Q/Y1QzyVVQnFStuYNbG9UclucG0IEmCaoPjjHbCFL
	FCfoRvrBT9/3JOD2QUelevif149nUjgKT835tYsTFokxuinDZrbiIL/volb74F3HL2xBZKKDY/p
	UEHjQSurFea6o9BjYQW4XL704jUU7e
X-Gm-Gg: AfdE7ckkAKFBq3dtNlArjP+P+b3ZoqwbOShi+MfFhKA1EL1y893bn0EGAOGBcU1I0i3
	wtypu3YhIoGGzZRyOx5Q7RzYabI2yrQPQv6SN5Qjg9SMWt1Kj8SFW/svaO7lPFHGOANiSyklxwB
	VGEpr5crg6mHTYnhlJndCyGw+aetUslNqpSjBJkKUbtGe8OaU4yK2gjKOm5SS/17vpKphu4OkH3
	UJhDOgFI1LMV/qiI2+HQ4CzqMxa5VTKJQpcieN0kLdfJQB2squmzxZu5xCeH5h8MDqogQwttE5g
	U7nXe7BGmTybZBA=
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id 00721157ae682-81ebfda0fedmr73234477b3.3.1784194910363;
        Thu, 16 Jul 2026 02:41:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id
 00721157ae682-81ebfda0fedmr73234217b3.3.1784194909834; Thu, 16 Jul 2026
 02:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030236.124322-1-xiongwm2026@163.com>
In-Reply-To: <20260716030236.124322-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 11:41:13 +0200
X-Gm-Features: AUfX_myzajePn8mltUINphDNuq-00hOZMHHFFuGnRbdhRoWqlQATXfpqP4mVDnA
Message-ID: <CAJaqyWfW9n5o+ojrEjK-m+6cwH_TSxWckjkvEXowZA8r=vDmdQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> Reject VHOST_IOTLB_INVALIDATE messages with size =3D=3D 0 to prevent
> iova + size - 1 from underflowing to U64_MAX, which would
> incorrectly delete the entire IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3c080c454e374cabd7321416ed92c5f7d3135254..xxxxxxxxxx 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1656,6 +1656,10 @@ static int vhost_process_iotlb_msg(struct vhost_de=
v *dev, u32 asid,
>                 if (!dev->iotlb) {
>                         ret =3D -EFAULT;
>                         break;
> +               }
> +               if (!msg->size) {
> +                       ret =3D -EINVAL;
> +                       break;
>                 }

I think the issue is real, but how about adding the condition to the
caller vhost_chr_write_iter? It is already the

if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

So it should be somthing in the line of:

if ((msg.type =3D=3D VHOST_IOTLB_UPDATE || msg.type =3D=3D
VHOST_IOTLB_INVALIDATE) && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

With that, please add my acked-by.

>                 vhost_vq_meta_reset(dev);
>                 vhost_iotlb_del_range(dev->iotlb, msg->iova,
> --
> 2.39.3
>

