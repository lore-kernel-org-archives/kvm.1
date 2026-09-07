Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A433947B5
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817031; cv=none; b=tDVvXh3TPO47rgkzRpen6OLimkx6nwfZhfYYbHhHkCCyHnZub3xh60kYE+D0hRrQdjjIc3S37DLKFhm4znwDFkqphVi9tKsVt+0OZToe358+ZXvihJWL2tZM0cK+epSdQy3o2Ilx0D7IBX5a5mNvd7olt5JN47ThX5lmhLDCzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817031; c=relaxed/simple;
	bh=u9moGRlDLZ8iHd/B9nEQXt7hx/ef6HPudKfAAjLC8zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGXLEKsyfJfMiVUO5IdB5DMC17v0lkwBErFZVjdgXusDWImzZU97daf2ey8fMuOCieIKk29tzUCHJ1Rz7q2rGGcKXGS7LmIdg30FYkLa92CXuHBjGb5f0h1TnsA6Q5NB27jVaIQQuQv1hMr+o/fvxpltVJHQzhYke/eOqw2+WTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSU67eTq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t1o/rb21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSU67eTq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t1o/rb21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=;
	b=KSU67eTqCZ1VIXK4VMFtF4Fh1kKEqB7M58KKmWSyWIB+k0qvqwC50tYX/9mviAK3Zs/ZJH
	ZVZ9B/19MPedjFrfi8FnouKpVAIFf4LHyBI8XeJ0pIBsID3yBvWiEyrYYlNveRW9UJQfOG
	JSqvoJh3tSyJMXfHdPgMnzbKEkca3eU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-UgVV5y7ON6WVht_DayQVJg-1; Mon, 07 Sep 2026 17:37:07 -0400
X-MC-Unique: UgVV5y7ON6WVht_DayQVJg-1
X-Mimecast-MFC-AGG-ID: UgVV5y7ON6WVht_DayQVJg_1788817026
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-484362cb000so2651887f8f.0
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788817026; x=1789421826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=;
        b=t1o/rb21F5Wjn2wBceJUmkjA25pu5UXVFpN9hWQjmAL3jHqg5BCcKSZcSXwncIUAvj
         eH9yh2Ogtp7F2GdrWTuy3luH8enI/1c+03CLKkW8E3w7BZoTwfxkCqSRf2m9CIjDbhG8
         4CtY7ZAcPjGDfwy0JXH5l6OrxvLr4UvzU1yYMDKgezNg2dh4zYv0MD6PAiOYVDsPjnjX
         9kf/P3y4owYoQvA1+Euu+uC2+ZvLSHQpa5r5BHwBlS1tgahdiaz4TkSaAwbuXPXzkcyc
         ZJLlVz6juZz0PmdWcxKBVZVmwvmihZ+RE/a/2wY2TbZ9eHqCeiuLjo++jQsKWHMMgJZi
         AlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817026; x=1789421826;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrHtKsbOCKteoqWFV7lfV/tXkTEj1Fv0IcHEJx72zjM=;
        b=rI//nWYG+NkKItqr1+qbhRR+E/i0JsQ2LDf3JOyzE5rtWwY2JqgYi87NF7nfAa+ULL
         eQ9gmIXrbNl2Gb1uUXOa7KYA5G5fGHxM94D5RzZS22/0ritesaFtAgWmCqvKdpWNtbqm
         2dI7sib4tihIhMcdlMFZxT1h5ZAEq4t+C8ym04YakfwjsSo8Hs5FYgKNAI/AjJQuCvh4
         dRWpxKMZcgPPYbKZFR3AVog9hiLh36tee2HG7eVzxuiCcIV9XgtYqkq+U+OqUSkD3SRJ
         iihHiqXacZIQ7hHlwVGlk2Y/tRhxymG4sYdKpEz0XBna2/JpBmFzehL9L+o3GVvw1j+h
         zoHQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2ln0/NCrPkHTHhV7hCRwQDLQoNkh0UzEhAsdGfNzCM6rkj3CzjMgFy1zyK0arFTJxBvs=@vger.kernel.org
X-Gm-Message-State: AFuF++m+axxd4Qht3UaNVpxnG5mm8wUT4/mapo7XKbDB/iBEdchOeFOU
	HfZk7gQcdYAXHcr9jrQv3mD1SkGXvIbl7AfM+dZX9v8eFawyawQQTUumKLAYZT2Kt+5Xk1lzkD5
	868r6ug3eIRFRm1cbku5hqrfxvG5RdVAf+vaCLrKGLZ8vLiFq//PmeA==
X-Gm-Gg: AYBFou1obP5iT7zzB2GLMwY7Mjz+elhqFP1jOCvq5nh1+HRpzWLqkub1qO2riE5vcL+
	owWtb0iaOSbdx6pHwchDCNyFEyt9ikP6JWxApRqVR4MP9JnBp6Nhd+FvYYC0uqSJWniH4asecJK
	qxwcchtFW8/PImHtqxE5jN3b99V8k9tvIaPtt0pXudKDnn2VxuM8t+G6yckHJ6keXtGkG96C7Kc
	TNmF2s4nm96mave2k3+dEhx15MAUbwlJPsoNUnzB5pKVesCZ36o/JEIDfsW2iWvo+SfsFk2G6Sc
	KdU6STMyRcvuiwcHGMFdx4YbSkt3BWseJWM7hOslkKuJNH7bd2/O6lGhyWjyAl71maBXsyxqM8F
	uL/F7ywz0qfk5bylacAKfTzs=
X-Received: by 2002:adf:edc8:0:b0:482:e658:7a39 with SMTP id ffacd0b85a97d-4857e5171femr27162886f8f.11.1788817025765;
        Mon, 07 Sep 2026 14:37:05 -0700 (PDT)
X-Received: by 2002:adf:edc8:0:b0:482:e658:7a39 with SMTP id ffacd0b85a97d-4857e5171femr27162864f8f.11.1788817025220;
        Mon, 07 Sep 2026 14:37:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm35717372f8f.25.2026.09.07.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:37:03 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] virtio: synchronize callbacks during device reset
Message-ID: <20260907172202-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-2-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905152059.89560-2-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 05:20:57PM +0200, Karl Mehltretter wrote:
> virtio_reset_device() promises that vq callbacks have finished when it
> returns. virtio-pci waits in vp_reset(), but other transports can return
> with a callback still running.
> 
> Call virtio_synchronize_cbs() after config->reset() and drop the duplicate
> waits from both PCI reset methods. Add the wait to virtio_device_shutdown()
> too, since it calls config->reset() directly. Keep the pre-reset call under
> CONFIG_VIRTIO_HARDEN_NOTIFICATION so callbacks see vq->broken.
> 
> Always take irq_lock in the classic virtio-ccw interrupt handler so it
> pairs with synchronize_cbs even without notification hardening. Use
> is_thinint to choose the lock: airq_info can stay allocated after a
> fallback to classic interrupts.
> 
> The transport reset must still stop new callbacks before this wait.
> 
> Fixes: d9679d0013a6 ("virtio: wrap config->reset calls")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c   | 6 +-----
>  drivers/virtio/virtio.c            | 2 ++
>  drivers/virtio/virtio_pci_legacy.c | 2 --
>  drivers/virtio/virtio_pci_modern.c | 3 ---
>  include/linux/virtio_config.h      | 6 +++---
>  5 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index bab6cad3fd5c..552d77998012 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1062,7 +1062,7 @@ static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct airq_info *info = vcdev->airq_info;
>  
> -	if (info) {
> +	if (vcdev->is_thinint && info) {
>  		/*
>  		 * This device uses adapter interrupts: synchronize with
>  		 * vring_interrupt() called by virtio_airq_handler()
> @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  			vcdev->err = -EIO;
>  	}
>  	virtio_ccw_check_activity(vcdev, activity);
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	/*
>  	 * Paired with virtio_ccw_synchronize_cbs() and interrupts are
>  	 * disabled here.
>  	 */
>  	read_lock(&vcdev->irq_lock);
> -#endif
>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
>  		vq = virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);
>  	}
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	read_unlock(&vcdev->irq_lock);
> -#endif
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 75bb4ffe3b87..ad1c50b8a94e 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -264,6 +264,7 @@ void virtio_reset_device(struct virtio_device *dev)
>  #endif
>  
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);

I guess we want the "Flush VQ/config" comment here?

>  }
>  EXPORT_SYMBOL_GPL(virtio_reset_device);
>  
> @@ -424,6 +425,7 @@ void virtio_device_shutdown(struct virtio_device *dev)
>  	 * Some devices get wedged if this happens, so reset to make sure it does not.
>  	 */
>  	dev->config->reset(dev);
> +	virtio_synchronize_cbs(dev);
>  }

shutdown is different. vq callbacks are not the issue at all.
but config callback potentially could be.
So while we could keep this, with "Flush config" comment, perhaps
preferably, disable config callbacks like we do
for remove, before the callback:

static void virtio_dev_remove(struct device *_d)
{
        struct virtio_device *dev = dev_to_virtio(_d);
        struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);

        virtio_config_core_disable(dev);

        drv->remove(dev);

....


}




>  EXPORT_SYMBOL_GPL(virtio_device_shutdown);
>  
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d9cbb02b35a1..8115aa39e01e 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	vp_legacy_get_status(&vp_dev->ldev);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..c9e21317c51a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
>  		msleep(1);
>  
>  	vp_modern_avq_cleanup(vdev);
> -
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
>  
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)





> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..8684a1e268ee 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -71,9 +71,9 @@ struct virtqueue_info {
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> - *      The function guarantees that all memory operations on the
> - *      queue before it are visible to the vring_interrupt() that is
> - *      called after it.
> + *      Wait for running callbacks to complete. Memory operations on the
> + *      queue before this call must be visible to vring_interrupt() calls
> + *      that follow it.
>   *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
> -- 
> 2.39.5 (Apple Git-154)

