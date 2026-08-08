Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4563CCFB8
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185559; cv=none; b=gEsrnMe4DTVN48S0brZawCSF4eDwkJKAL10De4ZZlgYiQKLH18p6aMDLl2mY0XcrHhbFVcbuSJ+Utn7mNGpwp+MWkHLTecQpvrqEMpWW3LKWKMcHl1lTojhysetJmyYWkcfgGuUJGB66r/BJ2VUbixgjWDX8QchooJV1FZNPpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185559; c=relaxed/simple;
	bh=IsWbm760O9I15mA7fvW+rKkxvqhQsLCH30zSXYJ8nsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ2AeG43AS8TSnOu0vgEC+oSfKI008+FJw3MX59BM8CokyQgXtznMNBIJLdTtgrYGqcEmlEwhLZdcooWcYybXwMZ/Xsuylp4oxiBMJ15n4WQbLSgb1cjTdzRxHR3JfqR0bwViUw5t7JO0qvHHGo80itU8MpvBgqmwV3msRf8s4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlHWG023; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g25srq9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlHWG023";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g25srq9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786185557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8pmDKziJnJ1aHFZKG0c6hFog+fOESVRfbMD1dM6B7Y=;
	b=AlHWG023Y6wheF1uZyVNlIC01f/iI3Oai3AsERKclppoa5pbQN4mViGFgwXGwejtBCppmj
	3K11gNpI3eFIeMYYdo6B6ISXAfBlHhqlLx7gGp/pxRUmJ7/MUejxKcRpqke00Nn7N7Kra8
	ahmgdHhA9oqENVU1TmC5pcjMozjejjY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-plngrAT-NsahP4MW49LqaA-1; Sat, 08 Aug 2026 06:39:15 -0400
X-MC-Unique: plngrAT-NsahP4MW49LqaA-1
X-Mimecast-MFC-AGG-ID: plngrAT-NsahP4MW49LqaA_1786185554
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994aebe932so4453505e9.3
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786185554; x=1786790354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p8pmDKziJnJ1aHFZKG0c6hFog+fOESVRfbMD1dM6B7Y=;
        b=g25srq9JjA2SuPp7K2gCmAqiOqFJP1xtvr/ofMnUAJ+C+Ov12djkuyLJXTjDgcJ7rH
         NzxIhigkxkdmVZl2CSOFvmhDchddsCQKXUGDOyX+pzCzdjrMz6EXiVSjMYk+L62gO8V5
         g9yEqPrjMy2m0YnsJg7Ci6Mzpidv1162OIzCjicjDD4yexCa/mb/rOgX7FkI6NrefEOg
         kANWpVTaqHNgJ9EOJlkIc5vSqiyvlGlMYAhCJk/vwtNjMnJocROMYhjFfraptjzRweb+
         Se5O38pelNN37U51tbym682ScQWhRl519dMETlQpUOSp14iXfckW2xVDPXtrnlBLqVkv
         R35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786185554; x=1786790354;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8pmDKziJnJ1aHFZKG0c6hFog+fOESVRfbMD1dM6B7Y=;
        b=c1U6xuGmqtkTTn2XYM9QFGoAgBBQc3isRoC2wWTYhHrYNDNpQtKbECVU9JKmFGg1aU
         pmx3aG6EfIGLXkNVcZp0rndMMtl6AQqlSQzV5+gKsdD9L/G3+phuAJ84jc+itXPnF/V6
         wQDRynhG4QNn9AzBFFZ3ThRQaqOg76JUb8wWyMt7/sCFjIOTfQ7UCVdlUstvH49ZIEK8
         ct0WUzu4lLgilgozMiNLmFCJRWQF35S8QwzZbCNjN8bbUx3wtdy7qsUG15UmTWmq9t6r
         c688PZ7nur9GfwaRS9NeRB0BC8nrn8cfoixQwPMISKe2RMnENR6pwF56S6oqzgQ0OKCs
         y1+w==
X-Forwarded-Encrypted: i=1; AHgh+Rp0UNcKer8LFL4RqP7ikusQf++kh2xDFzybAgUYLa5TZeJeH9D4frq1nB9vViIiszcURDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1f7uO6/+dMTiMZInHs1Y/joIOvJMmra5ACwKZ1d9rElcbjDsc
	dWSz/BDrXoVnq8Kin3CvBJ796AfqXb/U+Cd2RnNmyihrch4nGzu+YvZbRFw1XBAnFZAtKcoqtQl
	cg7sIt+LkWUDzacW3o47h5dAtlrSBbcE/RyOqZjZFleRJjhy7Ad32Nw0kPKVInQ==
X-Gm-Gg: AR+sD12esQGrNr42auvXHumOp9wK/htbPGytCCp6RmiFiqrE98fyzJVNx1TUKZ2En7D
	p1zTkBtibPBYtMO2o/nsnIsdoavTQ5DVpsLPwea2onTjou/iqQGVzmqoKo/02uNCMp1FgVWQFXa
	odwhnYdmleWlBhWgyZ9D4LAKmMMQRO9/aCBoo7xKX1HmMOC+WHKO5BNDHGW3mF22GI2SYGwMTFp
	b/UUTtb7SDBMfgsBZ7LYbqJMxPdMYVUWvp42d5L9zFL/AVvoKUsH4qc+Mdf26Bfe8Bmc4MYug7X
	JrTxdujlaQXZAyB5OZsPz7yRI7xhFYJ4pgR30u/y5ZBdRFItuNR8RWerbY68dlO0vAa+h3dMHNn
	l4wxwgZvH/bfmG/VKqcLvPf9gy1WVwC8=
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4994e71c87bmr305222625e9.7.1786185554365;
        Sat, 08 Aug 2026 03:39:14 -0700 (PDT)
X-Received: by 2002:a05:600c:630c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4994e71c87bmr305222285e9.7.1786185553786;
        Sat, 08 Aug 2026 03:39:13 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2898sm99603235e9.4.2026.08.08.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:39:12 -0700 (PDT)
Date: Sat, 8 Aug 2026 06:39:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Message-ID: <20260808063901-mutt-send-email-mst@kernel.org>
References: <20260808103415.101261-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808103415.101261-1-physicalmtea@gmail.com>

On Sat, Aug 08, 2026 at 06:34:15PM +0800, Jia Jia wrote:
> vhost_vring_set_num() only requires a non-zero power-of-two that fits
> in 16 bits. vhost-vdpa then hands that value to the backend through
> set_vq_num() without comparing it to get_vq_num_max().
> 
> A local process with access to /dev/vhost-vdpa-* can therefore set a
> queue size larger than the device advertises. On the vdpa_sim backend,
> the worker then walks descriptors beyond the mapped descriptor ring.
> KASAN reports a 16-byte out-of-bounds read, corresponding to one
> vring_desc, in the vringh IOTLB path:
> 
>   BUG: KASAN: out-of-bounds in _copy_from_iter
>   Read of size 16
>   copy_from_iotlb
>   copydesc_iotlb
>   vringh_getdesc_iotlb
>   vdpasim_net_work
> 
> Check the requested size against get_vq_num_max() in
> vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
> -EINVAL when the request is too large.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")

sign off missing

> ---
>  drivers/vhost/vdpa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0..b2083e1ef150 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  				vhost_vdpa_unsetup_vq_irq(v, idx);
>  		}
>  		break;
> +	case VHOST_SET_VRING_NUM:
> +		/* Reject sizes above the max reported by the device. */
> +		if (copy_from_user(&s, argp, sizeof(s)))
> +			return -EFAULT;
> +		if (s.num > ops->get_vq_num_max(vdpa))
> +			return -EINVAL;
> +		break;
>  	}
>  
>  	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
> -- 
> 2.34.1

