Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D03655DB
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826821; cv=none; b=OsWREtetN6Rz2UD0OmAwDES+3HU1RjDih0c4KrMv3JqX+COSogZ2DvCZ/vkSyjOL9VlXDkuwUsE6stG2HgF0Wol9WYcgYtF3BlNaMNLOgNnslgmqM9aOANVvfMqiusLMVizWxnzHSLRFSZ8h9/FYVMVRy00eWY3seb6tr9BW90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826821; c=relaxed/simple;
	bh=+uAe7+vHveJ9Xr7bLTlrloHySuIi1wTIpGjyEF60J/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU5BnTA6rRSvaDDafwG9LjRxgSOnSwxOcenJA5MVNVUeBQ6XDr+e82EWWFlLkhY7abCskSwGzW2X8XfA5c5Hr2L6j/JWuCOsqcgVEhn3zg22RtjsqyGBH0MSZfdWFVNAM17toXaR269U6+zaVkjWe5b5l7EvNTa8H6i85l7uUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJn/R6VQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8iDckx2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJn/R6VQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8iDckx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782826818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
	b=LJn/R6VQSA7Hi2OUnZYb5L9i4yz2rInQFhSYTJ+6Ms0T6IHchNbu67eH1DL6nC7rNq0FL6
	ZFNloTdWOsGbPfP82PTmHG4bZz3zB0HWB752kAFod4UPP86Opv21+q+4iqjNENttLLZy0O
	CcijGvajdaNTfTB4mpbFprFrypifzuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-m-Ky5g8UNSCG0G6RkmDILQ-1; Tue, 30 Jun 2026 09:40:13 -0400
X-MC-Unique: m-Ky5g8UNSCG0G6RkmDILQ-1
X-Mimecast-MFC-AGG-ID: m-Ky5g8UNSCG0G6RkmDILQ_1782826812
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473e18559b2so1285411f8f.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782826812; x=1783431612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
        b=O8iDckx2zgI6tlFnSTYgIu/ISUk0PehAz/seSGxqw0E2VqRIggAXAZN69zmQMYD8E6
         Ka6/UgoC8EdzW5z8LbXZpQfhiL/wN7PetWCt85dR4yNp7R7tn1Q7s5EmUGNvoeAJ2hRd
         Qv8PRBaF/mpD2TXl5K5tcvgVnAeqxrI7yNRvkSNAruM2UpOc3vDoc4AxMDRlIkpMyD+7
         zxObV9SS6VgmJAFZb5lQhybdb4ttbvMwCnGPkxy4zMHuR9jlkd2vb5BGkvWXP/xc1S8O
         1rjQ20+8sTxTCy6yfkVKlJ440bL63AZ6r1Nb8QCTJLyxHLmS2+HxkFCBfX55Dft4c3i4
         9Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826812; x=1783431612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
        b=UdIXpF2DdMyT7eEMhmEYaZ63zlBMWum9CV/FcYYidwxNkgXPiM86IXAScjaEBAoKEg
         lmI0t+jDmXfxFoTSncCbJa8Jc2N3/eMpo8bSqcvXtmFeivSh+TDsrfnezYlIipN5kPqG
         6EHxYOmgP9bIhPnkk/Xomur8LxT8zj0Rp1CRq+Ho6IhTuSAybQLRh6TgWqzQrwmhCXRB
         8nEBykeel3sZkTTyTXwXOTWfSIE2m84/hR9aT6kkKd70AnNIY4cBL8gNXrsHq+hSC5a0
         4Pwqz6/kmoIkp/V6bB038Sdwtor22o2r6Ac9bnd7i3Syg5L2gSyJvIMgcL/p9ay6cKha
         jHkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiHVYwyVE36pgy4xwxyTVib/NgahgQ4/aB4G9iPPpmM4l9Refsze7bFmvb8RWzMRjXan8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXf8wyLOzVEuy/9Ck9jWlONgQGIku4d5uiRzGz9UjGdVz/SZ9m
	SoUIrs+D3AdAKVL41nZxUyCV6N+8RLLB/xPr4srgoZjXR4/1lm4Rmj21ottR2XNEJBrPA6dDYlN
	n9mCBZ5nBt6118o6QQN50UTs408oiC0N8YPcB2ZeD9kEHAmxZpP5SlQ==
X-Gm-Gg: AfdE7cmaG3vVak+LT2YmfdlJy/iw/7fbwNlX3E/YO9AjBrs7tMZvBNootHfuUkptIOa
	nhpq5OuRumwSBsfpUQ1ADf4AzuYhBMHO6WQsH6/SpvAq2NvG4+AK1LlD/a7u62L41Wkg3qfhuW9
	EIfrQpE5shEfxu7Ttm/CRUi0MEoDz87Mg0FT06Mnfgl7vJE8qWNxnhx+FfdIor6Bl7mGjXneofh
	M3u8ZF3AQd9XahpIEM0c8PKzUAL74vktV2W5aziYXr4U0R+uchcaY82oZW/+AP3zX1pt3Bja/QC
	2MYeG0rTIb9civ+vlsykZ5/y9Lq+hyjBI19SAX5XO8VmiAA/4amHkj1gG9cEognrTgv2n4j75pq
	ic1N1fNYnXoQdwmlgi434zM6LHBk6pTm+rPL/8mszrBr5ZWgvEB/kB2k6VUlu
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841838f8f.49.1782826812365;
        Tue, 30 Jun 2026 06:40:12 -0700 (PDT)
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841772f8f.49.1782826811836;
        Tue, 30 Jun 2026 06:40:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm8461092f8f.35.2026.06.30.06.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:10 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <akO6tps94iFxCAWv@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>

On Thu, Jun 25, 2026 at 06:54:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>RESET_OWNER keeps the guest CID hashed, so that connections survive. That
>leaves the device reachable by a lockless send/cancel path while the worker
>is being torn down: a concurrent vhost_transport_send_pkt() or
>vhost_transport_cancel_pkt() can call vhost_vq_work_queue() as
>vhost_workers_free() frees the worker.  That might cause a use-after-free
>of vq->worker.  In addition, any work queued onto the dying worker leaves
>VHOST_WORK_QUEUED stuck, stalling send_pkt_queue after resume.
>
>Fence the send/cancel paths around the teardown: send_pkt()/cancel_pkt()
>only kick the worker while the backend is alive.  And reset_owner() calls
>synchronize_rcu() after drop_backends() so in-flight send/cancel finish
>before the worker is freed.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 51 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 49 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 81d4f7209719..f0a0aa7d3200 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		atomic_inc(&vsock->queued_replies);
>
> 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>+
>+	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
>+	 * stays queued and vhost_vsock_start() drains it. Pairs with the
>+	 * synchronize_rcu() in vhost_vsock_reset_owner().
>+	 */

Please explain better (as done by commit bb26ed5f3a8b ("vhost/vsock: 
Refuse the connection immediately when guest isn't ready") in the 
comment removed by this seris) why we can use vhost_vq_get_backend() 
without vq->mutex held.

>+	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
>+		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
>+				    &vsock->send_pkt_work);

BTW I'm now confused about what we are preventing here. A better
explanation should be added both in the commit and in the comment,
because it's hard to understand what we're preventing.

That said, if there is a problem, perhaps it should be fixed in vhost.c,
because it seems more like a generic issue.

vhost_vq_work_queue() has `worker = rcu_dereference(vq->worker);` so
should already prevent UAF, no?

Or maybe vhost_workers_free() is missing a synchronize_rcu()?

>
> 	rcu_read_unlock();
> 	return len;
>@@ -346,7 +353,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 		int new_cnt;
>
> 		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
>-		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
>+
>+		/* Skip the kick once the backend is gone (stop/RESET_OWNER):
>+		 * vhost_poll_queue() would touch the worker which is being freed
>+		 * by teardown, e.g. on RESET_OWNER.  Pairs with the
>+		 * synchronize_rcu() in vhost_vsock_reset_owner().  The TX VQ is

Ditto about the comment.

>+		 * re-kicked by vhost_vsock_start().
>+		 */
>+		if (data_race(vhost_vq_get_backend(tx_vq)) &&
>+		    new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
> 			vhost_poll_queue(&tx_vq->poll);
> 	}
>
>@@ -903,6 +918,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)

Why returning int?

We are defining err as long here, also the caller vhost_vsock_dev_ioctl()
returns long, so it is not clear to me why here we are not just
returning long.

>+{
>+	struct vhost_iotlb *umem;
>+	long err;
>+
>+	mutex_lock(&vsock->dev.mutex);
>+	err = vhost_dev_check_owner(&vsock->dev);
>+	if (err)
>+		goto done;
>+	umem = vhost_dev_reset_owner_prepare();
>+	if (!umem) {
>+		err = -ENOMEM;
>+		goto done;
>+	}
>+	vhost_vsock_drop_backends(vsock);
>+
>+	/* Let in-flight send_pkt() callers stop touching the worker before the
>+	 * flush + free below. Pairs with the backend check in
>+	 * vhost_transport_send_pkt().

This is also paired with vhost_transport_cancel_pkt(), so please update
this comment.

>+	 */
>+	synchronize_rcu();
>+
>+	vhost_vsock_flush(vsock);
>+	vhost_dev_stop(&vsock->dev);
>+	vhost_dev_reset_owner(&vsock->dev, umem);
>+done:
>+	mutex_unlock(&vsock->dev.mutex);
>+	return err;
>+}
>+
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 				  unsigned long arg)
> {
>@@ -946,6 +991,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&vsock->dev, features);
> 		return 0;
>+	case VHOST_RESET_OWNER:
>+		return vhost_vsock_reset_owner(vsock);
> 	default:
> 		mutex_lock(&vsock->dev.mutex);
> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>-- 
>2.47.1
>

