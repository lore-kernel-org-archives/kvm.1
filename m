Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666FE3FAE1D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813581; cv=none; b=o8lS6XaQHCaXOJxOxugv/trhd/Dg+uc3/Bvr1h31LF4v8oxPuyOlJQnt2t9skskdy+l0jwersl1kOypMyqgI0rKYNNOGNz9b4SwRLvSJkHQTlWcEqsUAttlHxE7JRgoByp9r6XsfUONzWEYogaYtBX4sag5EOCnn1sNj5V4NObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813581; c=relaxed/simple;
	bh=qJNK0mMXv0heRTimXOWusPvPz53Xv2iOqzKHV8MyWU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWBzFE7PfZ40BmjSEvMCxCo18j2gaRL8BJJM1X25GIw1LuYp1yVhXaK5Fu/4XmTZ5XVYOr2dJMHUnb1pE7UUcmOQrO+99tv11sVHBI/xhGoPjEsrn9TPfwGRfP3/RvAZ1niq9fTn/8uMwXDHV091n4BUxW6EbpZVbMznqOrq7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hD1F4rUH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwcS20Xy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD1F4rUH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwcS20Xy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMqUxTeod+qMIzPox6QOe/9dnA8UJsfNkNiAFu3uAdY=;
	b=hD1F4rUHnkm3Tr5DylFrCmdrUoZ6T4X8QdSPpxHRTDMuuuGRwVVOO8Rv3oAhnha/7sdW7z
	IEMmMr8fGj4VhPX5hMbQljemU0GxT6yg7ZNP7qDWdBKzyqVymDS8g4jVGPT/BQ/e3dhFno
	EOUu9MQsKdJfhBnxkeoB2usUnedduAE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-MVsAE87ZMp2HK8dYWSsbhg-1; Mon, 03 Aug 2026 23:19:36 -0400
X-MC-Unique: MVsAE87ZMp2HK8dYWSsbhg-1
X-Mimecast-MFC-AGG-ID: MVsAE87ZMp2HK8dYWSsbhg_1785813575
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-698c181a258so4785401a12.0
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785813575; x=1786418375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMqUxTeod+qMIzPox6QOe/9dnA8UJsfNkNiAFu3uAdY=;
        b=MwcS20Xy5Gno4UacUjH+R9UGA+kP3DQY26Nwd4yTXhz64k+/US7/nGlWgm+ZNOX+/8
         xHCEOH97iIRJc9FN9BqM1kLJn7TLfEI82/2+EaJdFUt1cRxtlLBDIiBljh5QFEo56WyI
         TQTqx2SHSeBlfQdtno0A2Z0hZTpZshGd9H1XeYqugzEHSpn2YRH01IPGFjxm+XUoiPc+
         LpqzA2vVFlbxhOwh73+uzagR04uQXzHBEzIiDD81h8Vmd4VCMujqnIGgvTrf5kQDaBeX
         RG7n0MZtaf+S54/yalG3SGOVWX/ym8QfSi9E5buQP2lw9dFwVOFdxoYSrMBuhyXvTbNj
         oHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813575; x=1786418375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMqUxTeod+qMIzPox6QOe/9dnA8UJsfNkNiAFu3uAdY=;
        b=n7TeyO41q/kdzENrtstzSeiF14B9vY0BGnfy+mckPvAdZB/nVf+SiLZutB1mr0+PPA
         TA0u2I/8KR2VPZneJcC9aBJRTSgKUSzT4hNRPxmYPoshLJjC04AfWKH0O9PaXIKAJ0ak
         HAF3ABm/Mu7KnIcKYjFRNUYSrHs7okQHm8rAUfktRroY/CLqPlWHRoADjXspY8c5k47A
         EoNE/AztU2J719WIoKXZarOXKmSqnx2TvKxUV6qRm04MJHFFNFBiS+aIEzvyRCUiOS/K
         UkPxeLGS8JuuNiPNpwhdvHZsSXr80WakUfCDgw0rAyivbXuxycJJJUjNHivChMHB9uLK
         xXNA==
X-Forwarded-Encrypted: i=1; AHgh+RoMzooLeMuyu/e55g5P54ha9lC+anSOXBIRz20yw6gPAxApUR2/qpU48AOTqR6MSvIPu7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+3qTxJqUj9FcZZz10jy9fUS3ykvpXJ+4rfNyQ/5gxWF6kkHq
	yNTiZWrzO2/LAgvFj2l28irlJ1G2GjyGsIEFcJqXeVonOZC3uLh4q4ITeenbNpC7+ltWoCFY3Jo
	Pk114fDnitb/mrckUii/Qu4Szyctiw0FAHnJoBXwh8jtr96rIUcdw4w==
X-Gm-Gg: AR+sD10Wdv0pZmC8o/SjihxGOtk++nPkfvXwWXIoUzECgl7qKSaCGDSopc+zvyX+iaq
	Oiw+Ij2XtfcvIEVH5Wvlrk2d9imdxA32fNT5q/aQ7OhQMT8sHmoTLcGabO8aeC1WzU1mX2IQOnh
	ill/64pqT8uZRpg6TvcTuWEoJFRlU/kgLeTjyk1wPFjciGq9FLPX6ahwovzyxaSMyu9lhrsMN8G
	8ZiQaMuCSTgrzqGSsQHMgM5P578yRZ6CjPTuRq4nZRJ4lQHwjaluNkXQAg6uoUP7g2IJVHez3Dq
	R0cEkcDAYJVXeOUxGEtIB+vUxmdVKQmqhNjF2hLcNcZqP4KKztWgosDA1ROlva6zWgke
X-Received: by 2002:a05:6402:4487:b0:6a0:f1d5:deba with SMTP id 4fb4d7f45d1cf-6a0f1d5e1f7mr6584346a12.12.1785813574700;
        Mon, 03 Aug 2026 20:19:34 -0700 (PDT)
X-Received: by 2002:a05:6402:4487:b0:6a0:f1d5:deba with SMTP id 4fb4d7f45d1cf-6a0f1d5e1f7mr6584323a12.12.1785813574339;
        Mon, 03 Aug 2026 20:19:34 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a0d0a70ae5sm2965304a12.14.2026.08.03.20.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:19:33 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:19:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] vhost/vsock: fix device IOTLB feature lifecycle
Message-ID: <20260803231911-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731103414.1746316-1-physicalmtea@gmail.com>

On Fri, Jul 31, 2026 at 06:34:12PM +0800, Jia Jia wrote:
> As suggested, split the changes into two patches.
> 
> Patch 1 detaches and frees the device IOTLB when ACCESS_PLATFORM is
> cleared. The device and virtqueue IOTLB pointers, metadata caches, and
> acked features are updated while all virtqueue mutexes are held. It also
> drops old IOTLB miss messages and wakes readers.
> 
> Patch 2 keeps the current IOTLB when ACCESS_PLATFORM remains enabled,
> so a runtime logging update does not discard valid translations.

pls do not post v2 as reply to v1. confuses tools. thanks!
> Changes since v1:
> - discard the existing IOTLB instead of returning -EBUSY
> - serialize the switch against all virtqueues
> - clear old IOTLB messages and wake readers
> - move the existing-IOTLB preservation change to a separate patch
> 
> Jia Jia (2):
>   vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
>   vhost/vsock: keep IOTLB across feature updates
> 
>  drivers/vhost/vsock.c | 46 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1

