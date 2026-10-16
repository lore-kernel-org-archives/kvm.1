Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04545040F
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161782; cv=none; b=OOJfFQr2WFnBY3Yhg8LNWpP+iaivLJVDlcsoiJ1Rzzp9wbKh7DQytpyy8dPaiRY0MgZP70wtS8Lv5KLe2NGNwJcp4A+e2eQ8nORCfM9UCCykQKHBgEe//yWf4S/gS7WELMYAxbrEoUA4ktpjCdRc+PCWFh0pa1Occ5cwEb1HGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161782; c=relaxed/simple;
	bh=6nU0p7akGtqHdSMO8WKU+bNNm8kXt03xfgcKKZOrDGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfHnwYaCMTvvaPjRQAoPjdCw4FjuohlIPnVZg4AXelz93f2IEUE5JORhdEvGBHFS5HaN9bKlb+mVFcoyEMSrtnWvgMWVwb7jvwo6ui+X/zoAwISyVTtfbZ4ZfV75zxoQLcU6O0+rEzs8rHgf0QHKMF3EwtpM0smpNqjvLAub4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGQXPeGf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu3FxlXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGQXPeGf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu3FxlXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792161779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad1yI/+jctmjqADu5rjo+cKNGx7OsfvQXcHn8HUJncA=;
	b=OGQXPeGflH9qbUSW1gSzKqMv16VflObmTQfiQHlLeaz9wbBjhVndyiuGRY5YuZCclYz8wX
	nI2rgolge9ut42soz3hUChlJ1DchUytQxPPTTQ7CzahyeoJgpbuED0L0flZ7W6BkAVib/c
	T18BwJWYAqUrC7sfkxYbodWNS+xWTTM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-X34I2Il-NbuH2uwTSpSGBQ-1; Fri, 16 Oct 2026 14:42:54 +0000
X-MC-Unique: X34I2Il-NbuH2uwTSpSGBQ-1
X-Mimecast-MFC-AGG-ID: X34I2Il-NbuH2uwTSpSGBQ_1792161773
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c427421f6so2041694f8f.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792161773; x=1792766573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ad1yI/+jctmjqADu5rjo+cKNGx7OsfvQXcHn8HUJncA=;
        b=Pu3FxlXjYfvB8ktV+jUUbBkrAF7NuPolPf7k8YWaWuk2qJuHnTiVZzeirjWL2q79d1
         WInxKGBjO6/G4pouYwafkhSptjKdsEXlID4QtBAP+PoChaGNF9SOprux2KessZOv/2xi
         hsv+QKjomXrflfGIg7uiIg6WVgs1tEeihWVUKq2QOXT6BQbuSZBtoM3M0JppkfMt5TYv
         K/6IhN/CX9cwN1dicY0xdUS6Vvf6TzbkISJARP0PdgnJTQbAl/waKcS0VJvaDlEWQRoo
         A5raI0l2zdEmy2jpffs25IDmRaaDZt+BWoag8DHHDZ8oZqnZ6tk4YcIwO3yFehgloZX2
         JCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161773; x=1792766573;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ad1yI/+jctmjqADu5rjo+cKNGx7OsfvQXcHn8HUJncA=;
        b=HvbdDrgR6FmZENGakX6ZM2y0hD64UHHWpRXC46ke/OLNoRrxT1CTGypB4b+gj258j+
         ST2y5hcwtHjg3PPegBWdnHOeuIpSV1qx/Vq8SzlFWIUVMCsbhvPkwcvKsW6X+eQ/YBw1
         0AzGyXD1btiwBAJyBpSQxcxm8aQwzOPvLggOdINEap/Fu7AJPNPZdSNSqUvfxfI8Qk24
         25GSz3LAXAL+GmGRpLSdpg7QZgy4J/hXPWPwwYv4C11yIIMNNSbHf/rVJ9F4WvH/afqH
         yQNQYxlWGBT7ORtD54Hvg1VER7FqnKKlsJ2GAZ7L7G4oIDSFINaNATOHFT8WNjDafKbv
         LMvw==
X-Forwarded-Encrypted: i=1; AKwUvBxO52sPbhN2exnVTNCBHUVtw/9ih0V+jnRHF/K/U+d7WBOCov6XJP0/pmACufBplJGQe6E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIF8Or2lvqLj2NFY7sR9bAkM1srodgV8AmEAETy5DFalDDd56Ha
	J2OkBZTivkuIqmXi8WW1JhXXgAdBJv+hsIMEpozfylkycaCdNhEdmlldWAVgDzdYPqys5DMsDy/
	r1hmIvTpWX3gKJx/y5zQ++Qual+MCRflkdxV1x6oyzL8w47xPEwUI6g==
X-Gm-Gg: AYBFou1/O88pQhDxdzZ2Lo0VbybV/w36UvzMFPDCHF0YNk/Di+qeKNH/g94uU10t20o
	QAykGKqn59lQeBhpKlzLY970Q52yAl2IUjrJgnRte3utVSxJI6fLCmxYWT+tpuLMzLDtnQh5MVE
	O4IUHvO7MLOaY+L/zbbJ7jFfSOxOt9qdHR4FajDz52PI7OMyFA/wpdN0LoY9ubjiSt5COhKETPx
	GrDdKczleHUaeJGTZeJstsh53yZZX3UMla76Z9LYkWS9rwTclvN0egoYk3+AcgV+BmmVG99o4et
	8CuJhmuyIo3MUAPgQtpvOOf0vlvjYTfOjkx4JsfYetY8BkteRJzomWji5+QyIZbStRLMroD8H4A
	5Lqzm
X-Received: by 2002:a5d:55c8:0:b0:48c:7d67:8ee5 with SMTP id ffacd0b85a97d-48dbaae35c2mr34270722f8f.43.1792161773018;
        Fri, 16 Oct 2026 07:42:53 -0700 (PDT)
X-Received: by 2002:a5d:55c8:0:b0:48c:7d67:8ee5 with SMTP id ffacd0b85a97d-48dbaae35c2mr34270691f8f.43.1792161772592;
        Fri, 16 Oct 2026 07:42:52 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.137.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm5554362f8f.54.2026.10.16.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:42:51 -0700 (PDT)
Date: Fri, 16 Oct 2026 16:42:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 4/4] vsock/virtio: defer RX notifications
 until batch unlock
Message-ID: <atI3neoHXhgiEpYJ@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-5-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261014115640.184286-5-physicalmtea@gmail.com>

On Wed, Oct 14, 2026 at 07:56:40PM +0800, Jia Jia wrote:
>An RX batch can make a socket readable while the worker still holds its
>socket lock. Waking a blocking reader then only moves it to waiting for
>the same lock.
>
>Record the existing low-watermark condition and notify once after
>release_sock(). Move the coalesced write-space notification after the
>unlock as well, since both callbacks wake sk_sleep(sk). Deliver
>write-space before data-ready and keep the lookup reference until both
>callbacks complete.
>
>As with write-space, save the initial sk_data_ready callback and batch only
>while both saved callbacks remain installed. Sockets with replaced
>callbacks retain their per-packet behavior.
>
>The existing psock-marker check also covers a concurrent sockmap attach:
>at most the already admitted packet completes on the native path, and the
>next packet ends the batch.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> include/net/af_vsock.h                  |  5 ++--
> net/vmw_vsock/af_vsock.c                |  1 +
> net/vmw_vsock/virtio_transport_common.c | 35 ++++++++++++++++++-------
> 4 files changed, 31 insertions(+), 11 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index bf077ee0ded88..f1396ca3ad9b5 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
> 	unsigned int pkts;
> 	size_t bytes;
> 	bool write_space_pending;
>+	bool data_ready_pending;
> };
>
> void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9a40960d10cbe..78bab5820f528 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -64,9 +64,10 @@ struct vsock_sock {
> 	bool sent_request;
> 	bool ignore_connecting_rst;
> 	/*
>-	 * Initial callback, used to identify replacements and deliver deferred
>-	 * write-space notifications.
>+	 * Initial callbacks, used to identify replacements and deliver deferred
>+	 * notifications.
> 	 */
>+	void (*default_data_ready)(struct sock *sk);
> 	void (*default_write_space)(struct sock *sk);
>
> 	/* Protected by lock_sock(sk) */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fe7f49da6c4bc..f40659ec29df0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
> 		sk->sk_type = type;
>
> 	vsk = vsock_sk(sk);
>+	vsk->default_data_ready = sk->sk_data_ready;
> 	vsk->default_write_space = sk->sk_write_space;
> 	vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
> 	vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f4b5f0230493e..8b62b789b71c5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1588,7 +1588,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> static int
> virtio_transport_recv_connected(struct sock *sk,
>-				struct sk_buff *skb)
>+				struct sk_buff *skb,
>+				bool *data_ready_pending)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vsock_sock *vsk = vsock_sk(sk);
>@@ -1607,7 +1608,13 @@ virtio_transport_recv_connected(struct sock *sk,
> 			vsock_remove_sock(vsk);
> 			break;
> 		}
>-		vsock_data_ready(sk);
>+		if (!data_ready_pending) {
>+			vsock_data_ready(sk);
>+		} else if (!*data_ready_pending &&
>+			   (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>+			    sock_flag(sk, SOCK_DONE))) {
>+			*data_ready_pending = true;
>+		}
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> 		virtio_transport_send_credit_update(vsk);
>@@ -1820,6 +1827,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> 	return sk->sk_state == TCP_ESTABLISHED &&
> 	       sk->sk_type == SOCK_STREAM &&
> 	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>+	       READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
> 	       READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
> 	       !sock_flag(sk, SOCK_DONE) &&
> 	       vsk->transport == &t->transport &&
>@@ -1830,8 +1838,9 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> /*
>  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>  * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
>- * record a default write-space notification for batch finish instead of
>- * delivering it immediately.  Return true if the caller must free @skb.
>+ * record default write-space and data-ready notifications for batch finish
>+ * instead of delivering them immediately.  Return true if the caller must
>+ * free @skb.
>  */
> static bool
> virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>@@ -1883,7 +1892,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	case TCP_ESTABLISHED:
>-		virtio_transport_recv_connected(sk, skb);
>+		virtio_transport_recv_connected(sk, skb,
>+						batch ?
>+						&batch->data_ready_pending : NULL);
> 		break;
> 	case TCP_CLOSING:
> 		virtio_transport_recv_disconnecting(sk, skb);
>@@ -1957,27 +1968,33 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> /*
>  * Finish the RX batch.
>  * For a non-empty batch, the caller holds the socket lock acquired with
>- * lock_sock(). Deliver any deferred write-space notification while the lock
>- * is held, then release the lock and the batch's lookup reference.
>- * An empty batch is a no-op.
>+ * lock_sock(). Release the lock, deliver any deferred write-space and
>+ * data-ready notifications in that order, then drop the batch's lookup
>+ * reference. An empty batch is a no-op.
>  */
> void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> {
> 	bool write_space_pending = batch->write_space_pending;
>+	bool data_ready_pending = batch->data_ready_pending;
> 	struct sock *sk = batch->sk;
>
> 	batch->sk = NULL;
> 	batch->pkts = 0;
> 	batch->bytes = 0;
> 	batch->write_space_pending = false;
>+	batch->data_ready_pending = false;
>
> 	if (!sk)
> 		return;
>
>+	release_sock(sk);
>+

Why in the previous patch we release the socket after calling 
default_write_space() and now we are moving before?

> 	if (write_space_pending)
> 		vsock_sk(sk)->default_write_space(sk);
>
>-	release_sock(sk);
>+	if (data_ready_pending)
>+		vsock_sk(sk)->default_data_ready(sk);
>+
> 	sock_put(sk);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
>-- 
>2.53.0
>

