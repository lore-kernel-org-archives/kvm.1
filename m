Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51F36CE10
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619813; cv=none; b=RY2Em4eEblUBmv4zD9j54JgmQq3c1A6jrehZIqVC8EZtz7u4auIte1BG6yFWdB5bTOY/jQUsWn1athPlPNOYjAPab39rTN+jfdTTMyI9U8yAnRnFJnAzQhE6xhserZngDjC3olg0VxwXZAYyKYNE08r7Sq77H4SPK68HsZXZRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619813; c=relaxed/simple;
	bh=Q/s4cDWwwN/dicrkzT22yRozV+e/TzvwUha5L7N8yA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbXJCEQ1nLSJX+5ISVGK2R5FPWC3l5xJDoqeC7kabzFbBSwvcWK5+skwSThWxDl8HQjK8SCHFFAgU5fvwoy+Ylud+GSm9MgOoHtkIgDXo1DWzRtzqRbc4usHcneiEYYfB+V23ZM/rVIE3MXF3o+IqZ/EuGJK4cEcZwZ0OBvcfx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5fV6wOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kg+lf2TS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5fV6wOl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kg+lf2TS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
	b=a5fV6wOlAnUvq9OcNiADJjYWaC/RfuuE8MXZYvqzxk3Ob++cp+2IYDs2Rxl/AZ6mXldtjk
	wJ+ojCJ6hFfasuac7wvGb6zIZuAmWV+1edHWe3FGrt0C0ImPYg48Gd4cZJsZt76y5S282L
	DJWirJ2GvsUam41qZa6ZtZsvzNssOfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Z-SMbD1aOLqgkQC0pMU5Aw-1; Tue, 16 Jun 2026 10:23:29 -0400
X-MC-Unique: Z-SMbD1aOLqgkQC0pMU5Aw-1
X-Mimecast-MFC-AGG-ID: Z-SMbD1aOLqgkQC0pMU5Aw_1781619808
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490aadb1386so28154815e9.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619808; x=1782224608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
        b=kg+lf2TSjV3/MHWhd4dmf31HVzOWM+Bn0fiiZh1UEe/SG5xV25UImuctwwThSbcWI1
         qEIVbEWHDHGGrjCffLAyLuW5G1SUoJM+Cr/sz1+lLl2YsqPvsxCQiamxU73P6Wf+0bzH
         g7H5wYdutvFfkp0O7SOfvncYkLX3ZVdu/FkeAtUjviEW8OGcfNyAcuDPPJRadO6L/ThN
         cS+MU2SVoAkF7P/pFofzUKUiqkYVJ4D+K+RCMkxYWcpk13BDXTR0yXFk30QL/vnyAwSI
         uskDoWvqrGTyyj4twOedg+VuCiXHPpZBM3kb+BCOHgsZKQKQpo0UKW2zLYSF2eVVTbl3
         8Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619808; x=1782224608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
        b=YMd1gbtQ85mRYCQeDZMLbNlcbPDUC14u+otykEsEEsBalpP9Lt2iMpmXYmBudmdUo3
         MHxjHhYOvRPhnQC6bw2kI52lDeUegktzO8ryj2rUqfTvMU6pKlhx1n6C570dkaGedI87
         rquwzRzI7CqldK7iHPvSXFWwU7GgxS9XTlSQbijB2++nMQm15eA4M3nO1bNgbxtaYEQe
         lLdToi9Y16FfvNoCTV9VVouvAasDN6VE7K/vOpER8fZBHPzpgyK3/9C12hrEw801x/AH
         JG/cwpohxok+i3O7PUOD12yy29zu5MkSYjqzsJPh8U6Fmm6ix9eII8Qte52FyLuBt9mW
         IV6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8hDN/IprnpNQBHocrJEXCPkKjBqziuqZe7oV1uwvuTy9LIqtPXVmnEbdpM6XCVOm4uZ94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYIPVKSQvaW50vNeiX8DLeynK4NutKnXBL0mwUHdz8Jku8H4X
	vc/kzNW7nqwhfR1PhceUe9EWQhTndITjRTOeoFsPUOluED1ivaDuV0c/iB/cfwHXnPdGsTC2s1g
	feok1btR77W2VLMV8K5VYd1tirMjowRtQRJ+P+Js31CB/B1kF7VYTiq8NKM6NLQ==
X-Gm-Gg: Acq92OG17g9kY1h2L2GJaW33rR3fk9fCD9y3owYHmkVCkS4brlyy8VtfzfOQcVumHq+
	qX5QP5x9tMhz3Q/l7vJrkHW7M6MP+ZQtaHuVwTqYRhfLv33s3867OVuBChiDb6IUwnu50s/HxLc
	Ym4dt9ljQKjIXYcBRfQLAc2y0WwToihaiuNPRQQV1NMTUqYR8PeNUy8JWBE8XldVQom7lQB7ZxN
	/le4lx4cry9NgUt8ovjlscjdbKD26nX8MfyGY8GUC0h7fKod1DjEsBNL0/+ScOP51Q6im3ToRmj
	rXU/irj/P1VqSXwF+/2WvVnl3f9+xeOdY87tn213bqJWFzqnzw5PdvEcPj1bU3Qu8oblkBrgd6S
	Td6wJZV4UuEUu2E/ZIM15lt8wQ3pDDcRx6wRwZsbHGHKpKJyJW5CYYQFIaYRwofgjl59e+VQ=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58483015e9.3.1781619807826;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58482265e9.3.1781619807299;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm243782055e9.2.2026.06.16.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:23:26 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:23:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <ajFbT6sDESh9FDOl@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>

On Fri, Jun 12, 2026 at 07:57:18PM +0300, Andrey Drobyshev wrote:
>During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>keeps running while the host drops and later re-attaches vhost backends.
>If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>and the next vhost_vsock_start()), then the kick is delivered to the
>vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>kick signal is consumed.  The buffer is then left in the ring.
>
>Then upon device start vhost_vsock_start() only re-kicks the RX send
>worker, never the TX VQ, so the buffer is processed only if the guest
>happens to kick again.  But if the guest itself is now waiting for data
>from the host, it will never kick TX VQ again, and we end up in a
>deadlock.
>
>The deadlock is reproduced during active host->guest socat data transfer
>under multiple consecutive CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.

Again, it seems like we're fixing an issue that existed before this 
series, but IIUC without support for VHOST_RESET_OWNER, this could never 
have happened, so the wording should be changed to make it clear that 
this is can happen only with the new VHOST_RESET_OWNER support.

In addition, this patch must also be applied before the 
VHOST_RESET_OWNER support or merged into it.

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bcaba36becd7..1fcfe71d18be 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
>+	 * mirroring the RX send-worker kick above.
>+	 */

Can we also mention that this is related to VHOST_RESET_OWNER?

Thanks,
Stefano

>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>

