Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927202;
	b=SE1UIeeymhJV3IXBLDQ/1lakSunrX6VSfXbAgFojhPEM9kX5CSKqyn4HxJ4aqlG6b23l
	 21E+oaUTief76KCEJySaNZE8uFkuQO+vK7siek0861zc9sPJWnweYeBJ9JkgZXG37SfIC
	 YahfXWfdSED4G58197++LTqq2MBBvqq0tPtDhiOF/UQP+i+1uHLsITpUuE49QsbHQFIqS
	 R/WExXuU7kQg9Fo5cNTcrMC4ghXY9qg4pJ6aggLVusz2n5Usb+YVGVslKJn1glkG/NpUF
	 E2n8GAkriEY9Vv+B0iNXCfCn70naLXrHUMia/JfrvRluLr6pMqCdIpMSAJqtSVG4OYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
	b=1T5/ETbeSp9p17HbqiIJ89TYMJcLymMrgOUrew5aAMPAvvVR8zsxyhluAyh6kudge0Au
	 C4LiMF71+ueHQ9I8pQq9yiV8sFhu8nsvbO1uC909UoLmLnYvqfRRIChfFIIvCnXTaphcy
	 qQEXgf4pRsvCpePLA84DOobGJahRPGIm0Cambe/RrG8aR33lewwpH3RfIso2KFf/4sdAR
	 NDBQGvSTEk+6j3mH7NbRO8ds5JmAb54Q/WccXkF/mSEwPqKRCMgS4KdbzedV/RmNraz3r
	 jBTt9jpl7JWTou7XHhz9KHZ7nZi2+R+ORQU5KrMXYQIycEDWPoH+8IesXO+atTMbuXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fzb9MBq1;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CC606A33B
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 14:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534CC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fzb9MBq1
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b3c9820789so145798a91.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927202; x=1795532002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
        b=Fzb9MBq1nqqQ5zjQ+Wx2/Vjq33FDWcUWLbn5DIgBawulgIj6LpCy5iJd/uWlAO9x9k
         Wrz8JnYfU3Hsfb6nH+cni+gd4X00dOuvLXQf7tzTdblTB5SMd2uWyoDcBcVAnU+S745f
         QXA1LMI79dL3VlgXr0M5a56GkxxvvIuovTWut1uUPQ9ctBxtdezWs96MKudaZQp280R7
         TFzwaPeTNLG82php9XbT7FlWi9zDqwBjRK+nSCZRPcNeDh6skRtWIv4ErLjfK8JttYuK
         G0Dc+csvkFhHmnt/zicMRDo8kJuztfc8rKqcvbXtXWyCX+T1hygJFv/dC9VhjQT2BPVx
         pYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927202; x=1795532002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
        b=0spbhXO4rK0JwaB29wxZ3ltKq4rK9ypmNHxPGHIaG11kT+Ay58VWAXK5tKoxhjCeSC
         iaF3FgPMFvL3JGjwi/y+Lm+mxiCLvL1QLvxEsWcqenA1zT0WjbAk0m3D1EX01SVyU3el
         Avsl4Abar2MM8YMPDN8UAdl9SNIyhLxTK018Vn5hanf5Dd+95c4qyZ88xDAJHpZhyHd7
         YnwLVMflDGzHCT7q/GArypmN/OvKD9FYEnzAQ0qV7FJL3NiDqvArZ0HXKsY6t11KSU3Q
         Fx3sFqLCetS64fMpaRVLLwkiivoSERGynzgXlTDklhTj+Gg53wPrLn+8fT/w3OzIKUTv
         MM8A==
X-Gm-Message-State: APuU4Z9AFQrsuAlxBJFDemO297xSdShxnkZfGFQFr+x75VDbFbgAV4mN
	UVgZO+uHql4eX3IqxpRlXp+Xcpjv805ewMJJCVRK2t5veP3lvPGrz+Lo
X-Gm-Gg: AZFdTZfov6MaQU0oxpOyRj4Llas+0wGKw5ig3dTjH9/3v54wK/1s8XDcRv1AjOa+FYr
	cPbLXNg6B1lAPObBefipRz3qRewekxIkjYtM3Z3O4hZy1OaahOl+GSfo1JWCCwzFh2azfE1Vv+u
	UDVflcfcAnpctwC2bmJ5ZKlBdL7opI+qWnoXetbOIrCWfGi3HTCfydraNvdOzmX+MM8Vk89aVi1
	fQm4mWmvA4gEjEar94v2uNMk3d2a/f4Osqx6HciyHrpOBhTTQE5VtD10CCGI1/lNBBSelNz5cXA
	HBku1JuutpCGi6bov/729GUeUAzv+6KeHQ95J0IQTH7hLnRXEb0M4nHBo+53ik/Ojv2r4Lw3npj
	cS0pA5ehrt1Gg6+zT1nsUX7+nICPVowcaJw0Cg73Ss9DTghBrIbb6naWhf7nDI1MhkC8sWdxzZp
	zJfRe2CYnc7uM8cSquiSCkzfO3yLA8LyEti1f9Vd1DOZ9a482LQHJ3Vhh0Gmu78OfKjDzz9ncZu
	c0r/2ZV9wfAEZETF0o5n/+G3a/nZ1oykop5OsKACyHgHBwN5Shq3EU6W5PwGGOY5NtSZIPFyBnT
	ZbFfWY94C5UEIQwKDx/3e/6+3x1Hg4+bNWy89yZL6vtHNo57V511m6s9oJ8IwV/7zOHju0hoM7f
	//fQeVqDY9jN5Y3l5wS3PWzU1yXTZH8mMPAXNhop6
X-Received: by 2002:a17:90b:3a0c:b0:3b1:7329:a121 with SMTP id 98e67ed59e1d1-3b1b0a0e800mr12479951a91.12.1794927201457;
        Tue, 17 Nov 2026 06:53:21 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18a2191sm6056636a12.21.2026.11.17.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:53:20 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: synchronize worker freeing on vhost-net teardown
Date: Tue, 17 Nov 2026 22:53:14 +0800
Message-Id: <20261117145314.1092372-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
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

vhost_workers_free() only waits for RCU readers when sync is true.  Both
vhost-net teardown paths pass false, relying on the assumption recorded
when the sync parameter was introduced (5efd97e6f0c7) that "net and scsi
stop their virtqueues before the workers are freed".

That assumption does not hold when a tap queue is detached while the
socket is still attached.  __tun_detach() runs tun_queue_purge() on the
detaching thread, so skb_queue_purge() releases the zerocopy skbs and
vhost_zerocopy_complete() -> vhost_poll_queue() runs there rather than on
the vhost worker.  The vhost_dev_flush() calls in vhost_net_flush() and
vhost_dev_stop() only wait for the vhost workers, so the queueing can
still be in flight when vhost_dev_cleanup() frees the worker, and
vhost_worker_queue() then dereferences freed memory.

Pass sync=true from vhost_net_release() and vhost_net_reset_owner() so a
grace period and a flush are observed before the workers are released,
matching the vsock RESET_OWNER path.  Both are slow paths, and the extra
grace period buys back the races described above.

Testing: QEMU/KVM guest with KASAN and CONFIG_VHOST_NET, zerocopy enabled
via vhost_net.experimental_zcopytx=1.  A second thread detaches one of
the tap queues and frees the queued skb, and vhost_worker_queue() is
delayed with a fault-injection module so that the close() or the
VHOST_RESET_OWNER ioctl completes in between.  The delay only widens an
existing window; the detach, the purge and the teardown are all
unmodified upstream behaviour.

Both teardown paths reproduce the use-after-free on this base, and both
are clean with this change while the injection is still taken.  The same
injection reproduced on the earlier base where the analysis was done.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

Test details.  The guest runs a KASAN kernel with vhost_net built in and
zerocopy enabled through vhost_net.experimental_zcopytx=1.  The trigger
attaches a tap queue to a vhost-net socket, queues a zerocopy skb, and
detaches the queue from a second thread while the owning process closes
the vhost fd (or issues VHOST_RESET_OWNER).  The second thread is the one
that reaches vhost_zerocopy_complete() and then vhost_worker_queue().
The fault-injection module resolves vhost_worker_queue.part.0 from
/proc/kallsyms and spins only when the caller is that detaching thread,
which makes the window deterministic; kasan_multi_shot is used so the
remaining reports are not lost.

Results on 666539eecdf4, one run per teardown path: the close path
reports slab-use-after-free in vhost_worker_queue() four times, and the
RESET_OWNER path likewise four times, with the free stack going through
vhost_dev_cleanup() and vhost_dev_reset_owner() respectively.  With this
change both paths complete without a report and the injected hit counter
shows the delay was taken (1 of 5 probes for vhost_worker_queue(),
the other four being callers outside the detaching thread).  A control
run that closes mid-test without the delay is clean.

The same injection reported on three consecutive runs on 776b6be748eb,
which is where the analysis was originally done; the reproduction above
is the confirmation on the base of this patch.
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..631855064b3d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1452,7 +1452,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev, false);
+	vhost_dev_cleanup(&n->dev, true);
 	vhost_net_vq_reset(n);
 	if (tx_sock)
 		sockfd_put(tx_sock);
@@ -1661,7 +1661,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_reset_owner(&n->dev, umem, false);
+	vhost_dev_reset_owner(&n->dev, umem, true);
 	vhost_net_vq_reset(n);
 done:
 	mutex_unlock(&n->dev.mutex);
-- 
2.34.1

