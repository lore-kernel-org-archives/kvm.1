Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418E48D860
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336437; cv=none; b=MeBtQ88CNX+8WgiyzdqAN1MomOsQ/cRT7pRme40vFc6fbIAQswNlI4xAVnukJXJgOQ/01ZGjAylydec7F26dhDlDoyiZXw3beLLOe0isNzZEQWzmfYkzqhSjd11El2nYJXEC4RD9E4+fcKEfJKkiAalQ94bzDefgj9uOA11o7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336437; c=relaxed/simple;
	bh=F7gJ/ECoIn0yMRAvxBO25GQLBgLR0EPLHh+0r9A2Y1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwc4JheNDfAHhxG0glsXYX6zut5Kdq7q+Ic5SY1sHKkaI5TE/hjH8AuItg9kkU462mguACzgFR3U42Inx6Ke4szDqv512CamYp0ZBm3ClOpZlm3+6CDjc7/GJNe9Ltz70gwFu4TW9C4FSccIkhsH/Jklw+WHGBiva4G2X6it9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTmRgDcI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBnU0bLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTmRgDcI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBnU0bLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUO+shHcXPXkW8jm7U6qNBfIeZI1sbU1fzZ8TMtvFnQ=;
	b=WTmRgDcIqkc6RU5BBv9wCgrEJAc4Y6aeRSv0FpUvdzv8yBVrBNTTgDBg/idnjOwio9ZRoG
	6Ka/g87/P92mBYXmavEliAu2afy9zN1WKpTHrw5cBF4AkSjeNhV4iCIBsxWuHeTstf7IEk
	auIHm3oYPJ+PJhuSvWnLS8TI6/0utzg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ICmekyGQMTmt5FucwvZq3Q-1; Wed, 29 Jul 2026 10:47:10 -0400
X-MC-Unique: ICmekyGQMTmt5FucwvZq3Q-1
X-Mimecast-MFC-AGG-ID: ICmekyGQMTmt5FucwvZq3Q_1785336429
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so9494505e9.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785336429; x=1785941229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iUO+shHcXPXkW8jm7U6qNBfIeZI1sbU1fzZ8TMtvFnQ=;
        b=KBnU0bLkgwVQuJQLZ3V7g+i1TV6HmLZJatMBRTpofkTxJnOeKFXXFNgmX1iGcXr9Oc
         zGZTPm00fuAOSGFyQkJmo54LoGCp7ltRTo9KZ8HBx3yGkPjxBTWR41oo3y0uageKCXzC
         aCMVUfMXbcd344cdEpANGJu8Gms6+BcR7Gl4TLVnqsOPqg721MhMN2QiduTBl7dntHlV
         WMypzMt+gq1+fZ0wV2tx2exrfVzsoxPmnymTKfBS4MCdiSQGRI0oM6tMRTGKfCCydiv7
         mQls58TQ9YD4ykIQfNyxDu51pwLXNARPpyw9o9okb+GT7d8dfPOgA3JQjCGIutgvbBkH
         DPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336429; x=1785941229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUO+shHcXPXkW8jm7U6qNBfIeZI1sbU1fzZ8TMtvFnQ=;
        b=dx1yobjmw+wGB8P4NSruUVLWL30WJQ6wK2y5i+6/rHPgLWq5ij1VJTUuAjwbVvWcSK
         xixoswB5qlux06qfo8VaN1qYSGlykqaJCMTXLvc0YAiOgujeNG78WnL7hz6Ixidchxyw
         t+rXfopy8yvnvLih1mNPdzjbmGSp8E3RAH9jRFGhI+U1WWtMMv5AXPQ6F9yqPZB/LFn3
         obY3YSR6jCPkYlkRz8aAObmNqrs0wRUFe+Bt0PQvRpaRewMLt4r5TBYffRycVmCWkFfZ
         njJVCO/Py3YZgQKGYqcaIQPSGDnH05VCIK55KQnotu5OvQ6h5zFuwYoT6kxwrzW807DF
         EYlw==
X-Forwarded-Encrypted: i=1; AHgh+RrzmhvSm/HYRZwmOYhf3aFAJTDATZ77fi8BL7Te9/vDT4DG5DM3zVCFiTzyydry8r64DTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDTvdoie5rdMzvf2vEH/wrZNpC2OAahMnC9tCf4F2nLV0+s+y
	l+bdhgZQa0rIpeLyG1TRnhqCNMh7tFXvEK5eWViQE8Joo+zK6M9PR9Bk0yCYTI8t5Km5wskPyJd
	Bxs1EofijjOiXrK6ro+PP3f+Pu9KkG/2Ud6uKcIofRtWWto8yjox3yQ==
X-Gm-Gg: AR+sD13gjiB/25qrWnkyqA0oz9fRaOQADmr0rEToZ51G1TPjONx5oZFNZkWmj+AyjJ3
	sWxTeTg55ElhIv05KxfAnkU8ZhtUTTsodlDLFmbGcZzEeIxzzU1QzvIv64ZwUJTWbBW/Z2GtjI7
	nadSnX0RrcnL8Hrguvkg+KzUOxR1wE4QMV5GbQ3gMyxHihiy/yKVSz7jTZyfXrrAYAdsxTXJhGq
	lJrY/KjglE3Ir2MMFzri0XzNQc2+d5T/jlnZuBZ69zyZZO/AQFmxGPjYu8BAArEv9GpB83ibMNt
	m7I2omTAsmMUU9czh5d+DI9NkkbREmfQBdUp2JKNF6Y14sjIxih93Tj10n0bfbqgsORfTXRAkPj
	BNMaY5sC15+YlOKOEGh6PFrCEdQBuJskvEQu3lQ4g26U=
X-Received: by 2002:a05:600c:4fc7:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-496c641505fmr101132205e9.3.1785336428962;
        Wed, 29 Jul 2026 07:47:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc7:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-496c641505fmr101131455e9.3.1785336428269;
        Wed, 29 Jul 2026 07:47:08 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd6dcb3sm65934695e9.11.2026.07.29.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:47:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:47:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Weiming Shi <bestswngs@gmail.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoR0pnMO2OQ2E6z@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
 <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>

On Tue, Jul 28, 2026 at 10:17:55AM -0700, Bobby Eshleman wrote:
>On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>> The RX, TX and event workers read their virtqueue pointers before taking
>> the mutex that protects the queue and its run flag. A work item delayed
>> across freeze and restore can therefore retain a pointer deleted by
>> virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>> and use the freed pointer.
>>
>> RX has an additional path: when rx_run is clear, the common exit still
>> refills the RX queue. A queued worker can consequently call
>> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>>
>> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>> Read of size 4 by task kworker/2:1
>> Workqueue: virtio_vsock virtio_transport_rx_work
>> Call Trace:
>>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>>  process_one_work (kernel/workqueue.c:3314)
>>  worker_thread (kernel/workqueue.c:3478)
>>  kthread (kernel/kthread.c:436)
>>  ret_from_fork (arch/x86/kernel/process.c:158)
>>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>> ...
>> Freed by task 141:
>>  kfree (mm/slub.c:6566)
>>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>>  device_suspend (drivers/base/power/main.c:1968)
>> Kernel panic - not syncing: KASAN: panic_on_warn set ...
>>
>> Read each worker's virtqueue under its mutex after confirming that the
>> queue is running, and only refill RX while RX is running.
>>
>> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>> Cc: stable@vger.kernel.org
>> Reported-by: Xiang Mei <xmei5@asu.edu>
>> Assisted-by: OpenAI-Codex:gpt-5
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 57f2d6ec3ffc..79cf19f58943 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>>  	struct virtqueue *vq;
>>  	bool added = false;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_TX];
>>  	mutex_lock(&vsock->tx_lock);
>>
>>  	if (!vsock->tx_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_TX];
>> +
>>  	do {
>>  		struct sk_buff *skb;
>>  		unsigned int len;
>> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, event_work);
>>  	struct virtqueue *vq;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
>> -
>>  	mutex_lock(&vsock->event_lock);
>>
>>  	if (!vsock->event_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
>> +
>>  	do {
>>  		struct virtio_vsock_event *event;
>>  		unsigned int len;
>> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  		container_of(work, struct virtio_vsock, rx_work);
>>  	struct virtqueue *vq;
>>
>> -	vq = vsock->vqs[VSOCK_VQ_RX];
>> -
>>  	mutex_lock(&vsock->rx_lock);
>>
>>  	if (!vsock->rx_run)
>>  		goto out;
>>
>> +	vq = vsock->vqs[VSOCK_VQ_RX];
>> +
>>  	do {
>>  		virtqueue_disable_cb(vq);
>>  		for (;;) {
>> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  	} while (!virtqueue_enable_cb(vq));
>>
>>  out:
>> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>> +	if (vsock->rx_run &&
>> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>>  		virtio_vsock_rx_fill(vsock);
>>  	mutex_unlock(&vsock->rx_lock);
>>  }
>> --
>> 2.55.0
>
>Not a strong opinion from me, but since this last hunk is the one that
>fixes the bug and the other hunks are moreso hardening, maybe break
>these out into two patches?

I think also the other hunks fix an issue, but I agree on the split 
since IMO we are fixing 2 different commits. Commit b917507e5ad9 
("vsock/virtio: stop workers during the .remove()") was before 
freeze/resume added by commit bd50c5dc182b ("vsock/virtio: add support 
for device suspend/resume"). Only after that one we can have the false 
-> true transition of *_run variables.

So IMO hunks 1-3 should have Fixes: bd50c5dc182b ... and hunk 4 should
have Fixes: b917507e5ad9 ...

That said, it's not a strong opinion here too, but if you prefer a 
single patch, please add both Fixes.

Thanks,
Stefano

>
>Besides, that all looks good to me.
>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>

