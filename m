Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1A1C84A0;
	Fri, 20 Mar 2026 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979444; cv=none; b=LpB2WNubPE6dhGExsYAuSX8vyQcmYRRZyJmV/z+8o6AGd30oBT7P2itO1OFxK12OR4AQ0UrI9XylZ80C/w4VrM9WuCpgPtSzcbSSiEax4eEQ7ocYCz+dzYammI495+K9wKZAiNKhEDnUJmeiDtRaIh70baZOtCJHu4Z655+WkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979444; c=relaxed/simple;
	bh=v4TVmYNjh8hgyB2oT0oMALAa/nPVWHCpkQkwTtRx8MM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8x90ICSbFu5nn9v8w3xAYAkP0vo45ky1STg7pXb5vTZ7Z35JYc6lNELQoWT2epEdgSrS6dj1sp2RQJhSPLZrbTKAX8eA/OelBq+4WTGtZtdsd8AmhGTmIGQ2h2UulvUH5Ln1A6l+3DqDW8JmYmdhWMQeASGFpgaaJbg7MF/Z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgSJ+I+R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgSJ+I+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773979443; x=1805515443;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=v4TVmYNjh8hgyB2oT0oMALAa/nPVWHCpkQkwTtRx8MM=;
  b=hgSJ+I+RZ1lf/RQpE5d/Wy5Aw0vYuLBjBxmXMlNjtoKt12RwQkNTg6m1
   oZAgpsFe0dDKRjV4y2NLHzysqeP3KHxtpdUNWq1fcooUt8b83QqikqasT
   MBu0rrSFitLrbRDps/87I4+9yguWnyfMBkdjc3rN9mGgnvbki1xtV686A
   aDskTQFFYSRrWHNC5iKjVcdYPAeuB/5nRTa43VobBMQLS3VUDTDFINjUz
   1c6BiXbsMGjEMQgF+2buAd10CYeBLFbMoN6kE/hJF+NOrvtUEIFe+PnoK
   CipjOFCyDNZZ5GBXtyU69dhxm2vlqdB73KqhsDIWPFvKg2bKpxnTVIMNb
   w==;
X-CSE-ConnectionGUID: lOJ3TLwgTMafj3bZkQjQqQ==
X-CSE-MsgGUID: pJ0xIAkyReeyJyDd+gOOKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85688513"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85688513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 21:04:02 -0700
X-CSE-ConnectionGUID: S/3gUPFRQaC96aL6d+iarw==
X-CSE-MsgGUID: zVlsBHFCT/6HiKj3ED45/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227885221"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2026 21:03:55 -0700
From: Yi Lai <yi1.lai@intel.com>
To: yi1.lai@intel.com,
	Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vfio: selftests: Align __iommu_unmap() check with iommufd compat mode
Date: Fri, 20 Mar 2026 12:03:22 +0800
Message-ID: <20260320040322.487429-3-yi1.lai@intel.com>
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

When __iommu_map() fails (as expected for MMIO in iommufd modes), the
test proceeds to call __iommu_unmap() for cleanup.

The behavior of unmapping a non-existent range differs between iommufd
native and compat modes:
- Native iommufd returns -ENOENT (failure).
- Compat iommufd returns 0 (success), mimicking legacy VFIO behavior.

The previous code asserted that __iommu_unmap() always fails, which
caused test failures in compat mode. Fix this by checking the return
value based on the iommufd mode.

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 .../testing/selftests/vfio/vfio_dma_mapping_mmio_test.c  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
index 4f7ecdca0215..e6a2b2ff91f0 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -101,7 +101,14 @@ static void do_mmio_map_test(struct iommu *iommu,
 		iommu_unmap(iommu, &region);
 	} else {
 		VFIO_ASSERT_NE(__iommu_map(iommu, &region), 0);
-		VFIO_ASSERT_NE(__iommu_unmap(iommu, &region, NULL), 0);
+		/*
+		 * Native IOMMUFD returns -ENOENT and Compat IOMMUFD returns 0
+		 * for unmapping a non-existent range.
+		 */
+		if (!strcmp(iommu->mode->name, MODE_IOMMUFD))
+			VFIO_ASSERT_NE(__iommu_unmap(iommu, &region, NULL), 0);
+		else
+			VFIO_ASSERT_EQ(__iommu_unmap(iommu, &region, NULL), 0);
 	}
 }
 
-- 
2.43.0

