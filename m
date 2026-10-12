Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C040471CF7;
	Mon, 12 Oct 2026 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798663; cv=none; b=r/uam79uZd2Xz9aS+2wRsn0kshc9zrH1+2YIpTeQBwr3yM+dkK4/whZS0CQPJ/76dwYMveBxS8L/Lu7+0Mz0+flYkNwwPCGKrAsW9TzCz4BN5aKAfFu/V2MUlsZE/KVl0PuTT8ctX0YqJ6j4QvF1XDNr8zt4aY9scqU5sYCj8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798663; c=relaxed/simple;
	bh=Pmdd2yn4I5XQGtVhXccV2ksBLyQt7qMtf4BHGJI5UcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omqo5J+m8qmO5dMJFeMfGLqIm9envjWcA96CK9tA5ezgBgQCaD5ejYZzAkfxpJ1stNLHRiTi9j8NjkbGXsjtRsw51oc+Q0g7+UrtCg5M445wEX6J/rhtxCbAbheQpKFa5dJxwk9g77zNnT4lqXfCD20IIK/fcntJwo3x0xJkZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4Q8WJYM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4Q8WJYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798648; x=1823334648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pmdd2yn4I5XQGtVhXccV2ksBLyQt7qMtf4BHGJI5UcI=;
  b=d4Q8WJYMqIvM2r7bdKYSjG8tNHUr1sRyWpqaD3gu48ObScA46eLYdjLU
   gjxsSKhjYSzyfioACFTWvxyn5KYSTaZua+/qiWw0nlquwal7ZjBteIyLa
   bs90uP5Q/F2qs4Jr1uBFwdMXmyg418+zoieFbNXNVDuiQ1g5CeC134rkD
   wrWiRBTR9CNCd9IMRnmp1TErSIVvLWMLI5gylFoCsapE7xctg9+1KqOUH
   v3rHD1MaTO8qWKWRI73ZfG4+6H6gBSmSuI8AzwSVwEg3KP5PDkGbMa62F
   i2poTB665e4xkVJlEIeMrfVfmOMesZf4Vs84zlbaSdZnSOrOwZi9L4fvi
   g==;
X-CSE-ConnectionGUID: gdfwaxKyQrSiwNQuiKffdA==
X-CSE-MsgGUID: IRrZDFerSFK4dUHLWPk1Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="388061"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="388061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:26 -0700
X-CSE-ConnectionGUID: Gd9+Y4/HQ1moUidBmpzTnA==
X-CSE-MsgGUID: 6OqNjddVSUSTN+yMCtHIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776878"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:26 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	rick.p.edgecombe@intel.com,
	nik.borisov@suse.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v4 10/10] x86/virt/tdx: Verify structure member sizes against metadata field IDs
Date: Mon, 12 Oct 2026 02:47:37 -0700
Message-ID: <20261012094754.27702-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012094754.27702-1-chao.gao@intel.com>
References: <20261012094754.27702-1-chao.gao@intel.com>
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
must match the size encoded in the field ID. FIELD_MAP() stores the member
size and uses it to decide how many bytes to copy from the value returned
by TDH.SYS.RD. The size in the field ID is never consulted, so any mismatch
goes unnoticed. Declaring a u32 member for a 64-bit field, for example,
would silently store only its low 4 bytes.

Add a build-time check that the size encoded in each field ID matches the
size of the corresponding C structure member. A wrongly typed member then
fails the build with no runtime cost.

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
suggested moving the size check into its own macro to keep the .size line
short. Rick also used AI to write TDX_FIELD_SIZE_CODE(), which converts a
member size to the size encoding in the field ID.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v4:
 - Encode the member size and compare it with the field ID's size bits,
   instead of decoding the field ID with shifts and masks. [Rick]
 - Reword the comment above TDX_FIELD_SIZE_MASK().

v3:
 - Add background on the size bits encoded in a field ID. [Rick]
 - Add rationale for checking the size in the field ID instead of
   building the ID from the member size. [Rick]
 - Squash TDX_MD_FIELD_ELE_SIZE_CODE() and TDX_MD_FIELD_ELE_SIZE() into a
   single TDX_FIELD_SIZE(). [Rick]
---
 arch/x86/virt/vmx/tdx/tdx.c | 12 +++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1700577ad5ad..e762189c64bc 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -427,11 +427,21 @@ static int __read_sys_metadata_table(const struct field_mapping *mappings,
 #define read_sys_metadata_table(_mappings, _data)	\
 	__read_sys_metadata_table(_mappings, ARRAY_SIZE(_mappings), _data)
 
+/*
+ * The size encoded in the field ID and the size of the destination C
+ * member must agree.
+ */
+#define TDX_FIELD_SIZE_CHECK(_field, _type, _member)		\
+	BUILD_BUG_ON_ZERO(((_field) & TDX_FIELD_SIZE_MASK) !=	\
+		TDX_FIELD_SIZE_CODE(sizeof_field(_type, _member)))
+
 #define __FIELD_MAP(_field, _type, _member)			\
 {								\
 	.field_id	= _field,				\
 	.offset		= offsetof(_type, _member),		\
-	.size		= sizeof_field(_type, _member),		\
+	.size		= sizeof_field(_type, _member) +	\
+			  TDX_FIELD_SIZE_CHECK(			\
+				_field, _type, _member),	\
 }
 
 #define FIELD_MAP(_field, _type, _member)	\
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index e41fc5e4925e..54ba8f1527a0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -91,6 +91,19 @@
 /* Class "TDX Module Handoff" */
 #define TDX_FIELD_MODULE_HV			0x8900000100000000ULL
 
+/*
+ * Bits 33:32 of a field ID hold the field size code. See
+ * "Metadata Field Identifier" in the Intel TDX Module ABI Specification.
+ */
+#define TDX_FIELD_SIZE_MASK		GENMASK_ULL(33, 32)
+
+#define TDX_FIELD_SIZE_CODE(_size)		\
+	((_size) == 1 ? 0 :			\
+	 (_size) == 2 ? BIT_ULL(32) :		\
+	 (_size) == 4 ? BIT_ULL(33) :		\
+	 (_size) == 8 ? TDX_FIELD_SIZE_MASK :	\
+	 ~0ULL)
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
-- 
2.52.0

