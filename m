Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34C3A9D80
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908704; cv=none; b=q5OFWAh7WvWsGxKVCt/DiiZ1gE+VOIPQ5+j+G0KC4hwrnm17KOhNlUwjkTtwq9Wxf8ckSQrGXx6DKdQhjW0ZZQ+KO6D2yW2VzGMV5x7Q+hnHzCcK7xWYg2qkTzRDutFbc5KKfrXSiAM3Cr6D8gwim9BtYyVEQT4AZnJOnBXT9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908704; c=relaxed/simple;
	bh=RN/+iAQWvz93fsNdffO3pKlm8BPcTNg2T4QvivKwM60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pI8Sfa1fKaBVjFgsxQ1dWDjaUaLVZQ5e2uVIIMDsI2C+eYVrefMtH2XrrRQpxocY2dm9UKgXnNdlmLT+JeRgQ0F29PBIz0+W9W0+9Pj3kytMYaiZXb8lwqCZQHYTxTcsOtrdqr+8DQ5BlsoLTf3/zheEhK4FlBGWU0GKovc3G1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j7WXbhUJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j7WXbhUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mW
	tGpjjUDl37/38JbV5w/oe5U7/Hkxam3wziKQf9nl4=; b=j7WXbhUJMzdI1IHSMg
	1EneSQ8eZH3i/zpajEI26GgvJMbiL8HeFyezB7u5z8s9WTaMOMAXo7oDijB1+OSH
	oL2sg6lI9DY9XtO7WqPyqiiQqakqQAwLUnWYneGVtR5dqTGOXFL/lKTYluABgtV5
	dHcWb9lXVThzrvvm6pZTKTkmc=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCH8q7DsrtpNoKYAA--.11656S2;
	Thu, 19 Mar 2026 16:24:36 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool] vfio: Fix memory leak in vfio_group_create()
Date: Thu, 19 Mar 2026 16:24:32 +0800
Message-Id: <20260319082432.34719-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH8q7DsrtpNoKYAA--.11656S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15KFW3ZrWxuw18Aw1DZFb_yoW3urbEk3
	48XF4xu3yrJ3s2y39rWrZa9390k3yUur4Fya17tr1DGasFywn8CFnxAry8GFy7uanIvFy3
	Aa9Fqry7A3ZxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1Gg4PUUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0QQn0mm7ssS+iAAA3y

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

When snprintf() fails in vfio_group_create(), the function returns
NULL without freeing the allocated 'group' structure, causing a memory
leak.
Fix this by jumping to the existing err_free_group label.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 vfio/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vfio/core.c b/vfio/core.c
index 8f88489..fbe0098 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -461,7 +461,7 @@ static struct vfio_group *vfio_group_create(struct kvm *kvm, unsigned long id)
 
 	ret = snprintf(group_node, PATH_MAX, VFIO_DEV_DIR "/%lu", id);
 	if (ret < 0 || ret == PATH_MAX)
-		return NULL;
+		goto err_free_group;
 
 	group->fd = open(group_node, O_RDWR);
 	if (group->fd < 0) {
-- 
2.34.1

