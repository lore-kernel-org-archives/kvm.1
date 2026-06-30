Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED89404BFD
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823182; cv=none; b=UEgv4OoiVMOi+14+Qi1q2uSpM/f8NPcsTHz0newJZDZq/R68ocnpXkWd2sUAerPUsGVUUvOsYyDh0BP94XrFeZrmuHexnNBGAg0Y3nayrgROPUT77fWR+5GUgQnKngGt90B7IXRM6yVauXDv+Ks3NrCUy/ROXd+drAOA388gLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823182; c=relaxed/simple;
	bh=VwYiaIOctNoh585NIztzC6xWPLmQ71URx+DbYZxb5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snfZlcktdvRNdXDGZfIQgShyr+5l6NYO89uzDmK7jq15zdApBrgxGbfcT1ulD3FHVnqRsZBJnZQJZSW3JyoGXUQlnEhunaNf0gMumu9ETSgAnhD7W1/eJ+xZskG5tuIuR7xbRYl0yI4VaBvlJ6+OiOJyy1RvlR0PaLloL6xS1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sr60LC1w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=McXhK1yN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sr60LC1w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="McXhK1yN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
	b=Sr60LC1wO2A54eGESptTL61RGjXnCB5tE2PjgBmqKiEFxIogD9V19rJlYm9y261lagyms3
	8eIvD7KpUbkGkbOz+gfxpZMUmayZdnUlrPSpPmSrf/wpEnYIwmqvnVURlRJL6Qej5u0wiw
	PFPOs6Yl8f9qHcxwIEaIu3GiM5Kodjo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-nASAS4P2M8mdK4r8ECkA9w-1; Tue, 30 Jun 2026 08:39:38 -0400
X-MC-Unique: nASAS4P2M8mdK4r8ECkA9w-1
X-Mimecast-MFC-AGG-ID: nASAS4P2M8mdK4r8ECkA9w_1782823178
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so5416715e9.3
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782823158; x=1783427958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
        b=McXhK1yNAOvan4mzbfUpRI+osHx1xroLtonszHSf4aPkBNjqKN+gHd21FuZ8UjBRrX
         rgWm5IClSTD6Paogj+RsfrL7kA/09TWEt8knVVOA4uhqBbPeFrsUt2a71SDhyhoGBVb6
         StNqNIGw9UF8XKqEW35/TEDnteJfflpPwcBoq+dD1ax5cbgJReG/iZzdTnbf5/jaunIr
         BP1Us38XKX/fjkFrtXwfeSkf47FSRY1ivI1boXxjWd6Xnk0X8oRFpMVYjTkjJKwGoxgd
         jTDSm7UvgFR+hD8EiL+ZOvIMqkw3Dt/csx+Hz+vOBawNc5yfJRSa43VtlKkObQtOv8JJ
         fzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823158; x=1783427958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
        b=o9CuvKPtT9tr4guBXWX85LVfYn9lBfU27vB7TrZqTeD5DBBt+KCfvVD1DUpqN+/NVE
         Fu6OTrPwtKlQ6WwIrQ2jFN+nyj+qgtN/eJa+/itG6eG3My9l2lPa7ShQUPnWCEKMGv1a
         plCuQWCoy1GmBom1Ck+NkoopT1gwAtabvu6HIwzgZsnDRfiQAVkQtDXAyIKHz6dZOaAQ
         /dwbN+k7r+CudQ8TF25MlT2Jg2NLb4ajg+mVDMSsX7iIT1FdKqZDdWlLCys4ZkVrTVGS
         b/OTm2uAhPSplMz8isTpLYNaogGMLillaaTs+PGUa2tdkSQZPj3oCSqqPpjUZay3bvnI
         enBA==
X-Forwarded-Encrypted: i=1; AFNElJ/NR+q8v1H6WXH8pRwBGUgV967dEHq87hE1OQZGm3dZij+6ub0MCzoQXJ01cpwck8xsZik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1uUKEf5MVGLeQ4SR8W5S39CuX29WW2mCM1tp3ZETT9+IqMSg
	IonSfAExkbZTQs9mCHu5CMBGE9hxEZObW3I1s0iR2KcSFcb90sOQEXJQN14P+WkYrYYspWZ02/1
	FSoxMAQyWSw1yBIrFwbMmvY2zdJ61FvEJ3/vuFdsdIZMwBHXaQrpDWw==
X-Gm-Gg: AfdE7cmYBiZz1ucmst2z7NPhJw8JNGydBEzSk4yoHEp21LEQcbsfWmRSb885ulTeKkQ
	rAxmI8wYnbN2k2v6D4q6hiP/l+Zs6G+A+nksB8qV25xsE54S6wIJ0WgNsFRWgO5Xvp2xsg0c3LV
	q4TffFS7Q/+OKKMWHFg2w6KNvplzqpLDD6tXfCQQk3AV9z7awA/5uvScw8NLVSCX8Oq1JlXlrVH
	SbistLK53iVXXrkc2r2P5NfaNTrcW+Ms/ZWGmNBEB+rmM6OrDZ9MCXHeBbbZXnytaQsj4F+i4wy
	bTsuujz9h7sHHDWW8ituGEVeOGUWIS6yLK3liN5Ti0g0Pf20nIIlldupaPVJj38ppj8syaEL/1I
	8Kl88smpQwq3ftNORh2I+uRQYZvsEIgFjVhPy7RIVcFND6IjqGn82glxM7IsL
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51871265e9.32.1782823157952;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51870825e9.32.1782823157370;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c8d92dsm71175085e9.0.2026.06.30.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <akOUbsbSdNzfNnSR@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>

On Thu, Jun 25, 2026 at 06:54:14PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

nit: IMO we should make it clear that this behavior has not yet been 
implemented, so this patch is a preparation patch to support RESET. In 
this way it is clear that it is not a fix to be backported.

>
>Add a 'started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>

Suggested-by tag is nice to use in this case.

>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..bec6bcfd885f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool started;		/* set on first SET_RUNNING(1); never cleared */

`started` was my initial proposal when I was thiking we should have to
set it to false when the device is stopped.

Now I think this name is confusing, so what about `ever_started` to be
reused in the future, or just `fast_fail` since this is what that
variable is controlloing right now.

The rest LGTM.

Thanks,
Stefano

> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
>-	 * and making the caller wait is pointless: even if the guest manages to init
>-	 * within the timeout, it'll immediately reply with RST, because there's no
>-	 * listener on the port yet.
>-	 *
>-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
>-	 * the mutex would be too expensive in this hot path, and we already have
>-	 * all the outcomes covered: if the backend becomes NULL right after the check,
>-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
>+	 * Before that there is no listener, so queuing is pointless. 'started'
>+	 * is never cleared, so once we're up we keep queuing across later
>+	 * stop / CPR-pause windows.
> 	 */
>-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>+	if (unlikely(!READ_ONCE(vsock->started))) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
> 		return -EHOSTUNREACH;
>@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	/* Set 'started' flag on the first start; never cleared, so send_pkt
>+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
>+	 */
>+	WRITE_ONCE(vsock->started, true);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->started = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>

