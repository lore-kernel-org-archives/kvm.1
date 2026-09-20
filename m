Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95E3DB324
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892729; cv=pass; b=YzoIOtiHhwT6i1GL80pfJkDzoqe+WgfazTYASMfh2+2LZYuTrMlBd+/vD5FMJeGF9orfJeINt/B6GsbtqKhxYZMhiIIXiw5QNJe+tpNNvvLyErYxspejNfkC3R28eIXhRhbQlbjuIXz8i7B+2xyb/MJU09F7TsfdHUFzQo2jSA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892729; c=relaxed/simple;
	bh=VXFTwPchnB8FN8+NBy8TOuHUJ8PP0h+KsSBgVXPy+6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VFhUJSuZpdler/b/8Cs2BSsqEsP1Ig/Awihi+EXmD94O3nzRfMimXCIKrdka4ELq1QNA0PSDzOfXwOGAN2ZgVxdzMIx9magkRjs0lTFppZn7qGpYKADbPWjmtQF4Ine9kxeRSuoMfL/3BRhTwRyLXNCcvGokPLARCrTcVS5CwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=PPF+vm0S; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="PPF+vm0S"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so1574683f8f.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 01:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789892726; cv=none;
        d=google.com; s=arc-20260327;
        b=H1AbCnda+A7DudeggghC8rk9kw6NNTbQL6x8CFSzz/LwroBoEdXJY1Cx1HZOvVOz9w
         xSHuzl27F5+nJLXEmEoddSmXysQsHkVQN8hu7zB2AvEolws3af3m1eTtJoW56+yiO5g4
         T+KRcTyiGRGnZ5tWnFJ66YPGY44fM0h6xaiUltRVT/zrv3zaKfwUk8wC8RaOe+/44uDs
         NGAm1F7o2brZAcmrO9qwDZjQRNSsMGUiHwxSCfc/hfh0/eLlWBk/wfxBTttmvYuvehp3
         kuBc3JjzbERW5jHrKu/FHM78Fx4Y38zSasjepQ4psDR0B170gvwLc5bnPSeRBYjwB6U2
         ftBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/v5NR7eNmP+HJUBTR1GLDXgKiaOepq2osnsCYiJw7Nw=;
        fh=PbXyHT1gbz5b7z1j4p2uZnEMvbJZJsP+ZdslIUSkF7A=;
        b=XNUjeldTBm1ri3V//LmMAin+eM4AnUYOnms2ojIMeo4pbksf6AhdeWg0YDIXhzgdBF
         JhgwrTrlLTqM+xm5uCUUYUEDlGctFCbbXFB5k1anZJhpI8Ih8qFMg3f6NIE6pTwy3+EC
         bmrOtyJN6K2dlQMLWzwYzl10vh1bHS5Cd7hnYs5wSsV6/HQDxdqN/XkGh8x/7AwTlg4z
         TEnZ6EPDvun4joDseaLlWd1q5Fbnl5RvuBLkLIEZxb7aId8t/xv3SODRt0FoGzxYrWZZ
         eLccieoqzyLDl8QuHw3K7KKXoRyW80X773eOdWwY84sEJgRmazs9qRg9Y1Cp1HvQcy5Z
         ewwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789892726; x=1790497526; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/v5NR7eNmP+HJUBTR1GLDXgKiaOepq2osnsCYiJw7Nw=;
        b=PPF+vm0Spbrcg+dy6Ycjei0utHpgSDPZ0YFcNgHWGmsVD7Z4vScofVyROUp4/0WUGK
         StsR/h2hgaai34DIGDw85YKmTqJhUMPtzFS831FFGL/pW4tiXtMgMmZ7pp7V+/oQHkIy
         tqW9g7Db02MiAAznLCx3TxcICcqxhH8XInM7eTUNM8yFqbNf8PfwloveVTh45HB6ZhFE
         BkdFIrM556rwibYT1NJHfKUwsYr3oebH6Mt5aMvouTZQVyfeE1l3lrjVAwT3EJoOoRrO
         z2cB64JlM11lcoI9gw5etUHmwBGR0K+hEOp8zmWPMVKnBHf2oBwtRlDeeQz4al0ZLkIB
         NW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789892726; x=1790497526;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/v5NR7eNmP+HJUBTR1GLDXgKiaOepq2osnsCYiJw7Nw=;
        b=rfGjazZTiDs/AL9TJv3brIKGI2yTZCmmx+wA1pgxqLI4kdV2bIJayVzP1ZEKAVYDlB
         IXK+TpgIJgHPqJkv63NqzKET971TbSVSb3+4jtBJtNy6KkYnTmWCG50RgpC8A15CTfwe
         eIO9HvXcw99YLK0JpNAhzPpbyYj5qfh2alKEuJJbZO3FzA4BRYGog7RBzaQrqsKz1wS2
         QN+T4dzi5cfZHZ5XFB9d8v/20H2GAJk0oeEYMbjnZV79znJT+eFZNSKoyVknpMgru406
         3ecF+fh/C4WJFOcV5S7H8oLvvWJJDpHmrtkWkpOQ4Hy8OuOmxg7fSO5pHkxsaevqqqAl
         WcEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHY6bw63+0Wv3swEX8csASDuao0o2vWqo/UsqRft4UbRQ4PXDKRAPRjMlJVQxQjpiwbgI=@vger.kernel.org
X-Gm-Message-State: AFuF++kQMNr9ZW6bjk2DlUnB5fMUokbwYvUxteDUOB6qzwLYX1OdjGbs
	PSrtd1JwJRzTyZGYymKPx5eQynv5+XE6QOB42152fejbawFvW0ZZmwdBA4Uucdgl04F8PplNXP8
	vM49+5npq+zUnX5+jluwuTvE7H22yTcZ0L3uvPFb3nw==
X-Gm-Gg: AYBFou2dc44Jnz2Dy5qiMlJeutT7WWOH0Tg/s60hm8HcP27DF68F7XuCYXJmjd6ul3+
	4y+aST04EQEgigQiGKo1mROqPy2G7o5S2R84KcCN1SQmuR6femlO5DZNsocCLU6v1KuC5THRMHM
	A7/ettr8K7KTSY7l6PX7ILtyh065Q1TYa1QzdfbWTVE5GFKT6UYhdZlSQGn3+b95m8mr//5HzfY
	oZrHCzQfyG5knVAzlbFc8QgyTx9Ab5EKRc6VLvVFlkMq8HgBWss++tvZs2j1rMfJjYNWyrbbII4
	2w62viSFd15jPlP74pcXn6OmkWBvvveog4dzZqHo71T4TKudsq/vIaxcqHdpUU73LJJqyMt+ROS
	uxoCsLRLCFf2istqThL2E/ALrfdcHVNUwXu0Pm0NhJXMEPu3N5c7KZc67oBF7BxcepWHZY2lxDA
	==
X-Received: by 2002:a05:6000:2c0b:b0:487:6f0:8658 with SMTP id
 ffacd0b85a97d-4871e36d031mr10347126f8f.42.1789892725264; Sun, 20 Sep 2026
 01:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anup Patel <anup@brainfault.org>
Date: Sun, 20 Sep 2026 13:55:14 +0530
X-Gm-Features: AcwNN1VHoP9FKod9I1ZhoSlWxL2KyjBkIxPhBW5MLSbl95fW79rnRDNl-xpnew8
Message-ID: <CAAhSdy2MbSq2eGDZfh_EKt2S3OUEn7tJRWUgvncPsWNVR7vqeg@mail.gmail.com>
Subject: [GIT PULL] KVM/riscv fixes for 7.3 take #1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	KVM General <kvm@vger.kernel.org>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

We have the following fixes for the 7.3 kernel:
1) Synchronize hrtimer during VCPU teardown
2) Fix the conversion between vsip and hvip values
3) Serialize IMSIC attributes with vCPU migration
4) Release unused page after MMU invalidation
5) Propagate interrupted G-stage faults to KVM user-space
6) Fix NACL hfence entry update order
7) Fix sdata leak and stale snapshot_addr in PMU snapshot_set_shmem
8) Preserve firmware counter value across PMU counter stop/start
9) Report PMU snapshot write failure to the guest
10) Fix perf-backed counter accounting across PMU stop and read
11) Fix HSM hart status error propagation

As you can see, the fixes are all over the place except quite
few of them (4 fixes) focus only on SBI PMU extension.

Please pull.

Regards,
Anup

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.3-1

for you to fetch changes up to 41e81f7e3ef96594fb840445343c0ee7723aa550:

  RISC-V: KVM: Fix HSM hart status error propagation (2026-09-15 18:55:51 +0530)

----------------------------------------------------------------
KVM/riscv fixes for 7.3, take #1

- Synchronize hrtimer during VCPU teardown
- Fix the conversion between vsip and hvip values
- Serialize IMSIC attributes with vCPU migration
- Release unused page after MMU invalidation
- Propagate interrupted G-stage faults to KVM user-space
- Fix NACL hfence entry update order
- Fix sdata leak and stale snapshot_addr in snapshot_set_shmem
- Preserve firmware counter value across PMU counter stop/start
- Report PMU snapshot write failure to the guest
- Fix perf-backed counter accounting across PMU stop and read
- Fix HSM hart status error propagation

----------------------------------------------------------------
Myeonghun Pak (1):
      RISC-V: KVM: Synchronize hrtimer callback during teardown

SeungJu Cheon (3):
      RISC-V: KVM: Preserve firmware counter value across stop/start
      RISC-V: KVM: Report snapshot write failure to the guest
      RISC-V: KVM: Fix perf-backed counter accounting across stop and read

Tan Chi (1):
      RISC-V: KVM: Fix HSM hart status error propagation

Xie Bo (3):
      RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
      RISC-V: KVM: Release unused page after MMU invalidation
      RISC-V: KVM: Propagate interrupted G-stage faults

Yicong Yang (1):
      RISC-V: KVM: Fix the conversion between vsip and hvip

Zongmin Zhou (2):
      KVM: riscv: Fix NACL hfence entry update order
      RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem

 arch/riscv/include/asm/csr.h       | 20 +++++++++++++++----
 arch/riscv/kvm/aia_imsic.c         | 11 ++++++++--
 arch/riscv/kvm/mmu.c               | 10 ++++++++--
 arch/riscv/kvm/nacl.c              | 20 +++++++++++++++----
 arch/riscv/kvm/vcpu.c              |  3 +--
 arch/riscv/kvm/vcpu_exit.c         |  2 +-
 arch/riscv/kvm/vcpu_onereg.c       |  8 +++-----
 arch/riscv/kvm/vcpu_pmu.c          | 41 +++++++++++++++++++++++---------------
 arch/riscv/kvm/vcpu_sbi_hsm.c      |  4 ++--
 arch/riscv/kvm/vcpu_timer.c        |  5 ++++-
 tools/arch/riscv/include/asm/csr.h | 20 +++++++++++++++----
 11 files changed, 101 insertions(+), 43 deletions(-)
