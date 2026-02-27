Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB7274FD0;
	Fri, 27 Feb 2026 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154796; cv=none; b=dGAexWqQrhRqysVJ9a2ufL8a1ejjJJoRSz+A6o9rRNEJMLRcp+hMdmTVmBHoc2b150IirEIaoLLZIX+tkTtKgjcq9traTgReQxhxKp+zRPgFWdG4uH3c9CdI9HJ5A7wUL5XtVDS56JwApBcOUk2KrBczavM5T4Z2V+dkRJszgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154796; c=relaxed/simple;
	bh=EGkThWYJDeFW24/IWdUsCMyv2nlhfDTHlZpEkgJNJIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHEzULxPfMrejeHeQztvqOwKFDnYSPtRWpwP+J1tSiEgf84efF+IXimx7Nv+/pybPS0KrI5F/Yhq02UpRkCZ9TsMPgtXwldtDM8e3fBBPzA32tZxY2MkAAokmDEKyicUWt0Je27OWjflm2M8b5IlN/peOVd/GAN1I4vnZU2CWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/9W4+gk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/9W4+gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6814CC116C6;
	Fri, 27 Feb 2026 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772154795;
	bh=EGkThWYJDeFW24/IWdUsCMyv2nlhfDTHlZpEkgJNJIA=;
	h=From:To:Cc:Subject:Date:From;
	b=u/9W4+gk3dAYAVHImMTqAwXrvQg5fCVc0TgxSdekssMc0y8eysKrHdJVPhsNIUTkJ
	 RwHSE3eGsaonsqgfl1JphQNRMP0lbmsuSg2s04P9IXzU4Zjono5H0qRP0OV1igS6ym
	 GIZZfkEjWQFRyCoeEqhwaHrFO4JyZTcqhMa6hfHcvYE1lo4cMXrU2uUAKiPWrwiqDA
	 eLg2/RU2YvcekVJ7fnDj4A0KdlRC2VJzbzsxHZ87oaPvH/bzvLrakRsb5qiJMmYBnG
	 kDjVtWcISHLP9mjyd8mhqYGOL9i6J1sZMOdbKZ6ougr/xbWNiVaogTUz5CY0Nahcbw
	 +mUcRzTLUxumw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 0/3] KVM: x86: Fix incorrect handling of triple faults
Date: Fri, 27 Feb 2026 01:13:03 +0000
Message-ID: <20260227011306.3111731-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a couple of bugs related to handling triple faults, namely KVM
injecting a triple fault into an L2 that hasn't run yet, or KVM
combining #DB/#BP from KVM_SET_GUEST_DEBUG with existing exceptions
causing a triple fault (or #DF).

Either of these bugs can result in a triple fault being injected with
nested_run_pending=1, leading to triggering the warning in
__nested_vmx_vmexit().

The following syzkaller reproducer should trigger it (although it was
manually modified and I cannot test it directly):

r0 = openat$kvm(0xffffffffffffff9c, &(0x7f0000000180), 0x2, 0x0)
r1 = ioctl$KVM_CREATE_VM(r0, 0xae01, 0x0)
r2 = ioctl$KVM_CREATE_VCPU(r1, 0xae41, 0x0)
r3 = ioctl$KVM_GET_VCPU_MMAP_SIZE(r0, 0xae04)
mmap$KVM_VCPU(&(0x7f0000fe9000/0x3000)=nil, r3, 0x1000003, 0x13, r2, 0x0)
syz_kvm_setup_cpu$x86(r1, r2, &(0x7f0000fe5000/0x18000)=nil, &(0x7f00000000c0)=[@text64={0x40, 0x0}], 0x1, 0x41, 0x0, 0x0)
ioctl$KVM_RUN(r2, 0xae80, 0x0)
ioctl$KVM_SET_VCPU_EVENTS(r2, 0x4040aea0, &(0x7f00000006c0)=@x86={0xf7, 0x8, 0x29, 0x0, 0x5, 0x67, 0x1, 0x9, 0x9, 0xbd, 0x6, 0xff, 0x0, 0x5, 0x4, 0x3, 0x7, 0x7, 0xc, '\x00', 0x7, 0xb})
ioctl$KVM_SET_GUEST_DEBUG_x86(r2, 0x4048ae9b, &(0x7f0000000100)={0x1d0002, 0x0, {[0x8, 0x0, 0x7, 0x2, 0x87c8, 0x5, 0x5, 0x6]}})
ioctl$KVM_RUN(r2, 0xae80, 0x0)

Yosry Ahmed (3):
  KVM: x86: Move nested_run_pending to kvm_vcpu_arch
  KVM: x86: Do not inject triple faults into an L2 with a pending run
  KVM: x86: Check for injected exceptions before queuing a debug
    exception

 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/svm/nested.c       | 14 +++++-----
 arch/x86/kvm/svm/svm.c          | 12 ++++-----
 arch/x86/kvm/svm/svm.h          |  4 ---
 arch/x86/kvm/vmx/nested.c       | 46 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c          | 16 ++++++------
 arch/x86/kvm/vmx/vmx.h          |  3 ---
 arch/x86/kvm/x86.c              | 15 ++++++++++-
 8 files changed, 61 insertions(+), 52 deletions(-)


base-commit: 183bb0ce8c77b0fd1fb25874112bc8751a461e49
-- 
2.53.0.473.g4a7958ca14-goog

