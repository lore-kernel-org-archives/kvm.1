Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6643E3C67;
	Wed, 27 May 2026 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925649; cv=none; b=Mi4DjT4hqkO9CM8mE4w4CGrW0DEsSqq2Hd6MXM/xRb/q5EeMPH4HjeAizhPtNVzMkLBU97aS0UR6+l4ozatfje+dyLci2ez6Wa/PkiYhUSlFSlLbWvujQwT2UsoUXsybHbZDvt5wLo+l0FGwijZx9mB92gv3WJuuirOcPg9+byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925649; c=relaxed/simple;
	bh=OI+xfgAyuNI9hANCEwWyv7RuIVole8DA9b84kwMlNug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9iax7f+M+pY5ngEWt7raYdRVLiQJNNAgqtZBHS0WHsBBkUVuZrpvXiPgNq9HJrd44S/dWU0RVY1UgBeM1wRZFgRu18u3JljM1CDiGpLWRGyoX4GuSikM78bJYQwB6ZenVjJW5gMtKH32XW1Qc1IluQNv96PNCewuWrrSeTE6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIJItrc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIJItrc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCD71F00ACA;
	Wed, 27 May 2026 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925648;
	bh=0lACjNcIpZ/rfwqoS4imDme5ztaTLdxIhnFZ+jb8Clc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIJItrc5XCA5LYwvsPhVI1F6vq6Gzd3mYkpLpmpdFwu2N7KHcnDPFVU3bXfq3+PmS
	 rQZPu5VcFVY+qkvOgvQ/3+4ax8vfUEWGfhQc3bioh6TTBNQqU+RAbTSDW1cA/O+Ngo
	 TxR4NlnyPYN7mqSiw2nu1r5Ob/31hjbmbsYE0rZRoq7OIlWeHl71N+2BIh3W4DUebj
	 nF1SYy11JirTTrysnLZMIb8Cbn86Gd9uqXr6ye+ECNTqUL4nwhy9Ti3mfSJvmYWJwb
	 A/Zubpby0q4wEYXgp6ISEDJDmSbwmaDgbdpw6DrtTikFZQZ2AgEYV4OsPbrPhD9wDh
	 uJ10qyGks9QQw==
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
Subject: [PATCH v7 14/17] KVM: selftests: Refactor allocating guest stack into a helper
Date: Wed, 27 May 2026 23:47:08 +0000
Message-ID: <20260527234711.4175166-15-yosry@kernel.org>
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

In preparation for reusing the logic to allocate stacks for nested
guests, refactoring allocating a guest stack and aligning RSP into a
helper.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../testing/selftests/kvm/lib/x86/processor.c | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4ca48de7a926d..9393bb580a58e 100644
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
 	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
-	regs.rsp = stack_gva;
+	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
 	vcpu_regs_set(vcpu, &regs);
 
 	/* Setup the MP state */
-- 
2.54.0.794.g4f17f83d09-goog

