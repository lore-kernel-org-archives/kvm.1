Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8D926B95B;
	Mon,  6 Jul 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367684; cv=none; b=KQ+2UOrQB1l4ZMhM+LQu1slR9txSAmIP6xUXJR954uEXpDyVRN6G2Tc8byL3fxqlfuGCFB701Y+lbDpGG7obPFj1OClzZvLknyfqpz60XYwMXtr/9dvMjAj/VeCC09cD7bvMJ2sFBiM/ZZ0tk4/sVH8YyV5ITp2ML/ndRHp6CQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367684; c=relaxed/simple;
	bh=D75UhtuHzcX+usQb1gS4LDqMMk+jRHzfuWs05n/bGkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbKbVKABEwxOUHbYSTDCeSGJ2bLQEQ2E8WAQ+kfu3WPEEYB5mRM9+D6EkLzqdyOAr3bkU1K0tK2lfu8fDCh7jWUrH2S19LrdkrEizh002w7i+LLlOgcOVUSt/crTUn6DiDI41XEjSMcqoPreYdOh7o3AWIfObSVPp5ZkC4T999w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca9XM8sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca9XM8sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3591F000E9;
	Mon,  6 Jul 2026 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367682;
	bh=XPr8pqwm48ayVawPtfl25T5sP9wRhO/7FQssNaoQda4=;
	h=From:To:Cc:Subject:Date;
	b=ca9XM8szVCgKcm0tYovEiU2OI5QVVJycJxtSzz0hTjIOAJL18i5yu21i5QcT7ueIE
	 0LkbaIwXMlMniRqq7IItNEn/cysgAlad5EyV2A5RpMQwNo7qqe1W0fRBcrqGuvzVHm
	 BaD/Ks8PkCkKoUHxqwRMogOPuQD8Pa/710KSkeUA9fDL6yknXaaUQg/6x9PzRBQ1M5
	 ct+HfXW3KgJGkUiRFBbjGw7WsXGFKWx0Iz9oQsLA+KIARdmOJ252G3ud2Blo03hW2b
	 22ldvOC6Z0KmQttK8/3URja9AfHjGlPiscwi1QHQltUVy3JnkvDzpHOlqmDXTDdyu9
	 iA7diIiwcXrUQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 0/7] KVM: x86: EFER validity fixes and cleanups
Date: Mon,  6 Jul 2026 19:54:06 +0000
Message-ID: <20260706195413.1966458-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of bug fixes for EFER validity checks, namely not doing any on
KVM_SET_SREGS*, and incorrectly preserving EFER.SVME and EFER.LMSLE
state after module unload+load.

The rest of the series reworks EFER supported bits and moves them into
kvm_caps, ensuring they are always reinitialized on vendor module init.
The final patch adds test cases to set_sregs that catch the bug fixed by
patch 1.

v1 -> v2:
- Fix reversing the polarity of efer_reserved_bits to actually reverse
  the bitmask instead of the entire checks [Sashiko]
v1: https://lore.kernel.org/kvm/20260630234716.3039031-1-yosry@kernel.org/

Yosry Ahmed (7):
  KVM: x86: Check EFER validity on KVM_SET_SREGS*
  KVM: SVM: Disallow EFER.SVME and EFER.LSMLE if nested is disabled
  KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
  KVM: x86: Add a per-vendor callback to setup EFER caps
  KVM: x86: Reverse the polarity of efer_reserved_bits
  KVM: x86: Move supported EFER bits to kvm_caps
  KVM: selftests: Extend set_sregs test to cover EFER

 arch/x86/include/asm/kvm-x86-ops.h            |  1 +
 arch/x86/include/asm/kvm_host.h               |  3 +
 arch/x86/kvm/msrs.c                           | 21 +----
 arch/x86/kvm/msrs.h                           |  1 +
 arch/x86/kvm/regs.c                           |  3 +-
 arch/x86/kvm/svm/svm.c                        | 14 +++-
 arch/x86/kvm/x86.c                            | 18 ++--
 .../selftests/kvm/include/x86/processor.h     |  2 +
 .../selftests/kvm/x86/set_sregs_test.c        | 83 ++++++++++++++-----
 9 files changed, 96 insertions(+), 50 deletions(-)


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

