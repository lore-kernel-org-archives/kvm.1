Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE91C84AB
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411157; cv=none; b=Ktz8GgrrD0lSQDZKCPnY1FpdHivk+3DHyrqoHPB2JqZTiI/lDUHwTSl99f4XP9zSW6ghmkvKY43BlM/vbLhqm7pqOXFX/ePwQN89a9Aagbcw/O4zfUlQRM1xwI6nezvx32T09zfq7zSNJHpuamlkBsIbsSEDVKL78IMHmXmlTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411157; c=relaxed/simple;
	bh=Nel6kawFnZVasgM7YYQB5WyfSs6jM3YP/OWaAuTim6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs5XjukNpGmAek5joKbUyEVGzZLdQKfxwy+ydeYw009KBD+uqUYUhxF++tf+oJj9SRi/XUKZDBM/BZvULZwn5gY6/Zr2QS3rSVQVf2nB+/VHSpub5icI0SE0PUNhxSCKGqD4yQjqwAWGiAbceHlySfwEl3XVu3SGiWGsD3e7CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrYYIrkx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrYYIrkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411157; x=1807947157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nel6kawFnZVasgM7YYQB5WyfSs6jM3YP/OWaAuTim6E=;
  b=MrYYIrkxZk6l07p6dFcIy5nZUpPxj1diECFQEGRG0ljSn/w6UNu7hTw7
   NcHxN/rk8L23g/va1VJYmn9LgjDMAXPcwFcLlr9OBh14d3AoPYo1fhyoY
   dqAYD+SgdkC6bdnmchh685Ub5GQYw7MJXhzzMntwRTUyEkzIh1EpcTIPj
   lLnFYWjsCGS/bRGe4TRt7ivkMEYYa2JHlfsd3aqTXMFcTQn/AIAZFH6ln
   /F2FgzqH3JqQEt+WAKL8IdpysDtKBMUsSXERi9ET8wOC5rD38Wp4KMTaP
   aPrddFkzGstCVVqkW2XdaL4ChNr7cZc7SDOeH3wbe43SSKQ3nMSr/WSZJ
   A==;
X-CSE-ConnectionGUID: DM87TxDkRUyztpWAC2JNCA==
X-CSE-MsgGUID: TrIA0QViQMaIGP+Qq1mVdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070238"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070238"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:36 -0700
X-CSE-ConnectionGUID: 1mrA+P2qR2C7TfD9RKZibg==
X-CSE-MsgGUID: oqiZ4F1VT9eevXaOMeY5Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284984"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:33 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 15/27] KVM: x86: Add infrastructure to track CPUID entries ignored in paranoid mode
Date: Fri, 17 Apr 2026 15:35:58 +0800
Message-ID: <20260417073610.3246316-16-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a structure and helpers to register and query CPUID leafs/registers
that should be excluded from validation in KVM's CPUID paranoid mode.

CPUID paranoid mode will cross-check CPUID values exposed to guests
against KVM's expected values to detect inconsistencies. Some CPUID
leafs/registers could be expected from paranoid checks, i.e., allow
whatever the inputs from userspace.

It could use kvm_cpu_cap_init_mf() to use 0xFFFFFFFF to allow all bits
for a 32-bit CPUID output register, however, it would require to add an
entry in enum kvm_only_cpuid_leafs and reverse_cpuid[], which brings
more COLs.

Each ignored entry specifies a CPUID function, an inclusive index range
(with index_end=-1 meaning "all sub-leaves starting from the
index_start"), a bitmask of registers (EAX/EBX/ECX/EDX), and an overlay
mask to scope the exemption to specific VM types.

KVM_MAX_CPUID_ENTRIES may be a bit oversized, but since it's global, the
waste of memory should be acceptable.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3bd9608770a9..e633707277f9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -45,7 +45,21 @@ struct cpuid_xstate_sizes {
 	u32 ecx;
 };
 
+struct ignored_entry {
+	u32 func;
+	u32 index_start;
+	u32 index_end;
+	u32 reg_mask;
+	u32 overlay_mask;
+};
+
+struct cpuid_paranoid_ignored_set {
+	u32 nr;
+	struct ignored_entry entries[KVM_MAX_CPUID_ENTRIES];
+};
+
 static struct cpuid_xstate_sizes xstate_sizes[XFEATURE_MAX] __ro_after_init;
+static struct cpuid_paranoid_ignored_set ignored_set __read_mostly;
 
 void __init kvm_init_xstate_sizes(void)
 {
@@ -372,6 +386,39 @@ static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
 static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
 			       u32 func, bool include_partially_emulated);
 
+/*
+ * index_start and index_end are inclusive:
+ * - Use 0 for both index_start and index_end if the function is not indexed.
+ * - Use -1 as index_end to indicate open-ended index ranges starting from
+ *   index_start.
+ */
+static void __maybe_unused kvm_cpu_cap_ignore(u32 func, u32 index_start, u32 index_end,
+					      u32 reg_mask, u32 overlay_mask)
+{
+	if (WARN_ON_ONCE(ignored_set.nr >= KVM_MAX_CPUID_ENTRIES))
+		return;
+
+	ignored_set.entries[ignored_set.nr].func = func;
+	ignored_set.entries[ignored_set.nr].index_start = index_start;
+	ignored_set.entries[ignored_set.nr].index_end = index_end;
+	ignored_set.entries[ignored_set.nr].reg_mask = reg_mask;
+	ignored_set.entries[ignored_set.nr].overlay_mask = overlay_mask;
+	ignored_set.nr++;
+}
+
+static bool __maybe_unused is_cpuid_paranoid_ignored(u32 func, u32 index, int reg, u8 overlay)
+{
+	for (int i = 0; i < ignored_set.nr; i++) {
+		struct ignored_entry *e = &ignored_set.entries[i];
+
+		if ((e->func == func) && (e->reg_mask & BIT(reg)) &&
+		    (e->overlay_mask & BIT(overlay)) &&
+		    (index >= e->index_start && index <= e->index_end))
+			return true;
+	}
+	return false;
+}
+
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
-- 
2.46.0

