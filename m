Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44E1509AB;
	Fri, 13 Mar 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360644; cv=none; b=hUC+c77T+s30vsru3XTEHCzJFwm6Dpg17Ljn/bhCAJCGvNA5YOlMh179VoYGtt7qqyfn/0bZNHa/UJ9fd2CPKKIqWKA6JWPowjxiHBqsS+i3teH81EJUyUXilpMRBNScNAz6RziF68ZaCBemEv+PgyEsr/5RfwLR9wBzwlBEbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360644; c=relaxed/simple;
	bh=tOmuDE/3A9OQe9ynRNYbm8QoWd1HM+6aHE0JMfAxyyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASI+ecp/uGhVYSq1oVS2hl7+bjgmdADW+frobulOaao5GSa+uuTIG94nkrVOgKDBqwV7hFzdCoFQbc4pGfPQLEYpd9/xREaidA6VQNcT1cob/uqEt1hYlHmIkdMsxAaROKktbnXmHwVlL3u0LhtuHNoN4dsceuR8E1woPSiP9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyoMNgle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyoMNgle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7A4C4AF09;
	Fri, 13 Mar 2026 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360644;
	bh=tOmuDE/3A9OQe9ynRNYbm8QoWd1HM+6aHE0JMfAxyyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyoMNgle1Rz6FC/QebyjYvCEaXiRoky4dd97Ietf4ZxsS3pubDzCxtzfdJcA4T7jf
	 y7DxN/2GyTUYUvifMBWEO68MLdTvhG8r36df7sQEUFPz/4LBCRS7jAGoF/inOfg4ND
	 IHDR6L99dpaDTnIQDwnk6Ehy1cGmQDpsCy1YYubj3TpxCq/aMDoDcNKX2b7Xp2IpLE
	 TQMv/bu2Z417i+7SAUiQuAQZwsuMXX5DOv2AJZqm16ropLfqFBwi4LaBNBstTthZ1g
	 ewcr/kBemZ0iJAq7pbk7P8ixXXdFab+AvWy6kLWHKs4KHaOC5evkA+pCSQAiEFTxf4
	 7FS4pUtekFpWw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 4/7] KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
Date: Fri, 13 Mar 2026 00:10:21 +0000
Message-ID: <20260313001024.136619-5-yosry@kernel.org>
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
index f019a3f7705ae..3b1516ea45d4f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2196,10 +2196,8 @@ static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 		return 1;
 	}
 
-	ret = kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map);
-	if (ret) {
-		if (ret == -EINVAL)
-			kvm_inject_gp(vcpu, 0);
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map)) {
+		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
 
-- 
2.53.0.851.ga537e3e6e9-goog

