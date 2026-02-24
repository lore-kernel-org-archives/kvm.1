Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011E2FF14D;
	Tue, 24 Feb 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972462; cv=none; b=UDkGcDi/Cs5JVmnTK3ePCwWjhi6g9+0nPTwJ5CFQGc2y6AgDafqmqAS746PnLXF33dPzZcbK3qV1v89i8U2NN2d8alrG9OB712aQQZqHt5+5BBR/RhsdePfpMI0ebInw5hZE7fl7ypt8mthbBQP+xQesdcuYIilbXg8JvQKDH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972462; c=relaxed/simple;
	bh=Vhp3vuWokN317wHEb9O9UL3ilPmfH+y4ZZA1i44uBXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwPe9cisE/AXEJdox5xjh5HZbL7lJ932gnHH+iJAyCLweqdlVoNT4ufQpdHsO7A6Qqxa+beJEuMqv5M8NaDWYZVkhTlOtqqgFdsBmUvwjuaEdHzzh78b79cuUzO1HrV2osksO+xgdslBNyckQI+IuLaRII+b6I/m/SNbEixr2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdEt87CW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdEt87CW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E8FC19423;
	Tue, 24 Feb 2026 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972461;
	bh=Vhp3vuWokN317wHEb9O9UL3ilPmfH+y4ZZA1i44uBXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdEt87CWIFfBIlDirRh7TT4naJikdwC6O5lZdYxe05MXCamybiAz2YU/TPbWwSqTR
	 neMf7Cj6EXr18sskbWLV7G6yzL5nCdxN70P41B8qKDun4dgkS8Vmc3aaYPCgIY41hn
	 Rs/gcVUK79cRSbXM4cyNzl+Ae3RHdAGoKYV8cm3/eyOhueLhxCCg2RKqD/+OVSzadW
	 BwvbamYKK8RQaASYhRDF8JRBzvocv9ot3JuyhvnJhOrB/en9C/0n6Kxk0YRUSeH4HQ
	 BJW33ERf7PYRjnOerXRP9CwvCNR+F28jT8s+ozpqxIkWggX0kb3MtY2QPd2WEPk9u7
	 xmn/DWKuiAPPA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v6 01/31] KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12
Date: Tue, 24 Feb 2026 22:33:35 +0000
Message-ID: <20260224223405.3270433-2-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260224223405.3270433-1-yosry@kernel.org>
References: <20260224223405.3270433-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

svm_copy_lbrs() always marks VMCB_LBR dirty in the destination VMCB.
However, nested_svm_vmexit() uses it to copy LBRs to vmcb12, and
clearing clean bits in vmcb12 is not architecturally defined.

Move vmcb_mark_dirty() to callers and drop it for vmcb12.

This also facilitates incoming refactoring that does not pass the entire
VMCB to svm_copy_lbrs().

Fixes: d20c796ca370 ("KVM: x86: nSVM: implement nested LBR virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 7 +++++--
 arch/x86/kvm/svm/svm.c    | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd5..a31f3be1e16ec 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -714,6 +714,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	} else {
 		svm_copy_lbrs(vmcb02, vmcb01);
 	}
+	vmcb_mark_dirty(vmcb02, VMCB_LBR);
 	svm_update_lbrv(&svm->vcpu);
 }
 
@@ -1232,10 +1233,12 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	if (unlikely(guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK)))
+		     (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK))) {
 		svm_copy_lbrs(vmcb12, vmcb02);
-	else
+	} else {
 		svm_copy_lbrs(vmcb01, vmcb02);
+		vmcb_mark_dirty(vmcb01, VMCB_LBR);
+	}
 
 	svm_update_lbrv(vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8bc863e2143..a2452b8ec49db 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -848,8 +848,6 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
 	to_vmcb->save.br_to		= from_vmcb->save.br_to;
 	to_vmcb->save.last_excp_from	= from_vmcb->save.last_excp_from;
 	to_vmcb->save.last_excp_to	= from_vmcb->save.last_excp_to;
-
-	vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
-- 
2.53.0.414.gf7e9f6c205-goog

