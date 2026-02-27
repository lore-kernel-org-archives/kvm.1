Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0E2BE029;
	Fri, 27 Feb 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154796; cv=none; b=gr6tLZulydnpprhxp1JhyLJt5XdtAu/17b9et4itPHC5yR0jazGJ17wWr4jlCmJ7SbnLEqYuWL4xn6XvtEu3GGX2ee7OjCme6/oDBiboZaCy6buvb+xks9uj0FTtFSlcFj35gaxypECYJMigNEt2oxkTHSaG575nj8I/ZvyBW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154796; c=relaxed/simple;
	bh=Ah+TuB1lDeYw4IsZuvO/0JPF614zpFT8QTl4uDoQUMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGObGqCbpce5cyKx0BlqjMo4BBWCDnvlnBPs3iK9kSxqNjXopeL4aT3viGQlIJgJa8ATcdfgKrAQLPjnLx5IrSoo9IU8bHUxCBRe1ne/YWSgBf1i+ywnl6dUEL4d8WSRVyEDFkbkv5/MRm0FvGaw7WS+7FrBxCX+uPNI4PYHO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diPjXSwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diPjXSwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB9C2BC86;
	Fri, 27 Feb 2026 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772154796;
	bh=Ah+TuB1lDeYw4IsZuvO/0JPF614zpFT8QTl4uDoQUMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diPjXSwK8TqqAFrIVbGRa/dGVkWStJjy8IIiHdsqnXu32unVIIvjH2504h5usT+IT
	 8J3xbQ++j49iOTp38bv7e6m5N+X9k/CJpquUtMfZsLMjckHJ74rGIOOwmDx8GGVnQu
	 wbfvgNeullqvEPkz1ieAQa0x59SMnERq8FL+OTlkrUbaBfU/ZvtIqqu2AT7/NPkM96
	 mai44Zu8cSqmXYNYmYuOeDCTpdqX9eXUfDMhuCRx8eiM6xV611ZSPHfEU6EcnqM3pM
	 Trrn/pATkMyZBYt1fljkpijm7aa1Rul9zWhem6EM6KDILUUBdqwpcnmdxfoO9prxgp
	 1t5lBCPUJ8gSg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 3/3] KVM: x86: Check for injected exceptions before queuing a debug exception
Date: Fri, 27 Feb 2026 01:13:06 +0000
Message-ID: <20260227011306.3111731-4-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260227011306.3111731-1-yosry@kernel.org>
References: <20260227011306.3111731-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On KVM_SET_GUEST_DEBUG, if a #DB or #BP is injected with
KVM_GUESTDBG_INJECT_DB or KVM_GUESTDBG_INJECT_BP, KVM fails with -EBUSY
if there is an existing pending exception. This was introduced in
commit 4f926bf29186 ("KVM: x86: Polish exception injection via
KVM_SET_GUEST_DEBUG") to avoid a warning in kvm_queue_exception(),
presumably to avoid overriding a pending exception.

This added another (arguably nice) property, if there's a pending
exception, KVM_SET_GUEST_DEBUG cannot cause a #DF or triple fault.
However, if an exception is injected, KVM_SET_GUEST_DEBUG will cause
a #DF or triple fault in the guest, as kvm_multiple_exception() combines
them.

Check for both pending and injected exceptions for
KVM_GUESTDBG_INJECT_DB and KVM_GUESTDBG_INJECT_BP, to avoid accidentally
injecting a #DB or triple fault.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e39c5faf94230..0c8aacf1fa67f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12543,7 +12543,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 
 	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
 		r = -EBUSY;
-		if (kvm_is_exception_pending(vcpu))
+		if (kvm_is_exception_pending(vcpu) || vcpu->arch.exception.injected)
 			goto out;
 		if (dbg->control & KVM_GUESTDBG_INJECT_DB)
 			kvm_queue_exception(vcpu, DB_VECTOR);
-- 
2.53.0.473.g4a7958ca14-goog

