Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9235DA77;
	Fri, 24 Apr 2026 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022295; cv=none; b=Kn9+82Z4Z34CxmgpqZwuXW5vfyZ7S4wmgAFYWjuwRaEo+T6yPU9VsLqUd4Bqj96GMmLppBISXnay3EI/XJPh4/jPkaypDSLNO88vsgOAqecf4aEY/lJlvwXjkt4MYkJ484QS0J4s/uG5tsG+H86SurTbcDGtOP/Rk9ZixkzsvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022295; c=relaxed/simple;
	bh=RtspwBo9pf805ofBGXqvsHZcX2ETm7S1THZdBYtX+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhjWqjLHvtxy3qkoRhrHbWMl+kSz1gVc56FC1z7eOQZDA49qPNu6OFK9Afsb9W4i7wWYUq6+JU3Gq4TMFnxxaSE3Jpb6TXsFeL7Pkr7jGRy63zdUhIo5BZarz6sHUsbiRirCFd22ZUkzaKzyo6/aCF9oNAN+rdkXs13Y/bGOSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7fe9993e3fbe11f1aa26b74ffac11d73-20260424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2cd62017-fd2c-456f-8b4e-895667d39ff4,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:2cd62017-fd2c-456f-8b4e-895667d39ff4,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:95bb05a891718cb0f0edf90c1e7c94c3,BulkI
	D:260424171805O5VNX6X1,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
	|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fe9993e3fbe11f1aa26b74ffac11d73-20260424
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1812665324; Fri, 24 Apr 2026 17:18:04 +0800
From: zhaoguohan@kylinos.cn
To: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	kvm@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vfio/xe: avoid duplicate reset in xe_vfio_pci_reset_done
Date: Fri, 24 Apr 2026 17:17:19 +0800
Message-ID: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

xe_vfio_pci_reset_done() sets deferred_reset and, when it manages to
acquire state_mutex itself, hands the cleanup off to
xe_vfio_pci_state_mutex_unlock().

That helper already clears deferred_reset and runs xe_vfio_pci_reset()
before dropping the mutex. Calling xe_vfio_pci_reset() again right
afterwards repeats the reset handling unnecessarily.

Fixes: 1b81ed612e12 ("vfio/xe: Reorganize the init to decouple migration from reset")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 drivers/vfio/pci/xe/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 4ecadbbfd86e..cbff5af385ef 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -135,8 +135,6 @@ static void xe_vfio_pci_reset_done(struct pci_dev *pdev)
 	}
 	spin_unlock(&xe_vdev->reset_lock);
 	xe_vfio_pci_state_mutex_unlock(xe_vdev);
-
-	xe_vfio_pci_reset(xe_vdev);
 }
 
 static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
-- 
2.43.0

