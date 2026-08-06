Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433C386575;
	Thu,  6 Aug 2026 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979128; cv=none; b=gU3PqFOqSuCSMEyN92eBhIdYVK39TQiSxKuf54GRWTU4RnpFNn2d6+XhfbK4BwlSdvcNuGp023avXdOA9aFCanZIyC61NMnxezt95mEt53MWkAj+SWyv/0PtkznYOSOKUFSFdmi7wdAvot9LNDV5Dt7r25P9bfCFZdrC8x8rRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979128; c=relaxed/simple;
	bh=S2TitmZwd4JpU98ZMVHZQlXK31LYwmA7iDIOrBEUlk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/o1z7WYNH3U8SzckgTk5HE3srV6Z0qadj9LJ0qV0Ftew19YsAXEEH3bkf6cE+7NE2bmXU0Gh76RkqCWHz6/EsNEXXclqskExeHkYgnITloLzQDZ7gdO3Ena/JNB5lpvb3y+zTegRJpxYEHV1rx62efagJvkpnVGL2GAqY4ycEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSsNf+lR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSsNf+lR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979126; x=1817515126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2TitmZwd4JpU98ZMVHZQlXK31LYwmA7iDIOrBEUlk4=;
  b=SSsNf+lRh5lxSPCyZDHjMEfg37JEfHDM8qb0+7U72tcDBAhhjhm67QPY
   +YRAeC42WGwHE3ajCw9dJlscAfny0CijA5dc5L7Ya+9o/Octtr7t5GSj4
   xbqtBOZgES4++y0rhYqnb/FLyawNW1Vzp3QH198idoOzKLBYWRID11cGc
   +f89srOTYPegh6naYyYZZGGmY0FvtOoxT8JnQktTjQ0/ckSX1Iw0oTiuC
   g/GA0YBMWL2asxrbQafPDXpflitnElCjK7rFOSuZZerQtCT2776pi2zni
   34fh0dJVOGkjdxLR4PtnlGv2nYwr4MIPqLyNrOdQ82rShiY2vuYxd8Uvz
   A==;
X-CSE-ConnectionGUID: lRKrOrnRQuuDDp7Hpzfmig==
X-CSE-MsgGUID: UoPsNI+BQdSo2U38/tumyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86593980"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86593980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:44 -0700
X-CSE-ConnectionGUID: pE8RSMmuT6+v4lS+kzg6bA==
X-CSE-MsgGUID: ZtBLhCP8T8mV69Z4tqjtVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804610"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:43 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 2/7] KVM: x86: Use linear_read_system() to read the TSS I/O bitmap
Date: Wed,  5 Aug 2026 18:15:31 -0700
Message-ID: <20260806011536.4172258-3-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSS I/O permission bitmap reads are implicit supervisor accesses which
are subject to Linear Address Space Separation (LASS) enforcement.
Though highly unlikely, if a guest configures a TSS base in the
user half, hardware would raise a #GP on access when LASS is enabled.

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
---
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
index 8ff28643b2e3..7f04544cfee5 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2573,12 +2573,12 @@ static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
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

