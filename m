Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75090481FCC;
	Fri,  6 Mar 2026 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831352; cv=none; b=fZDh7FXGvIIvtfohjhdmSy2klFI8LgeDuO0A51CQ+tOTtPjGD16v8EphvbxJgAMb1ktApwUDQf0KB20NR9fpgU69RJynG5POWfVlA14qxdT6VQI9hQ0kQCIH9t2H39xLRysJYUJK1TtBSyrGoWWCaLJ+Yt7URHztzf3qwUngqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831352; c=relaxed/simple;
	bh=CzgGTWWUcPgcLTG0JmCUypOX1KdDxGsKqlELDtaWJZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlPFVPdvFFB+rXwMvJ1PQoKDjjo5ok7bUIdLpTjoJNZTQkcivgHUoW8iHhoYujuVbQHdZKycDQ7fmaPRCnhVXEyuaKztp8x2iP2NcnOi7+MSFOoKi1Fh/Jme8zofJFegjG1f+AczDr/HJw3qelAq82gJjShwJvNQiKP3gMmptc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u51syaj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u51syaj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA92C2BCB2;
	Fri,  6 Mar 2026 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772831352;
	bh=CzgGTWWUcPgcLTG0JmCUypOX1KdDxGsKqlELDtaWJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u51syaj+rCMA2ab2LQvD0LoLleEA7d+uWhQm8lWFWiuT4c+KvEbHszr7wJ87l3tri
	 mnjZ6IXMe4D2BbbBkEU47qCQwg7RJTp+nrBqZGLkRTtcs/+GAOEVU+lqFbFiHjZ/L/
	 43YPr7c8GN2kzla8SgLfUa6f9Dipwffisc9PTXt+6gETaIapfW6Z9eDP/qTqdlKBjH
	 qSi7vLaZCCl71kWAi6c5aHD3KoXOH40qDmKDQF4DsPsr/iYiW6BCyB9LFnyabt3nRP
	 q4jPsBVaaowuiX32Rowwb5hzDtkwCuVZNS66rArDAvpei/p8cq37Kn57h2Hovmm+eN
	 +ZYfrXj47jhwQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 3/6] KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
Date: Fri,  6 Mar 2026 21:08:57 +0000
Message-ID: <20260306210900.1933788-4-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260306210900.1933788-1-yosry@kernel.org>
References: <20260306210900.1933788-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a #GP is only injected if kvm_vcpu_map() fails with -EINVAL.
But it could also fail with -EFAULT if creating a host mapping failed.
Inject a #GP in all cases, no reason to treat failure modes differently.

Similar to commit 01ddcdc55e09 ("KVM: nSVM: Always inject a #GP if
mapping VMCB12 fails on nested VMRUN"), treat all failures equally.

Fixes: 8c5fbf1a7231 ("KVM/nSVM: Use the new mapping API for mapping guest memory")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3407deac90bd6..7ec0b0e8945fe 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2190,10 +2190,8 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 	if (nested_svm_check_permissions(vcpu))
 		return 1;
 
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map);
-	if (ret) {
-		if (ret == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map)) {
+		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
 
-- 
2.53.0.473.g4a7958ca14-goog

