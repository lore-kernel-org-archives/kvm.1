Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88513F7873;
	Tue, 31 Mar 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961026; cv=none; b=seTjVksGEY49WADFwbJRaETnl1x8gwuANVYssfvPtnjMrIm0hCNXkoJY4oEEaAv4fZe9dgfl9F6esQ5+AX2svRro3MyNLK+Cjy9mA7Oc5IueGgqMTDiiOBpjj1afxfNKL00aqT5cbpIGInH5JLFotHqjQZS4nngUTCuvESMYXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961026; c=relaxed/simple;
	bh=9G7iw96WDPD6F4nZI1z+5J60uvmpCFGDTrWvIgc4x/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rK0Y5/nkcziPlhBmcVPis57COzyvbwlL6gKs5CAI0byMaTdiutb9+ukfgvu80t6YI6KUmGDK6gl9kvjdvFYRPK5xVPw70i+EaCoX0jtsR+krR0kwjjybwQTFG/X/ymM7/pD1zVyYg9W9dSZIQclDOcwszNNs2EczbPNcp7JAwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWp9tCb+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWp9tCb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961025; x=1806497025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9G7iw96WDPD6F4nZI1z+5J60uvmpCFGDTrWvIgc4x/o=;
  b=YWp9tCb+UgnwKMd93r6zDTWmjKH60wLtw+r07Vw0cjFWqgu0euBXFaRZ
   z3emO02PMdc66cVnhFKZdvmOOK5vwRn4yMI6X6WcHUZG5MTaUuf5hKwIT
   TEAdPxVn0xtbseEU2Uu4rtEzcPt/zv0CFS2TjSD+71C6oybkVPc2wu0tO
   krFFtRBV9UYvUMZ0GB55OK/nGjU5usFPcH3U9Pz5rrVWakjilpCci14aS
   OXVD+jl0K+CDXCbzn3KEfTsxEWvCugiEYIoNko2NIFr2ja1vlG+y44ILf
   uhZQSqkMoXySxf6g1XYsGEk+tGxmUD08V/CL0dSRpncp+xAhU2P0JsMnj
   w==;
X-CSE-ConnectionGUID: 6v5lFceqQKmFs3TDo9YB2Q==
X-CSE-MsgGUID: g10AeK+SRkaQPEEROy7ujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084606"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084606"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:44 -0700
X-CSE-ConnectionGUID: M6Fo87MtR0qJ8Bjj6exD8w==
X-CSE-MsgGUID: X8nk5c9FRveXXI84bVsWTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492243"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:43 -0700
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
Subject: [PATCH v7 21/22] x86/virt/tdx: Document TDX module update
Date: Tue, 31 Mar 2026 05:41:34 -0700
Message-ID: <20260331124214.117808-22-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
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
index 61670e7df2f7..fe9132d0f1fe 100644
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
+Documentation/driver-api/firmware/fw_upload.rst for detailed instructions.
+
+Successful updates are logged in dmesg:
+  [..] virt/tdx: version 1.5.20 -> 1.5.24
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
2.47.3

