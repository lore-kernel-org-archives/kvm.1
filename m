Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFA3F4DE9
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565769; cv=none; b=TxATzGJbaZlNLJ8GQ9V73kCiHk8zCgiWyONhR9jLpcVQWHFBwqUrZioLZiPn4IpaWmIWnXnDZ4G8q6Qmcfqr5cDOawFlkYqTlbNMGXdDRb5E10bJuLBiinC+tedad6WA+z7VfWWVUvO/kB4lYx3LYvPOeSB5f/Waj15Rn4fyFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565769; c=relaxed/simple;
	bh=GVtzPRUY+3WdouU0FCerpegVSH2w3tn1p6Ikj/AEcQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIZ3SdbvYLY88x5nOfklDdt4YFS/BCMLg7Itjy3D32DAvpZEb5bD5i5snj6jvVTNu9ypfe92chE4pz2EngAnAWuuyVK0fxoVVzgAYFNh7mZsHjHbzAnt8HNc1dNmPMHPaXBvQyVy5Bw47gYi+10QcVrD8dfFVP3rKF16NJ1Y5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/EsxtCp; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/EsxtCp"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4b94d72acso1601439a34.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788565767; x=1789170567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M4TJX16AB7oF5KfuSUINVhcqYMne4i5NBIkYyRe0xMc=;
        b=p/EsxtCppcvxYW+a7tpsZEXmfai+4AKwM9QMu51CM/gU3qmTK5rFCTDqZVB46XcVUX
         MQ5Vr1OiosaR4JO4KWdLltXfccPvJ824vwJqkcGrqPe3jkseaWowiRk4BXBrhQJYmxLY
         +79R5Sc186owrhiSMkFRWx/p/rNepv/wpDysIxCq+sjCKav1I8GZFdacWBhgIWk5qoAc
         xSVZoU/U7Pq12tQNn1xD37EFFYO7S6WK/tFiPPwiR4qAqeCQ1qSwvxB0qfkeVmxPYZ8I
         0YO7q8VAJbz5v2l2QR+B+FFtTc3uHt5gSCzkD8mEb3QA4MO0JXq4HNCzLxQjrqmmHE2J
         SWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565767; x=1789170567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M4TJX16AB7oF5KfuSUINVhcqYMne4i5NBIkYyRe0xMc=;
        b=HemkURzRID0pyvCqnDoXj3CuRf+lK2tQVkmtoFOPBsX5GXtQKSvkXYCNj7C51NqFu9
         sBjrwT4E0RHfUUERug/E3g7EwhabAGLkO7e+9Fo6RfTgqdEZEz5PD0ZsAVVS4qOa5LfL
         8jCGddqL/ASmBvTFBTaNBaLrIDsAXpcaftyb9VQ1NwEAsPwN8Jqk02hA5mvBHH2LGsKO
         JZnrO3usEKANM8bLxkuqRWeumPKUNH3tYUSx0W1KVTzr2KPXIETGirLKY46WedTgGfId
         OKH8r4EesQOOipkpkKZP66bZHse4oMpnoGcwvJNsITrGas0sBglJ06agIr+F203EbcfY
         WHEQ==
X-Gm-Message-State: AFuF++n2ZPfEPTNc9eyj+JHEg5h/tizK9ivSA+wQTMJkrcc7xnXqePqm
	7BJA8RgpgX1BXFNx6QoaitRn6kQbE7oalOpDl1N3nOU3WLuXfejok1IVT7oNSw==
X-Gm-Gg: AYBFou1mrMEya7SqZI52B2JfMmSIJ5oarwTeE0ujQhLTrTbfYWti7Mg2l9t7vxQB2/8
	VuGkeHxR42bDrVHPHSN+28Z9s6Bhw3X8XjnC9/tSuPnGkLSnFNB6oiJlk4rPuEJMOa0+DzbvRxG
	jiWsEhRKFxH6F7zRIDJ09abBa4EOvoFPAha/idl5Bu52uyWae7UIXxcD5OpLoCPX6RKPrkl17k6
	AYQ+zeZByBQ8SSkPDLSPVXxaNw5Kx43hUtZJVvOjAuQrHOZpFmyQK7TVbhdtcKXPL/OJddevuYo
	48OBe7I/nqT851WtcjI4NNbZThdtcgHVsoK9XzH/MjVV2cPI7AMjLZQbZUnBJjt6194KnzhtFHb
	aTAJN8NpppUxltuOD5AmmSeE6wgRm42igm80SmDgm3A2KKHfUVPNEppA3BiG0iXQfA/KVmIfNHK
	iriMeunaF0ehF70q8fXgz0Yq4alztpgTF/WtakP7yrD0KBhaO/NmRytu7ZUmSnCDJFKCyDNB9Nw
	899BGIpIg==
X-Received: by 2002:a4a:ee0d:0:b0:6a1:1269:c776 with SMTP id 006d021491bc7-6b6fd6c5428mr5703943eaf.25.1788565766789;
        Fri, 04 Sep 2026 16:49:26 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dd07214bsm5003504eaf.10.2026.09.04.16.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:49:26 -0700 (PDT)
Date: Fri, 4 Sep 2026 16:49:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
Message-ID: <aptZA/uA/6Cwi/Ne@devvm29614.prn0.facebook.com>
References: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
 <20260902-vsock-guest-ns-v1-2-9995383e9a8b@meta.com>
 <20260903230146.DD5351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903230146.DD5351F000E9@smtp.kernel.org>

On Thu, Sep 03, 2026 at 11:01:46PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unreachable connections are forcefully closed without notifying the transport, causing zombie connections on the remote host.
> --
> 
> commit f3fdca73a2fc67941333bcc7521ccf2e755bdfaf
> Author: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
> 
> This commit introduces an ioctl to assign a guest's vsock device to a
> specific network namespace. When the device moves to a disallowed namespace,
> existing sockets are reset to prevent unauthorized reachability.
> 
> Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 29cde17e08f31..ad11f0f56eb8a 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> [ ... ]
> > @@ -710,6 +751,140 @@ bool vsock_find_cid(unsigned int cid)
> [ ... ]
> > +static void vsock_reset_unreachable_sock(struct sock *sk)
> > +{
> > +	if (vsock_g2h_net_reachable(sock_net(sk)))
> > +		return;
> > +
> > +	sk->sk_state = TCP_CLOSE;
> > +	sk->sk_err = ECONNRESET;
> > +	sk_error_report(sk);
> > +}
> 
> [Severity: High]
> Does forcefully setting the socket state to TCP_CLOSE here prevent the
> transport from notifying the remote host?
> 
> When the state is set directly to TCP_CLOSE, a transport's release function
> (like virtio_transport_release()) may see the socket as already fully
> terminated and skip sending a reset message (like VIRTIO_VSOCK_OP_RST) to
> the host.
> 
> Since this ioctl can be triggered by a guest user with CAP_NET_ADMIN in the
> init user namespace, could this lead to zombie connections accumulating on
> the host hypervisor, potentially allowing a guest to exhaust host resources
> because the host is never informed of the dropped connections?

This only happens if the host-side socket is completely idle. The next
pkt will trigger virtio_transport_recv_pkt() to respond with RST. This
is the same thing that happens after VIRTIO_VSOCK_EVENT_TRANSPORT_RESET
or virtio_vsock_vqs_del().

Best,
Bobby
