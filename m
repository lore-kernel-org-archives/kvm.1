Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4023E51D1
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095228; cv=none; b=p5T3WW1vbI2W0SESRGqX1g/9YNyPndVgkfWkgr+lWk6IRXb0/PVJ0CzVqnti4bWAfSHo7PHHg+6FEQ80hQ8hpve1eTv2npmfjQ+Kf8HCYIHHPM0wyxbk/vus4u7V+7WO4nGrpffDbwfWfv5f0w8YW2kATp8X3Q+HNErW6+Daev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095228; c=relaxed/simple;
	bh=uQ6Wln7pJey/LF1d0dz2kzM3P6XyAQup1rTFP8pIs04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYdEBxWfbZLRldPxsBPMAv1DF53iyRfA3XbCiopsRqlTigeBqtp/WiA5hotTFRNpcyUccTQ0TgNz/Dd9sLhwLE+Ydxj1XDBEAjpDOpMa0dc4sZ4/ZLJM2j2rP7PW6ttrqikvXi8O9VKysFGVLgSHt0tjhHU0vLFo3++K7rkI8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwq/nw5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6888Ohs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwq/nw5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6888Ohs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
	b=Rwq/nw5XuznlzFJJ9HBTXwKl94hKCpkcUNwDl/VKD/AyZ3Ef+mY8SwWH0dxeVgy7/AqKNA
	ILXT5J+feyftvaN+gx2D3bzwuTKjWQrsM3m0IFk2ETctth4BCUnoBpCKsrDfkMa0HeXQ5t
	ojgRpzCZYZBfmDIQj8rbmYdtZDiWFRI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-sQ8-mtcoMuicA-djehmVkw-1; Mon, 18 May 2026 05:07:05 -0400
X-MC-Unique: sQ8-mtcoMuicA-djehmVkw-1
X-Mimecast-MFC-AGG-ID: sQ8-mtcoMuicA-djehmVkw_1779095224
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d83e45febso2145291f8f.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095224; x=1779700024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=S6888OhsGUJrpUapZHoe8wg1D12MJ6Z1NYXzeXUUO8b0icS0Ieaf0khOTB42Ka6b64
         rGzI5WyAHJusNVZMEDEv1Y1l68BFh5EgxaqFuAzM9w7W8rFk5p1qwoXk5tyTCnBF3Wtw
         Q9TU2ROluUhopKxci8X0cXmGif/+zMxqbWhHj+UgxjacCFQwr6iY8G7KrcVFr7mCGQmP
         8cQqJvHMIEJxRN4JvZGZJIexyN9EbAF06C25NeRXa8++U08ipne/syIdg4VKuwfT2Kok
         B9qTVlXtqfxEq7qZvLRegwM9llVh7KQ759O/eIoMvuFWTySy+CfcBx/yRA0WNhQXZyRD
         Zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095224; x=1779700024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=200SzWxPjUpvXvgPwqt07Qg/dRT4TNSJWBHGA2MWMbU=;
        b=GU49pYLGEn8aSMkkGWkGmXYrqVxKSnMiMrQJwBxXCrukIFZ4GPe/NDYiwinPJ4t/6G
         +LIYVPF+qTnUbWbiHqN121HAPvy68h0cXoY+Hfh5DgwR1W5lp+gRsDESr1B1YUAmlf3C
         w3lxTznPSe4ach1eqAPeZfn5c8wZKgg7iAHOVHYv6yWVAt/qBnq4GQKg039flhMK5cbF
         6Ph0q6e8U6t2UmJAtElbXldga2ULzXfB0zGPs0jE9yh9hRXDsFVqZoy2BasTGr4f0JXo
         WGYNNee/jd9RWyzna0KUzdu6hiKvylixcHY5/MwPekpIli2xFSoxwzx0umnLF/Q2YGqa
         oOpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KH7UK7mWW4So8u6Dtru0cPrsx6R8sqS/LQSrypLlYPse15+v3bOfYCXTU9sxlV1WmgeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ow+YA7dFn2PxrhOpvDo/ChN2N6ldUI21+vwZCmxXYsXBqd5F
	iLEZ/SbD2YrAmpnU8fHaJFeX+Nj5t9GNBlJi0vj9WW7eO6rayibQxvFbkvdNzl7vCW6JlrP39zj
	Mv/yFh45BV6OpiqNxHKKa6iRdiigKK/C9Wj1jp4PKbv7rvBzCazQo/A==
X-Gm-Gg: Acq92OFJJGMG9O3afA6Ti4eM+ZahzXlf8AUCchr7lBa4X+u7N/tadJKfLIqppszEHxS
	JSwkURwSs/wzj+8Mz+zrrtQbP5soxF+6stfIJrY9WxofAO6Z1JG108RdyufCAbPpBH9zwvFyEvp
	cz6ZDZiqSlbdAcWr09kVPDSciv6jPK2wJVBqRCUZSkjFNvTzU5io5mO6U+gS7T+PYmKvtxdGuIk
	uIlDu+xDFOsEEepaLK0nUttuZARWxfRCh5fefW7Z2TLoCyT2VytJc0NkTbVIKSFZ5+pkfqRRDtK
	u2DSKjkyKHdtEKJCnCCDDwGEwrQXDr+ZA5T3RVKADsbckkPs6mRqf28G9SZIhz4p2bdaQI4MxK5
	J5FvK6YXpKeIrHVwIQ4XAjCd4luNsCUBOa6hhKhp2VviRZ3xFV7pPzf9ZYpr+
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66193255e9.3.1779095223692;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1515:b0:48f:fe2a:107a with SMTP id 5b1f17b1804b1-48ffe2a10b7mr66192625e9.3.1779095223029;
        Mon, 18 May 2026 02:07:03 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm105880345e9.6.2026.05.18.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:07:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] vsock/virtio: reset connection on receiving queue overflow
Date: Mon, 18 May 2026 11:06:55 +0200
Message-ID: <20260518090656.134588-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518090656.134588-1-sgarzare@redhat.com>
References: <20260518090656.134588-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When there is no more space to queue an incoming packet, the packet is
silently dropped. This causes data loss without any notification to
either peer, since there is no retransmission.

Under normal circumstances, this should never happen. However, it could
happen if the other peer doesn't respect the credit, or if the skb
overhead, which we recently began to take into account with commit
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
is too high.

Fix this by resetting the connection and setting the local socket error
to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
packet, so both peers are explicitly notified of the failure rather than
silently losing data.

Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 1e3409d28164..5028ff534888 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1335,7 +1335,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return err;
 }
 
-static void
+static bool
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 			      struct sk_buff *skb)
 {
@@ -1350,10 +1350,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_lock_bh(&vvs->rx_lock);
 
 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
-	if (!can_enqueue) {
-		free_pkt = true;
+	if (!can_enqueue)
 		goto out;
-	}
 
 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
@@ -1393,6 +1391,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
 		kfree_skb(skb);
+
+	return can_enqueue;
 }
 
 static int
@@ -1405,7 +1405,17 @@ virtio_transport_recv_connected(struct sock *sk,
 
 	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, skb);
+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
+			/* There is no more space to queue the packet, so let's
+			 * close the connection; otherwise, we'll lose data.
+			 */
+			(void)virtio_transport_reset(vsk, skb);
+			virtio_transport_do_close(vsk, true);
+			sk->sk_err = ENOBUFS;
+			sk_error_report(sk);
+			vsock_remove_sock(vsk);
+			break;
+		}
 		vsock_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
-- 
2.54.0

