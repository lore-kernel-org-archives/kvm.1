Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2C3DB632
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124703; cv=none; b=AumEXydEX9vioczxheKq2QV+G0nQfMj6L8bzXYr8zexP84x7NJRFuejo+hqepu6fZM6tkRwOcCK1K3OhB72WXRUc0WEHaoxnbEWfyxYzovJelNnW6WOeaR1XdCI7mjEpIWVIk7HAOZmRO6jXLuKbdWIeKN+O6RYz4h+TIr8pNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124703; c=relaxed/simple;
	bh=TlYdtrHL+mvv8ijwFP2OcSIxIVHRN2GalntvmJUIBYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAzmhYiODElSawat3SjngZCdgfsiwPW0yYA8UPDrxzJg8DVBZrElgqNsyoYVYqD8/5pPPEez4Vo8KycCRhAn2COwVfkiOj8c7ayifUkVg2Cilp7L3hldq6hOMMs7vJ9JHUzYc5dgPeTnX8vGpDf+ySVeGMtfGjyV18nHdu1dJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahwfY66z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahwfY66z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a652535dcso1223504b3a.3
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785124701; x=1785729501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=ahwfY66zDbAXsQqwMUqmvNugb24L7dtZnO1YYO4fmR8R5/rPZc3Yt4DvLM/1jnW/P+
         PuB9W2gZpU2pgAG4Pht9DZBLERJgiOxxFN6h5SH6UEaWt89OCPQallXr13NR2vfCptFA
         mFK1d31Mv7z5RAafcGaRAhrOt40UG6QxrtnwMnj4Ur0Sr58xvgOB0mM1c2JNwmV6NDNm
         hX87wFKSyGWM7IBoUYGMti9sOTScrCJtuMd/MEf5tUClEwlihqIunGNWmiJwvnoydaKJ
         WvzhVbLzj+Zhm+S4t4qo7/kftxeKr14RbE44/2iD1i24uAv3GNL6nzfGVNnjPGaLvXdU
         7W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785124701; x=1785729501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=DsRJs3u5ruND6bHmb78xyVMOH4Ino4Lo52Q/FN9XwWySJ9SLuneL+D9sPvVD9nSY6B
         zSFkH3z3b3N3kegXNafwsvX7Ep5L1WICQVegZRiVjlNFOSQ8VmZhYJR6A+dkwDq7nHTg
         7JVvoImbrhAMZkHMZR45jL6OujUBiVyRsrVl9o13MAhFeoRpsLvRiYiV/LQU6ImN1N7M
         R8M+4DSb3bBzKMG+qy5teSs8VfYkJkh1sT9ra3JhY4UbEjbj8xJJdENEj/aji3y6YDS7
         GGkF4DKz7d1V2frEHXw/0VY7vWzlXTidtVYbTpI+jlkubelvOjJ9+Y4x9IvtzwpLcgyj
         lnRw==
X-Forwarded-Encrypted: i=1; AHgh+RpZhCgLcXGcNdqRdkQq3r+ZQ/cTqQfi532X5b4AQm+KUBEweQ5e1IokUdOr3oTH5kCB4BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+M5v1PTIg9IC0riTtfen6xNZ9FMu+RaHOg/gj5Xbtv+9Oj79
	r5sRZtNa29ri7PYd3FI/7Jua4SdkPXqAH8FiSjRoymT4QFu1s7EPxN0w
X-Gm-Gg: AR+sD12Ooq5A9yKs+QSRZ3HilQuHcAXGMY+HSCU1mR8waR1nL9entN4yL7YxV8VcFss
	+SdRkMyp6Ospu+3tFXRJuP+XfX7JgCn9psunvVyNVCbg5t/dtwkI5k2P9+7XLdUAtaaRO3urWCZ
	giFQiR0josRxsVVmeeNSVPSvkmqVlKqZ2E/px1gjvXxDYH+JHXjWnVp5A/w9vIGkHxVvF7/JZzy
	La/Btzmbrq2u+7sxrEqj5mBirBNfVqxA75Pc5NdZEwt8Z4q9x5+tqU5byV3jW+MaRgiW5CJG9Pc
	yAGYTjJbeJSpdi3G+PjLWCb3g8R68HBHfqppniigI3Ui2mGLbOIoST6+1le/5ko/M00N8EUdUjY
	X09AkMOlksuA6hANlx2r/BKED15lsAr2d7Fj7EkNZr2lZygDZAJOnGwHKmOFUddjNjuZmbZdnOV
	79aSgSBEnJYDO23mASEufW
X-Received: by 2002:a05:6a00:4294:b0:848:4190:ae72 with SMTP id d2e1a72fcca58-84e5955f15cmr5374554b3a.46.1785124701206;
        Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660dedfsm2680815a12.4.2026.07.26.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:58:20 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
Date: Sun, 26 Jul 2026 20:58:01 -0700
Message-ID: <20260727035804.1860862-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX, TX and event workers read their virtqueue pointers before taking
the mutex that protects the queue and its run flag. A work item delayed
across freeze and restore can therefore retain a pointer deleted by
virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
and use the freed pointer.

RX has an additional path: when rx_run is clear, the common exit still
refills the RX queue. A queued worker can consequently call
virtqueue_add_sgs() immediately after freeze deletes the virtqueues.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/2:1
Workqueue: virtio_vsock virtio_transport_rx_work
Call Trace:
 virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
 virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
 virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
...
Freed by task 141:
 kfree (mm/slub.c:6566)
 vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
 vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
 virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
 virtio_device_freeze (drivers/virtio/virtio.c:658)
 virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
 pci_pm_freeze (drivers/pci/pci-driver.c:1098)
 device_suspend (drivers/base/power/main.c:1968)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Read each worker's virtqueue under its mutex after confirming that the
queue is running, and only refill RX while RX is running.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..79cf19f58943 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vq));
 
 out:
-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
+	if (vsock->rx_run &&
+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 	mutex_unlock(&vsock->rx_lock);
 }
-- 
2.55.0
