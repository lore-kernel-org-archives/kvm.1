Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E0036C0B7;
	Tue, 24 Feb 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972468; cv=none; b=pYOzmdVHpMZJ4oE7KYACXgGgyFPg8m1WYhGw0u8nW0Yo7gNJlk/iSsfYAUnQCqKvoWXsuZojqqvnlNyKp95Jsejsa6/tL/eC+6SBlegYj4N0G0W3L0HS2J2lrYzxVHpRP8UrtGkfR66TpQZcIcTgtRLPZV/uxzsbojyFNHKuBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972468; c=relaxed/simple;
	bh=Y8/QwEVqLoWElzGzDO9XBHgtA8uAN6YBWaSR8ZmZZ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqbcDAaiHOHEeX1Rrkcuihx8uXZl0EU8WeurbR8qDRp2tGEM5jRmksix5nfLdqMysD1ZzS1xzeV/4DyrgrXuZkETV6HuXYE3C7iqdPmKx4V6IpL86th8626CyUEJtFVwCT+wACYoznaaFocXaVCHtDY0tr6YopGAEIVbLWvy7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVNu9yAk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVNu9yAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727CDC19423;
	Tue, 24 Feb 2026 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972468;
	bh=Y8/QwEVqLoWElzGzDO9XBHgtA8uAN6YBWaSR8ZmZZ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVNu9yAkbw2EiJUbSaR1U74iWE4sVzwcSUTcjbARiKmyP4v5tB/o4cdt0xzGfZc+X
	 krJtHlrAUYBTDbsAIk1N2xUsY8z43mE8ie4kqqsDh/3OAMqAHAlB6K/IO9jLhVFchK
	 HgQA5qlaMfFEcqeT9AGeN1A4fGh5XIuTMAYOf7K6BEIl8fkEKFK1v+IQLlVffWZuSP
	 9z7hajfIkA++7+d3uBhEY3FQda7jVCuNd4UYo1KpRvBkG6O6IqH1mdUWMNqg8GMksI
	 O0tqnnPwmeRndMFrPq9eiHclF41CB7peywUg1HVDSPHhMaWqCadcZACd0RuAW0A3Ep
	 ds5QiRwgWaAKQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 18/31] KVM: nSVM: Drop the non-architectural consistency check for NP_ENABLE
Date: Tue, 24 Feb 2026 22:33:52 +0000
Message-ID: <20260224223405.3270433-19-yosry@kernel.org>
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

KVM currenty fails a nested VMRUN and injects VMEXIT_INVALID (aka
SVM_EXIT_ERR) if L1 sets NP_ENABLE and the host does not support NPTs.
On first glance, it seems like the check should actually be for
guest_cpu_cap_has(X86_FEATURE_NPT) instead, as it is possible for the
host to support NPTs but the guest CPUID to not advertise it.

However, the consistency check is not architectural to begin with. The
APM does not mention VMEXIT_INVALID if NP_ENABLE is set on a processor
that does not have X86_FEATURE_NPT. Hence, NP_ENABLE should be ignored
if X86_FEATURE_NPT is not available for L1, so sanitize it when copying
from the VMCB12 to KVM's cache.

Apart from the consistency check, NP_ENABLE in VMCB12 is currently
ignored because the bit is actually copied from VMCB01 to VMCB02, not
from VMCB12.

Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index dd95c6434403f..0f18123f5461f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -350,9 +350,6 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 	if (CC(control->asid == 0))
 		return false;
 
-	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled))
-		return false;
-
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;
@@ -433,6 +430,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	nested_svm_sanitize_intercept(vcpu, to, SKINIT);
 	nested_svm_sanitize_intercept(vcpu, to, RDPRU);
 
+	/* Always clear SVM_NESTED_CTL_NP_ENABLE if the guest cannot use NPTs */
+	to->nested_ctl          = from->nested_ctl;
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
+		to->nested_ctl &= ~SVM_NESTED_CTL_NP_ENABLE;
+
 	to->iopm_base_pa        = from->iopm_base_pa;
 	to->msrpm_base_pa       = from->msrpm_base_pa;
 	to->tsc_offset          = from->tsc_offset;
@@ -446,7 +448,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->exit_info_2         = from->exit_info_2;
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
-	to->nested_ctl          = from->nested_ctl;
 	to->event_inj           = from->event_inj;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
-- 
2.53.0.414.gf7e9f6c205-goog

