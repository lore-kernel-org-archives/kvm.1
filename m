Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FBD471D0E
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818524; cv=pass; b=swAVNghkiqfV87KC0XxSTfdQHq8QQnRBHcJakDXweCB/e5FnRn4pxOfdwr00LHgYXjcEhqwD1SWXMyI/OaRJbNOuMQEy2O/IVOGRHPvKPRiTyaAoroAdZ7rjE2t5qbcE2jh66FLADVwlm9TaBRy63CIK5Ve/lIeHVMfE87TE1hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818524; c=relaxed/simple;
	bh=bvzchvlbWRbtbpWI65b+DUHjE3nGDJFevXw6NngY7so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KktRvydq72Xav2ho6NxpJb1XL9+dpDLKaQN9Ksix5a1w/b1nThBc5iB+C0QpySTPaIN6xdvbWOpnJs4XFyTT1mVQTSWeThCY2vwT8VohIqFPgB3tRqxf5zR4iGLxYErUQeogZ8he+G58M87o49AiO4bogA1EmHH62gsEK54BE2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmvIXNMs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tOot7o4y; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmvIXNMs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tOot7o4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784818520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvRd2eLeia2aUi9lVvFJVxAc4QDqtKWTlVyNMMnyTyE=;
	b=XmvIXNMs15v6x1ZnhpFXROCup68ZtB5GbTcc6HKX2NRIYx+Kd/1kI74PBKa9c6vGgVVWN9
	HBJwtnRLLfJJmrvpD+rpA2ef2FIPP+JddgXdo44KYJvu1qF5JsDOTnGdrcBytS31VJ8o1l
	di2cpJg91/XEpNP9aEnbfcQaAqReU0Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-xH6lec3ROdasRNJLYrZWoA-1; Thu, 23 Jul 2026 10:55:19 -0400
X-MC-Unique: xH6lec3ROdasRNJLYrZWoA-1
X-Mimecast-MFC-AGG-ID: xH6lec3ROdasRNJLYrZWoA_1784818518
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccafc5e82cso12653265ad.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784818518; cv=none;
        d=google.com; s=arc-20260327;
        b=CvCs/ewEHAaiVzBwzHJBbVoNjtMDtj1kZ6+xb2T9pObpBkWj5BOsaIpc2yGhHhGiIy
         eIPr/+E2a2CafoJAxhKv4evu1kAI+wjMjJufrGSMsnVRyb4gyZn2t6HdbxhKNfP738nL
         rgRyhUtlRlwJl5dVPtKtTn/0tGvRuun78TALkJSYzOdNU4wUyUMfmU5nmTTJa7pGwLfP
         zu7A8wgd1iDTqsUXbagT4mdVntXoCkkrXOveB55eA/7ZmkFIxEsH8+QECS0zHIqTPzU/
         KZ6f3/dAekJ0GjZ6lVQxbX4c174FJfcECcswiSSizhzN4NhP1vjBt5jy6TBhnGvs/2hY
         zpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bvRd2eLeia2aUi9lVvFJVxAc4QDqtKWTlVyNMMnyTyE=;
        fh=GidGcrGD/0OE56tLWujiqe8KyKXMltVuF1uPdHAh2xc=;
        b=bgBp35/WhHopebPn6yGJx8gr2iDhhuPIvLuZkJH8gvwaYNsOdtSdNsW/RHxiEF1GBZ
         MhA3AlkkzSgs4wlECBzaiwrxT+PQLUw3pOTfjyoDwuSnC+SXGwcBOmSbeBR6eVT0VKxa
         tSgxwhGKuT2XBIhoL31nXNCcGhnYhM4HV+6yRhMCgtykftG+k5NUJH2P4+hKjlHO11KG
         q2a0Zw8ofplmvnejemrxjJB/mLw53YIGwTHJPURfXpE/LEMle6XZ6tm+ccjoYiz3z1yT
         S7HdiuGfD9HEtOHonsSmdXjrQvt9XulHyQhubRfueeL7+XI8bwNqo3CWu7umw2ZoQP5Y
         QLQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784818518; x=1785423318; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvRd2eLeia2aUi9lVvFJVxAc4QDqtKWTlVyNMMnyTyE=;
        b=tOot7o4yaLsUKVv7Cp1JHTCmrOKDludthCydvvQJtZspyIiMXfvDQTDrG3sli7Vrq5
         77M5JtqB+6PXdUPMNfCo3MrmAT5wxi+BtvOkvqAcgmFfKFrleTAU+AHmO5JQVc0k5mHu
         HcOI6lcwKCT6p8FnT0pm3BA3fyeOlJetOHxg4RUOMBJkrO4jMW2gCWauCJFj1POlMEoC
         1DoYpDpOWwmgld+FLdroNZSm0maIfoRCwFXhzXNrzj2h6WiG9uNwsm74k30ev3NifKxk
         0scWeHJQtl5v+dAIsbFX1qjBTJIvEeeeOHBJBu01of53Lnz8MaVRiOJoH268ljn8h42y
         u1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784818518; x=1785423318;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bvRd2eLeia2aUi9lVvFJVxAc4QDqtKWTlVyNMMnyTyE=;
        b=c7tSaaxTU9Thz9kwjgTpZ5iLX2tc8ysgpz9JYSbwKWpAdDOBBfwmYzNI+altvqp9o4
         IS2oS4GYZtpgqOPlHC99BKVZbA+L7Qdko50Gk1vLbg8LF26JTLqx3avGCSvN5WU64zgs
         06K4zAdmBvRivNHNOlIeiJ2oDgIV5A9u8Yyn7Lee9A9pUCZFQtY/1anHOi0Blk43HOCS
         zNQaVa5x/MTY3cDFKBpkBSyAsUwyTI9TjQDwsnXPGDsazlEl34VL6lqm9iFlI3+4xvh8
         HvQrWIOyjnD41qSe2ol6fQWh1t+Hi9fWcw3CoFXn6xoojyHj3P65rvZA8l+t6YEFgIok
         nsCA==
X-Forwarded-Encrypted: i=1; AHgh+RrbIUDVFXmPscQBgVdlapzAVEWIPZNZVDWG2xhSV7UkNS7bJe05aWrsZ25CFVPJB6Q8dHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MdjuflvcZKMu5V8iw2CSCAg9yRImDgopoqQRSfB/VGkUP9xV
	SM6yGn462flr8Tkm9/r4gQuhBYFJZeTRAG/PCt9IfPnFL6oswLoI6KLGNhHnNFXGN7NRBuVn3Ry
	Lp30wuwMbOls8fV4i7cDuHyIhYAJgwemtHc8pJV8f7I/Omk4sXcItVyu0PpXHDHJf1qIFYKcCig
	H6WlMmwDnASGnt44Lq+/93B6v8qZdy
X-Gm-Gg: AR+sD10XQ2BSZJD9hg28U7UKhzV0t3I5a6bz6hvvspdln1PMbApKzN6kB4Kv8/jZ7P4
	e5w3L7wN0vj7C+/cwrC0QdwAFDcSAFWtW2uzjReIAyt1meiBKb6ZCZNFij2k40313r2E31XK/RE
	8Kq51nGQT6k2pIwaVBBNjmdSsqlLBIDSZmajZXiR8khXedtN+nFVWj+p0=
X-Received: by 2002:a17:903:22cc:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2cfa6b9aefdmr42836495ad.20.1784818517963;
        Thu, 23 Jul 2026 07:55:17 -0700 (PDT)
X-Received: by 2002:a17:903:22cc:b0:2c1:ee75:56bb with SMTP id
 d9443c01a7336-2cfa6b9aefdmr42836035ad.20.1784818517333; Thu, 23 Jul 2026
 07:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com> <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com> <amIe79X3j7GxDBdO@sgarzare-redhat>
 <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com> <amInL2hPEG9ejUd0@sgarzare-redhat>
 <c631dabe-ebde-4b4d-b930-d78db4cbabc4@virtuozzo.com>
In-Reply-To: <c631dabe-ebde-4b4d-b930-d78db4cbabc4@virtuozzo.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 23 Jul 2026 16:55:06 +0200
X-Gm-Features: AUfX_myZK-p9FOGSszTUuAcpH5FI9O4QC0jIuPyjdxhWMen1SWqoFmAarrjhwt8
Message-ID: <CAGxU2F7xaEgi3=2G_itbrGpBvFqOB2CTwB_W_f6c+t+wS2Y47g@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing workers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 at 16:50, Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> On 7/23/26 5:39 PM, Stefano Garzarella wrote:
> > On Thu, Jul 23, 2026 at 05:29:12PM +0300, Andrey Drobyshev wrote:
> >> On 7/23/26 5:03 PM, Stefano Garzarella wrote:
> >>> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
> >>>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
> >>>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
> >>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
> >>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
> >>>>>> the vq->worker pointers and immediately frees the workers, without
> >>>>>> waiting for a grace period.  A caller that fetched the worker right
> >>>>>> before the pointer was cleared can therefore still be queueing work on
> >>>>>> it while it is freed.  And even when the queueing itself wins the race,
> >>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
> >>>>>> future attempts to queue it are silently skipped.
> >>>>>>
> >>>>>> None of the current callers can actually hit this: net and scsi stop
> >>>>>> their virtqueues before the workers are freed, and vsock unhashes the
> >>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
> >>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
> >>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
> >>>>>> the lockless send/cancel paths become able to race with the teardown.
> >>>>>>
> >>>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
> >>>>>> period, and then flushing the workers so any work the last readers
> >>>>>> queued runs before the workers are freed.
> >>>>>>
> >>>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
> >>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >>>>>> ---
> >>>>>> drivers/vhost/vhost.c | 11 +++++++++++
> >>>>>> 1 file changed, 11 insertions(+)
> >>>>>
> >>>>> Sashiko reported some potential issues here:
> >>>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
> >>>>>
> >>>>> IMO the first one is pre-existing, but not really sure it is a real
> >>>>> issue since happening when the worker/vmm is going to be killed.
> >>>>>
> >>>>
> >>>> Sashiko claims:
> >>>>
> >>>>> Will this leave the queued work unexecuted and permanently break the
> >>>> virtqueue by leaving VHOST_WORK_QUEUED set?
> >>>>
> >>>> I agree this issue is pre-existing and doesn't have much to do with our
> >>>> series here.  It looks real, but in reality should be harmless since we
> >>>> may only hit it while the device already dying.  Means there's no VQ
> >>>> state to be saved.  The only potentially observable artifact I guess is
> >>>> a warning here:
> >>>>
> >>>> vhost_workers_free()
> >>>>  vhost_worker_destroy()
> >>>>    WARN_ON(!llist_empty())
> >>>>
> >>>> So more of a cosmetic noise on a dying device.  Again, not relevant to
> >>>> this series.  But one optional way to make it go away would be to clear
> >>>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
> >>>> vhost_worker_killed()).
> >>>>> The second one also not sure if it's an issue since the sender is not
> >>>>> lockless IIUC.
> >>>>>
> >>>>
> >>>> The term 'sender' is confusing here:
> >>>>
> >>>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
> >>>> virtio_transport.  It only stores skbs into the queue, doesn't process
> >>>> them. It indeed is lockless as it doesn't take vq->mutex.
> >>>>
> >>>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
> >>>> It's called by the worker thread to process skbs in the queue, calls
> >>>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
> >>>>
> >>>> I think sashiko points out to the former.  Still, I don't think it's an
> >>>> actual bug.  Look:
> >>>>
> >>>> 1) By invoking flush, we wake the worker thread:
> >>>> vhost_dev_flush()
> >>>>  __vhost_worker_flush()
> >>>>    vhost_worker_queue(flush.work)
> >>>>      worker->ops->wakeup()
> >>>>
> >>>> 2) Then woken worker does:
> >>>> vhost_run_work_list()
> >>>>  llist_for_each_entry_safe(work) {
> >>>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
> >>>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
> >>>>  }
> >>>>
> >>>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
> >>>> vhost_transport_send_pkt_work()
> >>>>  vhost_transport_do_send_pkt()
> >>>>    if (!vhost_vq_get_backend(vq))
> >>>>      goto out;
> >>>>
> >>>> As you can see, we return early in case backend was unset.
> >>>>
> >>>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
> >>>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
> >>>> processed, and VQ state isn't actually touched here - so I guess
> >>>> Sashiko's conclusion is incorrect and there's no actual bug.
> >>>>
> >>>>> But, please can you double check them?
> >>>>>
> >>>>
> >>>> In general I'd leave this patch as-is as Sashiko's complaints aren't
> >>>> very convincing so far.  If you want I can add another patch which wraps
> >>>> NULLifying workers in vhost_workers_free() in vq->mutex.
> >>>>
> >>>> WDYT?
> >>>
> >>> Yeah, I agree, about the other patch, up to you, but I'll eventually
> >>> send it separately.
> >>>
> >>> Thanks,
> >>> Stefano
> >>>
> >>
> >> Alright, then let me resend it once more along with this 6th patch, so
> >> that we don't have it uncovered.
> >
> > But why it should be part of this series?
> >
> > If there is no strong reason, I'd send it as a separate patch.
> >
> > E.g. even this patch in theory may be a separate one, but this is
> > related to this series, so makes sense to have this included.
> >
>
> No particular reason, just while we're at it.  Alright, no respin, will
> send it separately.  Then I'll consider this series reviewed - unless,
> maybe, Michael will want to take a look as well?

Yep, I mean this should go with Michael's tree, so ... :-)

I sent my R-b to all patches, so I'm fine with this version.

Thanks,
Stefano

