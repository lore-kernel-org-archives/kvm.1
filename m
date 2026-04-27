Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CBC175A81;
	Mon, 27 Apr 2026 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252920; cv=none; b=RFGXpMsuPyqLlEoNLORdZnUgU0wOjdaoDuGrbhvzlbuXP4tjSgC4jcmOzVC0dSfiuUleH6cWQRAAGdf6gkRG6L0Nu0dWNymaiq0+AT99ySQRSK7qddVdx+ap6hV3iQuLeb3GuKgK/2EfxjPjdF/GBgMazjZSkH1W2TyxVUxOC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252920; c=relaxed/simple;
	bh=CWmzRJgfn0UBdbDnrKyuKMFFos+n3gVb4I8g3lwEZeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcxvkADqOCX+oNuwftfmgmeBUg2aMA4re3rcoSXmgs7f6ZrGzPMK/E6keHn/yXvL0WcSemst0hfHPsBhZIXc9mD8FjuCI2sEh/N58gjHhWLnxU6eaEDEHKsow3wjBS4BAtLhQ6ytlpeN1XWf51TVC60wacIPQONmRUGpo6PVxV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7866515041d711f1aa26b74ffac11d73-20260427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f22e5be7-149b-44b6-843b-a8a1a78727c8,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:f22e5be7-149b-44b6-843b-a8a1a78727c8,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:9e8c26ad00135fa63ef713404ec30fd2,BulkI
	D:26042709215374FSTQXC,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	23|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7866515041d711f1aa26b74ffac11d73-20260427
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1993856307; Mon, 27 Apr 2026 09:21:51 +0800
From: zhaoguohan@kylinos.cn
To: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	kvm@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vfio/xe: avoid duplicate reset in xe_vfio_pci_reset_done
Date: Mon, 27 Apr 2026 09:21:28 +0800
Message-ID: <20260427012128.117051-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
References: <20260424091719.58800-1-zhaoguohan@kylinos.cn>
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

Fixes: 1f5556ec8b9e ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
v2:
- Correct the Fixes tag to point to 1f5556ec8b9e

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
