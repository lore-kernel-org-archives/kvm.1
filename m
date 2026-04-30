Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D23A7F6E;
	Thu, 30 Apr 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580880; cv=none; b=AXcgN4q1wxF84Drq1P7a+x4aKtbah7Mw5gF9+QZUIhMk+/U+qAUKIAg+yztVl3uaQ6QJjP8LZC/tFlgOa6UUU+FDkBvM1lCqldiA+ag6eSfzPV2OojdoSYWQNAuyLDRiCQHyNg0H02621YJLdJobqSIeJ1UNJD5JjTL/FyAfHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580880; c=relaxed/simple;
	bh=E4MwzKyp8yi3zfN85nny6hxSSlImYZ5aS3B8ll4qV6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk/vDAXx5OGjFePUKc6Cih9KkhD4M1J+QEfQbOd1hJkz1YLE/46nYvnRI8C8MI1TtzLmWxxVKAcgK2sMi4vQs7RU0kGwXalt9DUt5QxPfzg08rTHVnQaCz6+qLdPryfbl6/BG+1UHhbRrfFqpe84ZDxBW/3UU41sFAR7f5qadvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeDtEaMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeDtEaMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7C0C2BCB8;
	Thu, 30 Apr 2026 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580880;
	bh=E4MwzKyp8yi3zfN85nny6hxSSlImYZ5aS3B8ll4qV6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BeDtEaMq/V6R8hOUynDtlb9ENm9et25PKK3Ez5WqOidXhtpY4QbhVhtSAPI0w9kqd
	 3laj7b1Oe2eUdlA0oGi4wgSdRsjb9OXD+T2HaMXETd3xES1HqyCZ4kNPuqdsjWDDPB
	 RtsTFDKinyh1zag9m2UofTa7XuXsja08HiYseKaXVyNn3nDlqhoajeqWt/ZN55Eoo9
	 WLC+7VndRFZT+g6Mi96zAmP0uQFhVvIxoXQmeNPNwonCEACrkF+JSW1BdkKAPqEp4R
	 oKrrWjmXTjTzHjW6uQVkmnJW0D1vGQKMDbRXZM3ZBI//0COHlAUy4/PBn29ny/SZYk
	 q+S345jHUfsKA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 01/13] KVM: nSVM: Stop leaking single-stepping on VMRUN into L2
Date: Thu, 30 Apr 2026 20:27:38 +0000
Message-ID: <20260430202750.3924147-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
References: <20260430202750.3924147-1-yosry@kernel.org>
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

