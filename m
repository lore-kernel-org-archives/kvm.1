Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956D42C501
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080770; cv=none; b=Wiat+wt9XUvQkO2hjzjO8AAeU61BHN7paPyd9FfzbwMbfPs9r8rvJgIxC6rG3Kh+dQ9Y0F7BKT7DdNOWQDXVlZ7E58nfsOciYf1pxVCDk2ptIHxNY1Y3UsTCx9IV2ojSw5H+9dG4Pph+qVawoWlTfz1Ym8NTJwN5AZTehvjimLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080770; c=relaxed/simple;
	bh=L5NkcfVIoKsh+ScG5WKFeiID/xyVQuXFBO4Rcyml1a0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AhHK12rLCVBU3D/itOP5Vj3byWj0nr7Hfw1d5RZxT4eT2QixkDvbl9UmaYPwXohlwZV2ojqgm+Nk05nAm6Mr8GUS225nTFqWjLgsCGVtQxu47p/v2mjOlSavfSogaf+38lxwYmPPBjVDD5SSG6eUBOBh7f4+/h7M9esjzObq2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLy6/cS/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLy6/cS/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2415980a12.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080766; x=1786685566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PIbnsun6zq+1L1BT2WwwquArLAsjhJR/tgK45GqLXtI=;
        b=NLy6/cS/638j9Qwko7KWRZzbvgeqHNtP9vWAjR2DHr9+kiZx3gMmgYZTR45kvBw1/U
         P8DWn4vd/BlFnmW/f9Y0znMyjgBqGRKwFHAIAsNVADh1gZzYjZpi5SwIv9AhIjVktqYL
         Y9NebkhBAOGOiFyfzaETctADMVBUUXvXo7+3NCSRGM7D4yG4QUTU8t7Azz/pJfBbdlWA
         y4mdYlCrM04IE5TRHFC1ZlqN8WccKb+bVXOQfCMd0L+uJPWI2JYz6v3Ds+4hnnm8mGuF
         QbePO+t9+lYlAoUNokq16AJHCuXGXWB/7b6xhdc+AcX1OcneMdKkQ3Us3N1MfXjIG0jp
         Qvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080766; x=1786685566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIbnsun6zq+1L1BT2WwwquArLAsjhJR/tgK45GqLXtI=;
        b=rLvpDEhihCkxSl1arjG9dkue0BQdCN/zWyre4Ry6XO28keMz/DFZ1ni07qPx8G2ZIm
         EibejP32882xm+fcWKIF9VxXvy7eCWvwg0vdMFIYl8HlvqpFF/2E/3Ms0YcjpreoQaMP
         s9zawQ4aCawEGrMULvez8DOVl/ac0MZPX2+wgzX/VlnTwPRTAxs8YWXyfb8HuenWbeXB
         2Y4yuKu7wcqEPdvaTtPdeSruK7G8iqYUD6mE7yLRBwitwfJIqNWOhOt3UncxIXP/s0oO
         VGFpie+jkXASYdLDjwfO/y3vuMqB8TQVXhKGgzrn5XNi21ScH3R1472UVXmjpO78vRhB
         /ItQ==
X-Forwarded-Encrypted: i=1; AHgh+Ronr3o5XYmbnfqCTrUPlEXkgDAiAGHRSM0xejQCx+UtvnsnD2PJZ0v1UjnkNNuHRBfhsQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVhWX6/NahUGGSTOsigGjRfZETwSVoCftkRGd73s6H2RZnk6v
	abtbtPpPIc2A93TRJSv8JEt9WHxMRiqAEJuG8G1D6YH72wW327ryDd1Y
X-Gm-Gg: AR+sD11qBVAgPdfi9c24nJhCsE7y0Pb08z7jcoOwZJw3VMj4v6a1qpqODXd8LNZjt1c
	5DxjCO+FnnlUnXxE7xqaEACi8h+vYsR1peTmSeP1YJNw55+8E6zv1XXMapu9Ng1QuH0Ype84vqX
	rmWnxk2YRVF0Zill4w2K55INDa0kHo9xXYF+SHdK3s/65ja1GL/ThooB43kMif2r58qBflgd2D6
	vVwlzE4VDErPcWKsDwX0dBrye6ooQBsf8qBfIMYgyJk7bD1j+yMsEQEaGfkeSnlUG7wqILAOOXy
	oHP2t+HMjQdSjiUbMWkiJV6NNFe9RUqDf8r8eZadqf9H6jTalpEAtXYNPbLW6XIn/BTx/4/K5XJ
	H2v8D//fRZXGMMZ93EYCncu4AGhWSrN/7R0UWmQSfoqakxfBdiLNjzxXVGpZB/XjToMmjtiq13b
	zs0xzrMHtxC/4FCJuXKMEfB/1FljT/asF+KUurH92D4hCrv48GcaD6zTCuMFLxraUOBAH3j0A+u
	GOnUpg=
X-Received: by 2002:a05:6a20:918a:b0:3bf:d0c8:2aa4 with SMTP id adf61e73a8af0-3cb85df0a10mr21226501637.8.1786080765955;
        Thu, 06 Aug 2026 22:32:45 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f19634dsm108940a12.7.2026.08.06.22.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 22:32:45 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouquan@iscas.ac.cn,
	"Yuhang.chen" <yhchen312@gmail.com>
Subject: [PATCH v2 0/2] RISC-V: KVM: Add PMU event filter support
Date: Fri,  7 Aug 2026 13:32:25 +0800
Message-Id: <20260807053227.341700-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds PMU event filter support to RISC-V KVM, allowing a
userspace VMM to restrict which SBI PMU events a guest is permitted to
program.

The KVM_SET_PMU_EVENT_FILTER ioctl and KVM_CAP_PMU_EVENT_FILTER already
exist as generic KVM uAPI (include/uapi/linux/kvm.h); RISC-V KVM does
not yet implement them.  Wiring them up lets a VMM limit a guest's PMU
event access, which is useful for sandboxing and for withholding host
PMU events the host does not intend to expose.

Patch 1 implements the kernel side: the uapi struct, the ioctl handler
with an SRCU-protected filter, enforcement in
kvm_riscv_vcpu_pmu_ctr_cfg_match() (a disallowed event fails with
SBI_ERR_NOT_SUPPORTED), and advertisement of KVM_CAP_PMU_EVENT_FILTER.
Like the other arch-specific KVM uAPI structs, struct
kvm_pmu_event_filter is defined per-architecture; its layout reflects
RISC-V PMU events and the ioctl number encodes the struct size.

Patch 2 adds a selftest that covers the ALLOW/DENY semantics with the
event in and out of the list, filter clearing, and ioctl argument
rejection (EINVAL/E2BIG).

Testing: built and run under QEMU TCG with nested KVM (an L1 KVM host
running an L2 guest).  The selftest (patch 2) passes and dmesg stays
clean throughout the run.

Based on v7.2-rc2 (a635d6748234).

Changes in v2:
- Mask reserved high bits of the SBI PMU event index before comparing
  against the filter, so a guest cannot bypass a DENY filter by setting
  bits above bit 19.  Noted by sashiko-bot review.
- Reject non-zero pad in the ioctl argument to keep the field usable
  for future extensions.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>

Yuhang.chen (2):
  RISC-V: KVM: Add PMU event filter support
  RISC-V: KVM: selftests: Add PMU event filter test

 arch/riscv/include/asm/kvm_host.h             |   3 +
 arch/riscv/include/uapi/asm/kvm.h             |  20 ++
 arch/riscv/kvm/vcpu_pmu.c                     |  31 +++
 arch/riscv/kvm/vm.c                           |  69 +++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/riscv/pmu_event_filter_test.c         | 199 ++++++++++++++++++
 6 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/riscv/pmu_event_filter_test.c

--
2.34.1

