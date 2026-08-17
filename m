Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3FA379966
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989408; cv=none; b=ks/aAuNQzGHplfp4/0kM3FBKf7uwi70w9ceFT54cuF2ycv9dLaIWT4VjqCv2qk9iKloHHWWG0dYQ9SqTj/fWbPDK5ZKStLZnSm+dMyetahXGYT2tLNtvwCm8TqCDCzMBG61TZiqFTmL4shTcTDaW8tla93UIVWWwewapCf0lRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989408; c=relaxed/simple;
	bh=9JWIDMRvb6uL0k6LrrHl7ti08cD3k8wEjt9ZJwkEjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iASUSaLuq62bbULjtHSzMROXNQeiJTk1Kp75hxc8Oio+wSCsoaUinSwDv08cMbKQpf6zfH+zhpU0UPVfcYnwQXvSStrbnG1lcypKtZ3x6eZm1OKMjlo9uCG3XzTTMXIdakVc905h0+4aNAB2QJo9JifxerynUnvgbimu5FvcFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDq3okXP; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDq3okXP"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso3688897a34.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989404; x=1787594204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=ZDq3okXPQY+r8zgNNn8FwMUpvlrpBWVXYnLW7IBDLdtXml5iac3Yq7ddEjkMaCFmzY
         Oy1Ssq+8g9nXd0t3qCVxqk/Il5GTe078VJdreyXKpLPitm1LGHhcJbybLCo1yMaOBxp0
         t+Wno63MUWYpsfzFQOfw08oCYeIzlIVoevymMzKV1WmWSl0nBDwGjSx5aQCgTbDI2Dcl
         Bca/1UDosFjACirz47dp7zhTs1vPL1vCPl+n+kaJZNjJcwa29+lk2/WJnG3EvDampiwT
         CCUCkhHc4uGJfm6qUC2nEmMDfvuyQ1NcAkNGMNhTKKK+aKcDg7ZMdEeK90wQh8hAPWNt
         Ca/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989404; x=1787594204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8k1YxolwhVR5S1sB1XwRYtHWGpS7hH+697FP1h9LyqI=;
        b=WicwYyPYwBO+2dZiOTfHnotUNxJsEBhYFo6Sp1qL9YGkRj5zOklGaArg5Och2qU17Y
         5xs3wTGSciZVWiPxG22JlALiD8OU400y6ue3cuUvw0Vvjzf9HXSYvOYIwFvn6DDba+J7
         fIVP9eWa7nXJuzOmc2ord3Pfu7I8pLWFpaugLLvSwNGsH+C+hNjPNkNeIh9o0+on68Zy
         FCmEGXDL1UJeBjBhayhjV66W5hLFVAnE8+qEM1rAFvswE0+pIpodHvRsOe7e1bIV+txe
         ZD3xQ4JznfcEQStvDXjgIE4thsfYbN1wpJN6EXCj/dLPFcOYy3kk4t7kZvHYNn5vtjIg
         IMRA==
X-Forwarded-Encrypted: i=1; AHgh+RoLLwrlNsyWQQ5dYsZdLUqIq5UcgsSZDRYQuosK9Lp8BU/PN4J3Qysmwwi9ImdQaclCd7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbAUnP3eEsPjtfNG2Jt4DUCzH2zeGMPhF+vE10sLp+P7nD+Dt
	rsyRvzCUMSP6B6Ke7puxDpGwFGX4ljWrgiqCXjRarEIAOOE2Uf30nUao
X-Gm-Gg: AR+sD12UwvHecuIkz9LAXcl+ci6N7MA4Uop8dm1vSuztMb+eYyDyoAyL1uVJbW736V+
	cW/p64VpA2++KtH5eBC1VTA7i2152UOtv8xRtClODbqT02+hwzs/lh/mHrS+iRqwnlVMAlqoSYy
	+XT74A0Ad8FkMXNw9BvD9sNZUdxGR3LrXoZPFt0KTUEvf6gM24iqIuA11SY2EpxV+4+RmFr+UaD
	tAG982uoA0+boWGyGNtMvC1vUqRnBCTr5lg3IHHhwJoSS21Mpm8oRaQ3oCOqP0O8KcaJPTW/pbj
	gyssVKh5WR1J6igsP9Hm61wUtsFDE/QO9jLCgY85IrUykBGVUtNbmBTBLFm6iXCP30URKXu6q3K
	WCWAE+f/4EPLiJyiNzUchX8833NmxzJuY2u13/pVmYd0uY89yRm8UTX5ttzFvDUfr1XO74DNUdf
	MUHGlxg4T6BvSBas89XdWl/7OqZHVVwcw+KbyDvkKqH+Vnzi7aTMJDKrBFKJQSKBxGZBlr18p5G
	g3n53B/KA==
X-Received: by 2002:a05:6830:6809:b0:7e7:5e4:ee11 with SMTP id 46e09a7af769-7f3de809148mr27312808a34.16.1786989404542;
        Mon, 17 Aug 2026 10:56:44 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0b935bsm2004457a34.14.2026.08.17.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:56:43 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:56:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected
 sockets
Message-ID: <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813121236.2328599-1-4ncienth@gmail.com>

On Thu, Aug 13, 2026 at 09:12:36PM +0900, Daehyeon Ko wrote:
> virtio_transport_recv_pkt() first looks up a socket using the full source
> and destination tuple.  If that misses, it falls back to a bound-socket
> lookup using only the destination address.  The fallback is needed for
> listening and connecting sockets, but it can also select an established
> socket that remains in the bound table.
> 
> As a result, a packet from an unrelated source can be dispatched to a
> non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
> selected socket established while retaining its original remote address.
> Subsequent RW packets can likewise be delivered through the
> destination-only fallback.
> 
> This was reproduced with two capless processes under different UIDs.  The
> attacker discovered the victim tuple through unprivileged AF_VSOCK
> sock_diag and injected a chosen 16-byte payload into the victim established
> loopback socket.  The legitimate peer received none of those bytes.
> 
> After taking the socket lock, verify that packets for non-listening sockets
> come from the peer stored in remote_addr.  Listening sockets continue to
> accept packets from any source.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8becad812..f73e0406a 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check if sk has been closed, assigned to another transport, or if the
> +	 * packet is from a different peer than the one connected to sk.  These
> +	 * properties could have changed before lock_sock.  Listener sockets are
> +	 * not assigned to any transport and accept packets from any peer.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
> -	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> +	    (sk->sk_state != TCP_LISTEN &&
> +	     (vsk->transport != &t->transport ||
> +	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {

Does this equality work for loopback, when the CID may be
VMADDR_CID_LOCAL and/or VMADDR_CID_HOST on host or the guest CID in
guest?

Best,
Bobby
