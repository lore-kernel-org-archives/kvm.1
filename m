Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A563B47C3;
	Wed, 30 Sep 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746885; cv=none; b=aT976lDw4csdCPPVZLvsoNECnXcC3hEjS3hF4dV7UPcoFiHKUcQH9kPeC/l2lRvZ+Zxt+7iCInuaO9I0kMLwn9EgMLG1Q7g1CQazywZsD5/WyQvN8Unqdb5V+f+DX8sHk/FPVxTeDhto+3ah8L0dgQF2t62XrmD9agI4o9dK90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746885; c=relaxed/simple;
	bh=RNrQaJ9ZisYgkrcaPbEnmywd57d4FwQtZ1SfF+5GZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmNUhbZPs7Uy1vvnNPgfTL+thqGiAybYI6nJYh7w62AFXbg2q+/jq1jgHyr5cEol2hr2Q26Q3+cvU7W1roG9vXCiUXUsjLGCe2vk+lv52u6kXkPnu0gxvYmzoxDkQeNpVirwg8QvK3zCQsDaUv+kK/nCAHrGeMG5KvZ8ScDP/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1X4o3RY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1X4o3RY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746883; x=1822282883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNrQaJ9ZisYgkrcaPbEnmywd57d4FwQtZ1SfF+5GZi0=;
  b=L1X4o3RY/kWMUfNPbY3aXt8HYDHY9qIboaG7UTHKnA/slJqRfa20q0Dl
   LgGZwj5zpHH29LFHkgXI8nVp17CicIGhZcTN0z19RrTmb7bzscbPqNELb
   yFLlBuyHPd+3K2/hTwTevgpNTHKlZHscNi9026x410E94ago/RX5i2olI
   dDj3vJMPq20LN21i8ulVcMnvyOi3DENlJbywZufG9feASpkCa5FD5hIRC
   VfKmvIhArDdFK08AJGpZzHKf/s4GHI97zFbIQscYjzYDeyrXHEwQRfDO3
   w00dFuB5BqfOgmWI1mKJth4/JiTgD3tpLEUmak8BQK7G5wCwcQaEIhkdf
   w==;
X-CSE-ConnectionGUID: vFEn5qoXShqi9Bx4Ey3VOw==
X-CSE-MsgGUID: HQnwCcrlRXWKB6yTKCdHwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149142"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149142"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:05 -0700
X-CSE-ConnectionGUID: ihpuifHZTAygPoFdymmAsA==
X-CSE-MsgGUID: PhQFSmDFRe2rDBtUNiKZTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936442"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:04 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 10/10] x86/virt/tdx: Verify structure member sizes against metadata field IDs
Date: Tue, 29 Sep 2026 22:38:44 -0700
Message-ID: <20260930053901.22528-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260930053901.22528-1-chao.gao@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module reports its capabilities and limits as a set of metadata
fields, each identified by a field ID, and TDH.SYS.RD reads one field by
its ID. TDH.SYS.RD returns the value as a u64, but metadata fields are not
all 64 bits wide. A field ID therefore encodes the field's size into
bits 33:32.

The kernel mirrors these fields in C structures, and each member's size
must match the size encoded in the field ID. TDX_SYSINFO_MAP() stores the
member size and uses it to decide how many bytes to copy from the value
returned by TDH.SYS.RD. The size in the field ID is never consulted, so any
mismatch goes unnoticed. Declaring a u32 member for a 64-bit field, for
example, would silently store only its low 4 bytes.

Add macros to extract the size encoded in a field ID and check it against
the member size. The check happens at build time, so it catches a wrongly
typed member with no runtime cost.

BUILD_BUG_ON() cannot be used in a structure initializer, so use
BUILD_BUG_ON_ZERO() and add its zero result to the .size initializer. This
performs the build-time check without changing the stored size.

An alternative would be to leave the size bits out of the field ID
definitions and construct the IDs from the member sizes, which makes a
mismatch impossible. But the TDX module ABI definitions list the full field
IDs, and definitions with the size bits stripped would match nothing in the
docs, making them harder to verify. Keep the IDs exactly as documented and
check the size they encode against the C type instead.

AI was used under supervision to review code and workshop logs. It
suggested extracting TDX_FIELD_SIZE_CHECK() instead of open coding the
check in TDX_SYSINFO_MAP(), to keep the .size line from being too long.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v3:
 - Add background on the size bits encoded in a field ID. [Rick]
 - Add rationale for checking the size in the field ID instead of
   building the ID from the member size. [Rick]
 - Squash TDX_MD_FIELD_ELE_SIZE_CODE() and TDX_MD_FIELD_ELE_SIZE() into a
   single TDX_FIELD_SIZE(). [Rick]
---
 arch/x86/virt/vmx/tdx/tdx.c | 12 +++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e7d4fc3f350f..360875efb263 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -427,11 +427,21 @@ static int __read_sys_metadata_table(const struct field_mapping *mappings,
 #define read_sys_metadata_table(_mappings, _data) \
 	__read_sys_metadata_table(_mappings, ARRAY_SIZE(_mappings), _data)
 
+/*
+ * The size encoded in the field ID and the size of the destination C
+ * member must agree.
+ */
+#define TDX_FIELD_SIZE_CHECK(_field, _type, _member)		\
+	BUILD_BUG_ON_ZERO(sizeof_field(_type, _member) !=	\
+			  TDX_FIELD_SIZE(_field))
+
 #define TDX_SYSINFO_MAP(_field, _type, _member)			\
 {								\
 	.field_id	= _field,				\
 	.offset		= offsetof(_type, _member),		\
-	.size		= sizeof_field(_type, _member),		\
+	.size		= sizeof_field(_type, _member) +	\
+			  TDX_FIELD_SIZE_CHECK(			\
+				_field, _type, _member),	\
 }
 
 #define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e41fc5e4925e..b3694a80a0c8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -91,6 +91,13 @@
 /* Class "TDX Module Handoff" */
 #define TDX_FIELD_MODULE_HV			0x8900000100000000ULL
 
+/*
+ * Bits 33:32 of a field ID hold the log2 of the metadata field size in
+ * bytes. See "Metadata Field Identifier" in the Intel TDX Module ABI
+ * Specification.
+ */
+#define TDX_FIELD_SIZE(field_id)	(1 << (((field_id) >> 32) & 0x3))
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
-- 
2.52.0

