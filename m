Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30513BBFC3;
	Tue, 15 Sep 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478188; cv=none; b=iOukQz4dm8m2SpjUKjITGYAB+192qeEv8x75ksE3Yhdhsf7DMRZXi7QnwDVv0N7MsAschIUPY/9ALZQT3z5A8870426ToZy5UWqH+zlXp9chp1Z7S7jt620lGMdGbneF6Gs9M+BQ9sW3k+//6Y4IiHJX2YreJ3PQv6wSzRUfnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478188; c=relaxed/simple;
	bh=y7KsFyyKmTeubh6XFgZvaa8BZGB1esOoaDfWjXi4gwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXBDa82WJFCwW1ULoiEbyyAX0WBBEBVzyJjcTDCJTi7fguf/YLCN+e24onrQg7RSZY9D+WKA/teYdzUN2p6kjquJHByi8eWpIuYFhxvNTR6hCcECMBI1fqO8P83cJDXLbhJK0le90DCAFgajk288TJr8XIwqnFOXtc/pexJ5f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fE18l4fj; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fE18l4fj"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0h-00HRDO-Ly; Tue, 15 Sep 2026 15:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DeuOQ/YCzV1GKBzzkSDT/ZbSmyFHC1MB2bRkPBvNDS4=; b=fE18l4fj8+zzEPCsgPaxonUVGD
	rQttQ0mMtGEJiagUL+QUhvKEAp4VpV1rFPjSsIwkjLhFWMdocUxkad0fnPiXswSGeqOsOElIQLkub
	64MWl8650xrpPoK3iF+1psjN7jQVLxxU6IR6cs0CJ/Pkvbl3hC8f3BSIdtMiTO2CGUYxj5V4KgIC9
	OUEvq3UpmLAztIZPGnemAIXOn/2AWlqMiO19tObMNFpHtebw9ZVoaBaAGnVlCzyTTYKCUIG/yFE9Y
	owh8GisBp+AOriJXTWeZjNtkaQrdoTJZNyJmQ7slHwj0A6YDPDjqUodZCeyNZu/gZbOIa6yYWdyI6
	+to190gA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x6T0W-0002tu-G0; Tue, 15 Sep 2026 15:15:32 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x6T0J-00EUxD-TR;
	Tue, 15 Sep 2026 15:15:20 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 15 Sep 2026 15:15:14 +0200
Subject: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2

A non-blocking connect() running in parallel with a blocking connect(),
combined with a racy listen() that hits right after a connect timeout:
TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
in progress.

Enforce the invariant. Prevent a socket from becoming a listener after
acquiring a transport.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index f840498b58af..499e902becfa 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
 		goto out;
 	}
 
-	if (sock->state != SS_UNCONNECTED) {
+	vsk = vsock_sk(sk);
+
+	if (sock->state != SS_UNCONNECTED || vsk->transport) {
 		err = -EINVAL;
 		goto out;
 	}
 
-	vsk = vsock_sk(sk);
-
 	if (!vsock_addr_bound(&vsk->local_addr)) {
 		err = -EINVAL;
 		goto out;

-- 
2.55.0

