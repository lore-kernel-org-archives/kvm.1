Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180334F25C;
	Wed, 27 May 2026 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925641; cv=none; b=IwGKjjHyGTSvisRQV0j0TRn1tbwM5g5HOjMxVe2sQo/8MHbBOUivlqUOcSy+FCPhQUEqEQCkXsyrEWSJkxl3ptPhtyAuGuASjRs12ae+QMswVs/XZV8j78s06FPERjr9dZVu9gAQHgJR08qH6vJjdnVQ1ISXlpoZk2oyXkLLhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925641; c=relaxed/simple;
	bh=C9d8yBO9J4yCFc/5Ebpn1RJ2Ik8xbZ2fKHIem+1Jrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1jkr1sqQ9z/P6l6ANadF1Kcg1OitCf1fZXi7PnydftA8L3FgRVuIz1+vLPdN0MHn0LaPEjVdurc7PRFPGEKdbWiie26aqHrFcd/2zA9rPYBT9kR0XjmdQ5CYVJ2FL0jULN0XKZGznxMXaBjTORG5Zl+vJeVTn/cM94PUko8xkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpH1tB9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpH1tB9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAF51F00A3E;
	Wed, 27 May 2026 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925640;
	bh=maLHjx7aDGBVMG08GXms4oRWNwyzEpbFcX9pn3DcEuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpH1tB9+amOS97K1xAosJjekTsWqCCeaT5ajP4wbS8lWGZaywHOD0Jut8B4ir6V+q
	 0oGj6bLQymoBep4HeV2pyDPZNulOtwBPsc78UrhEJXjPwkRznhSsiDgpVcj29ZUuS7
	 WCDMVksZqvdBVTMOYEKnFLHBEv9FSl5T8hpasP+xYln8399kmsF9JaX7dKZqCnuI+C
	 9xhXvdx2XuoRCReYAS9mBoUJJSpJjRQe4uwPhIBpyBbg3Sks7CZr2x+QsSy/kdQdDY
	 ObQW+9Bn5Zyzi55dLZSWNP48HZcmrrdPSrgPJevg3VC0FZ8ohQc2ddHLxDqcFmxKBS
	 OO22sKbIFiacw==
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
Subject: [PATCH v7 02/17] KVM: nSVM: Bail early out of VMRUN emulation if advancing RIP fails
Date: Wed, 27 May 2026 23:46:56 +0000
Message-ID: <20260527234711.4175166-3-yosry@kernel.org>
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

If svm_skip_emulation_instruction() fails, then RIP could not be
advanced correctly (e.g. decode failure when NextRIP is not available).
KVM will exit to userspace to handle the emulation failure, but only
after stuffing the wrong RIP into vmcb01 and entering guest mode.

Bail early and exit to userspace before committing any side-effects of
emulating the VMRUN (e.g. entering guest mode).

Fixes: c8e16b78c614 ("x86: KVM: svm: eliminate hardcoded RIP advancement from vmrun_interception()")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 01e3e6fa8bbb1..ddf18a6daf823 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1159,9 +1159,10 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	 * FIXME: If TF is set on VMRUN should inject a #DB (or handle guest
 	 * debugging) right after #VMEXIT, right now it's just ignored.
 	 */
-	ret = svm_skip_emulated_instruction(vcpu);
-	if (ret)
-		kvm_pmu_instruction_retired(vcpu);
+	if (!svm_skip_emulated_instruction(vcpu))
+		return 0;
+
+	kvm_pmu_instruction_retired(vcpu);
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
@@ -1191,7 +1192,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		nested_svm_vmexit(svm);
 	}
 
-	return ret;
+	return 1;
 }
 
 /* Copy state save area fields which are handled by VMRUN */
-- 
2.54.0.794.g4f17f83d09-goog

