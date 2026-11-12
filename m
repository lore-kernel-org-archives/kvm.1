Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479719;
	b=wQEgVPa4p27zZlM22KR81JrkTY+e4jrU/jvwry9402gL3cOJ2AShNBjPieaKa9D7+egS
	 f55nUfJgIuQQCRLIb9HS6UrgbnbX8las/K98gdyGk192a5gQxgf9hyoLajJmsD46L7Lmv
	 U7CxZuhVYSofw/mymklcGkDfiflEio0AyEc7AB77hw3nRa6ZtGmpkJhJ9XuX5FvmDz/SW
	 AcDutpizbDFLVVNZLrYbxE1shTQaLTIF9TlcRUKlKKkXnj286UlJiQzANhfeFH6B6hJZo
	 uOA816ed0ZmfZ0Olu6ATxe+fv5yf8V1mMcNPVRbBzHhJMiEhwWEn83y+nS0JRoOVi1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479719;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=72sPZJMfQhmbB1ZVGdOBB0ZnPu9Ix7ckpmn4Q/SFcLw=;
	b=U4BjcH/l7Le81nPg23JCKfhvPMFQ+tHSS8E22ijs7BXqB2MNfX/ATUsObpIiqJPRPZ0j
	 YueSs5xERzUcb8/o9EUz4G3PqLgwxQt7QS+sTfcJ74DYK7mKN8Cwn45bdUSXpiOolzeLv
	 5v2ogVfm1qakIqSw4nN9qBJlTx5aDcWaVqTa1u30FKuNRbCb5x3kRZ1f5TZTpN5vTJnmK
	 VGItZ35px2lcKnLfaHbOAJgjeaSWXKUK70mw8tLvMGfFSxTeBgvOR/+3vAOOAbkZ4gLxI
	 AocdMXUJxu3nsw0R9OCVf1YMOcv3vtqoqgrVR+veRLLJEABJUahCd5BoUB6yk9G2nrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=KMoVWYKV;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C6606A88C;
	Thu, 12 Nov 2026 10:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71C6606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=KMoVWYKV
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xRS97-004Sja-6W; Thu, 12 Nov 2026 11:35:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=72sPZJMfQhmbB1ZVGdOBB0ZnPu9Ix7ckpmn4Q/SFcLw=; b=KMoVWYKVM9ilqL/7/iePaxMMJT
	LJH6p8ZLBGMuep6DAZfoys0ulDMYxtbO36uhOv4dbLDelpjGo/B6a4pIdM9H9C5a1F7S5xQt9rQZ/
	lP1tsoZfsiqwFevIYwrBVVGDVTH7Hwrn0rT/kTT4wlztFmzbJhsik9m61b261BTGtSHgWM11faKkh
	jI3BSwSDhPIlu902BhqFRrxXz3ZAaal6mhEGarI59C+6DWiU0NnXvTDTDNY9IogpnFWEA9iXjHQks
	WDy09gta1O+IN+NdAVunXUsTvWE95SnuhIK54bF3/nvb1H9oeUZVsBrgyAGuW6cW6r4ucn6plgLZh
	UthB9QPg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xRS8v-0002tw-C3; Thu, 12 Nov 2026 11:34:57 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xRS8p-004y3a-GT;
	Thu, 12 Nov 2026 11:34:51 +0100
Message-ID: <c34123f3-e006-4c25-b8d7-cdf0784926f4@rbox.co>
Date: Thu, 12 Nov 2026 11:34:49 +0100
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
Subject: Re: [PATCH net-next v5 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
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
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@gmail.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 02:53, Bobby Eshleman wrote:

> +/* Avoid breaking the socket when another thread has changed its sock->state
> + * while we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	sock->sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;
> +}
> +

It'd be nice to have it as a separate commit. If I'm not mistaken, this
itself solved the vsock_connect() vs. transport reset
(vhost_vsock_reset_orphans(), virtio_vsock_reset_sock(),
vmci_transport_handle_detach()) races. And those were already reported a
couple of times, including a recent NIPA/Sashiko Severity-Medium[1].

[1]:
https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/

thanks,
Michal

