Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3829D260
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819902; cv=none; b=f3nuUzLr86A1ZngOX2CKfRYHvh6ziaUtx5qMn6FSS29TL1lt+dBNZDZ/V+JZKq9RDG7pjXyscuSth5HIvb2Bns9LB0f2N6qigLYdKoMFHyDP/+ShZvE2U8uvk0qUvJJbkcyKIFC7UGTXTqBrGItoMyuJJLvrZj72wP7Mb9ks8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819902; c=relaxed/simple;
	bh=rSe9HD907K8IRLWvdPwE7ouRnZKLSw9p6mExkMka2to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPIKTHLRpEhYrMxrI2Cxkh8xAu31LZz464670ccrkLtP4owxccfxQp1v/K55aFLaFKExWRPbSWhEjWmxPoll7raqGbQ4d4h5NXv1buK/uyCbYPocgeIDazne6hGNNDTqGUFhO3kFIcmWOi1h6HtA5HbaYEV7MHyEfn/ar5cyC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzENcHB1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkg1nX1Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzENcHB1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkg1nX1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784819892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
	b=LzENcHB1cpLjBEdZ9cuFWNVyohdTFmqAa5uS1Qe12rANZDve9zhxVseFElVf7pXst9gXQl
	RDr2tHAWamFHBsAgkwbkUq6vtPq+yuMrpPPXY77n4VvCCFAdCwm3Rh7b0pUYOQIASf0a7H
	Vl8cTZaFt8CghHIzzF8VvfxLetY4OfA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-16nyCpu2MPqKuaNKnLEOsg-1; Thu, 23 Jul 2026 11:18:11 -0400
X-MC-Unique: 16nyCpu2MPqKuaNKnLEOsg-1
X-Mimecast-MFC-AGG-ID: 16nyCpu2MPqKuaNKnLEOsg_1784819890
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f90dbaf84so649373f8f.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784819890; x=1785424690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
        b=gkg1nX1YT69VX0y5vDJvJlU5Ajwm54l9OrTPblcGsl7N/P5Q64J5ADGi3YYcK3keQd
         aPeOK8yxFJxjvp4sVV1AdSpW/VpQPV3d6YTctd6h4js2uObCoQBrJ0Dy8AnTOcm4EpIt
         kBe1hhAI+STkwIjJ5ccgisfMHwVaQrSjfcjqQYW1tNS0pXzOA4KJezqQ58RqlnqyizdX
         4Z7tkrjKNXmU4DSWLeKHZ5G6jqViE5mJJhe/OwgYis7okSKb4tkzaNy2kaDTlk5uUu0J
         lOsYmjp12snxs/7ILSF6h8QKQxAuNtEUdsmbe2NCvnoPPneEd16TgzT1hCml928Yn41q
         ty3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819890; x=1785424690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OUorP8L7Hv+mWbQVnXQe/Nap+PNXLSDh1VLwTpZtYE=;
        b=Ykt5B41WAAl3E3Dz7+xo8OMV7S/f6bzjWy7g/OZgI8gAVFoNOAttKDuD0tf5OT0mLm
         cXusD1r08o4jBhBaKIgFxrtn+h/Heqbh+MR2Dgmufe6VuM5S6+foKIscFYDZ/bMKZ+h2
         lvsw6oHzOkKziW4UBZJ69qcUliM9z9ZhuEXT76oftwQ4OsPIl59geargW5V9wYByR4ta
         p75NrDSzgs5ruCFz8pRXRC0Uc28RWSTcbsPtAHR8qLCdsaWIdMDUEckB6IBdinDfTWb4
         wKAmrxEozYFMkZ6+xVJ42H/18oJ18p/g9Vg7btHcjmA2jXJ0X5E0WVNkUBrmi4pLH5Qb
         Msbw==
X-Forwarded-Encrypted: i=1; AHgh+RopEKM6oc9tGv4JKmbyJzDiA5Dnc0qUtWH5KWakNEQOnEnDZIxhyx7jEE8c73GWCuZl4yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVTHFvWy7FozTkF9/JPhtzOTGJKLaQbuGj3/ND9s6JFK12E60
	1G+R9TRtG0d5Qtd7U7DajzGv1ZvM69ctDQDQhm7frAGSeREMGqYX1ukwzDbvI/b9qnh9JF2h2CA
	OvrnjJ1+cyMW6NgUGQO90/TNDeR7gxc8HmBapJ7d0mUibw2B+i+sxVg==
X-Gm-Gg: AR+sD12X5j4EdQOcpOGc5gRK329XCwNhy3gxmH+tuoC9DVKYtfHLsk8qYfZZvUjJ3n+
	fmgoypbiY2g/R+npAgKpbTcrh29VfFi+8ybQks9h6fHYtNvdX9n8gbygWQix8YXRG0aDactzUkM
	Y02whSY5ekScDCJoB/f39hSIlj/wEEu3NKWkttCbEOL0HKAjqSNUMUha5IhOmCzcGD5wi25IH9a
	NYN+g2bS7vfwvmAHtkGNvktNGuXg2RIjbdQh6UL9nZF56odx4vwLbBLrfqw/T03Qvx20Y+HHQZ3
	xOsBLjPl/ww6HNPXoSBn+WKHxnjps6PuAFEhKNAS82zDE5Kq1EAatQkGA+k0JuJS9lU9UsbY90Z
	22angURYL1QvqQeDhDCrpNA==
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641360f8f.32.1784819889716;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
X-Received: by 2002:a05:6000:4386:b0:474:13ac:a91b with SMTP id ffacd0b85a97d-47f8d7564edmr4641303f8f.32.1784819889120;
        Thu, 23 Jul 2026 08:18:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm16346454f8f.13.2026.07.23.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:18:08 -0700 (PDT)
Date: Thu, 23 Jul 2026 11:18:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <20260723111557-mutt-send-email-mst@kernel.org>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> vq->worker and queues work on it.  vhost_workers_free() however clears
> the vq->worker pointers and immediately frees the workers, without
> waiting for a grace period.  A caller that fetched the worker right
> before the pointer was cleared can therefore still be queueing work on
> it while it is freed.  And even when the queueing itself wins the race,
> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> future attempts to queue it are silently skipped.
> 
> None of the current callers can actually hit this: net and scsi stop
> their virtqueues before the workers are freed, and vsock unhashes the
> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> in vhost-vsock keeps the device hashed while its workers are freed, so
> the lockless send/cancel paths become able to race with the teardown.
> 
> Fix this by clearing the vq->worker pointers, waiting for a grace
> period, and then flushing the workers so any work the last readers
> queued runs before the workers are freed.




> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  drivers/vhost/vhost.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..d6e235c25254 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  
>  	for (i = 0; i < dev->nvqs; i++)
>  		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> +
> +	/*
> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
> +	 * reader that fetched a worker before we cleared the pointers above
> +	 * may still be queueing work on it.  Wait for those readers to
> +	 * finish, then flush so any work they queued runs (clearing
> +	 * VHOST_WORK_QUEUED) before the workers are freed.
> +	 */
> +	synchronize_rcu();



Any way not to add this for all devices that don't need it?
Or preferably, even for vsock in absense of the new ioctl?


> +	vhost_dev_flush(dev);
> +
>  	/*
>  	 * Free the default worker we created and cleanup workers userspace
>  	 * created but couldn't clean up (it forgot or crashed).
> -- 
> 2.47.1

