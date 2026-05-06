Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F81311C01;
	Wed,  6 May 2026 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032688; cv=none; b=H1gDk8zhfnmpFLnfQ7/GIoMWTSdOwG0E/J7sFf1SxaLlmu09Ql2BgpS6KpwQrEg0vSPKm/AmA4vq8DjhSFiIIJZL0wsBqr0fbB6ZZDxEk1AhADlUQ2zKkSPTHRyG8qYu32l+inRFNGHbNXQhBul0p290jcAwAxKkdKF2NmK1jjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032688; c=relaxed/simple;
	bh=peLf1xjVZgVyqN2SqYE3bmr9oD1pXuOn5SU63DvVSnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBjETw85iIjJI8TVe5pEoaSat3xfL9XtTg4TRjfSpYR85zE0xRnoh2QCXsQcvlQqO5zUE30tNBhb46sr7CLXOkDxgWhdrUDliOXeA7eIxEIdGpnTByh4eDieU6WqLxbh0Z/35Al9GYv9ZZ2DVvBCP4gxwTKFTn5Q5X6RsrT/lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py5jd6/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py5jd6/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9350BC2BCB4;
	Wed,  6 May 2026 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032688;
	bh=peLf1xjVZgVyqN2SqYE3bmr9oD1pXuOn5SU63DvVSnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py5jd6/kmNtV4adicKCIC1XHKNESaWASbrchA64k1LCHvEW23DQsJYcFxsOxBuov7
	 /mwxPyh+doMvERuOhPtv+Uj0abyn2xN5Wp8KXHvNG+Z9unP58I5p2gaCU/5umjh8LS
	 ZKmiN9ZtVSvPV5fWsJ1vCUaaez1FUY0dSpEWK555ZBvLURzh6Z728dU8k6F1/eo7/f
	 KnfX8LZ1B1J0wb76tPMQ9hLPSBzBpagdGyWogmiSylecycENY4pSGYDQXAttCUe+WB
	 cmqV/8lNLPX3C/g1c0pe9sFF9OOqGc9kmlrlPO8cjN631o+Z6DJ5N/3Ru9m4HcwcT5
	 BqaiXS/MI4cAA==
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
Subject: [PATCH v6 13/16] KVM: selftests: Refactor allocating guest stack into a helper
Date: Wed,  6 May 2026 01:57:29 +0000
Message-ID: <20260506015733.1671124-14-yosry@kernel.org>
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

In preparation for reusing the logic to allocate stacks for nested
guests, refactoring allocating a guest stack and aligning RSP into a
helper.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e7..94a1cadb2b26b 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -778,6 +778,30 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 		REPORT_GUEST_ASSERT(uc);
 }
 
+static gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages)
+{
+	int size = nr_pages * getpagesize();
+	gva_t stack_gva;
+
+	stack_gva = __vm_alloc(vm, size, DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
+	stack_gva += size;
+
+	/*
+	 * Align stack to match calling sequence requirements in section "The
+	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
+	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
+	 * 16 when control is transferred to the function entry point.
+	 *
+	 * If this code is ever used to launch a vCPU with 32-bit entry point it
+	 * may need to subtract 4 bytes instead of 8 bytes.
+	 */
+	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
+		    "__vm_alloc() did not provide a page-aligned address");
+	stack_gva -= 8;
+
+	return stack_gva;
+}
+
 void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 {
 	int r;
@@ -820,27 +844,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_mp_state mp_state;
 	struct kvm_regs regs;
-	gva_t stack_gva;
 	struct kvm_vcpu *vcpu;
 
-	stack_gva = __vm_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
-			       DEFAULT_GUEST_STACK_VADDR_MIN, MEM_REGION_DATA);
-
-	stack_gva += DEFAULT_STACK_PGS * getpagesize();
-
-	/*
-	 * Align stack to match calling sequence requirements in section "The
-	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
-	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
-	 * 16 when control is transferred to the function entry point.
-	 *
-	 * If this code is ever used to launch a vCPU with 32-bit entry point it
-	 * may need to subtract 4 bytes instead of 8 bytes.
-	 */
-	TEST_ASSERT(IS_ALIGNED(stack_gva, PAGE_SIZE),
-		    "__vm_alloc() did not provide a page-aligned address");
-	stack_gva -= 8;
-
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_init_sregs(vm, vcpu);
@@ -849,7 +854,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = stack_gva;
+	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.54.0.545.g6539524ca2-goog

