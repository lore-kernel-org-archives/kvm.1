Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3D37E5D9
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336277; cv=none; b=LeDHocKNzQ+zNPB0XBUS0Nmo+f5Iu09dDT0P0TdlHXAnB0Jp7d6dssvnTt4cLQQflVS6imZ7F2VlC4wcGMXu7xOUpDcPbF4Kt0hctMJ/xOVt2ZSwrmz828hSzCj9XSd8PzyE3r19z470EGrtgeyT0Z628bL2BoQ8TO0pav/b5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336277; c=relaxed/simple;
	bh=BJS1HA8rokFIiV0ne5cRaLj+3cbfWQFKkW4X/b+NT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzlcIixhJmEfvVBSAeS8IHBLURSDuJjvC5/pnVSZOMlrKxSRCEMFtrqmUSY/aulSkWvhXWElgh3rUIKdIes7037i7eXJdyD8gU2Va0GpAqdiJ1/scxEJFcWNdzoLXYYQfITJxW37EFuDsZmDR9ooPPE3RetI3oqUqFKcPlmxQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNWcPWPn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oyz//dGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNWcPWPn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oyz//dGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
	b=YNWcPWPn9bvAPNDTNyD2ILT5WLEI7d/1jOq4dpgpaLzenlwxMGF/XU2WLVa/vLq1u6VZKJ
	g+ZOI/W2pWL6E13TVrj9aatcGZ3t2u3miOaCvVp26h4zpIWMhRQCJrx2qQ02AyOdegEs7j
	C/6E8lnswo7449EYUtRc1NypluOrXHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-MYGg1lEQOkah2qnegm6a0w-1; Wed, 29 Jul 2026 10:44:32 -0400
X-MC-Unique: MYGg1lEQOkah2qnegm6a0w-1
X-Mimecast-MFC-AGG-ID: MYGg1lEQOkah2qnegm6a0w_1785336272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955e865174so6439045e9.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785336271; x=1785941071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=oyz//dGijZHIMW/rtv4mM2WADpEIvZKQtsVJMd4vi8zUJKJxapTxrOrBFJaCF57e8I
         G+SHjo5GttqlA7ZYacmSj5eGVwnsxmDk6VmCW5fRNVpK0nLM91yO82IJ1iuiZJihivKV
         9nY/MCpWNoC3/iFI67y9xYYcFWeEZUPRdoQ4vDaUGmz3SL5LrqfWli8rpYoSoICedB14
         grS2SGy99EnTdrmh6neGP9d0qgJpMVAVvKQ/cC3FVD78O1sL2kPK/YQYYw+unlSQkseu
         58ujstEcA4fs0d86+JMUApceogZtc53P77HvUiM+DOCu2U3VNwvnWKOTb+A+GG6PX81F
         SqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336271; x=1785941071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=E/DUZ+I9FDuqgnHBP0DGX4GKynv6PsC2e8QrsRURG33BlsocHoklb+wyqD3N7X9XuQ
         hpeOVFY35fIF+JMiFNIWrgQ5a4ZFAAK75+kslQrBb56mDnsP8Rsx5k9qZ2l4PHB+Y1cv
         w6p5OXA85US7gT/oKumqgLf1zxKGnEBztdVIHpUsWb/w9mqe5PwWckvkayK4ZO8yMJU/
         /Zh1Rj1l3vGwOEJpUqNtBml102nrW23ES2kV7G3/mz93mCzTwRmVikkF6OK67ZPriSy1
         14uP3h6LPqfE6g+L4H64ppi4SW8ozyXni1nrE4YnFX05sC/vv+6/uQORDWc+2zWUsQGl
         RGAw==
X-Forwarded-Encrypted: i=1; AHgh+RpsTqAWS01tP/cW/DnnhEislS8BXqP0Cfp3X6Eq9rok+frPw+V4F0Lrfw3FAByZJnMtbkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6wI9ehV751rc5iFK+tjMcpSOISa0V/FhF+Czs35R++FrAk4s
	hDR9GOTC7bPstr4n3ynFF8sY51D9cRDe1j6bRgvbFlu0OzZ5caHBcufQ76g4BF/5sEQrtbNysDV
	ZJUY73Mqb8EuRpouZYCkKU3ivObFBD4Zu4Tpwn4CaZTxrrKf4yDICsg==
X-Gm-Gg: AR+sD13hDuqpUjKPgb8iu6tBn7cs00hQ5VlyJk7VXf88xBQyJWfsXBvKRSOFCPYItD/
	bHAqltuVtv5jKTOQlP4iwOK6xYwwNZkEcKhTPbHpT9mau1a7XMa1op7ZjrQ2xSf96WMJktgADfg
	TRzgn+2jNTPbceUUOg8/6lIl8WlaEBysVncKAT9NFBJORjL95G8W631achfe8T64hSxQfxupHJ+
	x9xzgPge6BmiduscpcgpOxoRNf681ThkNvl5pbV3ea6l0rdSFXPvrA1WU9+czdii7yKiXLnVXHE
	VzuvKH96mJYsugucphWH9j10W9dsgNCVa64Y6FT/lqpHqn+wAFT4HP+gdGQetd9o4hxxn9DXhoZ
	3hvcswcDHuxsECWkzoIfPRduYY2bPrKel+xokcdQv9gE=
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603545e9.18.1785336271633;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603015e9.18.1785336271121;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd52f3fsm36693245e9.0.2026.07.29.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:44:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoPm0aVfnadsJaF@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>The RX, TX and event workers read their virtqueue pointers before taking
>the mutex that protects the queue and its run flag. A work item delayed
>across freeze and restore can therefore retain a pointer deleted by
>virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>and use the freed pointer.
>
>RX has an additional path: when rx_run is clear, the common exit still
>refills the RX queue. A queued worker can consequently call
>virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>
>BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>Read of size 4 by task kworker/2:1
>Workqueue: virtio_vsock virtio_transport_rx_work
>Call Trace:
> virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>...
>Freed by task 141:
> kfree (mm/slub.c:6566)
> vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> virtio_device_freeze (drivers/virtio/virtio.c:658)
> virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> device_suspend (drivers/base/power/main.c:1968)
>Kernel panic - not syncing: KASAN: panic_on_warn set ...
>
>Read each worker's virtqueue under its mutex after confirming that the
>queue is running, and only refill RX while RX is running.
>
>Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>Cc: stable@vger.kernel.org
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: OpenAI-Codex:gpt-5
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 57f2d6ec3ffc..79cf19f58943 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
> 	struct virtqueue *vq;
> 	bool added = false;
>
>-	vq = vsock->vqs[VSOCK_VQ_TX];
> 	mutex_lock(&vsock->tx_lock);
>
> 	if (!vsock->tx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_TX];
>+
> 	do {
> 		struct sk_buff *skb;
> 		unsigned int len;
>@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, event_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>-
> 	mutex_lock(&vsock->event_lock);
>
> 	if (!vsock->event_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+
> 	do {
> 		struct virtio_vsock_event *event;
> 		unsigned int len;
>@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, rx_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_RX];
>-
> 	mutex_lock(&vsock->rx_lock);
>
> 	if (!vsock->rx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_RX];
>+
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>+	if (vsock->rx_run &&

Instead of adding this check, what about adding a new label...

>+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);

out_nofill:
> 	mutex_unlock(&vsock->rx_lock);

And use it when we check `vsock->rx_run` ?

Since we are taking the mutex, we don't need to check it again.

The rest LGTM, but I agree with Bobby about the split, since the Fixes 
tag here is confusing. I'll reply there.

Thanks,
Stefano

