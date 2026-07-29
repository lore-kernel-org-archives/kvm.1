Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895D4052C6
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342097; cv=pass; b=EKyGffGMYL3KYUGJfymTUR8R+KNH9i2LK+KJHPj+DqIQb/EXeYJdQphOlf9/LXr7w2nDz8AVfHHeSc1u4UYhORyAgPxUruupcX+kcgS0br1UIBttwl5j1Gj695XtL7Uty8T5a/DI63sq3CDvyUIpuBE0TFRqZercQQIyUtC+K5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342097; c=relaxed/simple;
	bh=LyMy1F4QlR8PI9H1s9I6XJ2S/7VeTGQVnwWyO1tA/fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsf+i5hPwginaY9GF3qsPrBEBJ/3GyTtvje9fIp1a+Yoss7ovL3v/lisUcYIMSYPsvAvFyu/9sUWUPd4akQZ8aEZcoCg6pqXipXL6l1NtYLJS3PGpmuRCZQrFwT8rAp6Vls8qTXDMJKy4qip/yLdJier31tkBFna6NesKBwXrCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=fAR/CNKI; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="fAR/CNKI"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1246506f8f.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 09:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785342094; cv=none;
        d=google.com; s=arc-20260327;
        b=KkL6cxX6evfLwcCf4BILfOWTJRtvo86hS5+0Ms0Sq6xHI7pBao8sjkSUWYvK8HC9Rp
         utRrWLlio1rtBaGOotXTEv1Y765sGmnFqSK1OyADr+foAVb6/Tz2/4VAvabHc6b0WbxC
         tvnamyrwys2AsR5v+FHQMqzXUDWhKXc09bLogRxpfB4lG6B+Q/YUnGAvUVAsAC2c1eol
         jZJvEjgArtE8xTE7w+mhHPh5BoK6PJgrXe3cKPbhTjMGLtoSxQthq3CZp42HuCbnkUhU
         r3tXz0sqoBo70QQLp0ASBSeRiuaX1jfMJpNHQCz6KPM7s/MdQX8xREBUL8MagsgLiNHk
         y09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        fh=MtdCchp6LliT9/0rN6PFX9DKCxlJKOy9ZR/80LPGc1g=;
        b=dL6GT5l1qRyQZLRGLf3u23wArf4rFHU6dkSr8BVZ3vzkiI4AT8H/cwJ5djqk5dxeOR
         tTFwwY73pWrGj7PBG2YV7AiB0Tk062njpsqHHpU5M7NCGS8UVQONaQkd6SX64TfFpvZ2
         idEqXdQ/Muy43uhhO0EQYzHr457xCZ5jHYkPvGnvKDRbZbxDDxwuM4zVZdaE/IyXgElx
         gUrbdV8DzZoGJlIrRpfVaLccpeXntEbQRAze9N9Rpr7AH8uPiJJ9wAt0fJdJfJko82Ko
         q7vGurz43yHUrTXfFljERtG8IlDBqIhRim3YKAu18pxU89iZYzt36AEQc7XvNmesvydh
         Ux3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785342094; x=1785946894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        b=fAR/CNKINJPvZ6qY+0+fxjat+cwjLzJErBHWl/kH2/FG23D/EjRNBiYE7qFzKISP3M
         5kOd4/NGw1H8Q/7gezl39QbEfbpGjhOaNncy8hGWL92p8V0Guyq6LbgEJKSi3q0BlcVB
         JvAnNgivFMXE7kcy+WWg7uR6jWt1mUAtCTC6duKHGE2en4Gh4jkNbJfZ/qRxbSoN5axa
         pazQgTfQ1HEumzBmwdhDasAbrIgzX/0U4QdCin0R2fYgWD0TmQvVyWM/WnHGeUbp12Eu
         Vl8BT7pFyHl7dLcDrcu+W+i8930fp6wEBGtQ3EHvDc/lj1AYkygLiqu8d4jV3QP30kQq
         t/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342094; x=1785946894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlNUGStHPcM9h7uZ5gMcfZsRgLFM6lwcIC3C63GbVXU=;
        b=feRN2ixWNnC+oJpqXfTpoRqRUUS+pycHyYr3IQWyRYkFYTFlolc0y4ELEp7deJl3Im
         p9CHwi0tdtisRLUp7k+vy4eH8iSa5iLgP7YEe/55RQuF/qYPQJ1B/dT8xlmmP+nQ3fio
         VoU3rYZ6gEIK4zdW7jjqevpyYxjwz+PDK7cYQG1FItFMdJ62HREdMdEmK7TEsDpbTxFG
         qtJBkftv0xF3az45x82aHcJ/dUjw6fE9xiE7SN9B9c8d1gbW+HV/TS3JP/Uax0C76cPk
         PYxL3PFeE+2wTGUiN+RNCmy9E+OgLBhzhqwTgfwThFTQHaCVBjU//thcFplUqwvPwK4J
         wrtw==
X-Forwarded-Encrypted: i=1; AHgh+Rqo9LC64Bfzer/JtQRFxoFTgu1JoZN0ay6TF5/f7LWQqunwXnHF+RuwsHlsURDXZZqMARM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZDLDQmtRpF/jtXTuh0rbLTynpgji6zaXEXxCMxuwOkVbtC4h
	rSVR4Y8NcrcBLoz1+NIlRdOxCXiP9B6NPb76ksLXoD/fxK8LksneRI1D3E4tScUo8k3oN2k9GRP
	i5FbQDNAFdmBGAcuUAQ+Xat+GP28hBTBnmCLadq82dA==
X-Gm-Gg: AR+sD11msUM+cx77v/YJD6soe01sQBc8xJ6Hl6I6usnpNSZfpWnH9ByEX9QkamMPmei
	LrMgZ2cB+FP2N05qIQYIBnUV4DH9bhOcpakwUoDHkYI7rKWdQ0KzpYQMKy7HNwLdaofittGjJ0n
	SUaEGC953DTJ7lbkJZa93g8B42nDsJdqBxgh94RV4vh0dkATHu5m1QEOuKxfDXWDmCg9tEvmZLY
	lrTP1RNyPpFU1777KpzUo74Bt1Ef1xG5YsD9FBeYOcPtD+MBszvYZAoaWT21ANuGSLyT1UvUQix
	ndaKk8bQafE+Yicj+FUP6ExI/vx014T3P5NqCPOqrirvHTpHGbGdl4RnjTRK6ftB1lR1A6ZtFlc
	MvQO5rO7VrJGHDBhcHHP8C2cXnuvrtwsU8es5HJlQVAN79TE1YfucD2g8IKT47KsO
X-Received: by 2002:a5d:5f51:0:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47fb1e89ab3mr9574371f8f.13.1785342093792; Wed, 29 Jul 2026
 09:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729075230.743030-1-shanbeeyoo@gmail.com> <20260729120733.829457-1-shanbeeyoo@gmail.com>
 <20260729120733.829457-4-shanbeeyoo@gmail.com>
In-Reply-To: <20260729120733.829457-4-shanbeeyoo@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 29 Jul 2026 21:51:19 +0530
X-Gm-Features: AUfX_mw18Ate4H7RNWrC9_sDszX8h_ptllZ_3py1A1MYtGllTZvUWlrvnw0-9-Y
Message-ID: <CAAhSdy0y-K3_-=_SCDwAqEiCb0PKmNHVcNDgyY+pGGF4N3gEGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RISC-V: KVM: Widen G-stage fault address to gpa_t
To: "Bingyu.Xian" <shanbeeyoo@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:37=E2=80=AFPM Bingyu.Xian <shanbeeyoo@gmail.com> =
wrote:
>
> fault_addr in gstage_page_fault() and the fault_addr parameter of
> kvm_riscv_vcpu_mmio_load/store() are unsigned long.  On RV32 with
> Sv32x4, guest physical addresses are 34 bits, so a 32-bit unsigned
> long truncates bits 32/33 at two points:
>
>   - reconstruction: fault_addr =3D (trap->htval << 2) | ... is evaluated
>     in 32-bit arithmetic, dropping bits 32/33 before widening;
>   - the MMIO handler call: even with the local widened, the handler's
>     unsigned long parameter narrows it back to 32 bits, aliasing
>     accesses above 4 GB into the low 4 GB.
>
> Widen fault_addr to gpa_t end to end: the local in gstage_page_fault(),
> the (gpa_t) cast before the <<2 shift, and the fault_addr parameters of
> kvm_riscv_vcpu_mmio_load/store().  The handlers' internal uses
> (run->mmio.phys_addr is __u64, kvm_io_bus_read/write() take gpa_t) are
> already 64-bit, so no further changes are needed.
>
> Also in preparation for sharing a common struct kvm_page_fault across
> architectures, where fault_addr is gpa_t.  No functional change on RV64.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Bingyu Xian <shanbeeyoo@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_insn.h | 4 ++--
>  arch/riscv/kvm/vcpu_exit.c             | 5 +++--
>  arch/riscv/kvm/vcpu_insn.c             | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_insn.h b/arch/riscv/include/=
asm/kvm_vcpu_insn.h
> index 350011c83581..a5c50dd4a884 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_insn.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_insn.h
> @@ -38,10 +38,10 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu=
, struct kvm_run *run,
>                                 struct kvm_cpu_trap *trap);
>
>  int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -                            unsigned long fault_addr,
> +                            gpa_t fault_addr,
>                              unsigned long htinst);
>  int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run=
,
> -                             unsigned long fault_addr,
> +                             gpa_t fault_addr,
>                               unsigned long htinst);
>  int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *ru=
n);
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29e..28cf9b27bb07 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -17,12 +17,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>  {
>         struct kvm_gstage_mapping host_map;
>         struct kvm_memory_slot *memslot;
> -       unsigned long hva, fault_addr;
> +       unsigned long hva;
> +       gpa_t fault_addr;
>         bool writable;
>         gfn_t gfn;
>         int ret;
>
> -       fault_addr =3D (trap->htval << 2) | (trap->stval & 0x3);
> +       fault_addr =3D ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);
>         gfn =3D fault_addr >> PAGE_SHIFT;
>         memslot =3D gfn_to_memslot(vcpu->kvm, gfn);
>         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index f09f9251d1f0..6506411a3f78 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -371,7 +371,7 @@ int kvm_riscv_vcpu_virtual_insn(struct kvm_vcpu *vcpu=
, struct kvm_run *run,
>   * Returns < 0 to report failure and exit run-loop
>   */
>  int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -                            unsigned long fault_addr,
> +                            gpa_t fault_addr,
>                              unsigned long htinst)
>  {
>         u8 data_buf[8];
> @@ -494,7 +494,7 @@ int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>   * Returns < 0 to report failure and exit run-loop
>   */
>  int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run=
,
> -                             unsigned long fault_addr,
> +                             gpa_t fault_addr,
>                               unsigned long htinst)
>  {
>         u8 data8;
> --
> 2.54.0
>
