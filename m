Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4F3CF217
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536788; cv=none; b=ugfRwBlBzfUYA7hF/22Vzzb7NsU92v6r1PTo0mtyTuDrVmIx5LPsg1h8SHH/Cp1NlN53aQdr9jYiugv4WSS2JNmF3rdyxkxmy0fqNmZymhmYVt+OQadx0h1BMN8L/rjtN1HK+uFUh2BugwDwv3Vbzsy4Ed/oJKTJOLoY3Xv6lCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536788; c=relaxed/simple;
	bh=Q7+IJX68QjV8feATeOoFyhllZFT4t92bU6G47rqe348=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG17JZWBUAUAvQID/E1FpdFXYOznVpi76OlJkpZw8DxIB/vLz7pFbYsoQrVU3L07BuSuNEj+GN+iMHh1RZeVOGlgDDtySxLKwmQ8rKKE4l4B8MWKzuePwKtUXDsJehUn/WiZ0O8rFwDhSW/KnzSpbfBadZvxYjVZLZH7n5Wrv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC3+B/Bu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSx2+9Q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC3+B/Bu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSx2+9Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784536785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYv0JD6e9nQrV7B6V6a2cos4kkVgkS7qp+ggCOAYFgU=;
	b=PC3+B/Buvyw0dgCHrYf336qcMtL138DdO19CuDhl3+wOO3Tl/WVyLfzmoEbWuLKqlbt5tt
	lBcPzXJtf2ZKYkVeD5bZD/OqtAr2es6Zz7XOzCNdim6H5SHPnyjovbYG04fOLz4pHc6bmq
	DZBTadJzPCzl7lTnhFCf15LkphhdpXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-096_WTweP3STlwSZn_oMbA-1; Mon, 20 Jul 2026 04:39:43 -0400
X-MC-Unique: 096_WTweP3STlwSZn_oMbA-1
X-Mimecast-MFC-AGG-ID: 096_WTweP3STlwSZn_oMbA_1784536782
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so38317955e9.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784536782; x=1785141582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZYv0JD6e9nQrV7B6V6a2cos4kkVgkS7qp+ggCOAYFgU=;
        b=NSx2+9Q9AvBzrmp+vKhQ1rK2qBJxwn2FnQpYPuAyiHO39rofxZDyiuAeY8Gm7jpO8V
         L3Br3vCs2LqgwDoppg55e89947TM0VBuG9k5waAPCXA14Dyet0HW9J+n4f+lC9b0Rklb
         YtC79S/fkrqXdRylSbVKc7dT3cVT1useqmeR1nbH5xEsSSC33ay6qjOmNDJ1PWL+RnBp
         05iJGPzDUTbeCz9EJFrVjA+Ox5hnGOwmO61D9bHjMGRv7fGD+JihrA81jstFy75/LnT6
         Idt3vQsQpEEh3hH2MX1Sr772ILRyQjzIphrVIC+mtM/qDKDFxuB86p6fSBJazBQ/lb+y
         UhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536782; x=1785141582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYv0JD6e9nQrV7B6V6a2cos4kkVgkS7qp+ggCOAYFgU=;
        b=swJBeURb8DYLTXgWqer3RGLI9F4XPDu6VzdBDnSl+4q7GRt5JkGceFNgcP3VMxttID
         E89foQK42xWgreFnDj+SwekWX8EtBHnC4am4FnLe5Ck0/q8Zi/R69fr3/vMxzmo4tbCQ
         01FZj1DQB/2nAM05lpOXAp3HLgnrN+YVrdsHZ0M/MfHJyous2ywl40PPIMRP4ODb8kMX
         Tc4hioP4lqo4JKjjAKh8FSDmOnRTn2iNEGo4u4VOFn0Fteaf1kF/g2JpnMtg6WYxHEac
         e3Zw2Gpt8AKRbjxDwCltQjoORkUmFnMgCB93rx3P5GzEWzi5u1YnEZcSB71TH2Hy97a6
         GGkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfJNU6Qz5oIThmksE0NUpXnirvhLRiw+Y0V6B0nHAiFzuha2BoAjt9dzODqtQGrZq9QSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPWnN7ukT+QO7rS5t3eR4k9L5aMQ/ht3j+Yo0Pa+fKFT10bOt
	F0axmIdvYMXInfAI6yUdG99PyYpxTVlJs/rUzqQ54ljNwft7u4YiU9Se5ZpuMKUHyOwRQcBFR9a
	b+FTXawI5OVnPEyDtr+gng14PROVn5wGfavCBLUxo33E1HMFYAnwjqA==
X-Gm-Gg: AfdE7ckmwHzDI6Ta6cj/bMgXeReuBGUArH/lnFECdFSVDxPRhlilGqY/mAg6+HWQG6B
	6OY5aGpi/Bnf+jYyA083t6kT1/6SCl1Ik5VAmNOMRAxQaJjqRdNA0w//0ZAjJIeQuK6/c1LY0BI
	wND3pWV1CHdDHM4ZlVilssn1RxQTWQms2EokEozsNlaIM93o7yjzxShi/7nSXLaMzEk9rTwuwaV
	Nbygnv8H0uVhRxjneuvV/EgvA6bl/omrYzx55gU+Ae1bHOAJXr4VBy0v2FPXKgQW+Jpj4/lbR/9
	VNgKwIk5lf7AhyzOnZdM479HEq7ZmUTcohKhgxcC9sFiDLwskIrHwH6Eo6RCW38AGw/kGza7HQP
	MX+dxXlvj5jtvnirD8qs8FBIC8naq/fFyQQr5Jny/KULwA4fucg==
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr90343235e9.0.1784536782005;
        Mon, 20 Jul 2026 01:39:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr90342865e9.0.1784536781447;
        Mon, 20 Jul 2026 01:39:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954ba2abd0sm234410465e9.15.2026.07.20.01.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:39:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:39:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <al3bcMk0ZxMGq7Pt@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
 <alj_YKTitwqMjAez@sgarzare-redhat>
 <55d7c896-b871-4c50-a324-35f5c4a9d11a@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55d7c896-b871-4c50-a324-35f5c4a9d11a@virtuozzo.com>

On Thu, Jul 16, 2026 at 09:01:22PM +0300, Andrey Drobyshev wrote:
>On 7/16/26 7:13 PM, Stefano Garzarella wrote:
>> On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>>> On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>>>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>>> the vq->worker pointers and immediately frees the workers, without
>>>>> waiting for a grace period.  A caller that fetched the worker right
>>>>> before the pointer was cleared can therefore still be queueing work on
>>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>>> future attempts to queue it are silently skipped.
>>>>>
>>>>> None of the current callers can actually hit this: net and scsi stop
>>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>>
>>>>> Close this the way vhost_worker_killed() already does: clear the
>>>>> vq->worker pointers, wait for a grace period, run whatever the last
>>>>> readers may have queued, and only then free the workers.  The
>>>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>>>> devices which never got an owner stays cheap.
>>>>>
>>>>
>>>> Do we need a Fixes tag for this?
>>>>
>>>
>>> I'm guessing it should be:
>>>
>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>
>>>> Thanks for pointing out that the issue wasn't occurring, but I think we
>>>> should add it because it's a sneaky problem we discovered by chance.
>>>> IMO the code should already have `synchronize_rcu()` after
>>>> `rcu_assign_pointer()` loop.
>>>>
>>>> @Michael, what do you think?
>>>>
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>>>> 1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>>>> --- a/drivers/vhost/vhost.c
>>>>> +++ b/drivers/vhost/vhost.c
>>>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>>>
>>>>> 	for (i = 0; i < dev->nvqs; i++)
>>>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>>>> +
>>>>> +	/*
>>>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>>>> +	 * caller that fetched a worker before we cleared the pointers above
>>>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>>>> +	 * to finish before freeing the worker, then run whatever they queued
>>>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>>>> +	 * vhost_worker_killed().
>>>>> +	 */
>>>>> +	if (!xa_empty(&dev->worker_xa)) {
>>>>> +		synchronize_rcu();
>>>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>>>> +			vhost_run_work_list(worker);
>>>>> +	}
>>>>> +
>>>>
>>>> Following sashiko review [1], I tried to undersand why we need this, but
>>>> TBH I'm really confused. That said, this seems wrong also because it
>>>> will work only with vhost_tasks, and not with kthreads.
>>>>
>>>> IIUC vhost_worker_killed() will be called anyway when calling
>>>> vhost_worker_destroy(). For vhost_tasks, it will call
>>>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>>>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>>>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>>>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>>>
>>>
>>> Hmm, are we sure it's the case for our codepath?  Looking at the
>>> vhost_task loop function:
>>>
>>>> static int vhost_task_fn(void *data)
>>>> {
>>>>     for (;;) {
>>>>         if (signal_pending(current)) {
>>>>             if (get_signal(&ksig))
>>>>                 break;
>>>>         }
>>>>         ...
>>>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>>             __set_current_state(TASK_RUNNING);
>>>>             break;
>>>>         }
>>>>         did_work = vtsk->fn(vtsk->data);
>>>>         ...
>>>>     }
>>>>
>>>>     ...
>>>>
>>>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>>>         vtsk->handle_sigkill(vtsk->data);
>>>>     }
>>>>     ...
>>>> }
>>>
>>> AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>>> setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>>> RESET_OWNER case:
>>>
>>> vhost_vsock_reset_owner()
>>>  vhost_dev_reset_owner()
>>>    vhost_dev_cleanup()
>>>      vhost_workers_free()
>>>        vhost_worker_destroy()
>>>          vhost_task_stop()  // for vhost_task_ops backend
>>>            set_bit(VHOST_TASK_FLAGS_STOP)
>>>
>>> So, first of all, actual work by .fn() callback is done after the exit
>>> checks, therefore we skip it - no chance to drain there.
>>>
>>> Secondly, the handle_sigkill() callback is deliberately NOT called in
>>> the STOP case and only called on fatal signal delivery.  And for
>>> vhost_task backend the .handle_sigkill() callback is exactly
>>> vhost_worker_killed().
>>>
>>> So my understanding is: if we only call synchronize_rcu() here and leave
>>> this path undrained, then whatever work which was put by send_pkt() for
>>> the worker currently being freed - will be lost.  Please correct me if
>>> I'm wrong.
>>
>> Yep, your right. But what will be the issue of loosing them?
>>
>> IIUC we are not loosing any data, just avoiding some works that will be
>> handled later when/if will set a new owner.
>>
>
>But will it actually be handled?
>
>vhost_transport_send_pkt()  // called on every packet send
>  virtio_vsock_skb_queue_tail(&send_pkt_queue, skb) // add skb to list
>  vhost_vq_work_queue(&send_pkt_work) // try to arm the work
>    vhost_worker_queue()
>      if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>        llist_add(&worker->work_list)
>      }
>
>So send_pkt_queue is a list of skbs, it lives on the vhost_vsock device
>state, and survives RESET_OWNER.  In that sense you're probably right
>that we aren't loosing any data.
>
>There's also send_pkt_work object, also living on the vhost_vsock device
>state.  So we're accumulating skbs, and then send_pkg_work gets put in
>the worker task list - but only if it's NOT already armed in there, i.e.
>QUEUED bit is unset.  And the bit gets cleared by the workload callback
>- for vhost_task backend it's vhost_run_work_list().
>
>The most important thing is WHERE this piece of work is being put.  That
>is worker->work_list - this list does not survive RESET_OWNER, as we
>free the worker in vhost_workers_free().
>
>Now imagine we have RESET_OWNER racing with send_pkt.  In
>vhost_workers_free() we acquire ptr to a worker but not NULL'ify it yet.
> Then on the send_pkt path we arm the send_pkt_work, set the QUEUED bit,
>and place it on the work_list of a DYING worker.  Then the worker gets
>freed.  Now we have send_pkt_work (a singleton struct) with QUEUED set
>in its flags, and with no worker to walk through this piece of work and
>clear this flag.  As a result - send_pkt_work can't be placed in the
>list of any other worker, because it doesn't pass the "if
>(!test_and_set_bit(QUEUED)" check.  Thus no new packets can be
>processed, and the connection is stalled.
>
>Does this make sense?

Honestly, I don't see the problem. The device is about to be stopped 
because the VMM is resetting the owner, so the connection is going to 
stall anyway, since I don't think the guest will never answer, isn't it?

>>>
>>> That said, I agree that vhost_run_work_list() will only work with
>>> vhost_task backend, not with kthreads backend.  If we do
>>> vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>>> become backend-agnostic. I.e.:
>>>
>>>> +       if (!xa_empty(&dev->worker_xa)) {
>>>> +               synchronize_rcu();
>>>> +               xa_for_each(&dev->worker_xa, i, worker)
>>>> +                       vhost_worker_flush(worker);
>>>> +       }
>>>
>>> With the last 2 lines being equivalent to just calling
>>> vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>>> guessing the warning reported by Sashiko should be dealt with as well.
>>
>> I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call
>> synchronize_rcu() in any case.
>>
>
>Agreed.
>
>> About vhost_dev_flush(), we are calling it in several places, and maybe
>> we should re-check them. E.g. we call in vhost_vsock_flush(), but it's
>> also called by vhost_dev_stop(), maybe we can avoid to call
>> vhost_vsock_flush() if we call vhost_dev_stop().
>>
>> I'm not sure we really need another one here, but if you think some
>> other works can be queued between the vhost_dev_stop() and the
>> synchronize_rcu() we are adding here, then okay, it may have sense.
>>
>
>Note that in our particular case we're gonna do:
>
>vhost_workers_free()
>  vhost_dev_flush()  // the flush we're planning to add
>  xa_for_each(&dev->worker_xa, i, worker)
>    vhost_worker_destroy(dev, worker)
>  xa_destroy(&dev->worker_xa)
>
>So we walk through the XArray, destroy workers in it one by one, then
>destroy the XArray itself.  Then the next time we call
>vhost_dev_flush(), e.g. from vhost_dev_stop() or wherever else, it tries
>iterating over the XArray which no longer exists - which is gonna be a
>no-op.
>
>Now, we can reach vhost_workers_free() via (at least) 2 paths:
>RESET_OWNER and device release path.  On the former the flush is needed
>as I illustrated above.  On the latter it's indeed redundant but is
>cheap as it's a no-op.

Again, I don't see the need for it TBH, but at the same time, I don't 
think it's a problem to include it, so if you think it's necessary, go 
ahead and add it.

Thanks,
Stefano

