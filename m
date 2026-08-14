Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0A189F43
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709577; cv=none; b=NeoIToXhPWIMTQyuMsbt6thQAlni/27WAfGyLQDYqB7j1ggbO694er35VeI4mXQC4+wbEyTyVMAcvrwpxgeUmIuwUT9QDuq5cUEUUPLGheZTleyW6bezU/0vxa4KWXnWr5q0UeIO7o2La4i/hUjUpo8ZSeFbIPmEKSCiaMLkxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709577; c=relaxed/simple;
	bh=64hEM0DqwyWdEHfKmqqXujQ+lKnoH8xWkRceI9BBGyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KynWKkqZhQkWLRLcEigvjtPvbSXqfw/Gan6337RLC6REowiXgFQmp1yzncg/4ciqmgTE2AHX+kpFyE6zOQOy9sWvqoeBqF2wzhvWp4gUSyzmh6T6aOV7iHPiNwfu2irATNyGN1fpE2/Cog8h/qn8/VFxnbkh0HHtSSFEJHGcPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY42rzaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY42rzaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5001F000E9;
	Fri, 14 Aug 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786709575;
	bh=vFEhjZD1jqpheHrh9uFVZmhczAXpWkS9L2GUxr5HzWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XY42rzaYA6rwdLq73LcZlZm+i2796QaOFDpAOxF7ZxddcmkEjfV0AfuEv877vrxAp
	 lb+MvRtKH8QBQgJHWJ7aMavDQPDFtuq0DDwQLMymxsseorN5n2jWcy5XVc31iQlYHN
	 IKKLc51Vt3kly8/4gTFNpDYuAA5lNXDYJt9zFgII9jGghdl98EI9/gP6APhhquc+R1
	 H6YEZG7CfyC/H5BCTR3Cel0Gc372arlrzRQzhR4NAaWQVcarIRp2heovuBLru+0hcO
	 6hEIawljODirqORuliHI9a7Tycs23JohEvIhGqSqEFB4Z9P170e8W3ihHCu5yeXMp1
	 NW5ffuOk8p7pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 12:12:54 +0000
Message-Id: <20260814121255.6B5001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical destination-only fallback vulnerability fixed in `vi=
rtio_transport` exists unpatched in `vmci_transport.c`.
--

--- Patch [1]: [PATCH net] vsock/virtio: validate packet source for connect=
ed sockets ---
commit cb88c0daae92eec924188a4684efd077dd9df9cd
Author: Daehyeon Ko <4ncienth@gmail.com>
Subject: vsock/virtio: validate packet source for connected sockets

This commit fixes a vulnerability in the virtio socket transport where
packets from an unrelated source could be incorrectly dispatched to a
non-listening socket via a destination-only fallback lookup.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 8becad81279c8..f73e0406a790a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_tran=
sport *t,
> =20
>  	lock_sock(sk);
> =20
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check if sk has been closed, assigned to another transport, or if the
> +	 * packet is from a different peer than the one connected to sk.  These
> +	 * properties could have changed before lock_sock.  Listener sockets are
> +	 * not assigned to any transport and accept packets from any peer.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state !=3D TCP_LISTEN && vsk->transport !=3D &t->transport)=
) {
> +	    (sk->sk_state !=3D TCP_LISTEN &&
> +	     (vsk->transport !=3D &t->transport ||
> +	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

[Severity: High]
This isn't a bug introduced by this patch, but does the same vulnerability
exist unpatched in the VMCI transport?

Looking at net/vmw_vsock/vmci_transport.c:vmci_transport_recv_stream_cb(),
it appears to use the same fallback logic where it can return an established
socket if the connected socket lookup misses:

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_stream_cb() {
    ...
    sk =3D vsock_find_bound_socket(&dst);
    ...
}

The packet is then processed by vmci_transport_recv_pkt_work() which
calls vmci_transport_recv_connected() for TCP_ESTABLISHED sockets:

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_pkt_work() {
    ...
    case TCP_ESTABLISHED:
        vmci_transport_recv_connected(sk, pkt);
        break;
    ...
}

Neither of these functions appears to verify that the packet's source
address matches the socket's remote_addr before processing it.

Could this allow an attacker to inject control packets into an established
connection and cause a denial of service?

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_connected() {
    ...
    case VMCI_TRANSPORT_PACKET_TYPE_RST:
        vsk =3D vsock_sk(sk);
        sock_set_flag(sk, SOCK_DONE);
        WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
    ...
}

Should a similar validation be added to vmci_transport_recv_pkt_work() or
the VMCI handlers?

>  		(void)virtio_transport_reset_no_sock(t, skb, net);
>  		release_sock(sk);
>  		sock_put(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813121236.2328=
599-1-4ncienth@gmail.com?part=3D1
