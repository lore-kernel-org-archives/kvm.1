Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EB558208
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082975; cv=none; b=IrQSCOYe4ixyHxiMgAGPfW9yS5q320Y5ljvSuvaxIX0KK7yx2O9m0GPh8I054WerZbiwgRva6C8FoZawup9BCP/Fzq4vEi4Yao5fmgv037ZSuw6h3I+hbwnI3PkeCoPxipz04oQvtTwWMhw8+jDqa09qdjSHxyILxVZ8S4dqujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082975; c=relaxed/simple;
	bh=XVovbV4MiKgVnCHFfITuoF6Ff9BScK9zcsSsj4gL0h8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkJ0eOcYVW69jns9TLk2CTDDZhUKTWjXI/s8Wgjf5W+zc7zsYpwAYKYG+LyvqhSd5dSs6pqGR5GwevQpbliX3fhrcl7yJwwA5Gb8PvOA47u/6d77XGaV9S3IfpwnQGUV/DAUO2imAhQMGX9h97hQ/VGjU6uUYOpTap3E3pGhUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IbXR9pBy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IbXR9pBy"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90LM-0038Q5-TS; Tue, 22 Sep 2026 15:15:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bArskdOfI8ynyADnsLgfNNIW4cga+YxDLW0nf10f/Ns=; b=IbXR9pBywQnF5ewMnRjGpz425K
	7f+MrIADThYPOyF835Rfic8cRXQK/+sNcugF/aiutFfsRpNRg4k01tRna2+sD2v+Q/Xz6xZ1fqpK4
	V5DcbPDKAzcV+8btar73T3JcStoPcGKPlNqbdOB6mlPGI1xiDNJwGr/tIYGAdaABwPnza4oRhcEHd
	7x8x+yjkChF0NI22pgq1BIOwP8MzEatliBVtAig1ZU05l9RUl6dXTC24Y4P6W6Zud/LSFGi5VNmwr
	yWoMIfxrwik5zQG14cHQeOcXxNfNONdivwzvjw2Tl901HjwtWLcAEhYO9kW8LIGf2Hk5x8z8KhEmE
	dv6ApVmg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90LH-0006Oe-5b; Tue, 22 Sep 2026 15:15:27 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90L3-00FyKH-VH;
	Tue, 22 Sep 2026 15:15:14 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 22 Sep 2026 15:15:00 +0200
Subject: [PATCH net v3 6/8] vsock: handle socket bricking due to transport
 event
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

Transport events are serviced by resetting each connected socket. The reset
is done under vsock_table_lock but without taking lock_sock(), so from the
point of view of vsock_connect() - locklessly. The same pattern is present
in virtio_vsock_reset_sock(), vmci_transport_handle_detach() and
vhost_vsock_reset_orphans().

While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
transitions can also occur:

  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event

But transport events leave SS_CONNECTED state unchanged. So take a note of
that, rather than a) making every event handler drop the socket from
connected_table, or b) adapting connect() to handle more transitions (while
missing proper locking).

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ff4140aaf1f3..5a2d7e10ecb8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1663,6 +1663,19 @@ static void vsock_unconnected_reset(struct sock *sk)
 
 	sock_owned_by_me(sk);
 
+	/*
+	 * Transport events are serviced by resetting each connected socket to
+	 * TCP_CLOSE. The reset is done under vsock_table_lock but without
+	 * taking lock_sock(), so it is effectively lockless from the
+	 * perspective of connect().
+	 *
+	 * Preserve socket's bricked status. Also check SS_DISCONNECTING, since
+	 * shutdown() may race us.
+	 */
+	if (sk->sk_socket->state == SS_CONNECTED ||
+	    sk->sk_socket->state == SS_DISCONNECTING)
+		return;
+
 	/*
 	 * Only connected socks may have peer_shutdown or SOCK_DONE set.
 	 *

-- 
2.55.0

