Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B93F54CB;
	Tue, 31 Mar 2026 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961025; cv=none; b=Hn8BWmNVsX7i3dPhJTemC4jilymxgobopMk0660zgB3bKUgdZMzt5td9ZJWeSA8Egi5TEKP/cql5AygY+p6wHtAOBpyi1rxGbfv+/dnqO1W0bBVAt4XL7EiI+cs+67iXXREU6IEGVb3zfl8XKJqyyfEl8wEEgoBxIvul8DRQtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961025; c=relaxed/simple;
	bh=S3d9W95aAm3aV0Jdu73JiNtI6xpUrDsl5gsbV6FJ+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1mvSt25zaH9YCO7Eh7ZGVHOUH5xK2jzdUnyLJ0scFVaWw9XGmW22LaPzyvDEdY2m0t9SG5Eo9dKGZyH9BoMN4jb30cRFt2xofWUYNzZ6Q6Mh30F1zNDk3juP+JIpIstUNauqIhqdVCGCcQDxCNczvfPboPOHMLGqiU8VEnYqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxXzbcA/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxXzbcA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961023; x=1806497023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3d9W95aAm3aV0Jdu73JiNtI6xpUrDsl5gsbV6FJ+DE=;
  b=XxXzbcA/VJo15ZaBUxy1hb9bW4OsDASwEodjDWL0eyRJX+YisMx34eIf
   cnGWmfcQbxum71m9p2kinxZe9aMP1Bbppa8ebRomFjsHSXh0m3WmGcBsU
   zf6CHqKd0oJGAlaVWwatkbvQlT64Dkp5sXpTRvACi/7AF4Jr0nQWQs585
   vnEtNfkPDCl1Z8kVmReVFglJJOD/R8qXx91vJ/wboDuJ3mBG25ZdiusR+
   3DHbRyZjGUSHwnRkRmxefPQ30nseTN//UIe0Vp4rxDCrz+Pe8pdG+XX87
   mOb4MrXlwi5WV8VDAP+HnOeEt77FB5UF1CjOM+P8TcJGCv7iTs4tIuI6v
   Q==;
X-CSE-ConnectionGUID: LzJMNuzORpSgE1XVOAd4Uw==
X-CSE-MsgGUID: VVm2OOYtQSK4MM/h7m3/nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084600"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084600"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:43 -0700
X-CSE-ConnectionGUID: 2/XXrTH5SxWF+tuaVRvEaw==
X-CSE-MsgGUID: Jc/vOhxFSgGU7bjftdFH9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492238"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:42 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH v7 20/22] coco/tdx-host: Document TDX module update compatibility criteria
Date: Tue, 31 Mar 2026 05:41:33 -0700
Message-ID: <20260331124214.117808-21-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TDX module update protocol facilitates compatible runtime updates.

Document the compatibility criteria and indicators of various update
failures, including violations of the compatibility criteria.

Note that runtime TDX module updates are an "update at your own risk"
operation; userspace must enforce all of the above compatibility
criteria.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v6:
 - improve the error scenario descriptions

v5:
 - drop "dead documentation" about tdxctl
 - add a note in the changelog clarifying that users update at their own risk
 - revise the error code for update limit exhaustion—it changed after
   dropping the related patch.
v4:
 - Drop "compat_capable" kernel ABI [Dan]
 - Document Linux compatibility expectations and results of violating
   them [Dan]
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index f7221f2e5fec..e1a2f3b2ea65 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -26,3 +26,50 @@ Description:	(RO) Report the number of remaining updates. TDX maintains a
 		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
 		Interface Specification, Chapter "SEAMLDR_INFO" and Chapter
 		"SEAMLDR.INSTALL" for more information.
+
+What:		/sys/devices/faux/tdx_host/firmware/tdx_module
+Contact:	linux-coco@lists.linux.dev
+Description:	(Directory) The tdx_module directory implements the fw_upload
+		sysfs ABI, see Documentation/ABI/testing/sysfs-class-firmware
+		for the general description of the attributes @data, @cancel,
+		@error, @loading, @remaining_size, and @status. This ABI
+		facilitates "Compatible TDX Module Updates". A compatible update
+		is one that meets the following criteria:
+
+		   Does not interrupt or interfere with any current TDX
+		   operation or TD VM.
+
+		   Does not invalidate any previously consumed Module metadata
+		   values outside of the TEE_TCB_SVN_2 field (updated Security
+		   Version Number) in TD Quotes.
+
+		   Does not require validation of new Module metadata fields. By
+		   implication, new Module features and capabilities are only
+		   available by installing the Module at reboot (BIOS or EFI
+		   helper loaded).
+
+		See tdx_host/firmware/tdx_module/error for information on
+		compatibility check failures.
+
+What:		/sys/devices/faux/tdx_host/firmware/tdx_module/error
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) See Documentation/ABI/testing/sysfs-class-firmware for
+		baseline expectations for this file. The <ERROR> part in the
+		<STATUS>:<ERROR> format can be:
+
+		   "device-busy": Conflicting operations are in progress, e.g., TD
+				  build or TD migration.
+
+		   "read-write-error": Memory allocation failed.
+
+		   "hw-error": Communication with P-SEAMLDR or TDX module failed
+			       or update limit exhausted.
+
+		   "firmware-invalid": The provided TDX module update is invalid,
+				       or other unexpected errors occurred.
+
+		"hw-error" or "firmware-invalid" may be fatal, causing all TDs
+		and the TDX module to be lost and preventing further TDX
+		operations. This occurs when reading
+		/sys/devices/faux/tdx_host/version returns -ENXIO. For other
+		errors, TDs and the (previous) TDX module stay running.
-- 
2.47.3

