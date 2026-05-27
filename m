Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3134D3B9;
	Wed, 27 May 2026 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925640; cv=none; b=VptEjXRvGCnLhQBeusuGghDGre3cKlkHdbh5QITOtSmceIkCTUBcLGVrtq/DKIrC05XTs8x8Fpt+yQDOjNCsxPT2Gy1QaaP6PfRYMaaBWmYF5yOQE3YpHQxops0HoemWWC6jzhAkkLSvsIoQl+7lgT/isnTYL+GnmMmg9a/Ci1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925640; c=relaxed/simple;
	bh=kiJB+hqQYj7xhnhJjwxYAUz132raL+ulTgPrrJKnIvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5MZUdGai5paQmVeZyCLLSGKjHtMjH0x4E1ITTC4gOT3hQj8AP0Ay0myOZe95lr8rfkAcETd6EHro6f4EaTUoGbQzDSYbkIF9SK+rSXiHDnOLRY5pA12RXTGIgiH4Uu+3lOvYdkUFglu62UmjOma/oqpNVqI37ArpL6AJc09IhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOyDbYGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOyDbYGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61F51F00ACA;
	Wed, 27 May 2026 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925639;
	bh=FyGd/1uAOo7TXsMQ15W37emnMrwKdTILk7667NP3Jy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOyDbYGwv/tKnAuFQJKMrkrGBJz8a61PfQ2fhvhrmsaluaVoaHf+CYSVwcVec3AHv
	 JiiNa4SN5rbPctQNBRUzoxk1taR+PgaUujM5eVHafAIevTx3UevQyMhlWbtIbo55Bk
	 mdMsesyTKB++XPvWD1A5oZnvue+cffkbrGjk24VW5DY/Ye9k+ADWIqpTTPcMcC5S8U
	 HGfu5tfiUelQ895fFFV9jz8To/lFSbcURG02fN4cCB0ajdDI3vGb0VrAjvXSIVjxnM
	 PoIcMkylSu/Zrrj7HhLVyKp2a7h1syC7dQSDnncu3c+gnBadALhEaskmnzKFIb3Z0p
	 TVTmNG03WdpUA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v7 01/17] KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
Date: Wed, 27 May 2026 23:46:55 +0000
Message-ID: <20260527234711.4175166-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
References: <20260527234711.4175166-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the APM, TF on VMRUN causes a #DB after VMRUN completes on
the _host_ side. However, KVM injects a #DB in L2 context instead (or
exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
kvm_skip_emulated_instruction().

Avoid single-step handling on VMRUN by open-coding the rest of
kvm_skip_emulated_instruction() in nested_svm_vmrun(). This doesn't look
pretty, but following changes will need to open-code
kvm_pmu_instruction_retired() anyway, and will cleanup the code.  This
ignores TF on VMRUN instead of injecting a spurious exception into
L2. Document this virtualization hole with a FIXME.

Note that a failed VMRUN would have been correctly single-stepped, but
now TF is always ignored for consistency and simplicity purposes.  VMX
does not support TF on a successful VMLAUNCH/VMRESUME, so it's unlikely
that single-stepping VMRUN properly is important, especially if it's
only for failed VMRUNs.

Fixes: c8e16b78c614 ("x86: KVM: svm: eliminate hardcoded RIP advancement from vmrun_interception()")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++++++++++---
 arch/x86/kvm/svm/svm.c    |  2 +-
 arch/x86/kvm/svm/svm.h    |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 28ac5d5c990dd..01e3e6fa8bbb1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -30,6 +30,7 @@
 #include "lapic.h"
 #include "svm.h"
 #include "hyperv.h"
+#include "pmu.h"
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
@@ -1145,11 +1146,22 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
-		return kvm_skip_emulated_instruction(vcpu);
+		if (!svm_skip_emulated_instruction(vcpu))
+			return 0;
+
+		kvm_pmu_instruction_retired(vcpu);
+		return 1;
 	}
 
-	/* At this point, VMRUN is guaranteed to not fault; advance RIP. */
-	ret = kvm_skip_emulated_instruction(vcpu);
+	/*
+	 * At this point, VMRUN is guaranteed to not fault; advance RIP.
+	 *
+	 * FIXME: If TF is set on VMRUN should inject a #DB (or handle guest
+	 * debugging) right after #VMEXIT, right now it's just ignored.
+	 */
+	ret = svm_skip_emulated_instruction(vcpu);
+	if (ret)
+		kvm_pmu_instruction_retired(vcpu);
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e74fcde6155ec..183e577802301 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -333,7 +333,7 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 	return 1;
 }
 
-static int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	return __svm_skip_emulated_instruction(vcpu, EMULTYPE_SKIP, true);
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2b6733dffd76f..e5d9984ef6320 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -832,6 +832,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
 	svm_set_intercept_for_msr(vcpu, msr, type, true);
 }
 
+int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
+
 /* nested.c */
 
 #define NESTED_EXIT_HOST	0	/* Exit handled on host level */
-- 
2.54.0.794.g4f17f83d09-goog

