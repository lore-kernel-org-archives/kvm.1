Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992234;
	b=gb90UmV3R0aZxn/yq83Fbm7JoHVqCfKLnV797EdsyO3khcBJhYeSHzRLlJBBw4x8dsV2
	 LvPLcq+vA0zAhfRtFjR6UX2jS+Dt07GMH9BhakBn6oyR409OVs0yUjoj5tCMpU9g52ENd
	 3kIZfg4FKVuvXYJ7cScaG7IIFfLGoqYdIeatg9EpgZWX05ZplwTLEXbK4e/7BscAB1C5m
	 Qp7S8Hih0/owhVOmTIBwbdoPip2lFk3rxkoLegV3vej6DVTWetZo2YP7mBTeeVBJFooMO
	 p8Zbb+nYRKyuqOB6V9laoiPpR5Bj683EQ1pq8KqD8xWFgCJsFW545eYw+9Zj/iysFRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
	b=tlwKUrnYJbwwivEJ+mcWS3nStap18jsEpwcz0QL92ZDGAsExYpvdB9wVeDGf3kanxugW
	 UPhZygtvh8P+XZvmqedcrY6jr5t5vwb71eEN4jJ/1KQc7cEj8TbK0zxYoZ8HlYszgRSC9
	 zvEBSL3PGm8tsWE6GB3yROku66HTHQJBceb6kjr7Lgp2EDevwkXaOGS/y7dvaGenTmatU
	 RL67oCwHl+gY5tN5nD0qjX6X3j2rNoPd7XShwd+7LCpf/t9fdgaek+gk5kOzbylAUEekh
	 Go5wvsQ0ZZ+6aUjuPrBRCVN7mQEEM3Du+PgGJ07KaTlmi6RG06HXMGub3qGim8+tO2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRLu4lzZ;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3312606A32D
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 19:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3312606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRLu4lzZ
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ebc0351deso1116226d6.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992233; x=1794597033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
        b=IRLu4lzZzcc2ZQGOKB7mVW3pv4psR+M1ijFPg5jVEmMFj5y3l+OUITizgZNjm/Ewd4
         DLCXXv6cL53BD82KuAoSF1V4wcWqHaGY5XjJPLGY2bX8OPA+xbKdn3cezJE3eyYhiU9q
         uVVScAX35b7cI7qc0L3TIjbFNw7bX5kvpgIT+V2YgKld2M0N4/paVVZPkzf8ba1LlpXT
         wbf7ZIgXZZy2LRsmlPh6AOs+5tPjcTHCTSQvb4vwjwc9ldwldbtG9cOITQvbnYilGKWK
         TB/4pIgZbZq0437QTX3OFkA/ztdQm0fkDXXtr6QOY1Skv5R0c9kcXgApGVWLt7IK4CA0
         1QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992233; x=1794597033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWaI+oXeHwnF+mBrw2+D+zH7UKh5jnKzMvqs17CwCNI=;
        b=qCtml4CRRMLqQtu/t4hMEA3HN3zORR5yUdjDQvHI+0YbLePuOMn6YOqttWrvXELYeG
         hQPb7lHp572t8PtHHyzhbZGy/v0bteRCgYtu2VR/q+oAtEhS4PgZB181vH088NhhCPD6
         e0m8naeB/rgvRmzAaCsohkhe13XpEXMOAKCyHjltoi3PEO/qhPHKKlTzf9J5K/y5C0hZ
         4LYw3v+N2dg+ZfKDdyrvoDaNPhnaPexjxu03MYgeidT1+kmu7TZl9HzNrSxhxM7MtPMO
         6ISQZz9TMI59Jep2HqvWvzt7xnFNXD2F8zlS6srwB03xRjCBICz/2MgHJSB1BZT5F9t7
         K2RA==
X-Forwarded-Encrypted: i=1; AL+hErED3hJ5QCTjfE1IfuBKlZLIKE2865z56orqcAefysfxfs+bPHlsV6zVplYmksj9eykhHW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+05Aofm2OzDv2uTZ9//JOHtqHBigKsO9zy0Nrb0RvLuox54/v/
	FraUAXYzqYhGhgpXZD1nQhE5fIljGO3s1G+4f4ia+jy/Ou1yqfGfQu4W
X-Gm-Gg: AYBFou33N1IcVH+k388MSTlkk8TBPoio7YAx1lJaKM6aMJC3H2IwXFi1YB8noJqHDvC
	yOYl/WZIRjDiaVSiqFMBuZkckybm8MWig6/zmJO2MLXyWZUq+UCEAjW8FLio7aPQMTasKKZQCPZ
	KkuaByaiA6Fo8rYHiockdX0Bx9lwtz4Ei28Uz7FFa0WXsCvww7w5uZqDowwVCCqrJE02dRVf+8b
	X254Vqr+9llbHf8hcFXZCJzKOIgiBTTWCKfxh17+z4oigaOd5abLbZuR2+anvNGCriCqEfOHC6/
	HL01cqItdRBhsp4k0QSjzJ/+XMAoRiswAVGOU4uORWpwjmuQZ+xzz2eKLbn74RL8z97iaqDkxMe
	T+0UTZ4KmjuyIFq6fTDDYHwpWc/1JBiTPafDvXuIrYF71Z2cLKfZYsfYllQl7d6NViUQe7aCkRY
	6IsgAshXrNhZdTKxSDO2jGdxvT9bEJ0XngoDLy5BS8uMAiKbPzjxniIPeJi7aQKrva/jmaxo4UK
	YynKLY957pMFVsr48jgvNWduUmT0YOX5JRhKSR80kzHjgrqKX4+mtpT19pErVwZdD9KdEepAu9D
	piz8aalkbSWZ0ZTrVhbKvqU+lPg87k4WxkDKyjQ+PnGGzHFJL12v
X-Received: by 2002:a05:6214:3308:b0:91e:b100:1523 with SMTP id 6a1803df08f44-91eb1001f9emr30869716d6.57.1793992232895;
        Fri, 06 Nov 2026 11:10:32 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a69818sm27622166d6.24.2026.11.06.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:10:32 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] vfio/ccw: Flush notoper_work before returning from reset
Date: Fri,  6 Nov 2026 14:10:26 -0500
Message-ID: <20261106191029.469837-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
the pages covering the range before it returns.  It calls
vfio_ccw_mdev_reset(), which raises a CLOSE event.

On the normal path fsm_close() calls cp_free() itself, so the pages are
unpinned synchronously.  But if the subchannel cannot be disabled or
quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
fsm_notoper() only queues notoper_work, which is where cp_free() then
runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
path, so the callback returns with the pages still pinned.

Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
and taking the host down.  A further CLOSE cannot help either, as both
CLOSE and OPEN are fsm_nop in the NOT_OPER state.

Flush notoper_work after the CLOSE event, as vfio_ccw_mdev_close_device()
already does.  The flush returns immediately when the work was never
queued, so the normal path is unaffected.

Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Point the Fixes tag at 0c11f61a876e, which moved cp_free() into
  notoper_work. v1 named ce4b4657ff18 by mistake.
- Mention that commit in the changelog.
- Rebased on v7.4-rc1.

v1: https://lore.kernel.org/r/20260922164928.477669-1-oss.patchbox@gmail.com/

Found by code review. Cross-compiled for s390 with gcc 14.2.0, W=1 clean,
but not tested on s390 hardware and I have no reproducer.

VFIO_DEVICE_RESET also reaches vfio_ccw_mdev_reset() and benefits from
this flush, ensuring channel program memory is cleanly released before
the reset ioctl returns.

On locking: the flush is not called with io_mutex held.  cp_iova_pinned()
takes and drops it before vfio_ccw_mdev_reset() runs, vfio_ccw_fsm_event()
takes no lock, and the VFIO_DEVICE_RESET path holds nothing.  This matches
vfio_ccw_mdev_close_device(), which already flushes the same work.

 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 5ce91285c7d5..8e0a2edbd34a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -25,6 +25,14 @@ static int vfio_ccw_mdev_reset(struct vfio_ccw_private *private)
 	 * and re-opening the mdev, return an error.
 	 */
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * A failed CLOSE leaves the FSM Not Operational and defers cp_free()
+	 * to notoper_work. Wait for it, so the channel program pages are
+	 * unpinned before this returns.
+	 */
+	flush_work(&private->notoper_work);
+
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_OPEN);
 	if (private->state == VFIO_CCW_STATE_NOT_OPER)
 		return -EINVAL;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

