Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8F3812E4
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023352; cv=none; b=g9kgYitotz6D9PPzwYf4U5fIe6wXJxvSjl1FSR/upbldYHxOBmIgb383aBVmZ+/tWluDvUorv49M7Qj9jYNkHan61q7j2o3QOif8scrd5lI+itu39Ul3ifWMdi7vn6l1htPsSaMQ9v8BTMb4HgTvyvF4bPuOCQ605wMn/NMjHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023352; c=relaxed/simple;
	bh=ObD7bPWSxhbklQOHrMfvrjgdmbGQvAlacZ3UlKZDW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSa66gX910DMfUz1jV0cXsiwqeltJ2QNBr92zObvZTbVgumTwon4SkmDBhCQGcz+mwmIjjYYELF+/TKt7N0haUMYay2AUcKcbKwlZ6hrC1vQ1VDZpph0GvQKJdUqy763XlZ2ki3Ml4L7KfZmw2mdTnOKXSHOm0JHBVpvXkWHHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDYb50vW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBW2twy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDYb50vW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBW2twy3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786023338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rILtqoeBHE7LGqRbLxT9biwUTl88ABJkJnpfbIm4pB0=;
	b=ZDYb50vWu4hGH63pBR4ioUf7l/utb1YDqsIGk6KTKvWQp75JxZwcBuzR5g1DV6xXz5vnRk
	RLitIP+2HOMjFg1M/Mtsjv4BhlkhQiJKMnKgGYt+AB2+jGkOSdnssjSy1ofOxQct5JXf0I
	xKvsHDKYZ8nuaa1sCLVb2HX6E/hm280=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-NzzVCsMNPOS3n6dAaM6QNg-1; Thu, 06 Aug 2026 09:35:37 -0400
X-MC-Unique: NzzVCsMNPOS3n6dAaM6QNg-1
X-Mimecast-MFC-AGG-ID: NzzVCsMNPOS3n6dAaM6QNg_1786023336
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-474170b59dfso1265989f8f.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786023336; x=1786628136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rILtqoeBHE7LGqRbLxT9biwUTl88ABJkJnpfbIm4pB0=;
        b=VBW2twy3z5dXVYruSZh4BbeqeNLSBAiXJuC2aBrZQVbuHUAYn7T2RGG+RVhjNf0Brx
         UoFiXNpGoXbAxw+37uaBMv7SHD/RchK0VRAG5QuFgaXcCBlwonb/mzwizHqSCMRAMb0w
         pDzK/07n+oaizJvClFilz2SfjNgYetiteux2LuGg4hIMT71uARvLVFbJORk+qXKpX8rK
         tWJKhvE1l+Ixyu6xrDJ8tAKoLHNBknIMIEL9soFUBkYLXgewmEbm5SXomNDyzGQv0yUK
         W7LD9ZBPr6UzFgj0G3lA1ggsOn6sbDMVmmNOVQZllh6dQYj+CB4LkeVUp7nLmkoFvY+c
         bnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023336; x=1786628136;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rILtqoeBHE7LGqRbLxT9biwUTl88ABJkJnpfbIm4pB0=;
        b=A+0C2G6kceHNUqtAo0HmgUR3Srq1C8j6UaW3hi0ys4+tykzSAp9+2+GGGDAe9q3BBx
         gmNEd7YYuK3340bqI+gIVkN7tBNdecdr/Bch24xSVuKHysxzCv90TAv7R/mBF2O1lCcj
         t3g2BSQ3aok7dN34Fm4aGHbBkNPdXOl7NYYY+FdAIxUfsQGimQkXaaUC04EhPSYSpK4l
         DMAZB/IztgEsaG2iQfhUR6lkJaS7SfWy7WIJxV3c2LBBGc3zwO1RvzbEStyVxa3PKt8A
         MwYvsXn+MzTMSzqWKVH9/89dc+Mha7bAAdaoAJFXHf/exCpS4n2fYlgrN5vK4bZRK2Hh
         mE9A==
X-Forwarded-Encrypted: i=1; AHgh+RoZbY+9bGhc2k4RAI3fhhkXqaNXqeMzUeB0tUo7fN1JzpLqTP9oTpfQ474xUkqwiaprpdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2SBK0uV2v+ppARwPpqgrLWc+qTF5OYF9YGAVvTR3gtxk01bU
	1oK8RZmRYFpGh/U2Qo/j1aUKVOm7mmiiiksXz8lukCj/Odb0xsof734YBABKpA6HB9fpIXMp92J
	moqp9C6ReQPnZnGvkRPA9LF/0zDpDb9ifSoajbDVqeGxv3jaWkTPCrA==
X-Gm-Gg: AR+sD12JH0nQbcXbLR+iw6KX4XxB4kygr3KkZJS9aTC6S/g+Ij7X8870c6G+Ss1bqv1
	+Pr7VqZIgsX/F6elRxIeYidx3REbbgmy3m4fKuLKfNJybxIlRn5xXX/1Z2iWBiDXNJ44bir8cr6
	xC+biRjRAWgsl/P/ZzHaNVJDsPxDdNtnzy/y6Q+7wiBdizdNsTiNFGoOS15hcXSVuKuER45BkcR
	Cfgf2gdEKaepO8KKwKr1RJLvYBH8QK+O/esqwfcwMmHrBU+OIbq0Gm4YFWsg5otgImacBv0Gi2K
	P10PwxnnrAonHQTx+DAKllwbIq0wVu5jr5dZgvZuwKYLVCZDA2fTRCSwkJdpw4FyiI8j/nswDk6
	2qAw=
X-Received: by 2002:a05:600c:8485:b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4994e7d646cmr224933985e9.16.1786023335695;
        Thu, 06 Aug 2026 06:35:35 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4994e7d646cmr224932915e9.16.1786023335225;
        Thu, 06 Aug 2026 06:35:35 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954228a47sm95181535e9.12.2026.08.06.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:35:34 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:35:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>

On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>Every other update of vq->worker is done under vq->mutex - the worker
>attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
>the sole exception: it clears vq->worker without holding the lock.

mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.

>
>The effect is harmless in practice, as this only happens while the
>owning process (and thus the whole device) is dying, but the lockless
>write is inconsistent with the rest of the code.  Clear vq->worker under
>vq->mutex, like everyone else, so that all writers of vq->worker follow
>the same locking rule.
>
>This issue was found by Sashiko AI review.

Can you share a link to the review?

I don't know if it's common or not, but having the link in the commit or 
after --- will help the reviewers.

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..dbb6cb5eccea 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> static void vhost_workers_free(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>+	struct vhost_virtqueue *vq;
> 	unsigned long i;
>
> 	if (!dev->use_worker)
> 		return;
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

Pre-existing, but IIUC vhost_workers_free() is called only by 
vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset() 
on each virtqueue (without the mutex) where we already set `vq->worker` 
to NULL, so IMO at this point it's already NULL, no?

Thanks,
Stefano

> 	/*
> 	 * Free the default worker we created and cleanup workers userspace
> 	 * created but couldn't clean up (it forgot or crashed).
>-- 
>2.47.1
>

