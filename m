Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABA3CF68A
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680978; cv=pass; b=VCNnDYAkeGXJZO/vlmrJ0O8DiN9jwkrZVtQkyNuUexWHeZneIG5qpNGi9ZVwyhpvRcIYXOHGB3VwdZA/OJAmXTpWjJ9X2p8xkyBKRwfco9aT1dATca10j0VzaRE0snfsESqh3S9eh81PS8rpLoU45z98AYPR1a1ht7T8UuGIN+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680978; c=relaxed/simple;
	bh=NNTfBBJ92pV51Q9pBimiCqTRiAqNEv5Iq9TZRM69uyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnV7wvOiYqz+hkkt7LR7mpeigTT3V68XKuFL/WcN1ANLXcBkX3XANMT7dSX0laI15dqIRGSzoQJ97woA7xbnK89qEDEEMRl2EYc4UMa0gRqZCukBiJBvq9DCP6KCxBw+R8wuj4wUuDBA+e/DjvTn3XLQ41rkGakA67XBZRCPNUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4J/xobT; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4J/xobT"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12fbbd9d2so7509428e87.3
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 10:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773680976; cv=none;
        d=google.com; s=arc-20240605;
        b=K8fr/26uaECq1VT7OrC4v70Icv4075KWHzmHdllngj6/+Z6haCf1/LmV65OtOdBkpG
         VJiEFphAyJXvzIXM5PqNAYSBA4M8khjN33atFYFdb+DPIfY141y/gkZhkIqsCSV0b2pV
         DXF55CahaYzeRkGr1/nuwJCixJocU79aA0ME+A6TPoVjxFNTfrsWjPttSV/s/pRMSDk/
         FBzE32gN9u2PKANNFWUdiVKVhLR5F2/TPmVDGus0Tbgy8hV3xDxmTGrrsRW8Sruh8cgX
         SKw/fkhB2zCoCz9N53ncb9Q/PXOKGIY2nhqYId6m6g3gvqvY1EhP6y3vk5ZO6+Qo9NpZ
         CpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        fh=9UEtqEVYE5i+Oo5gyzXKHdGir/OAK216w96OXSxQxdg=;
        b=goeCFuMUu+V/CuyjMKkac2/KUl7PHRac4XCUwD5bjDelNAwMvtpluj5kn/qcV+OnFd
         ii+YreNLp5TBZHfW9E2e6cxYDh6YgSaLGqUjgEHNXOnZvKqf3s9mKzOsATKi1E9/X8n0
         OUZvo6c4DNpPo6jW2ZO85E3PiwYLLYK/8fRieQeZUTN3MiMV7XZDz604y8FnqOSDBFVR
         Ej0GPGqRgpdhoZ3zbT3mixD7lXPgYq5DotgHkXyoGXkpXne08LCA2c+WodVKAZ8882jT
         l7j0m7Lff6C1vqMb1Mr4TDtppqqj7iRvGdF7bQIMklAYXa3O1DMGrfvP5pxcc1d9MvBw
         OWqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773680976; x=1774285776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=o4J/xobTqd61lsctsq1Mp5DIFrv6bPcSemwW0YkargjsE1WDYYBUULHlKBMCDgKPtj
         5fhMwNYHxYqciVnh8PL2wMKPEoV96+hIy8NDYDzoZl+GhXvBaH/QuNo/rcXK2s/Ayfbv
         PKomlm9ztOHqo123bsT3x7R2n3tg29nr6V7XHLhbLlHHTpmNcCqu8sdyA+7OFaPD0BUf
         cFbnfgnrEHYKTjk575MTqX76oiNSSki8NSgASzqPoYMRwxGt0I7bZayK2J5a8eiU411c
         VBPbrjTqsBo1uDOIE2Uyl/MB2SLTYmlNXZiCXfEbLpMh9ZB6OaWxgNkwvT9frHFEwRkb
         67PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680976; x=1774285776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+JmK53GRb51WN1NqYAYXjEI124SxFiHPFttdlfjYpg=;
        b=O7MxVr6CKUs4SLqNn8aCdU5A9pB0AMXUKLpxjLp6s66IxUMPhWDh/+muzEDm2q1/YY
         /9+kw2aqw9ofGeIhbYVXffvHRng/lGlm0Hxl6A4dVJ/hzjmN9iZfWZ6FaKk45g8KzshQ
         +4+F8tIZNqRwHVy3FWhbqWNkpii5Uw5VAJz6mYJNTwZM63jrBbuINpCsGVJ68TNo25G3
         F70IGuWPK2Qg3GVXgkuFwaF4lO0eta3YACBJU2k1TDOtm1FQ+yZfkHJwQOMgzcZ/F7nP
         eRaxwJH8rynEhemTyRqf5/MociCzqUf2NEDA4a9nBjXkyRuAggGuxcLPn0teeS8cNAB/
         WdVA==
X-Forwarded-Encrypted: i=1; AJvYcCXUhR15+WSxVs8aSu3Owoo2TXMGfOcQ/qFbbLHWG7WzGTYlOFVY7GftN4WRTs0xWkhpHC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqASC0UQo+0L4R3Lp4ZzxUBbwrYv/sPzCL7OcT1rG76A/NR8bB
	bbfQioOJIogtrP4tNbCWgZmVOiOGpaPa6KVmurLCHjIQaijWV5YCU2Re9ATyy+dH4EDxQQEVeQ6
	vg8MKzzKL32VXVwbsr54ZWQ/fNi0OM6leqAZgqF2f
X-Gm-Gg: ATEYQzzNmkFF/hPV3apAVqK/DI8KiHIRxZTUheQgjR+ACI27nIMkWmeiYYF5rbAgRHV
	qBej+9FdQkBPOfqBYH52a6WYcqbql6ms2EMmigPGv56uOsDwNfbUBkMlV9RDBXTXpaaAqS57H6c
	UCvtxZzw881FIl4KzHyRafmSkhH8Cubn9v1F21TF0cm/Sw2pjHA44YqRBqC4qGGfjtGZBu3oMVg
	aKS1qVkD6ggEvXHcCXix+7f3boEagMwHma7pv3oe8F+lxaGM+MM5zXP3nvFZyDwkRpvbPymcUmT
	55kx9Pab
X-Received: by 2002:a05:6512:64e2:b0:59f:6a2e:49e4 with SMTP id
 2adb3069b0e04-5a1626fb8abmr3594350e87.7.1773680975067; Mon, 16 Mar 2026
 10:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260314061747.GD4177610.vipinsh@google.com>
In-Reply-To: <20260314061747.GD4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:07 -0700
X-Gm-Features: AaiRm52NY6sLPHJr9Fl_13O_4mOB8Cua734qhyhURDdG8FlJ-PNRJ5f7ttW8G5g
Message-ID: <CALzav=cQQny8AXzewtSe2pM-Z20+K9UbTcNBiy6SC4PUzR3sng@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:03=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/=
vfio_pci_liveupdate.c
> > @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_li=
veupdate_fh =3D {
> >
> >  int __init vfio_pci_liveupdate_init(void)
> >  {
> > +     int ret;
> > +
> >       if (!liveupdate_enabled())
> >               return 0;
> >
> > -     return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +     ret =3D liveupdate_register_file_handler(&vfio_pci_liveupdate_fh)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);
>
> May be we should rename pci_liveupdate_register_fh() to something like
> pci_register_to_liveupdate_flb(). In the current way, it is confusing to
> why same handler is getting registered at two places.
>
> Above name will also make it similar to IOMMU series as well
>   https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.co=
m/

Will do.
