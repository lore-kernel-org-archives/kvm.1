Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C038E121;
	Sat,  9 May 2026 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315804; cv=none; b=IG8kqa62y1JMdCzCZqYXNvYYLfvh2uUZbyVQMv3E93+rplhwb9+K1vTAVRlgEkzr+2wI1izTN791n7MpeBdWY/k2PTJ7P8ELJP+C6vbMjOwnajA+0tSb+AREu5tsxICHbrru7UN5DcwwMBEciIID7JnCZqrXmfSICnBwMQWOX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315804; c=relaxed/simple;
	bh=CWVlTJ2fw9Hr14bsGHbzw8g4DedxcZzL9H4u85xMyA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTfMwUI+CsUDX69aTLQbcerezsL9NEGPsSmTvL6gM7wI52jKQ5un4kQTtYTNdWDoJrWTLDD207qDoBAF2lJ6Gclr9vFYjl5ig56kg3cNEwYwBoVsczRm5sR8CzDWJ4UZHgAcLg1MeDJWc19rpo/n/5k4NHg2HDLIofGM3OnXK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krZgTNyf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krZgTNyf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315803; x=1809851803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWVlTJ2fw9Hr14bsGHbzw8g4DedxcZzL9H4u85xMyA4=;
  b=krZgTNyfDbPeO70b/53mcGNyBlsIoNOcqEzdoYHG3WK4HHymTSfFTck7
   SiOL+4LWn0dcLJHVRLBjQR+ICZFG/f8AT08TTWSTj6n6pNbiinsM2cTs5
   ilFG+/G7rG/IGaehL8tgYLSmtqYSQPbKHTBiorBd0zfvTjCwrt9SHd8u8
   VIebKIKqgpw4OftaVMpui/C5YM+N0OinbE90iRfqFhAAi8DRCsyhbvQJx
   2N1VXaXEOSdgyW9j/JctHFyuKAbdTuOO6Ykn2YsaNg6yLN6mXIc3vj+hf
   R70O51Hi6WgOooorQqe/mJlr4NSjVYdb51uDYCh2Y2zj4EqbvgBGSlqFZ
   Q==;
X-CSE-ConnectionGUID: miNfV0QnQ0S2pACrlkRQFQ==
X-CSE-MsgGUID: rBm8L1pJRoCeIPFmkAAwUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79306587"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79306587"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:42 -0700
X-CSE-ConnectionGUID: W/jDTjevRq68nRpsrIxX8w==
X-CSE-MsgGUID: 35Tecm0uSbiHNKNABG6h+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="230584765"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:39 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v2 10/15] KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external PTEs
Date: Sat,  9 May 2026 15:56:47 +0800
Message-ID: <20260509075647.4290-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260509075201.4077-1-yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Drop the KVM_BUG_ON() in the KVM MMU core before zapping child external
PTEs, since requiring zapping PTEs to be protected by exclusive mmu_lock is
TDX's specific requirement.

No need to plumb the shared/exclusive info into the remove_external_spte()
op or move the KVM_BUG_ON() to TDX, because
- There's already an assertion of exclusive mmu_lock protection in TDX.
- The KVM_BUG_ON() is a bit redundant given that if there's any bug causing
  zapping of leaf PTEs in S-EPT under shared mmu_lock, SEAMCALL failures
  due to contention would result in TDX_BUG_ON() in TDX.

Link: https://lore.kernel.org/kvm/aYUarHf3KEwHGuJe@google.com/
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Updated commit log and title. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ada4a0837298..553a30628960 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -473,10 +473,8 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 		}
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 
-		if (is_mirror_sp(sp)) {
-			KVM_BUG_ON(shared, kvm);
+		if (is_mirror_sp(sp))
 			remove_external_spte(kvm, gfn, old_spte, level);
-		}
 	}
 
 	if (is_mirror_sp(sp) &&
-- 
2.43.2

