Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5B308F07
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136497; cv=pass; b=ovE0KmKaTmhY394fCYsblMpXUrTnVMSDrzsppNIsKCtDSHt+tSy0z9tdE6tjaUKkfMNMoWaHc8mKWuG0OalORmz5QLUABimbSADFHk1X5EY/95n0k5qLeyzSNyGjsnSFfKXS8xwhikMWaoPvtIWHDQ9InpWept3tcltEbrckcPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136497; c=relaxed/simple;
	bh=Oik/azXGay+Dctz7i0M4srzJ6nnZWFQDxd3kWjkKO1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu2lpe3IVmOr7JC9/KOSkvQphFzyg8k7SZuVSJAf8E6AXiYOsisRpOceP6ZnKileRBv9wAIMLJge4Hiql52IMNDlvama4AhV0LU6TSnlZ2Pors8TjSwortfl1ejOvYUuncjau/MGFv9mvecqP6yU3tBtMWxfxYrtNaBeVp0uYn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=aQ1ocKHU; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="aQ1ocKHU"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67c250805ccso315478eaf.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 06:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775136493; cv=none;
        d=google.com; s=arc-20240605;
        b=g1DoIyWKIwDh9OzhKRmzuejssmJsBQhu7k9n7Jc0PzD3+7T0VN68Rqu7rRiwdF8dM8
         hAfK7XAh4H5F/eaW6GEb5XrnlJPTKIvMfk5fq0zaUwQiVQICngcgaYFHEjQFOhl+zF42
         h/ANS5Ri7mLtI4BysQSiMnQumvDuKHeEweQ+I/M2upvkAKvLlXIMCw+V+fgF5xXhtmuM
         hseXpZi0FJD1G1uS3Mx1Zq8F4FJbYqDSEj4fJS35zTyeg/33qPAnb+QnIx04GCKHYvui
         EramkLZv7KA7BrPPH2r7jKnI2J6Uu1VhfeTDvGN7u3Vgk5kctJi78R2n3ayv4p1Dz+Kg
         H3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gwo7+tgUOrb+SJWwjSXGHYxxEG4gJRnUrJiDAJE/ZOA=;
        fh=sQTC1L+yLaIhWqVPDhT4GZDkjpT7eIvkDgoW38hoZes=;
        b=asxmDJrWI4JnEgGiCeXhJ52qacm8mgs4+fPuBYcATJum5AT9Jy6z9+cW/9x+KyaNsY
         +Kq6UVHuzt6Pt7CL0cg5/fFA9Jxm/vIaCCHv9PRLng1KtoZyxzckETfnQR6GrLNfwC1U
         1I5prSPBtkRXdW36a+h3rxA0DtVsgtZ9AKSc8a2eM8V74BYzky+eiKe+o2VSKjVATQtv
         XuRXmxjm52koIcxo3we9y7doNdYgDgR/MKPxdPQi+vNiEDW3FsGETA7iaBGcrhHp6ATM
         Qkad7NM8QUrC3ffS8VVkFO9vIdJ5+gCxxTLDMVTmUp6p8DpJjVIByUgpayTWpt7METUq
         5X1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1775136493; x=1775741293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwo7+tgUOrb+SJWwjSXGHYxxEG4gJRnUrJiDAJE/ZOA=;
        b=aQ1ocKHUkTDm+/LjT1XF12iuoK54ZyCCUaf0GS32mtnyUIB322TY+TDcKCLkNG4uIR
         AN+sdr1+sLW3G4sKWxDSiyuY27z6t5l3DSublwa3sk1QTFxxrye4ADzfGMmxggWO1fu8
         sXL82qGhnAzZAVzsD2svMmVOS8unt6OpSEYKdqhbTsLyz7Pk/YVYLbaxpqYfuJuWBKGx
         aYIDFhO+YzDQW4LOOj+Ksx0mIgb4SpPG5Kwyw+s5Uns1b6ZKzyjhXwBu4CXHJDBB/Xd2
         ohQblxpXo6iqRnl0F+Tg0EhKcQea1atGXGu57897vcnZRtv5lmnLr8/eEMFMKPd9eEgi
         qqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136493; x=1775741293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gwo7+tgUOrb+SJWwjSXGHYxxEG4gJRnUrJiDAJE/ZOA=;
        b=PNcncNicwjdGhuLunBacvp0dZCaECryV2qIn9uXa8NcFUO2MDj0C5RuFTxodu1GuQj
         ucw7lIAmiOL6Fq+Cda3dvuWqsR8VDlUB+bv/Po7UfXgPH3YYVGYcZHNcX6hJZzU2GW4Z
         A0A8ipeUuDRZ9NDbbg78UcYKv3Qhz9JogRCJhWGNPcOxuhMABoP/RJqV823WOzD8B8vV
         CSct0zqnvAthFJJp/PO9th+fy8tDz3uxuP5TtcBWH1dciStPyP/eFrtIpjZUiuPQJHAy
         0ynEvTqjqNTBhuK6DGYdtaR4x9Gu+c0a71lasNSN2564KY+AbKEGniXWcragtOw+T+bp
         MM2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTB3wDjngUI7WxHQ8/BUVdoB8YW/4FjeLPt3bG8ad4qodNMdcvFlEloG//3IJh4jLWhP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyim1sorZX7CzToYCJ7UWO2lFiiC8C6u5VneKiz6EGuebEmgCCu
	8vHL5GDYAOhJs7kC3iovm3LoBnlvQ+fjhnU8eurHVW0KNhzH503nF9JkzXvU6TokY6tgE4sNe5Z
	Eebe0+WUMf6vX718e2vPHCfCdsPoT8wQA1/m+FuGwLg==
X-Gm-Gg: ATEYQzwaHIeIVDxc4t3eS3pbWI5FbF0XAj1f9HQV45K7SEGAYHcM8b+MXNB+5+Rus0a
	sJR/7Qc+C9nCWDwa8gycX/TtqED1L9F8PJlGU+XJXWAoqJfx2ED/k5IRszqNnf2qsn1iske0eyV
	zQqMt4HkwA1uILRscPz6BFZARwN1K5Y404AkYaCeV3HHXclVVZXhaWDwVD9QeX0ur8vSDTc5DD+
	oVRP1tYGP/gDjakkiK2KXkc3c8gNLqLmehIvZIyYyGovXfiN83FceXNs0UN2k61IwmRkDtjBKtr
	nQg5bGHA/7Y+fJcqDA9Tmn/SQTIk7vdMry17i9ObopTsJ45yOiovJrxjiEzuh7GuRTEM9Ap583F
	ICm2uoG7G3qMAqvMoSuFez8tsig==
X-Received: by 2002:a05:6820:2f01:b0:67f:ac08:d78b with SMTP id
 006d021491bc7-67fac08d9a1mr2937060eaf.25.1775136493375; Thu, 02 Apr 2026
 06:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227121008.442241-1-tjytimi@163.com>
In-Reply-To: <20260227121008.442241-1-tjytimi@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 2 Apr 2026 18:58:01 +0530
X-Gm-Features: AQROBzCdorpmHyQHBiu4oSiym1sKMdsAQ59SLSIP6DWXbg54kifkZBvpDdbltSk
Message-ID: <CAAhSdy0M6+1w0FbqzmpQ2gkv4sXgo9+WcbW-TB9mBLvD7=GXDw@mail.gmail.com>
Subject: Re: [PATCH v7] KVM: riscv: Skip CSR restore if VCPU is reloaded on
 the same core
To: Jinyu Tang <tjytimi@163.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:40=E2=80=AFPM Jinyu Tang <tjytimi@163.com> wrote:
>
> Currently, kvm_arch_vcpu_load() unconditionally restores guest CSRs,
> HGATP, and AIA state. However, when a VCPU is loaded back on the same
> physical CPU, and no other KVM VCPU has run on this CPU since it was
> last put, the hardware CSRs and AIA registers are still valid.
>
> This patch optimizes the vcpu_load path by skipping the expensive CSR
> and AIA writes if all the following conditions are met:
> 1. It is being reloaded on the same CPU (vcpu->arch.last_exit_cpu =3D=3D =
cpu).
> 2. The CSRs are not dirty (!vcpu->arch.csr_dirty).
> 3. No other VCPU used this CPU (vcpu =3D=3D __this_cpu_read(kvm_former_vc=
pu)).
>
> To ensure this fast-path doesn't break corner cases:
> - Live migration and VCPU reset are naturally safe. KVM initializes
>   last_exit_cpu to -1, which guarantees the fast-path won't trigger.
> - The 'csr_dirty' flag tracks runtime userspace interventions. If
>   userspace modifies guest configurations (e.g., hedeleg via
>   KVM_SET_GUEST_DEBUG, or CSRs including AIA via KVM_SET_ONE_REG),
>   the flag is set to skip the fast path.
>
> With the 'csr_dirty' safeguard proven effective, it is safe to
> include kvm_riscv_vcpu_aia_load() inside the skip logic now.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>

Queued this patch for Linux-7.1

Thanks,
Anup

> ---
>  v6 -> v7:
>  - Moved kvm_riscv_vcpu_aia_load() into the fast-path skip logic, as
>    suggested by Radim Kr=C4=8Dm=C3=A1=C5=99.
>  - Verified the fix for the IMSIC instability issue reported in v3.
>    Testing was conducted on QEMU 10.0.2 with explicitly enabled AIA
>    (`-machine virt,aia=3Daplic-imsic`). The guest boots successfully
>    using virtio-mmio devices like virtio-blk and virtio-net.
>
>  v5 -> v6:
>  As suggested by Andrew Jones, checking 'last_exit_cpu' first (most
>  likely to fail on busy hosts) and placing the expensive
>  __this_cpu_read() last, skipping __this_cpu_write() in kvm_arch_vcpu_put=
()
>  if kvm_former_vcpu is already set to the current VCPU.
>
>  v4 -> v5:
>  - Dropped the 'vcpu->scheduled_out' check as Andrew Jones pointed out,
>    relying on 'last_exit_cpu', 'former_vcpu', and '!csr_dirty'
>    is sufficient and safe. This expands the optimization to cover many
>    userspace exits (e.g., MMIO) as well.
>  - Added a block comment in kvm_arch_vcpu_load() to warn future
>    developers about maintaining the 'csr_dirty' dependency, as Andrew's
>    suggestion to reduce fragility.
>  - Removed unnecessary single-line comments and fixed indentation nits.
>
>  v3 -> v4:
>  - Addressed Anup Patel's review regarding hardware state inconsistency.
>  - Introduced 'csr_dirty' flag to track dynamic userspace CSR/CONFIG
>    modifications (KVM_SET_ONE_REG, KVM_SET_GUEST_DEBUG), forcing a full
>    restore when debugging or modifying states at userspace.
>  - Kept kvm_riscv_vcpu_aia_load() out of the skip block to resolve IMSIC
>    VS-file instability.
>
>  v2 -> v3:
>  v2 was missing a critical check because I generated the patch from my
>  wrong (experimental) branch. This is fixed in v3. Sorry for my trouble.
>
>  v1 -> v2:
>  Apply the logic to aia csr load. Thanks for Andrew Jones's advice.
> ---
>  arch/riscv/include/asm/kvm_host.h |  3 +++
>  arch/riscv/kvm/vcpu.c             | 24 ++++++++++++++++++++++--
>  arch/riscv/kvm/vcpu_onereg.c      |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 24585304c..7ee47b83c 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -273,6 +273,9 @@ struct kvm_vcpu_arch {
>         /* 'static' configurations which are set only once */
>         struct kvm_vcpu_config cfg;
>
> +       /* Indicates modified guest CSRs */
> +       bool csr_dirty;
> +
>         /* SBI steal-time accounting */
>         struct {
>                 gpa_t shmem;
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index a55a95da5..2e4dfff07 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -24,6 +24,8 @@
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
>
> +static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
> +
>  const struct _kvm_stats_desc kvm_vcpu_stats_desc[] =3D {
>         KVM_GENERIC_VCPU_STATS(),
>         STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
> @@ -537,6 +539,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vc=
pu *vcpu,
>                 vcpu->arch.cfg.hedeleg |=3D BIT(EXC_BREAKPOINT);
>         }
>
> +       vcpu->arch.csr_dirty =3D true;
> +
>         return 0;
>  }
>
> @@ -581,6 +585,21 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int c=
pu)
>         struct kvm_vcpu_csr *csr =3D &vcpu->arch.guest_csr;
>         struct kvm_vcpu_config *cfg =3D &vcpu->arch.cfg;
>
> +       /*
> +        * If VCPU is being reloaded on the same physical CPU and no
> +        * other KVM VCPU has run on this CPU since it was last put,
> +        * we can skip the expensive CSR and HGATP writes.
> +        *
> +        * Note: If a new CSR is added to this fast-path skip block,
> +        * make sure that 'csr_dirty' is set to true in any
> +        * ioctl (e.g., KVM_SET_ONE_REG) that modifies it.
> +        */
> +       if (vcpu !=3D __this_cpu_read(kvm_former_vcpu))
> +               __this_cpu_write(kvm_former_vcpu, vcpu);
> +       else if (vcpu->arch.last_exit_cpu =3D=3D cpu && !vcpu->arch.csr_d=
irty)
> +               goto csr_restore_done;
> +
> +       vcpu->arch.csr_dirty =3D false;
>         if (kvm_riscv_nacl_sync_csr_available()) {
>                 nsh =3D nacl_shmem();
>                 nacl_csr_write(nsh, CSR_VSSTATUS, csr->vsstatus);
> @@ -624,6 +643,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cp=
u)
>
>         kvm_riscv_mmu_update_hgatp(vcpu);
>
> +       kvm_riscv_vcpu_aia_load(vcpu, cpu);
> +
> +csr_restore_done:
>         kvm_riscv_vcpu_timer_restore(vcpu);
>
>         kvm_riscv_vcpu_host_fp_save(&vcpu->arch.host_context);
> @@ -633,8 +655,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cp=
u)
>         kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
>                                             vcpu->arch.isa);
>
> -       kvm_riscv_vcpu_aia_load(vcpu, cpu);
> -
>         kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>
>         vcpu->cpu =3D cpu;
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index e7ab6cb00..fc08bf833 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -652,6 +652,8 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu=
 *vcpu,
>         if (rc)
>                 return rc;
>
> +       vcpu->arch.csr_dirty =3D true;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
