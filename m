Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741919;
	b=mX9ICptKP+Z2E9e0AbL1yql8zYko6elm37+05ho73Bx7in3MC/qGusrI4pP0VebLgkRX
	 1oeEOHDCBKG7tpFWeiG+cCDUXTv+eDoHAbFw5IdBGarP9bQNZ7bnTgXb+wfDCOrl4/Dt+
	 JGGsa5dqejCFnaiQhDD/Bw4K11ilDjOd0mrCXTVU87vlkuS8PpS4IMJtp4A+HBw0NgvN7
	 WE6QHIt13HaKVoT2lmpnDts779so0+n1ZJdgP9L2yun5HTmJg+zK99fscwvhkiSY+RKF5
	 ats37VM9h3GmREpi0RqHJNJWU/Qh72wzQHx+QhIMtUVZkvUyMDeBp3ozZIbXHwQbZ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=cqAPkYurh5feJIE12OgXjHMqoyOXWQxvlYtBTUVJyavrltR91j1i2EaomWTv7CmF8o5k
	 llQKYPtlizi40ohRC27M9dBel2AmjKtFDIuHIhTnDq9II+W845bAQNG/ONoZ2dhE7Mew6
	 NHborZhA4Ayxmtx+uDEfzurf3tWul/Ys8eB1u8LDsB2r7w0wOreKi6sbyf9GJWoQOMsL6
	 0mdDrKy3l8p+U+wjSTIyyuvd6laS1tb4HUAKkzb4G6pK4YvHIiNH3Zfthu61Lm3TpwVWi
	 dH1PymVB1O3Jpjt20OvcskoUcoSCPiMZSuyZBCtUEIsLVsDHZCMb+BrLf2Xf+jwCqmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RACWuQxq;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80C606A31B
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A80C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RACWuQxq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9eb579c0eso2889095ad.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741918; x=1793346718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=RACWuQxqcNvxZdCaZkfaqIrUNiPiYMBz5+g6sqBaI+yYIWvMYlPkMnUBWaiKQID20f
         bh2Cf3hmYtKlRrrkw7TbIPZRI+BPP2zGFWKj57/PIlqsbw9+8Haf1V5bs5dDRM96eNJc
         oQ7+LK+uvdX85peHEnZ5eltX6FH8J7DGBj+3uPXtWNSXuhwKtd9VIsIbAVlppPnkIJ3n
         lgUYHZJsb6OxDwAXLpzlISBSrzFyrRUa2GPhpiP1Vpce6lVuo69sPz3NKWKb0s51L+gi
         M7UPzlUqfiH0Y8WvsePP3dfmCqRC8Jv+OqfolzDJri0D3izC3LaPXwXNovw6Hp+QOwi5
         vRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741918; x=1793346718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=ctt45c+ey/VzF1d/jGJd3c87rmHAExfW+FOK2BjnkRXSJemU1T3UK11g/wMkpnyIEu
         MhoIbeE3V9j+gpjfQ2OKGqnnOg1FavQWfETbh+p3aqYt74Qi9Lcq7SGQj1xhRxA9eb3+
         Zdvqx6wlLuRis7LR/ykO+nmzCFgCYDtlwaEOj1lNFoz+4G7yiEZFb6R5P/p+lEV2rVN+
         +wqr+GN6hwRbkvEqdg8ukRmo3UfdVHw+Tb38p1lJbMT0KJiTnewD8y41yEusCwKtlDVo
         Uqw9JOJJhe7OGBHJXrXwTTxlJCHQVkwFTi126m+cUP1TCu9t8Y5s0rHuub1cE3UWUeRP
         yd7A==
X-Forwarded-Encrypted: i=1; AKwUvBxdJEJ1NI1Lzi0twR2iKHEYbO0KDdpy640j0kQofhkMkT2aB/SJXLworENC297PXXPey9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZ6ojK2QF+K/3UtSDfLAoGrEZohf1pxuOmU8QOR4vVV6Uhjt2+
	W/Fxbz+sIMU4UCeXKLK2+8jY2kMWQ/Rr950+/JCr9ZB474RMjtbjOZXb
X-Gm-Gg: AYBFou2RytTIB90PomaHBO0AUvCOVLvlad7A+1YHOSPLUcpxWt/+VopI2HmBAG7pCl2
	gNazQm3x9VkAmcDVc1PNXcPR8xJl1QUanI92qkKTIA3ga7zsEOxujj15w41a6R4C/QgfnAK2Ifa
	MXMwPdog17bO2ns2Qrsml9wB3b9CvjKnUYoKu+aBh4q8ekJ1YFItpP46QS36GwToyt3T9VhNlzh
	E6dq0/StX9riHtjNrefQZ9O7zFcPoX0jLFoS72O9NMFLCMau0082PK/8INnUgNLGLRLDZewDVGc
	0csTwH1K7DMjE/uvhE09EBQfJKM/k7nvfyVRirUYXDgONGRAmxUDSZv0atQ0FbJMEm/kljxHMmZ
	erF49kuhDgFzmBJWvyG7JIn4V7ipm6thgflgjTMuRpDrHoTV1a7YHpv1OgbjJ7Sbfwhteo/PH7c
	gJ6cyiFzqK0BWlTDq42EiLE6hllWb8wBumB6OardZysOisMAhPeyNPcMGH7ysb+jnofzOMBO9uk
	zObsMkmXe2i/tE4KHQBfAFjL5vN+qXM8n8QswNM66YhulkAqDuuChce80z9QATKH9gl9MQKEF7x
	6eE=
X-Received: by 2002:a17:903:26c7:b0:2e9:6be2:1296 with SMTP id d9443c01a7336-2ea7c330b3bmr15087225ad.56.1792741918158;
        Fri, 23 Oct 2026 00:51:58 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:57 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Fri, 23 Oct 2026 15:51:37 +0800
Message-Id: <20261023075140.9613-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023075140.9613-1-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
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

Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
into virtio_transport_rx_buf_full().

The helper retains the existing condition and will be reused by a
following RX batching change.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 43325d7aebbb1..2a9cfed085515 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
 	skb_queue_splice(&new_queue, &vvs->rx_queue);
 }
 
-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					u32 len)
+static bool
+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
 {
 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
 
+	return skb_overhead > vvs->buf_alloc;
+}
+
+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
+					u32 len)
+{
 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
 	 * metadata. Check payload against buf_alloc to be sure the other
@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
 	 * queue growth.
 	 */
 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
-	    skb_overhead > vvs->buf_alloc)
+	    virtio_transport_rx_buf_full(vvs))
 		return false;
 
 	vvs->rx_bytes += len;
-- 
2.53.0

