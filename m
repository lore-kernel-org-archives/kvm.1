Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871953612FB
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825065; cv=none; b=BZcxlVOzBbvwQSnXvHc/IVjfpOy+bCO3j0TiPEnL5h4O47jhzJ71mlRbybiQT9FX7kuxA0lNPCQvMBzdxtFswxU42W5GZdSkr4LIGFr4HEXMgkJmBmfNrX6Ns9R44z685JSFMT6pqXpT2YXTlGo/uLIWkprg4Zgwv2XWNyBYeO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825065; c=relaxed/simple;
	bh=qp19i8gKOQAW2OoVrGwPyPDIdtOoJJmFIYmFogXNP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7D8Om9jBUj9F58FFpeB/BTAn4+1sj5YZbwFlet2IELSJhX4Deq6jwzOy/cU9abhkWPRSTzOK/At+BzMa7v0yVbA31dLyKMeB0NA3MfPpiIZf7B4Cjwyc4Lcd38Kdu7j2hVcr8+DBSpb+wGI/bK87nr82+28u0N04WY1nr7RHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jOnNv4vR; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jOnNv4vR"
Received: from ms-a2 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63M2USQV090865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 11:30:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=swiEIN7WrlDhQ8FdTFcXjLaM5ebLD8EN3bBCVp4yXgs=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776825029; v=1;
        b=jOnNv4vRad30NNuL1TItyyMkLMKSN3yaIbKcgLTLMmvtg+FmJxUoGR9fktP+IEw/
         CBIrNyvQ7whqPJJtyi7l4nI3/urHNr3MT4mq47EsV2BexXOPyBAxjccTpAy2uzrR
         W/AeeNddVdRpcYtAiOhNbtFltiu2BzLbfPZM87ak3UJBqktpRF8umkOiS0hoiuxB
         K7YYlVhogp8+4PSlLv+P7bJobn9Br6XMTv5YB10jhn7Z2EGkoJpp2HP7oyvOGYzF
         qloWGP8PnnxpxAZDA7EnSAX0cxTbEE0aaXqE4HePKyNOs8hyEtgWUWKcs+mjW20u
         cDOj0JkS6hkFemKKgqxs2A==
From: Kohei Enju <kohei@enjuk.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>,
        syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Subject: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()
Date: Wed, 22 Apr 2026 02:30:24 +0000
Message-ID: <20260422023026.81960-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported "sleeping function called from invalid context" in
vhost_net_busy_poll().

Commit 030881372460 ("vhost_net: basic polling support") introduced a
busy-poll loop and preempt_{disable,enable}() around it, where each
iteration calls a sleepable function inside the loop.

The purpose of disabling preemption was to keep local_clock()-based
timeout accounting on a single CPU, rather than as a requirement of
busy-poll itself:

https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u

  Changes from RFC V1:
  ...
  - Disable preemption during busy looping to make sure local_clock()
    was correctly used.

From this perspective, migrate_disable() is sufficient here, so replace
preempt_disable() with migrate_disable(), avoiding sleepable accesses
from a preempt-disabled context.

Fixes: 030881372460 ("vhost_net: basic polling support")
Tested-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e6a414.050a0220.24bfd3.002d.GAE@google.com/T/
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 80965181920c..c6536cad9c4f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
 				     tvq->busyloop_timeout;
 
-	preempt_disable();
+	migrate_disable();
 	endtime = busy_clock() + busyloop_timeout;
 
 	while (vhost_can_busy_poll(endtime)) {
@@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 		cpu_relax();
 	}
 
-	preempt_enable();
+	migrate_enable();
 
 	if (poll_rx || sock_has_rx_data(sock))
 		vhost_net_busy_poll_try_queue(net, vq);
-- 
2.51.0

