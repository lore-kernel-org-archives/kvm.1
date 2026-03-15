Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E63644BD;
	Sun, 15 Mar 2026 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583191; cv=none; b=JDn5you9Z1nOpXp+JSoAHSg68o72fRch17o0IhgtIticX+oDXht8RPEq+6whkFMhIGpNj9ujcIVL9y1mdvFX2nXeKkqkLWSZu30pR3yX1+lKIugFx5EEJVTbAILs5XHpqssg/VJmG3mf8Dejnv5/RRC08hZdw6wvmq73yl8PMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583191; c=relaxed/simple;
	bh=Yzu2x/DJWrsTvYoPcjRvw5DbCXExO+H80V5s63j7pOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5fI5YwbwjtpopIqp0tQMsHUI9MWv5AoQQvNxuEJC4SKqmY6pn4aR1nhlf41qsZ4JDoOmIQJZ8eRu2kUIvM5YyjT5abYjOO+si0KOdMu7wwABqZ/nCnuTFI7fYdMV5PIXYw2FDhq07HmrNDHllhviBjZHaHc3iZslpVBHXtu87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caUbQ/Q5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caUbQ/Q5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583190; x=1805119190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yzu2x/DJWrsTvYoPcjRvw5DbCXExO+H80V5s63j7pOo=;
  b=caUbQ/Q51Io4UCT7PEzkDowk1Y3RI23IwQ87DANpdplHnkc8OTothinQ
   JaR86oL+KWh+/VUDg7TiNmmNTK78/KM88M5aKXRojnGGQBrfUcnziz9UC
   gcYPB8TSSJarIyx5WNzIo7oM494frgAZ1oZpdc6dXat4nTWz7a7zP82nn
   P4Bczrmc1hwIgiqySnMpdubbxhapXid+V6b2KyXDi8Veah1y5/84fIU3z
   ae2pUooQ5S7vzBlHyfSK2mUgpP4Czby17C8dDcZWcav+cfmZqcYbGju++
   vPI1ndaxeYrYqQsHjsywEuZk3lub1hgTbcWQSHsX/U4KmChv3PMfulAcH
   A==;
X-CSE-ConnectionGUID: +qp/1q2CSoi7F6CW+VvhMg==
X-CSE-MsgGUID: zzN3KXuJTXW1UuuuxqV2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732559"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732559"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:45 -0700
X-CSE-ConnectionGUID: h/qkFZjUSGeEAe6Wdn23bA==
X-CSE-MsgGUID: l6XCRXPtRg6uj7zR3EN/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123083"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:45 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 19/22] x86/virt/tdx: Enable TDX module runtime updates
Date: Sun, 15 Mar 2026 06:58:39 -0700
Message-ID: <20260315135920.354657-20-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pieces of TDX module runtime updates are in place. Enable it if it
is supported.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 arch/x86/include/asm/tdx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 4c4f7acd4044..386097b2e01b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
@@ -112,8 +113,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	 /* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 static inline bool tdx_supports_update_compatibility(const struct tdx_sys_info *sysinfo)
-- 
2.47.3

