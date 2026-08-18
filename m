Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1322282F36
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051299; cv=pass; b=PtsetJhuEeFgaqNIUVkTH+m6cGbmc0L7lHGasQCq00yJEI0mciEYjMNplXt8UcYSyMl6gd3E17GmgeFm7CSsNCity7ZKLQbUtU8he/ekVthIvaiOYLq4j1Gfp7KyaVbsEDoRrSs1xBkW1dOiZIJggcPFp1WQyk1fhoxxFbpSgTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051299; c=relaxed/simple;
	bh=B9XBZJdztTzXkp46t2ukqL8BL1zOs3boBCqxFN61A0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5etxmnr8LNEPzB9SVhpDh7Rnae0Sym9LMcMHtujk1fgblCyuA1vTtWMwRlDxPDnqvcJmp7RPSgI9BU3vHw+TtpxOssxl+xZYq01nDmXyE+FMD4lwjyq3u+lPy4vzTkJ39CmMZTug1NkHnqr7ignBzScLEESwUKon3Rh/OKwiVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUu/r2b+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6h6SKIA; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUu/r2b+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6h6SKIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORueaDYB8SGgZnQJhupwF85gIzf8OfQrOEupiKrf6Qo=;
	b=ZUu/r2b+mBJz7dsItiavFZ/Tpo++fBE6Lx/7ZlqFfy2QuXIgwcEg5VOKx85TSGbfuGvT6l
	Dw78EF5DCtCednFlZmSe6ZACcpSHOJeklU3XjBcC5pJn1/Z9evp+tlY7MhwG61ha1QPaik
	9ixFocYl5wfWn23kbPl/Xdh5sp9onKU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-VSQpTPgfPHWTiAJYV00Q5A-1; Tue, 18 Aug 2026 07:08:13 -0400
X-MC-Unique: VSQpTPgfPHWTiAJYV00Q5A-1
X-Mimecast-MFC-AGG-ID: VSQpTPgfPHWTiAJYV00Q5A_1787051292
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47eaa4006a1so438150f8f.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051292; cv=none;
        d=google.com; s=arc-20260327;
        b=Rc0haWTtzXDfygC2qqKcuq4Z+XMhtGHCNR8G/dNdfSsUpYm8C/q4mAi0phOzALSaoI
         c+YahDEVr/ipGQBaqRKNNGRcWigS33WRB5Rh8lIJiwxivN3T2pMBeZdIlyzhLIpXTuQt
         AoOU24SZO82br71RaudiXp/QoUDh/LjpkzsXrTQJ7MYKZ3xwJHz7E6jtOnhDitkmEUlq
         6TtvZ5YLAQfISTZJgkkRkmTS7IGI69Ig1SWzkwYM0VoErarYnVA6V1jm7CD22hOXnfxn
         FLesU429jiMQKye+LzTnwD2wv21j7j9Wf8AzbzrOIi8PieA8OgLqTJ716molviDPVLPe
         HxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ORueaDYB8SGgZnQJhupwF85gIzf8OfQrOEupiKrf6Qo=;
        fh=WQORyAMXxuWb+z5rzCzAqnQMQgFkzTRmmSkee9VdMzI=;
        b=VAmplD8fxn1Hz+UaRx27fdUmjEB42YpVtqvp3KrtLtGrNo7oOqmgxF+/jEx184vf1q
         r2jA1N1nEJ2bgAHhWCFtFEGD4oY8+DQC3qJ9Ml0l959Xy6gXmttXrgdXKak9EhHLrIaE
         aLOYQBFyuj+TOtCEJGig0a0XNv0n4UJ2dj6yTctjkcKRq8tk0t2do7wN3sgf92XYRoMA
         1tRo2HGjRBjvuMVJ1KAAT1zcaAAFjpq7MvYTy7UsWzt0bSrKuZEV6WAo6Brg7CgCIMwL
         ZxiN1NnWhVEpoUBDCp0W6inGe2eK+wa8JIIBPHu7pnZs4MiCPK6vqQ8rrdMlx12eSpXB
         Ibzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051292; x=1787656092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ORueaDYB8SGgZnQJhupwF85gIzf8OfQrOEupiKrf6Qo=;
        b=P6h6SKIA/K2WPpZtLoh0RuNY5OH+fEn5HGq1Cnri1n5YnqjCow+5j0mwMTchuqTjaT
         ze7An3BlqNhSWqhKdS+RDBvn0IwL7ClQdcdwL+ojjLcQxUy9dWVJ2Uin5xPjGX7um7gy
         CeSDI30FFvuCBeEMKrYo0aR2DA+xY/r7m+ew6IWlqzdRewFd3EiaFqSV3qNeknVjF3ea
         /ibmTw9ijiOwgCpLiA7fKXyLvNIzGNf5I1ZS4SnFLIlg2WBp4qryMOXFifzbw8E1NXSZ
         fz6psuOAbOGsSfsuLuoFn0uHdvLFLfgSuWBAwOpMqlfzYmkmA7dMYH07n8wUPHaFZevz
         YZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051292; x=1787656092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORueaDYB8SGgZnQJhupwF85gIzf8OfQrOEupiKrf6Qo=;
        b=eZQImPY5lRetptRR1hD41ClFkoXXu3O6SX+IZwPnNFa7EMAtVfdPxb5LIJ5lZZYoDb
         6BE534ZfWPKxTVNljjr0AocvrvxJwaCz4G9d3iHs1GeHEqvh6zkkwshr/QlHMmTX5HDw
         FqOji+kojVgdJvK2/GIQdYSZW+yqr4d5a+zq6CGYz/iYW0uuGkE0YqCvsO5fefY7oGQE
         EHfByl+9uP8xR4BRjuPEsZeqEstjNm9xB4PL+3r+v3CfIm+5mctukKZX8urrylhp8iGo
         kOZmd+i5ihSieeF+gGC/tIi8/ciMtjEwwDK7j4W2VquavpSNmpnLv1Csn8Dpbpus6pPo
         pGYw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhd/UY/4oJ+K5ItSkMTtnr7d2FX101BqsC+0A3T+fQkSSRrSOxbtnyRYX3OkD/wmHqMYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1o+8i9j/lKXQNOQ1rb9Qxl++ltQS8WlN5ve4J9Aa3SWtItoCn
	zg+vENTJfDnqHW6WCcgS99WKz2XPLEWBDuD4XMJBLAbroDk6yBNXSQ3H+xlzPCgl66qQCLpm0Se
	YZgvd1wiTt5ablkT8A7H3U6sGab5v17+Dcs96ubl+VIRbciurqMYrlOsiErlarj+g6toz2j2zk9
	3rWTmz9txQpl/CBgKCehJ3TE09irS0
X-Gm-Gg: AR+sD10eSnELKd4f+PyUrzaoJXKV1o2InSI8yhB9qnFI/SwBt8Wj0N0ecIChmpFn+GX
	OgfK04ToqsMxXb/oxUR7c4mnyKwRPqxooaymmCLLeyvUhKkHLlF/aEhMUzscltHflS9cpG4JxYa
	1k7gxMzoR01jgz0dkiX7h7CYDckwNdoSuO5SDgve0ke5SltpO7VyD+TfYl58TkJrHhH76pnjMrC
	n2cEcXz3OpHR2Fk9Qn1pu1+E+afu/owv9wai4B4ui3MMsxASLIYNcrfrVY=
X-Received: by 2002:a05:6000:4211:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-482a9d9b84fmr10033838f8f.1.1787051292113;
        Tue, 18 Aug 2026 04:08:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4211:b0:47f:90f1:68c8 with SMTP id
 ffacd0b85a97d-482a9d9b84fmr10033716f8f.1.1787051291651; Tue, 18 Aug 2026
 04:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy2AOkykd1JyrF6kJNsZv9M8rYJqVX1TUZNe3RDehZMxHQ@mail.gmail.com>
 <CAAhSdy1GMWcYMoNTvSxdu39AWhexZLHc56kVyBeDC1PNAL5fzA@mail.gmail.com>
In-Reply-To: <CAAhSdy1GMWcYMoNTvSxdu39AWhexZLHc56kVyBeDC1PNAL5fzA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:08:00 +0200
X-Gm-Features: AcwNN1WiqDZhT8-MKEbqR3ayVQDgK82fqbrrJ_dfLB2r9T8J33L4VhHqgam_WCs
Message-ID: <CABgObfYob0o0ZnzKMf=rRUswxOGtyft03-6h-0xTZ_MCsm+9Sg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv changes for 7.3
To: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 6:30=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Paolo,
>
> There is a small conflict between the kvm-riscv tree and the riscv tree w=
hich
> slipped through the cracks. This conflict will appear at your end if the =
7.3
> pull-request from RISC-V tree is merged before your 7.3 pull-request.
>
> This can be resolved as follows:
>
> diff --cc arch/riscv/kvm/vcpu_vector.c
> index 3c3183b39ae2a,bf5c94d8786b5..0000000000000
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@@ -56,9 -56,8 +56,8 @@@ void kvm_riscv_vcpu_guest_vector_restor
>                                          unsigned long *isa)
>   {
>         if ((cntx->sstatus & SR_VS) !=3D SR_VS_OFF) {
>  -              if (riscv_isa_extension_available(isa, v))
>  +              if (riscv_isa_extension_available(isa, V))
> -                       __kvm_riscv_vector_restore(cntx);
> -               kvm_riscv_vcpu_vector_clean(cntx);
> +                       riscv_v_flags_set(riscv_v_flags() |
> RISCV_V_VCPU_NEED_RESTORE);
>         }
>   }
>
> Best Regards,
> Anup

Thanks, pulled now.

Paolo

>
>
> On Sat, Aug 15, 2026 at 4:28=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > Hi Paolo,
> >
> > We have the following KVM RISC-V changes for 7.3:
> > 1) Svadu/Zicfiss/Zicfilp FWFT support for Guest
> > 2) Use try_cmpxchg for IMSIC MRIF RMW
> > 3) More arch-specific tracepoints in KVM RISC-V
> > 4) Eager Page Splitting for KVM RISC-V
> > 5) Optimize hfence request handling for SMP Guests
> > 6) Improve dirty log clearing by skipping zero bits in mask
> > 7) Guard HFENCE range loops against overflow
> > 8) CPU PM notifiers in KVM RISC-V for non-retentive idle states
> > 9) Fix kernel-mode vector context save/restore for Guest
> >
> > In addition to the above, we also have a few small fixes such as
> > limit checks, array overflow checks, data type changes, etc.
> >
> > Please pull.
> >
> > Regards,
> > Anup
> >
> > The following changes since commit f5098b6bae761e346ebcd9da7f95622c0473=
3cff:
> >
> >   Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-7.3-1
> >
> > for you to fetch changes up to b5060a4aa33d7d78a8c1837ab08ef0c81ea96650=
:
> >
> >   RISC-V: KVM: fix vcpu vector context handling for kernel-mode vector
> > (2026-08-13 13:20:02 +0530)
> >
> > ----------------------------------------------------------------
> > KVM/riscv changes for 7.3
> >
> > - Svadu/Zicfiss/Zicfilp FWFT support for Guest
> > - Use try_cmpxchg for IMSIC MRIF RMW
> > - More arch-specific tracepoints in KVM RISC-V
> > - Eager Page Splitting for KVM RISC-V
> > - Optimize hfence request handling for SMP Guests
> > - Improve dirty log clearing by skipping zero bits in mask
> > - Guard HFENCE range loops against overflow
> > - CPU PM notifiers in KVM RISC-V for non-retentive idle states
> > - Fix kernel-mode vector context save/restore for Guest
> >
> > ----------------------------------------------------------------
> > Andy Chiu (3):
> >       riscv: vector: refactor riscv_v_start_kernel_context
> >       riscv: vector: allow non-preemptible kernel-mode vector with IRQs=
 off
> >       RISC-V: KVM: fix vcpu vector context handling for kernel-mode vec=
tor
> >
> > Bingyu.Xian (2):
> >       RISC-V: KVM: Use unsigned int for vma_pageshift
> >       RISC-V: KVM: Widen G-stage fault address to gpa_t
> >
> > Guidong Han (1):
> >       RISC-V: KVM: Fix PMU event info array size overflow
> >
> > Inochi Amaoto (11):
> >       RISC-V: KVM: Add support for Svadu FWFT features
> >       KVM: riscv: selftests: add Svadu FWFT extension to get-reg-list t=
est
> >       RISC-V: KVM: Allow Zicfiss/Zicfilp extensions for Guest/VM
> >       RISC-V: KVM: Add ssp context save/restore
> >       RISC-V: KVM: Handle software-check exits for VCPU
> >       RISC-V: KVM: Add support for control-flow integrity FWFT features
> >       KVM: riscv: selftests: add Zicfiss/Zicfilp extension to get-reg-l=
ist test
> >       RISC-V: KVM: Add SBI extension validate callback
> >       RISC-V: KVM: Add SBI FWFT validation support
> >       RISC-V: KVM: Reset the SBI extension when disable it
> >       RISC-V: KVM: Mark the reset callback of FWFT extension always dir=
ties CSR
> >
> > Pengpeng Hou (4):
> >       RISC-V: KVM: Allow memslots ending at the GPA limit
> >       RISC-V: KVM: Reject overlapping AIA IMSIC address fields
> >       RISC-V: KVM: Guard HFENCE range loops against overflow
> >       RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts
> >
> > Wang Yechao (8):
> >       RISC-V: KVM: Add the split page cache for ioctl context
> >       RISC-V: KVM: Split huge pages when dirty logging is enabled
> >       RISC-V: KVM: Remove redundant TLB flush operations
> >       RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
> >       RISC-V: KVM: Add the eager_page_split module parameter
> >       RISC-V: KVM: Separate req and fallback_req masks in make_xfence_r=
equest
> >       RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I req=
uests
> >       RISC-V: KVM: Improve dirty log clearing by skipping zero bits in =
mask
> >
> > Yicong Yang (1):
> >       RISC-V: KVM: Use try_cmpxchg for IMSIC MRIF RMW
> >
> > Yong-Xuan Wang (2):
> >       KVM: RISC-V: Clear former VCPU cache on virtualization disable
> >       KVM: RISC-V: Add CPU PM notifier for non-retention idle states
> >
> > Yuhang.Chen (1):
> >       RISC-V: KVM: Add more arch-specific tracepoints
> >
> > Yuhang.chen (1):
> >       RISC-V: KVM: Account VM-scoped allocations to the VM cgroup
> >
> > Zongmin Zhou (1):
> >       KVM: riscv: Fix infinite loop in NACL hfence entry allocation
> >
> >  Documentation/admin-guide/kernel-parameters.txt  |   7 +-
> >  arch/riscv/include/asm/csr.h                     |   1 +
> >  arch/riscv/include/asm/kvm_aia.h                 |   3 +
> >  arch/riscv/include/asm/kvm_gstage.h              |   9 +-
> >  arch/riscv/include/asm/kvm_host.h                |  10 ++
> >  arch/riscv/include/asm/kvm_vcpu_insn.h           |   4 +-
> >  arch/riscv/include/asm/kvm_vcpu_sbi.h            |   4 +
> >  arch/riscv/include/asm/kvm_vcpu_vector.h         |  24 +++
> >  arch/riscv/include/asm/processor.h               |   8 +
> >  arch/riscv/include/asm/simd.h                    |  16 +-
> >  arch/riscv/include/asm/vector.h                  |   5 +
> >  arch/riscv/include/uapi/asm/kvm.h                |  13 ++
> >  arch/riscv/kernel/kernel_mode_vector.c           |  88 +++++++---
> >  arch/riscv/kvm/aia.c                             |  42 +++++
> >  arch/riscv/kvm/aia_aplic.c                       |   3 +-
> >  arch/riscv/kvm/aia_device.c                      |   6 +
> >  arch/riscv/kvm/aia_imsic.c                       |  18 +-
> >  arch/riscv/kvm/gstage.c                          |  82 ++++++++-
> >  arch/riscv/kvm/isa.c                             |   2 +
> >  arch/riscv/kvm/main.c                            | 112 ++++++++++--
> >  arch/riscv/kvm/mmu.c                             | 108 +++++++++++-
> >  arch/riscv/kvm/nacl.c                            |   2 +-
> >  arch/riscv/kvm/tlb.c                             | 117 ++++++++++---
> >  arch/riscv/kvm/trace.h                           |  81 ++++++++-
> >  arch/riscv/kvm/vcpu.c                            |  34 ++++
> >  arch/riscv/kvm/vcpu_config.c                     |   2 +
> >  arch/riscv/kvm/vcpu_exit.c                       |  20 ++-
> >  arch/riscv/kvm/vcpu_insn.c                       |  17 +-
> >  arch/riscv/kvm/vcpu_onereg.c                     |  68 +++++++-
> >  arch/riscv/kvm/vcpu_pmu.c                        |  16 +-
> >  arch/riscv/kvm/vcpu_sbi.c                        |  30 ++++
> >  arch/riscv/kvm/vcpu_sbi_fwft.c                   | 207 +++++++++++++++=
+++++++-
> >  arch/riscv/kvm/vcpu_sbi_v01.c                    |  52 +++---
> >  arch/riscv/kvm/vcpu_vector.c                     |  26 ++-
> >  tools/testing/selftests/kvm/riscv/get-reg-list.c |  90 ++++++++++
> >  35 files changed, 1169 insertions(+), 158 deletions(-)
>

