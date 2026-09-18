Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC14FDA4B;
	Fri, 18 Sep 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738318; cv=none; b=Xv4YxgVR0UqEiV9A1D2jgaPfM1rleuRNTGYCj2SYgVXH/iRZ6dLWBl68t0/hLYzkmI8skL2AwhLQMjbwSb7nFMjiSGMiBMATmmle0eUr7ZpfQPImF7r/kWBnGACpWyetTmp/xTIKBfhynIUg1Wc/pTqZNUcWiZD5Cz8muBRL93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738318; c=relaxed/simple;
	bh=MNmxRyRUy3Nzhgb9gzZzsOfr9IqYajZHJ+kbSSWtbJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptkq1TGoplQfoD7XofOI6YSbY1mEVYxU8K4/FjBva4y0XVngXJfUrannAPtfH+TpNBxWkWuv4PSrZBhTWmVyUHf1Jv1cKEQlz0aMhBD40AAwC22zbi3ZXd7mnXQW8qat9AFyCz0Q9cufPwl/vZCxCqwHjDCHwW48teegadURNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCu3p9SC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCu3p9SC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738315; x=1821274315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNmxRyRUy3Nzhgb9gzZzsOfr9IqYajZHJ+kbSSWtbJQ=;
  b=PCu3p9SCncEhyS7+6fdvfms6d1hNY3w2hZ0E1FKAF0eUPmhovSIttb17
   AP6Axgtr/TCvvqZ5/un0qmo8Qp9Qw8562Oy8sSg1cOsCt8h5wpawWDWoA
   13bG8h57/NG+VAcc/VMzOUta0CMlAyvi3yVgK0rEFo0VucVUnNcL/DxlD
   46tZ1O7DnFmTt8WePElZa82N8E6uUXsGU2Sur143tTShe1CNYXMf6KynS
   zpCsfP8vjd7w8XFcKXjl3Pw2uSBxgO7pUuAtOgkk8Gemsw7872yI3+4qG
   TvnWcsTeoNFUQYBDKp5VMOjQMoGmg/1vGdP1o6WA11FOt/gFRhOPL5weR
   w==;
X-CSE-ConnectionGUID: XLITr3cLQJuhPbzOiBNLHA==
X-CSE-MsgGUID: 0IbP5kyWQrycozzL0zP5DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776185"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776185"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:47 -0700
X-CSE-ConnectionGUID: dTQIsb7tSBm24NV2/yGdSg==
X-CSE-MsgGUID: 8B4hV1w3RLizDNzg9vbkAA==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:47 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC PATCH v2 10/10] x86/virt/tdx: Verify structure member sizes against metadata field IDs
Date: Fri, 18 Sep 2026 06:29:29 -0700
Message-ID: <20260918132946.76533-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918132946.76533-1-chao.gao@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A metadata field ID encodes the size of a single element. TDX_SYSINFO_MAP()
instead derives the copy size from the destination member, and nothing
verifies that the two sizes agree.

A wrongly typed member is a kernel bug: declaring a u32 for an 8-byte
metadata field would silently store only its low 4 bytes.

Add macros to extract the element size encoded in a field ID and verify it
against the destination member size at build time.

BUILD_BUG_ON() cannot be used in a structure initializer, so use
BUILD_BUG_ON_ZERO() and add its zero result to the .size initializer. This
performs the build-time check without changing the stored size.

AI was used under supervision to review code and workshop logs. It
suggested extracting TDX_MD_FIELD_SIZE_CHECK() instead of open coding the
check in TDX_SYSINFO_MAP(), to keep the .size line from being too long.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 12 +++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9d5a3296d3c0..6dc328561009 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -424,11 +424,21 @@ static int __read_sys_metadata_table(const struct field_mapping *mappings,
 	return 0;
 }
 
+/*
+ * The size encoded in the field ID and the size of the destination C
+ * member must agree.
+ */
+#define TDX_MD_FIELD_SIZE_CHECK(_field, _type, _member)	\
+	BUILD_BUG_ON_ZERO(sizeof_field(_type, _member) !=	\
+			  TDX_MD_FIELD_ELE_SIZE(TDX_MD_FIELD_ID_##_field))
+
 #define TDX_SYSINFO_MAP(_field, _type, _member)			\
 {								\
 	.field_id	= TDX_MD_FIELD_ID_##_field,		\
 	.offset		= offsetof(_type, _member),		\
-	.size		= sizeof_field(_type, _member),		\
+	.size		= sizeof_field(_type, _member) +	\
+			  TDX_MD_FIELD_SIZE_CHECK(		\
+				_field, _type, _member),	\
 }
 
 #define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 407aded3137a..17fdb682410e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -99,6 +99,21 @@
 /* Class "TDX Module Handoff" */
 #define TDX_MD_FIELD_ID_MODULE_HV			0x8900000100000000ULL
 
+/*
+ * Sub-field definitions of TDX global metadata field IDs.
+ *
+ * See "Metadata Field Identifier" in the Intel TDX Module ABI
+ * Specification.
+ *
+ *  - Bit 33:32: ELEMENT_SIZE_CODE -- log2 of a single metadata
+ *                                    element's size in bytes
+ */
+#define TDX_MD_FIELD_ELE_SIZE_CODE(field_id)	\
+	(((field_id) & GENMASK_ULL(33, 32)) >> 32)
+
+#define TDX_MD_FIELD_ELE_SIZE(field_id)	\
+	(1 << TDX_MD_FIELD_ELE_SIZE_CODE(field_id))
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
-- 
2.52.0

