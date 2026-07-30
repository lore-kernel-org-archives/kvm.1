Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB94119E0
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422941; cv=none; b=rzrIHkAMo6CVO19P0FXuI6Iv8wWqOAtp3ELQsT+4uG0rifQ8d3x+dk06MvVs0tvGPY0n82El7CYm8PjK+qPhqTAehtTV6IYEFb8uFz22+03bbDwEuDwdguVXoue7nZsIPLU6vb7H2+a8zspTEganyTKqdw3lf/j+i3DHcTVIFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422941; c=relaxed/simple;
	bh=xT+59zrSNXgZSX292AF0H2w7CA1Unv3yXaYCM8QYlXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1BHWbp02v0CAbSlZDpaNLtnRjYydY4/efhdL0ekTQH+/tNA6SjYibO38YiiJfyp95WDOmcxRUoQDEN+yPTxP301GpN0QpvMJgwIej68euqzF/reqHwA3qtoeYDm3z/8zVFPgaVJgw5FJwl7bevZbICLjeWVbNqP28vfsri0Ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDPQsKK2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OctUoOnr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDPQsKK2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OctUoOnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785422938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=icEaXTibKrUroRnU8otVcNfABM2uS6NaLhn91NMFBqw=;
	b=WDPQsKK2LeKdPU2iKUJDXXb0BSQaoFX2hRc/DnX4+cN6+LeZ+c6gePg7tGGQJdDqa0+5s4
	9CsAbCGOEwpNj+D6ClHvngkbLRIlj3ZlEpXm5hPWWfcsumX71sr8BXxbixMTC+gyG4dFUZ
	SDYdrcbY05ZWPfU64XTf/GsfKLGZXPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-3YbGWF7APMi2SeR-4_EkXw-1; Thu, 30 Jul 2026 10:48:56 -0400
X-MC-Unique: 3YbGWF7APMi2SeR-4_EkXw-1
X-Mimecast-MFC-AGG-ID: 3YbGWF7APMi2SeR-4_EkXw_1785422936
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so21712595e9.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785422936; x=1786027736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=icEaXTibKrUroRnU8otVcNfABM2uS6NaLhn91NMFBqw=;
        b=OctUoOnrT8TVtSyVuJ0wEblocLmQBlGPaPyY8OXbSc7Pji65mY4TdYucjAYSryzw2F
         +KAvcsyX3F9+uFNWTV380mt8ZNURImRseCNkGWrZZKOeFOS6pvDttUYcLI+gy4vgahQ3
         zlhA3EKWPmX7rdF2tBwu0sup0tvsKuKFiaYVbxi/Lz5YSzkJ99wOk5Jf+jmmuusiMi53
         MSO/ytUMUa76QG2HlATNEu25P8m5HFb3SmZswVbOS3/6XGfGQX8n9cw5oICary6N9Q8X
         XS3GC1z4qI1X3twpobbJa6siT6rnU3Qy6xQb4rmr0G50OMAfATkgJ3Glm+R2HZpR41H+
         QeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422936; x=1786027736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icEaXTibKrUroRnU8otVcNfABM2uS6NaLhn91NMFBqw=;
        b=e3GcW8iTOawWXBR4WYTrWiLC5Ia8tqBahyaCspWQW5pqG9sGGanXzktMp4rlUXBJuD
         qHC5ea2IsdtUOgvShyS/goBJBapnAPrGIKNi8lFgVvB1b83E6BMSs8Nr19FrCWd40bb/
         weJBHDxgHF71KN1BBy8isO54VNXDd0NviEB5pl7pvm4u8BEiKhs2LMpGR89FJxSqvItF
         yUcHRkYLvJ7lZRHfsNhh+y75QRqn+5sS12JRPDgiq/bFLFTIDFZRT3cv1tmyue0389EZ
         /uqPvAFaDwpGAaZ5yxu5RhMwBt2adcOwvpPYS2rKqjYgZwPd45jsPpJ1Kfve8GKc7CsG
         Xs0A==
X-Forwarded-Encrypted: i=1; AHgh+RrkUth+QxfDWjVxfszqhmQ+cR2c19QGGNMecmmcLM6GTOUudB7glU2XFcIMcnlmruDcMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaqFSEoSMGkcZii8haOioI6YVonKFf+fqEI82xPKbF0jjm9No
	3E8Q34sBuqX+gkFdKUjsxinBl5LUd3yDdFQ5bXUsR7ZUwxzrioP5Ms20FNVP67OMMU12gGbGM+l
	m2antgzEE46HDKsaSq4yvocZBZFzhsr/oFqw24ux+Eb4w+zCBU0zeNg==
X-Gm-Gg: AR+sD13xDJZVyOzUUG5IhP/gJTBrV81ezuK4s80hcCyxW7vazeb4aeu+Izmb+P5AzQ+
	FVdGIMiAnBxdb1XbRrbvn93S97qRsFg3/jngbOr32BHYWERi7rRcQQBF1hswnUcEojPMzTvkGXV
	nrLewBLNrQB0uQ+yjhVgwtBYYR05J7XJ8C3QArR9V6V1ZFe+drQIdxqc72yilINOK/pV0MxPBgm
	pCHtmOSLmLk+yxfCfQr6I5UGL2+e4yMFwmUdM73/lagMda7xDczVS/5HCTMDP/UWyGFzYscsuH8
	4arVopwPrlymXdj2d25Og/cOSByXoSVHvo8MWwaWimI+iDN78scZssNmuuEER/uhic1WKPxz0Kg
	Q4Q69kGg9pxAuNYkNEx6gzLo=
X-Received: by 2002:a05:600c:e557:10b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49800e898e4mr29774735e9.7.1785422935583;
        Thu, 30 Jul 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:10b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49800e898e4mr29774385e9.7.1785422935051;
        Thu, 30 Jul 2026 07:48:55 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm60785515e9.7.2026.07.30.07.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:48:54 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:48:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jia Jia <physicalmtea@gmail.com>, sgarzare@redhat.com,
	jasowang@gmail.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260730104811-mutt-send-email-mst@kernel.org>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
 <20260730135508.GC1442692@fedora>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730135508.GC1442692@fedora>

On Thu, Jul 30, 2026 at 09:55:08AM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2026 at 12:09:38PM +0800, Jia Jia wrote:
> > vhost_vsock_set_features() initializes dev->iotlb when
> > VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
> > when the feature is later cleared. The virtqueue still points at the
> > old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
> > vhost_get_vq_desc(), which translates them through that mapping.
> > 
> > A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
> > for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
> > memory table, and reuse the old HVA before submitting the same GPA
> > again. The feature state then says direct memory access is in use
> > while the TX path still uses the old IOTLB HVA.
> > 
> > Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
> > keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
> > enabled; VHOST_SET_FEATURES is used for runtime log updates and must
> > not discard the current translations by allocating an empty IOTLB.
> > 
> > Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vsock.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index ae01457ea2cd..57e8fd1eb670 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> >  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  {
> >  	struct vhost_virtqueue *vq;
> > +	int ret = -EFAULT;
> >  	int i;
> >  
> >  	if (features & ~VHOST_VSOCK_FEATURES)
> > @@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  		goto err;
> >  	}
> >  
> > -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> > +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> > +	    vsock->dev.iotlb) {
> > +		ret = -EBUSY;
> > +		goto err;
> > +	}
> 
> This prevents one problem but there are still other issues with how
> feature bit negotiation and the IOTLB are implemented:
> 
> 1. VIRTIO_F_ACCESS_PLATFORM is defined by the VIRTIO spec and must not
>    be change after feature bit negotiation. Please reject all feature
>    bit updates except VHOST_F_LOG_ALL to comply with the VIRTIO spec and
>    eliminate potential bugs in drivers/vhost/vsock.c.

Unfortunately, vhost does not expose the feature negotiation to the
kernel.


> 2. When the device is reset, the iotlb cannot be left initialized
>    because there is no guarantee that VIRTIO_F_ACCESS_PLATFORM will be
>    negotiated again.
> 
> > +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> > +	    !vsock->dev.iotlb) {
> >  		if (vhost_init_device_iotlb(&vsock->dev))
> >  			goto err;
> >  	}
> > @@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> >  
> >  err:
> >  	mutex_unlock(&vsock->dev.mutex);
> > -	return -EFAULT;
> > +	return ret;
> >  }
> >  
> >  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> > -- 
> > 2.34.1
> > 


