Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51F2F7F1B
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773594; cv=none; b=qjJeMROokpUalOSGUqOnmThajmtR2iPbPvGsyBHFDoTPFpJEczHxkYfSWbsFj6vE/SjKKfsrhwzxLdf57G6bpbKff/y/7bNWgKm7vgWEXMbhf8oOwqxIZuHZvD7xHI2K8eVUbzBBl/HWC/pfdvuAFU2Q/fMLtL+mrsNlbDNGGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773594; c=relaxed/simple;
	bh=tJv0/EBUpEKsRei7mQTEOg6F+oHmr7174OfGvOa8+ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IxXWyzwzyM/ouwgis6lk8ofzx9pMIMiO/nu2XG8yCtR8+yHTUJ2+xSlY1xzyqrlvlMl8P1aJyL6OHibJwKlvO4a/O7z7bWm1b9fKxJsTvkcSO0wkiFqjXlW/VChPmn2Rc9cxN7qMtSEfVrtu2F7PFnPgYGp5qCFNHkgnqX/kIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+5SVwR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+5SVwR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA21F00893;
	Sat,  6 Jun 2026 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780773593;
	bh=RCcuoTXIsJxZqoUgk6axS2g/SpBXs9aTRIQLAoMlFlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K+5SVwR+XbQCTL7khIQdvmSEMacnPxovUZ8Y0/QCCzZsob5QZ/OSkOWrOAYqjTfKv
	 K6ILwmf49TWOdbzNwsy6d3h/B8vgYbJSD98TJ/YP7v7gFm3BflpatxTfGYl9thg8g2
	 GZLCxlRGKoL7GIGctkNwv8j0seqT7ZfPuQrcK0ujyjtqetFOCdMDef/AYe2XczHTVg
	 i7jc/5faKNcMJfGuZsjHH+wuZM5t8ybPz+JGBvAuEDVI6v0LBWSDwy18pH/QmXxpE5
	 Oc0gQkpsuaAsqM8U/FEQ4drMon4mAVLPcCErCiQW3aL8WunJL1qUAyiuMdD0UZbpbn
	 C1W4OR8V8RI8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Divya Mankani" <divyakm@cs.unc.edu>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605191922.12720-1-divyakm@unc.edu>
References: <20260605191922.12720-1-divyakm@unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 19:19:52 +0000
Message-Id: <20260606191953.15DA21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Immediate deadlock due to recursive socket locking.
- [Critical] Lock state corruption due to double unlock of the listener soc=
ket.
- [Critical] Complete connectivity breakdown due to uninitialized transport=
 resource.
--

commit 66d0ddc596779066491dac2a5b409f48988831bc
Author: Divya Mankani <divyakm@cs.unc.edu>

vsock/virtio: fix memory leak in virtio_transport_recv_listen
   =20
This patch attempts to fix a memory leak inside virtio_transport_recv_listen
reported by syzbot. It does so by locking the parent socket and verifying i=
ts
shutdown state before calling vsock_enqueue_accept.

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D1b2c9c4a0f8708082678

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index b10666937c490..6cec430c3d8f6 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1571,15 +1571,20 @@ virtio_transport_recv_listen(struct sock *sk, str=
uct sk_buff *skb,
>  	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
>  			le32_to_cpu(hdr->src_port));
> =20
> -	ret =3D vsock_assign_transport(vchild, vsk);
> -	/* Transport assigned (looking at remote_addr) must be the same
> -	 * where we received the request.

[Severity: Critical]
Does removing the vsock_assign_transport() call leave the child socket's
transport uninitialized?

Without vsock_assign_transport(), the child socket's transport pointer
remains NULL. Later in virtio_transport_recv_listen(), we call
virtio_transport_send_response(), which relies on the transport operations.

Could this cause the response to fail and prevent incoming vsock
connections from being established?

> +	/* Lock the parent listener socket to synchronize with a potential
> +	 * simultaneous shutdown thread running __vsock_release().
>  	 */
> -	if (ret || vchild->transport !=3D &t->transport) {
> +	lock_sock(sk);

[Severity: Critical]
Is it safe to call lock_sock() here?

Looking at the caller virtio_transport_recv_pkt(), the socket lock for the
listener socket appears to be already acquired before it dispatches to
virtio_transport_recv_listen():

virtio_transport_recv_pkt()
    lock_sock(sk);
    ...
    switch (sk->sk_state) {
    case TCP_LISTEN:
        virtio_transport_recv_listen(sk, skb, t);

Since lock_sock() is not recursive, will acquiring it again in
virtio_transport_recv_listen() cause the thread to sleep indefinitely and
deadlock?

> +
> +	/* Check if the listener socket was shut down while we were
> +	 * creating and configuring the child socket.
> +	 */
> +	if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK) {
> +		release_sock(sk);

[Severity: Critical]
Will this lead to a double unlock of the listener socket?

Since the caller virtio_transport_recv_pkt() already acquired the lock, it
will also unconditionally call release_sock(sk) after the switch statement
completes.

If we release it here prematurely, could another thread acquire the lock
before the caller mistakenly releases it a second time, corrupting the
socket lock state?

>  		release_sock(child);
>  		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>  		sock_put(child);
> -		return ret;
> +		return -ESHUTDOWN;
>  	}
> =20
>  	sk_acceptq_added(sk);
> @@ -1590,6 +1595,8 @@ virtio_transport_recv_listen(struct sock *sk, struc=
t sk_buff *skb,
>  	vsock_enqueue_accept(sk, child);
>  	virtio_transport_send_response(vchild, skb);
> =20
> +	/* Safely release both locked objects */
> +	release_sock(sk);

[Severity: Critical]
Does this also introduce a double unlock regression?

Similar to the error path, releasing the socket lock here seems to conflict
with virtio_transport_recv_pkt() releasing the lock again when this function
returns.

>  	release_sock(child);
> =20
>  	sk->sk_data_ready(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605191922.1272=
0-1-divyakm@unc.edu?part=3D1
