Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493334;
	b=WwhDtalAB0NpRHLOmIGX66qXV+uV3Y+tbdq3VNgNQvEiNDmOkGMVsXt1SnciMW3SVyHq
	 r8kRIPa2Z5OvKvpyKGoBZUaaNu2ofSKPJgCT8Emuni3+lfTQyVBSg0+Rm6fBdrxMg8LJy
	 2PhVPDLNROaulBs2TTFODD2udEN5aBaPmas8ut+axYQhaXax5dQvenit+czouhnXWN9m2
	 br/Gxa3orv3u2C2H/wrCTNWm+6WBaAIaPVAUZ5Cm9igTpP4sFHhwWi38ykbYoCKv4iKG4
	 /DE5D9YYzv3NfE+Pbom5LZDvmapCOLET1SB7jqohLGiQRX6uZBhBov4M6aFvEFr2x8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493334;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=n7UmdptfkyUGIHI7PjXB+goWf/A3ecrQ13plqX4WP02onVOh6IrUTBTAPF646cW4a9eg
	 NvNjZ3aa91g9nB8q15QIsP3mOZYAq7LyMYqHdvVLnwXF36nhzuAXNZMgB6eQ8GIfTfHBP
	 JQ/raRo4LzjTmwX1gYYXDrWW0pMVEx7QKkK5j0FkQUb9uDMRPnMQb2A4+JgzRQ5UePA4J
	 YixwQ8TxZymSnUPzXWmH9zBQazl5gT+9WMrnSVdVy6mTuTDu0l5c4p7Apb/ucdJcCvDQd
	 stezuzU3JPhScbzl2TPGaFG1bbVj25GK4vS1o9EbmLgVCvTYT0fLSM7UQRRf8bvd5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JOEWwrZI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PqIaq6tp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE048606A896
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE048606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JOEWwrZI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PqIaq6tp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
	b=JOEWwrZIr2tHSZ/6Tiq1eZjnTMtV58BpppujzfCPAdRqvytVZhzuZCyOGdnIiDV0uxVtvF
	a57iXWpZLtMM3b1eY8J2+5K9it8/1HSmTtAbwIXUShJEGiIcPzX1aWsk/u/xQ8AZQ6oKju
	9ihSpfSpi+/s9twX+qIFcGe9SUzcJ9U=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-HtRYilcxOlGSedR-p2p6xg-1; Thu, 12 Nov 2026 09:22:11 -0500
X-MC-Unique: HtRYilcxOlGSedR-p2p6xg-1
X-Mimecast-MFC-AGG-ID: HtRYilcxOlGSedR-p2p6xg_1794493331
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4dc57e2a3f2so5949457b6e.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794493331; x=1795098131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
        b=PqIaq6tpC3qulR4Jy7cYgsLAsKcRKjTfd+W1Zx/p92JVotlZkNLwJOjvEXnB2U/9hh
         aEM4/hvy4HCjf6aatFLi0NjUjD+R9TaMzZlqjQ1pqv8x375HgB/q1ttcZAPJgjPxQAOo
         hLl8KuBqTu/Bm7P/POJMrXnu9OsA1i0ukxm6EuPox763QDa3wzazZOvJV5FJah0tsvOg
         c4DtdIxFVsSeMrHUlrqLjAjVoEshb/woPzb14frNfnJx872mITsv3cqXRRXvyTBImpxh
         IDOVklDCjjyB1NeGDr5os4/s2mwdAQi5BJ+/C5C5IwL4NjDjYF/ZS+dg5ByCiBQjbd+W
         FRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493331; x=1795098131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5ycgM6KpIgl8GosUfIZQ6wJ8AxoFNABYsI2jhCC9jo=;
        b=VgP1zINwy9Bw1ZWyj/u7tWAFHCYIE2qIGWeyviWTiuzEvcwA16TVVMuRdCKNJB5p40
         BQQQqzF/Fob5tz8mh4faDqA00VHOe7o0abFLTl5aCX4+NkJQRn/ZXSPDfd5S12Ep5MWL
         USdZOWFJ/2jVLRswCTGC6Wy8biJcFvgznQgjiqmm1ntC8qhpBvaRCWsAEX7YPBZVJ1JO
         GlMke+RWFWewg1KZm9actw29YhHDbXdMQORHcoJQXQwRmJ0aZROKtSe56TPXBc38EJf8
         spdPsjxMSKHTTqO577PUyo3kdPl/rfOFHfWz1cAitWxez4VJ7PVJp6JAQF9fnzUZ8gg0
         p1+Q==
X-Forwarded-Encrypted: i=1; AL+hErEqKQDeSWGfN4698IMCQpCNdajuph3n4m62bwqWBQ7eQZ7slFmAqtgSI4wwjEW4ZgrTduM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wO7lVtWwk0wXaY8NcopgH2t2CI992N/wDTGxgFvU3kHUA3Lu/
	gx7mN4udK1S/hbouJRV+m+YSgCguFN6BGVHdw4lmvNiqj1Bni7Mc72eZVjQWm/ZK2qjLH35EdHI
	KDDiagX6goIBWAEM03aEblJi658abMJOyr2y6zDNFSsedZ4RFAPwXUA==
X-Gm-Gg: AYBFou3tpQznFPSk9u7r8oqgun4B0fEV+3YrZ1L0ihY8S1JvLzDHHYPHD8sLplUlkiP
	rxLq9mO42szS/BjDi8ZNkkQcFoYxWdzP9JsvFbb+JLSR99RUh+QicwCyMKhn57ZRMqeqTA89HQJ
	Vn3CyjYhx4q0mFNTNsi+BLN469wfJOmRd39Ley3ES+59LBtnFroJ4H/NDu5hvebeZiaGZSdBZjO
	c3oJanzH3xHhIH7LB0jYRVYuI1VdsptClvJ0xdLkAxi3Mubzkysqug49dMDWJ2/h5953VOKixbL
	ZtJW1O0VMi1wZSVwwrXdOlCCxA5AXm6kxDYO1uxyXgxtx4tLmnp7zChNea6Uzzj122tWPyBtbhY
	UcfWgKlPTY8IMj+ULhuU1tqoQOH3cxZePHd4rDnvyzI2LoRWScf1a
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468291b6e.28.1794493330942;
        Thu, 12 Nov 2026 06:22:10 -0800 (PST)
X-Received: by 2002:a05:6808:5198:b0:4f4:9314:af39 with SMTP id 5614622812f47-56b96bd3b81mr4468260b6e.28.1794493329942;
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm5819481fac.9.2026.11.12.06.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:22:09 -0800 (PST)
Date: Thu, 12 Nov 2026 15:21:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] vhost/vsock: release the accounting of
 packets dropped on rx errors
Message-ID: <avXG51ibBiap9tG9@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-2-green@linuxhacker.ru>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261106050244.602625-2-green@linuxhacker.ru>

On Fri, Nov 06, 2026 at 12:02:42AM -0500, Oleg Drokin wrote:
>When vhost_transport_do_send_pkt() fails to deliver a packet to the guest
>(unexpected output buffers, a buffer smaller than the header, a fault
>while copying the header or the payload) it frees the skb with
>kfree_skb() and gives up. The success path does more:
>virtio_transport_consume_skb_sent() subtracts the payload from the
>socket's bytes_unsent (SIOCOUTQ), and for a reply the queued_replies
>counter is decremented, restarting the guest's tx queue once it drops
>below the ring size.
>
>The error paths skip both. Every such drop leaves SIOCOUTQ too high for
>the life of the socket, and every dropped reply permanently takes one
>slot of the queued_replies budget, so that after a ring's worth of them
>vhost stops processing the guest's tx queue for good.
>
>Release both on the error paths, as the success path does.
>
>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM. These error paths were not
>reproduced: they need a guest that posts malformed rx buffers.
>
>Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>Fixes: e6ab45005772 ("vsock/virtio: add SIOCOUTQ support for all virtio based transports")

Why this Fixes tag?

>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> drivers/vhost/vsock.c | 23 +++++++++++++++++++----
> 1 file changed, 19 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 88a310390eb0..b0004cb48999 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -104,6 +104,21 @@ static bool vhost_transport_has_remote_cid(struct 
>vsock_sock *vsk, u32 cid)
> 	return found;
> }
>
>+/* Undo the send accounting of an undelivered skb; true if tx may restart. */
>+static bool vhost_vsock_drop_skb(struct vhost_vsock *vsock, struct sk_buff *skb)
>+{
>+	bool restart_tx = false;
>+
>+	if (virtio_vsock_skb_reply(skb)) {
>+		int val = atomic_dec_return(&vsock->queued_replies);
>+
>+		restart_tx = val + 1 == vsock->vqs[VSOCK_VQ_TX].num;

Can we add a comment to explain this check?

>+	}

nit: try to follow the style, e.g. leave a blank line here.

>+	virtio_transport_consume_skb_sent(skb, false);

mmm, this entire function is very similar to the code we have in 
vhost_transport_do_send_pkt() where we also call 
virtio_transport_consume_skb_sent() but with consume=true.

What about renaming this entire function to vhost_vsock_release_skb(), 
adding a new `delivered` parameter to be passed to 
virtio_transport_consume_skb_sent() (and to be used to call or not 
kfree_skb()) ?

Thanks,
Stefano

>+	kfree_skb(skb);
>+	return restart_tx;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -162,14 +177,14 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		}
>
> 		if (out) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
> 			break;
> 		}
>
> 		iov_len = iov_length(&vq->iov[out], in);
> 		if (iov_len < sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
> 			break;
> 		}
>@@ -212,7 +227,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>
> 		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
> 		if (nbytes != sizeof(*hdr)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt hdr\n");
> 			break;
> 		}
>@@ -221,7 +236,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 					   offset,
> 					   &iov_iter,
> 					   payload_len)) {
>-			kfree_skb(skb);
>+			restart_tx |= vhost_vsock_drop_skb(vsock, skb);
> 			vq_err(vq, "Faulted on copying pkt buf\n");
> 			break;
> 		}
>-- 
>2.56.0
>

