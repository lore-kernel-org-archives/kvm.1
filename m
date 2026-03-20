Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F1364944
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042612; cv=none; b=R1NJSlItem+yhMegZAJJSuGQmnmqJLYn4nZhBblyQRpk9gIc6cGfTKakWt+owo2mMKkiUQH4nMfqSsmNTM8Trh+P5MRNEat+p4lIxC32dZvsTCrzSecUuasPsUfC+xk1DJaL7EhtvKJSgzGdu20pnfyJ13AUF9JAwYkDlKD6Sl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042612; c=relaxed/simple;
	bh=ch1RwpBuJsRnK1AM3W34sfabfx+/SQ4H5f2dJXcuC68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3eaI87ZNAXsbszhV70AnLBNQSHB3rBbH6qg6VKazX0io0/PJdDoffriGa01qwgTLRZDNOL0T8+yBGj9oZjMRwSYSQWH9FrJqg0u7dFReqWIcenwYnw6mQ8iB9kEYp14p597ZX9RXdsL/Iiegp6n4YyuATadVabx8wRMb9KgkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXiUGe7D; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXiUGe7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774042611; x=1805578611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ch1RwpBuJsRnK1AM3W34sfabfx+/SQ4H5f2dJXcuC68=;
  b=XXiUGe7Dy3s8qZK03uinjOcL/Lo6SPS6/PMIK3xWm58xUa5xi93/SXRb
   /ibWPYzLjDlXdLRzjbp8LCGuPJC2zT/hfGKVjDyhD0z3BO+2tPZNYEbXM
   z7/u6EiDRTycC2UaowD6MeSCyC1scgaCEAnTdgXfFBGeGB0pNhxLf/xVW
   za7qCHz5pSJkg1TypCnVo6dqlTT8LEmCc3DSaTI1yROTi52Yi4sDrSIQl
   +QX6cR0T31fKQgpqwEeUWpeXVgFaUs0LU2ma4nDiIHSakKJkfTo98Bz5f
   VhoqmdId3a5EWwoUV8tmtcQT1FciwstJ+t7wxmN2kyu1CXrfDfGgCG2bL
   Q==;
X-CSE-ConnectionGUID: OXiYYor+R52QyXGVkORHyA==
X-CSE-MsgGUID: MogvbKfEQs+EHbdno5ku5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85837799"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="85837799"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 14:36:50 -0700
X-CSE-ConnectionGUID: 3kE374RKSLuL4r555qmreA==
X-CSE-MsgGUID: +euvSSK0RXORFVZTJzZayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="220291359"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa007.fm.intel.com with ESMTP; 20 Mar 2026 14:36:48 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: alex@shazbot.org,
	jgg@ziepe.ca,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com
Cc: kvm@vger.kernel.org,
	qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] vfio/qat: add support for Intel QAT 420xx VFs
Date: Fri, 20 Mar 2026 21:35:39 +0000
Message-ID: <20260320213622.88549-2-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

Extend the qat_vfio_pci variant driver to support QAT 420xx (GEN 5)
Virtual Functions (VFs).

Add the relevant VF device ID to the probe table.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/vfio/pci/qat/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index b982d4ae666c..7b4d8bb9bed8 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -677,6 +677,8 @@ static const struct pci_device_id qat_vf_vfio_pci_table[] = {
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4941) },
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4943) },
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4945) },
+	/* Intel QAT GEN5 420xx VF device */
+	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4947) },
 	/* Intel QAT GEN6 6xxx VF device */
 	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_INTEL, 0x4949) },
 	{}

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0

