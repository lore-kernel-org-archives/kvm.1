Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63244D01C
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613982; cv=none; b=MvJrAac8u0UZmwFFZeI8AF+jOpt0W/exrtRISdihPF1sTFs5tp92jeAwqwW0/D9cKtbtgA27EkPuKAUOOMgYwsz4c3OdLNtZpPlv1xy3ZnNIMKWvHLWDBWrCT8Tks+9M7zwoAS8c0mq8RmyanMQrUqd5BanCjY37tSSiyKA2aSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613982; c=relaxed/simple;
	bh=RIJDgA6soFRVC0k78nWGXCgPMPcUzn7IBwof5CGhtdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkSYrCm6vyQ3hWnPINQJ4qLH4k5g5alfoqqGf0Fz5GLkDJnJcm4KUF3Csk2fWzyxNXdogk0yTHwzJ3cRvu0rWuEgtpngclSvo3yK9ma119NEu2bf6JVY0lnPu+pDjnTiBrlBAW2uTMFPl5Y7Bn8OvO1Hc79BLHzx/Y4j3Gq8QD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOeEwPZM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4Rhbbso; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOeEwPZM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4Rhbbso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786613979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F6N+VCq58ZT8xzy15i+HHmMii8MMNX7ejz2MgM7nfQ=;
	b=iOeEwPZM8hlgzWCnSy9YZXjAJo3Ua7dUNuu09DJJcPfX0BYDFm/ksIMKJqx1eBfPAioo7b
	+xi7sZ8npUY66EvC937F1/rOIWUSivjjt7eUMGG6Ep5gIfQJUeIks5eyEmWSLGE8tFSVex
	zpbgxi37Fm3a3FRIZ+YANsfLY09U7NQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Ox0dmU4tPx6LDoi8cRYlmQ-1; Thu, 13 Aug 2026 05:39:38 -0400
X-MC-Unique: Ox0dmU4tPx6LDoi8cRYlmQ-1
X-Mimecast-MFC-AGG-ID: Ox0dmU4tPx6LDoi8cRYlmQ_1786613977
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fe85684b9so521407f8f.3
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786613977; x=1787218777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9F6N+VCq58ZT8xzy15i+HHmMii8MMNX7ejz2MgM7nfQ=;
        b=g4RhbbsoWwZ6Qo89Ln/kJCk0roFSbuIkv5AqKjdrxS7eDIwmkbAoiWp9MSJmqI95j2
         B0bJs2SLcsVSCJfgRidFnzQ1/bRDoqoL4YxJ+xq2xBSv9D4+Q6YfoFiIaLDuDSbwpBgR
         fBUGeJfT1Ql/By4/LdULUbZxcX2nh7ZqL8IyN243D7iojjmT3T5r/uNQSaTRLh0LxeQy
         R4dp4kqaAuCKyMYYED0EiSix9ffhlqkWsri0v30rylZuqPrOxNev594yn5TQ2oQsqFri
         c30hH7pyjmY1CwMLZ82J/kUdE3UIB8THHhi2KVjlnPmawuqgnbprOqilwEZZa/e/3Eyt
         hQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613977; x=1787218777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9F6N+VCq58ZT8xzy15i+HHmMii8MMNX7ejz2MgM7nfQ=;
        b=OsQKX/i1Ag7u2lSQmos5hlDuvRZPUS012/O4IW2AKUs/noBQyS//2uyCcMm3rYjHAd
         IBs5i7gP1DOVMCpTkBwP+D1SdWtOzog+Xa3UfLkls3tuf79lF9+wJNz2SpuFei+NsmxX
         cIA/f6AtNKiw9h85eklzhUbzriVXhO4ClIzKN8HLMlifedvmwUp0X2L8RubewuTT2dK3
         jSs0QSChzhT2vXEz4jKr3hE3YlJFTlhXZaHPLGAOFmMJoiwh6a229AX9ygab1PDp8Me8
         KBXnHffwxhPP200WaXFnrMD6PpLRvvc0c32SF5HTlZiVhVguhHEljUlSgP0VsjIQvjhZ
         Ti+w==
X-Forwarded-Encrypted: i=1; AHgh+Ro7mhj7a2VkkrbOzvBTYT2hxDO7ewRam4LnU1725cF+fHbG010IE4nqahdDugYIvFGMhP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVI/D6L+O7X+UH/gB/tmN5eWEJ9QUZeetrC/BBKfFPYF66ujO
	pxvr66ucfv7MqLYWLPEknIv/HaxlC0HPEWmld8F44NbF3wAU90/Kg+T/x/MdzU11hx6Q/2gcGam
	r/EHcv8dwVGuqqT/sWYJqw8ZeRJPdSrnVcJU4o4km7QEs2bnFGRD9xw==
X-Gm-Gg: AR+sD11ETTLCZvQ1++D3PeTK8hnyBYoGnp9fb/BcWnuUBzlGOYPqrtzd2DZzUg+v32v
	ryWyTOfDAZgIOHphb1p/9knlQLb2j0iEU89aYAq6lMA1IvK4f7T+NTv0H8bQjJkHzio26htPQL4
	PutDA6o8YTd1vXR0SRn5JMeODNPbH5HHPu7KiykbZJzY4vfX4mNjjMs2qRhyjN9yKUxGcSlWXrH
	hbuK36UO6CzwuAhRiJwAKI4sd910FD9ZdZpbt6VL0EMspxAt7uztTVYiItd6XhYgEfxby48SjUy
	60ooe/ZFN5JQntRq49wBSK9dOfRcclC0BO0S2VV7P0IsHmy1HT6qUi8pc8qwsMcYB2nCat1kSbd
	vVgn32lfIZN6QOCABRW2DIQiRZ3LWzVBZr3h3pjTlTZxrDxnSg0t4
X-Received: by 2002:a05:6000:220d:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-4815a01c666mr5772524f8f.16.1786613976705;
        Thu, 13 Aug 2026 02:39:36 -0700 (PDT)
X-Received: by 2002:a05:6000:220d:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-4815a01c666mr5772398f8f.16.1786613976129;
        Thu, 13 Aug 2026 02:39:36 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5612d0sm4972789f8f.2.2026.08.13.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:39:35 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:39:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <an2KTuUm-mZ0nnDQ@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260810134018.143973-2-physicalmtea@gmail.com>

On Mon, Aug 10, 2026 at 09:40:17PM +0800, Jia Jia wrote:
>vhost_vsock_set_features() leaves the device IOTLB attached when
>userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
>continue to use translations installed before the feature change,
>including HVAs made stale by a later memory table update.
>
>Detach the device IOTLB before acknowledging a feature mask without
>ACCESS_PLATFORM. Serialize each virtqueue handoff with its own mutex
>while clearing its IOTLB pointer, resetting its metadata cache, and
>updating its acknowledged features. Keep the old IOTLB alive until all
>virtqueues have dropped their references, then free it.
>
>Also drop queued IOTLB miss messages and wake readers now that the
>device no longer accepts IOTLB updates.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 39 ++++++++++++++++++++++++++++++++++-----
> 1 file changed, 34 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..7372c22691de 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -851,6 +851,30 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> 	return 0;
> }
>
>+/* Caller must hold the device mutex. */
>+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
>+{
>+	struct vhost_iotlb *iotlb;
>+	struct vhost_virtqueue *vq;
>+	int i;
>+
>+	iotlb = vsock->dev.iotlb;
>+	vsock->dev.iotlb = NULL;
>+
>+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+		mutex_lock(&vsock->vqs[i].mutex);
>+		vq = &vsock->vqs[i];

You can assing vq before the mutex_lock() and use it there too (and in 
mutex_unlock()), as we do in all other places in this file.

>+		vq->iotlb = NULL;
>+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
>+		vq->acked_features = features;
>+		mutex_unlock(&vsock->vqs[i].mutex);
>+	}
>+
>+	vhost_clear_msg(&vsock->dev);
>+	vhost_iotlb_free(iotlb);
>+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
>+}

I don't see anything vsock specific here. Would it be better to move 
this to vhost.c and reuse some of the functions we have there?

I mean something like this (untested and may be incomplete):


void vhost_clear_device_iotlb(struct vhost_dev *d)
{
	struct vhost_iotlb *iotlb;
	int i;

	iotlb = d->iotlb;
	d->iotlb = NULL;

	for (i = 0; i < d->nvqs; ++i) {
		struct vhost_virtqueue *vq = d->vqs[i];

		mutex_lock(&vq->mutex);
		vq->iotlb = NULL;
		__vhost_vq_meta_reset(vq);
		mutex_unlock(&vq->mutex);
	}

	vhost_clear_msg(d);
	vhost_iotlb_free(iotlb);
	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
}
EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);


>+
> static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> {
> 	struct vhost_virtqueue *vq;
>@@ -872,11 +896,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>-		vq = &vsock->vqs[i];
>-		mutex_lock(&vq->mutex);
>-		vq->acked_features = features;
>-		mutex_unlock(&vq->mutex);
>+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    vsock->dev.iotlb) {
>+		vhost_vsock_clear_iotlb(vsock, features);
>+	} else {
>+		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+			vq = &vsock->vqs[i];
>+			mutex_lock(&vq->mutex);
>+			vq->acked_features = features;
>+			mutex_unlock(&vq->mutex);
>+		}

TBH I don't like this mix.

Why assigning acked_features inside vhost_vsock_clear_iotlb()?

IMO it's confusing. I see that you're saving another loop around the 
VQs, but this code is not easy to understand IMO.

I think we have 2 options:
1. leave the loop for acked_features and don't set it in
    vhost_vsock_clear_iotlb() (less code touched by this patch).
    This is also what to do if we move the clear_iotlb() function
    in vhost.c.
2. change the code to have a single for loop with if block inside to
    reset IOTLB stuff if needed. In this case maybe better to avoid the
    function and move the entire code here.

I prefer 1 with clear_iotlb() in vhost.c, but I'm not fully against 2.

Thanks,
Stefano


> 	}
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>-- 
>2.34.1
>

