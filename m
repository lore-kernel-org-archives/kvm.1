Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9D230BDB
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966106; cv=none; b=IHGQ6aPo2irUDBqSkTvkPKXkkVdW5GuIm3BbWlDW1RNwkjOc6z27gLveaGgYCYeoUj681Gwz0kEnIsq+9/KJnzSxYa5RP4wpEms33gtp2xOZ3r0CssRt5V2u4RvpbCgPdqxWbcVEVJSDUmKaOhcJyF1B9hrpUG2Tov6PXAvS95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966106; c=relaxed/simple;
	bh=37MPcfbmxnv7oFfJE4XBHYuIXMm5oEIMI1uGgOdOOVk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ML00GRXdxD4CGhWmr8Q6d0i4fQeF8J1jSksuGSpC3lYGD8cp0GIZ5ZksCPT6GD3a+/X8Y7+AwjuRrjdb4h5RswRVGFv9OoBEelwo+99Czjim+Sctd8Ev9VkyjjcCyKAK++6yaCrGyuT67pmlX0VElmhcZfVARUZkvTQiGBEpZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P0yHBx+C; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0yHBx+C"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84240683a82so3523781b3a.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780966104; x=1781570904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=StLjLCmXgF4Q/Ry3fnTHjp2FbwAsDgAHQZYkD5rM9oc=;
        b=P0yHBx+C1xVV+S6q8DF3QpNF2JZfGhlRDiAOPlYC29qERfa1ozh4eNBU902QdOmjfd
         oc7eJex/AQwf2BN2uB649ODJISdEdEBacsParxwbDjgMWoWNZLwnLobB2RHtAgTtIJgg
         R5hGnhQHaMxamLxWf4oyX6P4loV3gPCZdT/PyKOPdOq6x7AjQgZzX7iOh6jjpQhntjY/
         FF0lDGZnKbayApMcikmT6M+uR9r4HcmsqaaD6JorWmuYKs7HVYDru3l/EZnWFRjll34C
         C9VXKC8amlWxNh0p9hhS1Hk0uYQ7VjtA+Kr8eruFOchdGJw7e+/FH45QXVw/3Liov2Ki
         T8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966104; x=1781570904;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StLjLCmXgF4Q/Ry3fnTHjp2FbwAsDgAHQZYkD5rM9oc=;
        b=QbS3E6TwdKSZH7VMteBtWhCOCPbfXXo4GrpLPbgGJl7kawq/0BSOmImtBjdocd1+zV
         tYkBep2hzOMsHJRJ1fHxMJLWJK/qvs8w/LUZj1j/p06NjDorJ5luMiIZa4Ma1Zxw0iQj
         M14FMW2CZ3eHypZcQ0zeAMvQPtWmbJXAujIJByckimsyzUx6jRryAYVDnR5RGCWfHjrS
         yBsjNZV7P+7KLvRhsmgEktFBSlN29k1nSeCVmIFSBhnF2C9C56e16i1SNN5cNZdm8y8k
         YbbkDYcYYdADLbs/TA1g7c8Quomm65GdiTMvA+QhU7C61rddPbZLkmCUkCgH9IQeBcxm
         2U/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Lb5/WhUHlq4QnXE1VX0I38XhxAFh19Z7Jlglmj9Uphq+0wPCrYSDgIM+CWXJ8p1qbQPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GyrOTm7gEY3WnL5fZDYW84xjzvJN2lGUAQjpOvNVMz4ghIij
	bLCG+E5Sjl5HTVzmcHcMJmNjenUU6aQDbu+hO2EYthbJfbSkJpBuzN33cjp0ah0gOD0+1nyF8Ow
	y7w==
X-Received: from pfjd3.prod.google.com ([2002:a05:6a00:2443:b0:842:33b9:bdf8])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a201:b0:842:6293:fc43
 with SMTP id d2e1a72fcca58-842b66aa645mr12846516b3a.15.1780966103837; Mon, 08
 Jun 2026 17:48:23 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:48:05 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609004809.1285028-1-tavip@google.com>
Subject: [PATCH net] vsock/virtio: restore msg_iter on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When transmission fails in virtio_transport_send_pkt_info, the msg_iter
might have been partially advanced. If we don't restore it, the next
attempt to send data will use an incorrect iterator state, leading to
desync and warnings like "send_pkt() returns 0, but X expected".

Specifically, this can happen in the following scenario, triggered by
the syzkaller repro:

1. A write-only VMA (PROT_WRITE only) is partially populated by a
   prior TUN write that failed with -EIO but still faulted in some
   pages).
2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
   buffer from this VMA.
3. The first packet (64KB) is sent successfully because the pages are
   populated.
4. The second packet allocation fails because GUP fast pins the first page
   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
   permissions.
5. The iterator is advanced by the partially successful GUP (68KB total
   advanced: 64KB from first packet + 4KB from second), but the send loop
   breaks and only reports 64KB sent. This creates a 4KB desync.
6. The next retry starts with a non-zero iov_offset, disabling zerocopy
   and falling back to copy mode.
7. In copy mode, the transmission succeeds for the next packets but
   exhausts the iterator early because of the desync.
8. The final retry sees an empty iterator but zerocopy is re-enabled
   (offset resets). It attempts to send the remaining bytes with zerocopy
   but pins 0 pages, creating an empty packet.
9. The transport sends the empty packet, triggering the warning because
   the returned bytes (header only) do not match the expected payload size.
10. The loop continues to spin, allocating ubuf_info each time, eventually
    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.

Restore msg_iter to its original state before the packet allocation
and transmission attempt if they fail.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
Assisted-by: gemini:gemini-3.1-pro
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c490..588623a3e2bbc 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	do {
 		struct sk_buff *skb;
 		size_t skb_len;
+		struct iov_iter saved_iter;
+
+		if (info->msg)
+			saved_iter = info->msg->msg_iter;
 
 		skb_len = min(max_skb_len, rest_len);
 
@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
+			if (info->msg)
+				info->msg->msg_iter = saved_iter;
 			ret = -ENOMEM;
 			break;
 		}
@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
-		if (ret < 0)
+		if (ret < 0) {
+			if (info->msg)
+				info->msg->msg_iter = saved_iter;
 			break;
+		}
 
 		/* Both virtio and vhost 'send_pkt()' returns 'skb_len',
 		 * but for reliability use 'ret' instead of 'skb_len'.
-- 
2.54.0.1064.gd145956f57-goog

