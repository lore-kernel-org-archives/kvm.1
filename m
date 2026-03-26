Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA53C871E;
	Thu, 26 Mar 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514752; cv=none; b=KLjVAp+Mg2Lbfh/cZOtHehFJvdQxg+QpX9mHBErTH/HiUeVW2wKaS+eOjV6shQLGq2aEaL8lsoG7ThBe+nZ1gax7B65QTKAzjKofI+hKKizZu3+W3H/8uxHFi8RJC8ex9Z14ScQlfCKKw8k59KT8fhxhITtlSVGL8AVnF/IQR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514752; c=relaxed/simple;
	bh=aVM8yfRe32o0so7njMI++v91VUY7qPNEsBCIft9QDz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU4u0VIbTh2lKki9zMbB4nJ0vI36DuAvuJ7qjry0hMrfBExTfYlBvVN6/EPzX0KQXRQYwdtfRv3Rg0MTFlS7OBS7mpJ91l8bl3oaXFirwMehYNnHMk5UZkIKLEwI04Ab+ZPPh7lZ4gB4uZGLygx2xDbjCmgVg0VBWa3+Ulj4z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFHhF1v3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFHhF1v3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514749; x=1806050749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVM8yfRe32o0so7njMI++v91VUY7qPNEsBCIft9QDz0=;
  b=WFHhF1v3/AvSHwhxIap+l62BNuXNKdOE+wNDWDaoTg56nyy4DEGpxxHs
   SU9G9j0vzAFO0BVG9YLX8SjHGbu7yXARJG4ab+fU1LJqIVHKYcQO5Aihq
   wWhcUp6lUoMj9Qg4P2MIKdf9+lmyyb1HPMLlIcTY4P2RMTverVvm8tqxX
   a3u/Q/dVp4KoEBLDtTozv//jCC+eHlF2XsPST92jC2ClC3T/eNX2clxDZ
   aoChcwgKIQuIinmc+8E9wkmsCA9PvOePQwkkXc2IX38JpvMnyHYUjdg3v
   QLmYMQU6GDUkwhNpTUnGKmuGaZEW9fdkrg1u4awXGMtV8QQgygYsq9W4G
   A==;
X-CSE-ConnectionGUID: VObluEQHQbye1TLGtSR9pg==
X-CSE-MsgGUID: FfPsZe2ARoKHnbOt2d6AfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644777"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:27 -0700
X-CSE-ConnectionGUID: 4kcaJInwQuGuwWVIRUS1hw==
X-CSE-MsgGUID: q00bgPNDQIidTmXj2rFZtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967258"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:27 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
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
Subject: [PATCH v6 21/22] x86/virt/tdx: Document TDX module update
Date: Thu, 26 Mar 2026 01:44:12 -0700
Message-ID: <20260326084448.29947-22-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
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
---
v5:
 - use "update" when refer to the update feature/concept [Kai]
---
 Documentation/arch/x86/tdx.rst | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 61670e7df2f7..d4e257542d4c 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -99,6 +99,42 @@ initialize::
 
   [..] virt/tdx: module initialization failed ...
 
+TDX module Runtime Update
+-------------------------
+
+The TDX architecture includes a persistent SEAM loader (P-SEAMLDR) that
+runs in SEAM mode separately from the TDX module. The kernel can
+communicate with P-SEAMLDR to perform runtime updates of the TDX module.
+
+During update, the TDX module becomes unresponsive to other TDX operations.
+To prevent components using TDX (such as KVM) from experiencing unexpected
+errors during updates, updates are performed in stop_machine() context.
+
+TDX module update has complex compatibility requirements; the new module
+must be compatible with the current CPU, P-SEAMLDR, and running TDX module.
+Rather than implementing complex module selection and policy enforcement
+logic in the kernel, userspace is responsible for auditing and selecting
+appropriate updates.
+
+Updates use the standard firmware upload interface. See
+Documentation/driver-api/firmware/fw_upload.rst for detailed instructions
+
+Successful updates are logged in dmesg:
+  [..] virt/tdx: version 1.5.20 -> 1.5.24
+
+If updates failed, running TDs may be killed and further TDX operations may
+be not possible until reboot. For detailed error information, see
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
2.47.3

