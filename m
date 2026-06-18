Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE43B4EAD;
	Thu, 18 Jun 2026 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772003; cv=none; b=K8jCFiHXH2HLEjiV0PzGNfe8qS8XhHpE47zgrwyMrKJtgmayNpQDI/zmB55b4YfKyP9HUc4y4+m2alAa7LVT4TM98HE+ePA0/neayVTqGvHXzIAqE/EfscwW+6bJsVxbx8Odw97pFwqHQ42eYdbLpqHyXcrqE4CYPc7bEFDHVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772003; c=relaxed/simple;
	bh=xLmluGfg//xbU7AzG2DVmi33syzJcx5tY1yIzBhIVzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOFYAM6SFsLupYPuSCCbKVi81ObZo1/PICW7H2dgpVyo3QmGe+6rsVceyNB+heH6jIGZcWtwIljiq7izwveBkK8VTzwZoAvUKJmqgVX3vP917XQHTLFsZTiML8pCk6+7ywTRJHeM/ILPRcH2/PPNxeCKoNpPI1isZgcJhwJpc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNVp2yW1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNVp2yW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772002; x=1813308002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLmluGfg//xbU7AzG2DVmi33syzJcx5tY1yIzBhIVzY=;
  b=eNVp2yW1Rko4NhvXsRN5rrXsxGydC4u9s8AQtnYcmqYUmZIJHWyJFw5b
   O/QOmC9zLxTnjLFYPoEY+9gAoRuF+fs/DdEry+YTi3Q8AOpN8/D1u+qmv
   mrPJko6GAhWeOv/7kltyXOEHlnEfWAgQ8vuLhNSRmrDb5l4aFhs7mS87/
   pgb+YBhjlY1ELL47/jHXCa4XCnDIte5R8s1EFa2XeZuEqIEUxCZ74Bf2e
   T9z1MofXY9o2WAhhB6lLZwZjnX2cpve3Gowhy+jc0Nzq57SoM1uiEM8sY
   jg74Tby+9COKOQwS2kkKUcPzTaEeJqhQZAzswV7Ll2Bji4WLJaam/mhx4
   A==;
X-CSE-ConnectionGUID: jUYImSssRYKXLEdrfhohAA==
X-CSE-MsgGUID: 3esA6CSgQV6uSnb2uzUrQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584820"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:40:02 -0700
X-CSE-ConnectionGUID: QJ6WoQD2Q1GgZjiOfg0MGQ==
X-CSE-MsgGUID: oyC10arDSxa6BfVZL4up/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392443"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:57 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 13/17] x86/virt/tdx: Enable Quoting extension
Date: Thu, 18 Jun 2026 16:13:51 +0800
Message-Id: <20260618081355.3253581-14-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

The Quoting extension generates TDX attestation Quotes in the TDX
module, without using a discrete Quoting engine. Enable this feature by
requesting it in TDH.SYS.CONFIG and TDH.SYS.UPDATE.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 81e7b6b1dacb..01fb01313077 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1029,10 +1029,8 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 
 static __init void set_tdx_addon_features(void)
 {
-	/*
-	 * To add DICE-based TDX Quoting feature bit in tdx_addon_feature0 when
-	 * kernel is ready.
-	 */
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE)
+		tdx_addon_feature0 |= TDX_FEATURES0_QUOTE;
 }
 
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
-- 
2.25.1

