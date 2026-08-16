Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAD213254
	for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786897848; cv=pass; b=ng4cm7A1w4rrPM7NW3AekFr2ixE1hT6zeGRx4XihFSwoBiTNNdcf0Gx7mFQdh/ofv0Muc3x6G6OgkWHFbfNQ1z2Biw3GAaHJX5zz0FXbad6Ivpw5fzRxNbhobDqakvvPdcPIAl8GkJ3LbhTcjiR0DvAes9W9bP8J0gXbJEvyvUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786897848; c=relaxed/simple;
	bh=lyIOK0Fwe9u9oLlJGgcvBAoE+5AUU4CoHDlbj7aRaEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKCywrPBN49JFvUeQq9O/byZxV9Ri/naohuS7vffrKH5lqYPPoQvafGxIkp5iIXk7K15bOokcVPe25lwrG+e/GV2g7nB+OLAm1M4qY1oJ/sa1CDK0tp/9WNjAL66488RNR+jV5ZG0YwqQ02RhEzbuBYHUNXi+r1bbbXW6Zs8q98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=QpkjUCIY; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="QpkjUCIY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47362928f65so2537021f8f.2
        for <kvm@vger.kernel.org>; Sun, 16 Aug 2026 09:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786897844; cv=none;
        d=google.com; s=arc-20260327;
        b=l728tddhAC5MMl9N47NOAT2s0wPl3SKt+SCa04cz5DwBCUoW3WtMK8OGJ43sYqMdVw
         LYr69MEplwGyZOleFQMvKh1r9Dvds0aG6+dmAGbNjm+ZX4FWH6+W6hTqBh6vbgJm7k3r
         sigDvf7jC0J3Mn+NVA9z0ICx5Hb20ZDXpaHfJ5jFtBcQ3BrmtobbaeQeQxSJTJvHIo/H
         b0ocI6tHrRl0n3qWALZxdKZ7wNDj+izWTnNCZSowR8NvxF4+qmhjGeQzDycdaJ+O3CzX
         wsQJgBI/o/V4X1cpHqV8PmDspzAGCWYNVi3KIz8Cu+Ro5P4PepzaWNLp0dzLHR8k+d1C
         DXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gsir39bvo4crz0oUefgwXVCPjEjw0HYQy4PeY/lGMoM=;
        fh=K+Jiu+20smOlUYeGERszc+SZGfXJ/pyHHAwHKRxV3zI=;
        b=J0r1l4PubRRu8ksQ8JC6sBPL0Sggv5tMsi/+lU19yr0fkumGLIWjCXhz7HlGbucLg8
         EJPoJglqsLKeOr1rmTvKVKJ4DGfiwT05TYBFuA4lktUy1H0FZAnRpzDPwwlnoAm6pCn2
         /+gxfphN+NNWb7y4IIb3UFW6xhJGqzHK6vhbnIbUDkIlTlI1fqTK4xhhxE8wePlksal/
         nUEUTvHAc3KUV79HxyRn9CQt14/2fKiv+eB61yWncS9b1xsbybXdLrVXrJsFIGXynEV2
         04a9+BzUEy3oLoeY6iRbNuh/42y24MAJX2gjAbaNYgX9UYl3uY+koTcVoypLY218gT9J
         75sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786897844; x=1787502644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gsir39bvo4crz0oUefgwXVCPjEjw0HYQy4PeY/lGMoM=;
        b=QpkjUCIYW3QBb40UONMIon+N0mtY5KcrvFuEYqbN/zfuSe6oNDkz52PgVWocW5yShy
         aOr0b/wTHWcNOEwlBNofrwxJUYqWqroB5hRKXVE3ouArA+usA5HAMN+el2r951sTQ1Di
         6U92S8zUQUBIDAUezib80ujXZIfjPH7rK9gI9MaJNNyqM3Iou8CZUM6VOO9GOm7WHOJs
         tSjXtNLWlp1e7FU/vmniYHsRHbY+7yrNPvvO2KKGsPLPCmM5nNm5sAX3bp54CLFPPu1Q
         Zr8kQwTTapJh0gRMYlLPiSLb23zJB0L42VDUx/qvV0PnuGDgPMWkAlju1I+EPMJQH1+X
         H1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786897844; x=1787502644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gsir39bvo4crz0oUefgwXVCPjEjw0HYQy4PeY/lGMoM=;
        b=gCLJs8UbhQ5q0Zk+gqZ/eyBvXiWVtY15RYdza7i6VacROFJXcqVD/ZVFO3qJKjc/WR
         kxgMoadofluvToOD+qVqw2Zzv5IzyWVSVAS1hNHeEWZguYFJVhdgft4I8XdzBWn5XKgG
         ooHMct68nOoyNXxRNv38AcYckAQGZCA66O4dbwmf+UjJwT/aVC7s6aMP8cbQ+ffeuKUL
         O7YrS38Ty4pRoFwRrszZ1VbkOYEa9gUIpzFcyJmE5SO8nLshuROgmqyD9++MIhznVSZs
         w/E0JSlmJ3n8YH+pmE9FatrirW9bm9ho5kFdJaBo/zzIoBPSUoNyXHxAx40Ycp2UgWWN
         7REA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5vBpcbIiOhotugDlepBPkF70s98MfiQJznwJh2x4nqJbIZDT8BInyJO+8Ia5lG3fx9DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOt93xiq2xW2nREe2xE0EM5aUqyUYx8rtqpoI6AFdN2wWf97UE
	2hQUyxrPnwxwfTjI5BdM+DRK1gGITp9i4CyPsMvhr+dtexn5/M4SeK0CdtJX+/6I16ejijMLCCu
	pboMAAYqfdsUx6/uvnHZbixurYfL/0LW8Dzr9kfStjQ==
X-Gm-Gg: AR+sD10fYnF6xT3h5dOPENL4OvBicfj4WvxckbaRx8uTJ2SszPfyznpJcUeMOQjUB8C
	uJQkgNEm5RE9qa2okZJQYFQa73Kj1GGTllJC6I3TfGoZS54o3cgthA+AoDROFoGe+FC8Y5EHUEF
	jvgcu1ULpXdCRDR3dfZvAbOcONKaaK6bxUK2hO8UQqgpRE95AeBHWN3bEbMBGxafeFrdE9dZBD9
	4F3KtzIdxCCJEnp+Z0FJ31Jp8MMWfdEn79iOixiq0bgdfiDbDjqjFUCYHv3qwmkJG9YrAcQKojQ
	thrsidQoAtWHIBYEbPY9zIm4FDazf0hJCqOdv4uyThGn7YltUo128HTrXInfNcV8IKTieuLtrxk
	LhNSJxebWtBpS8WYRhaJWqc7TnAcywx5FJ8w2lLrb8dnKTPfyD6tzgziQsQiLW0ov
X-Received: by 2002:a05:6000:4a05:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-48160761e84mr31010929f8f.25.1786897844332; Sun, 16 Aug 2026
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy2AOkykd1JyrF6kJNsZv9M8rYJqVX1TUZNe3RDehZMxHQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2AOkykd1JyrF6kJNsZv9M8rYJqVX1TUZNe3RDehZMxHQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 16 Aug 2026 22:00:31 +0530
X-Gm-Features: AcwNN1V5WjOXt2BdHCccYQ73p0KVFwqjs6aePVps2XGzyv7PMYjCvxF-XjFQWuk
Message-ID: <CAAhSdy1GMWcYMoNTvSxdu39AWhexZLHc56kVyBeDC1PNAL5fzA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv changes for 7.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

There is a small conflict between the kvm-riscv tree and the riscv tree whi=
ch
slipped through the cracks. This conflict will appear at your end if the 7.=
3
pull-request from RISC-V tree is merged before your 7.3 pull-request.

This can be resolved as follows:

diff --cc arch/riscv/kvm/vcpu_vector.c
index 3c3183b39ae2a,bf5c94d8786b5..0000000000000
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@@ -56,9 -56,8 +56,8 @@@ void kvm_riscv_vcpu_guest_vector_restor
                                         unsigned long *isa)
  {
        if ((cntx->sstatus & SR_VS) !=3D SR_VS_OFF) {
 -              if (riscv_isa_extension_available(isa, v))
 +              if (riscv_isa_extension_available(isa, V))
-                       __kvm_riscv_vector_restore(cntx);
-               kvm_riscv_vcpu_vector_clean(cntx);
+                       riscv_v_flags_set(riscv_v_flags() |
RISCV_V_VCPU_NEED_RESTORE);
        }
  }

Best Regards,
Anup



On Sat, Aug 15, 2026 at 4:28=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Paolo,
>
> We have the following KVM RISC-V changes for 7.3:
> 1) Svadu/Zicfiss/Zicfilp FWFT support for Guest
> 2) Use try_cmpxchg for IMSIC MRIF RMW
> 3) More arch-specific tracepoints in KVM RISC-V
> 4) Eager Page Splitting for KVM RISC-V
> 5) Optimize hfence request handling for SMP Guests
> 6) Improve dirty log clearing by skipping zero bits in mask
> 7) Guard HFENCE range loops against overflow
> 8) CPU PM notifiers in KVM RISC-V for non-retentive idle states
> 9) Fix kernel-mode vector context save/restore for Guest
>
> In addition to the above, we also have a few small fixes such as
> limit checks, array overflow checks, data type changes, etc.
>
> Please pull.
>
> Regards,
> Anup
>
> The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733c=
ff:
>
>   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.3-1
>
> for you to fetch changes up to b5060a4aa33d7d78a8c1837ab08ef0c81ea96650:
>
>   RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
> (2026-08-13 13:20:02 +0530)
>
> ----------------------------------------------------------------
> KVM/riscv changes for 7.3
>
> - Svadu/Zicfiss/Zicfilp FWFT support for Guest
> - Use try_cmpxchg for IMSIC MRIF RMW
> - More arch-specific tracepoints in KVM RISC-V
> - Eager Page Splitting for KVM RISC-V
> - Optimize hfence request handling for SMP Guests
> - Improve dirty log clearing by skipping zero bits in mask
> - Guard HFENCE range loops against overflow
> - CPU PM notifiers in KVM RISC-V for non-retentive idle states
> - Fix kernel-mode vector context save/restore for Guest
>
> ----------------------------------------------------------------
> Andy Chiu (3):
>       riscv: vector: refactor riscv_v_start_kernel_context
>       riscv: vector: allow non-preemptible kernel-mode vector with IRQs o=
ff
>       RISC-V: KVM: fix vcpu vector context handling for kernel-mode vecto=
r
>
> Bingyu.Xian (2):
>       RISC-V: KVM: Use unsigned int for vma_pageshift
>       RISC-V: KVM: Widen G-stage fault address to gpa_t
>
> Guidong Han (1):
>       RISC-V: KVM: Fix PMU event info array size overflow
>
> Inochi Amaoto (11):
>       RISC-V: KVM: Add support for Svadu FWFT features
>       KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list tes=
t
>       RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
>       RISC-V: KVM: Add ssp context save/restore
>       RISC-V: KVM: Handle software-check exits for VCPU
>       RISC-V: KVM: Add support for control-flow integrity FWFT features
>       KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-lis=
t test
>       RISC-V: KVM: Add SBI extension validate callback
>       RISC-V: KVM: Add SBI FWFT validation support
>       RISC-V: KVM: Reset the SBI extension when disable it
>       RISC-V: KVM: Mark the reset callback of FWFT extension always dirti=
es CSR
>
> Pengpeng Hou (4):
>       RISC-V: KVM: Allow memslots ending at the GPA limit
>       RISC-V: KVM: Reject overlapping AIA IMSIC address fields
>       RISC-V: KVM: Guard HFENCE range loops against overflow
>       RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts
>
> Wang Yechao (8):
>       RISC-V: KVM: Add the split page cache for ioctl context
>       RISC-V: KVM: Split huge pages when dirty logging is enabled
>       RISC-V: KVM: Remove redundant TLB flush operations
>       RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
>       RISC-V: KVM: Add the eager_page_split module parameter
>       RISC-V: KVM: Separate req and fallback_req masks in make_xfence_req=
uest
>       RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I reque=
sts
>       RISC-V: KVM: Improve dirty log clearing by skipping zero bits in ma=
sk
>
> Yicong Yang (1):
>       RISC-V: KVM: Use try_cmpxchg for IMSIC MRIF RMW
>
> Yong-Xuan Wang (2):
>       KVM: RISC-V: Clear former VCPU cache on virtualization disable
>       KVM: RISC-V: Add CPU PM notifier for non-retention idle states
>
> Yuhang.Chen (1):
>       RISC-V: KVM: Add more arch-specific tracepoints
>
> Yuhang.chen (1):
>       RISC-V: KVM: Account VM-scoped allocations to the VM cgroup
>
> Zongmin Zhou (1):
>       KVM: riscv: Fix infinite loop in NACL hfence entry allocation
>
>  Documentation/admin-guide/kernel-parameters.txt  |   7 +-
>  arch/riscv/include/asm/csr.h                     |   1 +
>  arch/riscv/include/asm/kvm_aia.h                 |   3 +
>  arch/riscv/include/asm/kvm_gstage.h              |   9 +-
>  arch/riscv/include/asm/kvm_host.h                |  10 ++
>  arch/riscv/include/asm/kvm_vcpu_insn.h           |   4 +-
>  arch/riscv/include/asm/kvm_vcpu_sbi.h            |   4 +
>  arch/riscv/include/asm/kvm_vcpu_vector.h         |  24 +++
>  arch/riscv/include/asm/processor.h               |   8 +
>  arch/riscv/include/asm/simd.h                    |  16 +-
>  arch/riscv/include/asm/vector.h                  |   5 +
>  arch/riscv/include/uapi/asm/kvm.h                |  13 ++
>  arch/riscv/kernel/kernel_mode_vector.c           |  88 +++++++---
>  arch/riscv/kvm/aia.c                             |  42 +++++
>  arch/riscv/kvm/aia_aplic.c                       |   3 +-
>  arch/riscv/kvm/aia_device.c                      |   6 +
>  arch/riscv/kvm/aia_imsic.c                       |  18 +-
>  arch/riscv/kvm/gstage.c                          |  82 ++++++++-
>  arch/riscv/kvm/isa.c                             |   2 +
>  arch/riscv/kvm/main.c                            | 112 ++++++++++--
>  arch/riscv/kvm/mmu.c                             | 108 +++++++++++-
>  arch/riscv/kvm/nacl.c                            |   2 +-
>  arch/riscv/kvm/tlb.c                             | 117 ++++++++++---
>  arch/riscv/kvm/trace.h                           |  81 ++++++++-
>  arch/riscv/kvm/vcpu.c                            |  34 ++++
>  arch/riscv/kvm/vcpu_config.c                     |   2 +
>  arch/riscv/kvm/vcpu_exit.c                       |  20 ++-
>  arch/riscv/kvm/vcpu_insn.c                       |  17 +-
>  arch/riscv/kvm/vcpu_onereg.c                     |  68 +++++++-
>  arch/riscv/kvm/vcpu_pmu.c                        |  16 +-
>  arch/riscv/kvm/vcpu_sbi.c                        |  30 ++++
>  arch/riscv/kvm/vcpu_sbi_fwft.c                   | 207 +++++++++++++++++=
+++++-
>  arch/riscv/kvm/vcpu_sbi_v01.c                    |  52 +++---
>  arch/riscv/kvm/vcpu_vector.c                     |  26 ++-
>  tools/testing/selftests/kvm/riscv/get-reg-list.c |  90 ++++++++++
>  35 files changed, 1169 insertions(+), 158 deletions(-)
