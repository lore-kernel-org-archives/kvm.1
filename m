Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2112377023;
	Tue, 19 May 2026 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222538; cv=none; b=mLfDdvbzVfdQ1s5TMvW1gq9q5hn1dBtflX0Yj+ft+QwAwrqDWjhAIaOec3Y0ahlOrpH2kVUqS0OSZsknXo0y8D0VhuIOX7dOkav3iOElL43CfSGg81YN2PNxdqnMq07g/UdgI7mMuJiyxEu+Izk2I1jMx0yqfUGz+n57OkMJ0uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222538; c=relaxed/simple;
	bh=CctPRxY6PRPM24rPxmbaKmGdxWrZNvd1lT6h/xAn+6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jP/CMbdegV9NyjGo/OjSyUN4sYiSRdjmsPEjWAKm1uLI7fRJm5E1a5XEWNQgAoF4uOmkpbrxZwZKq8QDqgSpdXqZGGnDyuRCrucsQgdh2RggzcgcwBUI9muwCM30X+PzC2B1HiNAWDQ3apIBvIotWtXDdcbZpUz2AdeQgP+nQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5r/6tIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5r/6tIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BF1F000E9;
	Tue, 19 May 2026 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779222537;
	bh=W95J4r+NJDqvjSTHBC2PsoICJoyN2XsLG/Irph0HrZY=;
	h=From:To:Cc:Subject:Date;
	b=e5r/6tIXxH8XTKY5omMiKC/bwxr7SzBHhe2/WNc0n8Jv2lF2upVBEko2bW4QfN4GG
	 miOEud19CJq2zim9veVxP6Le8VGrUtCNbjMXSYC7oag6bLLh+Nb2zmSwrFWDozM5b2
	 /Rqu/knaX5jDweXB11PpNxNBPPPBysYupPiNeoeXwd21n+TaAFNhYm7fJjCAso09Js
	 +C7UWVzVcbWG0ClhqJUFnX1aNPHV9DmPkK+xHC/1QgRr9vI1l0o0GvGElVa7Ee52lx
	 V3+qQ66uCmXMVz5fklJFfxegO0Dd7pbqp0Od5x5RKCEmhQM/a4NXO+hnaQgrmnc1Q1
	 MwspigGcjOthg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Michael Roth <michael.roth@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM, SEV: fix merge conflict
Date: Tue, 19 May 2026 22:28:36 +0200
Message-Id: <20260519202851.1339906-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A conflict between two patches leads to build failure for
the reference countingg in 'struct kvm', which moved into
the kvm_refcount structure:

arch/x86/kvm/svm/sev.c: In function 'kvm_lockdep_assert_sev_lock_held':
arch/x86/kvm/svm/sev.c:118:32: error: 'struct kvm' has no member named 'users_count'
  118 |         if (!refcount_read(&kvm->users_count))

Resolve this by changing the added reference the same way as
the other ones.

Fixes: 422c363f58a8 ("KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio")
Fixes: ba903f738249 ("KVM: SEV: Assert that kvm->lock is held when querying SEV+ support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 04accfaefd0d..63b57f3b3800 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -115,7 +115,7 @@ static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
 	 * Querying SEV+ support is safe if there are no other references, i.e.
 	 * if concurrent initialization of SEV+ is impossible.
 	 */
-	if (!refcount_read(&kvm->users_count))
+	if (!refcount_read(&kvm->rc.users_count))
 		return;
 
 	/*
-- 
2.39.5

