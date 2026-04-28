Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3C341050;
	Tue, 28 Apr 2026 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353996; cv=none; b=Bri7CHmYXEPQmnapf7faNaONv8ExptlCA7T7r6ufn6sS6cwWMjTIcoc3LVQNJk2ytuustRADpAH50+GWefhYd2LqNSRvunjAa2Ohz9xk7S8XpdhceKZ5cNC/x0wI4JN+XB55FVFROg4ehOtDq7ULcjCLcnC0lfHNjTtbxkzGBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353996; c=relaxed/simple;
	bh=dag3Cqej1ikh8a10xryx/WQaVKBHh280meg151C1Wn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/RRoj7Hm1oWwczIJoe9LMmxer9lqdzn4ByRf3PcXGkxO7NmkZtXVeYt46FuzOgHc5aunKyRCZ/hxqkBi57GUGjPexpeOM9yIXcXp4mpahjOtY7nj0FDxZEMPL1V3HkQ4vZYAd319w/8Jq4HcNVB6Zz3C4Lis/aTebBKJ9vqo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhmeHlvn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhmeHlvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353993; x=1808889993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dag3Cqej1ikh8a10xryx/WQaVKBHh280meg151C1Wn8=;
  b=MhmeHlvn2CQpDdSE4cYs5EWtkIoRWnk+LMzgHqH9+cNECIqSbkdV8QDV
   ZCvHuw19A1DuZGBApmWtG1wNWKOrNXunOeVsBB9dx1Fh8IxcYItknBLBr
   wk+IIqmraiSdP+nVl3i3n7l9QMEc/HUnMwUoxLAJ3I+QpbqFbXqtpG0yX
   sqNUWP6z7r8Bt4gZIosqjFmFdYTxkb+uEmUukst9pMrj4q+5Kt+VCzutJ
   UH+v8TbEvTp5eZMons1J0FPVdI8ct48cLitym+Slimx5S04Uev/iuC+Ft
   xAnnzSPPjE8weD53WExu94CY0heNVJe7dE4Jr1BeuLy27PZ+4wXT/jHr4
   Q==;
X-CSE-ConnectionGUID: NewRrtXoRHKHWw+7HEihWQ==
X-CSE-MsgGUID: Ilfvpfo/SaiLYk4V5UtoBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131722"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131722"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:28 -0700
X-CSE-ConnectionGUID: 1axxFc1xTO6CwSLIjgRcDw==
X-CSE-MsgGUID: gBOXpCm5Sa6Ld7gr8VZueQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130210"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:28 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 12/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Tue, 28 Apr 2026 05:01:03 +0000
Message-ID: <20260428050111.39323-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the emulator context and GPR accessors to handle EGPRs before
adding support for REX2-prefixed instructions. Like VCPU cache, the
emulator can uniformly cache and track all GPRs.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Increase GPR number by CONFIG_KVM_APX=y (Sean)
---
 arch/x86/kvm/kvm_emulate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 0abff36d0994..b722bf20a59b 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -105,13 +105,13 @@ struct x86_instruction_info {
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
 	/*
-	 * read_gpr: read a general purpose register (rax - r15)
+	 * read_gpr: read a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 */
 	ulong (*read_gpr)(struct x86_emulate_ctxt *ctxt, unsigned reg);
 	/*
-	 * write_gpr: write a general purpose register (rax - r15)
+	 * write_gpr: write a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 * @val: value to write.
@@ -315,7 +315,9 @@ typedef void (*fastop_t)(struct fastop *);
  * also uses _eip, RIP cannot be a register operand nor can it be an operand in
  * a ModRM or SIB byte.
  */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_KVM_APX)
+#define NR_EMULATOR_GPRS	32
+#elif defined(CONFIG_X86_64)
 #define NR_EMULATOR_GPRS	16
 #else
 #define NR_EMULATOR_GPRS	8
@@ -375,9 +377,9 @@ struct x86_emulate_ctxt {
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
-	u16 regs_valid;
+	u32 regs_valid;
 	/* bitmaps of registers in _regs[] that have been written */
-	u16 regs_dirty;
+	u32 regs_dirty;
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
-- 
2.51.0

