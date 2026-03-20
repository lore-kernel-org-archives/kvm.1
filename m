Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2DA2D5C71;
	Fri, 20 Mar 2026 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979434; cv=none; b=pFk/z82FOWJ4UvHXtoLzn6XUFDGAtbLlBiNTy5KkmWR8FOlo8QVq+XTrBn7HnJgd7SpB1K+/vsv/NiUoH+E8DM1dTGtlZ6GxHo9OF0jzqiwuYY9YQU1DFg95elgB5Un/nd/npUDSgb5fU9AWpY6W7zOoJPqUdD9ljr9qTB2tTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979434; c=relaxed/simple;
	bh=92xLNYFXxkf133MqVUP+9mIohxfqEpXhSTZuPRD+mjg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU0osjskLnZreWyXJENmCENmYOvHU8oorez4YKjsDfFbrQ92ZJvK+Oj2++0+o1KRwvTSiWx8cSywhopLszf07KLl3hm3SfK4A3XYq0mF9ghgsiF8e4o3XS4L9OVa5UYYBijvLilZdIRSRba21es7c6Jj3AZ+7mJFchXphiy4/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXsAvh6U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXsAvh6U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773979433; x=1805515433;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=92xLNYFXxkf133MqVUP+9mIohxfqEpXhSTZuPRD+mjg=;
  b=QXsAvh6U9IJtP2WAavRVJ3mycbRNcJL7ffRZu1vzIpzpPgD/fOdLoAiK
   ze0eV2zYvz9jucXKMf2t+Z6SqQ4vo2OHiMHJ1qbnyvmt8qB2aOPCK1Zn9
   o9rY3+qJmPCGy97TEG6XFiS6NdvzbPaioun3hJj7QCrH95URKSde5eYIy
   oS3PUESv1ejjuGqLaaZF0StEl5RzcRlD4+UlJYLxzLVUF/CG020bAo1Fi
   kUb4Zc8o5H3IxnRckMqOiIPfXS4UYM1ui0EgLhM5R5rZH5fKfqcAzdknA
   zOe35BH/T1kM1NTs+4tLnAUkt8IswcWYr0M1d12ByPZmBep7DLVjuEdPR
   g==;
X-CSE-ConnectionGUID: H7YafZ6lRQ2GgD55sTj45g==
X-CSE-MsgGUID: PV/QDRTHSVCZfcM6+HYTmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85688493"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85688493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 21:03:51 -0700
X-CSE-ConnectionGUID: KFEIx0K4Qm+89YjcB5Cw8g==
X-CSE-MsgGUID: CUxuvRD0Ty2IcTrS+HNrpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227885198"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2026 21:03:49 -0700
From: Yi Lai <yi1.lai@intel.com>
To: yi1.lai@intel.com,
	Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vfio: selftests: Fix iommufd compat mode __iommu_unmap() crash
Date: Fri, 20 Mar 2026 12:03:21 +0800
Message-ID: <20260320040322.487429-2-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320040322.487429-1-yi1.lai@intel.com>
References: <20260320040322.487429-1-yi1.lai@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running vfio_dma_mapping_mmio_test in MODE_IOMMUFD_COMPAT* mode,
the test crashes with "Test terminated unexpectedly by signal 11".

The crash happens because:
1. __iommu_map() fails as expected for MMIO mappings in iommufd.
Consequently, the region.link remains uninitialized.
2. The test proceeds to call __iommu_unmap().
3. In iommufd compat mode, the kernel returns 0 for unmapping a
non-existent range.
4. __iommu_unmap() calls list_del_init(&region->link), dereferencing the
uninitialized pointer.

Fix this by explicitly initializing region.link using INIT_LIST_HEAD.

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
index 957a89ce7b3a..4f7ecdca0215 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -88,6 +88,7 @@ static void do_mmio_map_test(struct iommu *iommu,
 		.vaddr = vaddr,
 		.size = size,
 		.iova = iova_allocator_alloc(iova_allocator, size),
+		.link = LIST_HEAD_INIT(region.link),
 	};
 
 	/*
-- 
2.43.0

