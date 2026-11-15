Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784256;
	b=Lq47pAVENbe/OZAMJOd6URjGdBNURnoPxu6VDiyqNeKIz7zOGq1UQwtpgQ8DNO32Grpr
	 WXFf+9lZuge6AfsCr2k20/RC8lyoYj1znd4OBfbrxPytNq6CJmjKxnLn2Ra9TexOtzMRs
	 rCH35H4Fv7Q2r3XOO6gJQAH/NwEtOzBoWnYvqN6SRhsOqTzwdEyngjx7qb+0J1y+JNFgr
	 0qQMnRrSJkyT/+TQUZLoSI4h1Zso+rvBRVNIQaegiRmT1b0owcY3Y5uIjpp01EcEPAxDA
	 0S1PmoHljl+kmwhz/vrqp0BhcfofjokZT+bmJGnxNhqGY/c3w9zvykWhuo+snVj9v8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784256;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=54DqklQJRU5E5sAvgMJe/3GZgyr2z79+L1pPnq+zQII=;
	b=oWc9g/O9x/eUjk+TEdPPStMFVufk7VajFk175zy0tohz/yVk2nD64VD/gHjKNmrog3V+
	 bE9/hU6y/gB4EX9kTxodWsnjzk3p8HrabJKhVH3x7wrd0sJHeWaa8CI0fyFhYlSm0msbF
	 ugVjEAwbqpa8ihUqW5PABOlVAR8BrDbsHS4zmXCZ0x59ZdkLCEaselLqEzDo26PjIqNOL
	 6JyVPRoIM/TNXcKTbkWoJ9QIwl+SJc0usj7cdj2DXZcVOwz19N1zWRhtQ+QQmVXMolkGR
	 CbLy9y1AqEyO3l8EEUSOMwZ+NsMnTtua9Sck6Wvl3OOV/fgg/AaDY8CB8uOjvcThw3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=F3DWF8eP;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46140606A329;
	Sun, 15 Nov 2026 23:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46140606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=F3DWF8eP
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xSjMy-00EbNP-U4; Mon, 16 Nov 2026 00:10:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=54DqklQJRU5E5sAvgMJe/3GZgyr2z79+L1pPnq+zQII=; b=F3DWF8ePjOro893G9DPFG9cjA5
	m/V/eoM7PuzpWe9M9OfLhr61T5tRk3EJqylSekZclnYIqLPteYV68SY9FSU5u00hqJ5KvXkon639Z
	yjz9GkcQOuaCnaAyspNsaErReoRkUNgPDTs3xVe4aLTjtAemeC4wwt+B3i8yKVJAi0eXvFuHzpBwl
	xGMKL2gc/YXjrfgMfpnMlv7eoQGc6O4Fi5y6wlk39seZJSoBLRrJfBuUVXxDahZRDfWdzzJ1yuqj6
	cqQhTCWnTzn4MAgPwUyouA8ESD4chI15qM04xXnNJ7pLlgPvJNPqisz6Ql3owj2F/6sZ5Hzr52kNT
	u9l6tWpA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xSjMh-0004wX-B4; Mon, 16 Nov 2026 00:10:27 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xSjMb-000ing-CY;
	Mon, 16 Nov 2026 00:10:21 +0100
Message-ID: <6bdfe6f7-aba8-4fb8-ac24-62fe020e1422@rbox.co>
Date: Mon, 16 Nov 2026 00:10:19 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
To: Bobby Eshleman <bobbyeshleman@meta.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@gmail.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 04:14, Bobby Eshleman wrote:
> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> and a connect() to a CID on another transport makes
> vsock_assign_transport() release the transport the socket was connected
> on.
> 
> Only move the socket back to SS_UNCONNECTED if it is still
> SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> another connect() fails with -EISCONN.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Suggested-by: Michal Luczaj <mhal@rbox.co>
> Link: https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Michal Luczaj <mhal@rbox.co>

Thanks! To be precise, the Link: above is more of Sashiko's musings on
what's wrong with Jerome's (not merged) patch. The patch of yours makes it
moot.

I believe the first time lore mentions the issue at hand:
Link:
https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/

And there was at least one report off-list, so:
Reported-by: Kyle Zeng <kylebot@openai.com>

BTW, I've noticed Sashiko already commented on this patch. I feel I'm
responsible for that wall of text, so I took the liberty to reply. Hope
this will help.

