Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387A48F857
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787697165; cv=none; b=kw6jT+UiEWizHxjtlQRcwN5iCsYCSDwHqr8UY+T1EmRcSQ19NTaWubQ3vHKJAfrOtRGgPAzQX8wQTPU50hUw0tfj8iP6+e6txtuIrMlHS0l5hdm/OXTBe5OIB4Ij2HAQNnEl6Dz3AF4Rgbm0eLFVpw4w34XEwMfKbT97QrdotT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787697165; c=relaxed/simple;
	bh=4iqJpbtutOm4R3XsSRye/BVM3lSHQyMhCGLpVeYI+dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwXi46KoX676bs1EoVg8r7VaGgqnyjzGRa9iZdaHdw/+Zn9Lh6+yJT6iHDokRgp0simhc6unanxlB1pBBtqT+GrirMKCYmQ/nE4f4tpG3bdAiSr2FIHwR1kzE29HdLWOW1DP8y0grsv5qJZgrGjB+DlP2fjFkJMXHb2CDpSrpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImXdyWx7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImXdyWx7"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso528424a34.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787697161; x=1788301961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oAPCDDssQLWXyDbqpT5diYKMULhijQjsUnk18J2kiPw=;
        b=ImXdyWx7hNcruRjnJH+9eAer6ZxupYdZpK5hXn22o/uTqjKdygExOylpiLmiAMKVis
         E/f2mzl2MJb6y9AJ0LODYCbwkF6hJz/JFrBNVJ3I8bjydJRgOA17V5RBOFtZrGt4/HJM
         DmsLCLXtuEfrdmlmdUlgXFBsu2NDkz1thF000P0siZj9WyU+hjjlnMvGjcvOKBIYyPH9
         pEIJ/YcZZCoIjUu9i6xQDg1Tvb+Gr9hsVSjsMMkkU6QfyoxqEnjVwQ05qmMe2LW+BROB
         CE4wNoF6U0gupW14NuAS3rjBzvwZjoxYuqYzLdyC0h7q+OQhghRaELTrIHTGwU8cn0wh
         Ehbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787697161; x=1788301961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAPCDDssQLWXyDbqpT5diYKMULhijQjsUnk18J2kiPw=;
        b=GJ77HhkTcp2mCnL9kXr17f8Zy5/l0WXnb5ArAAITo9Ex6CLJnXVH/wB40t0B/OBquc
         7xiZiC3zbJocaHS1CMg1vj9sqLrG7o5ZNIzpx7CmtT1nkw+ePlF6VEavCZv0EPs89ygZ
         VsUaZ3iTAev6lt8VPs7aTsyKV8b3Gjaf7BYLsTBncKDTbAyvKmneQSmymPkRibN0+wf2
         TYkDIqky7N7WUflGJbx3cZDeACfVFxghPkNLIXZKpz0+BFqadtYXsZgpxFyuarjscueR
         SsBiKIErUbzEu2GMLhyJoGBDwDbwE84uayF/LfENNRLe9FpOnyu8ajwe227SDdClLVvo
         6d9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp1VtCvpbwYqehQFlwDV8FxQK5WpBaqCyMs3eaPLIHWayhPI9f+rIp2/EwhQhYh+jtwyvY=@vger.kernel.org
X-Gm-Message-State: AFuF++mLrZQYR01OMYjvnezxXEGqmQSzjLvaROrN2uCxX2XlFEtQAZuG
	N/VYk/31j6+1g/HnvpcrFlCObrRjXfrA6m8OEy7hLsLBxmI0smLIaj/1
X-Gm-Gg: AR+sD11SUxprElhWBElP8IyXIOVoLoR/fijYRLCJibDziidq3M9FbE/LHg7cj80bKvn
	WVi52d1LROoj+T4hZu7dveuBGWxXEHiXOmMFRjut4ftLd8EpDFTlPIc01ML+IxvpRP3CTavpXHO
	iKhMPJ81Qtb2y34392jC8/idjKSTZuLFg+6j0uIgceTv296ok2Dl4ibHvWvtUqRMEMoyD2eEjoL
	tIItpo7z3jWuNanvB+OQ7q8Xv466T76TplXtVy2/PnMRI1D0oyQMKwZm7SX05j3uW2eoP+v/2Pt
	RBQMt7O0P52krKRK2ptcWxONfbsVc/OxjOG7HcflARKC3GRK+LmCI9aoXq8ZGt9eel4Y/33lB+a
	8OUPjXuSOpPDLQBw2+CU4e/cW4PuIwAwIty+jwlZG81F2RNyaEGdyP0fpButExBwkGk/28Q3dq5
	UeHm8PtxJ+PN3BvOPMaMadYihVYFxsdczRrm3njQvLAggmcw+0cA7znt9ARB/RLKV94yLuRPO/0
	Kx+K948wQ==
X-Received: by 2002:a05:6820:2016:b0:6ac:9729:6710 with SMTP id 006d021491bc7-6b1a049e03bmr2588322eaf.18.1787697160680;
        Tue, 25 Aug 2026 15:32:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bdb31sm194474eaf.2.2026.08.25.15.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:32:40 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:32:36 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, stefanha@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
	jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] vsock/virtio: validate packet source for
 connected sockets
Message-ID: <ao4YBNYwQ9PGC0CN@devvm29614.prn0.facebook.com>
References: <20260823175858.351431-1-4ncienth@gmail.com>
 <20260823175858.351431-2-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823175858.351431-2-4ncienth@gmail.com>

On Mon, Aug 24, 2026 at 02:58:57AM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() looks up sockets first by the full source and
> destination tuple, then by destination only in the bound table. The
> fallback is needed for listening and connecting sockets, but sockets remain
> in the bound table after connect(), so it can also return a non-listening
> socket.
> 
> The fallback does not validate the source address. In TCP_SYN_SENT, a
> RESPONSE from an unrelated source can transition the victim socket to
> TCP_ESTABLISHED while its stored remote address remains unchanged.
> Subsequent RW packets from that source are delivered through the same
> destination-only fallback.
> 
> This was reproduced with capability-empty processes under different UIDs.
> The attacker discovered the target tuple through unprivileged AF_VSOCK
> sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
> the intended peer-side socket read 0 of those 16 bytes.
> 
> Add vsock_check_source() to validate the transport, source port and source
> CID against the peer stored in a non-listening socket. The local transport
> is the CID exception because its packets are generated internally with
> VMADDR_CID_LOCAL as their source, including connections using CID aliases.
> 
> Use the helper after lock_sock() in the virtio receive path.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  include/net/af_vsock.h                  |  3 +++
>  net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
>  net/vmw_vsock/virtio_transport_common.c |  3 ++-
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 3357ee62d..5549298c1 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -229,6 +229,9 @@ struct sock *vsock_find_bound_socket_net(struct sockaddr_vm *addr,
>  struct sock *vsock_find_connected_socket_net(struct sockaddr_vm *src,
>  					     struct sockaddr_vm *dst,
>  					     struct net *net);
> +bool vsock_check_source(const struct vsock_sock *vsk,
> +			const struct vsock_transport *transport,
> +			const struct sockaddr_vm *src);
>  void vsock_remove_sock(struct vsock_sock *vsk);
>  void vsock_for_each_connected_socket(struct vsock_transport *transport,
>  				     void (*fn)(struct sock *sk));
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index a33b2a2d3..f840498b5 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -438,6 +438,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
>  }
>  EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
>  
> +/**
> + * vsock_check_source - validate a packet source against a socket peer
> + * @vsk: socket receiving the packet
> + * @transport: transport receiving the packet
> + * @src: source address from the packet
> + *
> + * Return: true if the packet arrived on the socket's assigned transport and
> + * its source matches the stored peer. Loopback packets are generated
> + * internally and always use the local CID as their source, including
> + * connections using a valid CID alias.
> + *
> + * The caller must hold the socket lock and must not call this for listening
> + * sockets, which accept packets from any source and have no assigned
> + * transport.
> + */
> +bool vsock_check_source(const struct vsock_sock *vsk,
> +			const struct vsock_transport *transport,
> +			const struct sockaddr_vm *src)
> +{
> +	if (vsk->transport != transport)
> +		return false;
> +
> +	if (src->svm_port != vsk->remote_addr.svm_port)
> +		return false;
> +
> +	if (src->svm_cid == vsk->remote_addr.svm_cid)
> +		return true;
> +
> +	return transport->get_local_cid() == VMADDR_CID_LOCAL;
> +}
> +EXPORT_SYMBOL_GPL(vsock_check_source);
> +
>  void vsock_remove_sock(struct vsock_sock *vsk)
>  {
>  	/* Transport reassignment must not remove the binding. */
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e4ebaa70f..6301c108a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1823,7 +1823,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  	 * lock_sock (note: listener sockets are not assigned to any transport)
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     !vsock_check_source(vsk, &t->transport, &src))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
>  		release_sock(sk);
>  		sock_put(sk);
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
