Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B744E65F
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540928; cv=none; b=g+D4XZNW3q6vlKUak5eGsKD10EwKB0hBao0WgaGM3mAVzdTcFZDQcLrqdAzc0QaB9mgcwLLPc9YSBd5FvTXO3Q9k6VmhDcfkP4eGn7v1mgtP7EsQdfW7RszN9FrUZGN5IzQPZSjVGZjNtMobBJBm8NwXbxfjEitB/xRQBQicocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540928; c=relaxed/simple;
	bh=jyDEhNWEktcDeVA66O0x0HheikRt8+3NMW3l44bD31Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G90VKOuhQQGu3ZuidjFwDGV97QQErfKHyPegpeRTI4RMOEs3e4M/WQOz20Eeao70IelrlsCcHXTjzJO5NkRggjRAYc7Q/Qj1RTgqrSH3pR8zvuC1qJCyHiJJV/X8qoOjeBmLEuSX+lWQnoiybqxmvxUPsw8XzK3nrcMssusq+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YR9lUCsA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1AHSraY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR9lUCsA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1AHSraY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791540923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8qjpcfD3LG1eZs8VSpA9jEQmEOMfOU2B/T9s4mzaz2E=;
	b=YR9lUCsAExcPNjoNYfo2P79M1+v6Q6fA40V3z5ir7T6I5ynYnrKTqloRtWlyy6HosSqV1n
	syvhZ8qCNUpv9ObcG3YMd2xYxzjq8MOwpvPXYPgsiuMlaYCgzaKdF2GaOJ3maDwAuQthb5
	ey5W3LjJ5MAp9g80RxGm5U+pKF/v8nQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-eZ5r-REiPKWo73cj-L7pTQ-1; Fri, 09 Oct 2026 06:15:22 -0400
X-MC-Unique: eZ5r-REiPKWo73cj-L7pTQ-1
X-Mimecast-MFC-AGG-ID: eZ5r-REiPKWo73cj-L7pTQ_1791540921
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c511d9e97so3556437f8f.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791540921; x=1792145721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8qjpcfD3LG1eZs8VSpA9jEQmEOMfOU2B/T9s4mzaz2E=;
        b=L1AHSraYh9niilCYyPHgdz+agimXgXdkuvF+nfeJvFTY9Vwc+LkRnH//WkHPbN3Rfc
         8XRLW4ifCjHzYObphmzK9dbpTstUmIa6qD/MktdetcLknEYgcqrYXRvdN3ccPPmzRtVE
         0fV8omREyNef3RBHyuzupt6kbl1/Z234uQVST7OXva2uAKWJe7V8u6v8mSzyLFe6ouBy
         RiooAEswAN6o44N/j/9a8yhvk01D/Jg0Lpsp8GR7h7b8bXaZaq2J3zPDLwdVZHqPmX+e
         XhcdkXAYaIiyqSMSdG3Dc5gklxFRdbw1ApPMg9OKLj/7nGhygi4D/JZLJGJsfKz+QUN4
         IBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540921; x=1792145721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8qjpcfD3LG1eZs8VSpA9jEQmEOMfOU2B/T9s4mzaz2E=;
        b=iwC1cFN8pZxpogNvv1Cg0GILqkihwrWGpIuKuN3Z3kePNQGqicwI7JVHTUe2oElY2J
         tIZmZn0OC6xs/ecwUv4r0v0TLBZU2o7kTNQHrAorK06KhHoKYfyAQ4QVdTTnkLuBvpS9
         Zlwma5etPsD1j9SnANnQIviLN69W8uPwBHdpUYE29RmK5z99EjwH9eeB+aAKUSN6BYxJ
         pyNBlfYgwUGFi/QNOEz1yMZgOYA6ENRwdJIm4zHTnpl3mPhJ7fXSMaNaRQ7J7ZtO8gtE
         Yq6WsN/e/lmwk+6X5y7vfv0+jGxvzpVDvy+Wk6tfsnzOuMUZPU9sOxL7y55cVApFMe1F
         jq/g==
X-Forwarded-Encrypted: i=1; AKwUvBzUU9BcIWFQWI4lmgt4yf8TTf9a4UvZ17KqCNfHGPhngJjozCv0dzU5jPEPOQReUy4z0LI=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Cz1zKfd78BZj8gZUSOedX4I+yFiOPKQ3B3oX5/qApzgqjZ0f
	8RQELolco47WTqbSUlrNppDYoxrLumpU0QDwNPqbze/6sRhO1dAPzZDSd3S8Iog8DFjtdxF6xBv
	6GpjNbXnguQ6g63AkxJGLIj0KN9fXIXog6MDnK+UoVIkzc8EwzRfOjA==
X-Gm-Gg: AYBFou2lHFUwH4+WsjquVmwQe0Ng7ySmFoqD9muzQrO+aitBSaGh3f9kIfkUOPlpHWw
	NZK0Tx5rWN1cfjYSPji/RjTHS8zjt5akXB63+rcofu175BHLHGzrc4YwC5k/lhCnsNBjNr3li4y
	AGkglfW9/9+rYrXe7vKLKhfmZVPhmCaMsYNSzg/iKPIlUhq8szfhpgw9CZWBWd1b/grjmIzIEqE
	2AnOAEwGRhjZwfE02bjQTtry51W8A+IIFq9HZD9cRsOkwwDJvAqv617LDOR3X/WZoAMlPNDFGjw
	YzduZWQm2pKKJIp34goM8YO3gSuHpb0IGxgvNc7ahkHwR9nQ7u1610FZeZ5bWSCq+BTkOJ3tX1J
	J
X-Received: by 2002:a05:600c:6989:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a18e4a0030mr24138425e9.7.1791540921024;
        Fri, 09 Oct 2026 03:15:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6989:b0:4a0:1f9e:5f7d with SMTP id 5b1f17b1804b1-4a18e4a0030mr24137885e9.7.1791540920563;
        Fri, 09 Oct 2026 03:15:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.115.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm80901885e9.9.2026.10.09.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:15:19 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:15:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
Message-ID: <asi-oV3fF1erjxVs@sgarzare-redhat>
References: <20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co>
 <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>

On Mon, Oct 05, 2026 at 02:26:22AM +0200, Michal Luczaj wrote:
>Handle the TCP_ESTABLISHED -> TCP_CLOSING transition on OP_RST, which can
>race with the connect loop. Immediately break and return 0 on
>ESTABLISHED/CLOSING. The return value of connect() should reflect what
>happened up to the point the connection was established or failed. Events
>that occur afterwards must not affect it. E.g. even if OP_RW has already
>set sk_err, connect() should still return 0, not ENOBUFS because of it.
>Adapt the inaccurate comment above signal_pending().
>
>Resetting a socket that is still present in connected_table can lead to
>memory corruption. The reporter noted lost transports for in-flight skbs,
>and I have reproduced crashes caused by re-insertion into connected_table.
>
>  list_add double add: new=, prev=, next=.
>  kernel BUG at lib/list_debug.c:35!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  Workqueue: vsock-loopback vsock_loopback_work
>  RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>  Call Trace:
>   vsock_insert_connected.cold+0xe/0x13
>   virtio_transport_recv_pkt+0x10e9/0x1460
>   vsock_loopback_work+0x305/0x480
>   process_one_work+0xe4c/0x1560
>   worker_thread+0x4f1/0xd60
>   kthread+0x36e/0x470
>   ret_from_fork+0x47b/0x6b0
>   ret_from_fork_asm+0x1a/0x30
>
>This fix is supplementary to commit 002541ef650b ("vsock: Ignore
>signal/timeout on connect() if already established"). Details under Link.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
>Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)


LGTM! Thanks!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9b71479a2b29..14fe24b05f9c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1834,23 +1834,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>-		/* Connection established. Whatever happens to socket once we
>-		 * release it, that's not connect()'s concern. No need to go
>+		/* Connection was established. Whatever happens to socket once
>+		 * we release it, that's not connect()'s concern. No need to go
> 		 * into signal and timeout handling. Call it a day.
> 		 *
> 		 * Note that allowing to "reset" an already established socket
> 		 * here is racy and insecure.
> 		 */
>-		if (sk->sk_state == TCP_ESTABLISHED)
>-			break;
>+		if (sk->sk_state == TCP_ESTABLISHED ||
>+		    sk->sk_state == TCP_CLOSING) {
>+			err = 0;
>+			goto out_wait;
>+		}
>
> 		/* If connection was _not_ established and a signal/timeout came
> 		 * to be, we want the socket's state reset. User space may want
>-		 * to retry.
>-		 *
>-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>-		 * vsock_connected_table. We keep the binding and the transport
>-		 * assigned.
>+		 * to retry, so we keep the binding and the transport assigned.
> 		 */
> 		if (signal_pending(current) || timeout == 0) {
> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>
>-- 
>2.56.0
>

