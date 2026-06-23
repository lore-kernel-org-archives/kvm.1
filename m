Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF7390CBE
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237536; cv=none; b=ffqj4BTaBP8q72XH+KRYISujTqmryLbqqRW0W6fXNuQRpEdjR7lsL4r2v55yW1Mm0WvkD2Gyz4H+WR3TftKBe6VqjmVPJuakNfSWiyF1hBZikKgiqteHIjAGt/WA1zzXqxgLH5P2isGxEN3kApn9c7jKxRlYA8TwN6FTjhQjqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237536; c=relaxed/simple;
	bh=RzEDS2yX+4MKzi0o36/G+EV0tHRLGjT/pJ+PsRmPSfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oDgBYcKx/OrWX4qoUwCvHy7E0PBoAo7nUtM2y8keda14Q81yRU+ZGVjKq5rxxpYiLY839EQklnqvxNkVBSN5T5W6xxtOsunuGf3IOElmBuNdpHtcxtdrF75SxpMmpBXO21DQwuDthHQxaP7IbCjnstwwB5c3FH6RL+U/2pt9bb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbAOy+R6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbAOy+R6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6601F00A3A;
	Tue, 23 Jun 2026 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237535;
	bh=29MXx0ZeiSexMD4mniQObjEduMkNTNcTPVWQ3j6Z4ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbAOy+R6CkQ+cPJ2JRV+mF4IuJ9cAqm9u2hsJUNWkDhAMkP8qUVQhDVCGV3JXV3FL
	 C/M4OGjfBsZspEUFZpeCinve4BZH1eb56D6frqKdW7BPsffACsdvtpVZ+67sUc4Es/
	 ebVzUHuknm7QqZ17/OFxmdr8t0SsbDEW+jczPVFYNJLg0EgU+ZrAvKV/5oEHdNSgE1
	 RvgXZjP0L8TYlUGKl0XtUbZP8E6yEqfCOG/EbW6S6MI/1SIHUMdmhoK6MY+iF5MWcy
	 PugwuNmsZX5xbdrXbDd/0O/kEoeOmj3q4BbM76hDMY5WEIDvh4KooFQQpLn9zNAXwp
	 VFQ9RejxV89ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622175808.508084-3-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
 <20260622175808.508084-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:58:54 +0000
Message-Id: <20260623175854.DB6601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `started` flag is never cleared on VM reboot, permanently di=
sabling the originally intended fast-fail behavior for all subsequent boots.

Pre-existing issues:
- [High] The patch exposes an unbounded memory leak and Local DoS vulnerabi=
lity by queueing host-initiated packets indefinitely when the guest is paus=
ed.
--

commit c58db98ab34af8efb673c49c85406f685bf9805b
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause

This patch alters the fast-fail condition in vhost_transport_send_pkt() to
check a new 'started' flag rather than checking if the device backends are
dropped. This ensures that host-initiated packets are queued rather than
fast-failed when a guest is temporarily paused during checkpoint-restore.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index b12221ce6faf2..bec6bcfd885fa 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
[ ... ]
> @@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struc=
t net *net)
>  		return -ENODEV;
>  	}
> =20
> -	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the pac=
ket
> -	 * and making the caller wait is pointless: even if the guest manages t=
o init
> -	 * within the timeout, it'll immediately reply with RST, because there'=
s no
> -	 * listener on the port yet.
> -	 *
> -	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
> -	 * the mutex would be too expensive in this hot path, and we already ha=
ve
> -	 * all the outcomes covered: if the backend becomes NULL right after th=
e check,
> -	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
> +	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
> +	 * Before that there is no listener, so queuing is pointless. 'started'
> +	 * is never cleared, so once we're up we keep queuing across later
> +	 * stop / CPR-pause windows.
>  	 */
> -	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX]))=
)) {
> +	if (unlikely(!READ_ONCE(vsock->started))) {

[Severity: High]
This is a pre-existing issue, but does changing the fast-fail condition to
rely on a flag that is never cleared expose an unbounded memory leak when a
VM is paused?

If a guest is paused, the device backend is stopped, but the started flag
remains true. A local user could repeatedly open a vsock socket, call
connect() with O_NONBLOCK to the paused guest's CID, and immediately close
the socket.

The close system call invokes virtio_transport_release(), which drops the
file descriptor but does not call cancel_pkt() to purge the pending
VIRTIO_VSOCK_OP_REQUEST packet from the transport's queue:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_release() {
    ...
    if (remove_sock) {
        sock_set_flag(sk, SOCK_DONE);
        virtio_transport_remove_sock(vsk);
    }
}

Since skb_set_owner_w() binds the queued SKB to the socket's sk_wmem_alloc,
the orphaned socket and the SKB are kept alive in kernel memory. Because
send_pkt_queue is unbounded and there is no orphan socket limit, could this
allow a user to indefinitely leak kernel memory and exhaust host resources?

>  		rcu_read_unlock();
>  		kfree_skb(skb);
>  		return -EHOSTUNREACH;
[ ... ]
> @@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vso=
ck)
>  		mutex_unlock(&vq->mutex);
>  	}
> =20
> +	/* Set 'started' flag on the first start; never cleared, so send_pkt
> +	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
> +	 */
> +	WRITE_ONCE(vsock->started, true);
> +

[Severity: Medium]
Does leaving this flag permanently set disable the originally intended
fast-fail behavior for all subsequent VM boots?

During a VM reboot, QEMU resets the vhost device via the VHOST_RESET_OWNER
ioctl, which clears the backends via vhost_vsock_drop_backends(), but
typically keeps the /dev/vhost-vsock file descriptor open.

Since the started flag is never reset to false during VHOST_RESET_OWNER,
host connection attempts during the rebooted VM's early boot phase will
bypass the fast-fail check and be queued indefinitely until the VM fully
boots.

Could this contradict the commit message's goal to keep the behavior
originally intended, which is to fast-fail if there is no listener yet?

>  	/* Some packets may have been queued before the device was started,
>  	 * let's kick the send worker to send them.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622175808.5080=
84-1-andrey.drobyshev@virtuozzo.com?part=3D2
