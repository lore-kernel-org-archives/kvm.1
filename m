Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AA33EB17;
	Thu,  3 Sep 2026 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400299; cv=none; b=RkqLCEo1rY9A2hyrCGNc3o2EUN2XIxYFUvg35TXssDG5N6cNEw7w0Sl8a3gyT+eZSgh07C2ocfY2CwwwCW9A+5ykcskkJAAHYHt10M9WIkZqHRnIJ+y+kRniYKWl3Ivf+ZCnVPJS86h/FCt4L7rZMdcWG9LvdNNig4bj10CJRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400299; c=relaxed/simple;
	bh=/CB9ippxrpOsGJgcDiFoqTZKAywhBcGUCX3drlUDM9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5kbY+R+XQqlZ4jC3FBRxHFHhFr6r7DetdLWo1bxa1UNO+Imojx1wO1qc7ww+EsJy7NfGA+hFNWjT3ZwxswdMpwOCNi+NPp9oztE4F2DJop4bp0wuYOSxv8qaCe28bsLda0dtJvd5AwteaN2JOzvOkbhKVsmN1gH/E9h4PWPGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OP1nE7N8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OP1nE7N8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400297; x=1819936297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CB9ippxrpOsGJgcDiFoqTZKAywhBcGUCX3drlUDM9o=;
  b=OP1nE7N86jl5x6P7Zf5J9f88yC92DKQogYbjNxjNnWDggQI4i9XvCJR5
   gvBs892/AVPfJ/XZHdMvtgHj3b+kpehYgvOnxzoFnN0jIDpg2lhK3OTeo
   xojZdC6A/ax+HKD+xMyiBd3h/9rkoZCfOzef6+4TLC0a9iHh90lJSieat
   pTiDX2IgYNjp0sU+jnzKzd98mPpKWRj0wAvez+eqiDb4kYRBB7uzIh3tE
   aCPKsoINxb/EV6C+J0A3n5aijilQYbcS3nrJS5/yc/VKkbmRy9/FyYXlz
   QSu8G3LsVUOgn5+vvsdPh0ua7GQvtte1YjW41d4fjtS8UL3a+70bmft2S
   Q==;
X-CSE-ConnectionGUID: TQPxrIwTQSmOUHarVrPhnQ==
X-CSE-MsgGUID: M8QjSOtdS5SmUw9lcasxHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469185"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:24 -0700
X-CSE-ConnectionGUID: IDGYm3eoThaIO9Cc5yXNNw==
X-CSE-MsgGUID: YVKeJmFjRyicB83AcbjztA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770242"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
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
Subject: [PATCH v10 10/11] Documentation/x86: Add documentation for TDX's Dynamic PAMT
Date: Wed,  2 Sep 2026 18:51:12 -0700
Message-ID: <20260903015113.93343-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
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
v10:
 - Updated verbiage from Dave, but unify 4k to 4KB to be consistent with
   the rest of the series.

v7:
 - Spell out PAMT acronym (Binbin)
 - Drop Assisted-by tag and cover AI use in log (Dave)
 - Add info about kernel parameter

v6:
 - Add missing word (Binbin)
 - Use "::" instead of ":"
 - Make format of dmesg example accurate
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 Documentation/arch/x86/tdx.rst                | 27 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f32aa58f744a1..e7558b8382acf 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7589,6 +7589,9 @@ Kernel parameters
 			Valid parameters: "on", "off"
 			Default: "off"
 
+			For details see:
+			Documentation/arch/x86/tdx.rst
+
 	test_suspend=	[SUSPEND]
 			Format: { "mem" | "standby" | "freeze" }[,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 3303499ad4c6f..de09967ce8d8c 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -200,6 +200,33 @@ reflects the TCB of the currently running TDX module and therefore
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
2.55.0

