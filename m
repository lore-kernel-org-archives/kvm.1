Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873002931E9
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813540; cv=none; b=CquSDzRfEL03mGtvxSJDOVy66Xal1evaAWEaeyCaae26qkI80In12WjP4TJFlWF/2UlbudObnOHT1vvEMlBHFo2y0304CnWhys8OPUpuvuWRoeVppCKQZ6oaoVFjkcVgzYfLKAZeztg/6VtXUmPBsARSW71QW/WVyuis6lnQM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813540; c=relaxed/simple;
	bh=vjexPMXz+uHstAFBD5kC8PIMoFh7FLyMaZtlnqi/L7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hev4g1XGilgv60zkh66HNr6nVS21YXmGgFBZ3MdlciTH1UQqQ8diSUZshI+P6UQa3eVDkNOHNRYfqFX+45xZ83i6WgkFyakDXuJtGkG33xJ99RVP0DTBkBNKEL+Vnj05UgwusRd0CViXkFL7WABQJdnbY4OzBA5106IzACltgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOsmrTl0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SoJi61Lv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOsmrTl0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoJi61Lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hn89OAtGF04fL1DOEPjseXWeO4u1I3kemB7CwT2Ey+4=;
	b=WOsmrTl0WPEYOFPXeNljOcoJoRUC4RfI3uHlEBrEHkt1DiNdxBxtfXtbbsJED3LveS2Kz/
	9vozBWMnJxCWerxFuy0Cq8xSmLck86C3emQbHWCvrg+c3UOCUn0LJo3wNkJO8Qdxac3xVf
	kjDA205eNy6LAzx3wOe8JOsTsPKcgog=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-0LBPHVr-MVGmzSDrZMVZqw-1; Mon, 03 Aug 2026 23:18:56 -0400
X-MC-Unique: 0LBPHVr-MVGmzSDrZMVZqw-1
X-Mimecast-MFC-AGG-ID: 0LBPHVr-MVGmzSDrZMVZqw_1785813535
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e70c286ecso4125034a12.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 20:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785813535; x=1786418335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hn89OAtGF04fL1DOEPjseXWeO4u1I3kemB7CwT2Ey+4=;
        b=SoJi61LvmxaY1ZnjLpuYCCCeAGIxGAM6ju29CT3EVUQsoPGKnoG5xs4+OqUdIgLRXg
         E3nLwPS7VnC1DZEZGNEPG/7RDfxVzF3GEZTxwv/hvSI2xQCITE2ptnWKQTfRcQgDF2W3
         TUl4ioE8NtKhG54asndOr2IX5eRpqBICV3RjM1pcxCx3GhMO+4dAh29JevvvciPxQs68
         QXucKMsj3Uc36kdMVcl9xKIY5+YmFrU2Vcnn4j1rZvl5BOeYAPsNeFQ12O55/p3oCQrb
         SlNcOFvDVqa8poymyLbc2yd8h+pGIgrOR9GYDGTYXGm+wSEDOM/c+KzQpoNboiWtk0Dm
         5DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813535; x=1786418335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn89OAtGF04fL1DOEPjseXWeO4u1I3kemB7CwT2Ey+4=;
        b=KTZO2A4CqIk7zWIEyJnjiaOfKxsjM06hZdKWpwhpzz1/GAa7CYTVHC+jtMbuv/11tY
         2374mfIsc4ks5I/X/MfOql9PPB7c3PAZoDMp1DwM3dhK9xcCsyfPnyW2KZuPGzZOEgQZ
         pfLngNWARHkHWSo6j4M1eCUGqCL814HyWmjOxRQQflT4QMY/iCLNOYeiLpOJ+pXCv9rq
         goAMfyaKBV+20oZEArYEV9BCryrGjme5yql4uvDUd7sAkWvKETq6gabuvx+vKz1//5ki
         FhC3Cs1AMvWuGv4fNKwhgWWmB8GeAIcpHtTc+J30camxfaPAeT3/C5b8kZaxKCx2FUvo
         y3PQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUUEQeWmWFoJmxw5wPRJR7E+nWSabKGYkqSeHVjQcwCQ0dl552idGqlEDW3haP/1+8eEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3EI4/NCF9gmT2r5vFEu3dr3bYgv+LM6PospUtKt0Cv0a7wPb
	p4Ay1T1SH6tRqeAQEd4sAsdqGODhZLvDdPCVDoLJAkIYVvsjW+3/Dhvpl5BwGgx50aC7dEEmSY3
	9HgeiHwJB/gJnNp1XyxX9PnysoxUZROqcoy3Nngm2vdY+rue6k16O1w==
X-Gm-Gg: AR+sD11qxNVdL0bw1TALkh+f99i2Yk/fsSVC4wdRTx5uGY2Pgu/958DhQIElTHsAFFB
	5L0X1DB5slNlIaGGm1ShPPIXJ4dztmdPPGm81Sg4u679lakUh77pT9FpdEOh3qsgqFPNOisUnw3
	gPFSatOhIQYD4KrliHFLFKL6NgMq29syE+TsgnAwcvr9th7oXpACVdy1lY/G1ULWP7WJ7iAPVaV
	S9+MXtoulneiCrLACFdFCaro73c6u8YG9B8vFywKTUxOUcdOFCYi0HqscbBpURVOpLfU/De3qMX
	VQJN+4Tr+y+5ksF94RGJR4aUHgxqEpLkx/Hy9kS8Ye02MdZld8uzkPToKDRMRFBJ/TCJ
X-Received: by 2002:a05:6402:42c8:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a12400bf12mr1998130a12.10.1785813534915;
        Mon, 03 Aug 2026 20:18:54 -0700 (PDT)
X-Received: by 2002:a05:6402:42c8:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a12400bf12mr1998100a12.10.1785813534402;
        Mon, 03 Aug 2026 20:18:54 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a09acsm5960120a12.4.2026.08.03.20.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:18:53 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:18:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <20260803231405-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731103414.1746316-2-physicalmtea@gmail.com>

On Fri, Jul 31, 2026 at 06:34:13PM +0800, Jia Jia wrote:
> vhost_vsock_set_features() leaves the device IOTLB attached when
> userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
> continue to use translations installed before the feature change,
> including HVAs made stale by a later memory table update.
> 
> Detach the IOTLB before acknowledging a feature mask without
> ACCESS_PLATFORM. Hold all virtqueue mutexes in index order while clearing
> the device and virtqueue IOTLB pointers, resetting metadata caches, and
> updating the acknowledged features. This prevents a kick handler from
> observing a mixed translation state.
> 
> Free the old IOTLB after releasing the virtqueue mutexes. Also drop
> the old IOTLB miss messages and wake readers now that the device no
> longer accepts IOTLB updates.
> 
> Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8061..562b9e139a76 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -851,6 +851,34 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>  	return 0;
>  }
>  
> +/* Caller must hold the device mutex. */
> +static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
> +{
> +	struct vhost_iotlb *iotlb;
> +	struct vhost_virtqueue *vq;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> +		mutex_lock_nested(&vsock->vqs[i].mutex, i);
> +
> +	iotlb = vsock->dev.iotlb;
> +	vsock->dev.iotlb = NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> +		vq = &vsock->vqs[i];
> +		vq->iotlb = NULL;
> +		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
> +		vq->acked_features = features;
> +	}
> +
> +	for (i = ARRAY_SIZE(vsock->vqs); i-- > 0;)
> +		mutex_unlock(&vsock->vqs[i].mutex);

Why lock down all vqs like this?  Would this work just as well instead?

	iotlb = vsock->dev.iotlb;
	vsock->dev.iotlb = NULL;

	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
		mutex_lock(&vsock->vqs[i].mutex);
		vq = &vsock->vqs[i];
		vq->iotlb = NULL;
		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
		vq->acked_features = features;
		mutex_unlock(&vsock->vqs[i].mutex);
	}

and if no why not?


> +	vhost_clear_msg(&vsock->dev);
> +	vhost_iotlb_free(iotlb);
> +	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
> +}
> +
>  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  {
>  	struct vhost_virtqueue *vq;
> @@ -872,11 +900,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  
>  	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>  
> -	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> -		vq = &vsock->vqs[i];
> -		mutex_lock(&vq->mutex);
> -		vq->acked_features = features;
> -		mutex_unlock(&vq->mutex);
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		vhost_vsock_clear_iotlb(vsock, features);
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> +			vq = &vsock->vqs[i];
> +			mutex_lock(&vq->mutex);
> +			vq->acked_features = features;
> +			mutex_unlock(&vq->mutex);
> +		}
>  	}
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
> -- 
> 2.34.1

