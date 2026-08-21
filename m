Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8B3BCD33
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302284; cv=none; b=VGuftX0eY3E5We8L20do+kHk+PT4IKucB1S806Ge9Z9oBgec/cDF+hBCA2MZfZ9qwvx7Mu3ykiyLWGtaxZqzkqFd5ddkYMDMTGtLkDxlDlfbYyVridF4UedGJr0O7ayCdJL3B/sGfwXbOF4AH/wT1ji3cNdsBgATi8ceGuBnPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302284; c=relaxed/simple;
	bh=1Tod6uMNvMI753P4muUbJppzBeqFN07J+ccstjPlhiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsMC9m/H5v7VTuGu52nG+ouaDRPOpQhXd7By6aVZzvfW2J3hrGoVx4W0PaYzO5vC5XwDRJr5fMzVAWsEhZUStzbYdhuQXw1L5wn2VmRWpC8RCR/77I5l4g4Cvkmz8I15Ojjzx0Y/WLezNZ5GZgxaGRpp9soESmTNWoP8I6VXK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9t4644a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt2mYjhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9t4644a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt2mYjhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787302281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAMfT7dZIDZktTjpF23N4xlIpV3/mfSKrwhJnlOP5bk=;
	b=L9t4644avHxP4mPu2JbDkgCuBwRaYW2E5Y+dlq+HdgxFkqGFph2bpyQtUyJpj5l073v7QY
	lrNwUXuXYolOqeLiSSHcfrcEcUP6s02aSQi47X9MUWbgiPKKnQ86Mld4NrcHPv0EXCx+mV
	z9gisesvs2MtdPcjY/BCR+p6xyao5es=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-tnfONbsYPR-V35AEK615qA-1; Fri, 21 Aug 2026 04:51:18 -0400
X-MC-Unique: tnfONbsYPR-V35AEK615qA-1
X-Mimecast-MFC-AGG-ID: tnfONbsYPR-V35AEK615qA_1787302278
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c160b9c0676so57841166b.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787302278; x=1787907078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dAMfT7dZIDZktTjpF23N4xlIpV3/mfSKrwhJnlOP5bk=;
        b=Qt2mYjhGxiRGuuGTosQLr3VtvIeDS0/cRiCYOkYq8Y83/lcOL9a8Bsjg78ZTZsW42Y
         44cmefamm+Lc0O+LCYTHXcXn6W6f+qEgCVF5d+YB4JeN31fv+vv9tmAXHBY4WHeLWMo5
         2dneAbxUMxt+OFk1Hl3CaTp0g/sgbcAKa3mLzoHazFNQ7zjXOWXFeRg73qs7VaaHvCNw
         pJTMWl+JDzjUaDB/VhgxrXDoabagELRG+/3DH6SEcuI5ANrjb4oqG+DVa1a6Wvjp0Hzn
         b8QWQJoLAYVx3T3AGMCQ0oeffwdvnSUFsl6ZKoMhWUFB1asJQd3DhgxYpA2vMBvfHf/R
         c3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302278; x=1787907078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAMfT7dZIDZktTjpF23N4xlIpV3/mfSKrwhJnlOP5bk=;
        b=e9wFEbdYwcqwUD4AdLH94AF8jUAjW/gR5Uq0200n5LLv8uYtt9PeAJNk/k0NKPaYCJ
         UTZ384FzHKlV5V6XZ/Qku0f/nvITKMZgrekCgMsHoh1f4IdElBTI6zplPmmesjmgwbYf
         5lsac9N/cT3ywxHb9V+7xg+sTAj/cD3fiSfCsgZKhJXI2fucT420NzRY85wW9S+fuTKH
         mrrDe4bF+L24kmUu7NY7NJrPxlCDUnVwCmIWNKmw6L7E4PLzF+5rMpayF6h/sVR2ABFx
         9qjcX3wKlZyAtUrcVSGuPA2AYxNJ31HCUa01sNvJnBYaT4ekDQYMbs0IADX5AxwIKU/v
         QVtw==
X-Forwarded-Encrypted: i=1; AHgh+RpBv4TI5CeWfgvkK2aJZRiipUXTxagbRWJIQtL6XWlUb/hIrR8f3BG8H6uO0RbdvyDAT6g=@vger.kernel.org
X-Gm-Message-State: AFuF++nRnmURHWQ/dhCFguJ9FKPOWqxXOt42nwggWjP9dVpQNm5RWmU5
	zNfV5zKPojOpajcNt6UBAOdnVA0X6KRZXPSVpQD964DvrZho1pxdfCpYiG1PkuGayUOOGx71YZh
	7SU0NHwTiKMKkTAmD5wxwdSW13N4dj55m3p3KHOUuUwuGO6qIkXdgursic0kTXQ==
X-Gm-Gg: AR+sD12RleG2aK85SmJl9dcCOGUiP5NIEARRBe6rYWy0r2MPGGACTIBlWod9UBAM/bd
	K7apMjS31aQE+06Py0fAF3wXMG400WqVQuDRVoVQUPDsD08vDbp4nA6dmMKmNzwJlU20uHBkOyc
	kfG66Vc+/ZgM60QgpT31SAsniUmvsmtH7/1ghQm6TOExCNXa9DTZVc4JcGg8xxeMEXV4mhyjI+U
	I//3NbBcuWhxoTOnXxa9IawVaFAw6gpubcOHQPHyjbcnRd/v3EK5tF0AIOEy72vUY8/2gt6sfgW
	Aa9on00wMngZXnjr53dBmthqPdo2jnRI8KXjgTHLdO62y7TELHzfjybuubUHRN1YYDOQIIlAfMh
	LTg==
X-Received: by 2002:a17:906:6b86:b0:c21:74ad:8b7a with SMTP id a640c23a62f3a-c246a398994mr383580666b.9.1787302277601;
        Fri, 21 Aug 2026 01:51:17 -0700 (PDT)
X-Received: by 2002:a17:906:6b86:b0:c21:74ad:8b7a with SMTP id a640c23a62f3a-c246a398994mr383574666b.9.1787302277050;
        Fri, 21 Aug 2026 01:51:17 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.88.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b09349sm360276866b.19.2026.08.21.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:51:16 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:51:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: validate packet source for
 connected sockets
Message-ID: <aogL1SZD9lsE5qyC@sgarzare-redhat>
References: <20260820001517.2148196-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820001517.2148196-1-4ncienth@gmail.com>

On Thu, Aug 20, 2026 at 09:15:17AM +0900, Daehyeon Ko wrote:
>virtio_transport_recv_pkt() looks up sockets first by the full source and
>destination tuple, then by destination only in the bound table.  The
>fallback is needed for listening and connecting sockets, but sockets remain
>in the bound table after connect(), so it can also return a non-listening
>socket.
>
>The fallback does not validate the source address.  In TCP_SYN_SENT, a
>RESPONSE from an unrelated source can transition the victim socket to
>TCP_ESTABLISHED while its stored remote address remains unchanged.
>Subsequent RW packets from that source are delivered through the same
>destination-only fallback.
>
>This was reproduced with capability-empty processes under different UIDs.
>The attacker discovered the target tuple through unprivileged AF_VSOCK
>sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
>the intended peer-side socket read 0 of those 16 bytes.
>
>After lock_sock(), reject packets for non-listening sockets unless their
>source port matches the stored remote port.  Require the CID to match too,
>except that the loopback transport uses VMADDR_CID_LOCAL as the packet
>source for connections addressed through its valid CID aliases.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
>Cc: stable@vger.kernel.org
>Assisted-by: Codex:gpt-5.6-sol
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Changes in v2:
>- Preserve valid loopback CID aliases by matching the source port and
>  accepting VMADDR_CID_LOCAL only for the loopback transport.
>- Rewrite the commit message and receive-path comment for clarity.
>
>v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
>
> net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8becad812..d8990f5f6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
> 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
> }
>
>+static bool virtio_transport_source_matches(const struct virtio_transport *t,

This doesn't seem virtio-specific, so why introducing this function 
here?

IIRC we agreed that also VMCI has the same issue, so what about adding 
this function in af_vsock.c?

Also I don't see VMCI changes, why not doing them together in a series 
since they are strictly related?

>+					    const struct sockaddr_vm *src,
>+					    const struct sockaddr_vm *remote)
>+{

What about moving here also the transport check?

So we can have something like this (with some documentation):

bool vsock_check_source(const struct vsock_sock *vsk,
			const struct vsock_transport *transport,
			const struct sockaddr_vm *src)
{
	if (vsk->transport != transport)
		return false;

	if (src->svm_port != vsk->remote_addr.svm_port)
		return false;

etc.

>+	if (src->svm_port != remote->svm_port)
>+		return false;
>+
>+	if (src->svm_cid == remote->svm_cid)
>+		return true;
>+
>+	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
>+	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
>+	       src->svm_cid == VMADDR_CID_LOCAL;

Could this be just `t->transport.get_local_cid() == VMADDR_CID_LOCAL` ?

I guess the source is trusted and if we are in a local transport, it's 
always set to it, no?

Thanks,
Stefano

>+}
>+
> /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>  * lock.
>  */
>@@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	lock_sock(sk);
>
> 	/* Check if sk has been closed or assigned to another transport before
>-	 * lock_sock (note: listener sockets are not assigned to any transport)
>+	 * lock_sock (note: listener sockets are not assigned to any transport).
>+	 * The bound-table fallback matches only the destination, so reject packets
>+	 * from a peer other than the one stored in the socket.
> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
>-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>+	    (sk->sk_state != TCP_LISTEN &&
>+	     (vsk->transport != &t->transport ||
>+	      !virtio_transport_source_matches(t, &src,
>+					       &vsk->remote_addr)))) {
> 		(void)virtio_transport_reset_no_sock(t, skb, net);
> 		release_sock(sk);
> 		sock_put(sk);
>
>base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
>-- 
>2.54.0
>

