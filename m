Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D03B2FFE
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786197221; cv=pass; b=BlhexUT8kviXMLm9G4m3uzQE/I4paMTt1CmKpGRpK4X+Pw29vTHwpyieI4zrXlVUrkyo6C4BMSJno/uKgpXSNpzaO7dHLYT94Ygl4T2kLm9rQis5fWlKR8PYTJ/UoMtpp3xS7Av23vn3n5StFGenyljKAjKyeVAh9S+ikH+yS0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786197221; c=relaxed/simple;
	bh=zdZzMBzY0Vtf9x9oXrd2/FR6qg1HhMz6+KTWPAYIhVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svwsgf6XkjmKoso6WWpFo2g7PlK8dQw7J9vh2DEKZMDu0A1zVu64cTO8RhsVBYK9REd3o+4EHhSP4WBj41WOYh2WJ8ZXg3s7ZMUevzFnw7pTug120AIXYY0Iq1ILvesj0DtewkHYiSB8i7Vi0jmkmNiHD6N54TqjsU1+TYuiAwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=XEXkREdU; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="XEXkREdU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495590dde14so4822955e9.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 06:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786197218; cv=none;
        d=google.com; s=arc-20260327;
        b=dzmGh04XcidoncKtztnTi46cvUB01F9kiuME5EfjgZ0RYOkAiqWEVIoUdQ9wgpF+aD
         S5dlkVrRcIWg2XRT+LGtLPVG/fpURwCvyno/3szxC9coVmz+HsYjWRnNcMhsh/etwgyP
         m8gtHAi8hjRVyS6viser1RwMFkW6Ci2cvsb8YCdeMb5uPsVMP8AYyNxfDCp8pd+AEmST
         BSteD26eJaeNR5D0t6eOEls57NwxJ4xexO6wLBIr5PateZLESk7b0XWT0JRHhytln2pb
         IPvXmuZT4zysB3L77Crm+wa01Ivx7985825Hc4QulGe1uiGn1AZDlLyyG6MZNYO+SM2O
         SXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74xYgEIE8mnG78Ys3tNqrS7etwpa5hK5YHhCulGv8uw=;
        fh=vSd00oAeF8eQZqREo7MdDMNxEVCArI2M1Dlj0Oh6ZWs=;
        b=KkjH0X5MkxB2sPEPwHbUSJbqGTyR8AaCY0960+WeYWX/nUkaHpdHn+b5glbGut4TNL
         grPEzmhQejS6Wl8h9PINj9yz2/3OTJX2RRW5/rhwiDDBOdYwYGfCm42lvoQNIvltHRnd
         3mLTXlJ9+Culfs1HD36wdrCI99Nx6lMRIydCC0xSWo7eO3B1Na7z6kNcb+9m7PSziYfE
         v6+/Xm6Um0530H+H+XXQM8S9l+EX5PmpRxRRYIuku9+R4fzmh4sg/PvS3vSWNdNIft3x
         QPpx1kXJnzzX5dBbHU5KQ52JCOki9yB5BA+NOY516dTBnsdu0isvj6YCJTC+wvNHkNr1
         qHKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786197218; x=1786802018; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74xYgEIE8mnG78Ys3tNqrS7etwpa5hK5YHhCulGv8uw=;
        b=XEXkREdUyXUM0QCXOQvecJXSkVOBj9JaEAvWw4yi5yhwoGdslpz4rFV32GoBwBko1o
         fkNBlQpG4ai0vH3ucU6AblfX2aFwzMZKuD9xH/zIh6bKiz19aOPejZkETHTSMvDW7R3u
         2bF4JV/dfZ707b+ZTbn78haNlT/rkejay1XhwRkwn+O0O6ACRCVwcqqHyqQK67bdBc4c
         YegjxRb1z6wk01U2GEYoc4xyH/F3tjIWzPmHUS7gROVjRB+B2qYaj1qBiS8p4s8PUXYf
         g/J0jr5pOvXgXSooCK5QdyKBN3UyU9/JAF7NimG9Uh11Q0moDTGqB6IpGO3Kg4sSJExW
         qQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786197218; x=1786802018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74xYgEIE8mnG78Ys3tNqrS7etwpa5hK5YHhCulGv8uw=;
        b=OXnSFXR2ppM2xBW416zP45UIgNjiGkfWPslOa0cZPZwW3l1g6WaQ63aHlpJOYT7u+2
         apSFCvf07W6Cu94ZpOqCh5jMQ9peaZKnDNS4avN0HaRSBDN0xHNBzGdWujs2HEtkJM9I
         6UNv3cockbrf8h7in0g8QHRUUtqlpDbTmH6xlBDp/KPulWToy3SAKCtV8AxEjOmmSz8g
         SmBUnRLLZw8YKfb7GGZHHrdyqLBtYtTcZC1ysYSK1x1pmu2gXAbg1FXczRseWDL++lQy
         wQ5edgqSheTfrLFR0uKU9DARcppNpcF1Y4pqXlQSwy+jg9Ju2T/cZKAgO+rpVh9EoFZ8
         H9KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrF8WEoVTjPRHsL9e/Xp5aec0VhRFjENWTGXviAJVymIM5aFHtmF9Lqxc1SsPVpC2ycKHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdTrh8lFCCd0IgcwclovaTUAH4NiOkYNEZVXPOxmT1WXvMHEz
	fPT5vcaTF5Z22eI5FWRg8BFtZIJ46K3bRNMuDijAoTxTCR7buT86gxOYt4bNNb/cN48Z577GiWH
	DKSWObqvkJVaQGJ5wHLbSHkpNi5TsUoBoDYZloV6tCo8dffr5WlvauUg=
X-Gm-Gg: AR+sD12JuJbdmomIK7geyeqprfsw9bkRFj1qU6g6bivbjXLtKQM7sOa0+8PYrhz3aHp
	VNRo+g7N8rIPLZKaINfYU6SYAeADC71Xa+nUTWYJvWfsJkjElvBfynIpUbSqjaz8U/PrdZaZPXh
	+RO/mWGIvRXjXfoHViRPG0ZTT5iSxweH1DbV6l/k0TpyLOk6crpBJTyaJiFE6yB6NJQxty034RM
	IHNK3/7YiUoPb3jNshIHOv4XmML2029mJlBCp8Ub61jyNUjNeuYWsG2ru376nfqAsdb3OalGKjv
	jlviiAyvF3jIh6d6qPD0/jLUr7agWNziP0bvmato5mpeszVC19AgGKBZJ+1hMku9ZdF9hddCFK3
	OFpBqqtHMzS7myb7sRa+ZreIkv1zIuU990cOm+MzUkRsSPcTv34pyt1O/oozozYI=
X-Received: by 2002:a05:600c:35c8:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499593ba192mr238069085e9.1.1786197218018; Sat, 08 Aug 2026
 06:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com> <20260721-kvm-cpu-pm-v4-1-146bf942547d@sifive.com>
In-Reply-To: <20260721-kvm-cpu-pm-v4-1-146bf942547d@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 19:23:26 +0530
X-Gm-Features: AUfX_myz_LWEpWkQBi4Qgji9kmSumRPQ2nVtYheU7XgWx1CkLYrVIiuTenhmXOE
Message-ID: <CAAhSdy2f79uavqQb0_VxC_xCxX_c5DcFbbH-CfTA8bUGp=JAqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] KVM: RISC-V: Clear former VCPU cache on
 virtualization disable
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Jinyu Tang <tjytimi@163.com>, greentime.hu@sifive.com, vincent.chen@sifive.com, 
	zong.li@sifive.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:22=E2=80=AFAM Yong-Xuan Wang
<yongxuan.wang@sifive.com> wrote:
>
> When a CPU is taken offline or enters deep idle states, hypervisor CSR
> state is lost. The kvm_former_vcpu fast-path optimization caches the
> last VCPU that ran on each CPU to avoid expensive CSR restoration when
> the same VCPU is re-scheduled on the same CPU. However, if this cache
> is not cleared when CSR state is lost, the next VCPU entry will
> incorrectly skip CSR restoration, leading to corrupt hypervisor state.
>
> Add kvm_riscv_clear_former_vcpu() to invalidate the per-CPU cache and
> call it from kvm_arch_disable_virtualization_cpu() to ensure proper CSR
> restoration after CPU offline or system suspend events.
>
> Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on=
 the same core")
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h |  2 ++
>  arch/riscv/kvm/main.c             |  2 ++
>  arch/riscv/kvm/vcpu.c             | 11 +++++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 60017ceec9d2..808b4ee1bd10 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -319,6 +319,8 @@ bool kvm_riscv_vcpu_stopped(struct kvm_vcpu *vcpu);
>
>  void kvm_riscv_vcpu_record_steal_time(struct kvm_vcpu *vcpu);
>
> +void kvm_riscv_clear_former_vcpu(void);
> +
>  /* Flags representing implementation specific details */
>  DECLARE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
>
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 0924c75100a2..350e4f097d6e 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -69,6 +69,8 @@ void kvm_arch_disable_virtualization_cpu(void)
>         csr_write(CSR_HEDELEG, 0);
>         csr_write(CSR_HIDELEG, 0);
>
> +       kvm_riscv_clear_former_vcpu();
> +
>         kvm_riscv_nacl_disable();
>  }
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index cf6e231e76e2..e48338f907f4 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -26,6 +26,17 @@
>
>  static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
>
> +void kvm_riscv_clear_former_vcpu(void)
> +{
> +       /*
> +        * Clear the per-CPU former VCPU pointer because hypervisor CSR s=
tate
> +        * will be lost. This ensures that the next VCPU entry will prope=
rly
> +        * restore all CSRs instead of incorrectly skipping CSR restorati=
on
> +        * via the fast-path optimization.
> +        */
> +       __this_cpu_write(kvm_former_vcpu, NULL);
> +}
> +
>  const struct kvm_stats_desc kvm_vcpu_stats_desc[] =3D {
>         KVM_GENERIC_VCPU_STATS(),
>         STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
>
> --
> 2.43.7
>
