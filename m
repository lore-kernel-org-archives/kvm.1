Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027C2BDC0F;
	Tue, 16 Jun 2026 00:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570546; cv=none; b=p56kT6D75SYVJlvlvDUjvbeM03si7piBBGva3D+CYcXfENfV3wKNZGExtEizfZTAb8CXI0hc9mbgSQpzoOWZ/eutGrGI8zRxkHtJsr8ANDrgBLKEnxZ9JU8mqwBmHBs6K8ZoUvQeKr9Ccfz251DzrbX0Na1a6kPNbtfTUsvHjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570546; c=relaxed/simple;
	bh=UQgg9mXkPVnyN0uGRa6KunjkGLVaR33Rtw16lcltOiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEIS0YZ4F2P+MwGet37bDmqiTrJM70SFqtBO7Fl+jpdZh1VVLBeTMDAILbZWX1Q2QCo5w8CXAU1iRD8efhs3S0ejh5drri7sSTHvjDCAy2ZL0ivsXd0g5kGxIZfp8QKC0zxxTknXAoQ0eJ0+AKH+1wWSHgk4uj5gUbM4rhUr24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU2FoKV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU2FoKV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4041F00AC4;
	Tue, 16 Jun 2026 00:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570545;
	bh=2V6Mi7ACle6LhLBpogTxj2n4pn8IksTfc2/qKUF2ccY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GU2FoKV8qYLIXwqJYM2s6PA42+WaDL7WwDOrlWQ06TFI1UN91pt5/dIbPEmU0o+LD
	 XzEZNYN4CZBk5jDYX23hOOW8zE2IAZF5wPLRmDuOEA8DDMYhKcWKGJHQahUIoJqJv+
	 QWayK9Y9hJnz1JWgRmPGlX5nwoKssH/LR9ymopM+/hl02s9vvZsqM5PsK5pRO2t8GG
	 ZiT0ws3ISnCXIXrVa0DljOW00SAwbaycjnjWG2jcWEH/HZt/4kLES26vGMvSXSnGP8
	 HLZDKNkogIiDCLy2ZBdNNzDZcuyYtSHAR2OpGNV553Yy+7lCNWd/oA2U8G+jEQj7LJ
	 zMgoQs7nry6WA==
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
Subject: [RFC PATCH v2 07/25] KVM: SVM: Duplicate pre-run ASID check for SEV and non-SEV guests
Date: Tue, 16 Jun 2026 00:41:36 +0000
Message-ID: <20260616004155.1435766-8-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for dropping the check for non-SEV VMs, duplicate the
check between pre_sev_run() and pre_svm_run() (for the non-SEV code
path).

Opportunistically drop the unconditional dirtying of VMCB_ASID, as it's
only needed when the ASID is actually updated in the VMCB, not when
TLB_CONTROL is updated (as the code currently reads).

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/sev.c | 6 +++++-
 arch/x86/kvm/svm/svm.c | 9 +++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 026b070522dac..3c873c88894b3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3558,6 +3558,11 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	/* Assign the asid allocated with this SEV guest */
 	svm->asid = asid;
 
+	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+		svm->vmcb->control.asid = asid;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
+
 	/*
 	 * Flush guest TLB:
 	 *
@@ -3570,7 +3575,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
 	vmcb_set_flush_asid(svm->vmcb);
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 159abf841738f..5d4c45d788b54 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3766,6 +3766,11 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 	if (svm->current_vmcb->asid_generation != sd->asid_generation)
 		new_asid(svm, sd);
 
+	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+		svm->vmcb->control.asid = svm->asid;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
+
 	return 0;
 }
 
@@ -4502,10 +4507,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	sync_lapic_to_cr8(vcpu);
 
-	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-		svm->vmcb->control.asid = svm->asid;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
 	svm->vmcb->save.cr2 = vcpu->arch.cr2;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS) &&
-- 
2.54.0.1136.gdb2ca164c4-goog

