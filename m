Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF5389E04
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063184; cv=none; b=bLxqP+ePLPBhy0CfAWHoixaIRIxQgcP/fk7EP/s/3MUTFbZlKdX0Wgo7AmQ6yd19EYKyqRSQEqwhKlD6fTbrjZmHsxSbK+BGBSjs6AV5mM0O2mRjDkfWYCi4X7E1vYD+o8QRw9iIkF/69zq+Ey9bWfPizM8zX+eL4kkWxHCiXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063184; c=relaxed/simple;
	bh=u6YITT5i3g3xtgW9vHR1/H4ETIGCGLKHnuU1y7MmgAg=;
	h=From:Message-Id:Mime-Version:Cc:Subject:Date:Content-Type:To; b=Z+UZwAug2kAaa/yL85qDgeXrjmOK7ZqtVkR0U6lpp+4f9BApXFcSTE9kxJoNOqnVF+o6XlIwvpvz1G2yX8/xmRfRK13tVlrz8FRBL79RNCGOcLlrU1RdxCSp5gXNrV3K6A061JY11OHjeAxIb3ISe9y/bJfrBoUyWQoABzxThRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TqDavQnt; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TqDavQnt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776063171; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ZXothe/xKfm9FfMx4E0qgqfIEiuHvE3j/N2wGcAtYxw=;
 b=TqDavQntuKDSh00Ki6sB0RjiUhqGNCnjZj2QhdksM0ZkHiFhdXgp39gQcKQt2Bafo58rI1
 4kpHxEebnDWsaaMGIlVAlCXXXhaqEuhMEmhZB7i6woVWR+dGACVv91BhrX78548YyiQH8h
 t8gM30YcPbb1kCPmgoM8Y4Vb213d65KmnCuXZxE3kAn9TZpmKVS9I2OdsGOvmz0gDWLJkb
 RLU4Z8MRhCi9p6l6w0Cp86ImjVdXUAb/IAA4s01OhXNIDBkE32O0vqSrB10KGgNyDhBmfK
 zPttJ9DwH4p9hECOUehoZx1ZZUiAYCYumfMpTe8631wng0cPUqMM/exeNI6NxA==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Message-Id: <20260413065204.30330-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+269dc92c1+a6d9dd+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH] vfio/virtio: Fix lock/unlock mismatch in virtiovf_read_device_context_chunk()
Date: Mon, 13 Apr 2026 14:52:04 +0800
Content-Type: text/plain; charset=UTF-8
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, 
	"Yishai Hadas" <yishaih@nvidia.com>, 
	"Shameer Kolothum" <skolothumtho@nvidia.com>, 
	"Kevin Tian" <kevin.tian@intel.com>

virtiovf_read_device_context_chunk() takes migf->list_lock with
spin_lock() but releases it with spin_unlock_irq().  This mismatch
can incorrectly enable interrupts if they were already disabled
when the lock was acquired, leading to unbalanced IRQ state.

Fix by using spin_lock_irq() to match spin_unlock_irq().

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/vfio/pci/virtio/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 35fa2d6ed611..9fc24788fc04 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -621,7 +621,7 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
 
 	buf->start_pos = buf->migf->max_pos;
 	migf->max_pos += buf->length;
-	spin_lock(&migf->list_lock);
+	spin_lock_irq(&migf->list_lock);
 	list_add_tail(&buf->buf_elm, &migf->buf_list);
 	spin_unlock_irq(&migf->list_lock);
 	return 0;
-- 
2.20.1
