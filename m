Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBA2DC76F
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361780; cv=pass; b=F2ZMuNaZf70aSvZ11Z0L4JUwz2Qap+M9aZZj2jukE+VTxtxrLPAssCq7yVT5jozi7y71k9TOyGrjuXDLbOZMhy26CTVwdeaz+2sEKgXOYc5UlNSQ8zS1zsh1vCCpeV2fT7JcQFMfHnc1az10aVF/G3/im+bcUAHFCsMTbO0bKT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361780; c=relaxed/simple;
	bh=LH2gECeGj0O/0ahV9EVrVmOPRllM8ZCxrad3lQ+BgT4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gUDi7FCb1iv8ny/Wk0QaFDinBH05RvC66nqW3SQXzWud2Qn9/w04ZJ4AQsgV4nzG66C+T6wPTkYAiYD1hPXHt59WooJCC2ZilQYD1FPa2AhzTnSbN5OB4Awg0yL2/o/6b4/V95CrnQX6YWYchLZsCNn37Ep6q08bbbJwhrE216c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=vINP9XFU; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="vINP9XFU"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476a130c138so4959168f8f.0
        for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 01:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784361777; cv=none;
        d=google.com; s=arc-20260327;
        b=Nj+lmSGOWid7/JVmjprihzJ/+5dZpxc2cnBA2umD/EFv1kq9z/j0UFap2u6EgaJeGO
         gEXAfWYSvE+Wi5gV3WNqXC/qcbj4G/KUQ1JwDrkfo6J/sldihyD1YE7A6cPWVx79Brvd
         PkR4kEVQN9i3ic+f9Gq9SVrMsQM6kH+unVwKLJSNrKz5TGj6EBT1eBm+Cpua3iJB18Ep
         REMvZp49a1epRlGQdRKDOwdqJM+BvA8fTrEe8oGTFYDfihR4SGdRLEBS4lnqPSH7FtD1
         M2yMJ4paJvL70j54CB83Ip7xbuu21P2da7rhBAVAE7shpH0T8l1Aie1p2aI1DR9f1nr7
         a1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Rm7XhSy4D7GsNEFlHs1pBrGpKvn/WVAo06Ys8zEN9MY=;
        fh=khz9XtMCgjGmjyHz2S8SWeV2jhSAdgNSRyD+JFy5+zI=;
        b=Exv6lDltNtmVseQP1MosdP8v2GcXe7xoF619CRSJrIKi/Q9Z2iha+Vb7Naff4otKtw
         OF1gx+GnQcORoHWU98J0Cnd3mnUbbCeUMExovKTqD7mv4ZBvrFvWDQaNpyk4/OhKcipZ
         L/jSTNbxOI+n2tvIP1xPG1WlwK7jW6d0MjNu8woWMCSki5zVqOmeVr7jtqVFx3Gf6NwG
         /nkKXci2/MWKBYXo4GCXY+ehpxDSmCdsPez88frvBWf2asff6jPltJaf1g2kha7wJwn3
         mdWVZqao7md8YjuLKs52M9ssJGc4PauVa+PbXH6HK4uF/Ncib3cqEQBSVBZ2DLihMj2c
         GJgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784361777; x=1784966577; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rm7XhSy4D7GsNEFlHs1pBrGpKvn/WVAo06Ys8zEN9MY=;
        b=vINP9XFUyu0iGmcAy4QcQCY9j6VNsOtqwYP8U7N41aJoynCgjoHFCZFPh+xonEBGeT
         evM/iyQznyverCML+dwqSz6RA7uJOsDjEsCRSlnvllXO4HPRUTlAPZGAguMJb7Que0xk
         mMaPDVrvEYYdJCvlrTo+8U+L16DjLwagwIrgVu2YPcK/AmNnDwVwjJRS1hz7NhA22j+j
         wIhTVdW8uQ7a7XRUp1SblHPG6t/shSHK9Icv4w8m61X0Evn6f8z0XQ4XEJC58yUhRw35
         ztTlkIIbtYO89s6BOWYm5IAjPBtOvizJz6cdni5gIsM/VSVNWjB5REJFdQX/2OEEKIAW
         Cv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361777; x=1784966577;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rm7XhSy4D7GsNEFlHs1pBrGpKvn/WVAo06Ys8zEN9MY=;
        b=dEV8zibE/XvELtZQ0DzMiGPdjkUgcGrjaDoE/nJkAO81+JzC8u1gjnrIydLBdnnIt5
         sqUOweYjWQhovKUGW8OD4XrO1FZ1O/ccjqUkICfm+PwG1QRpqFOoEiq0/nuIkMPURJX9
         HvrbJsshCSge1QbDAg4V/wr0rCIHDvCNOGvfev/iXYmZpLuJNVkkSU+hh2uWLUjYR038
         t8LMjpzE/ReZgs4sUNlzV5A7hQIck8sC+I5Q6BUyv/ZN9KNxQzth2UIx5MKkaP2TGR2w
         bqsuUP8JOCGoeiwM8pNubQXF/7AChimSjjGZ+hewfBWAndHDXuJYw7Kg4fBe3g4FIvNg
         /NEw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3Q5W6GPZssOHQQdvu7Jiti1RzWZrYg//TIIhFZKbql4r7zKQp6LHTEsWPhVNX/XRsXYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQTvuAwIC+O8SrfPJuFvN9/EuiY4+UI+jGhLIBFzJFlNXFVes
	v5+hGu8gsxK8JyAeZxeIloMfsnTKzN1w7YPP2kYbLsRcLqHxQvximrHn/Df6nvdFbSzwyFUKOeK
	2SQuQo3Ml5I6wTZsBkbp/vmVx4jnmQIRGwPXz27ilcg==
X-Gm-Gg: AfdE7ckOYQ4jwyvG0pVKkkmu5s1/LlrY0WEgPJionR7QvEbQP/SL4/Uo5Dy55oQ7qiN
	7YU79s+Obct0Cp0bcbFLx+4NR1f8NodhrBLUo9FYT8FGBSjIQcNKPT+0SIMmjnmhSfrzx1M10LN
	DTdTAb1Wx19cl0iPAZCa9fglNFEgFtyujd0e6jFBX5RHAS8/87i+19r62PoxNs2rDRgPQ4u47K6
	2eQTZwycmLzYeGAFUksayJq0GTDgBFVU+sEyWIy2IWJyzIDDQSXAPsxPMPArvMb7MtTUQdmuhXt
	+HQaFt82IE5qFBnXgqayllkKtCN3l5Oes9Yud3N79K+Mk4u7XAWH05hJmBFXVAxN2aish1tpUBM
	oaNWw
X-Received: by 2002:a05:600c:4f09:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-4954a40bc1emr61521315e9.30.1784361776913; Sat, 18 Jul 2026
 01:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Sat, 18 Jul 2026 13:32:45 +0530
X-Gm-Features: AUfX_myMNGzt4ZSbXXn9B7HyuNCD1fPJy5lCNbHrmQgj6yVz1oiBXt5EwnVWQEg
Message-ID: <CAAhSdy2iT3GmYz+n_jzbQ4V_5P7UdfFhmq=BSOgYCDEQ6PPuZA@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv fixes for 7.2 take #1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	KVM General <kvm@vger.kernel.org>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following fixes for the 7.2 kernel:
1) Avoid redundant page-table allocations in ioremap pcache topup
2) Apply SBI FWFT LOCK flag only on successful set
3) Bound SBI PMU counter mask scan to BITS_PER_LONG
4) Skip TLB flush when G-stage PTE becomes valid with Svvptc
5) Zicbo[m|z|p] block sizes should be always present in ONE_REG
6) Inject instruction access fault on unmapped guest fetch
7) Serialize virtual interrupt pending state updates using a raw spinlock
8) Fix Spectre-v1 in vector register access via ONE_REG

Please pull.

Regards,
Anup

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.2-1

for you to fetch changes up to 8d9c9b135b5c23de9811a8426257cbd2fa024a99:

  KVM: riscv: Fix Spectre-v1 in vector register access (2026-07-15
18:06:16 +0530)

----------------------------------------------------------------
KVM/riscv fixes for 7.2, take #1

- Avoid redundant page-table allocations in ioremap pcache topup
- Apply SBI FWFT LOCK flag only on successful set
- Bound SBI PMU counter mask scan to BITS_PER_LONG
- Skip TLB flush when G-stage PTE becomes valid with Svvptc
- Zicbo[m|z|p] block sizes should be always present in ONE_REG
- Inject instruction access fault on unmapped guest fetch
- Serialize virtual interrupt pending state updates using raw spinlock
- Fix Spectre-v1 in vector register access via ONE_REG

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in ONE_REG

Dylan.Wu (1):
      riscv: kvm: Skip TLB flush when G-stage PTE becomes valid with Svvptc

Fangyu Yu (1):
      RISC-V: KVM: Avoid redundant page-table allocations in ioremap topup

Qingwei Hu (1):
      RISC-V: KVM: Inject instruction access fault on unmapped guest fetch

SeungJu Cheon (1):
      KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set

Shengwen Cheng (1):
      KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG

Xie Bo (1):
      RISC-V: KVM: Serialize virtual interrupt pending state updates

Zongmin Zhou (1):
      KVM: riscv: Fix Spectre-v1 in vector register access

 arch/riscv/include/asm/kvm_host.h | 10 +++---
 arch/riscv/kvm/aia.c              | 35 ++++++++++++++++----
 arch/riscv/kvm/gstage.c           |  6 +++-
 arch/riscv/kvm/mmu.c              |  3 +-
 arch/riscv/kvm/vcpu.c             | 68 +++++++++++++++++++++++++++------------
 arch/riscv/kvm/vcpu_exit.c        | 19 +++++++++++
 arch/riscv/kvm/vcpu_onereg.c      | 46 +++++++-------------------
 arch/riscv/kvm/vcpu_pmu.c         |  4 +--
 arch/riscv/kvm/vcpu_sbi_fwft.c    |  6 ++--
 arch/riscv/kvm/vcpu_vector.c      | 14 ++++++--
 10 files changed, 137 insertions(+), 74 deletions(-)
