Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3413A6B6E;
	Wed, 20 May 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284409; cv=none; b=Bg5b20jOLQ4ggD5yg7QjTZ9sX6617xpZspQBUmBAjJR7QRIqqgtQ+YG/yOI5x31PCOf0nww/2Bx0Um3ubNmqamoXc6biubKTpiH/rxaMOSRUO5Q2idhAYAbCZIsLW2L7deV2Akohxf5QKhN5281f0bJIETtsYmS+Kr4FFfcRmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284409; c=relaxed/simple;
	bh=vsVXOzX+eZdIz/SpvJEyplhhhAPnPHgd18pUAlvF5Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSFtJyBpC3PjNx8KkvS9wleBUtZvONn8kI83BG48B/8zTVEQRRbmkNMiVhm35h9glJWztCl1Hn9O1S0rC3u1zted0qD9XZqnB1TJyg880SbovGRTOMTMR5yx0ZwzQOGDFcOORQZApQzVynnpzzBcYHTbRH/7HdtsVUXbiiXA1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJi2Xsif; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJi2Xsif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284406; x=1810820406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsVXOzX+eZdIz/SpvJEyplhhhAPnPHgd18pUAlvF5Rk=;
  b=OJi2XsifYKEx5I/inc5HA9ptFnIZKzhokV+2tPAbq/YMj3YF1FhvFCqW
   qBUyllFnv0KqRCzvNgCNNblPXUk93Ls4soJj+KCRcPNjpX4/gCfke7sQo
   gp27uPBAocYW/1zinbNMKl2hLk/lU8CK/l4532rclqdYSlxvkIZaYzys8
   FHeO6DFNHFY6mzS+Q+s2p+WNmUlJIaVImV9FYCbJKS7J3fD7J366dvSS0
   pUFtuTprB3LykLc5fO8B3Qgxte5xQZCSOGUAtxUzWlqt56uhcy9CmuDbK
   q3Jhg4O0eWg75nlohA8Di192xsAcJoZuo1A4tpY38UFS0tBDnTR181bIZ
   w==;
X-CSE-ConnectionGUID: ZCejHnOcSA+O6n1U9crd8Q==
X-CSE-MsgGUID: TS/iozRhRh2umPqbqiID/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146419"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:05 -0700
X-CSE-ConnectionGUID: 6acRzcItSce0dn3NDOrwIg==
X-CSE-MsgGUID: z72y8QSlT2yRZTdichrdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923680"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:02 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v10 04/25] x86/virt/tdx: Move TDX_FEATURES0 bits to asm/tdx.h
Date: Wed, 20 May 2026 06:38:07 -0700
Message-ID: <20260520133909.409394-5-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will add support for new TDX features exposed as
TDX_FEATURES0 bits. The presence of these features will need to be checked
outside of arch/x86/virt. So the feature query helpers, and the
TDX_FEATURES0 defines they reference, will need to live in the widely
accessible asm/tdx.h header. Move the existing TDX_FEATURES0 to asm/tdx.h
so that they can all be kept together.

Opportunistically switch to BIT_ULL() since TDX_FEATURES0 is 64-bit.

No functional change intended.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/20260427152854.101171-17-chao.gao@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/20251121005125.417831-16-rick.p.edgecombe@intel.com/ # [2]
---
 arch/x86/include/asm/tdx.h  | 3 +++
 arch/x86/virt/vmx/tdx/tdx.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 15eac89b0afb..e2430dd0e4d5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -32,6 +32,9 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+
 #ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e2cf2dd48755..76c5fb1e1ffe 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -85,9 +85,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.52.0

