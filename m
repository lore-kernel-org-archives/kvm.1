Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56255296BA9;
	Wed,  6 May 2026 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032681; cv=none; b=AbrsPS5QN2VIKaeK/i1H+NbMmGXYd7ToWqrbp9C1T0kP/y19iQSZmqj3hYjSFyINAFbIhf8AxcDyJ9etODYZ48MecZdvVBos5vEGu4Uk471tqijhG9DkisErlByo0g2CKKqhMh+M4Aa651Gp1Y9RCLVCr4FWmzG3hqdriiNriy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032681; c=relaxed/simple;
	bh=mGGd8tZ63q+J62gW32bgSGIV4Zg3Cz+xJFbXsCrIfzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6eqDA0qObBBi+jezG7qVhVEzEDnK1Apqf6wXvQ4vt8/CQi4QO2jfCiP/QWxwXHBngy/Eh1ZidtZzjur+Q0AT3kSufNSVKg5KBXieiidudElIv4WXVReOlNgp1skdFAsqVMFl/w3GZzx9Hpm3t8ycgCiis+Q4aCyFlhNytEC6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbY5cdCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbY5cdCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A221CC2BCF7;
	Wed,  6 May 2026 01:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032681;
	bh=mGGd8tZ63q+J62gW32bgSGIV4Zg3Cz+xJFbXsCrIfzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbY5cdCxhmslb3iyPfay2pm78ElX41YQU4Ck5s8QsmhIfA1OjglP7/mFxR9a1TZRW
	 m1ONCBB3A6hbs1LMN73rahvt9npCEC7prnsAP/qt8vIeeKZKhKyDDrI5f+kKE3drLI
	 pzoEE1z7nJW0HAscb5PPMlmZOo09gzK3LpdBxoE8n5VxktQ2y67mBQ0kgZOUwAzd+8
	 /ghc+i7gm+FmGTViPQO6M/g1jXtMixyep7caFMgIPGQQ3kHf563HtjGsxvRRiYi48H
	 3oYhLRJPmebUov4hbEuaxJDiN4p9tzx3RKUtRYpl53KskbJGfgWlFgfLfbJIcqUD9y
	 biNWlVWrlpFvA==
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
Subject: [PATCH v6 02/16] KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
Date: Wed,  6 May 2026 01:57:18 +0000
Message-ID: <20260506015733.1671124-3-yosry@kernel.org>
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

