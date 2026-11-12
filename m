Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458655;
	b=3d5TvXa9YEK4dF+lvAuGPktZfhllFid9oSdKi/3f8A23SUNjPLLsUCb3qYzJVq5laag9
	 sl2to9qeTUAny0P4WD876TPplOJZmPJ4gX0BuF2fO1UcF18gHs/FC5VoC5bfEVIu5XSsl
	 5sxYO9JilJGa97E9kxyhHUQZ3gi2oJ1wlS537FICVPwxtuwEVePkLb9W+tiTU9J8xjUmL
	 uQA9iZQ4nBSy0Mv/PITp6m6KPtkWjrVsI/Tc1LjG+QPcdOe1rxzd4LGFb9kpq1jkmdwzp
	 S49QQeyY69/rV8SOhp+wQXGTZ86TMOii2+qhUkswSV5kaOU6m1PoIgxWCuyq0Hac/tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458655;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b9IATihdsUeDWcB2EDjo2ew409lUFsbM4BAzHHENhFA=;
	b=C8/Su4EWJx2uh+h7cLSqAA+EcgCzSK3KO4/ewmYl78cr7P5ucHRUIypEhW8BdbOqr2JA
	 tfowMwCqp2e6slHRU8R4a2sy6agtzf/EUMq3mLCy++26D0P19Dd0c0wuvefKuezzSpslN
	 +ojqF60DHayFZMxMUqUoTd+hLwYrHEQLv+NBsCN2CKdfA21ggYgarhnZEc1FHGsXODG/q
	 UzNGJdkkIm7qlTm7XTqQMGa3MxBh/VbDn/Q2afoVs5L5dixYpAycDmmuZ7AIdeujdGTOS
	 WNIzP89DhxjbpEAEtgu8AnmrRYvMytwjF8TGk6U7pdluN33nQHYLnOrhvqahXYt459Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="D4y/V12v";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F9360A3821;
	Thu, 12 Nov 2026 04:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F9360A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D4y/V12v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458655; x=1825994655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/n461LFf6Wzh/8619aa8c9gmrFFhuey8oUAdfjkxGA=;
  b=D4y/V12vLKczQF67q2uDSugQL6ZxyNLBvTs8i2AhcEbD5MWVXiv9Icnn
   uPjhIm/ZdfPtheoE0rGaezZli4fIukLY+lf3bFcZ9gIsiMaEnQ/pVLNa9
   KDFABfXNhWcgARlyv5JhCEZnP75eahB1Sh15XsFWUSnT9wqhGT6x2bIWH
   2molCOoBDsjzr0nfNnx9lIwJFAzFuFzDgE7F3zS89UTKponMN0dJX+5rs
   OGwWv7eNErF7XadTb0agAkEGTnv/2PYOk2DVmeO9nxRD8uHp+eZS5pww0
   GGUX34czi0UohdBsZMDxAljiqkWvLjlbGayjfr7WxqtLZWTd/E63c4xnV
   g==;
X-CSE-ConnectionGUID: Ey9uhtgIQHadCZhocsBATA==
X-CSE-MsgGUID: LXcy++f9So67u0oUYBcc4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318379"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:15 -0800
X-CSE-ConnectionGUID: i3spI3aYQEGceWM6dvqMwQ==
X-CSE-MsgGUID: VYzlsUC3RFqqIjCz97fUnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728678"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:44:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 8/9] coco/tdx-host: Rename tdx-host.c to main.c
Date: Thu, 12 Nov 2026 12:30:53 +0800
Message-ID: <20261112043054.2664857-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
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

The tdx-host driver is about to gain more source files. Rename
tdx-host.c to main.c and build the tdx-host module from it, so the
following changes can add objects to the module without renaming the
main file at the same time.

No functional change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/virt/coco/tdx-host/Makefile               | 2 ++
 drivers/virt/coco/tdx-host/{tdx-host.c => main.c} | 0
 2 files changed, 2 insertions(+)
 rename drivers/virt/coco/tdx-host/{tdx-host.c => main.c} (100%)

diff --git a/drivers/virt/coco/tdx-host/Makefile b/drivers/virt/coco/tdx-host/Makefile
index e61e749a8dff..a90ffba13a49 100644
--- a/drivers/virt/coco/tdx-host/Makefile
+++ b/drivers/virt/coco/tdx-host/Makefile
@@ -1 +1,3 @@
 obj-$(CONFIG_TDX_HOST_SERVICES) += tdx-host.o
+
+tdx-host-y := main.o
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/main.c
similarity index 100%
rename from drivers/virt/coco/tdx-host/tdx-host.c
rename to drivers/virt/coco/tdx-host/main.c
-- 
2.43.0

