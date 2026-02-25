Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705432727FA;
	Wed, 25 Feb 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981202; cv=none; b=KQNxtPnHKmLylRpLrO5rzxPfzBqn7feKA0Un+WfhgO8jZfpN67VA3UMxMTLJFkiF3e9/LlHABeHSyFVKiy9nh2V4Czr7HER5vrvOTQMmM3rMUXFtR5KrTv7DNuraEoEML5eB47OY/OzP/xUMoAJFaPmJ0bHqmj6VsM9iI0RKHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981202; c=relaxed/simple;
	bh=BFyMQ3Sh56pYQ9lD0aC9yH0Qqp6UFL+CGTwm5iBisn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuoP/Dtb0BXf268pBeVanXwxO4P4zoo7BiTr8U6Pkz+Tm+G+vaPzggmd99Izv7NZ/y1LOjgVSmU5X62A/AYaL8r9hx89Nm7yFT15x0K3CPdgkK/9w9tmBSvIbQzFAzaoMYU7oJXRH+o+gS0NEyim+6kXSkQ0x7rWOE3q6CHzCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cutfqfty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cutfqfty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE6EC2BCAF;
	Wed, 25 Feb 2026 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981202;
	bh=BFyMQ3Sh56pYQ9lD0aC9yH0Qqp6UFL+CGTwm5iBisn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cutfqftynqz97rkJ1g/YBg+oWfSLVxsYgS9Ux9bYkEvMJCBUrnoinC1pfZhAgOeP7
	 ogjXtNlgp1YO06kXzFrRpFoFQ97icevvh80JIOSMm/PkcZe5D/Jtq15vRFP27kRdlb
	 iX5e8GxKL2/OWBSj7uftfOlCAKuf2JlUIlmntg9+e/YQ6CQR9PI6MKqlV9h9jHo1fY
	 9LflORcJLakVq/mRvButEdCbXllr4H8aL7Ej2NDp2iqxUKtSR78ucvKQJUcUBEmCrx
	 nAmSIrU+ZvgnY+6d1XITCjyQBIWId85ZbLlolijlByQSRvhgpa4FIr3yUoVC4O/8vr
	 DRcMVHOsyeryg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 4/8] KVM: selftests: Extend state_test to check next_rip
Date: Wed, 25 Feb 2026 00:59:46 +0000
Message-ID: <20260225005950.3739782-5-yosry@kernel.org>
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

Similar to vGIF, extend state_test to make sure that next_rip is saved
correctly in nested state. GUEST_SYNC() in L2 causes IO emulation by
KVM, which advances the RIP to the value of next_rip. Hence, if next_rip
is saved correctly, its value should match the saved RIP value.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/x86/state_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 57c7546f3d7c5..992a52504a4ab 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -236,6 +236,17 @@ void svm_check_nested_state(int stage, struct kvm_x86_state *state)
 		if (stage == 6)
 			TEST_ASSERT_EQ(!!(vmcb->control.int_ctl & V_GIF_MASK), 0);
 	}
+
+	if (kvm_cpu_has(X86_FEATURE_NRIPS)) {
+		/*
+		 * GUEST_SYNC() causes IO emulation in KVM, in which case the
+		 * RIP is advanced before exiting to userspace. Hence, the RIP
+		 * in the saved state should be the same as nRIP saved by the
+		 * CPU in the VMCB.
+		 */
+		if (stage == 6)
+			TEST_ASSERT_EQ(vmcb->control.next_rip, state->regs.rip);
+	}
 }
 
 void check_nested_state(int stage, struct kvm_x86_state *state)
-- 
2.53.0.414.gf7e9f6c205-goog

