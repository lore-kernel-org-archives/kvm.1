Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5640DFA4;
	Thu, 19 Mar 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905245; cv=none; b=YebO0c3WFaFGDSxGS4ffrl+KigQcdw2ak/+XerPtNZ7BY7w57jk65y07GcwEJ0Mo3fep9E/o4LiaG6V9BoSD2sGxRgvN/iqs06l1v52pSpZXrax1iVHOzvvUsUVfHp7ujyzyEiS4Bw0Suag2oU4gRnjhJZnYrdTtQp5fky18GiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905245; c=relaxed/simple;
	bh=XfgwlRH9bRWe1YgxwhhvFqLdS9d4ZI0v40xB5hKDQmk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gnCCaCe5BavxuPMZblJeDsoZBfGOC7cv/7oEHH9/j5RgGs9gORK72W2B0A71Nll8zFkzkp6/cFTkzyST+zsecCZYahluJf/yjFJAhQkKWlr+RaWNOxhFoSilbwTs45qRmlec5wVe8x9JzF9AVhGQuSG8xtyPTG0lfw9egTKR/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwY+zWPO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwY+zWPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773905245; x=1805441245;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XfgwlRH9bRWe1YgxwhhvFqLdS9d4ZI0v40xB5hKDQmk=;
  b=YwY+zWPOnOTbVHC2jS7eLINkGojVQV/uPoYERpMQo276BsamxT2KZY67
   g8ZhLTOu0HX8d2UYMqV0qqVDlapN65+k0P7PUQ4JiCWQlOhA4LzMki1tX
   4oni/hYk6IJhNGD9ry4jpthVs0o6YqFVdMzzK61KwLvVAPHtrLkc2dC+0
   oMuOW5u/RVT6sKy9z4AkscLToWYwa4aBmxafFgDiOHEOe5udi74q/i/Qa
   afAHvEjaTfs9PMyIqyVL18t8Gyv92/ZJutAqMhOpJvT/w7+Y+JasPUszj
   dzAtmc+ja3lX85tcEo08iUdN10bR11UCTVfglnNCTQD8GbUBY03aJULgb
   w==;
X-CSE-ConnectionGUID: TnFqstkiSJGncjiZ+MPFoQ==
X-CSE-MsgGUID: xnaVcSGrQ864/QVQFcdPkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86449060"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="86449060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:27:24 -0700
X-CSE-ConnectionGUID: /SqSSyWXR3CCUxG0LcUQFw==
X-CSE-MsgGUID: iiilBGJxQoK/9rRpiTq2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227577657"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2026 00:27:22 -0700
From: Yi Lai <yi1.lai@intel.com>
To: Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Alex Mastro <amastro@fb.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [PATCH] vfio: selftests: Support DMR and GNR-D DSA devices
Date: Thu, 19 Mar 2026 15:27:19 +0800
Message-ID: <20260319072719.472216-1-yi1.lai@intel.com>
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

Refactor the 'dsa_probe' function to use a switch statement for
checking device IDs. This improves maintainability and makes it easier
to add new device IDs in the future.

Add the following DSA device IDs to the supported list:
PCI_DEVICE_ID_INTEL_DSA_DMR  (0x1212)
PCI_DEVICE_ID_INTEL_DSA_GNRD (0x11fb)

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 .../selftests/vfio/lib/drivers/dsa/dsa.c        | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index c75045bcab79..0cbc7606d904 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -65,10 +65,23 @@ static bool dsa_int_handle_request_required(struct vfio_pci_device *device)
 
 static int dsa_probe(struct vfio_pci_device *device)
 {
-	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
-				   PCI_DEVICE_ID_INTEL_DSA_SPR0))
+	u16 vendor, device_id;
+
+	vendor = vfio_pci_config_readw(device, PCI_VENDOR_ID);
+	device_id = vfio_pci_config_readw(device, PCI_DEVICE_ID);
+
+	if (vendor != PCI_VENDOR_ID_INTEL)
 		return -EINVAL;
 
+	switch (device_id) {
+	case PCI_DEVICE_ID_INTEL_DSA_SPR0:
+	case PCI_DEVICE_ID_INTEL_DSA_DMR:
+	case PCI_DEVICE_ID_INTEL_DSA_GNRD:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (dsa_int_handle_request_required(device)) {
 		dev_err(device, "Device requires requesting interrupt handles\n");
 		return -EINVAL;
-- 
2.43.0

