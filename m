Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09630C14A
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787417169; cv=none; b=muCERK3VDWODn0FybDjdhF5oLQ6rdIK+Zmq99EJqE0HZXLHmOis0s0sTIJaydMobcxT9EAhnHEo+LJ2l5s3HHaeC4uXE44sBb7HI8dRN1osBmC6cYJhPg0wOE/6L3te6OgJiHgksP4HdT5h/UQIrUKyCywcQ4g6VMOV55p+oKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787417169; c=relaxed/simple;
	bh=RZnSBXG7H5IfVESK5dV+papTZf4bB2+5pFdMF6y80Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnqKjhaJtWinDnMrWG/GfaYyZ0Ei6MR+9pH1iexnRLcps+AL3OvH/uqB7QglXkInt7co3SLT1segkbMubnBI4R51NyNdXW85TRI+Ni4MeorY2pt54MNQ8fPA1HEZTaqbtu59FIIaT117cGH/BPTReGKld9HoNhWhi/CNdm9OAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o50PTwrJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o50PTwrJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbe4c537ad6so239584a12.0
        for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787417165; x=1788021965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxjo65j0/PC8LNmS95fdZuou6hT1feMI3IHbQQyBjIE=;
        b=o50PTwrJBuwau13sNGF5h4O3fMo5o27/5Sy3+pjsyIesNKORDx6wwWGX0kKBL83BrD
         BsYaVVmDe0VuuL2boO8nOBgHnqTnEdua0MNVB3TzccDP0QAuj+qPb7Xrje2h+HJS0ZLv
         ofHR9qgWj564C/ap9pb13IqRfveb0K4H+d3xJ0sE1VMiE1y8Xre3g5ObJjvhjac7IqHZ
         dk240TvBQjk2PUZNlz97PlBdO3qF4kAFNJIGmWLpyeZMkoaxJ5gf2qbX7HaNVEJhiJIu
         Qot6JYoE6473NJg8I+1091cFGPiL1fDaz/Pt81NyEO0VKIE+zJqapI5Mxis4pT9IJwH4
         5iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787417165; x=1788021965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxjo65j0/PC8LNmS95fdZuou6hT1feMI3IHbQQyBjIE=;
        b=HOY2X818LoUdYSDnS7XzUJVGRWOs3q67CWKld9+XWFQg7BHQma+QdQ2ey/pluRj8vd
         VCn4c70BxUnUOrvTK29dFEkbBnh5SF9jESzJCjC/fOo4uOPH/aWXsqKNDPrPvBUlgRTA
         LIwSq8YdopI9+PY1eWvun/MyIPA4x25l9Pjkfu6sHEGIgqUz+mdSIk81qjs40nl7Eyzr
         sx2BTHHnepaD79TZFBoz61Kl5WGJH8VnCQba1uLToEGeSrF1fFgsPex0I9HykZbhj6X4
         NNWORVgD+Rcyb8mGY3FuIyjrHm/1FAxC/4IHLGAsfXpBLzYvJ+ZPAotqqQul/q8bI7X4
         zVvA==
X-Gm-Message-State: AFuF++m4QEVMuirWFGGe9CefjV+HuBf2RIA+QqK2g55DN6jGKV2o2B0o
	59AokJcDrDXMB85wc7Sf3RW9mZlYJdcrSa/FvNtaWP90u3g79gVv2aT4
X-Gm-Gg: AR+sD11xAY6ipxxRHMPLs41653PAAYRHnt6vSSVoxArUqVr0Htwp0jJqeji/KYK5LcP
	NDaXKr45yfSxrOeZG498Mf0J+khOeqsw8Rv2WMqx2x3whxDfFuecB8L/5JzpvhJiwKmdNFJP4jY
	Ia8ROuIk7HfZEhRIP4IrklKqJpqnCeUpl6Y/dOOvUmsOaOfrOhJDS1mzIDnASFDlKADh2bd1sq9
	+iCx1pChal29SnZ9znqSyDP0R+TcIcHa8JerCIhnEZqNkLg9TT9jozbNGIu0oCIdSNyxSgWw867
	mfmD/7XA0zyqoGwaz8xIr4MugURe6MCqWWYpBve2QMaBWlkStuO7wHILBQ6U6g/Lo74+zhEPf5P
	ZBOVQjREN9RLstmVTXCdC/GO6zaZThu1x+3G47I0PDnvLSjgrgoVFii5I5Fm+gjn4uSstmAbKlP
	5qoZUvYgBDJpMLH0RaOrzRwPH1Hj/VRBPzp4YBHiDOEuF5+EvkbNuiNIOxUm67zzxCclGaDKsQ5
	2tujvcGJFseI3XqrLYr2Q7buOyEM9360OnLst2rSAZEO6q3W8INris=
X-Received: by 2002:a17:903:b43:b0:2d2:a952:2628 with SMTP id d9443c01a7336-2d64b0d7b26mr129424855ad.2.1787417164695;
        Sat, 22 Aug 2026 09:46:04 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9209fafsm15623986eec.23.2026.08.22.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 09:46:04 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vsock/virtio: flush works in dependency order
Date: Sun, 23 Aug 2026 00:45:56 +0800
Message-ID: <20260822164556.3750959-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_vsock_remove() stops the virtqueues and then flushes each work
item before freeing the enclosing virtio_vsock.  The current order does
not account for dependencies between those items: tx_work may queue
send_pkt_work, and send_pkt_work may queue rx_work.

In particular, send_pkt_work can set restart_rx and release tx_lock.
The remove path can then stop the queues and flush rx_work before
send_pkt_work queues it.  Although the later send_pkt_work flush waits
for that producer to finish, nothing waits for the newly queued rx_work,
so kfree(vsock) can race with it.

KASAN reported:

  BUG: KASAN: slab-use-after-free in
  virtio_transport_rx_work+0x487/0x4b0
  Read of size 8 at addr ffff888114c2b008 by task kworker/1:1/47
  Workqueue: virtio_vsock virtio_transport_rx_work
  Call Trace:
   virtio_transport_rx_work+0x487/0x4b0
   process_one_work+0x688/0x1120
   worker_thread+0x45b/0xd10
  Allocated by task 1:
   virtio_vsock_probe+0xef/0x6b0
  Freed by task 84:
   kfree+0x131/0x3c0
   virtio_vsock_remove+0xd1/0x100

Flush the works in producer-to-consumer order.  virtio_vsock_vqs_del()
has already disabled the queue callbacks and cleared the run flags, so
after tx_work and send_pkt_work are drained, no source remains that can
queue rx_work after its flush.

Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 96c9fe8d357c..4f9aa9c4c3aa 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -872,10 +872,10 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 	/* Other works can be queued before 'config->del_vqs()', so we flush
 	 * all works before to free the vsock object to avoid use after free.
 	 */
-	flush_work(&vsock->rx_work);
 	flush_work(&vsock->tx_work);
 	flush_work(&vsock->event_work);
 	flush_work(&vsock->send_pkt_work);
+	flush_work(&vsock->rx_work);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
 
-- 
2.43.0

