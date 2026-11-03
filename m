Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679152;
	b=AC5+JtkP4F0wfV31MPsKyHrUcfBPDzWP+CtyKaNeKC6T/iQF6gBgmG9cqZywVGjxPw9c
	 E/3nk3jodyBfOyIJOnWnZrJoT5fuHfHRmXC0mlZwOxmvLTBFWZvcisfLckcjQCRaXN4wn
	 XzNCrebYVdEww2D59rdRH3UlPUu5V5bWwl14BdMHSyPVMBW3FIuykyeSrbV9xoDYaNit0
	 b5ge8UsyPc3wFlKHbVVehF/6e55Ew9NPr0etEYnmsvFCGiXskewp7AXprRedqL3Q10Qdu
	 y6Qt88ETMjhzFc0/4dflQ+coxiHdil+B89JYRiMrfvZz4V0Uc6jF+1d4kMMU1oAi1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
	b=fMLp+YTL2wPs8WJ8r2zz32NW988C0v5reQ0T1wYX96hWysE1TYTA+ARwvq5AXGvHAsvH
	 U1XDhP7nn6rz24KETyaiuZcxZba25k1IkkmTcuBW8Wr8aOcXiM1SfzSf1Rtf9eox8Uqcq
	 2uYermqBJwllhZxakPMBgeCcLbWpSTWoEEnR0LNpeonFSa01N+RBFosWeRT4PWVWvYwni
	 cGqyy4Z3hfJruHULjU9E5wBsbu/ath4uLgCrWfV1w8h9sAWEJjuUIjiwt2OoVdQxuOC6z
	 XpGf9oNFi6foqxfaEe/SsCMIu7MklCEgst9xvCYldMjvent7SC05iJAgja11IuHH8nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzaUTNE6;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3D606A32C
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 04:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D3D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yzaUTNE6
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so3131568a91.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679152; x=1794283952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=yzaUTNE6F6RJplgdhN82dhJZSzDhQ06QB5gPHmzagXtVy27eP3PELDsWY0W7jkkuHZ
         ekd5XdsvxVF032K2Gi1sp5KhDd0CBDv8vk6F1bg4wUuO4GzlOANZtOvINeO+soGra2PG
         7RZv4zAGkd0Rhz7TwXZtQHtri7lxyIdG0POr0yrjAj+qqAjSLwvsxk8+bFHtk3W//8dl
         yIxrdXZy9Q7MDJ3SkdspAPwKtjOhvzaCAwTNJG0e+9NUE0BYMZSr3jDljs2PlsUe1TRh
         lesKrhlCR72x63yIrZxo3eNy3YD/zJAOzgyXvrUoQmMybulJuN33+09brnDRblX+jwNt
         becQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679152; x=1794283952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YqasG4hoa5HMln8cuz36jlojNM8+bH53t/aSP0CVnp8=;
        b=O/C09O1zYHnitQjBZu4TAmbgYzVu47bkvSuhCcx5/xC+QExb+OkbvQ+GUfSvflYbZl
         Uee64PBmcBKmc6O93SbHOWAZ0ZmiuBd1OaKHU6/aGDx8BD6tCsGkR4PbH4AQuw8Hw8gw
         J0H5C1MI5zQhkMSvHFWvYClGPNw9EOpgzbs1+3V/yU5hzbrRFgEZmblKOX+kb5bg5l55
         tzFLGLjcw3CzQlXrtb4TjUOZ7fuw0jY1aN77s8C2bekby6ahGEwKjFXCFi34oQ/ZtxSU
         fv/KLKOv+BFpUIcOj24wHEDu2dyO8f8+BSn9rfDjTGOL2m5KsssIsYVAjv3xRp5tKmCi
         I5Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxFeOUcnyj26AbMrDIN9MQ8nwTRxwcWlayqQ2PoAR9OB0iE2YoAx6fKvGEmLHc19/ElGBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8izrp9mVwAjRqbRY6HL1/6h7uFsdk1d/mqkdm3IZjzNyyPcrck
	AYgX368fyp6CX7jzlqQkl6pLcjp16nI3wSZsvREyKhZimIOW6ZOwTPHl
X-Gm-Gg: AYBFou3QDpfYDfhrg/foQGIfnzCI1Gfg93HdSpx70v/USM2ULXovC+Slzqc+qxXv514
	TZrTxZafjys6y+5o8kgylPQZlPw0laGJ3Bb4jdANt9XnqNvamX5LTrZhTNjj0754vnP/9AydF2d
	nP/3uCj45pENrvPoeI07NZOHXLOBghnOw7TUWG28p13EA5lM/4b/W42bWNDF7IrQpZoeXnLuunn
	gb+buTh0or3gCXrgRoulR35lNoQlYzl8nZ6yptPFG+C99k3VZJOLYoeh7QFLpCNh622n797+VZc
	ikBglQHYWcksyGCKUnrqOhlKk+mAv2qbdow3fRY3vKoJyBPBQKOe0bvStxWjEpQ1Tfha3siYBCS
	dD9dMWy0H7KIwvZQsWomtCb5dUVSkoccSuvNljysbXFCY9aw0gR9o/s/Z+faE7t59hzUB9JlR9N
	77meeA1+vIduo4pl+A9L3DV0VqUq8xMoVtd0Eroewkawqhc+OVIUF2Jm8mtXUJFXFjxIOld8few
	7WMpU6xI+Wt+CAXjoPLt3AT8kekn7KoQa7G0bo8mJP2LiqMZfCcFKeFye3VDtrhKQ0yNq2V01M8
	oFrCKual
X-Received: by 2002:a17:90b:224d:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3ae897eb33emr9769580a91.21.1793679151782;
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
Received: from gmail.com ([2407:cdc0:f00f::117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6f010asm1941708a91.15.2026.11.02.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:12:31 -0800 (PST)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata budget check
Date: Tue,  3 Nov 2026 12:11:31 +0800
Message-Id: <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103041134.33310-1-physicalmtea@gmail.com>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
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

