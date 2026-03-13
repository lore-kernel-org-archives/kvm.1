Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241F1DF75B;
	Fri, 13 Mar 2026 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360645; cv=none; b=mbksqhywXSYAgTtcmemK+vr0RG20MfUvClVorzmyRc1jEVUPnk1QxMBBzxIUL7WjRYHMfmgbF76qntTim4O3UBjOrUmr8aJT3figK4q9qYw9RV1y86F7bZuE5mbCCm60vq7+x7+yntc/xZZAd0/KHjMnmPeGUY6WnsTdV3ZuxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360645; c=relaxed/simple;
	bh=1GBVDpxhiKQR9Qr5dCENGk8SY6ddmFWjDrNwoXXxb+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzr1RosboBeVIrlPiJdll2yYqnieytbuAK17Gpod9Yuro+mrNWWvW4vEGmdO5H60ZiOWsbWoHIT8qYmtGpPq2ZhvNvxbsi/jZtvGmRJSidRObsTFhlQZdgh77ogUS96tT2CHdYVGb7O+1k+GwcsRcJhPP7sOZqswiuc0tAA11dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtLHlbOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtLHlbOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04FC4CEF7;
	Fri, 13 Mar 2026 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360645;
	bh=1GBVDpxhiKQR9Qr5dCENGk8SY6ddmFWjDrNwoXXxb+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtLHlbOEnBBpOgijPac5XFymq+uCqVPsP2/FHyp7MHjcZXMCVv9KJYbbTbHnsnvgf
	 kwYJTF3ErVGjygNMtuPNVBfFnam8Tqru6LaOnI1W10LmxqCulSiePzkRSXIx4BeWQG
	 y+AG3kmk+i3BNxbW2hEEOdGpbeYAbODtLa4DkFUzRxTN90N0zQ81iHWVFQ+6qmIGUr
	 sZ1J+LKGGVUG7stgJa7Hv+vINr7LoAs8pjG0s9O0+YPZNekv726EobAbCrZdmDIGD8
	 3nMOV2SeX3rmkSfbugIB5Us2g6Gygaq7l4NO4pquk+1zUouUDtNRdlKqIxE4ZKtcqx
	 p+LSfPf2WlNQQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 7/7] KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name
Date: Fri, 13 Mar 2026 00:10:24 +0000
Message-ID: <20260313001024.136619-8-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260313001024.136619-1-yosry@kernel.org>
References: <20260313001024.136619-1-yosry@kernel.org>
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

