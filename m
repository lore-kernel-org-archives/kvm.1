Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB2A3F0AB9;
	Mon, 16 Mar 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692866; cv=none; b=PRd7F4xpDQ5kF1UYvR7zed7UdKLg/z1i/QXyWAchvmZFd0LDG7E3+4YDnTk4X/9ujEmA0ltqV9UVnIx2UteAlhsmJgEAqTxii7QypYQqxGEGumx6hF3ojwTxVL9fBz4Wod7LMB+uKSgy5ZL2GaRL4aqaSarVWqZJ+v6229woT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692866; c=relaxed/simple;
	bh=1GBVDpxhiKQR9Qr5dCENGk8SY6ddmFWjDrNwoXXxb+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pdrmz9fMjozEBxXi0hcsPdx0MHwUzqc5IUrSEIlKFjWxNPoi0PsTE92RTA2JOu4E2jBuMU7xBoUeY//N8z6HKczat/c+ZSNoHU2ilhk0QA0dEJwgY7bBs/54WfLW2qkxJQ/9AzAbUt5pmYSJnsqaiuGRn/Wqn21DIg4YCMCEQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgSnad3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgSnad3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFB2C2BCB8;
	Mon, 16 Mar 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692866;
	bh=1GBVDpxhiKQR9Qr5dCENGk8SY6ddmFWjDrNwoXXxb+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgSnad3dxLABuxEqOk7qttxHkmUkmiwT+4N0y0Y/P5jFKPxxQofVV3DeK/l1mfsxy
	 IpUSoyMuih6QkMz9adEtvxth3PfSNBVqCO4+G/Dsbxq16V4klTsSKBXnvNnVDTQ4dQ
	 Rj3AG4CtYqp7osreb9nihLc1iRvHz+q2+tequl1+9AQMcGFXBwhEqVN4jdreyOHU+g
	 Ia0xPIYTjKrdBSD5uQoW+L0J7Gq8oU35xB9+aUBZpfBJTOdKsFNXac0OoS1vyeHIrK
	 fzT5Stqs7FtuaPYs/IBGylQmAtlnvrcWt3TWwsJm/trGHDn6L/YbPSr8LVlGiHVeV0
	 UWttLwPd8idBQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 9/9] KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name
Date: Mon, 16 Mar 2026 20:27:32 +0000
Message-ID: <20260316202732.3164936-10-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316202732.3164936-1-yosry@kernel.org>
References: <20260316202732.3164936-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test checks both invalid GPAs as well as unmappable GPAs, so drop
'invalid' from its name.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm                        | 2 +-
 ...{svm_nested_invalid_vmcb12_gpa.c => svm_nested_vmcb12_gpa.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/x86/{svm_nested_invalid_vmcb12_gpa.c => svm_nested_vmcb12_gpa.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3d372d78a2756..02fa13d4ad4f1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -112,9 +112,9 @@ TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
-TEST_GEN_PROGS_x86 += x86/svm_nested_invalid_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
+TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c b/tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
similarity index 100%
rename from tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
rename to tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c
-- 
2.53.0.851.ga537e3e6e9-goog

