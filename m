Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466C3E1203
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216365; cv=none; b=qr+qeViVNP93xu1qcncFOaekcqbItzeD3dDwOdry6V5ENKWmT2T4v7QDWJ/M5AJW86ORFbM9dobR3GE6jx8MwU/DzX1ssxiaORBszqfi4fR7C19MB5DLndRxFBhvAnI3kcy+IBujzGWFSNciG/QjCHaQNygPTP432tcnebuMWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216365; c=relaxed/simple;
	bh=A+zUCLXifVgTuHB4fPwTYTmQVtckKJL/x1J77vP12OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWelxz8E4A0iDtjvcZ3d/irzQvY0dwFb7vP8lrW8gDwuZ/9H8LLyf2BuV3lhHptqxI8yVIhFkGUDNdgopUxSCx3IvXY3fhjO1/CBoR1J8q9frw5xaQgrqX+9b6hrG+Pjbv9PlFafJ6mou7O5M3IYp1dmadxaC946FbQg8aAZ0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnvSgCcU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCjdRYzk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnvSgCcU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCjdRYzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787216362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTl22GoWoyN6aViItfu2yJEcGK2iytdtHBsWnD7u58U=;
	b=DnvSgCcU3U6O6jWd6inFHOzD2W+28rTrSbAFdLqeUYDcKt4ACYMeO6IA1Xqibzd4wHQ6x/
	ZqizsO7qPCvKflRwWoQlcVwyH1na4vvaa0GqPelg3whVAbMfl2uuiQI7qX247DaB6JFuI6
	Cdf0SCsC5aw37f6MYBNzU2ylljtEeK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-TYMqkTFtP4aj7ImQcXIAzA-1; Thu, 20 Aug 2026 04:59:20 -0400
X-MC-Unique: TYMqkTFtP4aj7ImQcXIAzA-1
X-Mimecast-MFC-AGG-ID: TYMqkTFtP4aj7ImQcXIAzA_1787216360
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so16773415e9.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787216360; x=1787821160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTl22GoWoyN6aViItfu2yJEcGK2iytdtHBsWnD7u58U=;
        b=dCjdRYzknoSPA1GUALnN/oLKs5uka8sk4BAYk+tobMmfIo3QTfko7dFt1wX7WJ4atM
         2KVh+tblDIxXoxL6O8K97Rzya2VU9OLeqlXLpFxOEQacvyzddtqWggRuwKo+xws1+YDA
         a/E+zFpBHk+pe6IO6YUOcnmOEABM5F7Dgxcg+BWAkiMMyFX6a66cTdU8dGV9vOjTVJ4q
         /4/mOehBg4GwZe93xA2dBYhryIFkQz0+7Cf1hwhTDEnTzzMMskrSTfafl4YSkJ1CLIkP
         ha3xGzOUjGfCZ1svghEIjoIxyaxFUKVsn0CrYLDfe0GpVmpVBEqnbwI6MY4+6Z4VzPpK
         C4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216360; x=1787821160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTl22GoWoyN6aViItfu2yJEcGK2iytdtHBsWnD7u58U=;
        b=lA35RXJmr9A/P1AA//WnJaOJkBxbbJVBZYZ1xoScw7jEw0837I6XpYhE0hBGnBtkyK
         cBRyoum45cyxys4nxXjE4EGXC0XbJDln9jVyOAcwlt2D8OBpFrVEzM4rhAEqor+wNYzq
         lxQ7szyIHuL14sNCFlJwJooXCVFtpE2hZnwD7JUwxGssM+GBQongG4Zqckx/0afJAdqy
         6JFO6/J/3yI77WIbwH8hwZlUH5u1lIcFkrojItzO17nnoqdrm/vV9vpliG5yrz3Z/bOH
         thlkXg3uquC9RLmviQ2jOxwRzZJ8Gw4XFukWvRuREsxoEzbDVOwrVoQ77y1VIgJA5DpM
         hU9w==
X-Forwarded-Encrypted: i=1; AHgh+RoL76Wfv573mo7kgiw+i7qBHtWIlzSYnvVCNWtuoSQc574m5MNVlki2/zdulgXK8rMAdi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OhoN8s0LHMhYlRtcma98LxiZvK53ss9qFqA3xW8XDV7Jx6G3
	ibkc/3JQ6UZfdDGmr9+0jM5iHRSlu364O94Yh59Uzhw3FZy2VjIM/3BoTOm0wH2szrH3hSbCMU/
	+Fo7d8Pueikieso4qPU/XSVr2T7dREGxItTuxB248m9ekCjlX25GZYA==
X-Gm-Gg: AR+sD12cTq9VdmdDcdLMuRDNbUsfGHaGQ4CC2Nx4E/kx3oYtplMytq6kRBwM7OBj+Px
	lUpehGpexslnfbs+Qqo6/ebZdJGdXLVbhEMY4A2yIiqXN67+riYltuuLtPbIElyrNqUFSbTvXV3
	G/c/axKqOOPjRdgMeXdd1BVmOer2NaNFoazFi4kuQ4k/wN5/iTw91WwGAt+vD/KiHstE6qO9ZpG
	gfU1LNcLqdJ0RoQomA18X9kddndg8MNhejt5hbT+BM9nhIJhprc2Cw7o/EidutiPxZki5pot4+u
	F0OLF1TTmarvdgEgQcGq715YPDYS/0bljZ0PSoU8N5jZGHwiucLR71AC775V0oY424H0kMGVZIT
	H3V6G0rD5bMUK0vF5EI5+zosIwTEB41RneJuYEA7qFlGiMOupXm/g
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-499aa109edbmr172010355e9.0.1787216359743;
        Thu, 20 Aug 2026 01:59:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-499aa109edbmr172009765e9.0.1787216359289;
        Thu, 20 Aug 2026 01:59:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b3c556a3sm17318315e9.3.2026.08.20.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:59:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:59:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com
Subject: Re: [PATCH v2] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <aobAlM7l67fpDaPO@sgarzare-redhat>
References: <20260819114328.426131-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260819114328.426131-1-andrey.drobyshev@virtuozzo.com>

On Wed, Aug 19, 2026 at 02:43:28PM +0300, Andrey Drobyshev wrote:
>Every other update of vq->worker is done under vq->mutex - the worker
>attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
>the sole exception: it clears vq->worker without holding the lock.
>
>The effect is harmless in practice, as this only happens while the
>owning process (and thus the whole device) is dying, but the lockless
>write is inconsistent with the rest of the code.  Clear vq->worker under
>vq->mutex, like everyone else, so that all writers of vq->worker follow
>the same locking rule.
>
>vhost_vq_reset() also used to clear vq->worker locklessly, earlier on
>the same teardown path, making the write in vhost_workers_free()
>redundant.  Drop the clear from vhost_vq_reset() and initialize the
>pointer in vhost_dev_init() instead, so that vhost_workers_free() is the
>only place clearing vq->worker on teardown.  Any work queued while
>vq->worker is still set is drained by the synchronize_rcu() +
>vhost_dev_flush() in vhost_workers_free() before the workers are freed.
>
>Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>Closes: https://lore.kernel.org/kvm/20260721102325.1BD6C1F00A3A@smtp.kernel.org
>Link: https://lore.kernel.org/kvm/20260724153334.1BCBF1F000E9@smtp.kernel.org
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
>
>v1 -> v2:
>
>  * Drop the lockless vq->worker clear from vhost_vq_reset(), initialize
>    vq->worker in vhost_dev_init() instead;
>  * Rebase onto Michael's mst/linux-next tree (with my previously merged
>    vsock patches);
>  * Add links to Sashiko reports and adjust commit message.
>
>v1: https://lore.kernel.org/kvm/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com
>
> drivers/vhost/vhost.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a0c1d54019aa..5764a54ddc92 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -392,7 +392,6 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	vq->busyloop_timeout = 0;
> 	vq->umem = NULL;
> 	vq->iotlb = NULL;
>-	rcu_assign_pointer(vq->worker, NULL);
> 	vhost_vring_call_reset(&vq->call_ctx);
> 	__vhost_vq_meta_reset(vq);
> }
>@@ -613,6 +612,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 		vq->heads = NULL;
> 		vq->nheads = NULL;
> 		vq->dev = dev;
>+		RCU_INIT_POINTER(vq->worker, NULL);
> 		mutex_init(&vq->mutex);
> 		vhost_vq_reset(dev, vq);
> 		if (vq->handle_kick)
>@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> static void vhost_workers_free(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>+	struct vhost_virtqueue *vq;

nit: `vq` is used only in the for loop, so you can move this declaration 
inside the loop. (I'm not asking to respin for just this)

> 	unsigned long i;
>
> 	if (!dev->use_worker)
> 		return;)
>
>-	for (i = 0; i < dev->nvqs; i++)
>-		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+	for (i = 0; i < dev->nvqs; i++) {
>+		vq = dev->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		rcu_assign_pointer(vq->worker, NULL);
>+		mutex_unlock(&vq->mutex);
>+	}
>

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

