Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342C3ACF05;
	Tue, 24 Feb 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972472; cv=none; b=qMpgpskemnBdBqVSjmnZN09uZkzlTaCdJiN4VluQMoixdA2DyX3A7v2eICS/5+OZMcQLQmXsugeZFPnkajZJafW/3SaTPDEdgUKRCi7tCspEH60Qb98qFFdT9mTW0yKITtc6HgUV322Qrj0fLP5/FRXxkBat6TxatNcp7g2NuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972472; c=relaxed/simple;
	bh=IM+ni7R0tCySorWNqi7DDiY8uOysUtiVySdq/OQQOEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXc0M8qHwaNu4xpmS4abFMtWYQYsTRMSqtK1/GbtZcpq+elCih4UzYoEnATKYaPKJI6guXfKuStnQCQWPM0TUJSvQsTq8PJJSn9+khXSM5BOZfzBjEdtd8LDfPpDBhEx/uj918SSeiku3px2Sri9+CI1BMLNdXBZUbT/Yj8Mc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxOqL00o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxOqL00o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74AEC19424;
	Tue, 24 Feb 2026 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972472;
	bh=IM+ni7R0tCySorWNqi7DDiY8uOysUtiVySdq/OQQOEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxOqL00osshPsWMWJ0Hmy+vZliDAPz50WQXbux9eBjvkslA+M7zIB/G6wbDcPVusO
	 wLGWLzrtXMsaOE/Mcvg0i+MamV6JeIF4IXGM86TDwrQCBfC4faONfE9lWo8E4UIjak
	 hvclrD+g02atVzT5qCedHvEaWLT8Cjjz5UF4juKhmBw67XkXXGmi+QT+JOuZE9Fgk9
	 ihJuHoND3CXvRqoFTAGt0E+auTHqDp2UJlVJfKokRHm8A2DKPdZRwFO158l4//2H4f
	 zusU95LvGC20HjBSs9aSCAcTAL2Y9uzbWz4R29kyR0QZpypaUadV4cP9WdSKvz0WUK
	 o36Ok45oqm+Nw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 27/31] KVM: nSVM: Use PAGE_MASK to drop lower bits of bitmap GPAs from vmcb12
Date: Tue, 24 Feb 2026 22:34:01 +0000
Message-ID: <20260224223405.3270433-28-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260224223405.3270433-1-yosry@kernel.org>
References: <20260224223405.3270433-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use PAGE_MASK to drop the lower bits from IOPM_BASE_PA and MSRPM_BASE_PA
while copying them instead of dropping the bits afterward with a
hardcoded mask.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5c8449bc6fa0c..28a8bfc632ef5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -499,8 +499,8 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
-	to->iopm_base_pa        = from->iopm_base_pa;
-	to->msrpm_base_pa       = from->msrpm_base_pa;
+	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
+	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
 	to->tlb_ctl             = from->tlb_ctl;
 	to->erap_ctl            = from->erap_ctl;
@@ -522,8 +522,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 
 	/* Copy asid here because nested_vmcb_check_controls() will check it */
 	to->asid           = from->asid;
-	to->msrpm_base_pa &= ~0x0fffULL;
-	to->iopm_base_pa  &= ~0x0fffULL;
 
 #ifdef CONFIG_KVM_HYPERV
 	/* Hyper-V extensions (Enlightened VMCB) */
-- 
2.53.0.414.gf7e9f6c205-goog

