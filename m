Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023A3ACF16
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859212; cv=pass; b=F7BStwLDRlE+edCD811X9fx5U1QUdDiISluxBvq50kB597b01FKW3vR+tHKnVFk13Ex9gejoVR4z0rxyKfoVy9RM18e+tIdj4ry89K7k+/2/1YE+GAhN+8l4XAFzEwK0QFD1Xbgv09zY03LoymZBwRqd+AfZQBs7LA3GxzYRI/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859212; c=relaxed/simple;
	bh=xeABj9Q9+uze/Q8D/nPpkuTVaAaU0qpqyihPsjSHTbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR1N6XzH96eukUfESJ/bTN9I4B443eoyPbcnbNsTGg2tbONRUf6tVhlkw01inlVPgslARcYb+CE3DQfCsH8Xr2YJnIZQe69e2SLRHyxaBAdsYpr5/sJdC2Cc5XCN27KyeWuH7TDfsXl7lpXkMuKhGsHbmDR5upqDlVy0B9mslLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=K5EuU9OF; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="K5EuU9OF"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso2307368a34.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859210; cv=none;
        d=google.com; s=arc-20240605;
        b=gZ2j68YBIV2MxfmkC2LTwWREzcuiSfbY3+/Lg2fmrE7Lk4N4z8X0pgIYcAY/Qf9R8V
         g91O+L83U1CdZ+9xCW0ecbHeMK2AMc1HkORdOidc53gPMli/JUmoh8f9zKTcm3xwgE7+
         cimsOscRxda49Np2UO6hiXSIfL9KjIozJN+wVTAgG3WDsoR9C34BONWJgazxqPbNN/tr
         hiXfLWQCA+dSkMbyF5XAXAH8kf2BBT3xRSFJGj6Yu2wDy+JNxDTZFiGzm5kS1FcNaoox
         hbT8Q+j/+9Z0hgcy1Dg1ZqakVj3TPd6a4o9E2owaMmyE70d+jA+Ib1gUGRNnVv0Mb14I
         1ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qm+c0B0VghS5x1igpBlA8KgdD3cjShXIS4o/gceuxM8=;
        fh=TqF6DCXrQcN/90lIZ/fnZ+fpQINAr+yQV66QcPF3CVY=;
        b=LBgZ9IDAYoIz0DEQwLDUjV9iI9SiivINjrCYRQ4/xiW6TQMogXseSIMHroy9Ml8wFE
         JQKxWP++sdVU51ww2wXEbZ3dOwN8CowMRUOY+VgSp7RR5NrzBzNceWcgbBdOpeF/xiRq
         RWqw5UbUA/aYwZFeOk9Ra63X3OuDSFaucaCARNPYO9Y7R9sWQ2DfR/aa0eRyKVeJQnNZ
         AAOBndKozZMNSbPQ+cuuXTJbW5FGA98lpuEm+50w+Z2Rm8i4NVfHeU8HhsskyYZXG8O/
         +mBRgjpCo7XGuGJnDFh5+0S3gLHh3CJURwH+w8TzMyQE/2LuiDbQNotMARyMuokcB2qc
         mFPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774859210; x=1775464010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm+c0B0VghS5x1igpBlA8KgdD3cjShXIS4o/gceuxM8=;
        b=K5EuU9OFJQS832FMAhb3ihjbGCQVIUw843pv6+XZk84vnWfBJ6Qj2635sLbxY27gz7
         b9ocAxSlnaCbVQSVfcXJ/zMDl+jNJifQ6q+DGBCXzimowYw4yNRkGf8ANnEu3pO9CfZC
         vYGbQ+VNYT/GFE88/c2Wz01TRIYw2RYZ42tuvHuHySzBeMktxe1ikBzbX2mz9EmJ0S4i
         u33uwHZYoy2tdOs0S8z07/rXHCoHK7+5mXy1LQ3Foh0SYk97TlXFo241+YEdYx9Ha6IX
         e7wIR67IvRJd6LzwKLhqCdT5PeshiGx5HyzNYAQa+2t0O2qup+d/3WWUvQ/9GkKAB8q3
         AZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859210; x=1775464010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qm+c0B0VghS5x1igpBlA8KgdD3cjShXIS4o/gceuxM8=;
        b=QJf0S540SDfa8xm0QP0gZXK2Mb6Fjzu0Yf5ns1h8qfCR3Qn57Yie5q18gmM/M75TmH
         o4y/81MzV9DRNVRXXKMA3ahWz/E6R222/bQ8XV95z+32MFa495lYSTFKhgTtjpx+d+Q2
         eLOLlgSPSejRRdY7plu8b+WT6oIYKI/qGx5L/JzPh7kAQP9zQrWZ4/7zB7U8NF4bgV8b
         zcawUvb1p14q2heyFdkspHVFUg75jCOIczbk3sZwLuNKjPj3i6aVIgOaEgVBo4Ruf2z8
         iT31fdxBKHErHUxCfx31lFiqG0yFCqBKGDrXvFxUfXuXM5wY1wwoL3BbGnsxIGgOv22j
         6VgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHpqxpPSSAp7ohV5x278hML9FKqkSxiNV4dAW/q1zammNisw9SyKC0dUDeEJISAKrKnYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85zjPWbqVvIbDTwwzE1bmsHzVZNVillRtQFkjtvVCsltw4laP
	W5JfnN2EIgHQoUMwm1ta0ip5VOCUKLH6uJTPKs7mpyEXqwRoEIuQLFTyEkfilqLEsjuq1WEpbGo
	7DiU2BCLEDED6S8rt6/+Y/obhRB03nldxNdfosgxQgg==
X-Gm-Gg: ATEYQzyyXhSD7fOFLNSehLzON/l2GcXM4nAJ8RrhtfWt9m8LtDb/Ern+dJd5PhOdv+J
	HlzB0kYQEcb0cGuDSgbTpCuiSZGJh77IHAtqHjn8AIoiViRZAnlS7reOXYcm449YlAKMrKf7jfq
	8eJpC4F/b2LQGaXp+sCkbStrHJynbU+VRTXwVRJckmIjmxeBhEwRkEYSUihMvQ6Z8g9dqxAYvdK
	HzxwuCbKvpB79j9ohjbpuyM5eAiRfwY1Xr7znbWMtuN1IYiHUaKVQK1IjIPHFY9S1grh6mvoMPE
	Jg50Bf0GrWmnmAwW/931c03ooXrpuswoqGMvEXqP7XA8a1scay3SJc+IN5qsveH2EZOvcZpaVpO
	WlKiZCbx5bdImjicC4etWY+3yjg==
X-Received: by 2002:a05:6820:81c1:b0:67e:294b:726b with SMTP id
 006d021491bc7-67e294b7605mr3423411eaf.40.1774859210004; Mon, 30 Mar 2026
 01:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260318092956.708246-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 13:56:38 +0530
X-Gm-Features: AQROBzAttgYdkDk6vZa7Y9rWU3gasICclOjTZXUHJQOVCZXeCVLUqT-WwqE4H2U
Message-ID: <CAAhSdy01NHCwXRXMkpCrYSLpdApB5EC4kU9qig3q2KD1K34Atg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix double-free of sdata in kvm_pmu_clear_snapshot_area()
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Jiakai Xu <jiakaiPeanut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:00=E2=80=AFPM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> In kvm_riscv_vcpu_pmu_snapshot_set_shmem(), when kvm_vcpu_write_guest()
> fails, kvpmu->sdata is freed but not set to NULL. This leaves a dangling
> pointer that will be freed again when kvm_pmu_clear_snapshot_area() is
> called during vcpu teardown, triggering a KASAN double-free report.
>
> First free occurs in kvm_riscv_vcpu_pmu_snapshot_set_shmem():
>  kvm_riscv_vcpu_pmu_snapshot_set_shmem arch/riscv/kvm/vcpu_pmu.c:443
>  kvm_sbi_ext_pmu_handler arch/riscv/kvm/vcpu_sbi_pmu.c:74
>  kvm_riscv_vcpu_sbi_ecall arch/riscv/kvm/vcpu_sbi.c:608
>  kvm_riscv_vcpu_exit arch/riscv/kvm/vcpu_exit.c:240
>  kvm_arch_vcpu_ioctl_run arch/riscv/kvm/vcpu.c:1008
>  kvm_vcpu_ioctl virt/kvm/kvm_main.c:4476
>
> Second free (double-free) occurs in kvm_pmu_clear_snapshot_area():
>  kvm_pmu_clear_snapshot_area arch/riscv/kvm/vcpu_pmu.c:403 [inline]
>  kvm_riscv_vcpu_pmu_deinit.part arch/riscv/kvm/vcpu_pmu.c:905
>  kvm_riscv_vcpu_pmu_deinit arch/riscv/kvm/vcpu_pmu.c:893
>  kvm_arch_vcpu_destroy arch/riscv/kvm/vcpu.c:199
>  kvm_vcpu_destroy virt/kvm/kvm_main.c:469 [inline]
>  kvm_destroy_vcpus virt/kvm/kvm_main.c:489
>  kvm_arch_destroy_vm arch/riscv/kvm/vm.c:54
>  kvm_destroy_vm virt/kvm/kvm_main.c:1301 [inline]
>  kvm_put_kvm virt/kvm/kvm_main.c:1338
>  kvm_vm_release virt/kvm/kvm_main.c:1361
>
> Fix it by setting kvpmu->sdata to NULL after kfree() in
> kvm_riscv_vcpu_pmu_snapshot_set_shmem(), so that the subsequent
> kfree(NULL) in kvm_pmu_clear_snapshot_area() becomes a safe no-op.
>
> This bug was found by fuzzing the KVM RISC-V PMU interface.
>
> Fixes: c2f41ddbcdd756 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
> Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>

Queued this patch for Linux-7.1

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b2..ac1b9a91a19db 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -441,6 +441,7 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_=
vcpu *vcpu, unsigned long s
>         /* No need to check writable slot explicitly as kvm_vcpu_write_gu=
est does it internally */
>         if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area=
_size)) {
>                 kfree(kvpmu->sdata);
> +               kvpmu->sdata =3D NULL;
>                 sbiret =3D SBI_ERR_INVALID_ADDRESS;
>                 goto out;
>         }
> --
> 2.34.1
>
