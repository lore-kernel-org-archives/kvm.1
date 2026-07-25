Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420230E0F8;
	Sat, 25 Jul 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939016; cv=none; b=eUQ2IMEYME5X8LJYOEdRfnp6Po26Cc6dQJ2FOhEEBSjOFQ+a9oQZ0VliEkJ/ENmHYX1+uhF+SQY9yRvsN96xJ+5I4sLDlGCWv8ON75zdRcyd+3RvFGf03OBvTCORb9EPmkA3nLsCoOfN/tNuVQD8k1/a8h3ZGDvvpGG6pS5g8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939016; c=relaxed/simple;
	bh=yjQIMBRgzGAqNYs3xq8f13yTt3sK4whJmripRIABmoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEbKuQH79zWhrUyPm5tWeVU7TqJrk5f60wP/h8lnssT8yng787GqjkOVkAvDSw64da9jv3YAlPIGHkFxuKAfU/MJQnrwPdYG1jKjENfzYGDH6Liri+AhdBM3lP/qbqpOzvQGc8VfCqrcfWm4KlNFv8os+sU/c+uRg17YJqioM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M10ZZaEs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M10ZZaEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784939009; x=1816475009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjQIMBRgzGAqNYs3xq8f13yTt3sK4whJmripRIABmoU=;
  b=M10ZZaEswD1HHjsU+5qmyu3tn+Iupdd7S7bzu56rXuPDS32r81LxjJ/1
   XxXahTDD2KHnV1k+EF5ekK6ifCNDzwcfN0cMwg9wam9mEmvzjgTC/qQ0v
   zVKNSKUJAJGwrIE8feWODVuCIkcog5s1eJdiwOseVyfAG6BHIjlX25Yh9
   XJVeTh9ghs34njA1UY+0GeUCECwgkdvu43IVB3safwImpnZNv/4CSqvM3
   bCQTepkmuDbQT+Y20O/yL3JzQ/qOT/zGa/wgcRFtE+B1QkHIeqvxmzDNe
   1S2j50l45vG/p1F5NHWaOQ0L7rmlXNkQIVlOL3/U/vGwnIa+bRYgnl/pS
   g==;
X-CSE-ConnectionGUID: lVDuawcZR6awe+zfeP280A==
X-CSE-MsgGUID: fEZhkD9zTHWdHlU0foeu3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726192"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
X-CSE-ConnectionGUID: cYyQ38doTQyK6qIqIFjMNw==
X-CSE-MsgGUID: DfdOpB+5QcKle4Vi/07gww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359277"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v8 10/11] Documentation/x86: Add documentation for TDX's Dynamic PAMT
Date: Fri, 24 Jul 2026 17:23:00 -0700
Message-ID: <20260725002302.3337017-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Expand TDX documentation to include information on the Dynamic PAMT
feature.

The new section explains PAMT support in the TDX module and how Dynamic
PAMT affects the kernel memory use.

AI was used under supervision to review the docs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v7:
 - Spell out PAMT acronym (Binbin)
 - Drop Assisted-by tag and cover AI use in log (Dave)
 - Add info about kernel parameter

v6:
 - Add missing word (Binbin)
 - Use "::" instead of ":"
 - Make format of dmesg example accurate
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 Documentation/arch/x86/tdx.rst                | 28 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 49bcd7798876c..a0a7670246bc5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7519,6 +7519,9 @@ Kernel parameters
 			Valid parameters: "on", "off"
 			Default: "off"
 
+			For details see:
+			Documentation/arch/x86/tdx.rst
+
 	test_suspend=	[SUSPEND]
 			Format: { "mem" | "standby" | "freeze" }[,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 3303499ad4c6f..a1c2309230580 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -200,6 +200,34 @@ reflects the TCB of the currently running TDX module and therefore
 changes after an update. By contrast, TEE_TCB_SVN reflects the TCB at TD
 launch time and is not affected.
 
+Dynamic PAMT
+------------
+
+Physical Address Metadata Table (PAMT) is memory that the TDX module needs
+to keep data about each page (think like struct page). It needs to be handed
+to the TDX module for its exclusive use. For normal PAMT, this is installed
+when the TDX module is first loaded and comes to about 0.4% of system memory.
+
+Dynamic PAMT is a TDX module feature that allows VMM to allocate part of the
+PAMT as needed (the parts for tracking 4KB size pages). The other page sizes
+(1GB and 2MB) are still allocated statically at the time of TDX module
+initialization. This reduces the amount of memory that TDX uses while TDs are
+not in use.
+
+When Dynamic PAMT is in use, dmesg shows it like::
+
+  [..] virt/tdx: Enable Dynamic PAMT
+  [..] virt/tdx: 10092 KB allocated for PAMT
+  [..] virt/tdx: TDX-Module initialized
+
+Dynamic PAMT is only enabled when supported and the ``tdx_dpamt=`` kernel
+parameter is set to "on". The feature is off by default because TDX module
+internal details prevent Dynamic PAMT from working on all keyid partitioning
+configurations. When the TDX module is fixed to include these constraints in
+its enumeration of Dynamic PAMT support, kernel support can be changed to
+default on. For more information, consult the Intel TDX documentation about
+Dynamic PAMT.
+
 TDX Interaction to Other Kernel Components
 ------------------------------------------
 
-- 
2.54.0

