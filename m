Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9D1F131A
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219779; cv=pass; b=HWaQCpIrK43CZqwqyJY+khhB7qWxOrma6XFvHSgSRkgfzYEqbBz+zeuyuVK9UobQr4bWPzELCe0N0Xmo/iphZiSlEv+JG+z/DKXdb3ocpcYefcNFmAxiJG5o3tGFY+hIyVWiGNbUc2ffQsTywM+BRZmci0eLxp6Hq9zYynWL8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219779; c=relaxed/simple;
	bh=u8cJQTyOXgXzVAjhcRMpeP0M/QKFpl9SwZeWX3+nqRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXeAQZBqg/7tzF8avFzxkgREpN7GJBrIAq4NOQVNay4O40BABEi+ZBFID/n+ZrkTMuKLx4iW3WDK/9pQAPNiIUK09/aN7I9wbyh82PF6ryWi3/98Gu5LJBmvYdVgNVZVG0RTX4ky6Zivli+9X3ja9CVhYorzyjs88zYbfZ6zkMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=FY6136lj; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="FY6136lj"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4be94eeacso1760569a34.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 05:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775219777; cv=none;
        d=google.com; s=arc-20240605;
        b=fEeWo4ZXygUegLMvlcD8FwQo5CiiIJOGSYwzwuOU4iqcydPv5+ynInKuV8S6a95ixz
         6uoZmFk6pHQpLVWg5yBx9oy/lqpqynpDrO+4faKApkRIW9wXUcjhVYYR4MZZJ3I0kVS1
         dZIIxvLflInHTDeTNm0A51AmGgyey8JwgjEtWRy40mkGl+lsHT+23vsfh35w+00+i6bV
         79GHG2Q+wxILJ5zY0aiUBlF+uUfiAPOiuA4xNAGwtKsewqunxOZYTD5nEzQCIXDgatIm
         eBDoDcwQSKcj+c+DHnOyR3k0unsnnEeBHKS6Q6Ygx9Q/mxN/CiMRDDbbOPNXbgOn0opo
         w0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f489z9Q14+/QBLo/ZJR97CzCHDWPhtl1lFkJsX7ZtzE=;
        fh=pjLt1K0xIydWHvG591ugquQzDrpS5YbMPuJiyEnAW8w=;
        b=MK0lg9JkYKYvUhRvZURH9sZKXGFfXufdZHkCg1iJZizLFjL7u/BQKa/2Tmp4waWYz1
         lnsxIuEFKdDXBjzCl1Sxg6SpVO5H53jJ9kNW1gQSZ7HXvcBPiX/DNpXJDVKpit2q1Lwf
         xeywclO6FYTR3IddDh7c8/a2yxOY21SzKBLJmS3L7Dzho7RNK5F2MrFPWLiOY1U5fAno
         U2mQwkbm65VOLknUdfVUkc6CHn1Qqet0uByHWdepLhYg69T8kuVL2emXPje0HfFhz7zx
         w6loZgzvV82akuRUyLBum11wqQZGpJ6dpcyKp0KMMOputb7Rn8aqAGp8cAf5sN33IAKV
         fCvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775219777; x=1775824577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f489z9Q14+/QBLo/ZJR97CzCHDWPhtl1lFkJsX7ZtzE=;
        b=FY6136ljR/kVvLi79Ko0SPAa46k/apW4mY/feQCgmkkVwekzpfu8VsLR6FbwGtA0DS
         55VD0EUmUQPr3N/xtcUD00RUpzVUkz5f+6NzbVdulhiv2auTS1MseqO9Z4B4YnEFYXHk
         ur2B07lHjLLfhmY/YQhKJ/V9RJzlf0Nbjj/bjM0eDOKzRuwqesap8O4ftX5ejubOyb6Q
         OIO+nGjRgVT5oacbI9VO8Xb7hALKEHKYwCk44UuNfxL1rA+d5DqJmRsw86PF4emiyr4Z
         Z3aubbCTeUY2kcZRsyfK8IhL1ER1mCIU9yS7FeGESZCGjBI4jsNJmaDAolkx9mG/CT49
         60cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775219777; x=1775824577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f489z9Q14+/QBLo/ZJR97CzCHDWPhtl1lFkJsX7ZtzE=;
        b=raIsV0qVdi2NN0M2wXoPsARxLZxd5E+qYPnJeqEJHzLudwUELj7E2imVqRm3qDA6su
         UMMQ2Vj7q4Ma8xtUNH+TFdr+KCLxcRGQgpJyhb4lyKiV/DBV67E5hE25w3pv3JDrBxZA
         jua+u5HDQjKMnv83hKMMZuP7uO4SXyMmw+tonYEohOKSU/zTlh5GdTrf7+tJ1oPcQVjI
         nSuzt2ap6B8tIqwt9XjW7rtcD0/Ur0e6txoTZyW/N8lBM0qUgg8tP6jx9VMIx/DE+wbP
         cM+J2VKMeZwnhhPZM71HrD00uK2B5LiwllDS8CqWhM96r2N3nsZ/LY6KVgiYpnzwMgHh
         8PYA==
X-Forwarded-Encrypted: i=1; AJvYcCWipeHja6nzPaUszh023yUYrei4WtvmswqUv8bc6a59aqOAf2dGswdOHTjGVaicS/NaxXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HfBPUnKvSLmQ0A57qR+dZATf3ckrjqEx2wDH0MtaFb78IffV
	M/NFj8b1GH34zFefWooXUyqFUGWx+BtYjOzmtggQtVIL3BXTIUz4rbdkWfhHJgfsThNHhZke6o6
	7QgvzFniLVakPZitIM5gx5iSsasF5x+nwR/Tgx0hBSQ==
X-Gm-Gg: ATEYQzyiHtUUdyaIi1wr2UlYpcYUkKM6UItVfoF9sIk6hXkP/Pf/Efb4eqioyYnDVoS
	gCUR0eCsSwhx0hnYw2aWkh73+qhjMH2uhOlaKLvldeGDxbB7o8d8bqLrI+HlcNQ4lKvgHoFW50E
	CJn6JNWbkkR8QqQ4Ag6hwiES7tjWlQBPrC6jYJ0w7Jykt9rL8OwCVxTtoJY7Y5tlWnQpR6c3Vmh
	g5tg5H16tzNVV6U1KVQfteoV7uNy3Zw0sPZy/xL440+Ub5VPkg7zb5czGcpUTRbwfR2DTllyMly
	rx9GdqL9keFsqC6/bzAl32vsdYdLFDuF/pbIBekOJUsZcLF1LvzSd/RAS7QKei/cP7U3YOXibYU
	HMK7Qv96BjuUkdfn99U4AkQUMkw0=
X-Received: by 2002:a05:6820:f024:b0:67d:f56f:fe00 with SMTP id
 006d021491bc7-6822064c872mr1411396eaf.49.1775219776853; Fri, 03 Apr 2026
 05:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
In-Reply-To: <20260120080013.2153519-1-anup.patel@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 18:06:05 +0530
X-Gm-Features: AQROBzCZaj5NdnrddgbMifGi2nGpuLv9sXk2KqbS9U2BYMG_GPqE8MDkvi1tBQM
Message-ID: <CAAhSdy3EDro0fOTh+Hi6s6DUU6ENg+ufuUQqTG70g8xpSy7Keg@mail.gmail.com>
Subject: Re: [PATCH 00/27] Nested virtualization for KVM RISC-V
To: Anup Patel <anup.patel@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	Shuah Khan <shuah@kernel.org>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:30=E2=80=AFPM Anup Patel <anup.patel@oss.qualcomm=
.com> wrote:
>
> Initial nested virtualization support for KVM RISC-V. Using
> this series, we can boot Xvisor inside KVM guest and KVM RISC-V
> insmod also works inside KVM guest but we can't run nested guest
> at the moment due to work-in-progress G-stage emulation (or
> G-stage page table walker).
>
> Patch01-to-Patch09: Fixes and preparatory changes
> Patch10-to-Patch23: Actual nested virtualization support
> Patch24-to-Patch27: ONE_REG interface and get-reg-list selftest
>
> Upcoming work on-top-of this series include:
>  * Software MMU emulation for nested guest (aka swtlb)
>  * HLV/HSV emulation
>  * Sstc emulation for nested guest
>  * SBI NACL for guest hypervisor
>  * ... and more ...
>
> These patches can also be found in the riscv_kvm_nested_v1
> branch at: https://github.com/avpatel/linux.git
>
> Anup Patel (27):
>   RISC-V: KVM: Fix error code returned for Smstateen ONE_REG
>   RISC-V: KVM: Fix error code returned for Ssaia ONE_REG
>   RISC-V: KVM: Check host Ssaia extension when creating AIA irqchip
>   RISC-V: KVM: Introduce common kvm_riscv_isa_check_host()
>   RISC-V: KVM: Factor-out ISA checks into separate sources
>   RISC-V: KVM: Move timer state defines closer to struct in UAPI header
>   RISC-V: KVM: Add hideleg to struct kvm_vcpu_config
>   RISC-V: KVM: Factor-out VCPU config into separate sources
>   RISC-V: KVM: Don't check hstateen0 when updating sstateen0 CSR
>   RISC-V: KVM: Initial skeletal nested virtualization support
>   RISC-V: KVM: Use half VMID space for nested guest
>   RISC-V: KVM: Extend kvm_riscv_mmu_update_hgatp() for nested
>     virtualization
>   RISC-V: KVM: Extend kvm_riscv_vcpu_config_load() for nested
>     virtualization
>   RISC-V: KVM: Extend kvm_riscv_vcpu_update_timedelta() for nested virt
>   RISC-V: KVM: Extend trap redirection for nested virtualization
>   RISC-V: KVM: Check and inject nested virtual interrupts
>   RISC-V: KVM: Extend kvm_riscv_isa_check_host() for nested virt
>   RISC-V: KVM: Trap-n-emulate SRET for Guest HS-mode
>   RISC-V: KVM: Redirect nested supervisor ecall and breakpoint traps
>   RISC-V: KVM: Redirect nested WFI and WRS traps
>   RISC-V: KVM: Implement remote HFENCE SBI calls for guest
>   RISC-V: KVM: Add CSR emulation for nested virtualization
>   RISC-V: KVM: Add HFENCE emulation for nested virtualization
>   RISC-V: KVM: Add ONE_REG interface for nested virtualization state
>   RISC-V: KVM: selftests: Add nested virt state to get-reg-list test
>   RISC-V: KVM: Add ONE_REG interface for nested virtualization CSRs
>   RISC-V: KVM: selftests: Add nested virt CSRs to get-reg-list test

Patches 1-to-3 are already merged as fixes.

Queued patches 4-to-9 for Linux-7.1

Thanks,
Anup

>
>  arch/riscv/include/asm/csr.h                  |  17 +
>  arch/riscv/include/asm/insn.h                 |   9 +
>  arch/riscv/include/asm/kvm_gstage.h           |   2 +
>  arch/riscv/include/asm/kvm_host.h             |  29 +-
>  arch/riscv/include/asm/kvm_isa.h              |  20 +
>  arch/riscv/include/asm/kvm_mmu.h              |   2 +-
>  arch/riscv/include/asm/kvm_tlb.h              |  37 +-
>  arch/riscv/include/asm/kvm_vcpu_config.h      |  25 ++
>  arch/riscv/include/asm/kvm_vcpu_nested.h      | 163 ++++++++
>  arch/riscv/include/asm/kvm_vcpu_timer.h       |   1 +
>  arch/riscv/include/asm/kvm_vmid.h             |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |  36 +-
>  arch/riscv/kvm/Makefile                       |   6 +
>  arch/riscv/kvm/aia.c                          |   4 +
>  arch/riscv/kvm/aia_device.c                   |   5 +
>  arch/riscv/kvm/gstage.c                       |  14 +
>  arch/riscv/kvm/isa.c                          | 259 ++++++++++++
>  arch/riscv/kvm/main.c                         |  13 +-
>  arch/riscv/kvm/mmu.c                          |  18 +-
>  arch/riscv/kvm/tlb.c                          | 135 +++++-
>  arch/riscv/kvm/vcpu.c                         | 117 ++----
>  arch/riscv/kvm/vcpu_config.c                  | 130 ++++++
>  arch/riscv/kvm/vcpu_exit.c                    |  62 ++-
>  arch/riscv/kvm/vcpu_fp.c                      |   9 +-
>  arch/riscv/kvm/vcpu_insn.c                    |  46 +++
>  arch/riscv/kvm/vcpu_nested.c                  | 258 ++++++++++++
>  arch/riscv/kvm/vcpu_nested_csr.c              | 389 ++++++++++++++++++
>  arch/riscv/kvm/vcpu_nested_insn.c             | 140 +++++++
>  arch/riscv/kvm/vcpu_nested_swtlb.c            | 146 +++++++
>  arch/riscv/kvm/vcpu_onereg.c                  | 334 +++------------
>  arch/riscv/kvm/vcpu_pmu.c                     |   5 +-
>  arch/riscv/kvm/vcpu_sbi_replace.c             |  63 ++-
>  arch/riscv/kvm/vcpu_timer.c                   |  24 +-
>  arch/riscv/kvm/vcpu_vector.c                  |   5 +-
>  arch/riscv/kvm/vmid.c                         |  33 +-
>  .../selftests/kvm/riscv/get-reg-list.c        | 106 ++++-
>  36 files changed, 2244 insertions(+), 419 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kvm_isa.h
>  create mode 100644 arch/riscv/include/asm/kvm_vcpu_config.h
>  create mode 100644 arch/riscv/include/asm/kvm_vcpu_nested.h
>  create mode 100644 arch/riscv/kvm/isa.c
>  create mode 100644 arch/riscv/kvm/vcpu_config.c
>  create mode 100644 arch/riscv/kvm/vcpu_nested.c
>  create mode 100644 arch/riscv/kvm/vcpu_nested_csr.c
>  create mode 100644 arch/riscv/kvm/vcpu_nested_insn.c
>  create mode 100644 arch/riscv/kvm/vcpu_nested_swtlb.c
>
> --
> 2.43.0
>
