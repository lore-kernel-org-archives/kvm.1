Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC348D884
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561906; cv=none; b=iOHb7zxNy6hqyHHM//MwrY4WP26sS4VJUS25dGnBsRedsmizXWfBjomCTcxJoQTGMpIEIVXAEXtwidw1xX1kzR+1v47QAm1oOm/fQ+1Y9MUNxT5GGdhDlhN8obFGc7iKTw87uPGcSw/L6yReFBTaw5X/AhRqUsN04hCrn9YSVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561906; c=relaxed/simple;
	bh=nhAs5NaETTRV4ggb9S2xjW6cdn9Yst6vjKb89fLknJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efHQvf8W8tftFXWQNI5LhjP/07Z8UDzHZmPOt/hlbMuc3ey2XbaukZ1byT3FLKRLVwhGibKCCguwfAE2YG7ymoOnZeLoFon/Zyv7wHQQ9Y8Cw/6nwX+QEEdamq3XV9DSu4sU1/SbooBCIXFYX1OLGqiW6MhiYwPqIBX9Xmzr4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+ydnonu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijP4VzdM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+ydnonu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijP4VzdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789561903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuADGtRtcHr4ScjMyRSxePIFnAMKQr7pseg7z3igueM=;
	b=O+ydnonucX8HNLxnzVdGJ9nCFLv7a1rpvd7nNRTXU/0fuLKjlPDg0l4jeTL5Th3asDyn5R
	aig1ZuOpgPbjMciIB0qUOHvQEhNjItMD1fejRLxSO6Ahb5FhoGUyP9es02nWBUbMhcTJoB
	ViA715ktmeBlxoRk3Uy7yjl+sSLyG8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-94Jicbl2P4OdQVW6pmkz8A-1; Wed, 16 Sep 2026 08:31:41 -0400
X-MC-Unique: 94Jicbl2P4OdQVW6pmkz8A-1
X-Mimecast-MFC-AGG-ID: 94Jicbl2P4OdQVW6pmkz8A_1789561901
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6683d48fso49138145e9.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789561900; x=1790166700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuADGtRtcHr4ScjMyRSxePIFnAMKQr7pseg7z3igueM=;
        b=ijP4VzdMrM9kBee6MK9kuFNPaFjSR9lHt4t9Zw2NpW8dQgSJGK/q60QOjW9CY2e8B2
         TxpDM5CsCrgx5g0sScID3T2um/uBc4E+23JQTRzhT8qqJcQN6szjt3OG75By8DN+roMU
         gk7Ya/Q3uVZ2EcB7q2mZYFkiaAK1A55Y1J7+Zb2l0qVjPBo00ijtBteLnciLeE4gD/Yi
         kMiD/JQnoxg9Yp214AKC4EmHUKi52bB2ZjX0q3UGDCodfL+jp78TXWYOWboladna874U
         vJuhhLH2c6+7b1s3BK8WGRHbj6/xsZrcrtR3SqR2wQAlejNSkm4EkuHB6JOBoUkv+CTf
         svwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561900; x=1790166700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MuADGtRtcHr4ScjMyRSxePIFnAMKQr7pseg7z3igueM=;
        b=vX1yYzuB5an4u/EAyRyghy+G2Mv079cetIj44IVa58ofwdz6b4bQGlfTifm+9OUxdE
         u93fLgwworT/X34CrlfgJdSZepk0ygKLhKFuRW/v+db5y2Je927R5J2MjApdtYmqdTBR
         Zq7sAV0dGKywZ9nhPaspAK3zqobFHC1tMLuQBEGOoPwF2wdx7aIXIntkXafMvUnmFWZf
         QpYOPA7HuNRG1NvYcAEVi8uqIDti88WbpG0Qm8IwltTWukp+JWqLy64sOtKJY1YDtAgD
         G6swObx6/rEZzRRZla1Gl8w+0I9JnPMzoBH/2f2iwNnO3aFXhW5GPOJODrQbo2O8xxxr
         L5VA==
X-Forwarded-Encrypted: i=1; AKwUvBzL0ZijMGVBrhkBETeCdVuiOVjdW12D/8ilmIPkHHlizkiOnNwYT987lQvWNWJb/a/bFAI=@vger.kernel.org
X-Gm-Message-State: AFuF++l8RXiRqk1ht8eJkrq++MNqS+jboyVI1CP/cxP2uNE1jd+49fiM
	8n7v5Ui9l06A7YxyltaYfLu9x7QgAbP4CTKZl7hoTB1kvAjdi+/jufz2ZQMybdfREX5vI9rct+Q
	aJpm9X/c1UP4Py3lKWrBAw1RaNRAqU4IzvAxEhQ9fDO+g1CeMwoHjuQ==
X-Gm-Gg: AYBFou2K1FrJSLFqxAH6ozlUHmWXhq5NnBUgbh7JqyWhWk9mmy9b2kofTC1ySOWkK4C
	w81lbrWnnvqiTJoDbJ88dhmBZjFYOQMVC0McqqXNZiM4bDk9MbTb0TJWNrNd4m7hemvsW1Tqo3/
	PYyyKYs8+KjIa2iYKxNvEgFKoNdQpld57VkjbmF8NnCccM7PfzlBzjdBlETQFpGnsS77PEn9R7D
	YPm7WA3/4wWa9B8lFaRoYLo7RcXefrAQTScVOLpwX482AiCQVtX+b5586OMH+7mmlWrd6JrgHnq
	G6rpQkhy8g3iMVkxCblk/yX+YMWo9KfmHjozBoDZMLMXI1+guE7ESQGQyUOtw9z7hYzCWgc3PU1
	QVwwz+bOKbWybZxrTVzS9/LQKhLI9M9mb7ttV2p2fXw6p3A==
X-Received: by 2002:a05:600d:640e:10b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49eb7314c13mr20983725e9.6.1789561900494;
        Wed, 16 Sep 2026 05:31:40 -0700 (PDT)
X-Received: by 2002:a05:600d:640e:10b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49eb7314c13mr20983095e9.6.1789561899813;
        Wed, 16 Sep 2026 05:31:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847fcbdfsm43541255e9.4.2026.09.16.05.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 05:31:39 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:31:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
Message-ID: <aqqIuUadZ_E1skmR@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>

On Tue, Sep 15, 2026 at 03:15:16PM +0200, Michal Luczaj wrote:
>Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets

What "PM" means here?

>each connected socket. The reset is done under vsock_table_lock but without
>taking lock_sock(), so from the point of view of vsock_connect() -
>locklessly. The same pattern exists in VMCI's
>vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().
>
>The complexity of connect() comes from the fact that:
>1. the virtio transport can be reassigned, so the old transport must be
>   safely released;
>2. a failed connect can be followed by a retry, so the socket must be
>   reverted to a sensible state.
>Both cases apply only as long as the socket has not yet established a
>connection.
>
>While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
>transitions can also occur:
>
>  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
>  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
>  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
>
>This further complicates connect(). Rather than making every event handler
>drop the socket from connected_table or adapting connect() to handle more
>transitions (while missing proper locking), use vsk->peer_shutdown as a
>poison flag. Whatever state an event leaves the socket in, the flag bricks
>it and prevents suspicious transport reassignments or TCP_SYN_SENT
>retransmissions.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adf3f018347e..972952d04a81 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
> 			goto out;
> 		}
>
>+		/* Virtio/PM events are serviced locklessly. */

IMO we should be generic here (i.e. don't mention virtio or mention it 
like one of the transport, but IIUC also VMCI does something similar) 
and also we should explain better why we are doing this, like you did in 
the commit description.

Maybe we should document this behaviour also on top of this file.

>+		if (READ_ONCE(vsk->peer_shutdown)) {
>+			err = -ECONNRESET;

Is ECONNRESET a valid connect() error to return?

>+			goto out;
>+		}
>+

 From LLM reviewing, can you check if it's valid? :
   - M (net/vmw_vsock/af_vsock.c:1747): VMCI regression.  vmci_transport_handle_detach() sets
     peer_shutdown = SHUTDOWN_MASK unconditionally and then special-cases TCP_SYN_SENT with the
     comment "we treat the detach event like a reset" — i.e. a connect() retry is the expected
     recovery. It is reachable for a non-connected socket via vmci_transport_peer_detach_cb() (which
     uses trans->sk, not the connected table). Since vsock_assign_transport() only clears
     peer_shutdown when the transport actually changes (af_vsock.c:671-689), the retry now hits the
     new check and returns -ECONNRESET forever: the fd is permanently bricked where it previously
     reconnected.

Thanks,
Stefano

> 		/* Set the remote address that we are connecting to. */
> 		memcpy(&vsk->remote_addr, remote_addr,
> 		       sizeof(vsk->remote_addr));
>
>-- 
>2.55.0
>

