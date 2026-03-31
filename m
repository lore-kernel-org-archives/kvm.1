Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B31C860C;
	Tue, 31 Mar 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916610; cv=none; b=nWb2Wu7zKKJ1MCDwESPMud6GsMZa37g1w3x2IaOGjXQI9iH1zvasGbY4/DbdzPGidWcxZ0zD05Oe7XPK1UZre7eGcJefitAL/99bH9NcCbapGm3rb2TbGUbxQ8IhlM4cgOiwzrErN5tpKkkaXdcWR8IvyoeNrcgXXdvatKKb9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916610; c=relaxed/simple;
	bh=GCzVZzW/duwsjble9aoDXX1PUCepNmI4cXJTmfE2f4c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qCTOYbDbC37/qcdxSRj9Jpy8AjQVNkxnMfuJvqKipR0l8Jn92udxRwgZHK8QVBHfRGIsKDIrYlHlh7rNLGAkCKzvamG8fjEC4UuBhfzErQ1g3pVHb6mrUG6L8eoeVYk3S1AiYA7/JdM+RzZfRyIBR88HKeb3F+aY1hRWaIzQCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=B/puBoXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0u+dQVr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="B/puBoXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0u+dQVr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 297031400270;
	Mon, 30 Mar 2026 20:23:26 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 20:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774916606;
	 x=1775003006; bh=cWoDg1S5xG56Rd1oGlYnr5p4rgAcD9wjrqoTHNlBhfg=; b=
	B/puBoXS5cM5AJIvaLQazYUj4dU+LW9ELtN8WVR0pIFkkVq39Ku94XsT3dqTI4PC
	kX8S9ier4yfMxdPhUuqk7zQK8csOtldZMHq9GctUl+P5nChe4ALIxnuaGlYa4jxs
	Vz0HC6bEGD07u3M+FE+boghErN8uT3f1kVza3AtUvr7KNbk/bFRZZbkuN3y9zHoO
	9oJsByWDQL4vRmzkNGmRmCu4PcaI5GhestvOPF9DDjveinPnVr9C86rVG7lh3Eqd
	ZDhio7cUMCyUCrlfe1fqekkzY5+7X+dleVk423dDgNMQBUwIPMlnWss526D6GIIo
	J1bQ/VpVAeYYaOCFb2IHxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774916606; x=
	1775003006; bh=cWoDg1S5xG56Rd1oGlYnr5p4rgAcD9wjrqoTHNlBhfg=; b=V
	0u+dQVrvWOqc4Z4DWbHdT99ed7vFW2KvfDz9EGGIaqHUqa6e4V3tDi+82xyjbVPG
	I5y27GAF65bb57s2HifRDT7ZX9EYnYMBO2kCAkpJ3GsKXLopEE7nLAMxB5/o5lbj
	+doDJCaclsOSkLa9XLXfQbCMOgfuRBCEnEfMZNhBW/fF3ks3AqpzupXJPoEFsJbB
	VWKYdyrSszmA4d77AyD1L1pfyd145Tj2R6qROeisxtxs1nF204Uj8NbCPSoJnbcw
	y2Bj6QhiptyZAU6p2dKuBkACpoCi6jeE/OS3yWyT7gv0dYFWvwFVTVsZpmwGdwBK
	wSp+sMk2+xD2G7ABnPggw==
X-ME-Sender: <xms:_hPLaUZXkOooaKdGZqDSr6wDFXNP-obgu-0chKr8dw5o1ehMBmI42A>
    <xme:_hPLaaPg9JFIFCDd-ywucAFhBdZV3CEqKjHhnCdK_4T0quD-QC23iOpJzAJLT6wRU
    Sa2hk3rF6zuRjdZrDbjnJGBGS8zZcpj02vfuFpwPtiYCp6pAJxZiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlvgig
    ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeehffeuteehjedvleekieeggeefgfeuueejjeegkeefhedvueeugfej
    jefhheetjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdho
    rhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrohhsvghnphesghhmrghilhdrtghomhdprhgtphhtthhopehguhhsthgrvhhorghrshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhhrghruggvnhhinh
    hgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_hPLaVeplWVL0FT1k-5pu81AKOObq4rbj-og786NnK-obsvNuKazIA>
    <xmx:_hPLaSQ_etMJvWX58Cqdg1Oj4aToxYo5BmCzm_Vt196kqpS_FT4Bpg>
    <xmx:_hPLaUv4g-AlhohUHHJb6rvsz-9sYCdyV7Xi58D1O6HD2b9J_Ln9fQ>
    <xmx:_hPLabc3UY3AdFmRQ8UxMUvMSiKf06viMjMvtijpj4iliWgGbj7MpA>
    <xmx:_hPLaeKdvPmEu9ddgHKS1HFqdb1G-eYkoZMLA5QUIEoVkuC1qN9VJ1cl>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E784415C008C; Mon, 30 Mar 2026 20:23:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6P6aVCjxLYF
Date: Mon, 30 Mar 2026 18:23:05 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Rosen Penev" <rosenp@gmail.com>
Cc: kvm@vger.kernel.org, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>,
 "Leon Romanovsky" <leon@kernel.org>
Message-Id: <68be750c-694b-40ad-9818-809f80849795@app.fastmail.com>
In-Reply-To: 
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
References: <20260326023747.54485-1-rosenp@gmail.com>
 <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026, at 5:24 PM, Rosen Penev wrote:
> On Mon, Mar 30, 2026 at 4:16=E2=80=AFPM Alex Williamson <alex@shazbot.=
org> wrote:
>>
>> [Cc +Leon]
>>
>> On Wed, 25 Mar 2026 19:37:47 -0700
>> Rosen Penev <rosenp@gmail.com> wrote:
>>
>> > Simplify allocation by using a flexible array member and kzalloc_fl=
ex.
>> > Less memory management needed.
>> >
>> > Use __counted_by for extra runtime analysis. Move assignment to aft=
er
>> > allocation as required by __counted_by.
>>
>> I don't understand this statement, nr_ranges was previously set after
>> the allocation of phys_vec.  The only reordering was relative to
>> setting vdev, but that appears arbitrary.
> Yes that one. My understanding is __counted_by mandates immediate
> assignment after allocation. Otherwise UBSAN complains.
>>
>> In fact, we don't need to explicitly set the __counted_by variable at
>> all, kzalloc_flex() handles that.  So if anything, it's now redundant.
> Redundant with GCC`15 and above.

Sorry, this seems like a -2 on Rusty's manifesto of API design[1].  Why =
are we doing this?  We could do the math to do a single allocation and a=
dd the annotation for UBSAN without introducing this helper that's not o=
bvious how to use correctly and at best introduces a redundant counter i=
nitialization.  Thanks,

Alex

[1] https://gist.github.com/mjball/9cd028ac793ae8b351df1379f1e721f9

>>
>> Leon, any other comments?  This should have a v2 removing the
>> redundancy and fixing the commit log.
>>
>> NB. This will be a bit messy to merge since kref and completion exist=
 in
>> linux-next via drm, but maybe Linus will consolidate the hole in the
>> structure when he resolves it.  Thanks,
>>
>> Alex
>>
>> >
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> > ---
>> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
>> >  1 file changed, 5 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/=
vfio_pci_dmabuf.c
>> > index 3a803923141b..40e7e035a720 100644
>> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> > @@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
>> >       struct vfio_pci_core_device *vdev;
>> >       struct list_head dmabufs_elm;
>> >       size_t size;
>> > -     struct phys_vec *phys_vec;
>> >       struct p2pdma_provider *provider;
>> >       u32 nr_ranges;
>> >       struct kref kref;
>> >       struct completion comp;
>> >       u8 revoked : 1;
>> > +     struct phys_vec phys_vec[] __counted_by(nr_ranges);
>> >  };
>> >
>> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>> > @@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_b=
uf *dmabuf)
>> >               up_write(&priv->vdev->memory_lock);
>> >               vfio_device_put_registration(&priv->vdev->vdev);
>> >       }
>> > -     kfree(priv->phys_vec);
>> >       kfree(priv);
>> >  }
>> >
>> > @@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio=
_pci_core_device *vdev, u32 flags,
>> >       if (ret)
>> >               goto err_free_ranges;
>> >
>> > -     priv =3D kzalloc_obj(*priv);
>> > +     priv =3D kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
>> >       if (!priv) {
>> >               ret =3D -ENOMEM;
>> >               goto err_free_ranges;
>> >       }
>> > -     priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.=
nr_ranges);
>> > -     if (!priv->phys_vec) {
>> > -             ret =3D -ENOMEM;
>> > -             goto err_free_priv;
>> > -     }
>> >
>> > -     priv->vdev =3D vdev;
>> >       priv->nr_ranges =3D get_dma_buf.nr_ranges;
>> > +     priv->vdev =3D vdev;
>> >       priv->size =3D length;
>> >       ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
>> >                                            get_dma_buf.region_index,
>> >                                            priv->phys_vec, dma_rang=
es,
>> >                                            priv->nr_ranges);
>> >       if (ret)
>> > -             goto err_free_phys;
>> > +             goto err_free_priv;
>> >
>> >       kfree(dma_ranges);
>> >       dma_ranges =3D NULL;
>> >
>> >       if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> >               ret =3D -ENODEV;
>> > -             goto err_free_phys;
>> > +             goto err_free_priv;
>> >       }
>> >
>> >       exp_info.ops =3D &vfio_pci_dmabuf_ops;
>> > @@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_p=
ci_core_device *vdev, u32 flags,
>> >       dma_buf_put(priv->dmabuf);
>> >  err_dev_put:
>> >       vfio_device_put_registration(&vdev->vdev);
>> > -err_free_phys:
>> > -     kfree(priv->phys_vec);
>> >  err_free_priv:
>> >       kfree(priv);
>> >  err_free_ranges:
>>
