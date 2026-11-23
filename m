Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427006;
	b=xmT3iDvEO1QWwtNFkiB2jiuVutAKEvKmepMNP+0bFV3lWIEnXFDfOX4HGHKQ3vTk5yOB
	 S94gWVTRn4Yi0ObrUhXuM0rTWfHjyXTsQ2ZSTjn6eHj+aMxXqFBSKh/Z8cBPbHHV0uT+f
	 RKHXgpcKRcBlZs31+wljJKHZTRReMCOwSm5L1+GmTaucl8XNgaMuKz5++4n0uKGeSSaZ4
	 3QfHHFAY/r9c2J9vHu7c1//IRfF87RIVWaclultUYsFNG2FbHlz0pIP3r8zxZpf88ccy+
	 AJmtKTVT0pQeSE4nSXOXy+r2B5JPnf0tANUEH5mVOdbiGnbrfW9sL2Tvh+8m3tcioWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427006;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4J356MHWnNb4uOE0NENBbeFM2roPC3vQr9WKSEBSDyU=;
	b=SbQWYiaGsj+TFvrFO6JZX2f4a4gbG00i8oYUkRHwxhrOcwI8DghbKd6Yld4cLeRvzp3z
	 9khUDnmKmXPl2oX7CK8oZs57uP68hTXsyqG0rwkfC6JouROiZCGFsVBU8wc3SpTwr8Vek
	 FL9sDcUhSFKNwhLDS5m5BXklEtb6J2E66m/Ppeqn8iTMa4/r+2gcPZ8QlqlRbCznU2SpB
	 5lF0xB16rk8QdZqwNpnLhsZSa/upiaPbdun12GQgB93ML/XwkJ8NH+UUI54YBp5KeLoZb
	 4MwxjpGnFkTE+hi+Ob9hGB5fomXj+qde3u5iGGovxEzTluHgd/3SnK59F1AhQ46KbOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OGqhQ+0M;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gIsy0EOG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0238606A334
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0238606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OGqhQ+0M;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gIsy0EOG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795427005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4J356MHWnNb4uOE0NENBbeFM2roPC3vQr9WKSEBSDyU=;
	b=OGqhQ+0MLmUotH1pueOn4peO0ao4C2RRBBH0OPcD6D4kDVavsjFNjKzyOXrtUhfMbL7vJC
	ZSGoAcez3epqr3+RtR3mGMffOAqFG4ymHhUVLUAbBhYV2a7GPSFm0vkI6b0sTMGTN0EmpT
	NAbc6QZXeVbE7O+9N97bMuuKYfrQHug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-tcMaoUloNxW8JJkyX1rP3w-1; Mon, 23 Nov 2026 09:43:22 +0000
X-MC-Unique: tcMaoUloNxW8JJkyX1rP3w-1
X-Mimecast-MFC-AGG-ID: tcMaoUloNxW8JJkyX1rP3w_1795427002
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ba078abd78so18891445e9.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795427001; x=1796031801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4J356MHWnNb4uOE0NENBbeFM2roPC3vQr9WKSEBSDyU=;
        b=gIsy0EOG46GUIw4z6094Fqa9Kw4kM0sbGHFxhfE5oUfeBHWSId9yWlA5H0Jno4FERl
         WBeZ+NKGH+u/IDsPZugMuT2vt3ZpY1NUNZ3mfcfA6f+gsDgIX7xrKACPdXJ5/GEFLxrw
         0g4FfvSMDA/RQBtAyF9Tw8MOz59T43bby4Vs7ue15TFOIj3JcGlcYyKpZA1W0tWhtEeJ
         siNlsp2pKot09Jpk5o1Xdgc2Q15wahJZyKP+iF+iXHvxboVeXCLxAGqlDbVHwN/mGvdU
         6leS8xOrRyN31+aLoEgGbkTILj+QteWWxcFv5ca1+JlpmNZ9MsMlLo/daE+AGTGjPPRn
         RVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795427001; x=1796031801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4J356MHWnNb4uOE0NENBbeFM2roPC3vQr9WKSEBSDyU=;
        b=EXgwGQJHRSNXeobpB5R+GwMGpmd8H+mb0eczt+BuvOtC7ASTpxQSVrHHjjxVlxH/qo
         JB4mMl6VnfF3JOCKabaVdLyn65wCfa4+I72l/W55WuXN/G6qXt8gxaeKPp6xfJOHvGy+
         26alVtXZN/Ef8v4s+TC/rl9Rynif+OZGreCfdEtvUVntLJhpcRUoC77LfpwiZFfoyH6l
         JkHh/N9fV7Q5xKNzqXWnTFv1ZIL0lgZp5+4yjtJbAoBp6FecWxvcyJLAWnhbBysgf6wj
         b5zxijtK+Iog0egmOSIM0gZ7Yjm7BRCjnEtHutRl8KzLbrgMub4WDH0qUfywxDDbsoAm
         vl0g==
X-Forwarded-Encrypted: i=1; AL+hErGVEhEEQD/8iMRe2UHmyRHfYW1nB2NdwBkhanV4qxj+QUC3FE6fKXd8WYoFZvII4kmqwWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uMugTEojLqznPITSylOix72jzvCAvvjicz+aezjkpQoA+obg4
	h3o0AHn+hC6pE7whtxEvQK2D3gWEZImgg6glxDhxBjvs+aTVXuoSuv0v1S1Jv93JZRv3Iivmj2F
	nD5koGZTSIJ4oJhXRTMTaBwFQvL6PaHGaB5wjRUt5ztGiEowT8tWblA==
X-Gm-Gg: AZFdTZcXReNDzUPmM8yvbZVoM96NeSf/1sfgI/uUd5afJZ8jHzLwZ3I6ZOxwgaRvWTA
	+xgueombzvkokwVEHgIWOrNoyW7b5rYTuPwtJ8nRPweFmMfsOX7m46KVWOAkyE6rNNMAfUsIx9v
	CzxiN6fV7NRvDCaTmkITbbGHhN4myZkALVBIuTY0Rvfcy+Ffsr+qL1n1ees/GRO4mENfH2wN49e
	ssKT2WuX1j2wNtQTbnxqDNgpQqfNvcxXlkm23f1+CT3QRMM1zRK1D74zz1MlVB5TC4Sk208NSQa
	gYTsX2lWIafvpJCAQdf08BrDSeoLe4o9t9LxkvrCf8LTO3wkigTvgarOpmbQkVAJ4ITXvY11DYt
	DN5n4AOQdHbpcu2K3Ly6HSxIu/j3rQVUl5KbsJueRXWqkaim+Gu6tsQ==
X-Received: by 2002:a05:600c:46cc:b0:4bb:69b3:2b42 with SMTP id 5b1f17b1804b1-4bb888277b3mr231836145e9.16.1795427001509;
        Mon, 23 Nov 2026 01:43:21 -0800 (PST)
X-Received: by 2002:a05:600c:46cc:b0:4bb:69b3:2b42 with SMTP id 5b1f17b1804b1-4bb888277b3mr231835605e9.16.1795427001047;
        Mon, 23 Nov 2026 01:43:21 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm334271205e9.15.2026.11.23.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:43:19 -0800 (PST)
Date: Mon, 23 Nov 2026 10:43:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can
 reach the device
Message-ID: <awQJo8WE5Gn4nYHp@sgarzare-redhat>
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
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
In-Reply-To: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>

On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>vsock_deliver_tap() clones every packet to every vsockmon device on the
>system. Creating one needs only CAP_NET_ADMIN in the owning user
>namespace, so an unprivileged user can capture the traffic of local mode
>namespaces.
>
>Pass the packet's netns to vsock_deliver_tap() and only deliver to
>devices that pass vsock_net_check_mode(), the same rule socket lookups
>use. vhost passes the vhost_vsock netns, loopback the sending socket's
>netns, and virtio-vsock NULL (global mode).

For local namespaces I think we are fine, but what about global?

Is it okay that a namespace with global can capture all the packets of 
other global namespaces?

Asking because at this point the CAP_NET_ADMIN is useless, since an user 
on a global namespace, without CAP_NET_ADMIN, can just create a 
namespace to have CAP_NET_ADMIN and access all the traffic. Should we 
fix also that?

Thanks,
Stefano

>
>Fixes: a69686327e42 ("vsock: add netns support to virtio transports")
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> drivers/vhost/vsock.c                   |  4 ++--
> include/linux/virtio_vsock.h            |  2 +-
> include/net/af_vsock.h                  |  3 ++-
> net/vmw_vsock/af_vsock_tap.c            | 10 +++++++---
> net/vmw_vsock/virtio_transport.c        |  4 ++--
> net/vmw_vsock/virtio_transport_common.c |  4 ++--
> net/vmw_vsock/vsock_loopback.c          |  2 +-
> 7 files changed, 17 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 88a310390eb0..3de1f1920717 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -229,7 +229,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		/* Deliver to monitoring devices all packets that we
> 		 * will transmit.
> 		 */
>-		virtio_transport_deliver_tap_pkt(skb);
>+		virtio_transport_deliver_tap_pkt(skb, vsock->net);
>
> 		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
> 		added = true;
>@@ -567,7 +567,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 		total_len += sizeof(*hdr) + skb->len;
>
> 		/* Deliver to monitoring devices all received packets */
>-		virtio_transport_deliver_tap_pkt(skb);
>+		virtio_transport_deliver_tap_pkt(skb, vsock->net);
>
> 		hdr = virtio_vsock_hdr(skb);
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057..46058d354940 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -285,7 +285,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>-void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
>+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb, struct net *net);
> int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index e8481f12312e..3e28865578eb 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -250,7 +250,8 @@ struct vsock_tap {
>
> int vsock_add_tap(struct vsock_tap *vt);
> int vsock_remove_tap(struct vsock_tap *vt);
>-void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
>+void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque,
>+		       struct net *net);
> int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 				int flags);
> int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>diff --git a/net/vmw_vsock/af_vsock_tap.c b/net/vmw_vsock/af_vsock_tap.c
>index 7c5cdceabb2a..4c8821835251 100644
>--- a/net/vmw_vsock/af_vsock_tap.c
>+++ b/net/vmw_vsock/af_vsock_tap.c
>@@ -73,19 +73,23 @@ static int __vsock_deliver_tap_skb(struct sk_buff *skb,
> 	return ret;
> }
>
>-static void __vsock_deliver_tap(struct sk_buff *skb)
>+static void __vsock_deliver_tap(struct sk_buff *skb, struct net *net)
> {
> 	int ret;
> 	struct vsock_tap *tmp;
>
> 	list_for_each_entry_rcu(tmp, &vsock_tap_all, list) {
>+		if (!vsock_net_check_mode(dev_net(tmp->dev), net))
>+			continue;
>+
> 		ret = __vsock_deliver_tap_skb(skb, tmp->dev);
> 		if (unlikely(ret))
> 			break;
> 	}
> }
>
>-void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque)
>+void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque,
>+		       struct net *net)
> {
> 	struct sk_buff *skb;
>
>@@ -96,7 +100,7 @@ void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque)
>
> 	skb = build_skb(opaque);
> 	if (skb) {
>-		__vsock_deliver_tap(skb);
>+		__vsock_deliver_tap(skb, net);
> 		consume_skb(skb);
> 	}
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index cf63bc99f3cc..b39c001260a9 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -150,7 +150,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
> 	if (ret < 0)
> 		return ret;
>
>-	virtio_transport_deliver_tap_pkt(skb);
>+	virtio_transport_deliver_tap_pkt(skb, NULL);
> 	return 0;
> }
>
>@@ -680,7 +680,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			if (payload_len)
> 				virtio_vsock_skb_put(skb, payload_len);
>
>-			virtio_transport_deliver_tap_pkt(skb);
>+			virtio_transport_deliver_tap_pkt(skb, NULL);
>
> 			/* Force virtio-transport into global mode since it
> 			 * does not yet support local-mode namespacing.
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1e762a480df4..027fe41c676a 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -190,12 +190,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	return skb;
> }
>
>-void virtio_transport_deliver_tap_pkt(struct sk_buff *skb)
>+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb, struct net *net)
> {
> 	if (virtio_vsock_skb_tap_delivered(skb))
> 		return;
>
>-	vsock_deliver_tap(virtio_transport_build_skb, skb);
>+	vsock_deliver_tap(virtio_transport_build_skb, skb, net);
> 	virtio_vsock_skb_set_tap_delivered(skb);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 8068d1b6e851..cacd313a454b 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -138,7 +138,7 @@ static void vsock_loopback_work(struct work_struct *work)
> 		 * It is freed by the receiver.
> 		 */
> 		virtio_transport_consume_skb_sent(skb, false);
>-		virtio_transport_deliver_tap_pkt(skb);
>+		virtio_transport_deliver_tap_pkt(skb, sock_net(skb->sk));
> 		virtio_transport_recv_pkt(&loopback_transport, skb,
> 					  sock_net(skb->sk));
> 	}
>
>---
>base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
>change-id: 20261116-vsock-tap-net-1b09a0945779
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>

