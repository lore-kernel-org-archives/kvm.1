Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5328CF5F
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713424; cv=none; b=epb1jdEOfypiBV5hGoY5zl+ByDQvAZW/op1FnfDSkD7Qv0hjaXUsJ5QpVm6pP3y60Dy696ViZkwBNDGMDff2D0RHpowjYeI0S5rQhF4HS3rcTxhbKNXiBbm2OhjpSZqMid7SdkspBENzbPJuSxwKuDUZAc7rMRFZLQmcgtRF8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713424; c=relaxed/simple;
	bh=0Yu4rlSKE6ROlYI+xvQFCojN8cuCLeFtTpz/TZVKheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xklh6O60DBvZabxiwYtS1kvc/2JzJ0AZ5xMatQEz9RVB/6wF1fvzX4SkzYYjgyxcfduSaP3CyyV9VaG0Hoa8yTGbmj0UoqdxjQFhbT5DaBDxdLyzjKj9rVNg5Z/IqalX5FUsiwC06FDt5sRgIlY6S6ZFARtQhQj7knxB9x5NNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlEBd4UO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m4iGIw4f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlEBd4UO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m4iGIw4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784713418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qKPjC4I/XXec2U4Xjf51wijAauyxem8KgFjfP+Lbs8=;
	b=DlEBd4UOWy1JooXFCICfErUOmkGX2kNPeWuWyvk6DC/XjhUK5Ed4o5wS148UP+xZW+oxZQ
	gcxelNvAMDRSXNMnxWbfY+AIVNgzJ+gCe4LMwKOK5mopjszjOdZfo5d9QKMkVki+IV/0e+
	GNJofbLDZ/pIsGqVyzK9RR5xJf9GY7I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-UPyGnqOnOUGmZBYk_cu8Cg-1; Wed, 22 Jul 2026 05:43:37 -0400
X-MC-Unique: UPyGnqOnOUGmZBYk_cu8Cg-1
X-Mimecast-MFC-AGG-ID: UPyGnqOnOUGmZBYk_cu8Cg_1784713416
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so163297055e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784713416; x=1785318216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qKPjC4I/XXec2U4Xjf51wijAauyxem8KgFjfP+Lbs8=;
        b=m4iGIw4fwMJ4eClSg4VQcJJ7nO0RUDgRRwOgdEklc68gUDuxiMNbBggNaIsUPuK8fR
         8USwE3AvOROPdKhxhfDEgtIkOC0gpkcPqe9nABLTRuGbDjcqz9U7Tj8s+swjAlFSv8qX
         uatAXgHpoe40T2A3OkRaWEsQNHZZrD+vhkXmAkY4bfZUqS/fYKAwcrlX4NNhDGssPpNc
         LZSpGwzDfjNrFgwJzl/hhAspG1Gy14/J0Ynum6kSD3CQLi47dMqdiEszi5FNl9gJ4Qgm
         FpjJI1i0t+8ctJnGxUtxfIYFGFePXmotNFCCZC1XYjWIY9X+UKXu9h8V0t4k3cXxie0P
         1jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713416; x=1785318216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qKPjC4I/XXec2U4Xjf51wijAauyxem8KgFjfP+Lbs8=;
        b=iOtAibFO9+7me6mJMv3vW722VmL3qAfhUuwwpCImt5sDkWQCfeeyTSoWKIiYywRikX
         r7gHt6s7hVTDBotO8uk0S5ljg/OmMx4/eXsJMcRS6Y9SQNqCpK7+FrBQmFiMzZKvcvOk
         HE0XZppj5STJ66oyBieM4QmlvX3UaxlJRJamCA3mGAryZ0Rfb4yCJ8YDGGvzYOS+FkES
         tNZtTCiNBcjFyMiwENw+veAN+RSe7Yn95pvgEzKscNBcLv5aH2YwaI7TFmYSH9IPTkaY
         r4J34aV+Dgx3jYIHPORValolkSLoUFJvUuM6Xai0LW7EQa2aK6GYx59Rln8QyNuRGwQ4
         v59A==
X-Forwarded-Encrypted: i=1; AHgh+RoNhX70LaEIhwo8j8ckHU7c9U/IrKGiifum2UGvCjkMGU+0B5gRQwqTRCXcTnUmHWj/8O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ebo5HOOtiHjKi7/Oh9Eczm2eOdBIogUyOK4HTMZUIqkGK09g
	ALs/g7Awc40pgUWgBl8daD/NS7ITt28BtCjJWdvGur8hYJYeLJZTqEbUFoaOIInVlifGhGfuVUA
	i3UOyVdE1C17AZkSt+UbAbTG820xnygtkWzzwgLA4J4sDXs7bvyOZrw==
X-Gm-Gg: AR+sD13K7i9+GBVX1Ekn1ZkuzAovyqnu/QudxzLMhK69JJuPp5bNX4vWZBaksYHcH9I
	3M/J2dNMQE1lUMrkavncJBFyFH1+VP28aMOFsll7TaA/ztm+77xYWn7bW82A6py5JzoReZOccB/
	byEjsQ3iiLKN02KpyDxZo2lojGhOELSUvw5iA2i7FrOk/0As4A/Ke7jHyIwfvS2Y49DWMrjC22Q
	dlw+wk0M5tz3m0SjlNC3tJU7JWHbQYLLARS9c+vZRUXJvvVz4I5nv/m5FpaXALov126IXYTR1Tn
	tV4Vuh9EdrI9v0HXne0NQR5AdNj7wpLodsIomB9cfdq8jHYJcBLPfsZRy1Wx/IVO4xeuRMPEPYq
	dPsxiexEV8dqg1nuk1Oszkka0Ozn44TmxNSQYaBmnmbmDCAan4A==
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id 5b1f17b1804b1-4954a4104e1mr155441665e9.29.1784713416072;
        Wed, 22 Jul 2026 02:43:36 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id 5b1f17b1804b1-4954a4104e1mr155441405e9.29.1784713415638;
        Wed, 22 Jul 2026 02:43:35 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm4825813f8f.12.2026.07.22.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:43:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:43:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amCPLOrnpYmr5n0p@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>vq->worker and queues work on it.  vhost_workers_free() however clears
>the vq->worker pointers and immediately frees the workers, without
>waiting for a grace period.  A caller that fetched the worker right
>before the pointer was cleared can therefore still be queueing work on
>it while it is freed.  And even when the queueing itself wins the race,
>the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>future attempts to queue it are silently skipped.
>
>None of the current callers can actually hit this: net and scsi stop
>their virtqueues before the workers are freed, and vsock unhashes the
>device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>in vhost-vsock keeps the device hashed while its workers are freed, so
>the lockless send/cancel paths become able to race with the teardown.
>
>Fix this by clearing the vq->worker pointers, waiting for a grace
>period, and then flushing the workers so any work the last readers
>queued runs before the workers are freed.
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Sashiko reported some potential issues here:
https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4

IMO the first one is pre-existing, but not really sure it is a real 
issue since happening when the worker/vmm is going to be killed.

The second one also not sure if it's an issue since the sender is not 
lockless IIUC.

But, please can you double check them?

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..d6e235c25254 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>
> 	for (i = 0; i < dev->nvqs; i++)
> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+
>+	/*
>+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>+	 * reader that fetched a worker before we cleared the pointers above
>+	 * may still be queueing work on it.  Wait for those readers to
>+	 * finish, then flush so any work they queued runs (clearing
>+	 * VHOST_WORK_QUEUED) before the workers are freed.
>+	 */
>+	synchronize_rcu();
>+	vhost_dev_flush(dev);
>+
> 	/*
> 	 * Free the default worker we created and cleanup workers userspace
> 	 * created but couldn't clean up (it forgot or crashed).
>-- 
>2.47.1
>

