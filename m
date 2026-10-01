Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20618BC3B
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856971; cv=none; b=dCfE31268aSIqyYz7YEZXTLPXJhneS2rYz9Q2o71aRWKPWVNVzd/t8MGvKyaNgb5ia7S1lt4uxHGEhDd5nNRJz0D4Y0tlkpq9i/85P5RETS64zVjB2AMnzwhgqwDqk9nyaeYoRWWo9qlt4df/76tdSpycVleRMCuL02pJZZtV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856971; c=relaxed/simple;
	bh=4BLrtmzurW8UA6fVSeNeIt87jffuF6uA+vo/13A2Om0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRQ5QkzcDW0W8zeyNzzKwDxYcKLl2uIizLYOwo6PvW5V++t9l5q/LwfvgUaj3oXE/tkBzTn4nznsTvyaua/VbNKVFpuxoOSSYpb006ORMDlM7BSMrDvN7MNADiVeSVDbejUiVd15WDlWs8vF5/CVLbz9OW7HUxpYx2pkBuH9pgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9i5J00o; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9i5J00o"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso4620641a91.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790856968; x=1791461768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=P9i5J00ob5YP6/Lw91kRYaskxWPp5+F73cSbLXenZS59Ltm+e41c7CEedK6ioqvK1P
         FrWzi4BKQI0xHy6bZ7JkH5WZHmQABiEDfYGVmqfbWeuK6GXbe3gJcaOy0A3jhqJHaTI5
         avW5CM9he2c4PYQJvYVVmjs8mpqNIbwM6nf5zQtUVl7GTjZ9oHPbxv54IsYl+LM3rIYo
         41I892hhxHw6EOShD//781Iw3Juy044fPMUM2Ud4UlKa0OeGWeqQGhfK7z8wkiNqIbiH
         jTWQBhbZGUjfj5rJqi7CxhINBe8Rh22i994181q8SD74DgaguIbuMHxi7NlMR+vcBz/D
         1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856968; x=1791461768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYDWZrZ8gM+j3CLV2m4lS/hjDIinyiJ4OzY5zDftFc8=;
        b=C/nmJrcVkiF4O7/BnHfK89gVibFhXREMsmX36Xtfq8F8EZkKLO9+PF8+ddT7o+Gtny
         Jj+zhNVV63sybqGeik7JH6YgOJMAGwCfFwXmmGY36PCDR1JBwDCpJKIZ3AzSH/0TMTJZ
         pMOVqGX10WqhUn/vO+YFHm0Q8TX6904vQqRygJZ6NTz3r8VYkBEm5F6DFy5g9rHNHdD4
         /EOHZJhvIUscQIXjZi6lRpNxMTHd77H/Q+Ku59eOF+sxQtlVswP+R81WbOAIxI15Yj9o
         7cKb/uKUq3yTyVmDjoZw2ddz+R7t3XJrZ1DuSmo2kSEwLuwc/IhW3gzkab5YQ9GsWuya
         g3OQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+e0LCz5VfFMvdQdkCZU9/17i7Pz7zEMUZDEIxs3nsxeN+PW27n5d2k9my3hgUxAlah44=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmrW4ImAHinWCRMTfLJrS3KdrPCj29ccJJvUgzG69MpBw3HCOy
	J4aZOY3CgdsIk459gnWsf0QWsSstHiJsRxu6d1hKFbp4IYFBp8BofEwK
X-Gm-Gg: AYBFou13qNaA4/Au6PEOhpG+sOFRcgWZVJhOB82O6yw9C64ZSsw/Ji72DF6cav5ghE6
	iE7rHC4xhpwhwNf8EMX9tSkHJ7dHqVOXHp8HVCzFMsT8+DkZEolbI4xhQp6GtTHfywFQo59jEfH
	qc1OxnX5c+WGcFJ1YRUZ1A5oHZLBPWeresGf4mGmZ8k/QZmTuWMmPTlSuyW24Dgy2dlEeCeWDps
	MJHQOX+60pQXoFj5Lx7InqCDI1K9ZBtlaVLHXxcBZVP47eh2/rr9rukcN7DHjSUtHSSXCNn952/
	YVZrLlcZBCdASAcQm1J4JcqfgGKsTzhwUXYs3Rnn5sPJrT5Le6vG6meyercpQKqfAsUBq0KoFyO
	lQ2VtU1zRxil4kor7QM7isl0sNxKy5vPthvs6O36aca6A/VD6VtL93U2WYExD5GJpLsFp+Ik3+5
	X4g1ApORc2T4UyR8mykuf5hirMp6N21bGLUNX93kgtWra/smQF2L6a3Lxq/u5vGXHOL6fR2HKmk
	CXagxKOrh4=
X-Received: by 2002:a17:90a:fc47:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-3a4d102d65fmr3985879a91.7.1790856968300;
        Thu, 01 Oct 2026 05:16:08 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f43c8b02sm4352278a91.5.2026.10.01.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:16:07 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vsock: account only unread bytes in read_skb()
Date: Thu,  1 Oct 2026 21:15:41 +0900
Message-ID: <20261001121541.2983379-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a partial stream receive, rx_bytes tracks the unread suffix while
buf_used and peer credit still cover the whole packet.
virtio_transport_read_skb() dequeues that packet but passes pkt_len for
both counters, underflowing rx_bytes.

On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
from a 100-byte packet made SIOCINQ report -40, an empty recv return
ELOOP, and poll report the empty socket readable.  After verdict detach,
receiving 40 bytes wrapped the counter to zero and hid those queued bytes
until one more byte arrived.  The fixed run kept the counter balanced
and exposed all queued data immediately.

Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
full packet length for buf_used and peer credit.

Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index f225f53ed4bab..1e762a480df49 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 	struct sock *sk = sk_vsock(vsk);
 	struct virtio_vsock_hdr *hdr;
 	struct sk_buff *skb;
+	u32 bytes_read;
 	u32 pkt_len;
 	int off = 0;
 	int err;
@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 		vvs->msg_count--;
 
 	pkt_len = le32_to_cpu(hdr->len);
-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
 	spin_unlock_bh(&vvs->rx_lock);
 
 	virtio_transport_send_credit_update(vsk);

base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
-- 
2.55.0

