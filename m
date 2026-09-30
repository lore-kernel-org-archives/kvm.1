Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA43B3C1D;
	Wed, 30 Sep 2026 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746866; cv=none; b=aBRuDdvEu2glfXo1r3ych1E71MWLXHrrzGPxaiUyOr1kGlz1doHtUQ2TO8N+zxeEqQidE9+tJ84mtBTg4/LeyZHfilAgNG+27mBDIxijxi5f5ntd5Jp0Z9KncoiiPPNA2x0pMbZcu7TWuYgot7U5awJuyxoS8dKGG7VEx6c4gZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746866; c=relaxed/simple;
	bh=z45gW+brVDg5UgglQ5xgsazTAaXc0WAH/dWe1K8Kt14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQZNuzmZCAEKGkM9ebscLRk4XyNDLFUp+MEOAI/8VgDyXg0nxM06gT4JtmZbHwVa2BLJd2JWL9SLWVXj2D8QnpKSGD+E7uMz/YDkCG1oA/tVoULzT+nRJRA8MiHpt1CEUIecJwhDrQsT0884vErfAnFkZjbvfUneY6kGXBbMrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUyRpq7l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUyRpq7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746865; x=1822282865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z45gW+brVDg5UgglQ5xgsazTAaXc0WAH/dWe1K8Kt14=;
  b=QUyRpq7lx9wcipFkAcLsIyOJ2yUW62+lOnCAHP5j6ux3TvcEX0f6JwRH
   uH4ITdGHL5TKUSaQ2Qq+79kciXznnlRsHbRnScBHpXKhLGeGYSTZgm8Xy
   HQodSt4dq2eFBwO/EOtC+aYM2uCJN40jM4Nkama8P5TkmRFLUxMNEb7XI
   DByJDJGJAaFK7r7DuoyxNS0lb1B8QEAp67o4395pE9QLjys7jUFbbEB77
   dEwHpUIca9SKyxHEpNIQ4xuS9pLmX287KNcGDqp826erp6f3Yt14moD/J
   y/DFbfGxTuL8T71/6hsEcipbqNR3+D68QO3Mz3IpwBmhTgMBsi0LiYosb
   Q==;
X-CSE-ConnectionGUID: DP4D/oUsRf+p9EhkA9Ka5Q==
X-CSE-MsgGUID: jm/3HYKSSEGMHX8+Tw/UNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149072"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149072"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:40:59 -0700
X-CSE-ConnectionGUID: jWICw+dLSOOUS5js3Cdfbg==
X-CSE-MsgGUID: ptnztgSvSAiHygYYjzN9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936389"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:40:58 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 00/10] TDX: Stop auto-generating the global metadata code
Date: Tue, 29 Sep 2026 22:38:34 -0700
Message-ID: <20260930053901.22528-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the TDX global metadata code. It has two goals:

1. Replace the generated code with a table-driven metadata reader.

2. Make the existing code easier to read and maintain, and simplify
   adding new metadata fields.

I dropped the RFC tag from this posting, as nobody seemed to disagree
with the approach in v2. Tony's suggestions, splitting the version
fields out so that tdx_sys_info can be __ro_after_init and not caching
init-only metadata, are left for a separate series.

Dave, please feel free to ignore this for now. Kirill, Rick, and other TDX
developers, please take a look. Reviews and tags are welcome.

Changes
=======

The biggest change is that the get_tdx_sys_info_foo() wrappers are
gone. Rick questioned whether a single-use wrapper around one
read_sys_metadata_table() call earns its keep, and Dave agreed it
is an unnecessary layer of abstraction.

Other changes:
  - Pass the field ID to TDX_SYSINFO_MAP() instead of pasting the
    TDX_MD_FIELD_ID_ prefix onto a suffix, and rename the
    defines to TDX_FIELD_*, so the names can be grepped (Rick)
  - Patch 8: Pick up Rick's Reviewed-by
  - Patch 9: Print the module version only after reading it succeeds.
    (Rick)
  - Patch 10: rewrite the changelog to add more background about the
    size bits in field IDs and also add an alternative discussion.
    [Rick]
  - Patch 10: Squash TDX_MD_FIELD_ELE_SIZE_CODE() and
    TDX_MD_FIELD_ELE_SIZE() into a single TDX_FIELD_SIZE() (Rick)
  - v2: https://lore.kernel.org/kvm/20260918132946.76533-1-chao.gao@intel.com/


Problem & Solution
==================

The TDX module reports its capabilities and limits through a set of global
metadata fields, each read using a 64-bit field ID via TDH.SYS.RD. The
fields are grouped into classes, and the kernel mirrors each class it
needs in a sub-structure of struct tdx_sys_info.

Both those structures and the code that fills them were generated by an
out-of-tree script from a JSON file.

The script was not the first approach.  Kai's first attempt paired each
field ID with its destination C member in a table and walked the table in a
loop to read every field.  Two pieces of feedback on it drove everything
that followed [1]:

  1. Compile-time type checking. Metadata fields have different sizes (u16
     and u64), so a common helper takes a void * and a size instead of
     a typed destination.

  2. The check that a field ID's encoded size matches its destination
     member ran at runtime, although both sizes are known at build time.

The discussion did not converge after several rounds of review. Dave noted
that, despite the void *, the size check provides the safety that matters:
it catches mismatched field and member widths [2]. That left one problem:
moving the size check from runtime to build time.

Before that was settled, the direction shifted to generating the code with a
script. At the time, the TDX ABI definitions were published as JSON, so
checking a field ID required consulting a machine-readable file by hand.
The script parsed the JSON and generated both the structures and their
readers [3]. Generation also made the size/type check unnecessary. The
field IDs and destination members came from the same input, so a mismatch
could only result from a bug in the script, which is less likely than a
mistake in hand-written code.

Dave concluded that the JSON experiment had failed [4] for two reasons:

  1. The JSON file is not stable. The CPUID config arrays here were once
     sized for a maximum of 32 entries, which has since increased to 128 [5].

  2. The JSON file is not authoritative enough to write code from by itself.

TDX ABI definitions are now available in human-readable PDF specifications
[6]. So, stop relying on the out-of-tree script and maintain the code by
hand.

Yilun later proposed a single table whose entries carry the offset and size
of each mapped member in struct tdx_sys_info [7]. That design does not
cover the new handoff metadata because it is not cached in
struct tdx_sys_info.

This series gives every class its own table: each entry pairs a field ID
with the member that holds it, and a loop walks the table. This also covers
handoff metadata, which is read into a local structure rather than into
struct tdx_sys_info.

The common reader still takes a void *, but each mapping verifies at build
time that the destination member size matches the size encoded in the field
ID. A field/member width mismatch therefore fails the build.

AI usage
========

I used LLM tools to review the patches and refine the wording of the cover
letter and changelogs from my drafts. I reviewed all suggestions and adopted
those I agreed with. For example, AI review suggested the
read_sys_metadata_table() macro, which avoids repeating the table name when
passing both the table and its size.


Testing
=======
Built each patch individually and successfully launched TDs.


Chao Gao (10):
  x86/virt/tdx: Add a helper to read a table of metadata fields
  x86/virt/tdx: Convert the version metadata reader
  x86/virt/tdx: Convert the features metadata reader
  x86/virt/tdx: Convert the tdmr metadata reader
  x86/virt/tdx: Convert the td_ctrl metadata reader
  x86/virt/tdx: Convert the handoff metadata reader
  x86/virt/tdx: Convert the td_conf metadata reader
  x86/virt/tdx: Remove tdx_global_metadata.c
  x86/virt/tdx: Use early returns in get_tdx_sys_info()
  x86/virt/tdx: Verify structure member sizes against metadata field IDs

 arch/x86/virt/vmx/tdx/tdx.c                 | 198 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  46 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 154 ---------------
 3 files changed, 241 insertions(+), 157 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c


base-commit: a49e2d257594931772ab8f0024708c3076f3aa1d
-- 
2.52.0

