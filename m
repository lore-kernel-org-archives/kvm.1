Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BE1A6814;
	Tue, 30 Jun 2026 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863242; cv=none; b=oH7HWsXCSdIeA41FIQF1SB3zBS+z3CRno4toNtXGd1yOXnyJZb3g/bXdffKKh9vTF8Ghdu1VtwUhRa7zYt5ZTvNz5aY1BsLqA/mSMMw1u5w3knjMHIXLA2e3aZl7qQkJscvAuG9/xPGzeNeSovNfk/30J0uK5aP3IRHevGKWdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863242; c=relaxed/simple;
	bh=7uteng/4we/c7sX4XAP60dp7FbyWpJmDC9asKMvB7h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/tyGVUppUrC6IYj1woUkxlTtkK5Ex903xsNxSmsniCYT7qvgxH4GXokVe66GzXJWQHmDz4BsLFdRHTwMGgItkL1Qb8roAOdE9n476hpUIn/JdAVOzgte+d/DjEQFVmCRYxIER5j/frZgQF4yvtxu/OiXCV1KfxPaZ1MXxfBZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/oothyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/oothyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54031F000E9;
	Tue, 30 Jun 2026 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863241;
	bh=fnTyDXbo4j874K41Fj5zcKo6HxpU1aTxHwc1OmdYooQ=;
	h=From:To:Cc:Subject:Date;
	b=V/oothyDITUa4FnhkewFmpbw05ZKKntcDxNSQdnrsc3BPIWbSX7E+jsGmn+r5hhmf
	 MCOZ/gcR/mumT8UggJ9OjRFBI5PieJPPHNJT63hkjjdKYe7OaZiU0AtIzRUidKFlpH
	 3vLo73dEthVp4iGU6LBTrteSflsfwEhF7K6wR2Fj3kBf+RtKZ5ojAecELkpC69Av5/
	 VqZp7ovarv1INquL8iXR451DNkRVhWsJUXZFdYw0Qaafxd8rDOct2BMtiz0GuttVQK
	 U3dI1pAHjSfe4A9Orr0RS3/YhNwgYQWutwzkr0hTOvuvtqgnRA1JiYqOGjHfdG5yV8
	 HyBC0NiMXHzAg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/7] KVM: x86: EFER validity fixes and cleanups
Date: Tue, 30 Jun 2026 23:47:08 +0000
Message-ID: <20260630234716.3039031-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
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
2.55.0.rc0.799.gd6f94ed593-goog

