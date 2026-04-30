Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A493C871D;
	Thu, 30 Apr 2026 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580885; cv=none; b=bnk5zWeMmdv+vPj4iCd3bojCP7FdgaTrqUcMvUGv9K0fX6rF17EZB/4R/fJxP0VKPvxHZ2MLf1n5uL5lmmN4yH0dpE23g+aRUCzk1KlPqS2kDf6VCjikVxZnB9JNTfZrGVOTj0tlG4G8h1gjFBwA+3qH/NkuloUU51Ka3jsaj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580885; c=relaxed/simple;
	bh=peLf1xjVZgVyqN2SqYE3bmr9oD1pXuOn5SU63DvVSnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HE75y79LoHhO/YbGoGMZG8VE96XmuwECtmYEWrp9XCCfH+hABa1l7cvOoF8yAf1LJRv2+fhb6b+HJPZsqmhZ9Gxj0j+Whqt9Te3Tiv4f0E7kQSlrAIphEwCBcR4a9HQISXn+imFaEWup1yz4IPe6kw0I2VzYDUWZCSCMyrytEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvQMzCZb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvQMzCZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E728FC2BCB4;
	Thu, 30 Apr 2026 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580885;
	bh=peLf1xjVZgVyqN2SqYE3bmr9oD1pXuOn5SU63DvVSnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvQMzCZbkMZ5rXcASvLqtlRTVWcFycpepD+hRDKxseMzaul9054r1PH4U3Df2nUBs
	 sdHOQv7lgYKr18+9imlmW9dFk1tV+DNqaJNkrIMqlATUJWKKz25PxecxecKYVrcoaG
	 HShW5mL2E+cNJqq+NtL3NoHaxkIOiJqmRM9jW1wgK7ToQgWlzsWd0L6bexwLxqjVZo
	 lNBZyJ2q1i+injrge5jzSEqOgxH+km31k20iePCFv4KuPCOcqI4lXjECbbn1QlPtpz
	 r68I45+ully34gsS/utY2xh+r/BFBvLufp+C3wk5oXbIRuThAyL0PvrESSz5bHdRP7
	 xiG7yVqC2A/4A==
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
Subject: [PATCH v5 10/13] KVM: selftests: Refactor allocating guest stack into a helper
Date: Thu, 30 Apr 2026 20:27:47 +0000
Message-ID: <20260430202750.3924147-11-yosry@kernel.org>
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

