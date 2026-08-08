Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5963A9861
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177360; cv=pass; b=on29lXSJfcep8iqioXu7ZPEMkNDLPffw0Wt/EHkBywwrPiyqPqm4xw84alAjhayG1Kb1uvZfUF/nffUJI4bwtZTG+tXHqz3sRuslyKywrP1gHi+YYJ0CI+wN2yoUSU9nqKVF6Hnwu/S4uFWlWK4I4R/OktnG+jiEBe4BCClJ71Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177360; c=relaxed/simple;
	bh=xgBjcAMTO+mkQsReJ9SuBjgGpg5+u8EJXDIoPPcaBc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr6a8fWxQLXQdE/m0thP1ZTh0aCHS+chISqN6xh2YgQ4qckAFtjtN7XZ1AxcmnRaKYtnLd0KL8ak3T9JUfQsoKHrtAVIUocVBj/wEy7CqCB7eyBpc2zEmHWt7fJkoOaDW4nwFBC8XbS+3G6Y3bKu6usLZf64B20oy0YM2FxGUY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=JDwVlDRK; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="JDwVlDRK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f96c5b722so127378f8f.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 01:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786177356; cv=none;
        d=google.com; s=arc-20260327;
        b=NFHANLUzRNuuqYKchcOlj7Mxz71FpyU6GDxkE5WqHqMOJSNUGnAcBZY0wYng/vlbVg
         oo5anpBKhBFXM8mekte4QSwyXA6kxQr333NI8lgJ9bl/b4KTfLTHAYbRAp8zOar3Pd6X
         9AbvHF4uPObdaiJfU4XgCTyxG9vC/VZma6lSbQBu847z+/H59XewgYPr0J6W0bl9A6uW
         gE2V3sqifjQQse69C+eWhN1BsxMgp0iVwNSchdfElIuYNkRwL1rtU+x86aVzJUxP1Tg+
         XOLmbyVmvULyHiglq7WQTOjE8zhdesL5jlfwizBaa5daAt4obp6ef8FJIWf2zQTVwfPC
         BDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2L3p/EqCy6vKn+Ri732A5tGrVw5OVSAOMt2d+I2tL0=;
        fh=Goetz5TAWZiXHtfFANmlMBsb72U3/mhjxLLNAePrLaA=;
        b=VHl/sDgapPd56oPhOn7Guft5Xon6Ij7W8kVxFgfDFpfYQ6z3iQ87at0ea361FwvSN1
         xCxP5x0IfjzHUPjLof+SGLOrQEdtHhEmveQ9qrueFaRV5c+PcwvfSjwHj1pDe4ZFHB8P
         1t1s2bhNkAKqRhYft8fldCG/cgOM8Zn56OcKDgMy3tyHdNfs9fNSOwlHOHnEiz92XniY
         RyXXk8WHvsKzyu+Gh7wLBfEptm6I3ygr3zYmH1r1AORKd663LobVKAl82wu/jSLYYCQ7
         yfAE/4Mtln70daPRxg8PIfB12YcITZ+uVFxeWAPwvbL6ZYUU0B5x0LGezLDCGBhQ+rGu
         wuYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786177356; x=1786782156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2L3p/EqCy6vKn+Ri732A5tGrVw5OVSAOMt2d+I2tL0=;
        b=JDwVlDRK/7fbsNLqD3XswNOJWhgBkP1An2rkVOEHYb9/h1YAJsqLYwqEX8OAEdSONV
         Bd5ll926FNzXl/owKFNoIBzN69AwQK4XlRdl1aYWWds6kk+JuNVLHqhP5e6S4wGAWCwi
         6MRgubgpPJD/uMxVYAyPmsHr/PRIB56bEjllclc+zCojzjBgzs+mjqagKuczrU8/bSNs
         39xYMkO2TIeML+kv0uJF1BAXmQA7TlaWC/ym8PhNnGNS60fBzoTEfJGM8ZR7aVJOqz8j
         d48s9qTYx7GwSqeRGecGbdxuQdEZlADXWJIprDbe66cME7dJN0GPTdyWFYNYKDX2F309
         nSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786177356; x=1786782156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2L3p/EqCy6vKn+Ri732A5tGrVw5OVSAOMt2d+I2tL0=;
        b=csceluByuypn8q+2gMA8BGPEHwTGfjwky6oO2/IygOXEvmy8X2VQbKOOIe5RW/71WD
         efV32j/u19EJ5pG9azOSS2EiHsvpl9TMTF5YOdQpJKaqtOfTqZKrO5tXDV5gvc0sL34r
         J9yTtHyZKpt5xCZv77G9fhX6DdeqnYQj3JKPSp+j7eytRTmLMZX3BuQo4/za8bHZeYF+
         Y27IC1X3ElZrTcnB5PkOSUQlu7MsfhgN37w0EGJNY0CCZKoASKuE4vRTnrG6Cn9SfjM9
         DrBsRD5oqdAWsQiDbRzWIezKLOJUXhnPUsmQJL/eHo7n6BS5p73xphr4qtq1dcEjfV/i
         L/xQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5NOFRN+KXjWRlbkxFdVxnU/Wh8TpxWNkmLoYPNMHEdQrGiafKcbXn2CQfFNxEs/Keups=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAoXjRtWTjzUKoMQWwGFbIZSLGv5PrsAZpaba5ZO8nifkJQoK
	OUZlQRPT+23Ifj4fwcEmRrJdoTUXtMLVrgJ1MT0BWbhVezy52MoM4NUuwO3ADINofrRk4IeFgWI
	Bfn6qBlYbrGjWTtwAVgxut2xx5+RtzslBlrJxoEbUUw==
X-Gm-Gg: AR+sD11YTZP8hFXUFXp/ZJZH5SpIMRsBOgwEAlGZ+h9K0tfA7om8ou4ytuftPGk4rsV
	ak7H8clw9CyVIzVc9v/z3PZdnB2XlHrPQSKVAU+sw4HEUhIrUyQjj0aignEKECUgTNVxk+ke8lp
	OS1Z2U1NDOs6/G33BJ8LamGZE/1s2t+WyA6GKvO99kuogSV5Wsnfw21f6hKyhE5tzKRsKjkAgOe
	u7FSkyJPCWOdZ66Y6xt5TrMmVbm1KTjYR36JMGyogkEi0ncPlvnZOaCKYs58c4W6ZdHSszkvaYh
	KSLd8Xe1Egsc71rRpD9wzdeEwX6xX1UIWbKPMWRR864QIXOdyL2jhJ4Ay/Yn3ZuqULI7/lNVvz8
	KruKwZVelm3rvIGn04ydxPNyLJNPJfMYCx3YUZa9CkDxsDr+IE0fYmAp1EVY/22Ap
X-Received: by 2002:adf:e002:0:20b0:47f:f339:556c with SMTP id
 ffacd0b85a97d-47ff33959f5mr27501389f8f.2.1786177356036; Sat, 08 Aug 2026
 01:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718040000.008.17bfd3bd-caplitmus-rv@iscas.ac.cn>
In-Reply-To: <20260718040000.008.17bfd3bd-caplitmus-rv@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 13:52:24 +0530
X-Gm-Features: AUfX_mxNG1tt1AmOEVTtXoJ_7yBrPPTk9SVnD337B0nLADfjKaRqhoY00y6bj34
Message-ID: <CAAhSdy2J9ZAeNPPHcdyjjVs_ZLFbVeSjVXQ-nocmai0xyt0TYw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Guard HFENCE range loops against overflow
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 10:08=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> The local HFENCE range helpers build the loop end with addr + size and
> then step through the range by the requested page order. If addr + size
> wraps, a small range near the top of the address space can be treated as
> empty and skip the intended fence. The final loop step can also wrap
> before the loop condition is evaluated again.
>
> Treat wrapped ranges conservatively as full-range HFENCE requests and sto=
p
> each bounded loop before the next step can wrap past the computed end. Th=
is
> keeps the existing large-range fallback and only changes local GVMA/VVMA
> range construction.
>
> Fixes: 2415e46e3a9a ("RISC-V: KVM: Introduce range based local HFENCE fun=
ctions")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup


> ---
>  arch/riscv/kvm/tlb.c | 71 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 993b25ea94d67..b0c83e3ccc15a 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -8,6 +8,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/smp.h>
>  #include <linux/kvm_host.h>
>  #include <asm/cacheflush.h>
> @@ -24,7 +25,12 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned lon=
g vmid,
>                                           gpa_t gpa, gpa_t gpsz,
>                                           unsigned long order)
>  {
> -       gpa_t pos;
> +       gpa_t end, pos, step =3D BIT(order);
> +
> +       if (check_add_overflow(gpa, gpsz, &end)) {
> +               kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> +               return;
> +       }
>
>         if (PTRS_PER_PTE < (gpsz >> order)) {
>                 kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> @@ -33,14 +39,20 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned lo=
ng vmid,
>
>         if (has_svinval()) {
>                 asm volatile (SFENCE_W_INVAL() ::: "memory");
> -               for (pos =3D gpa; pos < (gpa + gpsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gpa; pos < end; pos +=3D step) {
>                         asm volatile (HINVAL_GVMA(%0, %1)
>                         : : "r" (pos >> 2), "r" (vmid) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>                 asm volatile (SFENCE_INVAL_IR() ::: "memory");
>         } else {
> -               for (pos =3D gpa; pos < (gpa + gpsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gpa; pos < end; pos +=3D step) {
>                         asm volatile (HFENCE_GVMA(%0, %1)
>                         : : "r" (pos >> 2), "r" (vmid) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>         }
>  }
>
> @@ -52,7 +64,12 @@ void kvm_riscv_local_hfence_gvma_vmid_all(unsigned lon=
g vmid)
>  void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
>                                      unsigned long order)
>  {
> -       gpa_t pos;
> +       gpa_t end, pos, step =3D BIT(order);
> +
> +       if (check_add_overflow(gpa, gpsz, &end)) {
> +               kvm_riscv_local_hfence_gvma_all();
> +               return;
> +       }
>
>         if (PTRS_PER_PTE < (gpsz >> order)) {
>                 kvm_riscv_local_hfence_gvma_all();
> @@ -61,14 +78,20 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t=
 gpsz,
>
>         if (has_svinval()) {
>                 asm volatile (SFENCE_W_INVAL() ::: "memory");
> -               for (pos =3D gpa; pos < (gpa + gpsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gpa; pos < end; pos +=3D step) {
>                         asm volatile(HINVAL_GVMA(%0, zero)
>                         : : "r" (pos >> 2) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>                 asm volatile (SFENCE_INVAL_IR() ::: "memory");
>         } else {
> -               for (pos =3D gpa; pos < (gpa + gpsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gpa; pos < end; pos +=3D step) {
>                         asm volatile(HFENCE_GVMA(%0, zero)
>                         : : "r" (pos >> 2) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>         }
>  }
>
> @@ -83,7 +106,13 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned lo=
ng vmid,
>                                           unsigned long gvsz,
>                                           unsigned long order)
>  {
> -       unsigned long pos, hgatp;
> +       unsigned long end, pos, step =3D BIT(order);
> +       unsigned long hgatp;
> +
> +       if (check_add_overflow(gva, gvsz, &end)) {
> +               kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
> +               return;
> +       }
>
>         if (PTRS_PER_PTE < (gvsz >> order)) {
>                 kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
> @@ -94,14 +123,20 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned l=
ong vmid,
>
>         if (has_svinval()) {
>                 asm volatile (SFENCE_W_INVAL() ::: "memory");
> -               for (pos =3D gva; pos < (gva + gvsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gva; pos < end; pos +=3D step) {
>                         asm volatile(HINVAL_VVMA(%0, %1)
>                         : : "r" (pos), "r" (asid) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>                 asm volatile (SFENCE_INVAL_IR() ::: "memory");
>         } else {
> -               for (pos =3D gva; pos < (gva + gvsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gva; pos < end; pos +=3D step) {
>                         asm volatile(HFENCE_VVMA(%0, %1)
>                         : : "r" (pos), "r" (asid) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>         }
>
>         csr_write(CSR_HGATP, hgatp);
> @@ -123,7 +158,13 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long v=
mid,
>                                      unsigned long gva, unsigned long gvs=
z,
>                                      unsigned long order)
>  {
> -       unsigned long pos, hgatp;
> +       unsigned long end, pos, step =3D BIT(order);
> +       unsigned long hgatp;
> +
> +       if (check_add_overflow(gva, gvsz, &end)) {
> +               kvm_riscv_local_hfence_vvma_all(vmid);
> +               return;
> +       }
>
>         if (PTRS_PER_PTE < (gvsz >> order)) {
>                 kvm_riscv_local_hfence_vvma_all(vmid);
> @@ -134,14 +175,20 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long =
vmid,
>
>         if (has_svinval()) {
>                 asm volatile (SFENCE_W_INVAL() ::: "memory");
> -               for (pos =3D gva; pos < (gva + gvsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gva; pos < end; pos +=3D step) {
>                         asm volatile(HINVAL_VVMA(%0, zero)
>                         : : "r" (pos) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>                 asm volatile (SFENCE_INVAL_IR() ::: "memory");
>         } else {
> -               for (pos =3D gva; pos < (gva + gvsz); pos +=3D BIT(order)=
)
> +               for (pos =3D gva; pos < end; pos +=3D step) {
>                         asm volatile(HFENCE_VVMA(%0, zero)
>                         : : "r" (pos) : "memory");
> +                       if (end - pos <=3D step)
> +                               break;
> +               }
>         }
>
>         csr_write(CSR_HGATP, hgatp);
> --
> 2.43.0
>
