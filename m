Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A2DCF6C;
	Wed, 15 Apr 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277098; cv=none; b=T0N17Ol6qyOr3eH0xwcrH0dq/x2tr1EItG8jBRnEX4GCozbtLXjnIk6nk+KuAfg9Ap30i6yneV10oWQEgWr81tLLjzfM8pwBMaeO2zUSBqFIOTLHLnwUj1XnZhYQ34/NjKIA2s6JQ30niRAsM78h+5iwD18VW5VqBJoZeyne+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277098; c=relaxed/simple;
	bh=xZsdgRz916OZ9bW1vtgM1tuuZr0o8jU7iy/Esnibrxo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LPMxjEIJtrMqhEfFH22xppd/mebl7Az+fDO6JHZAP6+Qb9LhOPJLM76CVE8aQdNEtOLUsBcvfS6f14FN7en5PB2wtYlW2e7Hs+mW1h5IjDZzpBLmNMDZeFcx0eYePYWKidu6iS9+e/tnJFKT9De5+1RE75/kIwjfUPWpvMNMTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CzxcsKtc; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CzxcsKtc"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FCOAdK2974154;
	Wed, 15 Apr 2026 11:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=xh2UaSdgyFxaliKPoL
	gZK/jMUpy5mjl0e00Ed4RmjhQ=; b=CzxcsKtcOW1EPAURoIlDxJKVggYkxknmrE
	8BPPMpP3CWKa9nvZo3S8M3iID+AtkhA5MDL2O3LIGoCf3Cpz3IHSYHbXN+PoQSL5
	CsTc8wYGv5ibATYn2n8ibKjpQUnv73ViJllEj3yR2chcrbQZcyNrIbKfuXHahWAE
	PkSB31np+hIT6WBX4pZTrt1HQbyLB5O/6FR9yfhlAh08eUxI49aNUAvPSyxDm6bn
	+TQbEBaU2nMGU5YBkwLtZucEzC+Oxq2+5eo9MVarPkx21+4NKaiyHPBeGf1WxazS
	19vCA/ECt5Ye9OSkY2Who3TTOBtTNJWfNK/hnfqLLEDVUAdFLiiw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84yd1qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Apr 2026 11:18:08 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Wed, 15 Apr
 2026 18:18:07 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin
 Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Leon
 Romanovsky <leon@kernel.org>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH] vfio/pci: Clean up DMABUFs before disabling function
Date: Wed, 15 Apr 2026 11:17:52 -0700
Message-ID: <20260415181752.1027604-1-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MSBTYWx0ZWRfX7GpOGKywTjzv
 9G1J/O0x6vRc8ncbf2iUCZSq68SwM4WIZ4IoGOPo6NFc9natVRp/u44HqgVDoZiGYLFdqfOXoVr
 QvlCpSOz+NPI0Glt3LIEBdBdeRe0hcwBh+BgGr207anWKLqZgQg10gtybAxkGCVJAnq+sK34+ss
 k5T5Jhn+icpPJr9E6oc/k67jmcBRn9pi2nnVsxdSwPqOpIqGIuY0es6canK+/w+9y8nqf8FB8A7
 ZLX6q0pVIpk1VjrzoEOAv15NUNbdQGmmSfoxSB3Ug21HenwEBslgp3yy6xvh2qv/FebiHq8lB7p
 6VGGdiYlhYe2gilu4wIHsvukg2UOLZkytEpJvlx6CF2fOYEvwjl4+GvkOw8HDzdaDbAUuaULQlY
 +PdBbJZBeSEq4BDp3kYHluVhh+iLf00+WuNzisC9dmMyiw2BiHkoSSHCGwdbQ9mKIeXGI7VxCSV
 vfPUJvnxgsOKWvRDk/Q==
X-Authority-Analysis: v=2.4 cv=eubvCIpX c=1 sm=1 tr=0 ts=69dfd660 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8
 a=4DpnPWOeRWuCnonzwFEA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ob9zizlaQnsigDOfnzs6IVaYg01vCzLo
X-Proofpoint-ORIG-GUID: ob9zizlaQnsigDOfnzs6IVaYg01vCzLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

On device shutdown, make vfio_pci_core_close_device() call
vfio_pci_dma_buf_cleanup() before the function is disabled via
vfio_pci_core_disable().  This ensures that all access via DMABUFs is
revoked before the function's BARs become inaccessible.

This fixes an issue where, if the function is disabled first, a tiny
window exists in which the function's MSE is cleared and yet BARs
could still be accessed via the DMABUF.  The resources would also be
freed and up for grabs by a different driver.

Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
Signed-off-by: Matt Evans <mattev@meta.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

Jason,

Added your R-B from https://lore.kernel.org/kvm/20260330132952.GS310919@nvidia.com/

Thanks, Matt

drivers/vfio/pci/vfio_pci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ad52abc46c04..3f8d093aacf8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -734,10 +734,10 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #if IS_ENABLED(CONFIG_EEH)
 	eeh_dev_release(vdev->pdev);
 #endif
-	vfio_pci_core_disable(vdev);
-
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	vfio_pci_core_disable(vdev);
+
 	mutex_lock(&vdev->igate);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
-- 
2.47.3

