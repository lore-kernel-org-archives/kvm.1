Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE0353E30C;
	Thu, 15 Oct 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095723; cv=none; b=BaR5tz6Pi2eliZINdUffhaDZFzV7+3PMa9ZstTgUbASUbgpvZ4cpS/rgTgZ1OpZSeluTgotUOZx4LU6wvtKTz2b9SjyV557Z9ZtdqZXKJwVl6U2QNzBuo4wy2qyNWjvRW6RUQLcegGkuxgb57OxdLuFLOhCVgZRxQ5dzHN4c+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095723; c=relaxed/simple;
	bh=g8FXMCeHZLnxsXsspLx7xhXGvU/3I1ISfwf1ghL1qOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMvFLhBrisd1LhM4rPRh54JMJzfDI+zESCaGHL21iz6eixGx4AfTe8E9kJVo3aHX3Ju/jW5o5zYwrv5oLx+jVm1GJDdk8VngSuMGZdAodldpaBaVX31V6fiz8yth9WscNOPS8Ecvg9Cqwdme+PIPCpvSbYKlrdzH5jUvp08kcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4xVxxP5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4xVxxP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095721; x=1823631721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8FXMCeHZLnxsXsspLx7xhXGvU/3I1ISfwf1ghL1qOU=;
  b=f4xVxxP5RtxrGBOi2tMDXcxx9Dsv0WUHBCB2Vd+OFX4mWvKTYLy4pp83
   xpXcY2jOY1RdG9ai/WsPMO1fafxj+FWiHPGjzbrv/i56qacgGcNtmbPlc
   o8oTsoqugx0QsGTX3Ss4I72c+X7vXdSnjlqp9ibkqqYKXAJSOnPc0iJws
   i3QoIungUsdGt7EMLZVpaQXYvS5bAfrOElOdw3TBJunggy3dQ0a+dqzHD
   CXTPmzUnI4xeETzNYAlpgxPdlQCQUrYYQ9MQ0FwMHxcAmwQ7zVYX66hJo
   HpYRujlzz8zesHOxSyzI735YIDoUN6TTA7KwMEj58sbxkkmKvtwXEKzJ3
   w==;
X-CSE-ConnectionGUID: +hXA/PnaQj6RAb8o1CHdow==
X-CSE-MsgGUID: F1vOwYSXTFObb0EKV+3rIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911092"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911092"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:21:59 -0700
X-CSE-ConnectionGUID: 0tS4RtH7S4Sp5oMXFjBX7A==
X-CSE-MsgGUID: I4RJ5Fu/QTmlH3tqH4s1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844435"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:58 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 2/6] KVM: x86: Use linear_read_system() to read the TSS I/O bitmap
Date: Thu, 15 Oct 2026 13:19:36 -0700
Message-ID: <20261015201940.1655956-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015201940.1655956-1-sohil.mehta@intel.com>
References: <20261015201940.1655956-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSS I/O permission bitmap reads are implicit supervisor accesses which
are subject to Linear Address Space Separation (LASS) enforcement.
Though highly unlikely, if a guest configures a TSS base in the user
half, hardware would raise a #GP on access when LASS is enabled.

Currently, the emulator reads the I/O permission bitmap from the TSS by
calling read_std() directly which is inconsistent with other implicit
accesses in the emulator such as IDT reads, GDT/LDT reads and TSS reads
during task switch.

An upcoming change will add a check to linear_read_system() to catch
LASS violations. For consistency as well as to keep LASS enforcement
centralized, switch both I/O bitmap reads to linear_read_system().

Note, emulator_io_port_access_allowed() doesn't propagate faults, so
even though linear_read_system() will set the exception details they
will be ignored.

While at it, fix an off-by-one in the I/O bitmap bounds check to account
for the 2-byte read and ensure both bytes are within the TSS limit. The
SDM mandates a trailing 0xFF byte after the bitmap so any out-of-bounds
access would be all 1s (denying access). Make the change primarily to
ensure hardware fidelity. A correctly configured OS will not run into
this issue.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
v5:
 - Picked up Tested-by tags

v4:
- New patch

There could be a pre-existing issue here. It is unlikely that any OS
demand-pages the I/O bitmap portion of the TSS. But if it does, the #PF
details could get lost and the guest would get a #GP instead of a
restartable #PF. Propagating the #PF to the callers is a larger change
that is beyond the scope of this series.
---
 arch/x86/kvm/emulate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 15872e722af8..fbf47f5ae298 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2555,12 +2555,12 @@ static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
 #ifdef CONFIG_X86_64
 	base |= ((u64)base3) << 32;
 #endif
-	r = ops->read_std(ctxt, base + 102, &io_bitmap_ptr, 2, NULL, true);
+	r = linear_read_system(ctxt, base + 102, &io_bitmap_ptr, 2);
 	if (r != X86EMUL_CONTINUE)
 		return false;
-	if (io_bitmap_ptr + port/8 > desc_limit_scaled(&tr_seg))
+	if (io_bitmap_ptr + port/8 + 1 > desc_limit_scaled(&tr_seg))
 		return false;
-	r = ops->read_std(ctxt, base + io_bitmap_ptr + port/8, &perm, 2, NULL, true);
+	r = linear_read_system(ctxt, base + io_bitmap_ptr + port/8, &perm, 2);
 	if (r != X86EMUL_CONTINUE)
 		return false;
 	if ((perm >> bit_idx) & mask)
-- 
2.43.0

