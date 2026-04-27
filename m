Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6839B4A5
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297534; cv=none; b=olkPGml9PnNS3OhOiEfRCcZCZxVk3nJMQzSuCbWPlZpiERtzXi/ugyRDsl9UZgbSx4Go8X62P4LNVoCulhOYAZnSbgTL0dIxe0UDxQZ7Kooqjhi6w3ijB/Q1B2VB77ieMpkSt9uBxUWp3FqlOTMDx5zCLImt5TuPm7OQbGWe2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297534; c=relaxed/simple;
	bh=vdEge6E6gvHM8ffoINkybHalssstepUGTZdrRvykmLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okFmGFbZjfyjUle6OxE6lKQmFUitwA0ENFjfU8sbObyf8ae8leux+CcXvbYjsaOoI8Fx5wIu1VVYOuJLbMqnnxst/asVT80ebp6X6sujYBqfMitWYfiXy6hX043GSfljnG2kXYwGqrcpjJQhdBzQUHnFaT67T297+BzF/kD7bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7zXatVB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6bLZzeL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7zXatVB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6bLZzeL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777297528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
	b=T7zXatVBq6kU24t/mXRusvQqSNjDfEyNPaMffmB5tz/DrycndpS0af8KL5RL/hmNp7Zu/q
	tKb7/XpPSv9ZnPXkm72lcK7Bkbq+wK3FbiJWCW7kXKzBDXcilGf2h5LSuyFKqmQ1WLWY0n
	XxO3TgDW/T0M4fNugzDYnuCWwKWZwoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-d6YQ431vP8WDDRM4NOaK5Q-1; Mon, 27 Apr 2026 09:45:26 -0400
X-MC-Unique: d6YQ431vP8WDDRM4NOaK5Q-1
X-Mimecast-MFC-AGG-ID: d6YQ431vP8WDDRM4NOaK5Q_1777297526
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-440d0c4401aso7548708f8f.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777297521; x=1777902321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
        b=Z6bLZzeLzILM+eK/wPct1O5ddsj7a6waMRazWRzGSIkB5NdCdEL47nfO60VZmdiSfx
         6mlgA1aJGFq7urag+ufUefypzVoRo4Dy/3P+aXOtRVWW8QS7hc1gS6glrIc9YvO29gYy
         OCq5RmnOlGR2lDwKulpSOwcCU/hbBU+/CwMUP5h9faqFGgeRgm9frclSvbTF4xQX1vaU
         lzGNXp7DRT2HGRTcYXrnRXwLWN/M5N4XGITlRVUC01SMsBvnhgEJc5fWNeaX2Nl9Aakv
         uNkWSdZcjc4KYLr35mcoO4/wSNHC3vZyO3cxSMZ2gT4f5M3Vhq/S8qOkVtXm4F3iTUwx
         7nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297521; x=1777902321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnZE4tGGwssQvL+J9Xkflayp0lDMTh/2EiF7Li6rJVI=;
        b=VynOhowpD5yazCwoV4qgDS+xjEKP22u86WgteiwiXPgMGhB7XcMmEqRWLI+8k6E0bZ
         IofqX2E1KuMQfQb+osLEK92e4/N/vVkeCGstf4Rer7VAiGn0nuKxfkkPT/tPlbCF4tfL
         rCJ8CPQ+Pq6oCMcOPTCXXeVXyup65K+HMRYVtREpCIxKRlrUNPUqGNKPoKrQqxG0g9XL
         GnxbVOCvPcDMSl3KSByhehPkr+QR0j0MBHRcMstOtyss6ywUswBAFA1l/1a56BbNd2gb
         pP2BNgv39+k97ORBWOaq7/w9HN1yxZl64KfqFbTdDEUwUMUhDyXN4qm/PPtqs8dMaWuq
         vdoA==
X-Forwarded-Encrypted: i=1; AFNElJ+G/QcI1TjW+UTBUGubsjnMLSmp/Mk2Qz2F2CSHbO5Ydtu+T5zbLoXjqNrTPsTZEU2iObQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+OT9hUYRYtITMpWKbYGBRy1pOEHdyq+584qDgstywUAf2Xzk
	DHNaDoVOGrQnC6K+30NqYAISxtEu74En6R/AbE2fptisXH/uwhrWxAGG8o69By5nElq36EMUm6p
	vd1BtzWljmQDkSf6H0Bs+1HL2GrUsH27Z2TaHf4I3SoILFS5j4FLVRg==
X-Gm-Gg: AeBDiet5PMllq7f+0biwUSuVymCbiLZX3oYQ02hO1WTB6lH9mczxXuksVUpSBs0fRqZ
	o+rY6h091x7mo1LMILlN9y2ul0Y1u5AUJyFgdYoNiCDp+tdnf0ma8aDA2bTcNh1PsBkjhrCvOUP
	I7uNtsrL4sL2QYDFwERpfsyNZDuESvujR1835xFnf6uyT8028TuuYze1ZJdrnnmQ8CQD6OUKft1
	999IvD8+8jrCbhXK8lDDSQmSYNrQRsCeq3EpQO8pIJP3btW5TIFP996t1NxhBuThk4cbyCuiCyf
	859kTtnQkY7SEMJ5AIY/+GJlWn0rK0kzEj211bNHIuHSxPA10dnKS11/DKjiTbL772VudvS78kA
	VKY/HWNbZAwYbm7YwGmU+375lWn7X4USPgINXSH3n6X1Xpy0QGp2CRz23331eXJ5GGliifEKpUA
	wuPvdZ7Q==
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258918f8f.15.1777297520891;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2888:b0:43d:7b23:bc99 with SMTP id ffacd0b85a97d-43fe3dc8152mr68258832f8f.15.1777297520331;
        Mon, 27 Apr 2026 06:45:20 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm81966218f8f.10.2026.04.27.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:45:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 15:44:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260424150310.57228-1-kartikey406@gmail.com>

On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>Two bugs exist in virtio_transport_recv_listen():

Two bugs, two fixes, two patches usually.

>
>1. On the transport assignment error path, sk_acceptq_added() is called
>   but sk_acceptq_removed() is never called when vsock_assign_transport()
>   fails or assigns a different transport than expected. This causes the
>   parent listener's accept backlog counter to be permanently inflated,
>   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>   connections.

Wait, I can't see this issue. sk_acceptq_added() is called after the
vsock_assign_transport(), so why we should call sk_acceptq_removed()
in the error path of vsock_assign_transport()?

Maybe I'm missing something.

>
>2. There is a race between __vsock_release() and vsock_enqueue_accept().
>   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>   the accept queue under the parent socket lock. However,
>   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>   calls vsock_enqueue_accept() without holding the parent socket lock.

Are you sure about this?

virtio_transport_recv_listen() is called only by 
virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really 
confused.

>   This means a child socket can be enqueued after __vsock_release() has
>   already flushed the queue, causing the child socket and its associated
>   resources to leak
>   permanently. The existing comment in the code hints at this race but
>   the fix was never implemented.

Are you referring to:
	/* __vsock_release() might have already flushed accept_queue.
	 * Subsequent enqueues would lead to a memory leak.
	 */
	if (sk->sk_shutdown == SHUTDOWN_MASK) {
		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
		return -ESHUTDOWN;
	}

In this case I think we are saying that we are doing this check exactly 
to avoid that issue.

>
>Fix both issues: add sk_acceptq_removed() on the transport error path,

Again, better to fix the 2 issues with 2 patches (same series is fine).

>and re-check sk->sk_shutdown under the parent socket lock before calling
>vsock_enqueue_accept() to close the race window. The child socket lock
>is released before acquiring the parent socket lock to maintain correct
>lock ordering (parent before child).
>

We are missing the Fixes tag, and I think we can target the `net` tree
with this patch (i.e. [PATCH net]), see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..fad5fa4a4296 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 */
> 	if (ret || vchild->transport != &t->transport) {
> 		release_sock(child);
>+		sk_acceptq_removed(sk);

Ditto, are we sure about this?

> 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 		sock_put(child);
> 		return ret;
>@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		child->sk_write_space(child);
>
> 	vsock_insert_connected(vchild);
>+	release_sock(child);
>+	lock_sock(sk);

IMO this is a deadlock with the lock_sock(sk) called by the caller.

Also a comment would be helpful here to explain why we're doing this.

>+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>+		release_sock(sk);
>+		sk_acceptq_removed(sk);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>+		sock_put(child);
>+		return -ESHUTDOWN;

Since this is very similar to the error path of 
vsock_assign_transport(), I think it would be better to start by 
defining a common error path for the function and use labels to exit, so 
we can avoid duplicating the code multiple times.

>+	}
> 	vsock_enqueue_accept(sk, child);
>+	release_sock(sk);
> 	virtio_transport_send_response(vchild, skb);
>
>-	release_sock(child);
>-

TBH I'm really worried about this patch since both fixes are completely 
wrong IMO.

Thanks,
Stefano

> 	sk->sk_data_ready(sk);
> 	return 0;
> }
>-- 
>2.43.0
>

