Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792646390;
	b=bkktYozmP6ZCGNnLVymDsmWA4Af0gEWz4OS1z4OL1t90s0tK/jcR2BG0I6VUt0xU139y
	 mJw7fY3rL3AXiM6Dmme/O3u3dNyraPzIghNtgfTggzSm/YX2KfcTUZGrFTjcSSZDOW/8+
	 KjEj7GLR8cd35NK2KDjsrNMJ7k1oCUJ5F68CLDPucM3odkJE7k6Jgk3jkDeqChgp1DSqy
	 mswqh8KVoAM8hgXhtnYXusbSRpZAw9PEVDNpTXF/COQlqbS5zoL3J/QlTF6aFbmnTG4hd
	 XbQI4qpwjbp8uh/uAnDzOLC6maMABKtei5NVGPWgTNXJoKfZtdxB48nNqHzY3DKxf9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HapPLVnPKNTi6siBORLQtk0Et4KzisGv9gkCpxoyz80=;
	b=4g2XIR8vdC8R5gUpNyDeHbmIMuIf+t/+FoccpKrGPWqlNay1qx93jzijls7r+5m1Cr8O
	 HIyAHShHmsUu0skly3TWEB7DGyXW7/wWnUZuUB5PFUJTgUFo/i3ky+bIDI5tp3FPzqZQw
	 FbjUNepFoyIEA3SUwBp2v+YdW8QZjHLh0AhWGpYeB6bgru3i3Ecm3kENaLmSvcZWdaBWa
	 JSVWviaquYyx1iLMLVDFPTEqNf7ZXl1FgYwCWVg+MTsTwwhquGbJyiij2ZtFw0CHcZpVH
	 hQ2RidPvpJFyNuvuHxaiYpYMx9mWQQBQO7ci4iaIve10htXZKXknlUx7U0xr1elJg2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=bpvgaLo0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1B606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 05:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46E1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=bpvgaLo0
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48df54150dfso852756f8f.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 22:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792646388; cv=none;
        d=google.com; s=arc-20260327;
        b=pAGp5xjSZkvuJdaClGfWvjrBd08xWqcWbOSLlio3fCplAkUzSv6rw9bRjMG5rqNPPo
         6dsFmMUR88NIDSUqxMbpLWILt7lWyltkzptRSC6KDfzaopNPLSSdQBewmKhKDig8ZrwI
         8j6ZIinYwCGjTyS8SnZAwbDllfvzo/IGYn6piw77uQNyUOR09AOP66Zx/G5KaCK4qG65
         Ewuj5z7shjuMlmLBvQBunwMG+q31L6+xYm6aIMxLetpnJ4WMwEA4a0vITToG2JW8DaOS
         +ZX69iQbUtWr/hwZXuxXMySPQsoP6bTY43pRNpOKuIusDHNqYc7eex/PX4km9O8vjKNh
         kV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HapPLVnPKNTi6siBORLQtk0Et4KzisGv9gkCpxoyz80=;
        fh=VXrXzFxdK0nf5Gvj7PeZ7EseYmVgHnulw9CJHda5V2U=;
        b=TUDmHIzW+sa832ArXL3lTIXn6fw5b9TCPVPwlV6lzkwq3gT63YvJQ2F9j5f6gEGEbA
         VTSzGwkNMWrybknhvOhdzxz03MhmeypFXhEOy+YkWb3mqJc94UlqnF+RK1usjqR1VOxL
         7tpzQtDmxThQvbw6uTqm31JKOGwzCGW4Ip08hyTDuTvfde4iCAJHxTPnbxQRCnCtKAf/
         Rco8meXJTI+wn51rUAT0kd55mu+HV2H97Ih5QsTcidSaGsrXCsmaAGktGFcmkPN7SU/H
         hHYc8JtrFaCrnbeaBObp3E4RETBfDR8Z2UpK1gBTohwj3hJdN8F4YUWIAx86VbPFmKpn
         lbMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1792646388; x=1793251188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HapPLVnPKNTi6siBORLQtk0Et4KzisGv9gkCpxoyz80=;
        b=bpvgaLo0EQp7fNdSdcNKNCyKGKrzEpifTwKSvwIRk/Mms67mZ/3ySVHVjUJUBZilgv
         rVN+Dr8FWdveH13hSpPijVXN2HbRnv/MYc1zMvdxdUyw6uGQSF0TokMlXxoaBajC/5mj
         2rEHCg2ymfeiiHdHejyIxqJGSg0HXzykisjRyqBS5mc45GuuPsAVOzF9fskG56Wi0/vQ
         m1LLxZRIOzr66Wzo/Lx+EHFTcY5gM4o5SrJIMChjKfixgQxtfkrjckENzyjkY+N6A7to
         TFIu/CsnY5dOYhtX2LDOyWQRPt2PvEWXWDpgC5VapC0Q3iNeLsSpj4Xvh+o+PbUbv8KW
         qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646388; x=1793251188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HapPLVnPKNTi6siBORLQtk0Et4KzisGv9gkCpxoyz80=;
        b=slFCO1vz5CHvjE1/HauKAZVXUCtACtfcZgYeYUQdKxLKTepPtEh0PPtywE3PBge0Bi
         DFUqfue9WYjhwGtzX4+uqVZAo95Rd3J9SKUvEnF/vTNAA+yviUYFkRWGm4Fj/4fBIJnc
         5+44xPiTajZ+cUVs9mW9nVvDURLVK/FYQ8oKVg8VQfiPifaX1/8TIp5DDr5eegosQi1P
         AcFgNeYjL5ETjKAKa/+M6m2FD8icYdaxYqkAtzcoBrCdDGw45kOspsU7sI3VFwN8QGWU
         Noa9sTiO5eZ50IW3oQ3lgW6c/YSWqd6yBG66Nrbdylxs3p6P7kPxptqypHq+PEbopL0L
         LpxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxL/RCt/6EjRV55geftfOn/Y8Tij7IU838CjgYS3HwAwgkG8y+APxqOPJRaAVfoPsOfCgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvyqgCpYt1Hp6roQwxOcPgbrvPFPxP1y6OyUGPvICBNm6CIhsh
	uNtdlDLGegUsU0Bm8FSpWSdFNYT/g0/6XRT12edIQXrUSfMrkOrvyg78we2smUKUaHvsqRMJ5Ah
	qldxboGKzUaW6Bwp6MCeQhGax0Zi8JK5gCu+tKiP5pw==
X-Gm-Gg: AYBFou30LqmtNAywIuxvqzG+b339wQPltQsYO7huCZtDtesxVvLiWa8xgPbtT2FtXyt
	ubDtVLTOgK4Bw2UUaiy7suYKGCL99dq+zC/Q0tv5AtMkxkMDr1W/nzDxTF1cjLbUFNPn2iGSOOE
	UIVMmCJlTHwdhBYpwkEuNy8dH3Px6eakOTcQhOcyAAizuMGH5qlhwpRi1u9kKwqEvdXbFB18UeL
	R4+DcQbnXPxTS4SybxHVQUlaI/Wb2KOoO+CSOCK8Ko31p3POLys1TeVjAoK527FYOKvl4jQbB+p
	n9DMgBIrV9bVchRRU0bWtw8MohqL/0C6tMVKUy6F8dotzZmebaiRVyUZKAt9tVis+j4AznUmthn
	2W11YvmVmvMhI7C0YQle9iZ2PKul5EIxF1vYncy2hCzoL2lMmCSAxDgwFwibFa4VWufaxWSPbQ6
	SScd6MOo+Tag9suS4wpOmf3Z2ZsFFKdBUYss3OjpsvmdQnWdEJ0+3vNKpl
X-Received: by 2002:a05:6000:2312:b0:48d:fa9c:7838 with SMTP id
 ffacd0b85a97d-48e2644efc7mr9279274f8f.2.1792646387426; Wed, 21 Oct 2026
 22:19:47 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Oct 2026 10:49:35 +0530
X-Gm-Features: AclHuK8p_QSaWeBtSoMEm3xKUDsy3StFk9vUIaP-8tnRvRCPH9rhzXhcbhlL-gk
Message-ID: <CAAhSdy1gh64bxcg_OpdWpCwHj3nb0V2Ub0AYXNeSOCnq08=o4g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use a raw lock for IMSIC wakeup state
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 9:21=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> kvm_riscv_vcpu_aia_imsic_put() can run from the scheduler preemption
> notifier while the raw runqueue lock is held. Taking vsfile_lock, an
> rwlock_t, there violates the lockdep wait-context rules.
>
> Protect the CPU/HGEI pair with a separate raw spinlock. All updates to
> that pair retain vsfile_lock and take the new lock, while scheduler-out
> uses only the new lock around the HGEIE update. This keeps the wakeup
> setup serialized with VS-file publication and release without bringing
> wider IMSIC operations into a raw critical section.
>
> Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC vir=
tualization")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

I have renamed hgei_lock to vsfile_hgei_lock at the time of merging.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/aia_imsic.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index c1af23e79ae0..1ccb7eac9f45 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -48,6 +48,8 @@ struct imsic {
>
>         /* IMSIC VS-file */
>         rwlock_t vsfile_lock;
> +       /* Writers hold both locks; scheduler-out only takes hgei_lock. *=
/
> +       raw_spinlock_t hgei_lock;
>         int vsfile_cpu;
>         int vsfile_hgei;
>         void __iomem *vsfile_va;
> @@ -582,6 +584,17 @@ static void imsic_vsfile_local_update(int vsfile_hge=
i, u32 nr_eix,
>         csr_write(CSR_VSISELECT, old_vsiselect);
>  }
>
> +static void imsic_vsfile_set_hgei(struct imsic *imsic, int cpu, int hgei=
)
> +{
> +       unsigned long flags;
> +
> +       /* Serialize the CPU/HGEI pair with scheduler-out's wakeup setup.=
 */
> +       raw_spin_lock_irqsave(&imsic->hgei_lock, flags);
> +       imsic->vsfile_cpu =3D cpu;
> +       imsic->vsfile_hgei =3D hgei;
> +       raw_spin_unlock_irqrestore(&imsic->hgei_lock, flags);
> +}
> +
>  static void imsic_vsfile_cleanup(struct imsic *imsic)
>  {
>         int old_vsfile_hgei, old_vsfile_cpu;
> @@ -596,7 +609,7 @@ static void imsic_vsfile_cleanup(struct imsic *imsic)
>         write_lock_irqsave(&imsic->vsfile_lock, flags);
>         old_vsfile_hgei =3D imsic->vsfile_hgei;
>         old_vsfile_cpu =3D imsic->vsfile_cpu;
> -       imsic->vsfile_cpu =3D imsic->vsfile_hgei =3D -1;
> +       imsic_vsfile_set_hgei(imsic, -1, -1);
>         imsic->vsfile_va =3D NULL;
>         imsic->vsfile_pa =3D 0;
>         write_unlock_irqrestore(&imsic->vsfile_lock, flags);
> @@ -727,10 +740,10 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *=
vcpu)
>         if (!kvm_vcpu_is_blocking(vcpu))
>                 return;
>
> -       read_lock_irqsave(&imsic->vsfile_lock, flags);
> +       raw_spin_lock_irqsave(&imsic->hgei_lock, flags);
>         if (imsic->vsfile_cpu > -1)
>                 csr_set(CSR_HGEIE, BIT(imsic->vsfile_hgei));
> -       read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> +       raw_spin_unlock_irqrestore(&imsic->hgei_lock, flags);
>  }
>
>  void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
> @@ -747,7 +760,7 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu=
 *vcpu)
>         write_lock_irqsave(&imsic->vsfile_lock, flags);
>         old_vsfile_hgei =3D imsic->vsfile_hgei;
>         old_vsfile_cpu =3D imsic->vsfile_cpu;
> -       imsic->vsfile_cpu =3D imsic->vsfile_hgei =3D -1;
> +       imsic_vsfile_set_hgei(imsic, -1, -1);
>         imsic->vsfile_va =3D NULL;
>         imsic->vsfile_pa =3D 0;
>         write_unlock_irqrestore(&imsic->vsfile_lock, flags);
> @@ -861,8 +874,7 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *=
vcpu)
>
>         /* Update new IMSIC VS-file details in IMSIC context */
>         write_lock_irqsave(&imsic->vsfile_lock, flags);
> -       imsic->vsfile_hgei =3D new_vsfile_hgei;
> -       imsic->vsfile_cpu =3D vcpu->cpu;
> +       imsic_vsfile_set_hgei(imsic, vcpu->cpu, new_vsfile_hgei);
>         imsic->vsfile_va =3D new_vsfile_va;
>         imsic->vsfile_pa =3D new_vsfile_pa;
>         write_unlock_irqrestore(&imsic->vsfile_lock, flags);
> @@ -1112,6 +1124,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *=
vcpu)
>         /* Setup IMSIC context  */
>         imsic->nr_msis =3D kvm->arch.aia.nr_ids + 1;
>         rwlock_init(&imsic->vsfile_lock);
> +       raw_spin_lock_init(&imsic->hgei_lock);
>         imsic->nr_eix =3D BITS_TO_U64(imsic->nr_msis);
>         imsic->nr_hw_eix =3D BITS_TO_U64(kvm_riscv_aia_max_ids);
>         imsic->vsfile_hgei =3D imsic->vsfile_cpu =3D -1;
> --
> 2.43.0
>
