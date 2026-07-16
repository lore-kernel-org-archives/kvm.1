Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC123176EE;
	Thu, 16 Jul 2026 03:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170974; cv=none; b=pLkVva/p9YHcWPQsm5YqvjacRIU4idDXUw6PDMp0c/7AiVHjvGEhU/cbFufXHGGCfRlNe0byvp5CkBME1zrDvgNhhudvWvNvK8YBf3yX2C0P3i2FV1i+WEIGbyZzWs+VDd3jyGGTfIbf+wTyJVHmUN56TQYsUaQ+nRiomEsxtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170974; c=relaxed/simple;
	bh=DFZRlVoWzPVMZ2jvsLr8WRYOGQcz7fh8eTIjkDXEqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRtXjw7iKLVzltiLftX42bHeRWaHb7Ts/UBaPLlWmXff68LNgRfowlTgk9oK6YLdM+1dAt+FRLoX9mrmVFjgmxAy2hM/FIgaTYEQkiWXVnVxBAB4UdTyx3a7ZHR54tEmKCp1PlY2R3XMzLhI5wQ4vIltuW8jkXDLrvMwqHQL9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Swamz4Do; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Swamz4Do"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=NV
	gqlwNf7WiTSJJImnUuHurU6cSUXveORdu3yb81gdo=; b=Swamz4DoZLQT+30slX
	pFfJ5E6R6th9WWJovHhbFx+O9/9k1PvTpwhiK+3vXStkBufrlz5tfm96e9BBLRdx
	ohzm0zNNiKLo+hZ4rotWzeP49yxnXsLDYIWJzwFuoa9ayi3OkH3oVpwzgSJ77WAu
	gCLtEVRdc38gouDLNL8WUz93U=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXJ1nISVhqrJ88KA--.23413S2;
	Thu, 16 Jul 2026 11:02:32 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	netdev@vger.kernel.org,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
Date: Thu, 16 Jul 2026 11:02:36 +0800
Message-ID: <20260716030236.124322-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXJ1nISVhqrJ88KA--.23413S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kGw1kZw1xWw18Cry7Awb_yoW3trb_ua
	yfXr1xJFn3tr1qq3Z2yFy5Ar9IyrsrWr4DXasYy343Zr17Jw15u3y8Zrn8A3Z5Ww4jqF9x
	Aws0kw10vF1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnZNVDUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQk1xGpYSclRkQAA3H

From: xiongweimin <xiongweimin@kylinos.cn>

Reject VHOST_IOTLB_INVALIDATE messages with size == 0 to prevent
iova + size - 1 from underflowing to U64_MAX, which would
incorrectly delete the entire IOTLB.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3c080c454e374cabd7321416ed92c5f7d3135254..xxxxxxxxxx 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1656,6 +1656,10 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 		if (!dev->iotlb) {
 			ret = -EFAULT;
 			break;
+		}
+		if (!msg->size) {
+			ret = -EINVAL;
+			break;
 		}
 		vhost_vq_meta_reset(dev);
 		vhost_iotlb_del_range(dev->iotlb, msg->iova,
--
2.39.3

