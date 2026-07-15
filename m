Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48193EA953;
	Wed, 15 Jul 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106320; cv=none; b=J9MeXof1FCDX7IS7//449iScFuwkQHz/6ideBe1UmqCbo/IvdYwgv4Tfw44yAIDHJRAkkmLZeCq3bFZLLSRnzTP5kKRhIBKTLy0otC+njGP58xRdSIG+O++dUt1td81xWr337soTebJ9ovmfQkgj6lDk42MYs2yswGV6eoYlwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106320; c=relaxed/simple;
	bh=bF1K/fFsu+KdHDWjVR3atC8VsHcVvTBlxcpCeZ7UsvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1Y9dJhig8LMVXm7yv/sze63zArKDt1Czs5jcouUD6vhStS9ckLJU6LNovySqs1jXPJXL2Ow0kI0Ex6j0Pcp+pyyGTsmoig0mU1sF8KlSCjJpSo4TNZ1XwyMRjrtRlUUc1VwWbvafq80q1hG4UIfrYiMZc7ocgQJq35+FVKj4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZtrWzMq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZtrWzMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784106319; x=1815642319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bF1K/fFsu+KdHDWjVR3atC8VsHcVvTBlxcpCeZ7UsvQ=;
  b=BZtrWzMqer15MKOM4JhLertZ7bZSw90D50n2NVW4w+8wwS2rv+wcTGK9
   CTMOzuLOhAh6+6Jb4VtPogdSRzK3F3KaaC6kpAD/vivumiONRbAzkgYu8
   i2R7qShgrrxXVJa98MpYa8sXLSX4b5SSc2/VPqQiJ7BjzVBsRHWa8Kz2F
   xZyTmaRlORZIcqzdOngItv+KRDW66S9nAkcV58pqBlzP/dLfraeTK4MxW
   IdSC72LKjMyNmgy4uL1jzE/kiOFHaErLlDFffaimlSfsomVi1qngiL1q5
   aiwo734drUz9RVl/Up5lRY4hPgdMZG1kL7ML/ArtI2BuodcwlsQCxQGEl
   A==;
X-CSE-ConnectionGUID: 3TBPe4weQfqwbbAZBj9Afg==
X-CSE-MsgGUID: OZ+lNYVKRhy1oeicoQnuig==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84779929"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84779929"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:05:18 -0700
X-CSE-ConnectionGUID: 6eMEhse3TdO7nF5e+e3wtg==
X-CSE-MsgGUID: +FRHLIHiT9aYxxwQLA2dvA==
X-ExtLoop1: 1
Received: from khuang2-desk.gar.corp.intel.com ([10.124.220.118])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:05:15 -0700
From: Kai Huang <kai.huang@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH] KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook
Date: Wed, 15 Jul 2026 21:05:05 +1200
Message-ID: <20260715090505.601174-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change to using KVM_X86_OP() instead of KVM_X86_OP_OPTIONAL() for the
.pi_update_irte() hook in kvm-x86-ops.h since now both VMX and SVM have
implemented it.

For the Fixes tag:

This hook was introduced for VMX posted-interrupt support.  SVM later
added its implementation, but at this point KVM_X86_OP* had not been
introduced yet.

Initially KVM introduced KVM_X86_OP_NULL (and KVM_X86_OP) and used it
for this hook.  But this was correct, because the use of KVM_X86_OP_NULL
was "to mark calls that do not follow the [svm|vmx]_func_name naming
convention" and the VMX one was named pi_update_irte(), i.e., did not
follow the convention.  See commit 9af5471bdbb2 ("KVM: x86: introduce
definitions to support static calls for kvm_x86_ops").

KVM later removed KVM_X86_OP_NULL (due to "the naming convention is not
in use anymore"), and added KVM_X86_OP_OPTIONAL for the hooks that can
be NULL pointer.  It used KVM_X86_OP_OPTIONAL for this hook, but should
use KVM_X86_OP instead.  See commit e4fc23bad813 ("KVM: x86: remove
KVM_X86_OP_NULL and mark optional kvm_x86_ops").

Note this hook was named .update_pi_irte() when it was introduced, but
got renamed to .pi_update_irte() at some point between the above two
commits.

Fixes: e4fc23bad813 ("KVM: x86: remove KVM_X86_OP_NULL and mark optional kvm_x86_ops")
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

Hi Sean,

I am not entirely sure whether this needs a Fixes tag, but I added it plus
some history just in case.

---
 arch/x86/include/asm/kvm-x86-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 736129db272a..0acfe15643e1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -110,7 +110,7 @@ KVM_X86_OP(handle_exit_irqoff)
 KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
 KVM_X86_OP_OPTIONAL(vcpu_unblocking)
-KVM_X86_OP_OPTIONAL(pi_update_irte)
+KVM_X86_OP(pi_update_irte)
 KVM_X86_OP_OPTIONAL(pi_start_bypass)
 KVM_X86_OP_OPTIONAL(apicv_pre_state_restore)
 KVM_X86_OP_OPTIONAL(apicv_post_state_restore)

base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 
2.55.0

