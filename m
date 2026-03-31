Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA4256C6C;
	Tue, 31 Mar 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933874; cv=none; b=a+vqLJ4MaziHRv816YLMcjs1BhJvztBgut8JcQcp1uSPKOjI1QVFLsk/Asja/uwdVZsZ2dFCC2reCd0AZKBaqM/MVfR5WpGFH7qkl8ATU9ddYWbX7AIu0cCNJFNMPf8UnveGxwhCSBy5elGd8o4tyuJ5y66neZtN8pKhkvMtSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933874; c=relaxed/simple;
	bh=qgwGjSndI7dIefRX9sQjFUQoAk0IrScVdd35+gJU8sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urNwSE/Uv9Z7Vr3Jdyey2IfPqN3m6lrOqYAetreUvJDKW8saPK7/wNXT81hzfR50m5AUJxV37x2zgiB5Cgae2rzmGscQB1nPYhdV+HWswDAk7vTjfSTZv8eulkOoofTM5Ca+NxVWZNqMwsRjVYnIqP3tJvlnAsaAvEr+sO11Iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2No6rJz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2No6rJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170BC19423;
	Tue, 31 Mar 2026 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774933873;
	bh=qgwGjSndI7dIefRX9sQjFUQoAk0IrScVdd35+gJU8sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2No6rJzRsar/Awuif++9FOunv81fRGhhWzTTye52bshVpLWDahwf0Q+UPa7ehVUN
	 CNWOb49A5f2F+S1lBfsWDwUlUJsgS319a+AvWayg1NHINTzppW7LA6ibEv94wp1STZ
	 nbK/gYYEayDP+FqK6/NauZqk9XLNVLvb4904T9pTFK3zOuTWApBvVL8fkhmv383fdb
	 hQyIa6bE2iHAxOtZLDVM3QANyKjUZJY6uWqel71wOTsjCYyt04CjwDN5Qg+ASAGqRx
	 mzctmt1endF6KcjYY8fPBTUXZrYl5kYKT5+IDVjOaXqiwDNnmc7ef0PhfOk2tSqym9
	 eu5DAV7ZJP20Q==
Date: Tue, 31 Mar 2026 08:11:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Rosen Penev <rosenp@gmail.com>, kvm@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
Message-ID: <20260331051108.GY814676@unreal>
References: <20260326023747.54485-1-rosenp@gmail.com>
 <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
 <68be750c-694b-40ad-9818-809f80849795@app.fastmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68be750c-694b-40ad-9818-809f80849795@app.fastmail.com>

On Mon, Mar 30, 2026 at 06:23:05PM -0600, Alex Williamson wrote:
> On Mon, Mar 30, 2026, at 5:24 PM, Rosen Penev wrote:
> > On Mon, Mar 30, 2026 at 4:16 PM Alex Williamson <alex@shazbot.org> wrote:
> >>
> >> [Cc +Leon]
> >>
> >> On Wed, 25 Mar 2026 19:37:47 -0700
> >> Rosen Penev <rosenp@gmail.com> wrote:
> >>
> >> > Simplify allocation by using a flexible array member and kzalloc_flex.
> >> > Less memory management needed.
> >> >
> >> > Use __counted_by for extra runtime analysis. Move assignment to after
> >> > allocation as required by __counted_by.
> >>
> >> I don't understand this statement, nr_ranges was previously set after
> >> the allocation of phys_vec.  The only reordering was relative to
> >> setting vdev, but that appears arbitrary.
> > Yes that one. My understanding is __counted_by mandates immediate
> > assignment after allocation. Otherwise UBSAN complains.
> >>
> >> In fact, we don't need to explicitly set the __counted_by variable at
> >> all, kzalloc_flex() handles that.  So if anything, it's now redundant.
> > Redundant with GCC`15 and above.
> 
> Sorry, this seems like a -2 on Rusty's manifesto of API design[1].  Why are we doing this?  We could do the math to do a single allocation and add the annotation for UBSAN without introducing this helper that's not obvious how to use correctly and at best introduces a redundant counter initialization.  Thanks,

My comment is that we can simply drop this patch. It adds no value and only
creates unnecessary churn.

Thanks

> 
> Alex
> 
> [1] https://gist.github.com/mjball/9cd028ac793ae8b351df1379f1e721f9
> 
> >>
> >> Leon, any other comments?  This should have a v2 removing the
> >> redundancy and fixing the commit log.
> >>
> >> NB. This will be a bit messy to merge since kref and completion exist in
> >> linux-next via drm, but maybe Linus will consolidate the hole in the
> >> structure when he resolves it.  Thanks,
> >>
> >> Alex
> >>
> >> >
> >> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> > ---
> >> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
> >> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >> >
> >> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> > index 3a803923141b..40e7e035a720 100644
> >> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >> > @@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
> >> >       struct vfio_pci_core_device *vdev;
> >> >       struct list_head dmabufs_elm;
> >> >       size_t size;
> >> > -     struct phys_vec *phys_vec;
> >> >       struct p2pdma_provider *provider;
> >> >       u32 nr_ranges;
> >> >       struct kref kref;
> >> >       struct completion comp;
> >> >       u8 revoked : 1;
> >> > +     struct phys_vec phys_vec[] __counted_by(nr_ranges);
> >> >  };
> >> >
> >> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> >> > @@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >> >               up_write(&priv->vdev->memory_lock);
> >> >               vfio_device_put_registration(&priv->vdev->vdev);
> >> >       }
> >> > -     kfree(priv->phys_vec);
> >> >       kfree(priv);
> >> >  }
> >> >
> >> > @@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >> >       if (ret)
> >> >               goto err_free_ranges;
> >> >
> >> > -     priv = kzalloc_obj(*priv);
> >> > +     priv = kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
> >> >       if (!priv) {
> >> >               ret = -ENOMEM;
> >> >               goto err_free_ranges;
> >> >       }
> >> > -     priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
> >> > -     if (!priv->phys_vec) {
> >> > -             ret = -ENOMEM;
> >> > -             goto err_free_priv;
> >> > -     }
> >> >
> >> > -     priv->vdev = vdev;
> >> >       priv->nr_ranges = get_dma_buf.nr_ranges;
> >> > +     priv->vdev = vdev;
> >> >       priv->size = length;
> >> >       ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> >> >                                            get_dma_buf.region_index,
> >> >                                            priv->phys_vec, dma_ranges,
> >> >                                            priv->nr_ranges);
> >> >       if (ret)
> >> > -             goto err_free_phys;
> >> > +             goto err_free_priv;
> >> >
> >> >       kfree(dma_ranges);
> >> >       dma_ranges = NULL;
> >> >
> >> >       if (!vfio_device_try_get_registration(&vdev->vdev)) {
> >> >               ret = -ENODEV;
> >> > -             goto err_free_phys;
> >> > +             goto err_free_priv;
> >> >       }
> >> >
> >> >       exp_info.ops = &vfio_pci_dmabuf_ops;
> >> > @@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >> >       dma_buf_put(priv->dmabuf);
> >> >  err_dev_put:
> >> >       vfio_device_put_registration(&vdev->vdev);
> >> > -err_free_phys:
> >> > -     kfree(priv->phys_vec);
> >> >  err_free_priv:
> >> >       kfree(priv);
> >> >  err_free_ranges:
> >>
