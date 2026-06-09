Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A93E5EE9;
	Tue,  9 Jun 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991687; cv=none; b=cZyUasNWwH/bGukR3ZDqp1v0/j3BDAQJimBcKAcy8AH90Aj1j7dLDWrLmxUti9ADG5454ZlueJTltJubXtMx2C7zSNKVna5fgwcVh3i+cX+495WkjRRXbmpHYpLLEWlIJzOpggQq4UtwcQvUgv3/KW0owxRhE11xHnKJ3kjX888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991687; c=relaxed/simple;
	bh=v7/05+Ji2lc0lGlXQc10fMuSgX+gsopN84nO8ztBPaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rld5n0uVJlVo/dmC08okI3uCLFJiEznjdoJEoXwpyFKQGRuxdJXl78xwdfk8Y+UOtfbbd69wfU5lDCkv6Ol5ieu5EW1ISi94fOF4jaIZAqFmlxsaUMJL+PxJs09xS6gqrG/ALD3kz/8YWxxdlaDX9pOuNICDJKn1Zk/WHsVY2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9IohcJ/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9IohcJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780991685; x=1812527685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v7/05+Ji2lc0lGlXQc10fMuSgX+gsopN84nO8ztBPaw=;
  b=Y9IohcJ/jA9sNhmQ2woajw2biyCDjbYySYmHQdiYcdsN+O0Swll/1ZxF
   m2XMfaiNbVhQQ/rKs3bL4TrzkHDG5HbgAJJ9uT93+vkz2vGTMEoe1ui2+
   IP1n5KMONvenSuMW4PIhAiBSsoEDraHoC6UNLdt0+JE+VkcL1Rrr/q/Z4
   YyU8BZDH8azbWTxAac1uCjhtu7OyfIW0DdwJandEJJT+Ka2VX8P+H4tBM
   aiQ+HtpAZas1Oabmhktr4bG0NaGnM0qhSrM49R5CAcLTkUPMBR1EgG9AR
   i1HUo4GakIcV5HsEVnjlexvGoy9YP0hvUwzTCfmnrxZzabvdG5NutvoyC
   Q==;
X-CSE-ConnectionGUID: NaCIXZylSbiMby6xA9KYJQ==
X-CSE-MsgGUID: WzhIM3/fQ1atUJNNlsxJeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93129892"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93129892"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:54:23 -0700
X-CSE-ConnectionGUID: XfHpeEiNQey2lLSxemklXA==
X-CSE-MsgGUID: 0ltfepN7ShS8hzFdaR7wkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="269485143"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:54:20 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH] KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf
Date: Tue,  9 Jun 2026 15:57:48 +0800
Message-ID: <20260609075748.612704-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the CPUID index into cpuid_func_emulated() and return no emulated
features for indexed CPUID leaves with a non-zero index.

KVM currently emulates CPUID features only for index 0, but
kvm_vcpu_after_set_cpuid() looks up emulated features by function alone.
As a result, reverse_cpuid[] entries that share a function but use a
non-zero index, e.g. CPUID.7.1:ECX, can inherit emulated features that
belong to index 0.  For example, RDPID, which is CPUID.7.0:ECX[22], can
be incorrectly OR'd into CPUID.7.1:ECX.

This is benign today because the affected bits do not correspond to
features KVM cares about, but it can become a real bug as new CPUID
features are defined.  Make the helper index-aware so emulated features
are applied only to the CPUID entry they actually describe.

Fixes: e592ec657d84 ("KVM: x86: Initialize guest cpu_caps based on KVM support")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd7..d92ce1e02cd3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -369,7 +369,7 @@ static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
 	}
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func, u32 index,
 			       bool include_partially_emulated);
 
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
@@ -399,7 +399,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		if (!entry)
 			continue;
 
-		cpuid_func_emulated(&emulated, cpuid.function, true);
+		cpuid_func_emulated(&emulated, cpuid.function, cpuid.index, true);
 
 		/*
 		 * A vCPU has a feature if it's supported by KVM and is enabled
@@ -1368,11 +1368,15 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	return entry;
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func, u32 index,
 			       bool include_partially_emulated)
 {
 	memset(entry, 0, sizeof(*entry));
 
+	/* KVM doesn't currently emulate any non-zero indices. */
+	if (cpuid_function_is_indexed(func) && index)
+		return 0;
+
 	entry->function = func;
 	entry->index = 0;
 	entry->flags = 0;
@@ -1410,7 +1414,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
 	if (array->nent >= array->maxnent)
 		return -E2BIG;
 
-	array->nent += cpuid_func_emulated(&array->entries[array->nent], func, false);
+	array->nent += cpuid_func_emulated(&array->entries[array->nent], func, 0, false);
 	return 0;
 }
 

base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 
2.46.0

