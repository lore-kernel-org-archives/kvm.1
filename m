Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8322772D;
	Fri, 13 Mar 2026 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360643; cv=none; b=X2BVTPUxNLewb2UPSajLYFtYl7yjIO7d7wRYHR4F8mynu6h1QVeQjsWgL7K3heDnRPBdQcTCfBmQx4+ooVlxYSxUKQLxCXZUagDPakeTh662fFhrFdffH6YbMadCQm8rlW0bkAzVZ+y7VkW9htvVl3ajXvM9tdimjZDzLZS/OSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360643; c=relaxed/simple;
	bh=5YIakzX7mDpvR6VQBgAaVfi8oprOXN6//gLrTnFCWDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OMcYMgEAjqz0xpnO3LQcjq3kAECc/jxrM4aCKcuu75uI9n2sRKXcwaWPscUK69ZCcvxmg/HPebdTiAGgZbTRB6QRcslkUldw2aL0/Sg22PRbDNBcoZk3UKKZaTYx8yn2fHcdpxkjvY9W91mZLoUlZbYJWW8AyO+P1PV/EsdakLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE5fvovP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE5fvovP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995C9C2BC86;
	Fri, 13 Mar 2026 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773360642;
	bh=5YIakzX7mDpvR6VQBgAaVfi8oprOXN6//gLrTnFCWDo=;
	h=From:To:Cc:Subject:Date:From;
	b=bE5fvovPK4fcjGTXJx2zHLRGgYN6kDRDlf2G3zp7Y9PqugPxQjI8zlrxDOD/4IZqw
	 8BvUCrNDfStTsvVUJhImC422tim4i9fUHiWUyBX8StP0Z63jO1I6vzx2gJW17KZ70R
	 Y4ERzI19YitLMLHvU2czaOcKle8iLZ1fpePNplyL3kI+SjBCTpW2HKx856AH+OVCE5
	 jMgk1SUZr829uoyhWYh0FH0weM7e4ncX5tT7pxDHrcVzJvFNFcOxiK+9vVwsMzlAtF
	 WpvD1JLQVKA/RWFb+GTG07RsuXuldpf399tKLVpMLeC1CymgLUOUzq9cm4tO6qKv/A
	 4Ela8avQsEy7A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 0/7] KVM: SVM: Fixes for VMCB12 checks and mapping
Date: Fri, 13 Mar 2026 00:10:17 +0000
Message-ID: <20260313001024.136619-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jim pointed out that VMRUN/VMLOAD/VMSAVE injecting a #GP when the vmcb12
GPA is valid but not mappable is not architectural [1]. The series
handles them as emulation failures and (mostly) exits to userspace
instead. It also fixes the checks performed on the vmcb12 GPA (i.e. RAX)
in a few places.

v2 -> v3:
- Drop the patch simplifying error handling of
  nested_svm_copy_vmcb12_to_cache() as it was picked up into
  kvm-x86/next.
- Drop the legal GPA check on RAX in the emulator instead of fixing it
  [Sean].
- Fix legal GPA check on RAX in the #GP interception path [Sean].
- Move legal GPA check to VMRUN/VMLOAD/VMSAVE interception handlers
  [Yosry].
- Update the selftest to use the first GPA after memslots, rather than
  the maximum legal GPA, as the unmappable GPA. This is needed because
  the maximum legal GPA sometimes still produces a #GP if it's in a
  reserved area [Yosry].

v2: https://lore.kernel.org/kvm/20260306210900.1933788-1-yosry@kernel.org/


Yosry Ahmed (7):
  KVM: SVM: Drop RAX check for SVM instructions from the emulator
  KVM: SVM: Check that RAX has legal GPA on #GP interception of SVM
    insns
  KVM: SVM: Move RAX legality check to SVM insn interception handlers
  KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
  KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12
    fails
  KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
  KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's
    name

 arch/x86/kvm/emulate.c                        |  17 +-
 arch/x86/kvm/svm/nested.c                     |  11 +-
 arch/x86/kvm/svm/svm.c                        |  37 ++--
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 .../kvm/x86/svm_nested_invalid_vmcb12_gpa.c   |  98 ----------
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c | 176 ++++++++++++++++++
 6 files changed, 203 insertions(+), 138 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c


base-commit: bfd7f4adc1230373c25e1b787a6f1ee407eb0656
-- 
2.53.0.851.ga537e3e6e9-goog

