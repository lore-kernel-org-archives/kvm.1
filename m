Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F833CF694
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192259; cv=none; b=RlrpLkt7kR8ZHf0CyJD+uHNtMrjamidv+M2WzAiTo7Y93CDI3ovBpp2tQUtVjlkosBcfwSmC0u/ENbkc8J2PEmnEBz2960BRUEtq7buzryV8WyCe/0UN1z9+r3oU5IlXO0yx6mCKM11dRb5uNZ3M7NYkt46HZ//d7M4jH4r4WKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192259; c=relaxed/simple;
	bh=mEjKg4AVLSWrUhKw9xfuQN61xzTZPl4Xk3fNow6F/Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcNPnE+DnIFtc2M420dTRaamKu+6MrA5FB6OI7ZTUbvFqii7eyXdsIWJrSa2UjKcRv7JYtdyTtisL/9Df9swosimBDiRSVG2diCuYaJ/LEnpQZkenEZCU3ai2S+VzjyM1OY52h7hSQlmfFyJ8p1B8BYr8oRbB/E2m9fOKcuhijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQDgewVY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXGnpmu8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQDgewVY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXGnpmu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784192251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhxSO78Yf0RPA4wZRxf7Fd3u153hjXB7c8vtU2XnoBg=;
	b=ZQDgewVYA7DD3oe3ZVg7jY2BgmCNKBbSe+t26Dduv/9uLyAEG8niz/ouldT3Yu2mavRP3H
	RLy48DgJ8HMWcxr3iGRkFnZ1CxcKqds2bWSLT3qClC+rNKmeeSNJFhZatFJe/tzBW/hFue
	RbhoevmmxkMlY6SpVL/IvjwxvCruQw8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-WAa0U2IPMwihLyDxeJeIPA-1; Thu, 16 Jul 2026 04:57:30 -0400
X-MC-Unique: WAa0U2IPMwihLyDxeJeIPA-1
X-Mimecast-MFC-AGG-ID: WAa0U2IPMwihLyDxeJeIPA_1784192249
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-474170b59dfso3549961f8f.3
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784192249; x=1784797049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FhxSO78Yf0RPA4wZRxf7Fd3u153hjXB7c8vtU2XnoBg=;
        b=PXGnpmu8dok8k9tzU3nIvPSEnkW6Wz6OKd19OrLDlcn/LkKcai0eezaT9/Ou1qhODf
         CiJwLHf9mJVlx84oQj+LQKNzxJhFmTj92WnfgMYzx2hSDHrwbB7xnBk+Y+M3Ml+8ldnL
         sSQSbkbUrJwcLvSvS9fFY+Vnq/UCd1v36RhwZ4SipNNAA/vat80K2yGmCCI8trLvAb56
         ifXCqFUm5vlFtFp1vX/KT/96hN2P92tws7HlECHneN6ZhJ/DI80cWKwPujW0NZgegdqk
         RAkGnw+IYFB03o198jILu0sm9a60RhYnrFDNUMxlaj1oX8i91wbNSmbzl6zf0aD4C0oc
         mthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192249; x=1784797049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhxSO78Yf0RPA4wZRxf7Fd3u153hjXB7c8vtU2XnoBg=;
        b=LLMcjcEIVxIv2CStSPXCEHZFBo5hoGVKKuYFaNwIJ9J2NAYopYJoMWStbAiKFOemuI
         PpJiEL3EnZTjxRNh8MmaOkFtkFLq2y1hCIBgs66lc/55dm8QI4mKUnPHXfGFzhbXqTUT
         TQfZ7e4uSwkqGM3uhIj5U9n/LM/L8NJCF6v1zbt3zIN2q/dMgRi8ABoM2a6Tvw8uI2+z
         C51oj98B+5ePbqwXnPZGHPhaH/1GWHgvb4rNeGgi/yuycFrjm8Kbe6dmV67SIQKNZtx3
         ALySj0f6rLutHGoa4Wo4Oh2MA5nKJObw7cAT7EdMre9HiZaWFkPcTy9BXNxDlULNW4/S
         6UEQ==
X-Forwarded-Encrypted: i=1; AHgh+RouKtlhL3k9whU5rmgwv+tu7qu6Z6HvvI0fbfJEIdbjHgwVgTIxm4o2buJndb88FyR3d4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WhGcNoW3rt0AAQFQ9+h88KFaMDCmy0sb04ga5/u3uH1rY7uY
	Md3nb3E3JxyX2dmf+cbnOfBJ+sPkKhBC6zvgcQdFDSqgsBfun9kWuKJzkYgMgTAJ0IW0LyBcbX7
	mpv+HbERDFb+V57JCbQTWPc5kpeJs/BGgZAfDIuX7bchJ2xKmnMlgmQ==
X-Gm-Gg: AfdE7ckDBEzZefZFb+gkj8UuHsO6ZRIp/UMWMb3CJmul3imtKA+KUDQ+yy5Q2jOV7PO
	SSs/XAboUjbHYxAeLIUUnvwSqRWcucMW55TtgkA9D+P0XjqwEugmokec62imwQiSuU7wdTvQAKX
	73Z8dpEDuDuAxGOVwdbEWd0bc/ZEbcvsSTbwvTs3MRWy3TG5qDPEZw3HfYe0s8oU9StOo6Q+KKd
	uOKx21SlxrDwuFpvfjAsVZQUI/6WIuVRCvwoCuo/yMl/hmARy1JHN6IKSmomEbR0ilhmvVFrI6v
	jcJF2LzPL+wsqNDN9QpDmaq3t0ogpfj7ihpLERr096jwG2jNcV0wGxuvsDIJZsJfHPSpeJjz2FG
	AmtOnobI527Zec7CRM5GnvJdquHL+MG03wgUsbWzJ/HYEva+cww==
X-Received: by 2002:a05:6000:46c2:b0:47f:5298:a010 with SMTP id ffacd0b85a97d-47f5298a31emr4384417f8f.41.1784192249020;
        Thu, 16 Jul 2026 01:57:29 -0700 (PDT)
X-Received: by 2002:a05:6000:46c2:b0:47f:5298:a010 with SMTP id ffacd0b85a97d-47f5298a31emr4384387f8f.41.1784192248495;
        Thu, 16 Jul 2026 01:57:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm20900447f8f.15.2026.07.16.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:57:27 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:57:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <alibLtcrC7o5r4Dh@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>

On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
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
>Close this the way vhost_worker_killed() already does: clear the
>vq->worker pointers, wait for a grace period, run whatever the last
>readers may have queued, and only then free the workers.  The
>synchronize_rcu() is skipped if the device has no workers, so cleanup of
>devices which never got an owner stays cheap.
>

Do we need a Fixes tag for this?

Thanks for pointing out that the issue wasn't occurring, but I think we 
should add it because it's a sneaky problem we discovered by chance.
IMO the code should already have `synchronize_rcu()` after 
`rcu_assign_pointer()` loop.

@Michael, what do you think?

>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..0d1414d40f4e 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>
> 	for (i = 0; i < dev->nvqs; i++)
> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+
>+	/*
>+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>+	 * caller that fetched a worker before we cleared the pointers above
>+	 * may still be about to queue work on it.  Wait for those RCU readers
>+	 * to finish before freeing the worker, then run whatever they queued
>+	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>+	 * vhost_worker_killed().
>+	 */
>+	if (!xa_empty(&dev->worker_xa)) {
>+		synchronize_rcu();
>+		xa_for_each(&dev->worker_xa, i, worker)
>+			vhost_run_work_list(worker);
>+	}
>+

Following sashiko review [1], I tried to undersand why we need this, but 
TBH I'm really confused. That said, this seems wrong also because it 
will work only with vhost_tasks, and not with kthreads.

IIUC vhost_worker_killed() will be called anyway when calling 
vhost_worker_destroy(). For vhost_tasks, it will call 
vhost_task_do_stop() that calls vhost_task_stop(). This sets 
VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing 
stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that 
is exactly vhost_worker_killed() you mentioned we are mirroring here.

So, why we need this?

Should be enough to call synchronize_rcu() in any case after the 
rcu_assign_pointer() loop?

Thanks,
Stefano

[1] 
https://sashiko.dev/#/patchset/20260714151638.143019-1-andrey.drobyshev@virtuozzo.com?part=4

