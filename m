Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755313A4F5D;
	Fri, 27 Mar 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642479; cv=none; b=YRAI0psaimFVylXMjdhW4ZZpfvIAsbIQtYSyhm2HbOGm0yxeJ4m/G80gU9phTwlCuWd8g7qrzWDw94pgri6zQjGIY9/xw+fP8AHJZag1BYZMWPortYUauuMo1LHDTXcSyDI4JWwHiSSUmAVbdjOsGFUcAg3fn/t82SEKsr3zXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642479; c=relaxed/simple;
	bh=wV8OuOc83N5v2E4voBHlyx19yiXx4AfYeaGG41ViA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPqCQYyRIg1Mtx1pZev8h9tI9uWGXRWTM7fjYy6TRC9JRLOvG0PzBGSDqJhmKJ0i+N1BjFNClgBL8ue74o1rmU8fZGLFV3dFrnPc8ZYp/LdzcyqbdWqH3J3jomxQvwfAgHxK2wEDYOy7JuBz4qeuQR4uSXt33Ew4eaDL6/vKjT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c82AOzbK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c82AOzbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642477; x=1806178477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wV8OuOc83N5v2E4voBHlyx19yiXx4AfYeaGG41ViA/Y=;
  b=c82AOzbK81muyxSeknDmnIkv1Wue+SkRqJe9Cz5gC/ze9Z1xtafxzm9C
   AT+v7ikaHz9Jai6wa19gSWYDX1J6N8sL6VCYM+UfAa+YMgAgDQN4yxY/h
   ST6KwMwmQNIe0NzvNbndrnAc1ujtLjsGHJg4x8eSGUxwwJj5hxMGqBLUT
   SVktC0EAQ+3f7gOjAJCuH9PfA0OpTPfwD8tfiN4OKJgtUc6Xaeel+Y+Qz
   fB2OjWLJmcfxKoD1R5sNhgknxHrQC8cm4wWA2zmmxU6wC+Ro/LTKoRFyb
   gKgbNPJ8iR/XauP9Wof8mhNCmhYysSm1L72tuyg5wQR93OlvOIavN56KQ
   A==;
X-CSE-ConnectionGUID: Lg7R35dzQeO/xRx4E+k+pw==
X-CSE-MsgGUID: knjENKTqQx+KTHW2fmgUrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182756"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182756"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: SWZdmb4XR3GoAO8gDzFXgQ==
X-CSE-MsgGUID: GtapS4rWTkeAQ0l4WImnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922929"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 14/17] KVM: x86/mmu: Remove KVM_BUG_ON() that checks lock when removing PTs
Date: Fri, 27 Mar 2026 13:14:18 -0700
Message-ID: <20260327201421.2824383-15-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of an ongoing effort to move TDX specific bits from the MMU into
the TDX code, drop the KVM_BUG_ON() that checks the MMU lock is held for
write while removing page tables.

Future changes forward PTE removal mirror EPT updates into the
set_private_spte() and let TDX code parse the PTE to decide what S-EPT
operations to take. This operations does not pass a shared bool for this
KVM_BUG_ON() to use in the logics future home.

But even today there are already MMU write lockdep asserts that mostly
cover the case. Since the KVM_BUG_ON() is already a bit redundant, just
remove it instead of trying to plumb the bool into TDX code.

Link: https://lore.kernel.org/kvm/aYUarHf3KEwHGuJe@google.com/
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 991870789863..5dc9633c866e 100644
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
2.53.0

