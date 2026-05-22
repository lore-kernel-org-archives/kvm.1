Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82339DBF1
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455207; cv=pass; b=XIb6Zv1BBFtvI3Y3oE5qMmzbi4DQY//48fL+8CnKmeI3Lmmyel+J/z3mcOuV6uKeGRuuM6rmY1SJqbcdzpqVkhLCHOiXoZbLaOSqVd/UsJesSri6KTnFq7GAEIFy6dGbhZT8CofFE0Mrw80kT3WH7Vh5FPHy9UTLKyKEQ26ONhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455207; c=relaxed/simple;
	bh=1M40iwC+tnqi6/6kGIrQQkFHBdkuDA3KVMWPuRb64R8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DofC4CjcTQFIHGD70x5VJYR8P3n6061cx56JQ9suGn2tTOnemQIoS8VrCQAhAVSHddLdL1QQdEdgF2apDfijbF8J6xwDZ4u5PywciWT/ryPtILM1I1OkUkCwrDd5BmJDIrEXz+riUCwTON1pzUeIWYD2FAJGpo8OfSd46khe1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=ha+y9ff+; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="ha+y9ff+"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbca22dbfeso3881163a34.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 06:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779455205; cv=none;
        d=google.com; s=arc-20240605;
        b=WOVfc03rXjQyOded0bYd4NgOYNyYbvWIv2uno0+zjMjn0oT05C1tkVlzV/vvCgI/ML
         S53KO9F0sYZQjTJbkjPia4K/KTQLy753ghEx0+/vM0TB4RYZRZPtz8eAVQNvlkd/h/VY
         +DpFBVxJlJK+mE6RBKQ2JflYzqJDR/lrf6DDKvl85Tt5IL5/z6k3wJJumWOLajcuZO6r
         FBFnltFlkTZHfH/1kIkTuikSGXaiQ6D2iMqC2GkEVjMPDSsymT9/CT3/igzVVwRuXdm3
         pwjCl/w+vsMzfbd9eE2wgsorRR6XMHuaDjtk5lCzVTh/S1ymM+13Q/z8gQxY+/sOZmPQ
         QclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NYAe2rB0gIMb7eEgjvs7GruqXDrCjVi8nCKCe2KONFY=;
        fh=wp7eTnfftbX22HMgYUc6PKnxRIitWFh08Uxv0Od9kq8=;
        b=Ok+ktL9WG1OmQeFA3kHWxOLV220Gc2xrt+agbTGuo0kDn9cUwBkPxsQ8AHCHQp2Ieh
         lhcp5stzuWugrk0jl55XXXF0x5IDWngL/0EiFGF2ineLy6CYev+ITZZlsZycjBIbO5Hd
         9zOvB2AxbXdilQmxcvDVEJ/MHqAKRX27SkzZpUcTVwyl2iV6PsiHNAmMY7h8yKPEPP9n
         casr++mu3yiv9et1z2l9KjXTzSG2Zz8jWq5xLOgmiUSfPV/N9N3wC11DAkR7wrHv2RSI
         A4npoqyf95G3dok92DP02ESRLtl6RbH/nerlEcOvmkWFhDNJd8ACIMr0vSDxprIrR25W
         YtDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1779455205; x=1780060005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYAe2rB0gIMb7eEgjvs7GruqXDrCjVi8nCKCe2KONFY=;
        b=ha+y9ff+1Ebb6wYHrWfsqL4GlpNu/MTiLMKj6s7MkanQvI8L2K8ovniRmwtUyFJouD
         skgkMGF0n5JJZfKRLHMZsuEsf+AR1XbiIsGf7Du54cwMRThj04ClUalXgrofOOIkaWGH
         fy4hoYM+ttQ9ftNsT96FYlhHY8ncGxSan6U3WE7yI9J364a3SMIJBUgXhfmq68tnMDlP
         kijEis6Leq2POVVChxiYWjhq+2y6wP4gMQ/NVWgxguOb8zzgXhhcZIjzpOegZZfTp2ZS
         +yhCeQO//oRWWgRV1XgHYWpLNi9wNkKex+Yfhmkmr0wgftYMnbHz1MPNgBr3t01kWrhs
         QdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455205; x=1780060005;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYAe2rB0gIMb7eEgjvs7GruqXDrCjVi8nCKCe2KONFY=;
        b=bScryAfuXVbS6Dhsg4TkLi0wU12N+B7UyFy+i1l+9M9NStbS4Lr4brRYr/Wq4uGI86
         Vp87tErENYfwBDc8U38o/zqEQ7+9WBVAtNAw5UW93DVolmn9fw3NyJVSJbIRkNZ3INwQ
         hLnncVW7whKmDTPFMRM/PXAzyGiNVwztR/K5272dvakI5q8zCUmF10JZqoDUxGqi7XQF
         3iGzZdJdT/xRCkEWcn+MZjpGlC7IsiiAaU6PlcICTSRHrhTAgnqYWuQVfsB+caFrBBGy
         AmnUqmMZuX0TAjZTnBBlpgd+DpW8UMNv9q2mbbSDo9o5UTlTyt+aRDZ+tFt/RKGJl+Qm
         2DQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6kqoXB+l9SqQFCnXG7MO1goVPwYkjoHkyenyP/cNFnY9tup4yRb371NfubEoxMyDM9xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbLJehITPCyg8phZV8fN+pyhmIV8GFeGQkREF4pHUGkGWN1Tz
	T0BTciW8WoNOhKbptdxjh+PPg9cdCDNzHWf5VWbZehel0S/vgc9B/+2nb/AaOnqAJlCuxIhoM93
	ecupE7v9CtfdWBEC2TUj6gbURTe5zqW9PesD3D/UTGNClL5dkfZJ4/mQ=
X-Gm-Gg: Acq92OGH14ymYQpOyJE2XMOay9h7dRGkymCSyZ6Pdw16wamv1VEKRigaUlkd80BdvzT
	iFf6tk0j1uh4pzB4MvmkmGR4la6mQIhVOtRYyflgL6XtgM6X6h/z8YE9Luw3irXixapp8jNw7hm
	cmmA2JA3dWCcu/fPU+YYyC/kFSkzL909p4HlU8geNWApp58s6OZu1dVtwZcVxTldLcFy0Nb7i7H
	oTdmV1fMYCnvk2yVBo2tpCJCIEyuknU4Gsy5AduVXtgV+LaanDdT9yct3/Ur6xDyhXBhFwU88Aj
	JOdln87A/s3TACIl4FeLjX/pefPJMjY5g9ViVIITFNHP2h5S9sfNy39nFHKqjMKYNbVri6ILHWF
	5oKozLISo9xQs/ELWKVEvUpAwh52iFnB34gM=
X-Received: by 2002:a05:6830:4983:b0:7de:60fa:6203 with SMTP id
 46e09a7af769-7e5fef070c8mr2267305a34.26.1779455205099; Fri, 22 May 2026
 06:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 May 2026 18:36:33 +0530
X-Gm-Features: AVHnY4KfXNm77pz9jWxpxXvMATQwUmW7tiCNVyzvocwyuvXKSLYVk8Oece-by1c
Message-ID: <CAAhSdy0-joewqwsJNkMgzKvc0zh2cTFgTqdP+LZAAxmfEd+Mpw@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv fixes for 7.1 take #1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following fixes for the 7.1 kernel:
1) Fix invalid HVA warning in steal-time recording
2) Return SBI_ERR_FAILURE to guest upon OOM in
    pmu_event_info() and pmu_snapshot_set_shmem()
3) Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
4) Fix sign extension of value for MMIO loads

Please pull.

Regards,
Anup

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.1-1

for you to fetch changes up to c7832534a8160276cccb9a8cc8cafb5614c579d0:

  RISC-V: KVM: Fix sign extension for MMIO loads (2026-05-18 10:19:18 +0530)

----------------------------------------------------------------
KVM/riscv fixes for 7.1, take #1

- Fix invalid HVA warning in steal-time recording
- Return SBI_ERR_FAILURE to guest upon OOM in pmu_event_info()
  and pmu_snapshot_set_shmem()
- Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
- Fix sign extension of value for MMIO loads

----------------------------------------------------------------
Jiakai Xu (3):
      RISC-V: KVM: Fix invalid HVA warning in steal-time recording
      RISC-V: KVM: Fix NULL pointer dereference in SBI v0.1 SEND_IPI handler
      RISC-V: KVM: Fix sign extension for MMIO loads

Osama Abdelkader (2):
      riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem() when OOM
      riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info() when OOM

 arch/riscv/kvm/vcpu_insn.c    |  9 ++++-----
 arch/riscv/kvm/vcpu_pmu.c     | 12 ++++++++----
 arch/riscv/kvm/vcpu_sbi_sta.c |  2 +-
 arch/riscv/kvm/vcpu_sbi_v01.c |  2 ++
 4 files changed, 15 insertions(+), 10 deletions(-)
