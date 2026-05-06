Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC61280335;
	Wed,  6 May 2026 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032680; cv=none; b=h1i0yO7cDW3wjv7l65HC1QyKZ6O+nxrmWAfxGwogivbAp7GRErGCvPM40+PLrxOHCRED8QoyCH4cy7X8sAGBOtsmBhRX/dJtf0ZdeqAUsu1asiMpkVSVW4HyGJF6CaXbGYIDyYPVebj1X9+2yd0HUIS0RltZlipUi8ueQ/602xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032680; c=relaxed/simple;
	bh=E4MwzKyp8yi3zfN85nny6hxSSlImYZ5aS3B8ll4qV6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAsJE2rPqkirQVT3k9yS/ORfnynFg5izOgqDvf4rG28Lu7JM3d/npQAkRNjlrKD6hYcvBr4T7vBnlezNnwEG1+1N3b3/E12Svao2lBvatm1ePQjoC+52iuAQUBfWpyPlWe8GnXkpLmpsPtapKZegbVTSXDyKfh4PS0IFaljYYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJa4i7AF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJa4i7AF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FD9C2BCB9;
	Wed,  6 May 2026 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032680;
	bh=E4MwzKyp8yi3zfN85nny6hxSSlImYZ5aS3B8ll4qV6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJa4i7AFCMjSMQXdzmlgDZ3YYEd86ME3Z/Hv7vWOMAoakENs8DgFAc92KL1lhfQ1z
	 erCeXmM/CPtVyqqA3Emh/eFxOGoSPcxJASYLuErcHLu8LpulSs6M+ooSEw+PGDWbtw
	 BZvx7uvLOPS4lJ48fr9q9IMIIBxpQoO3S39ds0fd2Xice96ePdRvqbEErEFRPeufGa
	 /0RyCFIlQ7njlMo9inPOushAcLVxPMR/cJGDicBeS5Gef46r6HoLspJvGl7tRy5vLF
	 fzxHuYRGr6HtNUOnim7Ub/O6H6WGqb83ZqGvb4mzvQYtm1DNrvWX0iju2GqNg+5gc+
	 MbWmUo4Rvolcw==
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
Subject: [PATCH v6 01/16] KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
Date: Wed,  6 May 2026 01:57:17 +0000
Message-ID: <20260506015733.1671124-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
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

Introduce __kvm_skip_emulated_instruction(), pull single-step handling
into the wrapper, and use __kvm_skip_emulated_instruction() for VMRUN.
This ignores TF on VMRUN instead of injecting a spurious exception into
L2. Document this virtualization hole with a FIXME.

Note that a failed VMRUN would have been correctly single-stepped, but
now TF is always ignored for consistency and simplicity purposes.  VMX
does not support TF on VMLAUNCH/VMRESUME, so it's unlikely that
single-stepping VMRUN properly is important, especially if it's only for
failed VMRUNs.

Fixes: c8e16b78c614 ("x86: KVM: svm: eliminate hardcoded RIP advancement from vmrun_interception()")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/svm/nested.c       | 11 ++++++++---
 arch/x86/kvm/x86.c              | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa4..b191967c9c1e4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2475,7 +2475,9 @@ void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
 extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
 
+int __kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
+
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
 
 void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f451..5dfcbaf7743b0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1125,11 +1125,16 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 			return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
-		return kvm_skip_emulated_instruction(vcpu);
+		return __kvm_skip_emulated_instruction(vcpu);
 	}
 
-	/* At this point, VMRUN is guaranteed to not fault; advance RIP. */
-	ret = kvm_skip_emulated_instruction(vcpu);
+	/*
+	 * At this point, VMRUN is guaranteed to not fault; advance RIP.
+	 *
+	 * FIXME: If TF is set on VMRUN should inject a #DB (or handle guest
+	 * debugging) right after #VMEXIT, right now it's just ignored.
+	 */
+	ret = __kvm_skip_emulated_instruction(vcpu);
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a9..31dc48a8111e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9272,9 +9272,8 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
+int __kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
 	int r;
 
 	r = kvm_x86_call(skip_emulated_instruction)(vcpu);
@@ -9282,6 +9281,18 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 		return 0;
 
 	kvm_pmu_instruction_retired(vcpu);
+	return r;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_skip_emulated_instruction);
+
+int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
+{
+	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
+	int r;
+
+	r = __kvm_skip_emulated_instruction(vcpu);
+	if (unlikely(!r))
+		return 0;
 
 	/*
 	 * rflags is the old, "raw" value of the flags.  The new value has
-- 
2.54.0.545.g6539524ca2-goog

