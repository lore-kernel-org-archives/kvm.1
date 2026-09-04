Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196451993F;
	Fri,  4 Sep 2026 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559213; cv=none; b=Q7Hmh5Qu1FJS+sYUn8ZrpijZqNN3nhGsdNa6A4TWMAYklGcjLWvesHrbC/C3w8iZvo4z85wQsxb+2kQlOz6KncCn4sH3pdGqRYaNM70viv1YVlFFHBa/zggFeabELyxGPLwUBuXcUa+lGU6DA2gL0XAlJO+m4Q79iwT/Q3lWPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559213; c=relaxed/simple;
	bh=1IbG4LD9mi4GQBxkBOPKkSIHANKh6JaOLeeR3c2M9/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dttoo6mGe1mggdgWXtOcM2QexjZmzz0nbZuji2AMd40XnvXULqBIv7kUpS/XMGV+DfhV7ods1hzBslr5sGD2okfFZKZJrnN2JyvHbVKlffU4uEqRQQnpFByzPOwg3i2ML50nQWmID2mwvqpArRTBeAiEL1IGcTaX1JEmaVWYErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZOWOCE0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZOWOCE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559206; x=1820095206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1IbG4LD9mi4GQBxkBOPKkSIHANKh6JaOLeeR3c2M9/w=;
  b=BZOWOCE0joDIg9vuHCr1IC6vbSCyTqIwf8RRHhvx1TShiPJPozqoUzbF
   cdMACCoWRsBwAGt57sEoDK/Xdm0syLu9uFj0oEAHHrpuo7Wxd/jzZFVeL
   xWgxBo19LPSgUFzPJL6sP6M/2SXEwubzt6Dx26k1Tdg75tfzFlBWrRdX9
   QQJN5VaznM3isYqlnz4WjqhMesGMqxTWUXgVMX9ADJQRRuKQ3rIyU+spE
   pKk9FnDXrra2DCstELQocAfk+/c8cP1gTV8G19ldKBJBUDLxrY5yasBGN
   grVD7cT4T8tNGUYUWuO3U9Aibzdd+DOr//iYDR87YaH4e/jx2hdR5jO+v
   g==;
X-CSE-ConnectionGUID: gTXotP3RTiiqH9zaOnDx+w==
X-CSE-MsgGUID: EdeKpc0FRti63y3bO5Zedw==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224880"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224880"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: HBvbopqNQAOupvHx5CbDpA==
X-CSE-MsgGUID: oEwJIpP9SVqFk7+4+5aUSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675052"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
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
Subject: [PATCH v11 10/11] Documentation/x86: Add documentation for TDX's Dynamic PAMT
Date: Fri,  4 Sep 2026 14:58:40 -0700
Message-ID: <20260904215841.303070-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand TDX documentation to include information on the Dynamic PAMT
feature.

The new section explains PAMT support in the TDX module and how Dynamic
PAMT affects the kernel memory use.

Some of the docs verbiage was provided by Dave Hansen (see link). AI was
used under supervision to review the docs.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/all/8e40862e-891a-4cad-8bb8-06ad25ad6061@intel.com/
---
v11:
 - Drop docs about kernel arg since arg itself was removed. (Dave)

v10:
 - Updated verbiage from Dave, but unify 4k to 4KB to be consistent with
   the rest of the series.

v7:
 - Spell out PAMT acronym (Binbin)
 - Drop Assisted-by tag and cover AI use in log (Dave)
 - Add info about kernel parameter
---
 Documentation/arch/x86/tdx.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 3303499ad4c6f..a36ea2bd4301d 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -200,6 +200,27 @@ reflects the TCB of the currently running TDX module and therefore
 changes after an update. By contrast, TEE_TCB_SVN reflects the TCB at TD
 launch time and is not affected.
 
+Dynamic PAMT
+------------
+
+The Physical Address Metadata Table (PAMT) is metadata in which the TDX
+module keeps data about each physical page (think struct page). Space
+for it is allocated by the VMM, consumes up to about 0.4% of system
+memory and needs to be supplied to the TDX module when the TDX module is
+first loaded.
+
+Dynamic PAMT is an add-on feature that allows a VMM to dynamically
+allocate the part of the PAMT which tracks 4KB pages. This reduces the
+amount of memory that TDX consumes while TDs are not in use.
+
+When Dynamic PAMT is in use, dmesg shows it like::
+
+  [..] virt/tdx: Enable Dynamic PAMT
+  [..] virt/tdx: 10092 KB allocated for PAMT
+  [..] virt/tdx: TDX-Module initialized
+
+Dynamic PAMT is enabled automatically if supported.
+
 TDX Interaction to Other Kernel Components
 ------------------------------------------
 
-- 
2.55.0

