Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8E4BC01A
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496096; cv=none; b=kJB8Ajc8lJEa1DGB1G4UNk0Yoj/xyxNl6Q/xmb73PRCGgHinBlAmwWiK3mFZPozDsASb4YFjCrx2kO13zOPnjliIT/rxVDkocX1JQwyXZX9veoZXJhudhKq3XYry6OcrlrhVZVn56ripW/dXcMj0ECgvfkvu/21tL8SCQgFd38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496096; c=relaxed/simple;
	bh=Zqxttmoi5XngJammIPSIG6qDpq3OZ3kZrZhzLN5W27E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgGM8cD7OeHZ7d+U3Ftj2yFxI2PDKQpE7s8AKYT+kDMC4oRqM95KW+uPB5WjNOJdpOqEZKVXq/FrqxWbPxmmah91jYqzEnsrKjRzEl2l/EGWMWPRPZGrY63EpdaTr8+eVDlUqjT/fN76uZGsVbZAlBzqi/W3lpBfNMu90MapK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abmd9RTM; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abmd9RTM"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae736c63so96008eaf.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496092; x=1790100892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F+aeTxhSeWnPEIt7QVJiINGNEEjF9/lqEswuPk0DNjA=;
        b=abmd9RTMWEHC4D1pnO27SnbXu1y/pm4qIDT0WA0sc99tY2QaXG3uYveQKYQ61uvPgK
         F9y2zn7s+lKxQH6hF9aKGxtKyNRg1gfLk+mbjLmZCn4ttFjd4jmttZwT3Khhy4434JhE
         b4ZlrsD05U9pLCuImu77A+Pjal2TCcMj5R84x/B/l8X24WtfKYx4gc0pTEtevr2t6edH
         jtqPIQpLKL1fM879/+tjEuyv/sPqH21ULXSgklwKlnA5Qgh/EfThqOit6TivJwrBzMl3
         z/ECNn9yCvcin6dxkq2dakQDKDnBdPvfGT0E9HaDO2ylfQKEGIRwrU6NTgKIOT5vp0ru
         4K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496092; x=1790100892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+aeTxhSeWnPEIt7QVJiINGNEEjF9/lqEswuPk0DNjA=;
        b=av3w3IWpD22Hv/MjeY2lu0wZk96BVebd2+k2PLU1smggUtSNpSqZ+EwU/XHBL7c7/9
         4xMmVmgR32B6CfGGW2z7FEVfwVoZT4aQPGIa291ImeOeiGDo/qcVtAyzuMKWBNAUgJbN
         vTbBRogMmkMWWnrjE3bTBjLc31ZAhaBdGUJYM72fY//mkXGvbx1zRpgxIPoNTYTtFsgB
         k5SvPeyoxCEHRy3bV1WxRwWmUy1HGZORik523XUChV8pZ8OXZXHS+6sPzyQl8gsk/cFy
         ezinRJkmOMzIXVh2KEbRBqI5VNAt+SQLJ3+P+vVrkb/tzkmkBWtc2bJN2isvo40PLbCU
         IIGQ==
X-Forwarded-Encrypted: i=1; AKwUvByKBl8A9n9RAfeJ9nvZOqr02byCvfH5HVz/379GkUMrZOGCdEYPVPa/n4A6wDHNQlNowNI=@vger.kernel.org
X-Gm-Message-State: AFuF++nCeFghv/2XVGM4skoPGt3ce+0g/8a8uRG6OfQstIVXYahDtg0R
	V3+zUuXPlREww2483ETdlE5C2OQIHV+2ehL5ldoAb8m5hVLbKd1O0GN9
X-Gm-Gg: AYBFou0qih4vzrlZjh6FCj5yGm/Tu44244nkr1hJrta6xXwBrXMzufK19SDtaBp+e6b
	kf3Gn2m4i4pP/oOeGR/fKamzpJuca/rRB28V0urDh9vVhGgCIBillbutqHKZUyKPPH+KRUZYqCN
	iC8nWEgTa/KWb+mXMMj8+rIoLa3gHfKevRKebeD2ij9oB6NNf5dkGHn5l/wpUZ8sh9IB0zKIGvC
	nUQxegprvht6hj2SI2TPNAWvT/JKDhKCUntjdlGwsDs7TcAKfq2zDKR0RYNHXPegubgWj2d7wdn
	IPUr54bIaoJjFMZokCq4PgVCqlhrNKGJVdDV6I6W/TFmQ5jH2X8lc4flGu3L1P/MYYnPUJbz9sT
	mS+d+5uT1aXUVWYdDzsdf+2e2/WiN6kFFWefIiUDo4gga6XjlWdWzpbdy23BGSSdKfJfHtK3T5j
	v0xYx+I3VI9Ojr/7twufDAeP50x4akiV3RttdXKJf++B2uFGzuzasWXeytjv4pIs52qqqzFHI//
	r75DayrgH+zzKaaFBghSU85/SPtpMo=
X-Received: by 2002:a05:6820:1c94:b0:6b7:8415:d780 with SMTP id 006d021491bc7-6c738db60e1mr1840407eaf.43.1789496091809;
        Tue, 15 Sep 2026 11:14:51 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b049fb51asm115974a34.1.2026.09.15.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:14:51 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:14:47 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sargun@sargun.me, jlinbox@meta.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 3/6] vsock/virtio: support guest device network
 namespace
Message-ID: <aqmLFzcF3MmwRITz@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-3-9995383e9a8b@meta.com>
 <aqlkWGyoUYrgQUzz@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqlkWGyoUYrgQUzz@sgarzare-redhat>

On Tue, Sep 15, 2026 at 05:47:02PM +0200, Stefano Garzarella wrote:
> On Wed, Sep 02, 2026 at 04:00:49PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > virtio-vsock did not have namespace support (the device was always
> > accessible to any global namespace).
> > 
> > Make the virtio-vsock device assignable to a namespace and initialize it
> > to init_net. Because virtio-vsock and init_net are both hardcoded to
> > global mode, nothing changes until the assign ioctl is issued.
> > 
> > When the device's local-mode namespace is being destroyed, received
> > packets are reset until new valid a namespace has been assigned and/or
> > automatically returned to, and the next RX batch begins (in
> > virtio_transport_rx_work). They are reset rather than dropped because
> > vsock does not retransmit, so a silent drop would leave the host waiting
> > for a timeout, and a connection request arriving in that window has no
> > socket whose teardown would tell it otherwise. This requires making
> > virtio_transport_reset_no_sock() available outside of the common code.
> > 
> > When a device is assigned to a namespace, every already established
> > vsock socket that is no longer able to reach the device is forcibly
> > reset. For that reason, adding new sockets to the connected table must
> > be performed atomically with regards to namespace assignment. This
> > ensures that when the socket is added to the connected table that it
> > actually passes the new reachability conditions set by ns assignment. If
> > it wins the race to the table and does NOT pass the reachability tests,
> > then the reset sweep will correctly catch it. This is the purpose
> > of the new helper 'vsock_maybe_set_connected()'.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > include/linux/virtio_vsock.h            |  2 ++
> > net/vmw_vsock/virtio_transport.c        | 28 ++++++++++++++++++++++------
> > net/vmw_vsock/virtio_transport_common.c | 28 +++++++++++++++++++++-------
> > 3 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..9c68ce1d7fb4 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -286,6 +286,8 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> > void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> > void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
> > +int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > +				   struct sk_buff *skb, struct net *net);
> > int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
> > int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
> > int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 4f9aa9c4c3aa..a453a4f828dc 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -540,9 +540,14 @@ static bool virtio_transport_msgzerocopy_allow(void)
> > 	return true;
> > }
> > 
> > +static bool virtio_transport_netns_assign_allow(void)
> > +{
> > +	return true;
> > +}
> > +
> > bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
> > {
> > -	return vsock_net_mode_global(vsk);
> > +	return vsock_g2h_net_reachable(sock_net(sk_vsock(vsk)));
> > }
> > 
> > static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
> > @@ -587,6 +592,7 @@ static struct virtio_transport virtio_transport = {
> > 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
> > 
> > 		.msgzerocopy_allow        = virtio_transport_msgzerocopy_allow,
> > +		.netns_assign_allow       = virtio_transport_netns_assign_allow,
> > 
> > 		.notify_poll_in           = virtio_transport_notify_poll_in,
> > 		.notify_poll_out          = virtio_transport_notify_poll_out,
> > @@ -616,7 +622,7 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> > 	struct virtio_vsock *vsock;
> > 	bool seqpacket_allow;
> > 
> > -	if (!vsock_net_mode_global(vsk))
> > +	if (!vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))))
> > 		return false;
> > 
> > 	seqpacket_allow = false;
> > @@ -634,6 +640,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > 	struct virtio_vsock *vsock =
> > 		container_of(work, struct virtio_vsock, rx_work);
> > 	struct virtqueue *vq;
> > +	struct net *net;
> > +
> > +	net = vsock_g2h_net_get();
> > 
> > 	mutex_lock(&vsock->rx_lock);
> > 
> > @@ -682,10 +691,14 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > 
> > 			virtio_transport_deliver_tap_pkt(skb);
> > 
> > -			/* Force virtio-transport into global mode since it
> > -			 * does not yet support local-mode namespacing.
> > -			 */
> > -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> > +			if (unlikely(!net)) {
> > +				virtio_transport_reset_no_sock(
> > +					&virtio_transport, skb, &init_net);
> 
> Why init_net?

This parameter is actually unused by virtio_transport_reset_no_sock(),
its call to virtio_transport_send_pkt(), and even the eventual call to
virtio_transport_deliver_tap_pkt()... so maybe NULL w/ a comment would
be better?

> 
> > +				kfree_skb(skb);
> > +				continue;
> > +			}
> > +
> > +			virtio_transport_recv_pkt(&virtio_transport, skb, net);
> > 		}
> > 	} while (!virtqueue_enable_cb(vq));
> > 
> > @@ -694,6 +707,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> > 		virtio_vsock_rx_fill(vsock);
> > out_nofill:
> > 	mutex_unlock(&vsock->rx_lock);
> > +
> > +	if (net)
> > +		put_net(net);
> 
> put_net() should handle NULL net, right?

It does, and somehow I forgot that.

Thanks,
Bobby
