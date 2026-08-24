Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375D380FE0
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594397; cv=none; b=l/RDt6MC8NcTxwEazkqJlx/59PQUNHAOhnFrDQKJyHQ9LlZ+DXcwlyjAU5FNFtXHJeFXLjhFxKkZ4bI7Z7ycI/r7YQ6tB4A9/GtBQDNrjmMat2cWyZZKqk6QlQqMP7qX0ikeEGMx7Xyo7xMkfdHKdYECyi0P8AT7ubGQFGNUA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594397; c=relaxed/simple;
	bh=az7nKeca0hh/sZDC8X+SYyLtvoGPv1ga7Jxl5xKMUxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hgJ0au6WBnNf4VKRRi4xmOGvGsaJqEK5y59Dl0GJWTMompGlrD6OoLEMKEDrxubY3W1EEbNGLj4IdHWgqNXamDv1DCxYdPwCF8h8yxnx7XURCKKFFBTua/Dl4NHhn6lY/jNOe6DUlgkaOZDvNXDsxbm6iBoF48DIY7lnRzYIV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbnIkvof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbnIkvof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9601F000E9;
	Mon, 24 Aug 2026 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787594395;
	bh=GOlA9rZ3zbn2lSVTXRBrQPmnUYPKUcndoYwniPBKXGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbnIkvof9gWgZH0GWxBdWGS/UBDVx2eMxUaQSYvJuPb/vQyDmGqJeg1gDiLEwIcYM
	 0OGkqJUTcDKiJx9XjjEb+7UaJeUB+sO/xN12KPUZcUeij3UyCNeGANoIJOXwnbx/7r
	 LsHmWOqHnXSVegk+93b0Qo4T5Ptq7zLMuVhQA76RebbBcw1EAcj5D9fX+roB5VOyrV
	 6FO0WXcrvoaW+6/KEU6LR+iOnHuNVtrGcOZpvlr6i80OzsUfSBWLUQ+oDs3n324R50
	 DI0ATqK4yGnoGIk4H9h8u+8E1HAvon/jf5HHTftzMekXJe0NrHPIoHpZFGbfQuEudK
	 894tdgvfQU87g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] vsock/vmci: validate packet source for
 connected sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260823175858.351431-3-4ncienth@gmail.com>
References: <20260823175858.351431-1-4ncienth@gmail.com>
 <20260823175858.351431-3-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:59:55 +0000
Message-Id: <20260824175955.AD9601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Legitimate connection requests to bound but non-listening sockets =
(TCP_CLOSE) or concurrently closing sockets are silently dropped instead of=
 generating a connection reset (RST), causing clients to hang until timeout.

Pre-existing issues:
- [High] Dynamically allocated `recv_pkt_info` work items are queued to the=
 global `system_wq` but are not flushed or canceled when the module is unlo=
aded, leading to a kernel panic.
--

--- Patch [2]: [PATCH net v3 2/2] vsock/vmci: validate packet source for co=
nnected sockets ---
commit 0c47d3fbd6e3da162ec0e88ab935d6073c395e19
Author: Daehyeon Ko <4ncienth@gmail.com>
vsock/vmci: validate packet source for connected sockets

This commit adds source validation for connected sockets in the VMCI
transport to prevent packets from unverified sources from being processed.
It updates both the bottom-half fast path and the workqueue path to verify
the packet's source.

Link: https://lore.kernel.org/netdev/20260814121255.6B5001F000E9@smtp.kerne=
l.org/

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 1c4ee039c1662..b612a9893856a 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c

[ ... ]

> @@ -765,17 +767,26 @@ static int vmci_transport_recv_stream_cb(void *data=
, struct vmci_datagram *dg)
>  	bh_lock_sock(sk);
> =20
>  	if (!sock_owned_by_user(sk)) {
> -		/* The local context ID may be out of date, update it. */
> -		vsk->local_addr.svm_cid =3D dst.svm_cid;
> +		if (sk->sk_state !=3D TCP_LISTEN &&
> +		    !vsock_check_source(vsk, &vmci_transport, &src)) {
> +			drop_pkt =3D true;
> +			err =3D VMCI_ERROR_NO_ACCESS;
> +		} else {

[Severity: High]
Does this code silently drop connection requests to bound but non-listening
sockets (TCP_CLOSE)?

If a client attempts to connect to a bound port that isn't listening yet,
the socket is found in the TCP_CLOSE state. Since the state is not TCP_LIST=
EN,
it calls vsock_check_source(), which checks against the socket's remote_add=
r.
Because the socket is not connected, the port is 0 and won't match the
client's ephemeral source port, causing vsock_check_source() to return fals=
e.

By setting drop_pkt =3D true, the packet is completely dropped. Could this
prevent the client from receiving the expected connection reset (RST), caus=
ing
them to hang indefinitely instead of seeing ECONNREFUSED?

> +			/* The local context ID may be out of date, update it. */
> +			vsk->local_addr.svm_cid =3D dst.svm_cid;
> =20
> -		if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> -			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
> -					sk, pkt, true, &dst, &src,
> -					&bh_process_pkt);
> +			if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> +				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
> +									       &dst, &src,
> +									       &bh_process_pkt);
> +		}
>  	}
> =20
>  	bh_unlock_sock(sk);
> =20
> +	if (drop_pkt)
> +		goto out;
> +
>  	if (!bh_process_pkt) {
>  		struct vmci_transport_recv_pkt_info *recv_pkt_info;

[Severity: High]
This is a pre-existing issue, but does queuing these work items to the glob=
al
system_wq create a use-after-free risk during module unload?

Looking at vmci_transport_recv_stream_cb(), it dynamically allocates a work
item and schedules it:

	INIT_WORK(&recv_pkt_info->work, vmci_transport_recv_pkt_work);
	schedule_work(&recv_pkt_info->work);

However, vmci_transport_exit() cancels a specific cleanup work item but does
not flush system_wq or track these pending recv_pkt_info items before
unloading.

If packets arrive for a port bound by a listening socket of a different
transport (e.g., virtio_transport), this code bypasses vsock_check_source()=
 and
schedules the work. Since the target socket belongs to a different transpor=
t,
the vmci_transport module reference count can remain at zero.

If the module is unloaded while this work is still pending, could the kernel
worker thread attempt to execute the unmapped vmci_transport_recv_pkt_work
function and panic?

[ ... ]

> @@ -900,6 +911,7 @@ static void vmci_transport_recv_pkt_work(struct work_=
struct *work)
>  {
>  	struct vmci_transport_recv_pkt_info *recv_pkt_info;
>  	struct vmci_transport_packet *pkt;
> +	struct sockaddr_vm src;
>  	struct sock *sk;
> =20
>  	recv_pkt_info =3D
> @@ -908,6 +920,10 @@ static void vmci_transport_recv_pkt_work(struct work=
_struct *work)
>  	pkt =3D &recv_pkt_info->pkt;
> =20
>  	lock_sock(sk);
> +	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
> +	if (sk->sk_state !=3D TCP_LISTEN &&
> +	    !vsock_check_source(vsock_sk(sk), &vmci_transport, &src))
> +		goto out;

[Severity: High]
Similarly, does this early exit bypass the logic meant to send connection
resets for closed sockets?

The default case in the switch statement below this code was specifically
designed to send a reset:

	switch (sk->sk_state) {
        ...
	default:
		/* Because this function does not run in the same context as
		 * vmci_transport_recv_stream_cb it is possible that the
		 * socket has closed. We need to let the other side know or it
		 * could be sitting in a connect and hang forever. Send a
		 * reset to prevent that.
		 */
		vmci_transport_send_reset(sk, pkt);
		break;
	}

Will jumping to the out label bypass this reset logic when a socket closes
concurrently?

> =20
>  	/* The local context ID may be out of date. */
>  	vsock_sk(sk)->local_addr.svm_cid =3D pkt->dg.dst.context;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823175858.3514=
31-1-4ncienth@gmail.com?part=3D2
