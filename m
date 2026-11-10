Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287974;
	b=d67vX6zgdn7gcde+qk1xBlM3MbIBujl4l80+HjTNtRU5o2uP3SeyZr6FOUkHk5c5uQg4
	 OC9ye9TLjmq0rWnQgPVe/hqWh5Oi6pzyONWlOvGvrp1zuEB6CeC0alOYOSHBGBkdAkOeQ
	 QJx/5gd1I8ET/TNP2SwDB/bBD0Jt2iJlYk9B2Hw0geKwqQc3LunmnYPZtPjoMaD15zacw
	 SHQFuLV2TNmN08XIIh+9rG+xyMlC6EILPdZQeyyfI+JEXWFRAQv2n9DPYKX08heQcTvCo
	 YIPZm34UloopAzesiuPvdjgH5B/vfLJv9Cl4UUaNS/AngJmLHxmWLolhtaVBj6kLrMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287974;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Yv0P3TWiAzWONtWG2ECNG8H4lCa4xc6OHScDZ0+4aCc=;
	b=ajfAftsfLSfHaS7Qc/BRW1cgpWZT8+pElXYW6MH8E4XvqFZLrlZ69J1pnGmkZfEcrqcH
	 k7xHiOIiyLfhoI7x1wzpnL9grzZQP+fTzu6Z8N6AG7N8W0263928esZYva+Zdi90J7EII
	 ishxRsCV0oKBvn5WJTYwKGI+9zNmFOxHlq6YPlgXCyeUr7iZshJfQYHwbf66qF1JmHJdS
	 3mOwcCHFHEkwWzF6lF/ldJp5zZZV4kxzqUvc+hWCmUHFitOFZQ3sV4JAHYJ7to6y7vchO
	 xfV2uXomewtVHGqtUjpiGUAbX5rFZ2wCZ3znXfy1KI/ENqXZ3zL1q+TBJr8ayPV2kBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=p6P+7S4a;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAC606A31C;
	Tue, 10 Nov 2026 05:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7BAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=p6P+7S4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794287821;
	bh=Yv0P3TWiAzWONtWG2ECNG8H4lCa4xc6OHScDZ0+4aCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p6P+7S4a/rtI0Ax5JVDJTg165W4NPkTC5PFo99HU5CfgqWHxsLR1DoAVyBe/kivJu
	 EzSLruBoQ7nNBjBEi6LzK9SnHiECUPuNDwrG4BTWW09SZmlmmCgkI8joDMmdkrOoHF
	 khEnjOBFC5M/BWvNshaRZ3243n1DiKaZ3ufNE4sU=
X-QQ-mid: esmtpgz10t1794287805t9d703794
X-QQ-Originating-IP: aIKJNBS3eM61OM3SC3IHGrznIfXqHEw19N6Jpqqjrgg=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Nov 2026 13:16:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10376603232952361344
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] vhost/net: Fix receive queue test in busy poll
Date: Tue, 10 Nov 2026 13:16:42 +0800
Message-ID: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKDqGZ+wcdYmN7I/w5u32lU6eKdu1rDL+iRi6TU3+4kma/JDSI7yDCwL
	s8mdutyqH1o/CPRRqvZQBOc7rwstx6xyYpYSR2kPGE/JiQDZpiAp984By23LA5MzsWoq4Bj
	VFwr0sBLM9iZeeBX+A+aZk/MCNI1by4iV2JPVb/O1G0N23aY8/79kHjJVgLhmyvXoD71vSc
	vSb9sbitlgBiF8LLCAVMLj8HwsnHCLIf5n6kmzRJPE2nWhyBWeDGXNJc+QK4F91IvALPFfr
	KoXx5TfxS7Oq9DdwEM74EHAAia6/1xI4NcJ333aPADvcTZm39Uva35nnj3ZzC8cvisuB/tX
	EMyVfFTyZ0yiDA3kQKoxWpINHH4W8txW5U22jZF7BWCVr8USId0rdeY4m+gc+uVswmfdLRz
	SR7MHgCrte3G6P48hyUoOC5aMbytOdJzdMs1g2JJ3R+ja8zN2HfCCP8JdOT2jXoBH2v3fxb
	Nbk61qenkhFvrliiTb4AzwI3c8FbQ113yIazXkJPtzZHkh21Vwte1s5CMhfc4bI+uw2cNsg
	vAtVo/qQZEO2wUEp5aP6EhXbkbHm1xVfe4CuAkLIPOqGjr4Z+wjGJHmSZ5waSxm4TciHy5C
	9Af+FGgjh28jt1EdCC5j+nFiLM5CUPYlii/X2cPjycOZl76XfBd/j5E5grlP/wtIQvmHX+z
	EGKRlvEMDeHe9uFrLpedkbtvoEx3PQQUgPRwWDtuizLIdFeXuZRjSc1GK8918XKzoMioZ2F
	m7yjIaO02zskO2tIqveEqZKELJ/vTNesxsVMuPHpmchVc71KGV/yfz9Kgs1hxSq7u8Z17EP
	+jCAxIofhZPhgQD2SfjhE0dYLHpQ8F8XBVtFYV07eMbmlzLjfQI2UGxMqR/b1tv7oAojpsL
	u3bWlSp4gj8EUL+K6HnfM3oLg4Uqshn2urZ9CYKVmSYRNvFCeN/LnhY3boeYielYakBErCm
	3GKyCIfQk7X2z91C4KCQxw9ib3MIddR85yi+EbyQCmPpgCCW3BPg7oC1fI5LHKX/efG3awl
	41S/T1LKYKydWZUBf684sKJTykkrEc9BqLn7hyemB7cHuM7GEX
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

sock_has_rx_data() returns a positive result when receive data is
available. Socket implementations with a peek_len() callback follow
that convention, but the fallback for sockets without one returns
skb_queue_empty(), which has the opposite meaning.

This makes busy polling stop when a raw packet socket has no queued data
and fail to recognize queued data through the fallback path. Return the
negated queue-empty result so the fallback matches the callback and its
callers.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/vhost/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..10ed2d55ff07 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
 	if (sock->ops->peek_len)
 		return sock->ops->peek_len(sock);

-	return skb_queue_empty(&sock->sk->sk_receive_queue);
+	return !skb_queue_empty(&sock->sk->sk_receive_queue);
 }

 static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
--
2.50.1

