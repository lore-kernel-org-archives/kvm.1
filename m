Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AE4CE685
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546342; cv=pass; b=JZpB7hgK6cY5nj1lHpK+6I5VlefZ6jrMXJ9IfeNyyiMEFVmoFyzC7fhPtSlQqE4/qMGFuS5BaYrWXGqKv263Y/sPHaanE7QKGUGSgRB2ZyKyJXW5Ek0Q5PW0sHgqfuo/OwWpuHATSCaOjyfZdDqb35CHyEF33facXz1pfOc+NgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546342; c=relaxed/simple;
	bh=TOfNGwFqaSy91Kspj+7ZYb7uFuFlJpfQkRhy9CLGxCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mejw9mARJPWYGUqfpp8nrc5HTwM1oc5Lpw8ZltuBQY8GpKgFEIwTTpEBTIZWUbHzAqU/SVMbkmtsXYmwwSM+urXRx5AvcOAmJaXtZ+3xRF5bcRobwUf4qus1HU5/dRVfyxO7v2Wjl274XZZp1zrj5iwViX8XrUHTEo6VNYyKus0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=u8gSMaDd; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="u8gSMaDd"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b0be347b8so3341827f8f.3
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 04:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791546333; cv=none;
        d=google.com; s=arc-20260327;
        b=fYv8z0k4LFUsSS8jEvONlwg7BF4I6KV1WGFk8MMRXaf6fra7UmCuSD1YRI1fYMwl0K
         MSVG/MimeuW1E25fOEuDyM4BtwdnJ6GNzdKqELpbl33slMZhvDuzf7qnrJgeEJRpZ2cM
         yHNHSZ5ioYTbZSR/QLH0tZkiVcoFp0hGl1ThkWjTRS//NSVu6kPYczwNlhUirZBWvJbV
         goXAntQ7m9ENSNVE0HfutXok2DBPnIGZftzDxgO0uM+9mphG4WBe0hd8PYI1pUJlJf8d
         F/s3wTbAQWOhhz0ae68u/ezr9Ou1Yxa3zEqcufqY9OKkNlojS2gUcL7J5swpyuLVaC4n
         QemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7MO9vjywSNkYUu5MtJSespV1dEQA8yEju3SiQ+MpGec=;
        fh=4Ke0gVHBUSxmxD2mpU++nt2vgZcFXdovshCcbYiymGw=;
        b=cIllx4TkfWBdZFHrDsBIjIk55I0FaDI03UC/11R4XnHvDk1MF8pnuEG0L6eBClSBT6
         XWIfT0OOpvFFJWQ989/xbYNrYaqk1DbDgKWCz43El7X7B0XoW1GQ+TjXkOtqNmuNUDIe
         Lj2G+6h2F2aIlZSUd7FKA0FND3IT4CAoTypf4128JupoRlwlOcDb9v/xmb6oy7nDU/0u
         g351lzMge9NlwXcGErJGmB14omsIUj06LQxXKQZGLtaEungfP7GZQBzypzn9ClA5c3TJ
         uy+/D5GD0hGF2qfssJqxb+9KkVCMl1PGM5JVRuEIpJhIltSUFRYZZ37vUyu/dH15lr1b
         URRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791546333; x=1792151133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7MO9vjywSNkYUu5MtJSespV1dEQA8yEju3SiQ+MpGec=;
        b=u8gSMaDd5aX5pz6DW9qlPcfr0QnwLzwg0OBgc5+IP9MlvhEALLTcqNZDy9ijtLZi8n
         R07Hu2DgU2NadN8sXlN0yM8c7EpvpyXpYwPvcBLqdoIYV+hZa/xCtg0xpmCEJItUOFJi
         uORpCiayRtEUWcPHhSjbmur4tgW84iDGGek+KZ8DB2p+jNTaPdqEOoNrsI6OwTThVwb1
         5wHW1CbxCJNVD39r7s2tmX4V2Tc7jcrRC6LbJ/spMC4j1XxyF50/B7zO5JVg6iylEHpW
         M6wWcXpuJ7FtOo9l0njcCKNokMdvpatk57ts9FIxMWhRLKesHcQ4OXJJmwSZsORVBbua
         Z4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546333; x=1792151133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7MO9vjywSNkYUu5MtJSespV1dEQA8yEju3SiQ+MpGec=;
        b=eMrgrHBUD5Gh/6xLPLK5Id6G/9ljkjwk8wMkfPqyPFvMEmsfDQuqTjZ1UWXWSqor2z
         4prGc/YrMvuR2MtjMOXLwmVYm6tKrFC8arl+t7gms/AXazrBNDptSPLcKvEy7ivuokao
         OoxfrlUVcEMv4iZGXo3lOfvTC+A+OA/DhAkvLUBOZvCskg4Yl7ra6Tuewtew421aqHCX
         NiUInKDREHMs0yOggRWw1KP2WU7fb7lUArFBKXPvrlqV1x/oyNc4Y8sVyWOjV2tWHG03
         fX3QIDXhFwRaDa+7RiQbrDoR8/3m3+vG6dv0lWiksrLvofo+vgqUObnU5F28qAGIgZ3g
         WDPg==
X-Forwarded-Encrypted: i=1; AKwUvBwNiyEGQtF9HPAOwslgR+Wusc2oIkUPf1qEmTwYUbf7s6b+csIdnwizdh9CvrZ1twsEV0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4UV1mgdR6ITm9hjUsPKPDucKNmfmVXKSDopNUBL/kFgivQCo/
	dJhSKFCtNyQdDhJaM8bw7rhwT8ABZ2cgQ6C4Q4hVZ0/BptLxpZ+Kk04reyMLWFp99RVGetZYfiM
	x1vhmTsXM0mMuzfwpNSqq8ZUBhoiP0YHC6hfsZdXUrQ==
X-Gm-Gg: AYBFou3terAjYyznaB7KOGNZW6Q4tIo0CCaWCuMcT/5kTivFJ++er/Yw6OErZ3qAmRt
	XwaG5ESvmnwmfzlOEiDmmuJ+UVQYRfF/vLguUV/qou/EYbZDYeNInXVCgjHIOhgKvcgCjGUVkVF
	6m96wcS3xgHJU7Lt0rRHrAASzAL2AdR9Pyg/3iSHsS3EVqT0hewXTuradHjUH0291qmiyggGJgQ
	j0/Is/JoZXkleMJMGSagK/19FgBLLl2tVPRv4eFszkKeRaaYUxCnwr6pANfm4TVgVvSqASDaURC
	AySDp2v7zBS3/kcYFXB6Ssezi3o8Qd+sQywvvjGnc4Zmb7XErcMlblE+yzqoJor9cB91txkEYN1
	f4v3nnCcb0Sn6dw9dgUM2WI4Nlh/OqAElISIsOmC35fXfR5b3UFsiXCBA9/6KHijTHwPQlU1J2Q
	==
X-Received: by 2002:a05:6000:4687:b0:487:36b:1816 with SMTP id
 ffacd0b85a97d-48dba7877f0mr2127579f8f.7.1791546333358; Fri, 09 Oct 2026
 04:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 13:45:20 +0200
X-Gm-Features: AclHuK8rgBU1gbsBmEn-K4KM8bdu2PbHz2NOesu5k9NjQJGHum_Uocj_Q34IYFc
Message-ID: <CAAhSdy0Y8kQ=gsiX0QX6Ntq=fL89METhA0s7G3niBBJrHpue7A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use a raw lock for IMSIC wakeup state
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:51=E2=80=AFPM Andrew Jones
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

Instead of introducing another lock, why not replace
read_lock_irqsave(&imsic->vsfile_lock, flags) with
write_lock_irqsave(&imsic->vsfile_lock, flags) in
kvm_riscv_vcpu_aia_imsic_put() ??

Regards,
Anup

>
> Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC vir=
tualization")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
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
