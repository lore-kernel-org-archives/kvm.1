Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F13FFF85
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218397; cv=none; b=OSMk7ngfr7K5pdQePzgMfV+5vlYPf2hS5Hif9HBRwwzZbydGenv5OZwoDF9eGfMl46XZgsGsKs826ZX83OLU4sNFarD7s8XHsWI0Utr0yU4jq0V69fsiaS+GTND42R6nXGA/g2GpWga4KFo9R/ZJJOU0RLN4bBxVFSApPPuFAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218397; c=relaxed/simple;
	bh=kKKZU3L+6reK4B7gcJARVHlxz60vhrpuTNd2xoB+G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUFUPBE3PRxR8z9tRmW8H9xqKDSZZ70ZO8JxdxCJB3Inrht+DhlrIUy/7KWpKEn108t1FxL3pY6slD2mr/Iow+o9U0JWy9ZQddt/R5EZma4KJn1xbFjMyaE93IaerDhfiGGwSdCz9haZ62ApUUCUTTlIRA1A6ewQbWNYdlZyUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFHIhdnl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dt4uYwX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFHIhdnl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt4uYwX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784218394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
	b=ZFHIhdnl40KmeJeUXxYpHBY9XJi3UKPTWftXqBkOjcVJ0gpTxlRowXgPwVeZa9Wmht7aQO
	yZmKABUzP3GCEbcDMoCTyN16BCzXL4YpU3cMrD2p/AkUYmKcs9HCISQGVksoU0+VwS/CgR
	QYruB+G6pgLAWzH1l0IkV00OLV27Vzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-F0wzPFs3NX25ecu7ILCqYw-1; Thu, 16 Jul 2026 12:13:10 -0400
X-MC-Unique: F0wzPFs3NX25ecu7ILCqYw-1
X-Mimecast-MFC-AGG-ID: F0wzPFs3NX25ecu7ILCqYw_1784218389
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47485fde05aso4058136f8f.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784218389; x=1784823189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
        b=dt4uYwX7EYt46fsT6WqnWoMbi6wUVXURuB0b7YbA8MINGXJ4GP0h6IiazDw6NrVo7A
         /b8sepZ3CYyCY7uFRqz5m68Pkd+tbJRA36Y8jOpLUbrwEItNO9ELq2NDeDdOUg2hq11X
         Sep4/FS473fP7WqO/Q9fPhF9BBKKn9SdJ+uZD0IuZqoK2Sdn1BKr/RfSajd4NxNbpkU/
         ormc3uWp9A0FjHABDTZ2ioLt2lw0TpmqI02ZMWo2cavtvFyT5FbblvXxgbvyhRfuXO6t
         1sv0cW4cq6OUT5o8+K87mfqV7M1W9PMA/XU52OQporTFSCf7ooix8apM7GvcGyWI5v20
         2Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218389; x=1784823189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
        b=K6tP0cHQosIw+zrIYtROAV8EOmSreNm0mYOnDt1lgLqcPrY4Oq6+a7XCwqBdMJxTD9
         CBx+tRIdD5m8S319VNuBATveFi+y/Hp133ELFPlWDTAyQhl9n91LXGY0RjJRC1D3hMDH
         bgQxlk+YId4dtCGQFwtVQssAXkUmCJ2/3uN4O2pEfcCJXAewG04nkz1FWJrqwqtU6cLQ
         hWa3x5lhHWyaIRZgQHKBU2rxuxnzCFwR9T0w+q1surSwXB8Vnk9cbiqrSeVajqWmNHha
         T8T6Y6IAKShqK3LF4Qc7aAwSFpOzhrahD+L3Ctp8lxvC/XGSmzIrW00x1Bxj/qCKC5qR
         M+GA==
X-Forwarded-Encrypted: i=1; AHgh+RoVJmEA6f0DlJykd405VQBdTuo4OJFqf1Bxu8OrQ6z5inO2aB39TMvlmgESP9HJeQL9KS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdo48+K3Sey7k4DbW9/LTiAVjMDC82+KCSvSD83MAOydaWUryf
	Nv9O8lOwCk+z8GH0ewf6UW+PpovUDvysiTZ+SIkTTXlHHkB0UvYaOR9vn41wX2rvanoveP3EUCz
	90AzbWFEgJBUCRNNPLcgrb32OcS0QODluCX1KPIR64Wwe6F5ihJJnLw==
X-Gm-Gg: AfdE7cmUsVSEe2kfbM5ngz4l8gE7rPP0PWEvdLADnAMAYOST+pXNnYa93cQoCXQJsua
	nbG5TcCIvoEJRdg2dqrP8KEYAHbkA32UjcNpFbHrQ8K+4t7Jvf05EIfO77TBtwD5n6/EohlwTOF
	KXgLUdD2u3iEgAutcSREi6t/FkGJD9XOejGCg+bSvwGGk6bVspKD7HGaBgcLhurr+xVeLKaQfuJ
	+hxQc1LeJqV88yDjfrzcUvY4hn7Ob4d8tQYtqMF0IwLhkqO7o9VQ36BOARFUIiBFxW8OHUuwh26
	H3xXqOriTh0qD4CluLQONuLLTr6k7QHmQK2YWBxww28xjWSYlj5xuuq0JDoGSOxu6w3LE69+d4z
	ui//5AZpK2FBq1qZXc49zsU665ew3bfGqsPlUaZlFSuR+1vSvMA==
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38415255e9.26.1784218389328;
        Thu, 16 Jul 2026 09:13:09 -0700 (PDT)
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38414535e9.26.1784218388605;
        Thu, 16 Jul 2026 09:13:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm70836725e9.15.2026.07.16.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:13:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 18:13:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <alj_YKTitwqMjAez@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>

On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>> the vq->worker pointers and immediately frees the workers, without
>>> waiting for a grace period.  A caller that fetched the worker right
>>> before the pointer was cleared can therefore still be queueing work on
>>> it while it is freed.  And even when the queueing itself wins the race,
>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>> future attempts to queue it are silently skipped.
>>>
>>> None of the current callers can actually hit this: net and scsi stop
>>> their virtqueues before the workers are freed, and vsock unhashes the
>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>> the lockless send/cancel paths become able to race with the teardown.
>>>
>>> Close this the way vhost_worker_killed() already does: clear the
>>> vq->worker pointers, wait for a grace period, run whatever the last
>>> readers may have queued, and only then free the workers.  The
>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>> devices which never got an owner stays cheap.
>>>
>>
>> Do we need a Fixes tag for this?
>>
>
>I'm guessing it should be:
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>
>> Thanks for pointing out that the issue wasn't occurring, but I think we
>> should add it because it's a sneaky problem we discovered by chance.
>> IMO the code should already have `synchronize_rcu()` after
>> `rcu_assign_pointer()` loop.
>>
>> @Michael, what do you think?
>>
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>> 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>
>>> 	for (i = 0; i < dev->nvqs; i++)
>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>> +
>>> +	/*
>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>> +	 * caller that fetched a worker before we cleared the pointers above
>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>> +	 * to finish before freeing the worker, then run whatever they queued
>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>> +	 * vhost_worker_killed().
>>> +	 */
>>> +	if (!xa_empty(&dev->worker_xa)) {
>>> +		synchronize_rcu();
>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>> +			vhost_run_work_list(worker);
>>> +	}
>>> +
>>
>> Following sashiko review [1], I tried to undersand why we need this, but
>> TBH I'm really confused. That said, this seems wrong also because it
>> will work only with vhost_tasks, and not with kthreads.
>>
>> IIUC vhost_worker_killed() will be called anyway when calling
>> vhost_worker_destroy(). For vhost_tasks, it will call
>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>
>
>Hmm, are we sure it's the case for our codepath?  Looking at the
>vhost_task loop function:
>
>> static int vhost_task_fn(void *data)
>> {
>>     for (;;) {
>>         if (signal_pending(current)) {
>>             if (get_signal(&ksig))
>>                 break;
>>         }
>>         ...
>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>             __set_current_state(TASK_RUNNING);
>>             break;
>>         }
>>         did_work = vtsk->fn(vtsk->data);
>>         ...
>>     }
>>
>>     ...
>>
>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>         vtsk->handle_sigkill(vtsk->data);
>>     }
>>     ...
>> }
>
>AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>RESET_OWNER case:
>
>vhost_vsock_reset_owner()
>  vhost_dev_reset_owner()
>    vhost_dev_cleanup()
>      vhost_workers_free()
>        vhost_worker_destroy()
>          vhost_task_stop()  // for vhost_task_ops backend
>            set_bit(VHOST_TASK_FLAGS_STOP)
>
>So, first of all, actual work by .fn() callback is done after the exit
>checks, therefore we skip it - no chance to drain there.
>
>Secondly, the handle_sigkill() callback is deliberately NOT called in
>the STOP case and only called on fatal signal delivery.  And for
>vhost_task backend the .handle_sigkill() callback is exactly
>vhost_worker_killed().
>
>So my understanding is: if we only call synchronize_rcu() here and leave
>this path undrained, then whatever work which was put by send_pkt() for
>the worker currently being freed - will be lost.  Please correct me if
>I'm wrong.

Yep, your right. But what will be the issue of loosing them?

IIUC we are not loosing any data, just avoiding some works that will be 
handled later when/if will set a new owner.

>
>That said, I agree that vhost_run_work_list() will only work with
>vhost_task backend, not with kthreads backend.  If we do
>vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>become backend-agnostic. I.e.:
>
>> +       if (!xa_empty(&dev->worker_xa)) {
>> +               synchronize_rcu();
>> +               xa_for_each(&dev->worker_xa, i, worker)
>> +                       vhost_worker_flush(worker);
>> +       }
>
>With the last 2 lines being equivalent to just calling
>vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>guessing the warning reported by Sashiko should be dealt with as well.

I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call 
synchronize_rcu() in any case.

About vhost_dev_flush(), we are calling it in several places, and maybe 
we should re-check them. E.g. we call in vhost_vsock_flush(), but it's 
also called by vhost_dev_stop(), maybe we can avoid to call 
vhost_vsock_flush() if we call vhost_dev_stop().

I'm not sure we really need another one here, but if you think some 
other works can be queued between the vhost_dev_stop() and the 
synchronize_rcu() we are adding here, then okay, it may have sense.

Thanks,
Stefano

