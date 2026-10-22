Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673498;
	b=zd3jvHIThR2DMh0Fi9v9+pyiV67Xb588oXVIlnLpO6SGVRHf5otUNSLhdFSqHereDFvF
	 H5S1yTtF77Oy685ri0d9UHhEB0/MFqcJuAxrceovQ3SkqUhkMlxzPxom6VioAEkrx3g5q
	 0rKXERPj2Xa7/1raU2BPXpURRd+VkxjeN3TlloOL09hKrD/vGI7Kn8kAzge/F413oj3tL
	 HlfhPcRFPxGeqtz9SoAcnzkjtqRChAEJluToPhbcAx59A2rlo5MKFXpae59+Nw5hLyZgK
	 pb5L6iK6TTXyScf6enWQJ4Qdbv3iQ0Wt+TNYEZMJWhCgtzWgusGcdteJVjHAsx7HnEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=lkhWzDFxqaEySec5iIKN1ckUu+fpCVqgL2+r7zgE9p0=;
	b=njXvPHt7gI6pZyVqKRK2J9oOmVvWUTJ1r7KDt9aWfkpR3Q6M9CpUJSmjbZVGleEcVgSR
	 Z8VRLLLnrEsA/9t4DRDn9/Yo4ea/910lC2r8lTZPfMtkd9791J0euG+iBzN6FFw8+Tuu+
	 lg2QkiAlsJxLd1K60Y/hwrskh1Y5vC25MmGmp8sw7u1qVbWvcE1mbI9R+yoj/8wJbwX+u
	 /i+k8v0FdoYNJXsqiofDGhtqPTNeUEgGaQJw3ZtB6glp6TLtFMrJ2fBXSdJDPC3Ug3Ia9
	 4x4KZc0UKmpIDlc0Ddu3/nebwdawwleLZ0mPZE+XDIsWYaBYvQPKJMo3dzOwVzAc2mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F67606A324
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F67606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so21097765e9.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:51:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673491; cv=none;
        d=google.com; s=arc-20260327;
        b=ZVPwgYKYfCT0enMCpv22EUM6rn/s5lVSBf4dcoOxZbCOplQyFTE6DnDZnBXcRnBMq5
         7uUB6vRuBGpmAqtjd5T+obhHFnDvhBla30QN+ea769kgc1/dQC61e1ydqKsbsodUIJPN
         /3CxmXojn8A7sFXZucYzmL+zWgTK7kBKm7bhdm8WIW+JVMqoVx+w02hhE/3+O9oI7vFu
         3lFmk1FyeS1+oOn/aaojUzQo8eDk90Mn2OA6c/0D9qI5YLAyOKGgRxUd39tQot8slOFI
         I9kpcQGU2EydnjgTaFKbIanAZKhOAygivPk2YIgLIQwm4NyukaqipZbIiC4s3E8e0yIT
         gCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lkhWzDFxqaEySec5iIKN1ckUu+fpCVqgL2+r7zgE9p0=;
        fh=N3irNgldSAeHI5cWFF8sFtwcBLTgg8TyWPHHkhp5L0k=;
        b=XIRE9ZBuaXhlTPT+9ZJVyLRPjdYbiXe4lCJTDil3rN3GsmKQYbQ53HQm4Kn7OzSL1s
         LoNNT1S9Z5i3uE2KsS52mre72S7E4hmdO7GdTIy2uwZDG7/M17/hFt38CTTl9IduYvYt
         v0mUL0MeKidNNsVa8F2kB5MJdsOP+T7xrvhT70RR19mheBjAHpH5os3ZAiGTN4IQQi6b
         7u5sURzHpH+rXAAG4JXB9NsTxHKzd7nowsxVe7EC7h/d/l0Y1+S5CBmDB3YSHQan4q3L
         7bJ5TNKFbNZQLWIwvh2RI6FRtoLwNpHYsP0JwbJ2Q6BC/Q9Ly5lZ7CG4QZzDZtfbz3w9
         pevQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792673491; x=1793278291; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkhWzDFxqaEySec5iIKN1ckUu+fpCVqgL2+r7zgE9p0=;
        b=mZUmh4HA5g/1Jv6pzlT4mW/zImEHIt2ELL9mEf6GUOkIdLBR/wns8p5cTjP7lFiMXA
         IfdgS/LVoQShERp52Hh6vBaBCJfcGyjzakbsfy112UKzy5/PV3ztOVMz/U/1pH1mqiin
         FDX/T0JCx1E882IYBJZqxq4JBY8u3qh0x+KmlYn+PD0Wq7/Xwj11h6M8jXgIJspQMREX
         p/uKBFLfSNtZa3zqmU9RlkmmHnFckHWbp6uXjrFtEUr1uTBr4im70asK5QmzaIVL1EMP
         xgEpXiw8BhdiAnjLbBibaHFhC9K9Wh4dQ6/YKhFXg5gLsP6wus7o8/daXY7MKaKM6PlH
         mk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673491; x=1793278291;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lkhWzDFxqaEySec5iIKN1ckUu+fpCVqgL2+r7zgE9p0=;
        b=whZ+DE35dNw/560e6TrNvV46ogxnSTkLFs9Bq3m/8ynRHqiROOADgCr10WIkyB+1Bq
         +XZZfJgc6Ov++imnl3zHJ9fWCkAUEEyBL3sgR1YUMFpWA6STExyXF4d6AZepd4tBRjwc
         +PRsKKGpXmYx3JnNJ2nVV8Zn2csvoKACV2NqVTDa6JDLj/pdvShDKNEJVG9GggDHyGKb
         FYNf1ZtFJfm89DuxG5DsZyPm8bLESu4D4/+dOx9MNvnwMYh8IlX0QFduP6OtI8XiqV90
         s+36J9nDEeWeVRv32S5EJnCcjMD3HlkvTuys7T2sajZ0H3zzvpCUzRdEXB0IXc6sBzZ5
         PomA==
X-Forwarded-Encrypted: i=1; AKwUvBxxIgOuX/KvyTUjETZwMAwuRihg2kh9fXCtYha2VyHO82GrEOnCiBtaqNIi5mWMmE0Hjh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6c385qxN8vbp2liDk7Kq3rHPJznSwZvgPHmhqitDiIPOgIPM2
	eCIuNkWGZwUKs0zcvO6lAWDRAP2fWG9BuVSY//OeMkQ0KhoKr52g7GyYRcbFpkr61baOeiVXp1T
	p3iCcjHDgIdhL5LUwlkLIfdLf8RpU9dEtrMq8Sr9ctg==
X-Gm-Gg: AYBFou2+JpdOofZaoc/DxJsFfnBCZnHoUTISfdHVUZSHYLlHNfAAS1MMFuduqG35g4U
	CdF4TZGVR+mKBccpgH4g5yF9YGJUoN79pCopISxOSHsjxVQCG9gx3kz6Sw4lXutk0b5anKKED+e
	0Rtf3+tbonfPOg4kToWdoirysaRoNpfMHGD/7xv02c+221OHIsP59hj0MoFGPqM2mdv6z0t+2GV
	Gl9UBVdcVboCfkbHbJNmEQ+oHu7JhFsKKFh2pj+tKgkRtnfgRpSr+CxMtcd0aGy+tR3lbLVb9sy
	SIssLmWWt6XnjOBnG38mK/VgVNCetOhK0iKqBktboRc4UkrqlGd9o5gz0Bu1spcZCuZc43zEsmL
	LRIxSOIDsNDsx2aN/43NaH4RFqRr6z9m+GRy6nhVlWaa8QWMNHDbGK0BwPVqGszRhQ7nk98q2RS
	mipaStEZ5ROTZ2ZOenYbjTc1Dr2nURiGPcPk4oVREbEmwAlfiObplGF0Y=
X-Received: by 2002:a05:600c:3513:b0:4a1:cedc:ab49 with SMTP id
 5b1f17b1804b1-4a1fdd1e97emr110310385e9.31.1792673491312; Thu, 22 Oct 2026
 05:51:31 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Oct 2026 18:21:19 +0530
X-Gm-Features: AclHuK8tY4cnQo19_qXz-4M4enDNV7jYzKlMWWGhWHS4NdQgPAJSZrkmDICrIVs
Message-ID: <CAAhSdy1zNA7Xn9Uv1fFTRJMuCP0Pd2xLQazzm2FedTo_DZwMCA@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv changes for 7.4
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

I was on vacation last week; hence, I am sending
the KVM RISC-V 7.4 PR a bit late. Apologies for
the inconvenience.

We have the following KVM RISC-V changes for 7.4:
1) Lazy V-extension enablement for KVM selftests
2) Implement KVM_PRE_FAULT_MEMORY ioctl() and enable corresponding KVM selftests
3) Show sepc/scause/stval CSRs in KVM selftests vcpu dump
4) Use a raw lock for IMSIC wakeup state
5) Reject vCPU creation after AIA initialization
6) Updated next branch name in KVM/riscv MAINTAINERS entry
7) Allow Zicclsm, Ziccamoa, Ziccif, Za64rs for KVM guest

In addition to the above, we also have the following fixes
and minor improvements:
1) Avoid redundant interrupt check for pending timers
2) Fix build with vector support disabled
3) Fix IPI delivery for out-of-order vcpu_id
4) Replace imsic switch-case macros with range checks

Please pull.

Regards,
Anup

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.4-1

for you to fetch changes up to 633b3931a87438282d6454646ff40c669a6896cb:

  KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs
(2026-10-22 13:01:31 +0530)

----------------------------------------------------------------
KVM/riscv changes for 7.4

- Lazy V-extension enablement for KVM selftests
- Avoid redundant interrupt check for pending timers
- Implement KVM_PRE_FAULT_MEMORY ioctl() and enable corresponding KVM selftests
- Show sepc/scause/stval CSRs in KVM selftests vcpu dump
- Reject vCPU creation after AIA initialization
- Fix build with vector support disabled
- Fix IPI delivery for out-of-order vcpu_id
- Replace imsic switch-case macros with range checks
- Use a raw lock for IMSIC wakeup state
- Reject vCPU creation after AIA initialization
- Updated next branch name in KVM/riscv MAINTAINERS entry
- Allow Zicclsm, Ziccamoa, Ziccif, Za64rs for KVM guest

----------------------------------------------------------------
Andrew Jones (2):
      RISC-V: KVM: Reject vCPU creation after AIA initialization
      RISC-V: KVM: Use a raw lock for IMSIC wakeup state

Heinrich Schuchardt (2):
      RISC-V: KVM: Allow Zicclsm, Ziccamoa, Ziccif, Za64rs in guest
      KVM: riscv: selftest: add Zicclsm, Ziccamoa, Ziccif, Za64rs

Jinyu Tang (4):
      KVM: riscv: Avoid redundant interrupt check for pending timers
      KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
      KVM: selftests: Add RISC-V Sv57 page table indexing
      KVM: selftests: Enable pre_fault_memory_test for RISC-V

Matthias Goergens (1):
      MAINTAINERS: name the kvm-riscv/linux riscv_kvm_next branch

Stefan Butz (1):
      RISC-V: KVM: Don't write MMIO load result to x0

Xiaofeng Yuan (2):
      RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
      RISC-V: KVM: Replace imsic switch-case macros with range checks

Yong-Xuan Wang (1):
      KVM: riscv: selftests: Dump sepc/scause/stval on vcpu_arch_dump()

Zhanpeng Zhang (1):
      RISC-V: KVM: Fix build with vector support disabled

jinrui (1):
      KVM: selftests: riscv: Add lazy V extension enablement for guests

 MAINTAINERS                                        |   2 +-
 arch/riscv/include/asm/kvm_vcpu_vector.h           |   6 +-
 arch/riscv/include/uapi/asm/kvm.h                  |   4 +
 arch/riscv/kvm/Kconfig                             |   1 +
 arch/riscv/kvm/aia_imsic.c                         | 149 +++++----------------
 arch/riscv/kvm/gstage.c                            |   6 +-
 arch/riscv/kvm/isa.c                               |   8 ++
 arch/riscv/kvm/mmu.c                               |  42 ++++++
 arch/riscv/kvm/vcpu.c                              |   3 +
 arch/riscv/kvm/vcpu_insn.c                         |   2 +-
 arch/riscv/kvm/vcpu_sbi_replace.c                  |  12 +-
 arch/riscv/kvm/vcpu_timer.c                        |   6 +-
 arch/riscv/kvm/vm.c                                |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/include/riscv/processor.h        |  19 +++
 tools/testing/selftests/kvm/lib/riscv/processor.c  | 109 +++++++++++++--
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  16 +++
 17 files changed, 246 insertions(+), 141 deletions(-)
