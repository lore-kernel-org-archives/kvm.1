Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4A24677A;
	Wed, 25 Feb 2026 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981201; cv=none; b=gw8I9mEQsncy2Gv3iQOmlBAtZcEATYmQ5inuH9shiKTUmyGYtLimrndGh4Gw4FcFv44zsOtSoTb6XzxFDDf/IDstoxQnuhz2UIiG/zBc/RU2PByE2a2EiqCoSKjX93w8/Ui23Dykic9VtzUhNVjeYlXYtqlyutURaXEP7wKPJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981201; c=relaxed/simple;
	bh=psTgTDmkBB+5q3oS5ZinWmYelhMqgnO61QHn7HGrQfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDGsX9rY+byiBM4jS5UbSVm4Yjn+lsPxtEJILySb09f2htXZwE2YkvLT2VI7KAE+7XOSk9uZeuCmonghY7H/J7ayGVsOv5CE7Hs09RORHvJLim7jevwHQsAPyUBKH5a243HDyH/cEx9TdgUpJLniVueaCKD+ijYdluLTq7Z+0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP5D/hiI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP5D/hiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88721C116D0;
	Wed, 25 Feb 2026 01:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981200;
	bh=psTgTDmkBB+5q3oS5ZinWmYelhMqgnO61QHn7HGrQfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TP5D/hiIbTS3RfNFXvlMH7plMu5oDJBFN3I/ysnJWKDI/qUQeQbkU4bzvUvpIrL10
	 lG4hwoXJM+y4sJXFkHe/kLjBBt/Jrj1eTexmzHninBb/82mnh//4JmC9cTy+2M/JCz
	 atDDBi5p8wLOHCCTnFZx8i8wnA2s6kEIbqH8TG8ZcoMVFVb/nvx5J3ZUp8YBLTbRKJ
	 OCbjZCG0Hdw+yWYoQovXHadP8kPoA2FBrDJidxwfp8M6mXtA+enQlOFVZHEm6bKvjE
	 KISweLTqquq37Ade0/fJHobCam6pgKkRjBBbk36nS3KkVcojSPbwWqwuIYZcmqbLJJ
	 lalhqNt7oWfVQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/8] KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
Date: Wed, 25 Feb 2026 00:59:44 +0000
Message-ID: <20260225005950.3739782-3-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225005950.3739782-1-yosry@kernel.org>
References: <20260225005950.3739782-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After VMRUN in guest mode, nested_sync_control_from_vmcb02() syncs
fields written by the CPU from vmcb02 to the cached vmcb12. This is
because the cached vmcb12 is used as the authoritative copy of some of
the controls, and is the payload when saving/restoring nested state.

int_state is also written by the CPU, specifically bit 0 (i.e.
SVM_INTERRUPT_SHADOW_MASK) for nested VMs, but it is not sync'd to
cached vmcb12. This does not cause a problem if KVM_SET_NESTED_STATE
preceeds KVM_SET_VCPU_EVENTS in the restore path, as an interrupt shadow
would be correctly restored to vmcb02 (KVM_SET_VCPU_EVENTS overwrites
what KVM_SET_NESTED_STATE restored in int_state).

However, if KVM_SET_VCPU_EVENTS preceeds KVM_SET_NESTED_STATE, an
interrupt shadow would be restored into vmcb01 instead of vmcb02. This
would mostly be benign for L1 (delays an interrupt), but not for L2. For
L2, the vCPU could hang (e.g. if a wakeup interrupt is delivered before
a HLT that should have been in an interrupt shadow).

Sync int_state to the cached vmcb12 in nested_sync_control_from_vmcb02()
to avoid this problem. With that, KVM_SET_NESTED_STATE restores the
correct interrupt shadow state, and if KVM_SET_VCPU_EVENTS follows it
would overwrite it with the same value.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd5..9909ff237e5ca 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -521,6 +521,7 @@ void nested_sync_control_from_vmcb02(struct vcpu_svm *svm)
 	u32 mask;
 	svm->nested.ctl.event_inj      = svm->vmcb->control.event_inj;
 	svm->nested.ctl.event_inj_err  = svm->vmcb->control.event_inj_err;
+	svm->nested.ctl.int_state	= svm->vmcb->control.int_state;
 
 	/* Only a few fields of int_ctl are written by the processor.  */
 	mask = V_IRQ_MASK | V_TPR_MASK;
-- 
2.53.0.414.gf7e9f6c205-goog

