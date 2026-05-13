Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2314DA559;
	Wed, 13 May 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685123; cv=none; b=MLjqh3LDJLi/ArxOVEuAS3lIZeKuViP9EDrV5cav0IKmNCIOQQk04o6/i7gXQ1seNFeLjbdnjKnsdo8CFYpky5lrnZFVn3uQwpE7oJAmaeaaE1xz6+XMOA4Ovr0RI2+dCY5KAvWffNTXCzCHmsCDsv6QZvxv906i230VMyxPIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685123; c=relaxed/simple;
	bh=OJs+uzAVPvyai7EjlSuZGq+u2Jdj5elwWlSDt98B6hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La348d77suRG8F0QxniYeT5i1XuVXwbUzYsh+iK9UKD1bHAF1jAVrNnM8k92MPPCccBDJFHG0c7IMlzhq0gPtXGamak0LdiCkpHBqZ/1rL6Sy06LKqTEzXwyxPniCncoJfWmuaxVBx5A6+ucLhU5URXMVxclkoyGPAsvrhWYafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/1iG2hd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/1iG2hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685120; x=1810221120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJs+uzAVPvyai7EjlSuZGq+u2Jdj5elwWlSDt98B6hc=;
  b=V/1iG2hdy+/flzUpmgIx+V72MgcF+NXniVmWKUG/vgMvJeS5D57o+2NZ
   UDpo/2tBt+PtFjOs4s08QzHAQFmBMvTGXuUZyrn31KlHtJX/e42hsTiyS
   L+FMR/DXftBWmmO5MnM+FOrYAqhk0thCVl079hAdCNJARtT1flIICRpbh
   nnQHYboEjnhom/XzLDRFfPUDQiiejhOIkQe6/lwGzDilfdgPJ9A24V/jy
   1QjbIZPENIeDm06OqsIge/XJPbtUhPMQXguP+ggoKJF8KsZxPmQCu9p5k
   MjiDhpiwitvU61w7c3Iel9Y02nEmKIR0vVzkaEKyE0VkTRSEeq/jaHv3M
   g==;
X-CSE-ConnectionGUID: BJ8Cg8ARTvK70HhosE8kdA==
X-CSE-MsgGUID: GmeuPqAMRI6H6FGIkSmgBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921790"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:58 -0700
X-CSE-ConnectionGUID: RsyfL3IoTOSbDecfprjXRg==
X-CSE-MsgGUID: MUniygxbSOygWicp/KzpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716909"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:58 -0700
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
Subject: [PATCH v9 19/23] x86/virt/tdx: Refresh TDX module version after update
Date: Wed, 13 May 2026 08:10:02 -0700
Message-ID: <20260513151045.1420990-20-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel exposes the TDX module version through sysfs so userspace can
check update compatibility. That information needs to remain accurate
across runtime updates.

A runtime update may change the module's update_version, so refresh the
cached version right after a successful update.

Drop __ro_after_init from tdx_sysinfo because it is now updated at runtime.

Do not refresh the rest of tdx_sysinfo, even if some values change across
updates. TDX module updates are backward compatible, so existing
tdx_sysinfo consumers, e.g. KVM, can continue to operate without seeing the
new values.

Refreshing the full structure would be risky. A tdx_sysinfo consumer may
initialize its TDX support based on the features originally reported in
tdx_sysinfo. If a runtime update adds new features and the full structure
is refreshed, that consumer could observe and use the newly reported
features without having performed the setup required to use them safely.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v9:
- don't print old and new version [Dave]
- explain why it's OK to hide changes from the tdx_sysinfo users [Dave]
- update versions in stop_machine context
- don't mention major/minor versions are idential across updates. That fact is
  not relevant here.
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 6 +++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7eb1b67af656..a04b69f77c6e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -67,7 +67,7 @@ static struct tdmr_info_list tdx_tdmr_list;
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
-static struct tdx_sys_info tdx_sysinfo __ro_after_init;
+static struct tdx_sys_info tdx_sysinfo;
 
 /*
  * Do the module global initialization once and return its result.
@@ -1307,6 +1307,10 @@ int tdx_module_run_update(void)
 	if (ret)
 		return ret;
 
+	/* Shouldn't fail as the update has succeeded. */
+	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
+	WARN_ON_ONCE(ret);
+
 	tdx_module_state.initialized = true;
 	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e793dec688ab..e49c300f23d4 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,7 +7,7 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
 {
 	int ret = 0;
 	u64 val;
-- 
2.52.0

