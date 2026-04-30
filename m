Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AD1A5B84
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533118; cv=none; b=QwTC2JgK7/i53LLbw7ztihdWcGj7UPqRn9A18gqmuEBZ5y1BYEtT5gswWT7kfQt1Dif6S8BQdhHqbNGVYI68uGu4UmuaezBt1jmu2Q3+gZ2N0r7q5WvetyXEz+cBYsVB/rV0MaNWhI8Y+pVgvCT93fouQvaSZ1AW1Klf+/qe+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533118; c=relaxed/simple;
	bh=WHf7SDMWeGDMepkYHsY68ydsCu4X3ZfH1ZKR959neqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXAdj3CRyssGwe4bHF7o0Q18cRtsWLIrGjuIwUl3QfrAGm7zSmV8PBIq9EbzfBSecn4e+oRVVYSU7tm3vvSc1EN3foB3Fx6pfXrfUFdQkEVexycRq4G3M8Bt1QkQk+2+vwc6PFiTuqeNKpPYjOvDwRxqVBZ1f7lMbEZetfjlyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnWnp9RC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnWnp9RC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8244105fa96so21426b3a.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533116; x=1778137916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=YnWnp9RCggRjEd1Tp728h4tXn6aq+rDoBV3L0sPx/93PFdq6nNMYNoit4r+v9vlozK
         /UuY+Qlys+AU3QwKYKeV/33VUEM48+oIKEQ0iOvXDfJi4U0Gl/L5i5WRw8D8FfW6Jk2p
         SXMuQGVVnHT8zYiWDi27xH5VSlhNZJ3hpUIjhcgo6a22wYELgkGJmpR8XZ7iTWleYwOQ
         aIOpIqjqP8JDvcyOdjkAzxrgazxgOQmHWWC1cC0hhxNGEL7HvcR9xFBCOfuUKIOrFTTG
         1a1He56B5Qeu6h/CWxXzbod3s3GLvUv7mvBmGByw5LqCDzG8th5UxpYT/d4Usx3K8w++
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533116; x=1778137916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=qljK2Ev/Cy8Skrlc1kk/U9097RkKQAsKqllNBxC1uddQ1f4E16DWYD9Py+nB0vJwui
         6W5y7vmInpYfh0tXSoxX27mt09cpEE2EfaooipaFkIxQVkkpm/or5rmJChSegRzsz6J4
         efG9X8FP34m4IR40p/mf14w4O6Vx3Td7tPUwzyRdgd3wcrNk/HaDnUMJSsT8DHH+s+9r
         97CilgvwaJlUTckH5y8VW5M92jjthKsSLQIyALojbEsmddbw1U2a061iFr7WwGEfTZ90
         CZ+kTJxV2fC9PhV//6Hlbv4cRrMfzfAllkCPDLhmnBqXHoYAc27kBlA4JwFw4VO86/H6
         0GEQ==
X-Gm-Message-State: AOJu0YzEqoCVAijDm8HtWj8a4wEv1aTR0mb87mV64FYfKmku9ZXQ4A9T
	/7nJCYSbUZhhlcEuUJ8jTEWXcSesOc4g4FJ3ej9774hDvv/L6Pw5IbUIuW6NgwhJw1I=
X-Gm-Gg: AeBDiesV6p4mnvXnZtwXq5SvL1ifLTvVolrY3EpDV657pYS/9A1sk9Rjzygk0HBzEaL
	/Vk/BYcLNVsan4bzsEezeYHVgHOxprxHySJlPns6FHav59EpNBGqhk9749MssIeLUECNb2+s/yz
	o8ADB9VR7i5ZkSJizyryaOl40wCepw4/9Z4nodIatBluMMn/h2dlnr94JsDFhJomhAf+p/j8XgX
	HR7AcwIA5z0hmxArl6vrK4ydfMbpcpsNkQU+5KxvmN4Qo2CggQFKJjJOVkofAVkNKaRhc2R1Fim
	SFB48Ly2frhL7+dSbuUY0ptd33AMtjg2gAT8Vlxucqw9Y47081JeXyOjwBpLNay/lmIUsj4bwX6
	YoQxtDvMu6I5mSgkcH6Xk1JEudvovTQczR5oK50sr9Qa5AxOZJgzrBCg6e79aGvWJO4lzER2rum
	5nCGkQVrdrCWBtuUQ44/8H09ONbmU5j0PXIuAJtFjWJ6I=
X-Received: by 2002:a05:6300:2208:b0:3a3:18d4:2590 with SMTP id adf61e73a8af0-3a3cf70d02dmr1041632637.3.1777533116186;
        Thu, 30 Apr 2026 00:11:56 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7ecf57sm4049605b3a.50.2026.04.30.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:11:55 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap copy
Date: Thu, 30 Apr 2026 15:11:10 +0800
Message-Id: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsockmon mirrors packets through virtio_transport_build_skb(), which
builds a new skb and copies the payload into it. For non-linear skbs,
this goes through virtio_transport_copy_nonlinear_skb().

Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
As a result, skb_copy_datagram_iter() sees zero writable bytes
in the destination iterator and copies no payload data.

This becomes an info leak because virtio_transport_build_skb() has
already reserved payload_len bytes in the new skb with skb_put(). The
skb is then returned to the tap path with that payload area still
uninitialized, so userspace reading from a vsockmon device can observe
heap contents and potentially kernel address.

Fix it by initializing iov_iter.count to the number of bytes to copy.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..6b26ee57ccab 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
 	iov_iter.nr_segs = 1;
 
 	to_copy = min_t(size_t, len, skb->len);
-
+	iov_iter.count = to_copy;
 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
 			       &iov_iter, to_copy);
 }
-- 
2.34.1

