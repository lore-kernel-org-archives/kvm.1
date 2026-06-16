Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14653290C4
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617360; cv=none; b=q2H2va0CB0DYf/gu1y7CdjfL+3eJdcAUgW197rEvRvcSAbfRsfr9mS3E9Z4mXCorizzcvOgfZuuCXWwCPjKIEr1Vv2n3SNnR1rhInfdAzSihX/Hv7KSC51WamhJS4hjWq1SoTehWZc35burhWvhNGBTpGHwLjQfsxRerehiOE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617360; c=relaxed/simple;
	bh=tc2x14jzytwc/9908NmOW1OURlK/VDWDQ8I16o2NBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED6v9DOjoOrPSW3uEZpUmrrJe1KgFYxXA96HgZkV8/4mxdlUUXiFiPegL65yRgdDGZ4nqYRjmME7uGQQnKr6QTlJdxMy7ZZXPuX2J39xyJ12TFufVPMWK5IV3+dJ76T/+q527mCa83875gRFC3893UwmkAt66o8qlrKqLwULGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBG/QONm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rLO5DiaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBG/QONm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rLO5DiaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
	b=FBG/QONmIBdC+NcdzoRv4c4YmpzTfrJVtJJDaG16yJNMUZasEXGzDG0BUL39/Kfg7BHfZ1
	PC6xyN0dGXtLeseJL28Tts9FTRT+NexBprppHJLNVM3LGYhs+PCLLR85bXFyOeoO7uarcK
	nytYXV10ms7NfCu/n+k2i4wD056a13A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-RtfZFbALO9m6AkJvyFiwMg-1; Tue, 16 Jun 2026 09:42:36 -0400
X-MC-Unique: RtfZFbALO9m6AkJvyFiwMg-1
X-Mimecast-MFC-AGG-ID: RtfZFbALO9m6AkJvyFiwMg_1781617355
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-461a15b716fso408793f8f.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781617355; x=1782222155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
        b=rLO5DiaBMVBY8a5rIfDpeha8mMgsaypWW1nvTjLIMSE2gSS1TzS4BOn3MmkWszPBf/
         QMDdcf1oFoOZBMDVKr1hKPIAxn+VGewUJGTCFI5lEiBgjYEAfBD3Y1R1AbHoNvTDf4gG
         C6Ixw0vsLkV5+x3/ySMI7rGtOeG775U5a3WPZagq+5IfCHBVj1C9eFnMggvNV09N//G7
         h3freBePDe1TGRFAQnP4YEATg+ZPRabCbSk1c4lAF3X2bn+ZzcAbyKflaxLhnWyNg15Q
         qFMr0qhaRHD2u25jHPyPa8BSdtRma48QfnpGyRiLBJyH3IcIfuCm/xKcEmURZDw4JCeK
         Sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617355; x=1782222155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
        b=APSqzG6kUiysxyRCPT/V73zOM31HOsVdyX35CwY39iiO90WQ1yPzaEcB8rfbCVb1mN
         dEro2Zo9/msNHh6fWi+8E9P1MKev7mmyUGgXALWp5fAtfMLUzdmvmKfQ1zPWBQYbBV7d
         gwOqq+IYF7zGQOnmVK6tIdlaNbwDPFtN3BhCFB4yJUQTHP29r7EwSZAx7mx4XDDS+9W+
         1zpGeu/qoAQYpA7i+rYUv+p+81lKrVadR+uCcpdzO135Z80zlVgdU12xfHxEzLd1q5Zw
         0bAlPEFrEYwjCsjF7OMYhND9rbVjfOiF05iajRG4i+ktgm6MYNgVylXLZQuo5FEWTVQ1
         pGzg==
X-Forwarded-Encrypted: i=1; AFNElJ++P7ONvnvO7ooV0yM15SWrBZQ6rTZ6TFLftCmbCDBtaTPgAKVWgCkDqX7dGN4VhhsmiDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8oPfd9RRdw7aazkM3IsSX1fzkDXFQwITgvkYY4YPNjMAfap+
	bJe5yBYCV26P++30bpY6aymLiYklFg/3Qx4IGpN8u8xHpT375dHnjvs8YOB6GAroBegA7gUZy91
	juqDI0WfzVZ75y2c8JVpUkob8UzJLAq8H5Ee3kRf7WteGbIBqoW+glA==
X-Gm-Gg: Acq92OFNxUxESNhEIkmaqRPiFtUkVH1j5h+QOyO5YUTvpfo2RdnaETPVTio6lZmURE0
	ggh11QAkb5s5zYV4gDJu90NEGmbuufEIzV8xQLAtKB4hyiGeZlOanvwcoQIvndsbzmDU5IG0WAy
	j5y6XBJJqLVG+fw3vauQx02XaKmfccQLfPMzZjAPVNKpc+Yz5Sz861hwSI/PJZIKq+cymqU6LdH
	mQxslW8wQSXyPd0aQW4Wx1NgBB/Z1d/q7VffE6HrWztzS091tIVOfUTy15J/qibe9ZUSvo/a7CI
	tMlUeju3DIfD80gQ6x2UZfoM/HZv/i9Coe1z7BfdktSm4m8tMDRpT1HZLri1jYk8REH/5HPzDBD
	Rxauq9YUg4SS8IeLxiHsiyG3xhtBF+IXNM64jXJi52pS8BLhxUJF2oOD/e2WzF+MLZxrxUvM=
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1007020f8f.16.1781617355160;
        Tue, 16 Jun 2026 06:42:35 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1006943f8f.16.1781617354664;
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51242208f8f.29.2026.06.16.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:42:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 1/4] vhost/vsock: split out vhost_vsock_drop_backends
 helper
Message-ID: <ajFSurS_piyfFvjM@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>

On Fri, Jun 12, 2026 at 07:57:15PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>Split the actual backend dropping part from vhost_vsock_stop.  We're
>going to need it for the VHOST_RESET_OWNER implementation in the
>following patch, when vsock->dev.mutex is already taken and owner is
>checked.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 26 +++++++++++++++++---------
> 1 file changed, 17 insertions(+), 9 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b12221ce6faf 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	return ret;
> }
>
>-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
> {
>+	struct vhost_virtqueue *vq;
> 	size_t i;
>+
>+	lockdep_assert_held(&vsock->dev.mutex);
>+
>+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+		vq = &vsock->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vhost_vq_set_backend(vq, NULL);
>+		mutex_unlock(&vq->mutex);
>+	}
>+}
>+
>+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+{
> 	int ret = 0;
>
> 	mutex_lock(&vsock->dev.mutex);
>@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
> 			goto err;
> 	}
>
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>-		struct vhost_virtqueue *vq = &vsock->vqs[i];
>-
>-		mutex_lock(&vq->mutex);
>-		vhost_vq_set_backend(vq, NULL);
>-		mutex_unlock(&vq->mutex);
>-	}
>-
>+	vhost_vsock_drop_backends(vsock);
> err:
> 	mutex_unlock(&vsock->dev.mutex);
> 	return ret;
>-- 
>2.47.1
>

