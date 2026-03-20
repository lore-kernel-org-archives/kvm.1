Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A01C84A0;
	Fri, 20 Mar 2026 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773979417; cv=none; b=uWlC2nFF1YmMQTX5PWWd/5MOWSO0zE2IaMvCaKs2H57erA/kjdSapQrVLsobOFlZbwzwsNAsz5VcawPOf1LuvOs2dKihgyaywSdDcW+n9nTYsO3zewKPpA2EZCiSsJm2AXeqzgeCWBlPEx2Q/EtdW6hzjP8Cg2kWRKgYCH98nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773979417; c=relaxed/simple;
	bh=snaY+fSjBgR5sNLxgOSVbO2EQXnQ4xYoV9VyZu4budU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SWr66uXIVroHD3tj2jH5gnz/AAWH7xOrAHqzkXEB8Je1cd5o7NCHPx8VtijHqLZbQAvI+wOzltgHx0ILMepEY+FrmVgwx+g11qch9uy9OI3XVTfHyOi01vQQcfeEGnAF0YlpF1hQGBfNYV+N632MOThx1TwXK49ZMl0AMrSB3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egIcLoxr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egIcLoxr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773979415; x=1805515415;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=snaY+fSjBgR5sNLxgOSVbO2EQXnQ4xYoV9VyZu4budU=;
  b=egIcLoxr/OlegDrsYtG2EuyCBsXerJicfj7MST09qbsQ+RS6M8hLkL0B
   PajFSgLv2a1zO6urwSJJ7w/Cxx9ktrFYCzY/xuKrAfu2RmrpXFTiYtQBl
   zJLSyiH/q5Dkxr/Gyl+Qy/OYnGk5Yy86kjLU0VMc/5djIOb62GSW0gQSq
   knzRcEfHa7hg7kAVkVPMlWcgiBAJdcHJkWvou8jJsjZyEVkdD8IottwZH
   96PjyTtG2+/hZX1YeXTUsYTaz1lGB1wordLe4io77cmMZVSL7wvkJ3cci
   jG0IAOMFSNd3thFwfuEx6268kh4f2YKkl06M0WWoGridr2wbv6UtJcw/c
   w==;
X-CSE-ConnectionGUID: xGo/XbsoRFSd1x8sxen1Zg==
X-CSE-MsgGUID: V54i1iKeT+OFZrZuM+JyeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85688471"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85688471"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 21:03:34 -0700
X-CSE-ConnectionGUID: TRzDkONRTwSQvxyk9j2xYA==
X-CSE-MsgGUID: IGCmYFdgQeG7FOvst1fZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227885150"
Received: from ly-workstation.sh.intel.com ([10.239.182.64])
  by fmviesa005.fm.intel.com with ESMTP; 19 Mar 2026 21:03:31 -0700
From: Yi Lai <yi1.lai@intel.com>
To: yi1.lai@intel.com,
	Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vfio: selftests: Fix MMIO test failures in iommufd compat mode
Date: Fri, 20 Mar 2026 12:03:20 +0800
Message-ID: <20260320040322.487429-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the vfio_dma_mapping_mmio_test selftest when
running in iommufd compat mode.

The first patch fixes a segmentation fault caused by an uninitialized list head
when __iommu_map() fails (as expected for MMIO regions in iommufd).

The second patch fixes a test assertion failure by aligning the check for the
__iommu_unmap() return value based on the iommufd mode (native vs. compat).

Yi Lai (2):
  vfio: selftests: Fix iommufd compat mode __iommu_unmap() crash
  vfio: selftests: Align __iommu_unmap() check with iommufd compat mode

 .../selftests/vfio/vfio_dma_mapping_mmio_test.c        | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0

