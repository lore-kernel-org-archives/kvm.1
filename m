Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9330BBB8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614862; cv=none; b=j+ZdMtIz+OD7D9jt4oClThliies3mntdAWip07Y/PSqBKFCGN83WcQO2eCMAEGM7ohREdpSlv5M1FsD2KJL99fJie8/inPHsbRsjTA/AO8jvu8WpPCI1+SMVTh2CHTviWMlcu87Kkcdutcf1Ioaw3dZtEPdOjA52AKPl1xu1jBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614862; c=relaxed/simple;
	bh=5y3PcmFRYqRP1NnGXJUwB0A0KdsvIgR/FJxx9aWTUsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTyJwpBNqQHlAmMSAGsukMU2b/6YAxDZnccHchfRTGDO2+TPj4GDNuW3WmsyL4QPkGZSIiiff4QXPI4+OC7RssWgmJ6pP1iP4dzBl9QbxjTsHeBb+ckH5ZKYsGDT30X8r/wqTOgm8fQAdR2JoehgHgPu26jchGzydfa7061qVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaElgTFt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjXZ3xoJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaElgTFt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjXZ3xoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780614860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
	b=YaElgTFtz5plumd3F9BmbQui7KnXRyEM2UVoXCdQoFTHSc9m+zaepTrAQKvMT3kaD24Mor
	I2vnA4BqOLh91Nif6LdX5DexXWqpkS0erhrPYj5xcbVv4JdXtMBiOWaKmuWEA63QdN1Ed9
	INLf5nlDDa8S+ac3z1/Ru38/LL20Wps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-eC5snsMqNJmWZQ0VdBQZlw-1; Thu, 04 Jun 2026 19:14:19 -0400
X-MC-Unique: eC5snsMqNJmWZQ0VdBQZlw-1
X-Mimecast-MFC-AGG-ID: eC5snsMqNJmWZQ0VdBQZlw_1780614858
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so752598f8f.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780614858; x=1781219658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
        b=VjXZ3xoJ+7gWk5xZ7MaEQIZs2AQEihJoTGtNlR329G+CyghMJ5Kz+UuOnM1hY3r4nh
         NXPRM4rmYQpBVNPxofnQFzuI/UJ2AF2Ug8nuxk+5I+6YeCp3026A39HElL8Rc/sXxX5Q
         /Y7G5NqFDEtFOOViULpsSKvGGNLXaI5qT3aP5EnSoOehtcbJue1YLgdvDaO9arOKteO+
         UUtQT2NxKFLSmvanssklYrhl/PtMIO682auIkFVYlJUlXEc8CyUeMtEA2H5JvNpOfxuN
         y/+J7wHUBCMZuGh0pw0mmpeW5IJW7LS/V51s5I0AFGmSYpvpylUIWHOcQMbq3X5nksLN
         XCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614858; x=1781219658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLGZz3723Aln9n0iz1W4fVsSKoXjcy4jTxlM5UdbXW0=;
        b=ic7GFjuVQFyXwYNLNgnKZrQbKRa9sEg+AxOH5VMy8n0iUnrBC/vT+0LeY4e+n+Vbfo
         w0Q2d/dJoq3p9SKuPc99+h7a3F8/cGO7YG7Kocy4UyOqiHpsBZIUBd64iz4KvxSR6jcI
         PwT3FlSqYlIVqGfUgjOYgP2vr15ChQDN9QyiuHy3VWFMqQLasxmRQkgB48dAhU+/nMWx
         tFCoqWt8m4FYJDYFPpVbOr+M6a2iHh64/oLbn9s2hzaFUXt9HKfwKicONbCrJRgDIM9O
         Ms6vaTmHNUAjqC06OfT9KHtsLlIdPXYYVwFx8quJRT2o1vbI26Se4Lnf+3zFaD6rZ6CL
         5Y5A==
X-Forwarded-Encrypted: i=1; AFNElJ9gEPTP6okJlqS23+zxxv+aiuyRMxSahxana1ppgYtx9WkPrNDLVA8mWvrQ5BfzJPMwv3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoqOpI0lEDVggtNAXiH05+9bqjBt7CZmIfJC9Sz/UpvGXX8GB
	KVmNU86AbpfKgDI51mleWBpSf5LgwMMPuPt/yfAmBYMDd09FxP4abhrzoaldqnytxiA8IcjsoOd
	jX70mK5YxYN41Tc6DQ138Yy3EQ075oLMhyL/rGjCE2ZZVH1rNlMbatA==
X-Gm-Gg: Acq92OHjq0BVzgA4V5DKCL1JT2I+dJbmdWF2LhYsyfagK2X+hOjb5neQIDLUkL98ARJ
	+g2R7MyJs6NkzQLOFm13cxDgwUKN9GIQMxqwckpm0IQu/ARorTiCJ6nI8wjQSvwDTE/0xWCEYe4
	Ry2aqV7qxJbBQdnKxkTv5ehUsvABW0AWmSmb4O1zsbB4iGbek0FbXmmxnukrTx4vc4wMEQwnkAP
	Yv6tkmSK1XauaMwPGIjKwQrbfeA1WGtGh6Z70dz3/eKWjYRQgaAarsSW7Uy5kPagppid7EU6gT+
	rsPMeCoEJIj2TCjs+VpJ8Qv49pJS2tI5LTN4UocSbzV7so4+UXhQiIpBHiQjxTfNt4PXF3aBFk+
	z9U6pVqU6uZH/jyIBzvRLUeURqE7Sp/Zax0M3hdfg4QEQWm4XIavyrEY=
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134273f8f.3.1780614858162;
        Thu, 04 Jun 2026 16:14:18 -0700 (PDT)
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id ffacd0b85a97d-460302dc4a8mr1134244f8f.3.1780614857676;
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm19910295f8f.3.2026.06.04.16.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:14:17 -0700 (PDT)
Date: Thu, 4 Jun 2026 19:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Qing Ming <a0yami@mailbox.org>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
Message-ID: <20260604191341-mutt-send-email-mst@kernel.org>
References: <20260601104300.197210-1-a0yami@mailbox.org>
 <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>

On Thu, Jun 04, 2026 at 12:55:49PM +0200, Paolo Abeni wrote:
> On 6/1/26 12:43 PM, Qing Ming wrote:
> > vhost-net initializes one ubuf_info per outstanding zerocopy TX
> > descriptor and hands it to the backend socket.  The networking stack may
> > then clone a zerocopy skb before all skb references are released.  For
> > example, batman-adv fragmentation reaches skb_split(), which calls
> > skb_zerocopy_clone() and increments the same ubuf_info refcount.
> > 
> > vhost_zerocopy_complete() currently treats every ubuf callback as a
> > completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> > descriptor completion state, and drops the vhost_net_ubuf_ref even when
> > the callback only releases a cloned skb reference.  A backend reset can
> > therefore wait for and free the vhost_net_ubuf_ref while another cloned
> > skb still carries the same ubuf_info.  A later completion then
> > dereferences the freed ubufs pointer.
> > 
> > KASAN reports the stale completion as:
> > 
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
> >   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
> >   vhost_zerocopy_complete
> >   skb_copy_ubufs
> >   __dev_forward_skb2
> >   veth_xmit
> > 
> > The freed object was allocated from vhost_net_ioctl() while setting the
> > backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> > removal, while delayed skb completion still reached
> > vhost_zerocopy_complete().
> > 
> > Honor the generic ubuf_info refcount before touching vhost state, and run
> > the vhost descriptor completion only for the final ubuf reference.  This
> > matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> > skbs.
> > 
> > Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> > Signed-off-by: Qing Ming <a0yami@mailbox.org>
> 
> The patch LGTM.
> 
> @Michael: to you want to take it via your tree?
> 
> /P


I wan't copied) Alright then.


