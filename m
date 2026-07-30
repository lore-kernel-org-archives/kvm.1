Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291E43D502
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423086; cv=none; b=RViIyo5WagE+Ics6Z37kfiD5ClUgk6BLHtRwmKH61IdAHZVmjRKG9g/JN6Nvq/XY4X3oKVOnlM7ew083mxej+cp9OKr+xBOmr72+n2Br4vzSq1iqFn2zY+STucvmRphUo3UVtkaSjh6cbSE+zy+vNcveXGJmWY0DQDGQ01Ms+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423086; c=relaxed/simple;
	bh=tUIAFR2ZSygyso4Eb9U1hdNssTpLdhR2q00ylJ7K4MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odnv2MEGzDv9BYQ7kgONWxqNd7PgLxf1I8oUWf4MhClIuBqR+Xpv/hC7kj8PxqzPEbaOsXh/Rl7oelmVlgVV1j3/IRQGsgGpsRLaZy/UHrClJCrgpLlHviQDCUUMQN3Efy8jrrOXDTTfgqaPvxBQqRdXWl7Fg/sIdsAwzZ2Jn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY6KofLp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdiRQ6lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY6KofLp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdiRQ6lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785423083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3zt6XkOgWd+IfIfzdQFphbvcN6LQXkbPFo9WHWQNv0=;
	b=WY6KofLpRDR1rf/iBSrEBroWJLYlULtB28Ph7zNkXj074Y7QQ1R/3BHomKJQfTIOeQ2CMJ
	7jJF0RYOG1BZZcyz+6yOe1btTaY8+ZybjnzCP0k//8e/4riyV27lHiFhqCEkq1MyVZXIrK
	cHl/SrfebNcEnQJjj6Uj5AtaeCvWtxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-wrX7vVqOPfi2z2adly4LuA-1; Thu, 30 Jul 2026 10:51:21 -0400
X-MC-Unique: wrX7vVqOPfi2z2adly4LuA-1
X-Mimecast-MFC-AGG-ID: wrX7vVqOPfi2z2adly4LuA_1785423079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso15623795e9.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785423079; x=1786027879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3zt6XkOgWd+IfIfzdQFphbvcN6LQXkbPFo9WHWQNv0=;
        b=KdiRQ6lcXWxsY7Gbj2oPTjwup8NolxFNkYijXjDqI6Rzhto8HyJz1ZS//siSqVgAbT
         HvNsEhlv3at2SPFk3nhMESX8ZJ8TEE7sxgCwvGM26vevgOQ+QidO28QI4oklyDPaFRlL
         avUnI65oJWRYL6kKW0K3UCbNQ7jSet0PqVA56Gsd2T9eP7LSrLibgxWmIcai2JGn4GhR
         HlyQdpyYYg7+UKpjkT70itMcw4ZskD/m/OSYC8RJ7CAzlZaNqBgW0J5ZwITjJ18DV7Ll
         aH3NKB7uNYhf9LoX/6CiEfOi/hvJkOeigk9eW8oMSAEIgNXlTwuWBRa2e5WE0skTXKaY
         JHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423079; x=1786027879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3zt6XkOgWd+IfIfzdQFphbvcN6LQXkbPFo9WHWQNv0=;
        b=EwEk2oOLXRPBf03Sl4IOrw0V10d7ERpgsCnvyaikdj8/o9nXRQn34y6zeIcjzYxLRc
         g2k0b25DQytGHcDrzMzdyjLERT+GjxFU8ZcI4YeaBjm0jjL1JB/QHgHtbqtRwcu+Sl6J
         jIU6RXk5/8xT1CLvb+A4VUEAh8IMt4GthdOk8mXZobyuwijP/M71pmqueAF+PhRHhpTf
         ReRn7U3A3RfF5yj2avavgpuDVXSeJReN1DpkMIsZWoqrjRVSL3GXyvRqaBP6NzuTCrak
         GLsEErtPvi96GVxFVtzq9mIL1j0dpN8fyOcBhuobNx58xTG/TNGhON843cYIBGMNoZ0h
         e4dg==
X-Forwarded-Encrypted: i=1; AHgh+RqBuScu5OyKnvTiELsiKxNNxOF2QHt0nA3T8VUabrBIdXMZhhTKXDN9mF+598ldVo27xqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhibXVKFWlchWioJH6daiDzoTdVmiFvT8khpUbsUjtgDr4hVus
	mtSdYqmD38siuZ7xBMeVzEAv4NtQavTX3dMzI9mhobqftb3fBTSzDvGnht87NqPiz+QzBe9wwAI
	SbbqrCU4n2uV6H6i1D78w5AdbiShZBOYHdvmqHUO5QXk2JTCcvo839KdoLDXVAyQa
X-Gm-Gg: AR+sD122lG+gFucy073oGbsoF2K/m1/5hhb4anCENHI+smJ/JgcLyGu558CX3pfEGiJ
	3lTJ9xPQlmd4GdpIPYnd6/CdXdFB4bd5ZeyH5EBhE0gbrD2WXENMG/0myKxLJdUi+CdVQoIZnBg
	zZ2crpw6KZgv0D2KLgglF62N7QDAo6/kzTf+SDVfFY9yvVf76KeXqhuBGDDuwMvEaYylWnT37sr
	e25fN0CTIPLMwXtnwtLIG3Yl8o4i0hk80R2UTWXrkKSHuc452P9D5sDLaMWqhEmRLU/OLt2OU3O
	kFHeelIKe23+C83Tkd7CSHUADUQGNgB9pkyogw3LLQfEORa9fuKnJ58hfmIY8I+aZ1Nlu1Dm1Xm
	s0VtKdk3Po3j3pima5/dBnww=
X-Received: by 2002:a05:600d:8444:20b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-49800ebd355mr30260715e9.30.1785423079331;
        Thu, 30 Jul 2026 07:51:19 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-49800ebd355mr30260275e9.30.1785423078800;
        Thu, 30 Jul 2026 07:51:18 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f2b45sm65069295e9.4.2026.07.30.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:51:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:51:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, jasowang@gmail.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730040938.1725757-1-physicalmtea@gmail.com>

On Thu, Jul 30, 2026 at 12:09:38PM +0800, Jia Jia wrote:
> vhost_vsock_set_features() initializes dev->iotlb when
> VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
> when the feature is later cleared. The virtqueue still points at the
> old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
> vhost_get_vq_desc(), which translates them through that mapping.
> 
> A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
> for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
> memory table, and reuse the old HVA before submitting the same GPA
> again. The feature state then says direct memory access is in use
> while the TX path still uses the old IOTLB HVA.
> 
> Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
> keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
> enabled; VHOST_SET_FEATURES is used for runtime log updates and must
> not discard the current translations by allocating an empty IOTLB.
> 
> Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Thanks for the patch! yet something to improve:

> ---
>  drivers/vhost/vsock.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ae01457ea2cd..57e8fd1eb670 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  {
>  	struct vhost_virtqueue *vq;
> +	int ret = -EFAULT;
>  	int i;
>  
>  	if (features & ~VHOST_VSOCK_FEATURES)
> @@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  		goto err;
>  	}
>  
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		ret = -EBUSY;
> +		goto err;
> +	}


I don't know if this will break anything. Why not just blow
out the iotlb? kernel will rebuild it if it needs it afterwards
for some reason.



> +
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}


This part you are fixing is harmless. Let's make it a separate patch
and document the motivation.

> @@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  
>  err:
>  	mutex_unlock(&vsock->dev.mutex);
> -	return -EFAULT;
> +	return ret;
>  }
>  
>  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> -- 
> 2.34.1

