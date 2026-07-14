Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7239182D
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997109; cv=none; b=SCF8PONCDLU5rew3GfyBIYu+cjvqCQDnGEUq41+igwiP6CmBh8wHVBqBYb+Y6Z9AtqNFCK/iBUEyyWyroh65oyeImrMTc1KWcbi+U5NiM3QtVcSv/SV7/7MmsxpFxiHKjYsQEgsBRsIEl4GTUUHk955sOd006nKYRxdrIqWvRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997109; c=relaxed/simple;
	bh=r+BhOWwHZR/nXn933MZz2l4J+vv7UjbRlj2bs9BJtFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXfpW+SZ2HQ0hIaZJM5HLFGMN/WGhrSiuKPlW00csPTB/JON/oLA3io1m6xnYZruWZ2DhVD6+k+RoguyxTFYP3riVCaHJannTkZtx32S+qTrlU2lIGGbH7YEL2yYeVQ1h1INMEG0yaxWX+272lY7MYGaLjvNnz3p1HBRSke2JhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eJZWLYGe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eJZWLYGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=eg
	NvZkkgF0O2goDym7Bxh4vIiL8gXxR26e03veP3E3I=; b=eJZWLYGeTPSdRKxJDs
	lxXiXSpWdTAOy9lO9b+vJ0vCbEWMdQTnTZcRYxKrpPdIsUMA4eLysplG49r9fmnl
	Z7Cazs2S6DSk+9v6ZhiOKzE+XsBSsF3F5BTThgi9FzIOVwbV6cf9KfY3uIopT/HM
	7jIMPfdAB34TKOENeQgHtEqrw=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDX0kKSolVqaKemGA--.24446S2;
	Tue, 14 Jul 2026 10:44:34 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vhost: fix inaccurate kdoc in iotlb helpers
Date: Tue, 14 Jul 2026 10:44:34 +0800
Message-ID: <20260714024434.188302-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDX0kKSolVqaKemGA--.24446S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4rKr48ur4fZr1UZw13Jwb_yoW8Gw4DpF
	4xW34UKr1jvw1UJw4DC3WfGFnYg3WxCr48CrWfW3W5Zrn8JryUGrsIk3WUtr1xCFW8CF13
	XFy0vF15KrykC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8J5rUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8xO8RWpVopO9bgAA3E

From: xiongweimin <xiongweimin@kylinos.cn>

Correct missing "if" in the add_range_ctx return description, and
align vhost_iotlb_alloc documentation with its NULL return on
allocation failure.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/vhost/iotlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index e1414c774..10d1c4073 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_map_free);
  * @perm: access permission of this range
  * @opaque: the opaque pointer for the new mapping
  *
- * Returns an error last is smaller than start or memory allocation
+ * Returns an error if last is smaller than start or memory allocation
  * fails
  */
 int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
@@ -143,11 +143,11 @@ void vhost_iotlb_init(struct vhost_iotlb *iotlb, unsigned int limit,
 EXPORT_SYMBOL_GPL(vhost_iotlb_init);
 
 /**
- * vhost_iotlb_alloc - add a new vhost IOTLB
+ * vhost_iotlb_alloc - allocate a new vhost IOTLB
  * @limit: maximum number of IOTLB entries
  * @flags: VHOST_IOTLB_FLAG_XXX
  *
- * Returns an error is memory allocation fails
+ * Returns NULL if memory allocation fails
  */
 struct vhost_iotlb *vhost_iotlb_alloc(unsigned int limit, unsigned int flags)
 {
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

