Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712823;
	b=FRgn6vJK/VfvU7T7oROpXeNihpKNfgMxZqLhcCx47TnLpAOQUpVdDO+q1FRdeIW08aQB
	 4xP+iYfGbstFOLsxcPS+bK0NQTMYEMS5i3oiGnkDd6fKz6/pJ6v6fasNDqIMJIgvJaPsS
	 sxvvsgoc2nd72ii8GImLfqJQOnyYLimQPKnwxngERaS0o4SSXdcTKaZuv7eUSWgnltHdr
	 F1rTqHdDj6exxe6zPtJu9bROb6moX3pC1/fImjwX5P7Ro9QLOspMqGlHo+9suAt6YEFlo
	 oom+nWl04FcMlBVU9lz670ZFvTA/Su08MFMJKfbTb7Pk6Rpifo3yytPb6nfZjR4agPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712823;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
	b=ixo0G+tvD6WF6xFeHx3aZnl0LsqcdNJBaiJTeeqzzERKqkYhi4vc7QWVBnP2icGo4SjY
	 EoSigFYflBd3qh22CQjikuL8axIivdO6QXX0vY9IefsqOlA8gG48vyJg9x66LC3sLTAUC
	 ymwemCqN3T66zXxDlfkEGNmesg48jcpLJuxLMfPZOaA+gX1tBylEoMDz1KUJe5wkbeWqx
	 zjmuqgA/9jWeITKF3xQwowrAK7UNz97Zk9fG+r5P1Hafmuax0LC2cY5EImbSG2KSe/4vT
	 bSlAiu8tYWRyPccb2Biw6IykibpNfwEzxTEqPI20P94WA4l02kYZKo0XBfT8GiGjBZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6ZBKwzI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="PLsVU8/t";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91357606A32A
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91357606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X6ZBKwzI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PLsVU8/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795712821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
	b=X6ZBKwzIgscc6W5g0qwuJQYsvzeKifdTVPIyhVsV+xk8Zq4sxiijQvRn+rGnEAia2iqbmd
	sfJeOiyPFlHwWMyWkmHzPga3XiX7sV/FAM6e9URU1BmHG8RAipsItT3FYQLoomfRqunZaz
	+Cbq4bGP6HR8WgosqG+pbXa863omXv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-pUamuWAYO0C0EiNNBtuwzQ-1; Thu, 26 Nov 2026 17:06:59 +0000
X-MC-Unique: pUamuWAYO0C0EiNNBtuwzQ-1
X-Mimecast-MFC-AGG-ID: pUamuWAYO0C0EiNNBtuwzQ_1795712818
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso41631995e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795712818; x=1796317618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
        b=PLsVU8/t6IShUQkO4Xi5sL6dme5WEAV9ZzVwE+mt1HgyIE+OEEWfqaEapHKJxq2wrx
         corwKq8uU/Q1P46zcbVRSK0p6ucwOhgXWhLUNKaRyxMSL/nQB/Q8zHpQLpDiFGJjn93U
         9F49r3aou6+BCDkNgzSaVjS8SLiQPI2SI6WbHXeokniDYyjGP1XnzpSdVNdCO87wKgFJ
         kb16dzwGwQPwfV/RNwKOXkX2IQRjSeQ1x3S7mfG8uG3HiO/yvl8tMGFTLns2tp2oW9zp
         uUjNMCYLVpdJVz5iBJHwhhPUKHP1A73a+ZcFgED4EjiTMacNmnuC2wO+OM197zVoPXKR
         MCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712818; x=1796317618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0yjxrZbpz1L+siRYyu7F1RBOFIChPAKyEA33AawY46g=;
        b=2czCKOINk8D+dN1GPKReFYm83ObqCT4ibZ6BpO3T7epuXu34S5fk5axpjj8WzT77No
         Kx1avnnLR3MXmE5jFWFNPONahxaPIGBfQc8e6xXne0+5UxJeXM8XMSithhWMPFWBai7d
         H8H5yTrZieale9gd+pDYKa/xt6yS2eaRYGgpYHxhsCrey3xig/g/eaaXq1G++qTyyuhX
         7EDv2bnpyMjEK6+e/U9TCn5BaWRfIUZWdOZAEgQSYRmKM7UcPV7GwfFFWjRlc7sfwoOz
         ZmOU4nQxzzoUMWR4vqWZ2tGQ7MVQLyxyFYux7ahBZ0aYMM0/x3n4xgSkcQQwerYarS1g
         1ugQ==
X-Forwarded-Encrypted: i=1; AL+hErGCgGiJYWggWr/ipOIgYUepfHYeLONTzG3GUnZ49nud24LEXGuvoA2IYruLOi4wl82Bcf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8rKcIrqRxK9dQ9wvUQpHwonD/8Vwrkl5txKBrFsMWgnviWKL8
	Bc+lxSYxGOOSd5a6uUHkA92Wepk5xW9wqnkLX8y3VJBMiqyZrmp9yEo+7XVfFeDEWeaJ+AhYhxx
	ktyAbMjKGk3I23ypGP6C48B+sUrJDl41kg3pRHXFLTwLsjIqTsu8kVw==
X-Gm-Gg: AZFdTZfNfTRYG9lt0BLt8Eblx7qrLyyWDbYdGSj9TTMQvgaDqGMn36BlbF2qgzrihep
	DRUpy9EVJxtDukg20jz5VNJ2oNQf49Cs8/b0JsnJ5Tb64vSeprXuNWNGp7LWFVWCJpVIpT9DeuR
	5LgU4dQMSziXABpPOGv4NkUsWd+a9dwK96BrFH3btJ4UM3RfCuYkworsyvrKhrorodilwT8fomm
	XGPbf0vG6huR1yQF9I4MDKw+Fz6tDIXXBIIeaRWOHvznrAuXIGc+kgPUBFdoUxzLAVTL5DojF7v
	M+OkyScB9yYfSlcVQsccGrvas2VFphXMh/+X5AWCwsyuXw0o5ziey+K9ZWKrWhqPnaQYChSBeBQ
	FL0uTK2PHSvAktY7DwZXo4PTY6/u3KzEpmx0zhNcozfUdMRCTJ/Tiyg==
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr463369535e9.14.1795712818009;
        Thu, 26 Nov 2026 09:06:58 -0800 (PST)
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr463368905e9.14.1795712817454;
        Thu, 26 Nov 2026 09:06:57 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm362731005e9.1.2026.11.26.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:06:55 -0800 (PST)
Date: Thu, 26 Nov 2026 18:06:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Sashiko AI bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and
 vhost
Message-ID: <awhAaTuR375RpyAE@sgarzare-redhat>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>

On Tue, Nov 24, 2026 at 01:20:18PM +0100, Sergio Lopez wrote:
>This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>the existing AF_VSOCK API. It is intended for guest and host services
>that exchange independent requests, responses, or events and need message
>boundaries and sender addresses without a stream connection or application
>framing.

Thanks for restarting this work, I have finally found the time to took a 
quick look, sorry for the delay.

Reading the cover letter, it is not clear to me the changes we are doing 
to the core and VMCI that was already supporting DGRAM. I'd like to 
understand better how the backward compatibility is handled and how VMCI 
behavior is preserved. Also reading commits, most of them just contains 
a description of what the code is doing, but they lack the reasons 
behind the changes (i.e. the why).

Overall it seems the right direction, but I have some open questions 
(some of them discussed with Bobby, Stefan, and I at KVM Forum some 
weeks ago):
- Can the virtio flow control be affected by a flood of dgrams ?
   See https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-5720001
   and virtio_vsock_pkt_info.reply / virtio_vsock_skb_reply(skb) 
   handling.
- Did you test virtio transports when VMCI transport is also loaded?
   That one is automatically loaded (for historical reasons) first time 
   AF_VSOCK socket is created, if af_vsock.ko is not loaded. So could be 
   a common scenario.
- Any limitation of the current implementation that we will need to 
   fix/implement in next steps?
- Any performance number?


About patches, I started to review, but I hit a wall with patch 6. It's 
too big and really hard to review/maintain. Please split it (e.g. the 
refactoring for vsock_assign_transport can be moved out, etc.). Also 
there are too many if() with conditions duplicated and few comments on 
those conditions, for example:

+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport == transport_g2h && transport_h2g &&
+	    transport_h2g != new_transport &&
+	    try_module_get(transport_h2g->module))
+		fallback_transport = transport_h2g;
+	/* Loopback can own datagram state when directional transports cannot. */
+	if (sk->sk_type == SOCK_DGRAM && !transport_dgram_fallback &&
+	    new_transport != transport_local && transport_local &&
+	    transport_local != fallback_transport &&
+	    try_module_get(transport_local->module))
+		local_fallback = transport_local;

This seems a regular pattern, please make sure duplicate code/conditions 
are factored out.

Patch 7 should be vsock/virtio, no? Also should be moved before we 
enable F_DGRAM?

Also check better the bisectability, I'm confused why the changes in the 
core happen after we expose F_DGRAM to device/driver.

I'll send some reviews I did before stopping with patch 6, I'll take a 
deeper look patch by patch in the next release.


Here other issues spotted by an LLM reviewing (line numbers refer to the 
full series applied), please check if they are valid:

- [PATCH 3/8] net/vmw_vsock/virtio_transport_common.c:357-360
   (virtio_transport_send_pkt_info())
   When sk_wmem_alloc reaches sk_sndbuf, the datagram path returns -EAGAIN
   even for blocking sockets: nothing waits and SO_SNDTIMEO is ignored.
   UDP and AF_UNIX datagram sockets block in sock_alloc_send_skb(). The
   selftests always send with MSG_DONTWAIT, so they don't cover this.

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:588 (vsock_use_local_transport())
   Stream/seqpacket routing changes: when the registered G2H transport is
   virtio without a device (get_local_cid() == VMADDR_CID_ANY),
   connect(VMADDR_CID_HOST) now goes to loopback instead of virtio
   (-ENODEV). This hits a guest before probe or after hot-unplug, where a
   local listener can then stand in for a host service. The commit message
   says the host alias "remains", but before this series it never applied
   while a G2H transport was registered. Using dgram_transport_match as an
   "is virtio" test in stream routing also looks like the wrong layer.

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:1674 (vsock_dgram_resolve_cid())
   VMCI registers as the datagram fallback when its module loads, even if
   it has no guest/host context. In that state get_local_cid() returns
   VMCI_INVALID_ID, which is VMADDR_CID_ANY. A wildcard-bound or auto-bound
   socket then matches the first branch, svm_cid stays VMADDR_CID_ANY, and
   every wildcard sendto()/connect() fails with -EADDRNOTAVAIL, even with
   vsock_loopback loaded. Because of MODULE_ALIAS_NETPROTO(PF_VSOCK)
   (vmci_transport.c:2170) this module is often loaded on non-VMware
   machines. In that case VMCI also owns every datagram socket and creates
   a VMCI handle on each bind. (Sashiko reported the same issue on v4.)

- [PATCH 6/8] net/vmw_vsock/af_vsock.c:833 (vsock_dgram_get_transport()),
   called for every send (af_vsock.c:1740) and for every packet received on
   a connected socket (virtio_transport_common.c:1840, from
   virtio_transport_dgram_source_allow())
   Each datagram takes the global vsock_register_mutex, does a module
   get/put and may do several vhost_vsock_get() lookups, which serializes
   all datagram traffic in the system. On RX this happens in the RX worker
   while it holds rx_lock/vq->mutex and lock_sock(). (Also reported by
   Sashiko on v4.)

Thanks,
Stefano

