Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BA38737B
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161077; cv=none; b=lbwfV7KiutTbllRWIGdLciCRT9SI1VNTs5NeZcxqXo/JeL9GYMnPGVF+XEd5GoIaGbpR038xp7KdJnZU07xN5rI9dI5CkqIF0C3vc4Iz5x4uaeX0tqfiJvU1I7Tr0fDr2PIRVrFTODyZHynZb4LgFOjMLkUno7d1n98Pg/0oBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161077; c=relaxed/simple;
	bh=K91HiQt1yEIn09CwVOcy8afHlysNdhjOqO+vmGR1S5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnB9O7ptODf8xDmSkA2NtjTkTii5ySRdlPuVjHPPpHuVHBIrw6n6urs5cxQjJaIKjd80M3LK4EjhbqECUPymlABlhZ2g66C57BBElgmgOIApXA34Ch1hY9WQB3HGar3DqLn/tcQF7yC8B3NVETaXw5+Koh7k+G85YYvv71kTylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km57NTZD; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km57NTZD"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-702dedeb70dso3471eaf.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161074; x=1792765874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLwSzLny46jupzvFLvBEk+T6b2l6mUuh85ElZv2WpbQ=;
        b=km57NTZDJvheHfYTaI00mQwHBe/895HSk2QcGO2iYyaiYM1pbiPgXNTnTVypsdr/LN
         0r5THtoPaU/6++F0NQX+cBLit0WQAmdrT0rzfmeiij5usKNwwrPH4BatXheNKa0Z/WM8
         fEMh7gqnjFD0EMm7Y5kIFAAp8isJKsGgkUx1A78zVF8Tjf5fOpiB27fjPKUOdh0lANxD
         p8hwbSTMY0z41Ti6mvXl6rywMV5Rd7uah80PEWGrJxCuygIu85kQcKe/I4KNNm+occRp
         r1iiCiTsd+00iLB6SrgMadXESwMb/F+YEpjG1R515m7QGKKSDxtAv57KbynV+7u1/Jzh
         hwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161074; x=1792765874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLwSzLny46jupzvFLvBEk+T6b2l6mUuh85ElZv2WpbQ=;
        b=EwcsSo1T0mj3e8msu8JhW5xcOv358/rBLiqBS0MsiWeKVY8j/d5zAdsyuDGYJM47IV
         ShY++djyUO8Vdq4CUU/qWq4Z8QGOrxsHoReXK04ndHkFjo7zVHTj9RZ57ZrDzxFncCwZ
         tk5QWY6gGjhZGvzqFw21Ol0WF2Jt5n9v2tFy+31vELIhGWQ3rrLntY0wV6jsirCZuqQU
         ITRAQpEFtxEWD1RfWTRd5+L+T8484rOMtThwaaA+UldbDD5jkDXh8Uv82nBMD6PdGQ6d
         Ug2ybE6seoYxIGczWZH64Ube928OloIAMDyQ1t3iHUyQuamnJwyd36CN/wTsNx53Mfye
         rS6g==
X-Forwarded-Encrypted: i=1; AKwUvBxvavsNjUYv+DtjLBlNTS95WDzxnCJsgmDdggxR0rSTyOhrJzzgnkLNgBEwSOsf2yLVU8o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBykyRcTjA8cHejKJUhxPHQQhFBaz2kxbJ8cLl1cNzQ2FzEX6D
	WKAz2Pq6gowpqarcOqACtjcvZkvkqLBUG0MBQ1D0OibKyY7ophyw7hMD
X-Gm-Gg: AYBFou3oh0Y7d52+/UI8ysZSOednX42U2ncC2W+0ywhq9cr37vYSenZ/kIN3YElGymZ
	5QY/WYkpIZO4Z9AV0kCPusD2QN4mLL9epXwVdB0N5Wprl9h6G0D/kEJSn8Ehj6brbxxovNbRPrh
	D2QHKS4uIa3t3RFn9vMBJc8y1PB6ZlKXBdFrEjvF+zj2yy9BN+WngqKBxiIJTT4QuukbtK0ZSy3
	cNh8LXCIl/2l4pHuoWVu8djZALQwQTA2MvVFCNPyp8H+lVxH1/D5LvJO5nBo+WXGWsDyGPRmVVi
	/fNTuHFNAEsbU/iR+Juv11Zfhi/xUrFDxDPBkCQV3iaBRtmeDc0ca9FXK2w2Vv59qN465URjKYz
	bn6lRgOYyZkD9ZHTEQNM5ZMLTSCegG3zRfgBS54QUvBSNZ6b25KDaMorf0AUWyL3NZN1W1XAoYD
	9GBuHgRV80S+sOGlouhm+ZqUDyi/P1aoaSlM/PyD6zgkwPOx6evFwDRdCPOAAYEGFUu4k=
X-Received: by 2002:a05:6820:1c86:b0:6f7:384:a09a with SMTP id 006d021491bc7-6f70384ab38mr11546790eaf.24.1792161073822;
        Fri, 16 Oct 2026 07:31:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b763339sm1824054fac.15.2026.10.16.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:31:12 -0700 (PDT)
Date: Fri, 16 Oct 2026 07:31:10 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jia Jia <physicalmtea@gmail.com>, stefanha@redhat.com, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <atI1LidDfxztx7sj@devvm29614.prn0.facebook.com>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-2-physicalmtea@gmail.com>
 <atImp74JbTbEb0d_@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atImp74JbTbEb0d_@sgarzare-redhat>

On Fri, Oct 16, 2026 at 03:47:33PM +0200, Stefano Garzarella wrote:
> On Wed, Oct 14, 2026 at 07:56:37PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from
> > receive state machine processing under the socket lock. This prepares the
> > receive path to keep a looked-up socket across multiple packets in a later
> > change.
> > 
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > The locked helper obtains packet-specific addresses from the skb and uses
> > the matched socket namespace for reset replies. Preserve source validation
> > and failure handling.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > net/vmw_vsock/virtio_transport_common.c | 128 ++++++++++++++----------
> > 1 file changed, 75 insertions(+), 53 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index f225f53ed4bab..61ee3bc205d5d 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1774,81 +1774,60 @@ static bool virtio_transport_valid_type(u16 type)
> > 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> > }
> > 
> > -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > - * lock.
> > - */
> > -void virtio_transport_recv_pkt(struct virtio_transport *t,
> > -			       struct sk_buff *skb, struct net *net)
> > +static struct sock *
> > +virtio_transport_find_socket(struct sk_buff *skb, struct sockaddr_vm *src,
> > +			     struct sockaddr_vm *dst, struct net *net)
> > {
> > 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > -	struct sockaddr_vm src, dst;
> > -	struct vsock_sock *vsk;
> > 	struct sock *sk;
> > -	bool space_available;
> > -
> > -	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > -			le32_to_cpu(hdr->src_port));
> > -	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > -			le32_to_cpu(hdr->dst_port));
> > -
> > -	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > -					dst.svm_cid, dst.svm_port,
> > -					le32_to_cpu(hdr->len),
> > -					le16_to_cpu(hdr->type),
> > -					le16_to_cpu(hdr->op),
> > -					le32_to_cpu(hdr->flags),
> > -					le32_to_cpu(hdr->buf_alloc),
> > -					le32_to_cpu(hdr->fwd_cnt));
> > 
> > -	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > -		goto free_pkt;
> > -	}
> > +	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> > +		return NULL;
> > 
> > -	/* The socket must be in connected or bound table
> > -	 * otherwise send reset back
> > -	 */
> > -	sk = vsock_find_connected_socket_net(&src, &dst, net);
> > -	if (!sk) {
> > -		sk = vsock_find_bound_socket_net(&dst, net);
> > -		if (!sk) {
> > -			(void)virtio_transport_reset_no_sock(t, skb, net);
> > -			goto free_pkt;
> > -		}
> > -	}
> > +	sk = vsock_find_connected_socket_net(src, dst, net);
> > +	if (!sk)
> > +		sk = vsock_find_bound_socket_net(dst, net);
> > +	if (!sk)
> > +		return NULL;
> > 
> > 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > 		sock_put(sk);
> > -		goto free_pkt;
> > +		return NULL;
> > 	}
> > 
> > -	if (!skb_set_owner_sk_safe(skb, sk)) {
> > -		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -		goto free_pkt;
> > -	}
> > +	return sk;
> > +}
> > 
> > -	vsk = vsock_sk(sk);
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns true.
> 
> Why the skb must be freed by the caller and not by this function itself?
> 
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +				 struct sk_buff *skb, struct sock *sk)
> > +{
> > +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct sockaddr_vm src;
> > +	struct vsock_sock *vsk = vsock_sk(sk);
> > +	bool space_available;
> 
> Please, follow the netdev convection for ordering local variables: https://www.kernel.org/doc/html/v7.2/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
> > 
> > -	lock_sock(sk);
> > +	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +			le32_to_cpu(hdr->src_port));
> > 
> > -	/* Check if sk has been closed or assigned to another transport before
> > -	 * lock_sock (note: listener sockets are not assigned to any transport)
> > +	/* Listener sockets accept packets from any source and are not assigned to
> > +	 * a transport.
> > 	 */
> 
> Why changing this comment in this commit?
> 
> Oh because we moved out lock_sock, right?
> 
> I think we should keep in some way the old info that was much more
> informative that the current comment that just say what the check is doing
> and not why.
> 
> > 	if (sock_flag(sk, SOCK_DONE) ||
> > 	    (sk->sk_state != TCP_LISTEN &&
> > 	     !vsock_check_source(vsk, &t->transport, &src))) {
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > -		release_sock(sk);
> > -		sock_put(sk);
> > -		goto free_pkt;
> > +		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> 
> We need to be careful here, IIRC Bobby used the net from the caller for a
> reason.
> 
> Are you sure it's fine this change? Why not passing net as parameter and
> minimize changes?

I think you may be remembering this issue:

a6ae12a599e0 ("virtio: set skb owner of virtio_transport_reset_no_sock() reply")

?

If so, sock_net(sk) might still be okay, but I 100% agree we shouldn't
change things haphazardly if avoidable.

> 
> > +		return true;
> > 	}
> > 
> > 	space_available = virtio_transport_space_update(sk, skb);
> > 
> > 	/* Update CID in case it has changed after a transport reset event */
> > 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > -		vsk->local_addr.svm_cid = dst.svm_cid;
> > +		vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
> > 
> > 	if (space_available)
> > 		sk->sk_write_space(sk);
> > @@ -1870,17 +1849,60 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > 		kfree_skb(skb);
> > 		break;
> > 	default:
> > -		(void)virtio_transport_reset_no_sock(t, skb, net);
> > +		(void)virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> > 		kfree_skb(skb);
> > 		break;
> > 	}
> > 
> > +	return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +			       struct sk_buff *skb, struct net *net)
> > +{
> > +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> > +	struct sockaddr_vm src, dst;
> > +	struct sock *sk;
> > +	bool free_pkt;
> > +
> > +	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> > +			le32_to_cpu(hdr->src_port));
> > +	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> > +			le32_to_cpu(hdr->dst_port));
> > +
> > +	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> > +					dst.svm_cid, dst.svm_port,
> > +					le32_to_cpu(hdr->len),
> > +					le16_to_cpu(hdr->type),
> > +					le16_to_cpu(hdr->op),
> > +					le32_to_cpu(hdr->flags),
> > +					le32_to_cpu(hdr->buf_alloc),
> > +					le32_to_cpu(hdr->fwd_cnt));
> > +
> > +	sk = virtio_transport_find_socket(skb, &src, &dst, net);
> > +	if (!sk) {
> > +		(void)virtio_transport_reset_no_sock(t, skb, net);
> > +		goto free_pkt;
> > +	}
> > +
> > +	if (!skb_set_owner_sk_safe(skb, sk)) {
> > +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +		goto free_pkt;
> > +	}
> > +
> > +	lock_sock(sk);
> > +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk);
> > 	release_sock(sk);
> > 
> > 	/* Release refcnt obtained when we fetched this socket out of the
> > 	 * bound or connected list.
> > 	 */
> > 	sock_put(sk);
> > +	if (free_pkt)
> > +		kfree_skb(skb);
> > 	return;
> > 
> > free_pkt:
> > -- 
> > 2.53.0
> > 
> 
