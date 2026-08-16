Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24718BC3B
	for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786856480; cv=pass; b=aOsgpJDZeAsMIPqFYhpxrWnGuodz7I0GNWL4xkOC55uSKm42EIZ6yTjM+DKrsxK8fdaQzTLWX2HWjY2Xvx60NNxKzBEOSBmrGk7fxxyIINAuaWOKGVZ4UP7bv30gh9dVX6ycwAF0Wr9H6t8+nSzlXWCR70oe3a1eP+UqJ+JLGRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786856480; c=relaxed/simple;
	bh=6nZ7uWDKkKyQXWqZBP+SaoTwUDfFkyA+VI+BLcb4TEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5QUUN5YafP79640j5ewbzJbOUO4Yid3RtzRAAcCAK6XUFJ8IhfL919zKH8AxNHBhFhUscfBmQ5YYdw1c43Q75Khobq4QaKtMATT1RGvuDwDAJBTlXb+7HLkFXTlqiHOGYTza1sSHGKP9klOdxxx+uHL3I+uW81QNj8nfwk8mEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmZsbF0g; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmZsbF0g"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52cd38ddcdfso8832401cf.3
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 22:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786856478; cv=none;
        d=google.com; s=arc-20260327;
        b=qwFuyXX7qpdDg02gUUy4Ix448Vh6vCcygzZTFV+wtpfBXSOHxZET0dLhQeyPkISQ86
         cYySQ0j+5fd+n0vrsGG9sQQEw01RfgaKYZPzh7HIEGsdTqr7EF1s6ax4aZF/d6dB97gM
         qnP+dcYGqAqHg123N3kyWXjdaRfVnZnnQaxyrTcceZ4RR0DbCyMRjcYW6kh+rPw8Dsja
         KmUrEy055x5UxxEsMwwgjUz5TKhUzqGKycUx6OtfJFZ2nf5ajvPuat94EyMEHFsYzeDH
         lQ1D8y7is8YcRzQwaeJXr6TVwQPaX7TrBRG7Uax1sB3freroxjnquWhO5x6bj00s4+Y8
         0hOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8/71bLh+w9rZZhRc2yuSIKi4ExOKzKYVMgI7bI9QhU=;
        fh=D5TUnnSbdAmCFzRYxtyEYkT9Mnd8q0lRDN5K8kIiW6s=;
        b=cfh1ZNd+hNmLqi3/NUtHFUVxWDhvgVtABUzExC9H55XpUuszdvoD3Rio3EDbyP2S0l
         D79rAicfBDcAFr3eFcy1z+W/Dr2as1dYcSPsT//e7X/fva1V2tnnEQPfULiO70I8h2iy
         0bRncjhTA1SrXtH7YjN3lmgm6zuB1VvtqsNaKsWDXJGtdhcYstGzBg8pr+zr4MvFazFL
         4h/2Etg5x+wgkjK1JHqyo+KZk2h16nriiuWGF0Q5//cUtpQgAL/4gR6b0bg3pqhf0itx
         bGY0RpqEZfP4+8j5S9t89nruJz/8Jl3jS2cYslM7FCnbl+u1GAhDB7AEJ+etVpN+pksu
         XWOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786856478; x=1787461278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D8/71bLh+w9rZZhRc2yuSIKi4ExOKzKYVMgI7bI9QhU=;
        b=GmZsbF0gU7sm/80PpFE3QboHbvyc0mIZ+SdYYpHq8+0WAYq4Av4qkVxjSo/pP49j8a
         +Px4qa19ZZBNEulB9zFS9xKeTG3F0ErRKnHGUsIyQVTNJ7B4VOf9wv6UACUTpKfaRLk1
         9kVuWMduaNzkFZrRgbXfa48VRgtbyM7/2CkmGckjsBuoT6J4+K7QsA1WIB3bW5qIRHAQ
         m2sM/GXeMCn+Lhnzml1iOq5ULoOwB9EQYsvulhAcG5qwXQrXTtVAusKlD+0Bo3fLcVAS
         bf4H35Aa0Pr7lsI1MH1li/kSK5uRQjIDgLDpT0oNm+Ov68fsycP68KmfDs6TEV4GFwiM
         Mn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786856478; x=1787461278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8/71bLh+w9rZZhRc2yuSIKi4ExOKzKYVMgI7bI9QhU=;
        b=Lao0tNndE6S/kYzgGGqAN6hzz6Dpeah05o+n2PwqfUwSGUT85VRGedumGpn/1i7Qc/
         APghykqbrliKOOLq4DnEHHQFUjByzjHvw+i+7syCqebAiOwEPmF2pGb57D6Gi0v2gGkL
         Tz34hfTK4knftoHczGnu9ib1paRrlQEDLYvqH80S0UQbw3u6gexnGUpfKnvi9rzlEWBe
         esR6S/IWHfZrRqb8msYh57X2LH8q1le0DLCHI9MwYeHHkrFLKs0iMwEUZiuR+pf+La/3
         FGgsCICgLFcWtn8KR0gyrZhNy0zkIX3laMbJQGjKFE0RdC8tC2GndbF8+emhAMtdWfEq
         DKtg==
X-Gm-Message-State: AOJu0YzX8AC2AFtdzxHTZ/17BChyO2KkBLDsR6FuwyBKoauYe8fnNkIV
	1G5Vt2xotYBQkoQYew6oNSaw0LqgeN1Uz+LeHresaDZYKu0aT+udUJG2lVxVB/9Ih2NtlmVnuQY
	tG0ek02GMVv854Ps+YrSRClaDWBkpfo0=
X-Gm-Gg: AR+sD117nQq+favq4/6ubo/S04rjPzCOGIc/5In6aHsJDGxT+WfFE2UGpXDU107hiMy
	HCHoB83smcCa62etxfXD6M8hCprn3anRnn2YRBenhql3lOTAl4G/OgwKV+jUtuwPKwv7qbDmGsf
	crfQFePeVsG/EJVPYdOaJLAkZPaz7P8Yw4cRnvhqgtDhzHsBhuVWULALVePCLwGg5M/V44BHDnL
	byf3xh4nqSvLFRHIIwxxtbNxFa4HjZ3U84L6uZ5yQszTAyBpuV8FydJ1Z+qRSXWzQOjs349nBt0
	k0hvoNPfWkiSREQyjotMwd3cublQGUxZmyRqrdFi+Qj2
X-Received: by 2002:a05:622a:4189:b0:527:43a:2f30 with SMTP id
 d75a77b69052e-52d85381c96mr206682521cf.1.1786856477220; Sat, 15 Aug 2026
 22:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-2-physicalmtea@gmail.com> <20260815072935.410ED1F000E9@smtp.kernel.org>
In-Reply-To: <20260815072935.410ED1F000E9@smtp.kernel.org>
From: "m'te'a physical" <physicalmtea@gmail.com>
Date: Sun, 16 Aug 2026 13:00:40 +0800
X-Gm-Features: AcwNN1UmwAk6Kw5H-vtPINn8bmj8KuTvj3801SSFEdFUigHbLDkbQCHJ4srJXfo
Message-ID: <CAJwVaMJXNh1TECy9aXS1pnLuLMjS5icUgO=VGbvgm7RNPZ5_gg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
To: sashiko-reviews@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Setting `d->iotlb =3D NULL` before acquiring `vq->mutex` in `vho=
st_clear_device_iotlb` creates a race condition with active vhost worker th=
reads. This exposes the host kernel to a NULL pointer dereference or an IOM=
MU bypass (TOCTOU vulnerability) leading to arbitrary host memory corruptio=
n.
> --
>
> --- Patch [1]: [PATCH v4 1/3] vhost: add helper to clear device IOTLB ---
> commit 721258d5c0d5f3c1aeaefcc8dc997b5bbedcd9c1
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost: add helper to clear device IOTLB
>
> This patch adds a common helper for tearing down the device IOTLB shared
> by vhost backends. It drops each virtqueue's IOTLB pointer and metadata
> cache before freeing the old table.
>
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index a0c1d54019aac..0861406f3246f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> [ ... ]
> > @@ -2298,6 +2298,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *arg
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> >
> > +/* Caller must hold the device mutex. */
> > +void vhost_clear_device_iotlb(struct vhost_dev *d)
> > +{
> > +     struct vhost_iotlb *iotlb;
> > +     int i;
> > +
> > +     iotlb =3D d->iotlb;
> > +     d->iotlb =3D NULL;
> > +
> > +     for (i =3D 0; i < d->nvqs; ++i) {
>
> [Severity: High]
> Does setting d->iotlb =3D NULL before acquiring vq->mutex create a race
> condition with active vhost worker threads?
>
> If a worker thread is concurrently executing vhost_copy_to_user() while
> holding vq->mutex, it could call translate_desc(), which locklessly
> reads dev->iotlb:
>
>     struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
>
> Since d->iotlb was already set to NULL by vhost_clear_device_iotlb(),
> the worker thread might mistakenly fall back to a potentially NULL
> dev->umem.
>
> This could bypass the IOTLB translation and expose the host to memory
> corruption via forged GIOVAs or result in a NULL pointer dereference.
>

This is a known issue and appears to be the same issue discussed in
<20260804072159.7506-1-physicalmtea@gmail.com>  I tried to reproduce
it, but was
unable to do so. Therefore, I retained the current approach.

> > +             struct vhost_virtqueue *vq =3D d->vqs[i];
> > +
> > +             mutex_lock(&vq->mutex);
> > +             vq->iotlb =3D NULL;
> > +             __vhost_vq_meta_reset(vq);
> > +             mutex_unlock(&vq->mutex);
> > +     }
> > +
> > +     vhost_clear_msg(d);
> > +     vhost_iotlb_free(iotlb);
> > +     wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814072903.12=
4991-1-physicalmtea@gmail.com?part=3D1
