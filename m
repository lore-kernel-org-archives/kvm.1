Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3A41DED9
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127257; cv=none; b=Uxom4ksKFaMzuLYhqEWppU1aVpzNi5h+mFLIjZqjyZxvkTW1xBgPRf4DAidFscGO8GKnrTs613AWqpF3+t9rNzgM2CLC84M5QILa3FY1vl6LbXzRjWYHgZutUACVMWVArV6rpBz4fEHkZf4XtbOSWlXzf/RE4wUE5EBQ2sUKeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127257; c=relaxed/simple;
	bh=KhJExQqvLhBaMXF8UfYU6ZCaLYbHIyLRVAmEcmHRB+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPrFFtpA7odrZlzM2OmV/21SI6Feswkxzoo8k+mDYOFNznxZ42qhVIaZ/JdXu51nPw5tCfr/hZUSPO6gn8QiZHpPnN6a9rMmpl9idGnF4sHRoBnO/FnU3RrKYySi8vMrDnphltFbnXMeqb3r+s3+IjYICr54Zg1vlWLIXyl2t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jR3ineOg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lbSifBGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jR3ineOg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lbSifBGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787127250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gk/y1sZo7O4/GSumr+W798rlzWHoDtcAKC9y2aG75mA=;
	b=jR3ineOgeIwKxOuwrLHhG2tLUfaI0njbDe2qrePV9xVaXNh1iiPDGoc6lA59T+RZeLftN9
	BbzPsi6LN6bpVjdymnYj6ib2xhS9Z/EhmcQ9dzueQeR1ISOu7ob5TQgr6MWw50TrWymNsN
	chq6wv81bq60Xb5/12wuMfY4TuL0rn4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-uLxaCHhCOfWQgYMe_orTbw-1; Wed, 19 Aug 2026 04:14:09 -0400
X-MC-Unique: uLxaCHhCOfWQgYMe_orTbw-1
X-Mimecast-MFC-AGG-ID: uLxaCHhCOfWQgYMe_orTbw_1787127248
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so5139975e9.2
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787127248; x=1787732048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gk/y1sZo7O4/GSumr+W798rlzWHoDtcAKC9y2aG75mA=;
        b=lbSifBGG7jinEGuAV63JnNlRmaDnn6wQtLoE3YmAFjWfDk5oqECTIP5/ju68dLvWe9
         Dnsk0WltILsZRm86/TLlA9sTHcMsZamZrBHhjhNPJx0KJZM2feoL2veMInCtUVPdAw4G
         I1B2X+OMu9axTdFXycOuMiCZq/vC4J3v1mDBXp0XhK2fH6U+KM+mBfcHKsVSXTAqiOW4
         008fEphQ2nQILrGtShRFJjXGUbWJQjAwDg5TpcSH+AZI5kLRFbb050JBasYeYAPZf5+F
         NB7hLtUKzxgGrdUg6SiB5skvWcXTSmBIhsx4mkEzuRpqEuxyuJqsFjfCgKqgGSCc5XrL
         BdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787127248; x=1787732048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gk/y1sZo7O4/GSumr+W798rlzWHoDtcAKC9y2aG75mA=;
        b=CQKsWYMnWUyG38rBS8ANiUQBeQtpv34QqKZ+5j0R93nPzt47bHivPjjA0Sjqn0Pf8H
         vYv6bJhEfi5DAVA3nB1z/N8jF60RbMLltW6qiCgFH0cXj9jD7t40UWOonTQXCV1+YK+l
         RvueeMfuCp6vgoR8LkTGhJZN7bTIqaqYBnL2VrWga9Woi2BK6Hqw9LPz+BkJodTAUeW6
         uMra8YSE6hcfIQZYLX+0tqgViuCu9SwQECbLyTD6ZxGAEICcvUU1fzLEj/sD2Wc5BrgW
         2x9iO79+qOj+diuKceY4f2ARezTe/rAaouhzaQ5zPD13aMFNDjeyLdpQCZsvmZqAWX7+
         lQCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIqFd0WQksZ8OoW2c0XFFKwB4Zu/f8NPtDrbzC5XGnSS42PhGGDegGcWhgSGooHqtILBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKy8vNQX2hamdEjfa/8eCqut+Tn8yrNrdhoGoHdbV6k4KBrAw
	wjgeElm0JkeH4Pg0ExLiELx1m+aKmDDhhchGJ8ow4AsmAeugYIi6TEzZe8qydi6hJk0VCL2jhOQ
	Cg1r4uAZTWMw42flgfDfOj4+Xs7Q3UtWBO3zGsJhELmMFqKzvuHzUzQ==
X-Gm-Gg: AR+sD13PngzFV5+69dlpCVlenMnZBuAuYiP2EIfzL9qoU3dP4rxR6Aq3+eA++38AqIS
	bvwH4PTc9ZaoDfy0AGmQbOZEjV2GPsW7/TTvOZBL9XU1sGGxGLL9I/KdcTGe/GzktyCmpj40d7s
	PZxcHSDBLJ0v0f+IraJiQ6vh9Ymua9DI8DWQZ2rHdUg7cT7Rk51aVXxj975eiGojow4bfnXprZP
	4rVflsWVpalxN+C96ujxJtZ6ViErFoiTJRQICSOs08cltxVnHT4T0Rchp+/blAS5m2YiWjxZ0Vn
	ahACQM6WDD7dQseqzKiafwwmv0Rty0eXa79iX3hOwGCz4PGeoVtdpLBPO6StHZJiCtse2oZxwkG
	e2eh/cgFpzlL8HeIgL8juGyf6DUieYC2CckHpCpUnu+f9DDr3yGz0
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499aa143b7cmr46256355e9.3.1787127247880;
        Wed, 19 Aug 2026 01:14:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499aa143b7cmr46255465e9.3.1787127247429;
        Wed, 19 Aug 2026 01:14:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa09b199sm38294085e9.0.2026.08.19.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:14:06 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:14:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <aoVkp0USmfvbmIy5@sgarzare-redhat>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260818042613.281125-3-physicalmtea@gmail.com>

On Tue, Aug 18, 2026 at 12:26:12PM +0800, Jia Jia wrote:
>Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
>Otherwise descriptor translation can continue to use mappings installed
>before the feature change.
>
>The common helper invalidates cached vring access and applies the
>transition even while a backend is attached. The backend remains attached,
>but userspace must configure the vring addresses for the new address mode
>after a successful live transition.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>

In v5 there weren't any blank lines there, why are you adding them?
Please remove them.

>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..77a5a6775c86 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -854,6 +854,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> {
> 	struct vhost_virtqueue *vq;
>+	int ret = -EFAULT;

This is a return value used only in the error path IIUC, better to call 
it `err` or something like that IMO.

> 	int i;
>
> 	if (features & ~VHOST_VSOCK_FEATURES)
>@@ -865,9 +866,12 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>-		if (vhost_init_device_iotlb(&vsock->dev))
>+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>+		ret = vhost_init_device_iotlb(&vsock->dev);
>+		if (ret)

Is this change related to this fix?

Stefano

> 			goto err;
>+	} else {
>+		vhost_clear_device_iotlb(&vsock->dev);
> 	}
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>@@ -883,7 +887,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>
> err:
> 	mutex_unlock(&vsock->dev.mutex);
>-	return -EFAULT;
>+	return ret;
> }
>
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>

