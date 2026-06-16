Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09A36D9F6
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619530; cv=none; b=n+CqRiqUQ4rYS+x9bEdWtACs6ttSQeBtzhiU/e/5EQfee0BXLqZfOwU8b7HmkUig4mKqQ6PAm6NpTs9PZ1jWvfY2wEu/vzUFcqc68lytWkDHFsqyI4EjF24RDGrw+tEUWgTO8Vg2AxWACIQeb1DZXa14h0XQsdWd5CkG4eBIGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619530; c=relaxed/simple;
	bh=vJqyvxeaNxfW6LxXVQpl4/4cnJSjsoFuDMk8hGTaUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr219l4rYiS4zHMjcYiJ2rz+6lZyZu5etjs0OeqN885Pbhwm/Bml8vE43ua7RRVfrSfV39b1I+/KNjMe+dwclbleg6ttzKNUaaDUrt0UcrTZWtHpopoEysi9ykblFxUq6rXYAxnHgaLEoHePhLFCy8cdFpVz5QbziP4eO+uo9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUxQmFk3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r84Afdb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUxQmFk3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r84Afdb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
	b=cUxQmFk3vY+94t7a2vGtuioJWzqfCqgcP4Q+ZcREkPVq/St9qFGuUeWopUkXFfVqx4PpM+
	XbNI5gkZOCsvwaHfHZspp3u4JW5qWrX+Mywyq9BG1gnqS0oISy4n3hAR5fo2FlUVf61etd
	YmHp1bDDfTRtXycDL50uPBeKuJ6+nT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-UCbD1Da0MMCEU2Mc0En23w-1; Tue, 16 Jun 2026 10:18:45 -0400
X-MC-Unique: UCbD1Da0MMCEU2Mc0En23w-1
X-Mimecast-MFC-AGG-ID: UCbD1Da0MMCEU2Mc0En23w_1781619524
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so43846085e9.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619524; x=1782224324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
        b=r84Afdb+ras7xvbCSGAiKhBQ6uMwsyZ2vB+Y959Jtah5IxdTopR9g7lEBhX3vMqqe8
         63TkAe5UR5I6jdLO3pNoibMQVPL9YQfA2V2ufrR+cXegxt1xGDrYnCgN+0nLkbs2aikm
         L7oMt+CrvwXhSUd4oR++1EwGRdGSsGVYbQ7YQ8AWF4w9+KIEgVNvN6Z/Q3+40xKvN4qw
         nTfKw4AyJ+K3saK5AQjIunr3IOm8OmdY4YqN8udW7uZUhhbBOWHpkI9JMQknM29GplpB
         C1TuGQ6pD5cpn0/b7oaUCjNapF4prgBMAWMxjV5OPlBfjg5cZzhslwru4wsJm+KiDHst
         d+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619524; x=1782224324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
        b=RlTwltwfprznpp4X9Fd6bQTlrMZ9kVy7LGmDcrOYBUq5WPn1SI85QGAUpGPNQE/65F
         njN5X+XCahJsu/2qBvBVNLSc0bGA5/5pm0pHF5Gd9wdVYKQGp0keQdtNvfnTLZvsKYCR
         V1VUX1SexkMe7fmu/m6Yluckvh4t4GMVAifIJPU3QUnVLRbDn8a5VeM4mJ3pmAFOofb4
         TUT+KrQoR2lNPdfvpkaVtpVt8Ieo6lro1yMSW+BdIUQATsXNXRg5DjAQO4l4zFEg+nYN
         HVddmiKfFjNFsafwTycalvZv818gEfulvUMiYJn/kJtfsFepZx4TXbkRq/fB6BnYmMiq
         9Hwg==
X-Forwarded-Encrypted: i=1; AFNElJ98WRWrNLwmr+CPyT54uzJysgw7gvxV0ZTLhKxkFCHo2aZAoThORyFH4KDvSPQpy6OEde4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH67at+E4A8ELqZhIG4uoe0C/h6R8Kl1g2BKZ/fSm1JHYT1i+X
	2Wd5/D1TibHhfXeGX0LRrJDCs+0oH5+4uajuZjsxalgOl7iH0dwmjg1kNWRBW1mO0BeM5uWqeCd
	0BXsBp3B8gfwjEsfsicFDVg+Z3eh8Wil6GTB6uKP+1hfvEF24lf2jRw==
X-Gm-Gg: Acq92OFNQhXPPG6qC3Qh/BweiWDG+7b1srA5T3HPIMqkuMbTbWXEm13u/EdAaGwjyjq
	zVJyDY2TYsez2Jcdq7EwpTEdwoxtVn1CirRSQUtvC1dLPBMY+5+7TFugJxt6vTTLILjABi5MZI8
	6agQTDrhXxJCKBWhctsA7WKMZoEWynq45kuP+85jROysdGLJLIa+/Qw/+adhz6qKlXRrD1HuDJJ
	pXEqIA6pVo0weePeJ43r76Dm8I1AESlqXTLBf9T8VGByTUE/fsjL9X3YftW/miPu0yhbuG+vQMS
	vy7eBVVqHGfznTPOOfPMonYETJEV1tif86MJEfXSs1S+s+5AxgaHdLVYKu5p8ACtHe7Srh+FZ+4
	KO86fzPfNG3JvHd7r0CvPcPmh7XACgfq/fgorXRQrmj60VI2ZgKkjUMvLF+HiIzWdiWHc6SE=
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60188465e9.28.1781619523790;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60187355e9.28.1781619523017;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96b47sm56484875e9.13.2026.06.16.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:18:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:18:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajFUk7quPhbI7Te-@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>

On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>Earlier commit ("ms/vhost/vsock: Refuse the connection immediately when

Please follow 
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes 
on how to refer to a commit.

>guest isn't ready") added a fast-fail in vhost_transport_send_pkt().  It
>rejects every host send with -EHOSTUNREACH until the destination calls
>SET_RUNNING(1).  The fast-fail condition checks whether device's backends
>are dropped, and if they're, the guest is considered to be not ready.

Okay, so it's not a regression, I mean without this series that patch is 
not adding any regression, no?

If it's the case, I'll change the wording in the cover letter.

>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Please add this change before starting to support VHOST_RESET_OWNER 
ioctl in vhost-vsock, otherwise we are breaking the bisectability.

>
>Add a cpr_paused flag set inside vhost_vsock_drop_backends() when the
>backend was previously live, cleared by vhost_vsock_start(). When set,
>vhost_transport_send_pkt() queues the skb instead of fast-failing; the
>existing kick of send_pkt_work in vhost_vsock_start() drains it on
>resume. A device that has never run keeps cpr_paused == false and the
>boot-time fast-fail behaviour is preserved.
>
>Pair the cpr_paused store with the backend store using an
>smp_wmb()/smp_rmb() pair so a concurrent sender on a weakly-ordered
>architecture never observes (NULL backend, !paused):
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>---
> drivers/vhost/vsock.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index e629886e5cf8..bcaba36becd7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool cpr_paused;	/* between stop and next start */
> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 	 * the mutex would be too expensive in this hot path, and we already have
> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	 *
>+	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>+	 * The kick in vhost_vsock_start() will drain them on resume.
> 	 */
> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>-		rcu_read_unlock();
>-		kfree_skb(skb);
>-		return -EHOSTUNREACH;
>+		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>+		if (!READ_ONCE(vsock->cpr_paused)) {

Can we avoid this which is not really readable and maybe add a single 
variable to control the fast-fail at all?

I mean replacing both cpr_paused + backend-pointer with a single 
`started` flag: set it to false at open, true on start via 
smp_store_release(), back to false on normal stop, and leave it true 
during CPR pause.

The reader in send_pkt can do just:

     if (!smp_load_acquire(&vsock->started))
         return -EHOSTUNREACH;

WDYT?

>+			rcu_read_unlock();
>+			kfree_skb(skb);
>+			return -EHOSTUNREACH;
>+		}


That said claude here is reporting a potential issue that I think we 
should consider:
     After VHOST_RESET_OWNER, the guest CID stays in the hash, so 
     vhost_transport_send_pkt() can still find the vsock, skip the 
     fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while 
     vhost_workers_free() is freeing workers without a synchronize_rcu() 
     — risking a use-after-free. Also, any send_pkt_work queued between 
     the last flush and worker teardown gets its VHOST_WORK_QUEUED bit 
     stuck (the vhost task exits without draining), deadlocking 
     host→guest traffic after restart.

     A synchronize_rcu() in vhost_workers_free() between the 
     rcu_assign_pointer(NULL) loop and the destroy loop would close the 
     use-after-free, and reinitializing send_pkt_work via 
     vhost_work_init() after vhost_dev_reset_owner() returns would clear 
     the stuck QUEUED bit.


> 	}
>
> 	if (virtio_vsock_skb_reply(skb))
>@@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	WRITE_ONCE(vsock->cpr_paused, false);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>
> 	lockdep_assert_held(&vsock->dev.mutex);
>
>+	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>+		WRITE_ONCE(vsock->cpr_paused, true);
>+		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	}

Why here and not in vhost_vsock_reset_owner()?

Also having this here will set it to true also with 
VHOST_VSOCK_SET_RUNNING(0), is that right?

Thanks,
Stefano

>+
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		vq = &vsock->vqs[i];
>
>@@ -728,6 +743,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->cpr_paused = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>

