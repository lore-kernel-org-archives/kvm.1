Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8623382C7;
	Thu,  8 Oct 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418488; cv=none; b=nty7jDw4NrkKVYrBGjpqzCX6xNWU264e5iXQC/9fJabyKzC94wxUbFgrczHOu+9/cJhe9istkYE3eRu+P8SVDCdQhXRWjd2lUXdRqpFtDIWvC/xO13n9TqaWs0iA5y3oHbk0OALRg+FzkYeSSZBt1CpTR3J2iP844Mszycyg3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418488; c=relaxed/simple;
	bh=ufGSUN1LxAZCWJmR9oIS/yYvALuIT67EvA2EoaOGboM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZfLi0oP6QXd6rwIXvXUL9YLXmO/QVqZKpeDZYZwUg5alDbApCsbU3VmJC/pE0TJcTq9XiZObIP+uK6hzUtRujreb6amywLrF8NQemSijrKaNxrICAyT4zxRdXN/NWYZzYvzKKR6TTecQP1aj2S42DI4H2yVnfT4QgVJCEgUgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO8Uuvgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO8Uuvgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166971F00898;
	Thu,  8 Oct 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418487;
	bh=4+SK8tZpvL/XMVKUpx3Px3NMv7az3IY6GSGPZXNjHuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YO8UuvglySYN9slMlxiIbKk7Zh542SlM4JNa7kZLf5Tx+IX+GBpgj+3pUhilZrlGq
	 gjkb/oit2EnFJr2VTu5SyGNdevZF2DwROMVHN0XTSR9J1MU+K8dtEJ88H3pdRfSLQA
	 qxmWx5LmhiKkjUZtX71nXnl5aRD4b9VG3QL1752aaNfzU+3GgFmzkXg6JGIuB+roxJ
	 ZCiy1Ln8iOSgWRe1FNt61sZPgSIJAZlwFcJpuaIAmGyCzt2T7ZA+Sb/lZn/2FNcOA6
	 5fT+vS9AEEBIKP3qAFSR0Lfn6bjbYkS3aHnUdIsv/dfQZoS00EcfztQtJGxntYWLPW
	 wrYh/Rl2UKHig==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 17/29] KVM: nSVM: Always switch VMCB before leaving guest mode
Date: Thu,  8 Oct 2026 00:14:13 +0000
Message-ID: <20261008001425.2458927-18-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move svm_switch_vmcb() calls ahead of leave_guest_mode(), as nothing
between the calls depends on svm->vmcb being set to vmcb01. This makes
the nested VM-Exit path consistent with the nested VM-Enter path, and
having the calls to svm_switch_vmcb() and leave_guest_mode() close makes
it easier to reason about incoming changes that depend on both VMCB and
guest_mode context.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 75ada771026b2..27f78228a42d5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1329,7 +1329,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (nested_svm_vmexit_update_vmcb12(vcpu))
 		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 
-	/* Exit Guest-Mode */
+	svm_switch_vmcb(svm, &svm->vmcb01);
 	leave_guest_mode(vcpu);
 	svm_pmu_handle_nested_transition(svm);
 
@@ -1356,8 +1356,6 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
 		vmcb01->control.erap_ctl |= ERAP_CONTROL_CLEAR_RAP;
 
-	svm_switch_vmcb(svm, &svm->vmcb01);
-
 	/*
 	 * Rules for synchronizing int_ctl bits from vmcb02 to vmcb01:
 	 *
@@ -1543,6 +1541,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
+		svm_switch_vmcb(svm, &svm->vmcb01);
 		leave_guest_mode(vcpu);
 
 		/*
@@ -1554,8 +1553,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 		 */
 		__svm_pmu_handle_nested_transition(svm, true);
 
-		svm_switch_vmcb(svm, &svm->vmcb01);
-
 		nested_svm_transition_tlb_flush(vcpu);
 
 		nested_svm_uninit_mmu_context(vcpu);
-- 
2.56.0.360.g66cac248cb-goog

