Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2444C503;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260564; cv=none; b=fJD/QIa99v2F0BHyDlKuW8O4MzSZIa2h9gH0uuonS/23vi1FpcU+eO+/17QIlpYT1spARuC0lTvXs0rwwGyHcoKt9RgR+1jtWD3lAAro9vjOUmDqx6ckGLQ4X+u/8k4p1z+pw17mEFm4DM2aWdV25YN6C+Bmaw5Y/SW1xvsYEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260564; c=relaxed/simple;
	bh=l15asE7+7EUAE/Z5OP7a2BqH6PBadFkk7KHHfNZlTzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOBKdltiD+k8YiP4dFTSUFDRnXeWmGyMd2Xgh6tmSyS3wmnmd6cordSJnMOFRT2WOnHJ7x2YmHlGFvo0aZswxYDMJSXnEMdAYK9ji4BoqMx/E1GwPH2nEOLwIyMRllHWnSDatZrvA3FN2BVkhqunHZdBvPID+WqM14uckrK3jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxL3/URF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxL3/URF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4E21F00ACF;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260561;
	bh=RoC89DZcGv2r2dc5mZfNPHmreDqDWfSNFSnvepeiziU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxL3/URFBgwfcsCkRnNxlMRdwXZUVNGHykKixsuj5rgDmoeIaTg3Tw/4TxkeJcvJH
	 eZKyKwUFBY/NCaH1wqXwZX3oy5UwfR/SFx/qJpUZO0OMyYjTIWnyQLfT04Mfp8MJTK
	 QTxfMeNmIxhzNfvsHeWV3MlB4Qhq05sbZc5MgzL9TgUv3yvbzvgsRgd1KU2Nsp6p+V
	 XJM4B6wE65YQ2LD/+xbL/qGMCX4isMLO13gLVf8A77kl5M5zjKmTCp0xUzNlC+N2Pw
	 erju1F0mBjX9UZO1cFnwpIYCp3y491WwrXcTVcd29Uq1aD1OEhtWlwp6iN717hwi80
	 UGrVpnx33s6Kw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 08/13] KVM: selftests: Expose PTE masks to guests as part of an MMU
Date: Tue, 28 Jul 2026 17:42:27 +0000
Message-ID: <20260728174232.2423257-9-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
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
2.55.0.487.gaf234c4eb3-goog

