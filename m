Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11979306498
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913074; cv=pass; b=aPotKYA2yhcMnhyBZKMv1y1KzglLR/aLCrvMnoy6K6digqFWkPfuo4UMI2c69NyPcwr6fk5xPRlMd08z17jNDDiFrrepf49VB/PbhcW2FiY4bfVpjhVAYqa6A6D0CLcZsztyAVIRJIrk/m8Kc0ValVSYOiqqm/HeX9+o1vZsXho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913074; c=relaxed/simple;
	bh=Yg/Wzcwr8nuTOj+aY3bK0uncV0Afs/fkAKyBSA43g1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9nJQ3lEBCcv06MNQ9wiD31LZJAkH49hT+zM4Jfd7nCV614F/QOywEbMUxOwt0NO1+bjBTViVwjqz1QnICQaUSy/2+Fv/Bvi5zc6hQnrKG+Fq71A2oiwg40GQb+bzhPkmaCQdLXA9UPPYH7sXfg+QVNDtIuSq2A7fQGb/U+iCZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZD4Nznx; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZD4Nznx"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so8783036a12.1
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 16:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913071; cv=none;
        d=google.com; s=arc-20240605;
        b=YW24TN+wjR1JOtvEzcujMiKe/sE03mP+7kkaYN6R5A5w62jriax8gwUL+Zjg32mWbE
         xM3gy17XVippt2gBKXYeNXk8zJ9nP3cfbvlA01v0jJmPaOE/DasyP0WqNVDQxf8lpFO9
         2g8pU/LK79+GibVczSVZF2VFWCCsX1xi2dJaNCROeOMigSncIJb787LlINHpgu1tldih
         ntR67+DJ0y/+hyiOoVm9Dj4R4t2QMWC+B7wtEDL+vrWyVxFibSabEo7y47Yzbz3NGYyr
         i2Fd2oulGKBmwrdAnLjrfb76AP1ffdSDa/pohFvWGQX9oGJBq67uKZtHGmlUhWG4Xw8i
         WLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        fh=TDH9vF49osDWwfDdlulssNa4c2GYZRJPTD7W/vSUnaA=;
        b=kGUT6h+pdBF+gs+OHdjAjOdvzpJdrkrsfQLWh9gkY9+LC1MrQvYZHzhMWjcNTMb5pM
         ov7UrOe3VgNuM+feuLcPkUyZLPtpnTuqpfUvbYky8fqSZG0Dlt9frQ9y0WUx/p/egVJc
         MTy1IcQvcFmZ6gzYtZly2oE+AOob1x/ahkTQuGaS6f+tJ5wepNNp/TV9Pf59Vd7LSsUl
         HoRYHj+4lSeKngMkZ6UwWTPvqYx6cXh6rUn1ikjaRqBGBE8wtp2EgefXVo+zefT5C4b5
         8Auh1qer2+VQDN9Tp9U+kvvLqyYSTRX5InK2Y6byQn5AuhHdYjiyESCj+r5UEJX1k+lt
         cstQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913071; x=1775517871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        b=RZD4NznxKAgRkoRaQC9NZNLDQJDH8G60CJdN0xO9SF6mzQn4pmjm0b/tFvgJfBnmhJ
         GS6SWTZK6OWfMqOlmjVzV6gMjALoiXb+BSfmvZsaedQ8J5Ejn66dmw9mpq1eunrWi1mv
         4d6yyjbSf2UbPWbi7OPLKe4MAuBAtwEOBJ0ii9gE/OwIs/1L223mqyyY5SdG4hGfjkJB
         2BVskOfAaibJoWbgtnL4lFVIlN4OU1Hd2gT9UnLHRVis3PdPp8+gDB16v7+zBN3ARsIE
         dpYnovikmBIprQ64aVCkzCgTzu4Ix/jbOyePKePFy1tWenKDZwOdyQEsN9mvj24j32SR
         ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913071; x=1775517871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        b=mDyKyaJjZanmFqAzSGUVhGbSrEDseWUrX89lINTZjDy4Nx8geSTREj6lVMdnwRk7gw
         lLng2nsPCA0MvFde7/Xe27yV4TAtPKPWDMVaNoJUg5LDzKkz1DPz/+0xAM+oT9C37T5Z
         dtV/D1P3Zb+To+xbMAgVmV8bwAr53yftWtYyM8bgSVfseVXBnZkD2N9zZGKLTnfs95R8
         k75OkHzp3AcFexM9alpeaR3MVXejIZoRCYhvhOmEAWwtFD9oDt7TfOGIxXQgBK+2hler
         k2HPQTbgQ1laf+i/1YdDH9iEe9S29ZEiP1k69jnSwtkNlyzUYQbtSK7JDt9GcIv85DC9
         gP3g==
X-Gm-Message-State: AOJu0YxF8pPyEBAIsnun3KoxR+pEEPZnRS5XVg2HXl0tUyVFbGMUX+G0
	v8wJ/8FWmw3M2l51e71cnGYyCoZiuidU2t7x7Hjv240E7UPx+1H1nTDVPDUojqsc2uvOGsKgjns
	GwIU+ubSgBGLhXwIFy1mYp4BFU0CYOgg=
X-Gm-Gg: ATEYQzzxws9rX/ztukGTJyx51OMEOFIPi0GPCl9vQAVmTqiMssHuBrZko4NuIo0Zm/y
	ylw2Qcw74nCg4p8pCq/Z8gsTOnrhTfd8VhKKCDq0UeAMfjQgkmCNziRFIvX1FdTGiXa7mYU0KH2
	qruHdnRkT2NMoFwvLbwYeOzUK9/zypEYT3rusjA39bJHOcPG3e60xUQIIHlfDkNI6bIyuaGJZd1
	ru29aVN3cujVx6ZIz1xaaYzzyUGsuqZmay82O1Piw8xJe6C+TySRgFKS0ALTC/Am2QOjS7unHaJ
	opIS+2DwXK0n4Hda5hCprOkF+nFW25sl4i5ibIXYqX4n2JkxHQNRaZ/CJLgvJBmAEcA/j/OTA8/
	BkOMsfA==
X-Received: by 2002:a50:fb99:0:b0:66b:3d06:bfff with SMTP id
 4fb4d7f45d1cf-66b3d06c24cmr5309095a12.21.1774913071422; Mon, 30 Mar 2026
 16:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326023747.54485-1-rosenp@gmail.com> <20260330161933.6471d473@shazbot.org>
In-Reply-To: <20260330161933.6471d473@shazbot.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 16:24:19 -0700
X-Gm-Features: AQROBzAidcpIVCd1YiJIrE0vM9y7-srtU0yd-xhmfvOW4gWw8BUXK5VZROzReug
Message-ID: <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:16=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> [Cc +Leon]
>
> On Wed, 25 Mar 2026 19:37:47 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
> > Simplify allocation by using a flexible array member and kzalloc_flex.
> > Less memory management needed.
> >
> > Use __counted_by for extra runtime analysis. Move assignment to after
> > allocation as required by __counted_by.
>
> I don't understand this statement, nr_ranges was previously set after
> the allocation of phys_vec.  The only reordering was relative to
> setting vdev, but that appears arbitrary.
Yes that one. My understanding is __counted_by mandates immediate
assignment after allocation. Otherwise UBSAN complains.
>
> In fact, we don't need to explicitly set the __counted_by variable at
> all, kzalloc_flex() handles that.  So if anything, it's now redundant.
Redundant with GCC`15 and above.
>
> Leon, any other comments?  This should have a v2 removing the
> redundancy and fixing the commit log.
>
> NB. This will be a bit messy to merge since kref and completion exist in
> linux-next via drm, but maybe Linus will consolidate the hole in the
> structure when he resolves it.  Thanks,
>
> Alex
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 3a803923141b..40e7e035a720 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
> >       struct vfio_pci_core_device *vdev;
> >       struct list_head dmabufs_elm;
> >       size_t size;
> > -     struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> >       u8 revoked : 1;
> > +     struct phys_vec phys_vec[] __counted_by(nr_ranges);
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
> >               up_write(&priv->vdev->memory_lock);
> >               vfio_device_put_registration(&priv->vdev->vdev);
> >       }
> > -     kfree(priv->phys_vec);
> >       kfree(priv);
> >  }
> >
> > @@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci=
_core_device *vdev, u32 flags,
> >       if (ret)
> >               goto err_free_ranges;
> >
> > -     priv =3D kzalloc_obj(*priv);
> > +     priv =3D kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
> >       if (!priv) {
> >               ret =3D -ENOMEM;
> >               goto err_free_ranges;
> >       }
> > -     priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_r=
anges);
> > -     if (!priv->phys_vec) {
> > -             ret =3D -ENOMEM;
> > -             goto err_free_priv;
> > -     }
> >
> > -     priv->vdev =3D vdev;
> >       priv->nr_ranges =3D get_dma_buf.nr_ranges;
> > +     priv->vdev =3D vdev;
> >       priv->size =3D length;
> >       ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> >                                            get_dma_buf.region_index,
> >                                            priv->phys_vec, dma_ranges,
> >                                            priv->nr_ranges);
> >       if (ret)
> > -             goto err_free_phys;
> > +             goto err_free_priv;
> >
> >       kfree(dma_ranges);
> >       dma_ranges =3D NULL;
> >
> >       if (!vfio_device_try_get_registration(&vdev->vdev)) {
> >               ret =3D -ENODEV;
> > -             goto err_free_phys;
> > +             goto err_free_priv;
> >       }
> >
> >       exp_info.ops =3D &vfio_pci_dmabuf_ops;
> > @@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> >       dma_buf_put(priv->dmabuf);
> >  err_dev_put:
> >       vfio_device_put_registration(&vdev->vdev);
> > -err_free_phys:
> > -     kfree(priv->phys_vec);
> >  err_free_priv:
> >       kfree(priv);
> >  err_free_ranges:
>
