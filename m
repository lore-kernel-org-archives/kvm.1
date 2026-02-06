Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006043E48D
	for <kvm@vger.kernel.org>; Fri,  6 Feb 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404983; cv=none; b=noV6CGbbJ1c4Syn14AciWXims/O3+Pe9vHgtQvlhqWaPvYaJALypcAFzcuruoOKlbPGyZlT870abTpU57bMBjyQOSWPEyA5OAG30Rz0gtWKr2LtRqQBmjlB1uMkZdJciYosm1TDOjwnlZslokEfQZbjQyzPCMCdchjIPgD9SZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404983; c=relaxed/simple;
	bh=myzwwiuhbadCyZSw7HuAVfjih7JweD6SXt48MzjlC4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUaovniVhlLC0B8YVo/lBIwJ1S72tL034kovsx56EFL8RUwFJIQRkEiPRc6XcWbne1HS7Umf3ougPO1CAo9QuKU0pByV5cpeN1RaJrEf5n10y1cDzVfCGoXztdJzv5+X2EDrqtOK4NCsy6umTI5RmYFqINdXKepnJxNNCZV1Ow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7Rr8ibF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7Rr8ibF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770404981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EG5LX6BdhVM8GYyf0Bk/7CQB4mY+IW3H5PUrABCxjTc=;
	b=T7Rr8ibFR44X8mefM5hzYRIf1QfZ6+9pXzWpwfKhwwuyixKX6SZ2VTGzIxHk8wUak6ldyU
	ogI9hmYe/L10uOredc20P1gcOjbtzhhOyXCrs0StSHCLVcNk84JWGe2Z/7LV/0zOerjDm7
	x44zs1VO0SNT9y+UG3gp+Y2/TajFSpY=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 19/26] KVM: nSVM: Add missing consistency check for EFER, CR0, CR4, and CS
Date: Fri,  6 Feb 2026 19:08:44 +0000
Message-ID: <20260206190851.860662-20-yosry.ahmed@linux.dev>
In-Reply-To: <20260206190851.860662-1-yosry.ahmed@linux.dev>
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

According to the APM Volume #2, 15.5, Canonicalization and Consistency
Checks (24593—Rev. 3.42—March 2024), the following condition (among
others) results in a #VMEXIT with VMEXIT_INVALID (aka SVM_EXIT_ERR):

  EFER.LME, CR0.PG, CR4.PAE, CS.L, and CS.D are all non-zero.

Add the missing consistency check. This is functionally a nop because
the nested VMRUN results in SVM_EXIT_ERR in HW, which is forwarded to
L1, but KVM makes all consistency checks before a VMRUN is actually
attempted.

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 7 +++++++
 arch/x86/kvm/svm/svm.h    | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ca2d1b1b8be6..90942c8c9d9d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -397,6 +397,11 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 		    CC(!(save->cr0 & X86_CR0_PE)) ||
 		    CC(!kvm_vcpu_is_legal_cr3(vcpu, save->cr3)))
 			return false;
+
+		if (CC((save->cr4 & X86_CR4_PAE) &&
+		       (save->cs.attrib & SVM_SELECTOR_L_MASK) &&
+		       (save->cs.attrib & SVM_SELECTOR_DB_MASK)))
+			return false;
 	}
 
 	/* Note, SVM doesn't have any additional restrictions on CR4. */
@@ -492,6 +497,8 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 	 * Copy only fields that are validated, as we need them
 	 * to avoid TOC/TOU races.
 	 */
+	to->cs = from->cs;
+
 	to->efer = from->efer;
 	to->cr0 = from->cr0;
 	to->cr3 = from->cr3;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7629cb37c930..0a5d5a4453b7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -140,6 +140,7 @@ struct kvm_vmcb_info {
 };
 
 struct vmcb_save_area_cached {
+	struct vmcb_seg cs;
 	u64 efer;
 	u64 cr4;
 	u64 cr3;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

