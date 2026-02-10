Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE5221F15
	for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685713; cv=none; b=XvfiCbZuXdptelWHF6ByiwH6X0IO7O8QMtk3BD9QdIRN2kLVD0+OazVLA3DOnQYbmCfiwIz54CLmiW8a7jubu+abIODMZW9aPywbc1bYDoCq9jUQlw92QQfg357yWtUFYLDihKbTK+ULpyMHeee/kQBlXMZkKjxw0lW/gYGF2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685713; c=relaxed/simple;
	bh=UgFMK87gMbiLTkxPxNtJt5viTEUwEhQAaH4Gg0AyR28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rv45llVmBMwH4HJ4OYHsvTqBgec8q11/4pG9QA6tw8kbrO05S/oKsqYe4Gdq8eNRGmA9RWxkxqzLzZnj6qEKzjHqXXBghHRrOLj8HrtqfiggWebygV6IN0qSx1suuNmmT08mMTVibeUiM0LmPuibuutpBHtPfSqm2xphJU9nfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tfLppn6F; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tfLppn6F"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770685709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oss6+Yt6vPsRwCho8KPS5orhk3NXvZs6/NMsKCKIGG0=;
	b=tfLppn6FG2l1ups5PtduKSMT9L4RunS6TLXPA0H6osKF7gRvFOmWHaeFW1EDt+wdJ1kQS9
	PplaQSuZCxQbzxqqLNkVFEXXc2iYEFzKMnpXZDkI3VAyJhTQGSftq7y7YP/EODR8XK+3h3
	tDTaJuqy5VIqZc2M9JEqNoppSn2Ks/Q=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nSVM: Mark all of vmcb02 dirty when restoring nested state
Date: Tue, 10 Feb 2026 01:08:06 +0000
Message-ID: <20260210010806.3204289-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When restoring a vCPU in guest mode, any state restored before
KVM_SET_NESTED_STATE (e.g. KVM_SET_SREGS) will mark the corresponding
dirty bits in vmcb01, as it is the active VMCB before switching to
vmcb02 in svm_set_nested_state().

Hence, mark all fields in vmcb02 dirty in svm_set_nested_state() to
capture any previously restored fields.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index de90b104a0dd..6ed333fcf0c3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1909,6 +1909,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
 	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
 
+	/*
+	 * Any previously restored state (e.g. KVM_SET_SREGS) would mark fields
+	 * dirty in vmcb01 instead of vmcb02, so mark all of vmcb02 dirty here.
+	 */
+	vmcb_mark_all_dirty(svm->vmcb);
+
 	/*
 	 * While the nested guest CR3 is already checked and set by
 	 * KVM_SET_SREGS, it was set when nested state was yet loaded,

base-commit: e944fe2c09f405a2e2d147145c9b470084bc4c9a
-- 
2.53.0.rc2.204.g2597b5adb4-goog

