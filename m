Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD853AF668;
	Thu, 30 Apr 2026 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580881; cv=none; b=TUnDQGmQT4hVFdWkBQM45rMYuTMg6Pjdq4Nnv4jmdGl+empfv0IWLiPz8Wu781dWs7OriEsMV1W79yPxINVDQAcstdX+GOEE7RfBkQTTTATZIdo7cfArd75uOPp6TpFgmaZXtpl9oSrwdW+JGEyw++axU2sgdscPnrCpVHBjpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580881; c=relaxed/simple;
	bh=mGGd8tZ63q+J62gW32bgSGIV4Zg3Cz+xJFbXsCrIfzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD3Kp2bG3sRxQRzEfxXM/W8genI8mBH0ChAIgIpn0e/Z+PJdNneCCZ482R5VCsbeTnFx2FyWDS3xQm3lpwYmoiyBHgVJ/uAedW/jQbOIX2eFQSvjWzltN5pkY/8GPRcGbQeJgwxL6RR+2OU+xL4cULH4Q/VMZIeC1chDjdLJnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So79m+tD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So79m+tD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF82C2BCFF;
	Thu, 30 Apr 2026 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580880;
	bh=mGGd8tZ63q+J62gW32bgSGIV4Zg3Cz+xJFbXsCrIfzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=So79m+tD1RdgzpnfCmN+km/c+st96I4CylqG0Xn9rY4tbHV3unoYtteM9qXt+GjI1
	 9QASD6XeqFazba8pYMCAdKaWeDTy+9QP46WQEU3KfNYYtjmRQrtu8QMngzNdPDII5P
	 ZKvG5e70xqahIUVepL9PsIxQGZC8XXPbObmADwMLbAlkRtsFY5Pfhb+CJqamYsc1Yz
	 oE1tC6IN8yR0wWY76d/xMznSZx1uiEDj7Fw7ivyIOtjxKilY7MJp0yO4PrX6FB2Bhn
	 LzX/5XsqtiMKvhymC8ihavt4iJcCH0zEC7+Q8QVApqiGSqeaWqWr80Am4QB7qYZrYX
	 a4zxBBCTpXAVg==
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
Subject: [PATCH v5 02/13] KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
Date: Thu, 30 Apr 2026 20:27:39 +0000
Message-ID: <20260430202750.3924147-3-yosry@kernel.org>
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

If kvm_skip_emulation_instruction() fails, then RIP could not be
advanced correctly (e.g. decode failure when NextRIP is not available).
KVM will exit to userspace to handle the emulation failure, but only
after stuffing the wrong RIP into vmcb01 and entering guest mode.

Bail early and exit to userspace before committing any side-effects of
emulating the VMRUN. Unify both calls to
__kvm_skip_emulated_instruction() into a single one, but return
immediately after if copying and caching vmcb12 failed. A side effect of
this is that the FIXME comment is now above the only caller.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5dfcbaf7743b0..0f6ea490d707b 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1120,21 +1120,22 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	}
 
 	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
-	if (ret) {
-		if (ret == -EFAULT)
-			return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
-
-		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
-		return __kvm_skip_emulated_instruction(vcpu);
-	}
+	if (ret == -EFAULT)
+		return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
 
 	/*
-	 * At this point, VMRUN is guaranteed to not fault; advance RIP.
+	 * At this point, VMRUN is guaranteed to not fault; advance RIP. If
+	 * caching vmcb12 failed for other reasons, return immediately afterward
+	 * as a nested #VMEXIT was already set up.
 	 *
 	 * FIXME: If TF is set on VMRUN should inject a #DB (or handle guest
 	 * debugging) right after #VMEXIT, right now it's just ignored.
 	 */
-	ret = __kvm_skip_emulated_instruction(vcpu);
+	if (!__kvm_skip_emulated_instruction(vcpu))
+		return 0;
+
+	if (ret)
+		return 1;
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
@@ -1164,7 +1165,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		nested_svm_vmexit(svm);
 	}
 
-	return ret;
+	return 1;
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-- 
2.54.0.545.g6539524ca2-goog

