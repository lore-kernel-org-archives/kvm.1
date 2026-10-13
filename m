Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C823CA4A0;
	Tue, 13 Oct 2026 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933460; cv=none; b=n+8iXf+8jYzs6UUmEItkcmyk7q6achCh9WMe6szQ0n38kyUiQo86/s3T/oBkClVDQPAVWNavq4jr+kgQ3qKd+8a12M4bJlB0PxOuShKWVGTunNpgAsclNKMYF8GUIDB3KboDWsFKLIaEq706wABfZ0dYHKU2BW4YQCRzYxLU/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933460; c=relaxed/simple;
	bh=dnyR9HN6Xqt/bYE7gUtWyyA8H3WytB6Ddjo+C/NgK+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItSRBe9KxiIXf4rJB+EB/REIp70gqhomzM1gjK5ODDaR8wLEhCoti8a17VguiL8CZqlXu9EnIsnlqZZVQ6tHmFN8OFgIinL5vDSHyqyOQF0liPojAJLpRqxPhebPIH+nF9hxcZLeRTPiO2srguzx66yzRpPrE2qeWS0pKanKVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWCamyvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWCamyvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FE1F0089B;
	Tue, 13 Oct 2026 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791933459;
	bh=SBPrOyhBQZiPa4gKbscLDIZzIE4c7fFGeygedWvOa9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWCamyvfAxPzSjTVle/a+sA2kAzqSj8E9+sUcPHvvGGCr3fSnx/KlTfsCNy7sDXNy
	 b4Yk91dUH9xCsVq+cq9JZCFJFyMXXoibLgx079oZIURNiAl32IKriYQUPyzrujkOtM
	 iDoa0Bfu8wjertjuDKNaoWtMXSfuH6pJvnGNJSzruu5jhGEFKkz26nht7b1tGwpl/x
	 WJ7+dI3p9TW7EpJDCU9zFvhq2Q1XFrRs+tRc3NhXcvE1Xl6ERKI7Z9654tHvZ6N43e
	 a1ZMjtaJOOfi0sX/zUE/l/0Th4Hlq2NnTXD66q8NLrUCkRsAK+Z+1UkgPj7KgMMKJb
	 cNaCCCRoZtJgA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 4/4] KVM: nVMX: Drop the TODO to sync only the affected SPTEs for INVVPID
Date: Tue, 13 Oct 2026 23:17:28 +0000
Message-ID: <20261013231728.883001-5-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013231728.883001-1-yosry@kernel.org>
References: <20261013231728.883001-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the TODO in handle_invvpid() about syncing only the affected SPTEs
when emulating single-address INVVPID with EPT disabled, instead of
freeing all of L2's roots.  Nested virtualization with EPT disabled is a
niche configuration, and no one cares about the performance of INVVPID
emulation in that setup.  If someone does care, they'll find the
overhead by profiling, whereas the TODO is more likely to send someone
chasing an optimization that isn't worth the effort.

Assisted-by: LLM
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854cf..57458b8455a41 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6159,8 +6159,6 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	 *
 	 * Note, this operates on root_mmu, not guest_mmu, as L1 and L2 share
 	 * an MMU when EPT is disabled.
-	 *
-	 * TODO: sync only the affected SPTEs for INVDIVIDUAL_ADDR.
 	 */
 	if (!enable_ept)
 		kvm_mmu_free_guest_mode_roots(vcpu->kvm, &vcpu->arch.root_mmu);
-- 
2.56.0.385.gd3acb90ef8-goog

