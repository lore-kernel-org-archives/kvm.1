Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4B26A0DD
	for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684923; cv=none; b=JdcgicuHV9/kaP1dxrZzCYrgK1X9CjQ9K8LyhBkwIp8IH0DATl7SL9Wu8E5V2iHu6x8dO/7/D6EgveXSsiAaDyKIaESSvIDH9SQEI3G0p0pf6DfFEZU498gVeWFBzyeCPX90rfd3g/vOHrNVCqLCbmpj7z8dD+QtMNDHgyTlkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684923; c=relaxed/simple;
	bh=Ce4bMJFKHMZzZ3HONY928lkH2VpESG7Hgnfctak0/Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPNJCABCSVFSO1m1RxMLz01ht0xzSxzOuBkvzptUmk44/SEWWTj6IyyJ1F8G+tgc35/YYF0ExbQbUSMCJwjNKgCyqRcWRiwz5aZy6IrSDc5vfDZEEH+TFj0bE76yNcSPDPE2Rf/WUXDKgw3RDzNB6GN7K704l0U96EQhcxwL9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qitoFcJo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qitoFcJo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770684920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZKFG8rBXK0TH0NXfkEiSOKxdTpMOu4yndM+D0ocM/s=;
	b=qitoFcJoD7UL96UJE+PsfZx42Wd8go2WBmmA2+BV9JQ4y3Yr2M0qt00zCuB8arvs5Spi5L
	Hko5x06LbN52ayZjtWSthfbfvvItG+UuxqxAb43/e5BwZhT9sjS6Tr9cExg+2VGYC2TurQ
	CmcBDC1x8eOfHpUCoT/XRXKLHJpgly8=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH 3/4] KVM: selftests: Extend state_test to check vGIF
Date: Tue, 10 Feb 2026 00:54:48 +0000
Message-ID: <20260210005449.3125133-4-yosry.ahmed@linux.dev>
In-Reply-To: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
References: <20260210005449.3125133-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

V_GIF_MASK is one of the fields written by the CPU after VMRUN, and
sync'd by KVM from vmcb02 to cached vmcb12 after running L2. Part of the
reason is to make sure V_GIF_MASK is saved/restored correctly, as the
cached vmcb12 is the payload of nested state.

Verify that V_GIF_MASK is saved/restored correctly in state_test by
enabling vGIF in vmcb12, toggling GIF in L2 at different GUEST_SYNC()
points, and verifying that V_GIF_MASK is correctly propagated to the
nested state.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 tools/testing/selftests/kvm/x86/state_test.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index f2c7a1c297e3..57c7546f3d7c 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -26,7 +26,9 @@ void svm_l2_guest_code(void)
 	GUEST_SYNC(4);
 	/* Exit to L1 */
 	vmcall();
+	clgi();
 	GUEST_SYNC(6);
+	stgi();
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
 }
@@ -41,6 +43,8 @@ static void svm_l1_guest_code(struct svm_test_data *svm)
 	generic_svm_setup(svm, svm_l2_guest_code,
 			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 
+	vmcb->control.int_ctl |= (V_GIF_ENABLE_MASK | V_GIF_MASK);
+
 	GUEST_SYNC(3);
 	run_guest(vmcb, svm->vmcb_gpa);
 	GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_VMMCALL);
@@ -222,6 +226,24 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 	GUEST_DONE();
 }
 
+void svm_check_nested_state(int stage, struct kvm_x86_state *state)
+{
+	struct vmcb *vmcb = (struct vmcb *)state->nested.data.svm;
+
+	if (kvm_cpu_has(X86_FEATURE_VGIF)) {
+		if (stage == 4)
+			TEST_ASSERT_EQ(!!(vmcb->control.int_ctl & V_GIF_MASK), 1);
+		if (stage == 6)
+			TEST_ASSERT_EQ(!!(vmcb->control.int_ctl & V_GIF_MASK), 0);
+	}
+}
+
+void check_nested_state(int stage, struct kvm_x86_state *state)
+{
+	if (kvm_has_cap(KVM_CAP_NESTED_STATE) && kvm_cpu_has(X86_FEATURE_SVM))
+		svm_check_nested_state(stage, state);
+}
+
 int main(int argc, char *argv[])
 {
 	uint64_t *xstate_bv, saved_xstate_bv;
@@ -278,6 +300,8 @@ int main(int argc, char *argv[])
 
 		kvm_vm_release(vm);
 
+		check_nested_state(stage, state);
+
 		/* Restore state in a new VM.  */
 		vcpu = vm_recreate_with_one_vcpu(vm);
 		vcpu_load_state(vcpu, state);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

