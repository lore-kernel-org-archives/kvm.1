Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827394;
	b=YCovBzb+zpl8h5AH3OpUq+OzlAb0TnHRk/4n25MqvApYWCi8h74rIgB46D8iIBgIW7wq
	 XykODduOSk7LenkvLh7/5ONfh5n9OB1DJPm30mrtDXPKzfdv75+ZlpVQQrB2TyjSIBaZs
	 77Pqkji3KnXWaQPS/aFe7YYesSivnGWF38GP8F/IDrRIn6PwbLY33erCz09sbAske4SqQ
	 mAAGyw0KOGIZqwwPjxp7xUlmJNUL0OQklPzMsezlV1/n2xZoeC6HSWv5MFj/mEzQektnR
	 Q70qe9CK571D43CPGJo/Q6tI1B/uT5tTc6GcwLJ3/5miScTUTGbQa3tvZ6I81FmUxgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827394;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I50HoopRxa3buonCeeRPTdblT7XpCyHv/F3JuXs3y4U=;
	b=b8K9DJvON9GFyemySSAvyjNTbDXQisex/ZWEZVJpcV1+WgkCiy1bXVJBIAVBKr0OV/+Q
	 aL/ED/qmv206geyZZ9Oxd5FQyoVcBLn55DvOGHZKiGUcqoVgj4wCDV6eAz1Es7e4lVcMh
	 XFxmcR/tQySMfRxVZumAcaVdQOTOVuF8qOUMvgsB84/n94dswF0GyVd0h8spo3BcL0/xJ
	 U7Eg5wbmBKoVOLyX+5idD1vxYPpeatpC5VETOZwEWOYT0JysP5gkLtJ/1GjbM48P2dA2m
	 /xytx8yddW7kGVwK8eZo8+EsgW6hr4TmUeuL5JJg60s44LHIJGnenXUmrwvvqB6bSrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M0VUsFTw;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A93606FA40;
	Mon, 16 Nov 2026 11:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A93606FA40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M0VUsFTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827394; x=1826363394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2AXhRaZ6LXJexE1z27G0MrbSL970RhGYxsDjZz3cj9k=;
  b=M0VUsFTwwHP5kQHQ/YYosnK0amSREq17X24OLpsrCIEJE6/DmxBJJmks
   GOrXCmciyLuuKi/AnRFvDACC8djU0eXxJX9kqv3NreeUewc2xRB7LjZaR
   GvfgxyoWF1mnrRwEl2IB0WRSv9UxjKMOI3Z5hI4S4IQBOmwHYxJoTHvZF
   06vdnw+RhEr3yJCDyOwNwL+5qycS/kivrRydPlLjwZBYk4dpasK4XlCEM
   9mSLc4G242GOHxXnCbmqVNu40q9sHScVu2yRQF8Zmsv9VcD0Z7kJVBscC
   Z13J6nqywKRIqEEsa5wMUoKEN7TVF5BVWqcTYTMhEmZEFL0Wc8tNqRUjR
   w==;
X-CSE-ConnectionGUID: sBee3eOpQjCh1bZC9jz7YA==
X-CSE-MsgGUID: 8ZIdOXiwRemWb86HzIewDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429612"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429612"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:54 -0800
X-CSE-ConnectionGUID: HHCspzSSRB+PBfABOgJyRw==
X-CSE-MsgGUID: qwSVI+qUS+u3QjTNG73DAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848125"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:53 -0800
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kevin.tian@intel.com,
	yilun.xu@intel.com,
	chao.p.peng@intel.com,
	baolu.lu@linux.intel.com,
	chao.gao@intel.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH 3/7] coco/tdx-host: Exchange SPDM messages through DOE
Date: Mon, 16 Nov 2026 03:10:21 -0800
Message-ID: <20261116111037.3478844-4-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261116111037.3478844-1-chao.gao@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module cannot access a device's DOE mailbox, so the kernel
relays SPDM messages between the TDX module and the device. The TDX
module produces and consumes whole DOE data objects, header included,
but pci_tsm_doe_transfer() takes only the payload and builds the header
itself.

Define struct pci_doe_header and struct pci_doe_msg to describe a DOE
data object. Strip the header from each request before passing the
payload to pci_tsm_doe_transfer(), and rebuild the header around the
device's response before handing it back to the TDX module.

An alternative is to add a PCI DOE API that takes whole data objects.
This would avoid the conversion, but the TDX-TSM driver would be its
only user.

Based on work by Yilun.

AI suggested defining the DOE header and object structures in place of
the bit operations, and dropping the endian conversions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 drivers/virt/coco/tdx-host/main.c | 49 ++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/tdx-host/main.c b/drivers/virt/coco/tdx-host/main.c
index 32755d70dac5..86299658ae45 100644
--- a/drivers/virt/coco/tdx-host/main.c
+++ b/drivers/virt/coco/tdx-host/main.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
 #include <linux/tsm.h>
 
@@ -73,9 +74,55 @@ static struct tdx_tsm_link *to_tdx_tsm_link(struct pci_tsm *tsm)
 	return container_of(tsm, struct tdx_tsm_link, pci.base_tsm);
 }
 
+struct pci_doe_header {
+	u16 vendor;
+	u8 type;
+	u8 rsvd0;
+	u32 length: 18; /* in DWORDs */
+	u32 rsvd1: 14;
+} __packed;
+
+struct pci_doe_msg {
+	struct pci_doe_header header;
+	u8 payload[];
+} __packed;
+
+/*
+ * The TDX module produces and consumes complete DOE data objects, but
+ * pci_doe() takes only the payload and builds the header itself. Strip
+ * the header from the request and rebuild it for the response.
+ */
 static int tdx_spdm_msg_exchange(struct tdx_tsm_link *tlink)
 {
-	/* TODO: implement the PCI DOE transfer */
+	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
+	struct pci_doe_msg *req  = page_address(tlink->out_msg);
+	struct pci_doe_msg *resp = page_address(tlink->in_msg);
+
+	size_t req_sz		= req->header.length * sizeof(u32);
+	size_t resp_sz		= PAGE_SIZE;
+
+	size_t req_payload_sz	= req_sz  - sizeof(struct pci_doe_header);
+	size_t resp_payload_sz	= resp_sz - sizeof(struct pci_doe_header);
+
+	void *resp_payload_addr	= resp->payload;
+	void *req_payload_addr	= req->payload;
+
+	u8 type = req->header.type;
+
+	int ret;
+
+	ret = pci_tsm_doe_transfer(pdev, type,
+				   req_payload_addr, req_payload_sz,
+				   resp_payload_addr, resp_payload_sz);
+	if (ret < 0) {
+		pci_err(pdev, "spdm msg exchange fail %d\n", ret);
+		return ret;
+	}
+
+	resp->header.vendor = PCI_VENDOR_ID_PCI_SIG;
+	resp->header.type = type;
+	resp->header.length = (ret + sizeof(struct pci_doe_header)) / sizeof(u32);
+
 	return 0;
 }
 
-- 
2.52.0

