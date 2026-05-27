Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975B3B4E8F;
	Wed, 27 May 2026 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925642; cv=none; b=sp3KtL0It33NUQZfeVJoYixlnJW+uXDsSX4n9NBNEyZV1W+FFbTglRYBPtmJTugjVR/l4ccCDwdcZEy6GCMUIM6XlCkFC5cfPa+Y3dI2yATg3liVhpty6/bekwVDC2W4sMWMmPMU10VlyboLupmI0ttiU1H+gvFuKiRC/FjfMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925642; c=relaxed/simple;
	bh=7+Tv4NBVSbknMRguQ3kWdxSF/aC1JK7bBli793XgeAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEXbrc+CjtJ66RyNXBlX/CpxnNr8gEnGl3V60i35X12Wqame+2IeQwRYxdx9tfnPvzZKpRGSWjllCK4d/d5aCjls8OBi27hkXNccmNzXj0D3X4gzNpqkWSBMoTHnNnothA/xbu8Q1LVeLC8pNXm5wxatkequICwsqcyKpZX3WEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2+uvpF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2+uvpF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477191F00ACF;
	Wed, 27 May 2026 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925640;
	bh=saBqk30OK+NzxA4VKs1MZapGHjQQor0woe2RYxM3Ypw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2+uvpF6tWV3DXtSI/2ctukogJEe/XfmcMBaWtxwXFIFMi26WS+1bhnS+fklPAIdI
	 LYrAMDn48v95LNwMrkgbKSUVCPkloxPBJ1AEv7jkM+YLjPUXK23ZpMbDtNECMJQCjH
	 LFsyPCPhb2UCsy08VevkoEnIBISuWDeQJacCi4k72H8ODavdnI+3qJ/GTdfRDJlAq1
	 +Dq4OyQXF3B5cMuMic1Vb2UVl95OQrYsVtDsCR4lkFJ0oE3wKa3z5tFoo4zWmt0Qmk
	 ETSV3DrUdiOaN6iXIL3Lb2E3X0ztFoe33+R7BOZ/y6h+Z7U1YuyDMsr95EcmT8PjTJ
	 5+WipdzZo3LAg==
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
Subject: [PATCH v7 03/17] KVM: nSVM: Unify RIP and PMU handling calls when emulating VMRUN
Date: Wed, 27 May 2026 23:46:57 +0000
Message-ID: <20260527234711.4175166-4-yosry@kernel.org>
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

The code paths for advancing RIP and retiring the instruction for RIP
are very similar whether or not caching vmcb12 succeeds. The only
difference is handling mapping failures (i.e. EFAULT).

Pull the mapping failure handling out and unify the calls to
svm_skip_emulated_instruction() and kvm_pmu_instruction_retired(), but
return immediately after if copying and caching vmcb12 failed. A nice
side effect of this is that the FIXME comment is now above the only code
path calling svm_skip_emulated_instruction().

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ddf18a6daf823..0063ccbd327bc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1141,20 +1141,13 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	}
 
 	ret = nested_svm_copy_vmcb12_to_cache(vcpu, vmcb12_gpa);
-	if (ret) {
-		if (ret == -EFAULT)
-			return kvm_handle_memory_failure(vcpu, X86EMUL_IO_NEEDED, NULL);
-
-		/* Advance RIP past VMRUN as part of the nested #VMEXIT. */
-		if (!svm_skip_emulated_instruction(vcpu))
-			return 0;
-
-		kvm_pmu_instruction_retired(vcpu);
-		return 1;
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
@@ -1164,6 +1157,9 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 	kvm_pmu_instruction_retired(vcpu);
 
+	if (ret)
+		return 1;
+
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
 	 * state.
-- 
2.54.0.794.g4f17f83d09-goog

