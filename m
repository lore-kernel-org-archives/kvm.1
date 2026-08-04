Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16819A288
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813658; cv=none; b=MT5H8LY3K788vhcs3Qi0iK+HmoxNqxsTUGV1FE2q2g+3l5YI9QQhQWFcAgH6dAjRRvKP8q7Qrrug248O87oj9iHBJXNX1mH+3pIIWMUBYBR5Jr95pZhq8Ma63g2wk6V7+9Tt/cIsDbToGuXMb2nrmA5ko3vZePEcxpIVrmGQF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813658; c=relaxed/simple;
	bh=tqZLOsTLaD2Vkl2fHPJf5w3iLf3P6mTDx2svcOIN6lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmdBHgLG/0RiRwkCr9Nu6gZoi1kVmEIIuKdX2mt7632oz03H8ILO3MOsvdYlLzfMnMnSUDz06o1YUMgDrLXwBsWHguPvLdO+pNECgPllqiBqpTuwdg9hNMmFcMM0705iicaQlqiXl405AC/xcuLutKaj9aMtjZhA2Tk/FHWQ2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EtkyuhFG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q8MqVcco; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtkyuhFG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q8MqVcco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=En8P5t+/b7u5WFGgCY07au7/iBs4q0cXFNe6Tnkfb0g=;
	b=EtkyuhFG6ARiLAcq2saeyhjR4/GbjZUx6pw/gBmar6ScMsfgom9qGsP+VkqnqG2QRXlvAn
	8arjzclLa4trzeXwuSo5Fc8jDBo9G3WSENYXy+64jnwSA/UJyWLwvtlNOZf90/I+uy1hyh
	5fPj08CliIzw2ezjvm6rot6kxqR+z/Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-gy2kNknINjmXpXJvbek3vQ-1; Mon, 03 Aug 2026 23:20:54 -0400
X-MC-Unique: gy2kNknINjmXpXJvbek3vQ-1
X-Mimecast-MFC-AGG-ID: gy2kNknINjmXpXJvbek3vQ_1785813653
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c4715cf0eso443273366b.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785813653; x=1786418453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=En8P5t+/b7u5WFGgCY07au7/iBs4q0cXFNe6Tnkfb0g=;
        b=q8MqVcco4PpKi51Xv3UpnUWsATDDMPaxkz7TU8ssjRqOoW4qdB3Wgi3C8aerlKSJmv
         TmyOKqRaepEn+s3xGYFzhqeeYagnG+IF9uYKZ4Zd8KhF4qESipMNyAY3DDGl/s3gzmHy
         084LdTIVW4HfNO/JNVjan7+u6hzN3iqTd/YDVku/gTYif8e33UjncZDsF+r1kg9xO8pv
         PUnwexquACPLRE+ZF75RIC5jLXEXglUFcVXdCh0DwSy0EjUSEPPZek0Wrsh6x+hXChCd
         UolBsNvhzG9OZlRMjo8fXK8lieEgmAsKDjrOEjTaZnvGXqY9GlmT+zq29KUHZ5BcbA7V
         KUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813653; x=1786418453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=En8P5t+/b7u5WFGgCY07au7/iBs4q0cXFNe6Tnkfb0g=;
        b=jo82+aKYQng8ePBv2Usmiyj9vZGGDGeVEj//0Gz/O8V5MLWE37jJCD2JcycmX5iysZ
         0ZbaEk+MqZyb8n3+tATgukxX5zs0mhxJk3NUQFqPmYImwzk6GcsEg7OaNexviTFCzfil
         nuXVmRndq/ZN2ul/BvBgg1GUS6lxpLRLd4r5KKfCW0xZZUxjVdOm6AOR20UnsKlIT6Vm
         uybv39vdqFdLiqasdsTAGtaLgS6EfsKRiuvWQaPFcCgQl/WIN3xw90MiK+PY/2J5bMUs
         evUAAUwI680MDm22ySAZae485KHPQe9wHCktkDH0z29gUUfcvzX0iBdG3TLiH5LkrZkm
         BKfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJKiwqsQuzxfDsEbLAvmY+y++/iITKFwri7sLSjWQWZ5ck6MsqZTywe7Ip1tGzrwqxHWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfb7y+YUxX7LmEhwMWsPVvSfcoKldJabeegnOMnR4KCMMYWd2y
	xDc61b2nUfh9ilQrVRIP5OLENr7XbWeIEceEKVOUBZetrELpO3vL0FXLLI2fTWBSLMzz+Q17WgM
	7AeN7NYhCe6J3qs4gRxhuMpIsSySEef/ZikKZvc1n50jonEA1l1ihJA==
X-Gm-Gg: AR+sD11dUG6AbwehUZRbKbPAbMERVWcGRNB3VhWYj/JoPR0nqGqWMarMol11l1ekS/Q
	fXluomMpFqu3OM4eKC6TFJlnpBtA53jJm1WJC34OejInmUm1mcB/7BbdjsealdaqMTjTTs7AYje
	dMwxWXRxuh4fP2hZIGo14DKZyqhaVKD+9LO+tE+bQUJ0rN/Xk9QB97us7tgLttxNZbPGgs7HIS/
	Tyho5HrgDu9SHYOq8vgN/Djg+gI+5cQYs6DIdDpOyMLlTTZznYR9592gSFlbgmNoOlXcVGdG5ph
	aMhFwYELgtphPKAmf4MBZNLE7bY7lfr6+zK0lrm3smxQRuDHS88G63bisPGhYBk4i3JZ
X-Received: by 2002:a17:906:fe49:b0:c19:4ea0:f4a3 with SMTP id a640c23a62f3a-c1fe8109d66mr946357966b.22.1785813653526;
        Mon, 03 Aug 2026 20:20:53 -0700 (PDT)
X-Received: by 2002:a17:906:fe49:b0:c19:4ea0:f4a3 with SMTP id a640c23a62f3a-c1fe8109d66mr946355866b.22.1785813653094;
        Mon, 03 Aug 2026 20:20:53 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b8c7sm641983266b.9.2026.08.03.20.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:20:51 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Message-ID: <20260803232008-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731103414.1746316-3-physicalmtea@gmail.com>

On Fri, Jul 31, 2026 at 06:34:14PM +0800, Jia Jia wrote:
> VHOST_SET_FEATURES is also used to update logging while a device is
> running. When ACCESS_PLATFORM stays enabled, allocating a new empty
> IOTLB on every call drops valid translations and forces avoidable
> misses.
> 
> Initialize the device IOTLB only when one does not already exist.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>


You did not CCc all maintainers and lists with this patchset.
./scripts/get_maintainer.pl -f drivers/vhost/vsock.c
will help find out whom to copy.

thanks!

> ---
>  drivers/vhost/vsock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 562b9e139a76..3703fd219039 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -893,7 +893,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>  		goto err;
>  	}
>  
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}
> -- 
> 2.34.1

