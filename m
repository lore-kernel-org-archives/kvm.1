Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED574343888;
	Tue,  4 Aug 2026 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843069; cv=none; b=SW0P4glzvpjhUHTMfSYv8mfJzhnSiO8AcIAESjN/fnKQgRlyWiUK74BCS7td6w5lWsy0AV83h272xPvUOww5NXnyalLYkDTT+mitiRtKnSfiSH/EJr282vGyTtUyJw3tSziMfyajMeXJ04p/ZUR2lvq0VyzRWqBV/RZo3k9lVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843069; c=relaxed/simple;
	bh=H4dytvN91/yFqwVRcg1SNaR9Jqkwytj5m2GncfcFwX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xt5XO+U3XNMja/hC9T0+AsWOv0Le0aUR81DHpL+DEvgNtZ0qYjgczKtZDuizwsnGycLGVCGYwzox33V8h9YCYyUNhz4seBMjJnGuhgYzWFJK/VsJLknTYOqvq/TJC5Wlzh8q8xy7v6CyZEWjoirdSGv083XIhrnEA7eEfiy0ugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+xuQzGW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+xuQzGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843067; x=1817379067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H4dytvN91/yFqwVRcg1SNaR9Jqkwytj5m2GncfcFwX8=;
  b=T+xuQzGWZP8HlqhiKKfruH1gKa0OJXbIvWeN3RtRjJHOVnIefG+TgzvN
   tBonRPsyoY9vmSx7SdgQIYKYCL6YJ0QYvT7i6M0c04MSASumHOLaCWNuk
   Wqh5UzBuhBNxtDxlHqXBsmf4WeyRdLTBgSPKEn0H57m7s4xA3Nt10vj72
   YjmqkSIlabNSYjC9fSt8+zs0+qhTJWRzL3Ne5kO2X71IvhxgHeOgsUeau
   0LPNKhMS1BNLT9T9WeP+p5zJ+u8EriT2YUAYenKA+IdwXBENNVF5dozNK
   k6ewdIGAZF7sA9damxlI6lnLkoNulCoPZxCXeMQ+7w3F26cfe9Xh50ldD
   g==;
X-CSE-ConnectionGUID: 9+V+xp9oT6WThMz5gixLdQ==
X-CSE-MsgGUID: HhLv2mltQGK5xOpAyBkK9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244230"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244230"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:07 -0700
X-CSE-ConnectionGUID: PCmTF6L9SoeYk1O3zH2n2A==
X-CSE-MsgGUID: pWL+IZe/Tk24LLCsHJ3Z8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323091"
Received: from jf.jf.intel.com (HELO 984fee019967.jf.intel.com) ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:07 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v1 0/8] TDX: Stop auto-generating the global metadata code
Date: Tue,  4 Aug 2026 04:29:28 -0700
Message-ID: <20260804112941.19894-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a long-overdue cleanup of the TDX global metadata, based on work
from Dave [1].  Patches 1-6 keep Dave's authorship -- I only reworded the
commit messages and comments, with no significant changes to the code.
Note that they are missing Dave's Signed-off-by.

Changes on top of the original:

  - Rebased onto the latest tip/x86/tdx branch
  - Converted the newly added metadata (tdx module handoff)
  - Fixed up the __init annotations. The version and handoff tables must
    not be __initconst
  - Refined the commit messages and comments: dropped forward references
    to later patches and stopped restating what the code already says.
  - Added two patches: cleaning up error handling in get_tdx_sys_info(),
    and turning the runtime size check into a build-time one.

The series is also available at:
  https://github.com/gaochaointel/linux-dev.git tdx-metadata-v1

---
The TDX module exposes its capabilities and limits through "Global Scope
Metadata" fields, defined in the Intel TDX Module ABI spec.  The kernel
mirrors a small subset of those fields in C structures under struct
tdx_sys_info, populated by reading each field via TDH.SYS.RD.

Both the structures and the code that fills them are nominally generated
by an out-of-tree script from a JSON file describing the module's
metadata.  That made it trivial to add a new field, but everything else
suffered for it:

  - The generated files are edited by hand in practice, for different
    reasons.  The VMXON rework added __init annotations to the readers,
    and the handoff metadata is read at module shutdown into a
    caller-local struct rather than into tdx_sys_info.  In-flight series
    will add more: DPAMT and TDX module extension metadata may only be
    read when the corresponding TDX_FEATURES0 bit is set.  Regenerating
    the files would clobber all of these edits.

  - The generated code is opaque to anyone who doesn't have the script
    and the JSON file handy.  Each field is identified by a bare 64-bit
    hex literal, so verifying any one line means cross-referencing the
    JSON file.

  - The script ships outside the tree, so reproducing changes requires
    fetching it from a mailing list link.

  - The structures are short and stable, so the script's value over
    hand-maintained code is small.

So switch to a hand-maintained implementation.  Name each field ID after
the spec, then describe the field-ID-to-C-member mapping as a table: one
row per field, pairing the named spec field ID with the C member that
holds it.  Reading is then a walk over the table.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxtable

Chao Gao (2):
  x86/virt/tdx: Clean up error handling in get_tdx_sys_info()
  x86/virt/tdx: Verify the C member size against the metadata field ID

Dave Hansen (6):
  x86/virt/tdx: Stop treating tdx_global_metadata.h as auto-generated
  x86/virt/tdx: Name the TDX module global metadata field IDs
  x86/virt/tdx: Add a table-driven TDX global metadata reader
  x86/virt/tdx: Convert version/tdmr/td_ctrl/handoff readers
  x86/virt/tdx: Convert td_conf reader
  x86/virt/tdx: Remove the auto-generated tdx_global_metadata.c

 arch/x86/include/asm/tdx_global_metadata.h  |  13 +-
 arch/x86/virt/vmx/tdx/tdx.c                 | 216 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  66 ++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 133 ------------
 4 files changed, 290 insertions(+), 138 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c

-- 
2.52.0

