Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138E1A6809;
	Fri, 20 Mar 2026 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968977; cv=none; b=AmLlbAwb8aXEzgIcBAGszYmp86oHq3z/VpVlgeQoZBEXGtVUCTEsw94kEAmUY0N2nNAOf6q3ewzHsLY8MrZPHWYgivJKivWBzb/Kl8cMAdwR2v2c3CNdeBnDUsD3VXc85hm1Wbx+7lCut69uMG+tlqwdQPsTPBPqf8iYSNOemGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968977; c=relaxed/simple;
	bh=Eh8u5fRl2jl7IiJCj/aoUOgKAuSG6seXnhZbnDfFHWw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=f6TOD404qGvLkj3Uyd4cqXc73VkA2wUVuSk/WWf2GvphOB/1JD4KUgRC7Vp89zJlNZUefbIca7BjeX4VgdG/oe+3lDMiHa7qto6Y34/Yms1iKdJ1br9IDKai5kcLprmI1QwjkZApGpLkKPT9kzUh0gLtsiouh8zANAPI3qoz5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHU/j16E; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHU/j16E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773968975; x=1805504975;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eh8u5fRl2jl7IiJCj/aoUOgKAuSG6seXnhZbnDfFHWw=;
  b=lHU/j16E/a8xqOtD768FLm6cxlnLk62Kb8ic1X36I6YGgty/SR21BleS
   EFc8Eu1XXp4TjJUgV/Mc9TQ+G1ZfFQxtKPHUfpuelyyMryLQUmowbVpw5
   c2S3nbZq3gze9WyWmthT75yTyJ1AgvnWPAXsJ5FJZFl9L7zOY0gNMeMbu
   U/yy3nbom1JZ5RXQ6Tcm4j8u/CA/IEkuUvft7gbyKY14xuTkjbHp5LH3W
   uxKkS4+DTJTMgfkDAvjL6oWgT1Fy5ntE83Z5ED1VUP2ezDvVaPyDEfkwu
   tb4xAvmvYGzv8j2MGAYFsG5IIYoV3qWchR1xlG6/LBa8L/lIu2yVg5fSU
   Q==;
X-CSE-ConnectionGUID: w3yVY2o0T++pI8/eTnPayA==
X-CSE-MsgGUID: jM1XH83hR7uDYsS4egSAGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92626658"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92626658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 18:09:34 -0700
X-CSE-ConnectionGUID: JkoDgQHeTmKyhIfb22RIHw==
X-CSE-MsgGUID: PzwUfweWQtiSxLPIf4sCJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220072732"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2026 18:09:32 -0700
From: Yi Lai <yi1.lai@intel.com>
To: Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alex Mastro <amastro@fb.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH v2] vfio: selftests: Support DMR and GNR-D DSA devices
Date: Fri, 20 Mar 2026 09:09:29 +0800
Message-ID: <20260320010930.481380-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the VFIO DSA driver test only supports the SPR DSA device ID.
Attempting to run the test on newer platforms like DMR or GNR-D results
in a "No driver found" error, causing the test to be skipped.

Refactor dsa_probe() to use a switch statement for checking device IDs.
This improves maintainability and makes it easier to add new device IDs
in the future.

Add the following DSA device IDs to the supported list:
PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 .../testing/selftests/vfio/lib/drivers/dsa/dsa.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index c75045bcab79..19d9630b24c2 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -65,9 +65,20 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
 
 static int dsa_probe(struct vfio_pci_device *device)
 {
-	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
-				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
+	const u16 vendor_id = vfio_pci_config_readw(device, PCI_VENDOR_ID);
+	const u16 device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
+
+	if (vendor_id != PCI_VENDOR_ID_INTEL)
+		return -EINVAL;
+
+	switch (device_id) {
+	case PCI_DEVICE_ID_INTEL_DSA_SPR0:
+	case PCI_DEVICE_ID_INTEL_DSA_DMR:
+	case PCI_DEVICE_ID_INTEL_DSA_GNRD:
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	if (dsa_int_handle_request_required(device)) {
 		dev_err(device, "Device requires requesting interrupt handles\n");
-- 
2.43.0

