Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69274CA287;
	Wed, 13 May 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685125; cv=none; b=i2DU/MKwEGZA532t1uG4m05Qo+Q4p+KIjHrLFKr3VbuiS+yGd2GxkkJEvqZZUeTzJR/HzEkHpK75s2lRcQI8O5Mb9XHy6rjDAog9KCwJ9MSxzM3UvUH8ut2stMze77eLnAW6sxs50sqrn++Jyn8CxopLa5MKW9kkoRktXZtorrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685125; c=relaxed/simple;
	bh=g7DBKzISsVeAPEr5fRf6vFci06L9JPnHLfj1n6CF7wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJgoJ8QkqoMlAZ1PyjCEa/d+u5Tj0UuwRyRLQ/93sTbFsgDf9qFCo7lL6VBLmiYvO9VM6e+xIxvBdo08us7vXAPQD2tPhZPJYI4/00UiKfQmH3xDvUZEq7bDmt/jW7/2xyZsClKrIfcW3e1Mp/xQqO+eAghOq8rUV+FiQLVSWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePpBJbLT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePpBJbLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685124; x=1810221124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7DBKzISsVeAPEr5fRf6vFci06L9JPnHLfj1n6CF7wg=;
  b=ePpBJbLTJ+t/0cGMMe9aNv4M4mwkO9NiunZj2re+4bru6G/P+rF51is9
   2huSSPLOIuZip9k+tO2b5WGyxYxt4BVYo6g2L/X02uQBSlvlLj6+RAGDM
   CA6Uj/ZJihZbNeY69TecuYxGSTP7e4SFGCpi2ryEWTN7NC4C/VTz5I/Id
   ZwPPIMcsBJUUVnFCjKGjNIwgN6DUjKgKbD+9/vWL+Qg2yEPuADqdIbKy2
   s4NJ3Kuep2c7x5FJ4sEEP7Tlblufmil7A7n33/YUwO5zcESEaMW5u5kCi
   T5Y+g3DC9GSNDCfwPScK3xM7j+CaxNRZJdTDb8DnhTRa2oXa/VPl7SnmL
   w==;
X-CSE-ConnectionGUID: YNMzsG2pQ1CsfjChsnRDmQ==
X-CSE-MsgGUID: JU8csZH3Ru2yWe88fWqMgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921830"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921830"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:12:02 -0700
X-CSE-ConnectionGUID: gA4HYUfQQd62goYNWsZYTg==
X-CSE-MsgGUID: 1fW5cWnpS/eV6H0ihhBZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716934"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:12:01 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v9 23/23] x86/virt/tdx: Document TDX module update
Date: Wed, 13 May 2026 08:10:06 -0700
Message-ID: <20260513151045.1420990-24-chao.gao@intel.com>
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

Document TDX module update as a subsection of "TDX Host Kernel Support" to
provide background information and cover key points that developers and
users may need to know, for example:

 - update is done in stop_machine() context
 - update instructions and results
 - update policy and tooling

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 Documentation/arch/x86/tdx.rst | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 1a3b5bac1021..9d2b7db166b5 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -73,6 +73,40 @@ initialize::
 
   [..] virt/tdx: TDX-Module initialization failed ...
 
+TDX module Runtime Update
+-------------------------
+
+The TDX architecture includes a persistent SEAM loader (P-SEAMLDR) that
+runs in SEAM mode separately from the TDX module. The kernel can
+communicate with P-SEAMLDR to perform runtime updates of the TDX module.
+
+During updates, the TDX module becomes unresponsive to other TDX
+operations. To prevent components using TDX (such as KVM) from
+experiencing unexpected errors during updates, updates are performed in
+stop_machine() context.
+
+TDX module updates have complex compatibility requirements; the new module
+must be compatible with the current CPU, P-SEAMLDR, and running TDX module.
+Rather than implementing complex module selection and policy enforcement
+logic in the kernel, userspace is responsible for auditing and selecting
+appropriate updates.
+
+Updates use the standard firmware upload interface. See
+Documentation/driver-api/firmware/fw_upload.rst for detailed instructions.
+
+If updates failed, running TDs may be killed and further TDX operations may
+not be possible until reboot. For detailed error information, see
+Documentation/ABI/testing/sysfs-devices-faux-tdx-host.
+
+Given the risk of losing existing TDs, userspace should verify that the
+update is compatible with the current system and properly validated before
+applying it.
+
+A reference userspace tool that implements necessary checks is available
+at:
+
+  https://github.com/intel/tdx-module-binaries
+
 TDX Interaction to Other Kernel Components
 ------------------------------------------
 
-- 
2.52.0

