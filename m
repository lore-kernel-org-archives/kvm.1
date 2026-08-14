Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A74192EF
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694348; cv=none; b=JBJLwoRovkbcXJ7ho8/5QVTuWJ4Ht7M540HZBb4w/OF7sxFVovah/KTqlLvcN/52E5lv0sConxD2yvRHrXjeKOVO1vfZtiYDl4OkiLjlYWtSlSIUevjaZIAaKp0Y+RpygM+FzOouPGtbZcNiFXbmfJrzl4jXeXdsJUE8TnV2jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694348; c=relaxed/simple;
	bh=FC1U7Bkume/g43id9Gi5fvJ0O8FBhgcpEYLYobLKUS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak4AKRUSi9DlEFQOtQkleFzda7wybe2ryyEKKGo6PMLGPO6RbVqbbdOMal7RqEe2592OHOCnbMUrOFFpNAh401dSzN/9SwB5Lqeim571Boqw9dIrAeAgb3ALJx5DaOenJaWc44WeN2GVy/mBnJOgSLM+wkewgzWZVe4oZzFcsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcSjbiH0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyNHQ6vl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcSjbiH0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyNHQ6vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
	b=TcSjbiH0E7gDRu8wsVTc3porRdybMYR3QUceM9sjsRYAudGfX2dBplzxylxjxD/Ao0v2nU
	OPjd/oHT0Ib80a7YtLNRHOyih2BP3zoEe9/+PQszU2yc2J6R/rOosJ0rEQyb1SycPoxY9k
	go3OL2ZcvU+zGQNj96zIiZUtERt8gI4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-DDN8hNnWNvSLQvJZ50FXkw-1; Fri, 14 Aug 2026 03:59:04 -0400
X-MC-Unique: DDN8hNnWNvSLQvJZ50FXkw-1
X-Mimecast-MFC-AGG-ID: DDN8hNnWNvSLQvJZ50FXkw_1786694343
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso545252f8f.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786694343; x=1787299143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
        b=XyNHQ6vlc0imLuYxfdzQfnUrwkCfguoqg0x3XNKXRiXgLe3XojxKHHoSOS8c6Ez7Ft
         ZsGdbADeFDB3kSQ04Ozj153aJdTCIrRP8LBXZeuzVJVrWdrSfF392Lpqs9uWHDIAeNEs
         toJ7RZ7cupkfQmHBS1t7SkaBlYoGS2PowRYazPG178qiU0qBCR3aOOJARy4dH/YSwrxD
         vOEJstep+E/8kBdowmpEfgDK/ViwWiWeNZyI1yqO9bo7LaFFjJAR6mUXQsVN9ZpK+4+i
         E6LpBuVaAARLemDDzoXWB1Ba+L2LkdqKYZMuMVVVbv8GnAtuwVWo2xRpdCsjQImeMUuI
         ZQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694343; x=1787299143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FO98RYWplbEpkXEISYhcLGNF6lZeNFPlJN8RWdcoifw=;
        b=GBAYo8IploqN36p0X3kuv6wKOx18uCs+X/2wLazx+OET59tJbWhdMXiN17wkjUpPDO
         5SlCpLiKRLOt4wAll8K5drFuv/70v3w+XHyBgt6zP/iqVGNFXwFiU7xWYDacwtwDPv11
         P9OS9ANHTaYTBW/RWinmEKeMCO4FVnbnoNLi7Aaphrhd6Xh64Nt/1rmQNyMLK8scXpZq
         ofnL9Q3rZUmlsv6aT/rNyN64OmKs6SeV3t07GWDd7q3mkxkaAx9PI3bXJvUYVvWiICdI
         oDWcVUbzmAFutOuTJMxB0WTDi2vSSqJcgPJF8bSyphVuO+/XqFYQvqQzp7vXTmJRwibz
         1f5g==
X-Forwarded-Encrypted: i=1; AHgh+RpWGPDk4kV0N1OFFXAJGXi+8xWQoYhFLH5u/n0H5gVXqk57uC8/l87pVrDG+mUhiUZw9sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGOPUXTZrNpC8h/lFhu3vLUSlbnvVLwRiukR5eeKORgfaB48D
	N5k9iNLmthLCSA/hIlaywx99Aa9oHxHN4G9M+GjEM1BGsdg04IH+LV34o7EzLC8PMQDylK8z0to
	GYTDShPzJFju8D4AdNQD3tayUkLVg1miv6034q/R+oZ5FX+S+g7mpk1zoK9VnSA==
X-Gm-Gg: AR+sD10uU6lCVigGRd6emsGcfiC5l7LDuyDW6HsyKtAvX5Lvj1VJfsgXzLjHK6IoDRK
	l/5lxRVKOymR29xhz3iqdlW0mGjGhb7TBM00X2Cyn/jEbXzujLe/8nAvsqieLcizyav1HSaconw
	JdK+dMa2WWpxkvl9FheHrvcxdw7pg7elOV2x+IlAPtSWBkEHZUOOZNMB1A5niZE85QNxgeiZWZ5
	3AdKdLbl9fyKv9AomHtUP7+SN/as2WzVYuLEm5za2iLlKnaJodsMB2a/FtB3ubcpV7DVZqKosH+
	L9dZhzmgdUwAfSzJHClBSZoV5ZzCigTMBC5kTwODxejH/+1UcecsihINFyY7rDhxP1lcz5dJkYm
	3QmXPHNnaYEluqeN6Whsp1AFs5HWjY9NyN70h4byvt4Bo4Ei4u1GA
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222672f8f.0.1786694343287;
        Fri, 14 Aug 2026 00:59:03 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:47f:9283:1fb3 with SMTP id ffacd0b85a97d-481606d2962mr5222619f8f.0.1786694342786;
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm6204391f8f.0.2026.08.14.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:59:02 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:58:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <an7HhRxxjv09faBX@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260814072903.124991-3-physicalmtea@gmail.com>

On Fri, Aug 14, 2026 at 03:29:02PM +0800, Jia Jia wrote:
>vhost_vsock_set_features() leaves the device IOTLB attached when
>userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
>continue to use translations installed before the feature change,
>including HVAs made stale by a later memory table update.
>
>Use the common vhost helper to detach the device IOTLB before
>acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
>each virtqueue's IOTLB pointer and metadata cache under its mutex, then
>frees the old IOTLB after all virtqueues have dropped their references.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b69c260eaeff 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
> 	    !vhost_log_access_ok(&vsock->dev)) {
> 		goto err;
> 	}
>
>+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    vsock->dev.iotlb)
>+		vhost_clear_device_iotlb(&vsock->dev);
>+

Why checking the feature again instead of adding an `else if` in the 
already existing check?

I mean this...

> 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
	} else if (vsock->dev.iotlb) {
		vhost_clear_device_iotlb(&vsock->dev);
	}

>-- 2.34.1
>

