Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45F3B19C2;
	Mon, 12 Oct 2026 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798628; cv=none; b=a8TAmf36AeEGb7nPHmkqnKJrdP0zH/k+0eADzaZ8GCwEvhFrz8HKlx/3MfSsJZVJ4OY5d9Huvs8gLDsyP5/z3kvMzCHaGa865yFyWDofnBIzOrNzaXrF2Gr3dj1dxMudQhc6lQcJN8HwugDJGOvIg4PdCADCvTUfaNs281ahyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798628; c=relaxed/simple;
	bh=c7vUApaBRcwqMhGhHH55s+qal+/nDfwHKF2DLYwzsOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSDvx6JkwVbk74hvxOzV8/J0n3ZWN5zuLWpuj5IkSJfgnYbU6Mf6vP+CM6WOMsTcoMwBaXr66cZ/VktPKkwnVhaq8fNEXTza1fjeMvup3bkcUEYYogkS+qSVcDdgdXSHdhWV1jk4bk+iTdzOz525DUEfkrsLrOnO/4cTqc932CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1ty/hSK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1ty/hSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798620; x=1823334620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c7vUApaBRcwqMhGhHH55s+qal+/nDfwHKF2DLYwzsOs=;
  b=i1ty/hSKKapm7jUkdeLqocvCzTDoI/Stsk9M+eOP/+/Dt8X8hFAEc52J
   AvxUpKPxKrtklfHYUVfqig9NTQKUUQ2Zp30N4fTNnRhvfpyYGol2Zktpm
   KCbY9hGJzc7INjptt78I1DJ+l/lFDhBRD3OyvudrtxZqRLOw8UJC2jmjo
   vaP8pMbBOBkhbETihVq47nTqn6Hted1feVK072xqyxD1Qg4qxVDNsMhom
   RgHoV6poTQ4PJNhoauJ6nX776im08EeuPHqWf/94xbnnkQG+0tWkYuZ9p
   eYEAGHdceo5hX3GnjZ/nyVt1DG3DrMmd+tSX5njNnt7bbInrKsMjKzpCn
   g==;
X-CSE-ConnectionGUID: itHDWQY2QYy5HK+Kic0HEw==
X-CSE-MsgGUID: rRU1LqFtQgS/sC6kJbkGUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="387977"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="387977"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:19 -0700
X-CSE-ConnectionGUID: h7J3Y6uHS3ef0obSH7zJ/A==
X-CSE-MsgGUID: 2sgKd1keRs6+/Isu2BnOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776813"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:20 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	rick.p.edgecombe@intel.com,
	nik.borisov@suse.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 00/10] TDX: Stop auto-generating the global metadata code
Date: Mon, 12 Oct 2026 02:47:27 -0700
Message-ID: <20261012094754.27702-1-chao.gao@intel.com>
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

Most of the feedback on v3 was about style and small nits, and eight of
the ten patches now have Reviewed-by tags. Patches 7 and 10 still need
review.

Dave, if there are no further comments, please consider merging this
series.

This series conflicts with the TDX Module Extensions series, which adds
new metadata fields. If needed, I am happy to provide a patch that
resolves the conflicts.

Changes since v3:
=================

The per-class macros are gone. Dave and Nikolay found them to be an
unnecessary layer, so every table entry now uses FIELD_MAP() directly.

Spelling out the full structure type in each entry would make most
entries 80-100 columns wide, and two would go over 100. As Yilun
suggested, FIELD_MAP() now takes only the part of the structure name
after tdx_sys_info_ and builds the full name from it, which keeps the
entries readable.

All entries now fit in 80 columns, with two of them wrapped onto a
second line.

Other changes:
  - Patch 7: Read the two cpuid_config_values[] entries with two
    explicit calls instead of an inner loop [Nikolay]
  - Patch 9: Reword the justification for printing the module version
    only after a successful read [Rick]
  - Patch 10: Encode the member size and compare it with the size bits
    in the field ID, instead of decoding the field ID with shifts and
    masks [Rick]
  - Collect Reviewed-by tags from Rick and Nikolay
  - v3: https://lore.kernel.org/kvm/20260930053901.22528-1-chao.gao@intel.com/

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

 arch/x86/virt/vmx/tdx/tdx.c                 | 190 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  52 ++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 154 ----------------
 3 files changed, 239 insertions(+), 157 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c


base-commit: 5b8212d45d99b77c84e3ad305a295e9e65d5ef20
-- 
2.52.0

