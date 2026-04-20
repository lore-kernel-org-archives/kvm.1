Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D13803DB
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691262; cv=none; b=cFs8xfNAaqOrm76TPgf0DNOM0BOy99VByNTad2ak+G31KDhXnzwyugfdToLw6fiqMGGOclBXi9C6UWMX+ces9FTB3PnfhDdi9CQ1+ingef/gO1DUJoO50OLlUt7VDpbQD1H8EuthZVY7F6/qKehrdXFzk+kfwvIn6prGZsnr9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691262; c=relaxed/simple;
	bh=oRz4R1uy7BvYcGv9q3SW450IGK8oQQE9HdAqw2IRtxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gb9bu577kXvToGxZUjktsDHNZiWWZ4rT1k5zAFCdqgMveT8ruJ8R9Sf5sNyFuurPYNpq6GeHewc880l2CPcbiae30S8lNXmpqRG9+20fK0MDq18YJpZSQQnUGVX21oyi14v8SiyaFCLfy1A2rtI47w+rODoU8UiPOFAe52RoiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XY6/zVO9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fF4+aoQ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY6/zVO9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fF4+aoQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776691258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
	b=XY6/zVO9HQb6IhjAWwRrK1wocom4m4QRTATqpSzKFJN8Zacxin60+pr+hgmgftbf2jtcQu
	uvmS23Th/qe3K9aKdxQRdu+iIZB5BwQ1Jerdv7d9floS0qsgQVYWvor6WIy9jJP0bk4IT4
	wcjjuxjNnLDRXS52iymtsVufAaAbwgg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-4mEdjEj1P5qVwb5PU3Iedw-1; Mon, 20 Apr 2026 09:20:57 -0400
X-MC-Unique: 4mEdjEj1P5qVwb5PU3Iedw-1
X-Mimecast-MFC-AGG-ID: 4mEdjEj1P5qVwb5PU3Iedw_1776691256
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso2291587f8f.3
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776691256; x=1777296056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
        b=fF4+aoQ9ORE+8pfPTrY9kG7rar5FYNikC4i9K7e0v9tPpt2C5FwkWfyCfPEEpAy/pv
         CnqLM1jYEgwYtHevuEjNDYqSqAodtWChyk5m61n7ozsaDQHwZ+kDnFi7Ef8eJ8sgYdGg
         z8M+U5LvhAsDLB7uPTBuwO+t1vLECvG33ptkZ0XDMXvIOEug+vGqCRf75K2pDkJQUHnZ
         Fizh2cBJkn4MB/iuOw9ZZXvWmKYZzrknCW81lUBhtDusJTfH5bvvQCvincWxjPpmCJwp
         FfjxKXmroSm1EPN9FnI4BOBNRlmKkX9PemriunFoGlTJ7F7LTHhQ5Z4aD+WeImQehbPa
         d4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691256; x=1777296056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNw8VU2wHUCMW8yOpvKsEhvAEIS86OBEtLoYfE3AKWY=;
        b=o+DqS9V5ZYJgXtwxm3Jue75Op6kGUwguefgx7CAS4mTBUpyLU2qfMKK0zqr0OwLezA
         dtYKMNJYLWPEnEmKZya4K2kMyAOPyxYdzNPR6Kkfjda1C3HwZxkpRG6wxcH10oV+3WhH
         rtCvYM9VBzOAsQZ4IvvH6cd6lell/y+QC6lRbpxSyNYgTwcjOxLOJRl6VHZUA1ZsTGJm
         QtCYtvVVOX/mfHvsiYoZm4//4j0fm+Aj7nz9wmu4E4SpKeW/i4PxinHJ+c3xmd0UuAA5
         D8vYA+USNoNvuArIXHSf8jpt4B+Wnm+BDmNbv+m6IAUDvBUVudQcmeJ4s5/lTGioaWw9
         xMZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yxzQitearFpUkX1DFBs+Yotsl3VKpFVH3KKBEzmOQnipZ/obytABQfIrgUzZ2txL2TTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTGeDQyE1oQHGL9bOKE9VwOf0VtJYPIkytSUrRT8eVU+MK747
	cB08oFthFwyhhOoDUXqFAXXeNXg7hhX+zVrALqMjjQ54Vq8qA536cpZdnhv9z9qIHj47DEFq4on
	np2hM9aMRRNih8P+1EgslxONDMLisWMz1OuGNrZVkYaVFrRnJH4kSxw==
X-Gm-Gg: AeBDieskQ/ROyXJPiyHNKu6rS3HYU7z0BNVsgeLKgdrd6T5aMaVXTPLUh/Ye4Nl4dce
	7TeAxgMYDrOsPXsotSB78U+CSwTT+z20HB0Kt0MtewrJazhnCSIIPf9wpfLaUXS9BSUWTGsK6lS
	La8mayJKRIswwzdc0QSmHpXSfh+e1+R+tbS2ZUAnC3GGw2hScXlO1Dg1AK3MmuHuWWBgkICRsxe
	ivEMG1oQ+RiTtUuHnXJnwHwhQ/NdcofFGckoUnzvk7QbdEfACzqqGT58PP/pyOrQeg3HcwGCIfA
	3+AhsAp1WycK0AqAelw2baiU/Cthef1vJUvaXbYMpkBy+orCBb4u6lTrhtCv7889hqKKUsxvbXC
	fxv7FFjdEqlhIx1n+4drBSUcxXxZpLsobSBxoMyiPLAO/WDKc+QvtWtf41X+HgcOIFXluaZMoqi
	jMmrX3ZRI9
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818833f8f.4.1776691255876;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
X-Received: by 2002:a5d:5e01:0:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-43fe3dbec67mr19818744f8f.4.1776691255247;
        Mon, 20 Apr 2026 06:20:55 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm28294807f8f.4.2026.04.20.06.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:20:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	kvm@vger.kernel.org,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Yiming Qian <yimingqian591@gmail.com>
Subject: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting
Date: Mon, 20 Apr 2026 15:20:51 +0200
Message-ID: <20260420132051.217589-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_init_zcopy_skb() uses iter->count as the size argument
for msg_zerocopy_realloc(), which in turn passes it to
mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
function is called after virtio_transport_fill_skb() has already consumed
the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
will be 0, skipping the RLIMIT_MEMLOCK enforcement.

Pass pkt_len (the total bytes being sent) as an explicit parameter to
virtio_transport_init_zcopy_skb() instead of reading the already-consumed
iter->count.

This matches TCP and UDP, which both call msg_zerocopy_realloc() with
the original message size.

Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 0742091beae7..416d533f493d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -73,6 +73,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 					   struct sk_buff *skb,
 					   struct msghdr *msg,
+					   size_t pkt_len,
 					   bool zerocopy)
 {
 	struct ubuf_info *uarg;
@@ -81,12 +82,10 @@ static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
 		uarg = msg->msg_ubuf;
 		net_zcopy_get(uarg);
 	} else {
-		struct iov_iter *iter = &msg->msg_iter;
 		struct ubuf_info_msgzc *uarg_zc;
 
 		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
-					    iter->count,
-					    NULL, false);
+					    pkt_len, NULL, false);
 		if (!uarg)
 			return -1;
 
@@ -398,11 +397,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		 * each iteration. If this is last skb for this buffer
 		 * and MSG_ZEROCOPY mode is in use - we must allocate
 		 * completion for the current syscall.
+		 *
+		 * Pass pkt_len because msg iter is already consumed
+		 * by virtio_transport_fill_skb(), so iter->count
+		 * can not be used for RLIMIT_MEMLOCK pinned-pages
+		 * accounting done by msg_zerocopy_realloc().
 		 */
 		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
 		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
 			if (virtio_transport_init_zcopy_skb(vsk, skb,
 							    info->msg,
+							    pkt_len,
 							    can_zcopy)) {
 				kfree_skb(skb);
 				ret = -ENOMEM;
-- 
2.53.0

