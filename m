Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EF3EE1EE;
	Mon, 16 Mar 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692863; cv=none; b=NpWN5c7eIKKpU62NYF8Ddpa4oDeJJnA7ZIGW8B1kL+aFtiYESAmOhPHYfa+zPH7+C/wT3erSASX2r2Egumtm8nrHcmuL9xIfLVWNNpHbgjJpIMW1sFwMe0vYTQr8xCYGXoPh8UUyP7p71IeCI+MKfYSVjyu4o3Q1ZyrpMNDi3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692863; c=relaxed/simple;
	bh=v5HACp+Ry2GA6wpD8TrxF2OmhE28GueMrvUuJaK3wWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LybJCNAHsxXQhWN3d4gBr8Sf49l/rv6Qmv70eDVobp/57stDeogbty31maAaGlaygzjSB9yGgShVSWEyRmMqo5Iy+OI1fllEul9XPfmnI+gxS8xEwtZOnxdtjFXr4t2HVtwYyJ2cplk840RFMN9byh0wWAbfw04WVh6urSxhS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9VPWAK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9VPWAK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF8CC19421;
	Mon, 16 Mar 2026 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692862;
	bh=v5HACp+Ry2GA6wpD8TrxF2OmhE28GueMrvUuJaK3wWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=H9VPWAK7pVp+Bv/XoHFCtT4VkyP05et7R13Hr7Z4BSxiz1hdSNhuT3ZN0l9q2C0XO
	 oIY7Ec1FOrboeHbWeQ8VGjzXse/PQxsRoz1y0repyTafmzcUkrN/gqq+1qYrnreGKB
	 +eitFlOYY2D/qxWSM8sAXGqsXl9x0uMaGDEQyWmiA+BHBA5dQzobHdebZXOCuuOBfI
	 97bJrPpOt8V5BF9wtyOQxuLVTt2c0nk1bipIcIKU21VhHeEa6TkDvBN8uKkQrLo9k2
	 9fLcC6sTdzqUqob1x0Hr9gUuQTwK3Rnj76EmsviuHNu/DE6etYhhXTtvlHp1M+cNBz
	 EIklVbqK5u6Jg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 0/9] KVM: SVM: Fixes for VMCB12 checks and mapping
Date: Mon, 16 Mar 2026 20:27:23 +0000
Message-ID: <20260316202732.3164936-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jim pointed out that VMRUN/VMLOAD/VMSAVE injecting a #GP when the vmcb12
GPA is valid but not mappable is not architectural [1]. The series
handles them as emulation failures and (mostly) exits to userspace
instead. It also fixes the checks performed on the vmcb12 GPA (i.e. RAX)
in a few places.

Note that there's a few other bugs that this series leaves alone, mostly
to keep it focused on fixing the non-architectrual #GPs, this includes:
- KVM synthesizing #VMEXIT(VMLOAD/VMSAVE) to L1 when intercepting #GP
  from L2 on VMLOAD/VMSAVE, even if L1 does not intercept VMLOAD/VMSAVE
  (e.g. VLS enabled).
- KVM not respecting priority of #GP vs. #UD when EFER.SVME is disabled
  by the guest.

However, the series documents these bugs with FIXMEs so that they can
hopefully be fixed up later.

v3 -> v4:
- Fix the RAX check in the emulator instead of dropping it [Paolo].
- Add refactoring of SVM instructions on #GP intercept to facilitate
  following fixes.
- Use kvm_register_read() to handle 32-bit correctly and avoid false
  negatives.
- Do #UD and #GP checks before synthesizing #VMEXIT to L1 when KVM
  intercepts #GP on SVM instruction in L2.
- Update changelogs.

v3: https://lore.kernel.org/kvm/20260306210900.1933788-1-yosry@kernel.org/

[1]https://lore.kernel.org/kvm/CALMp9eSMtzDJn7tGtbj=zLYpcU7Tc7XjcWBRZH7Aa5YihSmN7g@mail.gmail.com/

Yosry Ahmed (9):
  KVM: SVM: Properly check RAX in the emulator for SVM instructions
  KVM: SVM: Refactor SVM instruction handling on #GP intercept
  KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
  KVM: SVM: Move RAX legality check to SVM insn interception handlers
  KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
  KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
  KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12
    fails
  KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
  KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's
    name

 arch/x86/kvm/emulate.c                        |   3 +-
 arch/x86/kvm/kvm_emulate.h                    |   2 +
 arch/x86/kvm/svm/nested.c                     |  12 +-
 arch/x86/kvm/svm/svm.c                        | 107 +++++------
 arch/x86/kvm/x86.c                            |   6 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 .../kvm/x86/svm_nested_invalid_vmcb12_gpa.c   |  98 ----------
 .../selftests/kvm/x86/svm_nested_vmcb12_gpa.c | 176 ++++++++++++++++++
 8 files changed, 244 insertions(+), 162 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_invalid_vmcb12_gpa.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_vmcb12_gpa.c


base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
-- 
2.53.0.851.ga537e3e6e9-goog

