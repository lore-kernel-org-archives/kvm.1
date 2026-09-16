Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064A4EE849
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561866; cv=none; b=Z2WYreyrzpPrT6XPLQyvtVOK9B9LxiSQFPGrkZ6ar1/N90auLO4JlHe7r3/HHPQcS1EKgf22gpr9eXgFJo+g3bVfXmABS/mCN/UBy3RlFIlrDjiSP+GAoWdmIa1O8WIVB+UEv6X3sAqOl31xDQziW5TRqWJdMGGbgtafu6Dw2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561866; c=relaxed/simple;
	bh=XGXi9MYz+h2MYHPVx7/i/kQbavA7JbRWDIW6+ytE058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3utCvW4apgvRj6H/iqFvwTH3o2FWsnHii87copXh8ee7P6jNiE7EDpqPo7mondoJMQhCKOYhtcOgQz7s2h8y7/FLhDhrKK1Om0krTPlTAkWtZoRsQ9sBOuPI47SqF053O2knw2inuyrfi+wcbFeZWbUqjmsRWPkUPB/QBL5Fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWZw8LF+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKm+6+r9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWZw8LF+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKm+6+r9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
	b=VWZw8LF+RA8XBlNaL1OeOmh1n8N0StcBy13dLY1D7NWxtah6PMiN8MVlRkwuQ6SNDnTLRG
	WEwYdppnHavd9Djr0HrVrmcIRAnY7WWT5JhJN0J2k9+bj1mpl5uX5ExVfmEKXwUkL7d0Mu
	A3D3qUDiAW9KyYgVuQkXOBThk1JFWGY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-rSIL8VcDO86dcEXBEvyWwQ-1; Wed, 16 Sep 2026 08:31:01 -0400
X-MC-Unique: rSIL8VcDO86dcEXBEvyWwQ-1
X-Mimecast-MFC-AGG-ID: rSIL8VcDO86dcEXBEvyWwQ_1789561860
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso51452095e9.1
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561860; x=1790166660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
        b=BKm+6+r9lu3DsJE4uW8J2eBtIfEmodPbvwFiGz+ePabXnBwlL0012AxjbX7t21gP/E
         NUJm/VXNR02u1Eb0VruDf987OWmQrDwIbbT7ZNGe3y5bMY9B0XsL/vDfBFHEULSSLFV8
         dVgDv9zlwmkuHLzT8PZ9QnatBLhYiy2zEWEhQodtQydoEV9/pFh9XyK4Dks8FWbE7gHS
         8Jmka45RT7HNySHWV0cnTXDVbXNmvp/k8KyqzDmEOpJx/+Tzdf+FF7EZ8rU0HrJ7YI9O
         8MLG0eYWFz50aHuSSJLis9mkhrQpcbPtzmxaE+71681wJcIqHRG7casKZuJ9RGsdXgK/
         cCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561860; x=1790166660;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLMe/wNCn5zgtYuy3BxEIMyOkeNzl/Thlke2TpXOG+M=;
        b=qwx8RSfgWnabxKFWu8Zk7lpbjfTUIZLmXfw54RdaFPCM4uz8KkZRkDs78v1yZwHCGC
         z6n3AEPXJyUfNW+ZxkFTqZPaSr6pIKMqpxu2G5hYrmKOTh3+5s5lngKtLpSl2ZNCfQmV
         jOQfyuUST/VX7JFa065WUqoofBW1jqFQp6dw523QX8XIEV93FdLMyFAeHkcf8TA9S86n
         pnzWtI2wzFQn108f9b62V/BAlNqTDl+s5ItJP6/xZMIWySGn7etr9597RL6kgZXeY92v
         NFZ7n0cVb5xZk27n/oX8PUHS8jtukz0CLoSnsdNhEBOG2/WmCOUuYAM2BJZSd4FFfzFC
         Nx3A==
X-Forwarded-Encrypted: i=1; AKwUvBxv8P+/tC+oejbsZJJI0E2WOCdGkD8KfJ5iZ0Pxrilw9jTEYbR/oM/LJoQjVIC6xBwxT7c=@vger.kernel.org
X-Gm-Message-State: AFuF++lh0YDuFvqSpvZ+upu5gSvmIz99OJQHzs5PiM5QVP1ut3a6hPEj
	ZI0VlY5pENXGcQMXGbDyucxqD9sP5Is98X4BsQeRVJLgpMJYYhiUecEwwtO6pj/bulbwZSkyzPV
	QBqJmgwm+aKiswVMS9PAub310FYveorXTVhMFLQkC8sp6SX2J1BYprw==
X-Gm-Gg: AYBFou303xLU/qc5DHF6pN21ub1sCxcC1DQnk1ar9ZUZXgW9duXJwwlw6T+WptVqLxF
	UfOmwLstgeOjwe0r8rwCQs+pG4GIVCJqkQSsNquzvHDxCQdl6awoFyOYPOhyetPzKmTYjMjWgm5
	9y3ITEaI0U5CJ8nnjr0SkrVF0lCbPIF5miqh8mTm0IzkDRrzV4muT3BLAs2j7YSd6c0enpG0SiL
	HUcAreULWaK/SRbqdXwWF/tormNyL9xGxKSTtipwGF2vdDL1ds3eBzpqBCqF0RTiEjNhlHEoRDl
	xiOayo2bJz0J9l1nYysy6viGB+bMO16X3NARQPD+XN+b0UW8IeOxYAgl//k15SS3GlM28qlyMos
	DgaybeA5zFAE0UOC4uagxoUfqRy15ke0a58YRNFEKWf39bQ==
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61109715e9.8.1789561859678;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49eb730e225mr61107955e9.8.1789561859097;
        Wed, 16 Sep 2026 05:30:59 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d903f6sm72500905e9.4.2026.09.16.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:30:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:30:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
Message-ID: <aqqFkBYebKK1nZNJ@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:15PM +0200, Michal Luczaj wrote:
>Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
>transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
>loop.
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
>Drop the redundant err=0 and the inaccurate comment above signal_pending().
>This fix is supplementary to commit 002541ef650b ("vsock: Ignore
>signal/timeout on connect() if already established"). Details under Link.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
>Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 499e902becfa..adf3f018347e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1712,7 +1712,6 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 	long timeout;
> 	DEFINE_WAIT(wait);
>
>-	err = 0;
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>
>@@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
> 		 * to retry.
>-		 *
>-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>-		 * vsock_connected_table. We keep the binding and the transport
>-		 * assigned.

Should we keep "We keep the binding and the transport assigned." or 
maybe add on the other phrase, "User space may want to retry, so we keep 
..."

> 		 */
> 		if (signal_pending(current) || timeout == 0) {
> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>@@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
> 	}
>
>-	err = sock_error(sk);
>-	if (err) {

Should we add a comment here explaining why we are doing this?

Thanks,
Stefano

>+	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
>+		err = sock_error(sk);
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
>
>-- 
>2.55.0
>

