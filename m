Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E139734E
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743323; cv=none; b=aaFdOfi8oQ7+2XRTPZrbOsloLFthUAenEd4Gl18QabyVRDUytikRb4p85F4md55CZIiLRslUGWlk5CouDqjwRQdZPtzRTkmmYhMdCCe7cXXG5LwPVcafhFWHKpdCYVT8jLF/Y+LNHH5MCK4lRlbWJsr90SkscSl50Aijs0HMB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743323; c=relaxed/simple;
	bh=hVK5ZaKV4XKlAN+5/oG1cx4MwyE5N3AwnSgb6VJtQF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Go1q7ZozDhOrGID9HhaQ0De/GgnsF1i2MyXy4dqAQg1uHztVepUmTK4Sa9KHsJURbSxiUxBA+zsNBRrllxaibEy6jGyOZKBTY9SYF7UoLQe1uvCIow06tHuvEe4LNIx8ox4GHovL/o5bTEB1sZFubI7S4q4L/KEzNSALvUNlB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSZeBCac; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSZeBCac"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso31717975ad.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790743321; x=1791348121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=nSZeBCact6qaShd68BNW4fkcVF1wCHtyXGtdU79kJo1OlXmjB2UPcSPAfmzmsXZBaO
         3diFhUCQqzM4QoysSPzKyp+bi2fpghVWOyxt52QPbiX380kQOxqxVVx45pCDnoQLH5MU
         8Pl73CDaK3M4h1ikjiK9zNfMpFNV0eoC8VOv5wIq702eZ5NkAee4EgJpWbJ4CXehb/xy
         z1TfOK9AwTOCF2OSauAt7NLpAAkrTjauJsQse1+3saC0mIWG9FAwdyC9+OkQUH2Lz+Z9
         eMtyu4r0Z6AZHsLlqCm1w0jJISTzwcc8kCgb1O5PueRz1ilf3c9UwQTQ37cnxNc/nErC
         XYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790743321; x=1791348121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ud4fTEqxQzrUTwARn11POV1Taqipw52FWd2xdX+lQEY=;
        b=OqkGyO3DB24wHfSTXux/ofAMKUKQo6MLF5PmMIh3jJ1NmLIVwZxUC/IgW2Eh6BLOvb
         buW2fM/Y/+vdO03Z/lq8jPfA1wexbiEE46YCOdQE1BExfo6TxQpRhivwAogics8dcMpa
         YehBvouEftjuRMSInCO6wbfwsMwS9J+Zja72VYfTnMiDNA92lw1Nrre7D9pCSyNZLJ7O
         1Lv5DETwMjuTLhw121709StzbQVmVjtRijdgHALIKGL5hevtVdV70s4riR/emkQR1v2g
         xWWaQO/JyKnNJt5Q4TIUx2fOY0AxHWyLV7xQt4chLJquU/vyrZL/clHrN0PG+7QO8Qtr
         yFLA==
X-Forwarded-Encrypted: i=1; AKwUvBydtxvISNXE8UcdF0d2luSG2iYde7M1W6TslzJ1dCtrpOWkKKOlfAzhW1obCaub1FL2ff0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLO62UIiNPOyvN7AkBUHM4uH7t0JtCANdXmR6eqXRsCEpRxKYEG
	8LqeYjTFqSnnE2NsDxZKzZZIXKgWaP37lEnzSiOJ29n7cqoDQqbtcFwf
X-Gm-Gg: AYBFou0mfD/zi11+JKSP9OhGJ1VoJR3IgGy48CYjxG8rMmjtBiThmgNx2e7VNvwRsac
	/dXuUIDhOF28jDyXU3djOMOTWacQqZ3tUeR13Jti+zsY+gtP05t+C7lHn+pdSDCklGPH1OtiZk5
	H1ghqmoDSTdzlMJrvy3rXp48xFLVYMQ9tPlJ1HuBdwUB4uESeqJEwcLTfXVUEyL0cxsmclm3om4
	I1lpAMc9TjlN/DpsS+QQQp6alMsH/c9Hl1kARTtoC2xuU6HiAD7iiFL2zGxunXO3WkDiTfRAWHD
	wYHBCFZUv/0AcA2Q3V8pTRZXpWohNuovvW+ALbPnNIeD/zQdQOs8xOn9Q+h4HFZyTkhfQbZKyXL
	A03Eq6nngCE+XPQljM9mgYquqZYiyKWG1nlSQTt0j4N91luAtSffCpJrch3yQXJ8GnFjc6UsmHm
	sDJJLmhAAdqg6TRsl9J3XStApLgeLOX16K0yBEdLSAg4f4JqaKh0OpG8813nkfitNmOG5RFha5c
	LStRwR4aO8=
X-Received: by 2002:a17:902:ce90:b0:2df:9eb0:761a with SMTP id d9443c01a7336-2e2e4a25a1bmr2167915ad.25.1790743320928;
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5b89c06sm538155ad.24.2026.09.29.21.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:42:00 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
Date: Wed, 30 Sep 2026 13:41:45 +0900
Message-ID: <20260930044147.3818241-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
length, while virtio_vsock_hdr.len independently declares the payload
length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
for handling large receive buffers"), large descriptors use skb fragments.

virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
skb, leaving skb->data_len and all fragments attached.  The zero-payload
fast path skips the helper entirely.  A guest can therefore retain the
full descriptor allocation while receive credit accounts no payload.

On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
full-payload control retained 265,984 bytes in four skbs.  The existing
SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
descriptor-sized fragments.

Set skb->len to the fragment length before calling pskb_trim(), then trim
to the declared payload length.  This releases unused fragments and lets
skb_condense() reduce truesize.  Move the zero-payload return after the
helper so zero-length packets are trimmed too.

These skbs are newly allocated, unique, and have no frag_list, so the trim
does not enter an allocation-bearing path.  Keep a warning for a violated
caller contract.

The fixed v7.2 image left a one-byte skb with no fragments and reduced
the zero-payload queue to one 960-byte skb.  The build had no compiler
warnings, and the run had no sanitizer, WARN, oops, or panic findings.

Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
and CONFIG_VHOST_VSOCK.

The source reproducer is available privately to maintainers and is
omitted from this public AI-assisted report. It exercises the real
allocation helper and VSOCK receive queue from an in-kernel module, not
a live guest virtqueue. Guest control is source-confirmed, but live guest
end-to-end validation and deliberate host OOM were not performed. No KASAN
splat is expected or claimed; the oracle is retained truesize and receive
credit state above.

 drivers/vhost/vsock.c        | 6 ++----
 include/linux/virtio_vsock.h | 9 ++++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index abed1fbcf66c..fa59456abda9 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	payload_len = le32_to_cpu(hdr->len);
 
-	/* No payload */
-	if (!payload_len)
-		return skb;
-
 	/* The pkt is too big or the length in the header is invalid */
 	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	}
 
 	virtio_vsock_skb_put(skb, payload_len);
+	if (!payload_len)
+		return skb;
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..31358683e23e 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	DEBUG_NET_WARN_ON_ONCE(skb->len);
 
-	if (skb_is_nonlinear(skb))
-		skb->len = len;
-	else
+	if (skb_is_nonlinear(skb)) {
+		skb->len = skb->data_len;
+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
+			return;
+	} else {
 		skb_put(skb, len);
+	}
 }
 
 static inline struct sk_buff *

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.55.0
