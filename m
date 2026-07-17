Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A643F0A9
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306767; cv=none; b=X0fN6jmcaSL2j1C6nS8NiGmUv8HtjsYiAWK0T4UuA+Tn2rfA1VrRpFcr2Yyuo6l9vJNVIsh9TPyjXDMAIkNyVgIKuWXE4mc4ntPVOjar/Jokdz0ZwwHGE+JNKpT1vAVIWJqtgWoAAI44naWjNMmaKikUz53cTkf3oWu3c1Huk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306767; c=relaxed/simple;
	bh=nviwvVLUwfTAa1t0mN3Eb0+fM/GyZ0mwhfHpc6hHwxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9K+RZ7KAgzgitpWKXOkdwqrfm4Qzpu+kDNkD1vnFZdx7OKO5jJxxHYT4SyNqD2LeqtI9BHlbRRNoBdQpp0y/fWqLc+jHhbixsjBgocVUMFn86UcF88HubUAwONCbvaGo4lg8tNV5mok9leSZiavNM9ZmR3J2Z450TSWC+n1NEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAi2tSL2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAi2tSL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F2B1F00A3A;
	Fri, 17 Jul 2026 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306766;
	bh=BVnwEgfUNr5qM2RQQfmP+GbSkxrpVcW6gxmmU0eaw5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAi2tSL2tLcIwZ8kJnFs1LyZJH/NauV/YsByu3LyJ7IUMyURn/jOOOdfwRDqvrkKg
	 hTiXvBtT+mZuLbPcKw1uWi+oe1m1rdGN9qNKBWNmR39Hz+BIQtCi4dA8NDLoM/rZ3p
	 VztZZv7f50FQjyNac+XR5E5EfzQjI1TTWDWjeLWAIEUFKUuz41tjXXdNaPVj4QucLp
	 /kp17rFIqo2hJuiTGtS/h4ICFf0Ag+kr6FVqZrGuz9u/9MwQshVaQCjPG0GMMlvLT9
	 vnec/S4pYuiZEHhR7mWMeHWYriAgHpV3MFaXccMF4TYUdyyaS35f7Qth1NlYejHVEw
	 XoxIzV09ZN9yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12] vsock/virtio: fix zerocopy completion for
 multi-skb sends
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Martyniuk" <alexevgmart@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716163600.115458-1-alexevgmart@gmail.com>
References: <20260716163600.115458-1-alexevgmart@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:05 +0000
Message-Id: <20260717164606.15F2B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Failure during zerocopy skb allocation advances the user's `io=
v_iter` without reverting it, causing subsequent loop iterations to skip by=
tes and silently corrupt the message stream.
- [High] MSG_ZEROCOPY violates its API contract by generating multiple comp=
letion IDs for a single sendmsg() syscall when the message is fragmented by=
 the socket's wait loop, which can cause Use-After-Free in userspace.
--

--- Patch [1]: [PATCH 6.12] vsock/virtio: fix zerocopy completion for multi=
-skb sends ---
commit 60570416b19b3acf053340573a6882df58212cc4
Author: Stefano Garzarella <sgarzare@redhat.com>

vsock/virtio: fix zerocopy completion for multi-skb sends

This commit fixes an issue where non-final skbs in a fragmented message do
not carry zerocopy completion tracking. It resolves this by pre-allocating
the zerocopy uarg before the send loop and attaching it to every skb via
skb_zcopy_set. Notification only fires after the last skb is freed.

Link: https://patch.msgid.link/20260514092948.268720-1-sgarzare@redhat.com

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 9acc13ab3f822..62d753e3df358 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -372,6 +345,25 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>  		if (can_zcopy)
>  			max_skb_len =3D min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> +
> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> +		    info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> +			uarg =3D info->msg->msg_ubuf;
> +
> +			if (!uarg) {
> +				uarg =3D msg_zerocopy_realloc(sk_vsock(vsk),
> +							    pkt_len, NULL);

[Severity: High]
This is a pre-existing issue, but does MSG_ZEROCOPY generate multiple=20
completion IDs for a single sendmsg() syscall here?=20

If the peer lacks sufficient credit, stream_enqueue() in af_vsock.c can
return a short write, causing vsock_connectible_sendmsg() to loop and wait.=
=20
In the next iteration, info->msg->msg_ubuf remains NULL because it was=20
never updated with the previously allocated uarg.

When virtio_transport_send_pkt_info() is called again, does it allocate a=20
new uarg with msg_zerocopy_realloc(..., NULL) and increment the socket's=20
sk_zckey? This would return multiple completion IDs for one syscall, which=
=20
might cause userspace to desynchronize its tracking and prematurely free=20
buffers.

> +				if (!uarg) {
> +					virtio_transport_put_credit(vvs, pkt_len);
> +					return -ENOMEM;
> +				}
> +
> +				if (!can_zcopy)
> +					uarg_to_msgzc(uarg)->zerocopy =3D 0;
> +
> +				have_uref =3D true;
> +			}
> +		}
>  	}
> =20
>  	rest_len =3D pkt_len;
> @@ -390,21 +382,7 @@ static int virtio_transport_send_pkt_info(struct vso=
ck_sock *vsk,
>  			break;
>  		}

[Severity: Critical]
This isn't a bug introduced by this patch, but what happens to the user's
iov_iter if virtio_transport_alloc_skb() (called just above this snippet)
fails and the loop breaks?

If virtio_transport_alloc_skb() fails because __zerocopy_sg_from_iter()=20
hits an error after successfully pinning some pages, the iter has already=20
been advanced. Since rest_len !=3D pkt_len, virtio_transport_send_pkt_info()
returns the partial byte count without reverting msg_iter.

Will the next iteration of vsock_connectible_sendmsg() read from the=20
advanced iter, permanently skipping the user bytes that were pinned in the
failed skb and silently corrupting the stream?

> -		/* We process buffer part by part, allocating skb on
> -		 * each iteration. If this is last skb for this buffer
> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> -		 * completion for the current syscall.
> -		 */
> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    skb_len =3D=3D rest_len && info->op =3D=3D VIRTIO_VSOCK_OP_RW) {
> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> -							    info->msg,
> -							    can_zcopy)) {
> -				kfree_skb(skb);
> -				ret =3D -ENOMEM;
> -				break;
> -			}
> -		}
> +		skb_zcopy_set(skb, uarg, NULL);
> =20
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716163600.1154=
58-1-alexevgmart@gmail.com?part=3D1
