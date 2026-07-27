Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD2433BA4;
	Mon, 27 Jul 2026 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196369; cv=none; b=QvdfIt0uO9T113PJrLCnQEBvS/dnIhXyu+h1CBMmMuz2MMQdfhZ9oDXafKRPdtGl+7N4jiEoN5FVJF3Dc4SnORNf2NLJQTpOsCTN6X680dfsaePAnhz/6t5ga6wGy5uVATLtfzQbCK+aYNc3ul4dMSReBDAikuObNTFrvVGp2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196369; c=relaxed/simple;
	bh=+9qUShhZnYumVuLXQiWy6dvid3L+Y4olXDcRQDdJgWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZrhZqiVq4ukBcRkuuFKThaCrQc/exSITu720ZjquwFK1QDg8sbsq9VaX950M716LPMqgVTJT8MPC9YE3xOy8fDchHqsU5qsO0ZSDyrx+lLba8SUeCADFDXCAYNBzB1x/TrRvGfKuDKb7kdJE5QPBIsYYMMokO5yhv/6N4dBcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF1Dm7yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF1Dm7yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD10D1F00A3A;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196368;
	bh=eUVzPtU+Xrf8O4rcMMOZJ6dbNa2g6Xg8o/T2lZw+Wvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DF1Dm7yiR4Ny3TiacGIJWDEiFNvHOazeUrrrIDHybnhHTjuaeQnSYywJVA5GWIxyZ
	 6ihKlQ3gwwnRDG3H+qCYEs6SLfwlHQ2pv1g6nDz3e4DItTlEYrfePwwSnqELR9ooax
	 rcTomp1xGOEBmGWGwkqB2fWgX98nzuE0Ty98rNmlUrQBXC/v9Pzkhoyc/AGXPnuX9w
	 ZFoXki/IkczSQNm+qngBES+yQmqsp0g2G6oT9TMS0IfrfFQRKuPV5xgZtmeU4gjBKV
	 Luq06uG91rr8aiV/38d5Kmtcf5Rn9ejMzqU2WCLOeOGoJd+ljRKe9gWXs6hRz+RDYK
	 R6+5BpprUJmNQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 08/12] KVM: selftests: Expose PTE masks to guests as part of an MMU
Date: Mon, 27 Jul 2026 23:52:24 +0000
Message-ID: <20260727235228.1007324-9-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose a guest_mmu to the guest to allow guest code to use the PTE masks
for page table manipulation. Since guest page tables are not mapped in
the guest by default, zero the PGD in guest_mmu in an attempt to make it
more difficult for new tests to shoot themselves in the foot and assume
that page tables can be immediately used by guest code.

Ultimately, guest code can read CR3 any way, so guest_mmu.pgd doesn't
add a lot of value.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/processor.h |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index dab64688e8eae..06d9ba1c4df33 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -24,6 +24,7 @@ extern bool host_cpu_is_amd;
 extern bool host_cpu_is_hygon;
 extern bool host_cpu_is_amd_compatible;
 extern u64 guest_tsc_khz;
+extern struct kvm_mmu guest_mmu;
 
 #ifndef MAX_NR_CPUID_ENTRIES
 #define MAX_NR_CPUID_ENTRIES 100
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 1f9201590f5b3..d31fa81ea0756 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -28,6 +28,7 @@ bool host_cpu_is_hygon;
 bool host_cpu_is_amd_compatible;
 bool is_forced_emulation_enabled;
 u64 guest_tsc_khz;
+struct kvm_mmu guest_mmu;
 
 struct guest_regs guest_regs;
 
@@ -831,6 +832,17 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
 	guest_tsc_khz = r;
 	sync_global_to_guest(vm, guest_tsc_khz);
+
+	/*
+	 * The guest MMU is just a placeholder to provide access to PTE masks
+	 * (for now). The guest does not have mappings for its own page tables
+	 * by default, so any meaningful use of guest page tables requires
+	 * explicit setup by the test. Zero the PGD to make it obvious the guest
+	 * page tables are not immediately usable by guest code.
+	 */
+	guest_mmu = vm->mmu;
+	guest_mmu.pgd = 0;
+	sync_global_to_guest(vm, guest_mmu);
 }
 
 void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
-- 
2.55.0.229.g6434b31f56-goog

