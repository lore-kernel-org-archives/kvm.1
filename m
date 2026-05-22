Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565A259CB2;
	Fri, 22 May 2026 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422720; cv=none; b=epl+Gt2GXZMHIlyOIFdg19iz7oegXlk4U7zC9hKEnDpn/hNQ6h3HuzSDSkpfB0JLbNm4SDWS3qSmgm8Bnu6A6YPu9JhkBIyAGgt2GGPq5a1FuQDONPQgmQWAiiF/9zjMX+D+db0Bd1G8zjeAJ45a5uDWpO+ZHbsG4LYj8I/fm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422720; c=relaxed/simple;
	bh=2md7VEOtbD6E+/wgTRyMaE87euFnnX56mA1cVXkGYQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXQaJxSRVQCe/B+NCssj8U2OU511wy8b2myEuksLKbnGqwoJmyIYYJNcSLvVoaEbtGxpPh+fZInwsKcqK6Zaub1MVFP7eO6pad18iLQGIZ8HDriXncWEycuUNXuQl4maWfO5rNVwoIzwTZVNc3YJwWGa7FreDDwGBDQcZFsAF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgV78VFG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgV78VFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422720; x=1810958720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2md7VEOtbD6E+/wgTRyMaE87euFnnX56mA1cVXkGYQw=;
  b=ZgV78VFGaL/26uCgS9R8GYcQkbjdDiQj82Xh5pUD9iAoNVeNsAPI/7PZ
   TvkCi1t9dqqwu9zSzvZl+pW0Q/cn6kssIkaUthz/YTeSEsh9xySUiSblv
   uxKVapEoUlhPT+d9UZJzC7cqNZYeN0H1+uJd8BGgf/KnayPuf0W447uGa
   86FN/u64+qZrqkExSpaRiB3KQbBMW8xh25cizdoLB/O84D7/OGHSF+8Bu
   BUMIQHFi/nXC4sZJwUg+noh6pTe6PozX0a/np3+9bIvj9OyBnPBIhRqQf
   uIuQpOeE7YpJuTT+40T2DZ0zxZ+t/5XW74KJZrKp7E3i4F8TQGFQxUVZE
   Q==;
X-CSE-ConnectionGUID: xR1MzQ4TTaOaO3yiiEPdBA==
X-CSE-MsgGUID: dYzq8eMzQpaVl8PDmLEBwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528849"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528849"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:16 -0700
X-CSE-ConnectionGUID: UoDSeMo5Q5mDxPBCKqIUtQ==
X-CSE-MsgGUID: +iaGczp/T/+OpuvIjyDAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757787"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:12 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 01/15] x86/virt/tdx: Read global metadata for TDX Module Extensions
Date: Fri, 22 May 2026 11:41:14 +0800
Message-Id: <20260522034128.3144354-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add reading of the global metadata for TDX Module Extensions.

TDX Module Extensions is an add-on feature enumerated by TDX_FEATURES0.
But for the Module's integrity, Linux requires that all features that a
Module advertises must have a complete, valid set of metadata, and the
validation must succeed at core TDX initialization time.

Check TDX_FEATURES0 before reading these metadata. If a feature is
advertised, a failure in reading associated metadata causes the entire
TDX initialization to fail, otherwise skip.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |  6 ++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  1 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 16 ++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 40689c8dc67e..533afe50a3f1 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -40,12 +40,18 @@ struct tdx_sys_info_td_conf {
 	u64 cpuid_config_values[128][2];
 };
 
+struct tdx_sys_info_ext {
+	u16 memory_pool_required_pages;
+	u8 ext_required;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_ext ext;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e2cf2dd48755..a5eec8e3cc71 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -87,6 +87,7 @@ struct tdmr_info {
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 /*
  * Do not put any hardware-defined TDX structure representations below
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c7db393a9cfb..3d3b56ef3d2f 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -100,6 +100,19 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_
 	return ret;
 }
 
+static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000100000000, &val)))
+		sysinfo_ext->memory_pool_required_pages = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x3100000000000001, &val)))
+		sysinfo_ext->ext_required = val;
+
+	return ret;
+}
+
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
@@ -116,5 +129,8 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
+	if (sysinfo->features.tdx_features0 & TDX_FEATURES0_EXT)
+		ret = ret ?: get_tdx_sys_info_ext(&sysinfo->ext);
+
 	return ret;
 }
-- 
2.25.1

