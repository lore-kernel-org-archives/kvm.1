Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B93F1AD7
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906752; cv=pass; b=ne9FARlAHPrwKBn8DPXqGgesIGlcqGQ3vgckBIxCxyyR5+47oFZRIjYYPiadT2ufFMuZQaokTfgciTgwPQvtKSmZD0L31qx8VJX0buyz4OlAWJRgi7xZwD9mUFZ+sm4mPbFAzox/Zb8SYf0+7+cqEi1cRwj/7H5PDlPLHni84/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906752; c=relaxed/simple;
	bh=foMYCCJ+aKQqeLr03l4kG5PGTUXTArR/A61o6BzmI+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INvRUAnQNpO4EwpoVJZRJpML+qMtoDxp760tRtJAMwqwkW+qRI3KRfYLkspxHjjPNQUuoSYWvtGS+5YtRTSJXCL3QwUQq4RUTzB98L9g8AN0WOakys1LB2+/NiL4jsmtabbs64DNHz43AYel+JPSFxMHL6xCGkBpVTkyssPi0A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ8mQOXk; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ8mQOXk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f0e5e36912so5122176d6.2
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 01:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787906750; cv=none;
        d=google.com; s=arc-20260327;
        b=LgwAUr7tX+JlTKjfXErHVgcCGjpfrEjJ9sNMAGTo5nLHMiWeDM4eENTuVzpAoP+2ZL
         HiVZ3t8+o+CRjPiS4CAGG63TfkKyRko8GcXEHyS7hM2s6G+MBcc2rPZfuwhchM90a4zF
         TBNh758LH+z+Lz995kzEc0Mn2FMPvPgXM5ia8VO/VV6rAeVplJWo6i8sSculi+a6aqkb
         um3ItI0YM8TTj+soPaI9LMTj+XBj9mN1AzLzo8wlDnaLKzNsxRcWEVdPG0/KrsZR/yPS
         46UPlW0W/V8LZc/nLZEcrUMq8NSJxLLkEUi2OILlgJF+hTF+TU6AENEeUlkoXEuWYas1
         FPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R+vuGpXV32M//EXLT1S4dmLGkLzlqAlnEnpUouWH7fw=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=FsnSX8eRvErG3bYSVNJLAT/z5lgjaTD5YzaC8TSJEnRw2ZHoGuVgmhjGXdwQDEf5px
         bJyO+Ifh7gBbwEO2vQ1+nUE/xrF7Aj74EbxceGiDxUsnrrfQVPNy/dBrVSmVKw9EBENm
         6KTjsUuG28zEIztNzJfI3Ddj8pVYO6hjfQsyxhS1Yy8BoMDBIud0dagdtumG3QmTMIMj
         CxZD3V/S32O2RmtI+rYvDiTU5kzlbvGRo3IGHe8mCplIOjFS9I1/ZfR7t4zWmn8qjx7x
         2jOzl1j//Je9VlzLcN9Ux39THOxzeXK2HYmYFmv78KLdFuw3o6NSfdRsOMiH+xsWGaic
         702A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906750; x=1788511550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R+vuGpXV32M//EXLT1S4dmLGkLzlqAlnEnpUouWH7fw=;
        b=CJ8mQOXk0NSwcQ97UtxpuoiDhOqeIML4KLTTHz1Co4eYu9sTbQdV2NwC7lLARxNR/R
         KuQIE2E1f0Df/llfvwmP4EgrbNXoOHJQj82uec/HDMbwA2/HDkeltnaLZDxVudhQZ/X4
         OpYsEB+/I5LdC5QsZBXSxz4v6cyz4KWUvcDwTUs6uamBoTcKLfLsVe9C7C8aobTw0bin
         c1mvWhcW0SN8QO/lhHWtIclSK60uVUWg4zqoVy/293hqEikbsRO8awLGyzXfg26B9pzH
         4kbSss4M7SBhoM3ph/uGl7spu3MrARX31nw/l1AdHKL53KU4xbkyiDSs+HsdErnvtCr6
         ZJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906750; x=1788511550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+vuGpXV32M//EXLT1S4dmLGkLzlqAlnEnpUouWH7fw=;
        b=lCnbK7JFVq5il3pjjHJOmHTPpYaY4AYF0j5K5kfWzp04Fo13EO4pUZ1qykiqhmMfGJ
         lU9KyIhZ22qZcf0SUAk6IWiqceQ3vWqzvXDEMrvn6pE7xW8a65Xt/ZtUtLk+cpG0oKpG
         QegQrmn4JEnRs1oFnRiHYX8mCrLVPSIbh6hCeZShQbU9QhRDXQwdyGjH4JhyOvxdJ+eG
         fl64ULUxpDmayScLFVvxLp2GKfyp2tfoasqb1ouPPC+OjnlYPxAMSTzZ/HAegdEomJu5
         E9lpJJRF+QRCuMqrk0RICLVLuVb4/k61+8j/1Lx5n0cc+oGl+CfgPzoL4ELIpQiD/sO7
         x49g==
X-Gm-Message-State: AFuF++l8nnCQWIQ674IL6JGiee9ayTaXxVDZ6L+3BJy2oysffoR9m7lb
	3chqpiSXDVVmAOuWNz0+ajSY4ETQEeeiM/pP21dg28Mk3fjZX5py+otJuyjryzBPhpDcBSmF3KC
	zABKZ6TPvgrFBRx6vMB++qybY78R/CvQ3t9s9
X-Gm-Gg: AR+sD12b2eozG4aVyKxwBQJeyctn1rNM0DY6QCiWkO45jZ1GD5ygm/HnIsjC7flEKZY
	88P83+5EXY90SkM3tCTRgtKhx3vKvUZUSmIMnz0IoSLjgCzKMGN+smQtjOMPxE+6uwN1UFMb8su
	Um/eUUhu/tNaKBcDUfZyG4SsTT841iqQnNzGVVMMi7Ck8F/vHX1hUv213SCizGBR4FICpA9YmBQ
	Tujmthjg/6JUcPFeLT5i0wysiyIPzs6dTbj9qiJXbVLPVhXgDJcT/4zzL9ML2mmcnlDT0Rrposb
	8xD/xInwNwVsV8FXThJGZeahGt8AlRiaCNRlWGlK2oxb
X-Received: by 2002:a05:6214:4902:b0:8f0:3b98:d6af with SMTP id
 6a1803df08f44-90ce0ec4959mr62282336d6.26.1787906749180; Fri, 28 Aug 2026
 01:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821092108.334318-1-physicalmtea@gmail.com> <20260822092149.B85491F000E9@smtp.kernel.org>
In-Reply-To: <20260822092149.B85491F000E9@smtp.kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Fri, 28 Aug 2026 16:45:13 +0800
X-Gm-Features: AcwNN1VO5lrxjn7mKua8z_P2HOL-1Kz6_UW4T9Fp5-7w_bziMTnekXRsXsDA_2I
Message-ID: <CAJwVaMJqo06tf0XeM84VzZmqh5A1Q_hAHW44gyh2Ni2_FCmkPQ@mail.gmail.com>
Subject: Re: [PATCH v8] vhost: invalidate vring access on IOTLB transitions
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Concurrent execution of `vhost_clear_device_iotlb()` and a v=
host worker thread calling `translate_desc()` results in a NULL pointer der=
eference or arbitrary host memory access due to lockless clearing of `dev->=
iotlb`.
> --
>
> --- Patch [1]: [PATCH v8] vhost: invalidate vring access on IOTLB transit=
ions ---
> commit 601cfcb65f9457e49ce60311ed18a7ca3496a8ba
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost: invalidate vring access on IOTLB transitions
>
> This commit introduces a helper to clear the device IOTLB when the
> VIRTIO_F_ACCESS_PLATFORM feature is cleared. It drops the device-wide
> view first and then drops the per-VQ views under their respective mutexes=
.
>
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> >
> [ ... ]
> >
> > +/* Caller must hold the device mutex. */
> > +void vhost_clear_device_iotlb(struct vhost_dev *d)
> > +{
> > +     struct vhost_iotlb *iotlb;
> > +     int i;
> > +
> > +     iotlb =3D d->iotlb;
> > +     if (!iotlb)
> > +             return;
> > +
> > +     /*
> > +      * Drop the device-wide view first.  Each VQ then drops its
> > +      * per-VQ view and its cached ring access under its own mutex.
> > +      * Keep the old table alive until every VQ has completed this
> > +      * handoff, since a worker may still be using it while waiting
> > +      * for its VQ mutex.
> > +      */
> > +     d->iotlb =3D NULL;
>
> [Severity: Critical]
> Could setting d->iotlb =3D NULL here race with a running vhost worker thr=
ead?
>
> While this update is protected by dev->mutex, it does not hold vq->mutex.
> If a worker thread is concurrently calling translate_desc(), it evaluates
> the device IOTLB locklessly:
>
> drivers/vhost/vhost.c:translate_desc() {
>     ...
>     struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
>     ...
> }
>
> Since dev->iotlb is cleared without vq->mutex, could the worker erroneous=
ly
> fall back to dev->umem?

I was able to reproduce the issue. Although I did not observe the more
severe symptoms described, repeated resets of ACCESS_PLATFORM showed
that
translate_desc() can select dev->umem while the device IOTLB is
active. This confirms that the race is real.

>
> If dev->umem is NULL, this looks like it could trigger a NULL pointer
> dereference when accessing umem->root. If dev->umem is populated, could
> it map GIOVAs using the GPA table and lead to arbitrary host memory acces=
s?
>

The reported consequences require several additional preconditions. I
could not reproduce them; at this point, they remain theoretical.

> > +
> > +     for (i =3D 0; i < d->nvqs; ++i) {
> > +             struct vhost_virtqueue *vq =3D d->vqs[i];
> > +
> > +             mutex_lock(&vq->mutex);
> > +             vq->iotlb =3D NULL;
> > +             vhost_vq_invalidate_access(vq);
> > +             mutex_unlock(&vq->mutex);
> > +     }
> > +
> > +     vhost_clear_msg(d);
> > +     vhost_iotlb_free(iotlb);
> > +     wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> > +}
> > +EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821092108.33=
4318-1-physicalmtea@gmail.com?part=3D1
