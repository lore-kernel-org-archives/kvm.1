Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0FA1FE47B
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234566; cv=pass; b=Y+JHMT7pXIyhLlhbcCGVlsSA9hTiy+OeyCkY21yZ0Xnd3/mB1wZj8TDdogQVxz/ZhTmqN40B0ztiJRHzEZf8hYIXLHei+pdSEk6OmrSGcCmnOnx7Ey70YsMHpMg/Lfm6XtD4RJDPFBaY4w0gYF5kfYns+V1mppow6m9IWiBS2Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234566; c=relaxed/simple;
	bh=qGU9Zxnzj7IbyFxskAzMgqpZJCRoHLKeXshL3Lo8O2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqe6B8lPelqd4VdkjmHJc+ex3naD4tlIfJKrHiwAlRGOr5pOEHarnwKCUlHYXQbWGulxMkWUvsEsJm+naiu9ewDmjTsN999mFCLsv6NoJ5S2/54dQkEsAnWx43KAe+PFuAf9UWNJbrsZxtDRdvtn9TQhAfmNC5tHthdrZm/D2Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=DZDOcZI6; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="DZDOcZI6"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6836ab45d84so34287eaf.0
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 09:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775234563; cv=none;
        d=google.com; s=arc-20240605;
        b=N1Ee4nV5Xi0VuB9moCtTLMgAhFQfnn10uMb5mvaStNxeJZq8UZjEx6rSqKFBaSdxSt
         5MdJuAYh66eGmEfzNy2D2FMyiCk8cK92C9n8Uy2L4eJ1QXvwKEOAJeViJ+IZF7LY+JOM
         80cO0aoctGFS1IhZ6wQrk6T7lXDEyqNDRvca7Notrwl17WPcsJ/Y64VXAid0qoh6+KH/
         tTOjIyS2ypDwqzKPR+gTKXekS7P3xki7+rN1BHl4kSUP+2XHZEWdpmy/pIaexUVcctYn
         mC6Ytk9xQZOAcew/57dsFCOdctOr5HZt1eN58LFEJoOCE2CZ+3yhVpvUD7zAO2pu7Dxl
         ysIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auZTnywYVktBT/CjhCUIdzd5mrQJL3jt4L8n/dbsyLw=;
        fh=aBCNax7+hlSN/+OsJTzGByUwgGaro65kPMyNCTpPPZc=;
        b=dz0AfQrZbWCISmfwetb38+3Hs0LrWDV/70SP4rSMHuuZhXniCudf1FXhRilSCVdcgC
         Vrg2i/JFKBgsRZrAWJLCwk/MaOZ2p8WKYeDMnC4t74eLlNEJLnRkaXImccV4yZStHmSS
         Vp8xMB/otqSybn8GyGeb7w/HrJ7zBkAoYsCkcDQzDpocJExaTZ3JLiaitP8qrbWKL8kq
         pMSUBeYC+bJ4tcb+UFiNK1u9R0VoQ6f/19V1hFpCpDdz6TGqtzAIIgwNc1uaxKCE5WmV
         DVBd6ngTtUwrc2B8pbFiF0rOL+RkJ0JwPNcdt1V09NxJQxEES8foUVaS1fSPP/8iuH/1
         EDxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775234563; x=1775839363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auZTnywYVktBT/CjhCUIdzd5mrQJL3jt4L8n/dbsyLw=;
        b=DZDOcZI6UKl03G5B/oUaab2SDROdBPqJfl5aJiy50iA2VZ18B9mN0E/iF66YvJMKiu
         YAGfnegNPC3Ke6pM9exi2MHncB66fClQeRThnllhwxGqM9e8hiiZpZk8NVIHegKw2vDl
         nWWImL1fnC7QbB3HEETOXq+XLu0cF2nFz+ltsFLOX1dizhDxagX0Ff/ED/N02x6wuRLu
         cL4Jzh+eeiBPLWLAAqv7XhCTLIxMNvhrxHJGtqJPKy9ML7Qwc/WfwdSGjEVxGs55D6hC
         EkplN8cuJ3RUoZ7ckwGSPK+P9TICyXQ0dafgVykXKqqsSzYLWYkkhBT8j7O3V6u5tO8d
         6uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234563; x=1775839363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auZTnywYVktBT/CjhCUIdzd5mrQJL3jt4L8n/dbsyLw=;
        b=I2ZChsh9+telg3AvMsmLily+Y3ro85Gn/0terZvJu4cbLAco+eZDY4t58P9zZktfxU
         TWNLvKT6xcYwE7n3ftT6xtPp6a9iUeZD7dSKKV9ehV+5jX1X0R/dNsh7YbMREtZbLb7l
         1rGv6G+t6hVwEIp21CDxQGl+IWtBxE0ujnOkOgSCu7eJyCQmjrpf+An7S6ocdRMZz+KR
         K6IZuuLBfMX1jHqgXAiGYR4jUu2FKa2oBIksurOtqAm0+TbkvnJh1QWvUgsZwZMRqrBr
         hoPTTHhdz2gysT06ECa23LJh9hrtCHJqrGY6+BU+1j4meLHqp3ICeTne8hnboHq4dRuy
         pjwg==
X-Forwarded-Encrypted: i=1; AJvYcCUGK50X42vRv4s9Vhdu5LQZXZUJaNPpivSfMGFFyRdXwkGd1ghUqKF5CjGxZ9676Qcx2qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfg5qoyQ/M2lUgTD3WNoZV6iuSF80/pCKKzjM1Fcrj0PQZ7KaA
	57j/kxfrqByNDtrHqug+gC9j1EnFuukfegGbhnmIMgiVHOADn71dVqIzyCcHWK7JFbT4+6QhGwt
	3s8kYpaJWJjcRiGdHNVjqx9KIFoYJc7mHU+2nnNDU/A==
X-Gm-Gg: ATEYQzzlmUl45V5q6sk1feqjeUm7H7VS8HQv92crKNYZYjBAVxiMftTOmkVufZLfR/c
	t93X8vK9aNgQ1Qzle9pWloPBr2FKS7F/vy+9N7Y4sH2GKk4H9rvupDSMHPVhZKanFV4/gAkJGki
	v2LOHUdsqkMHjsCvsQ3bVnT61ojE8L/GVWfToRXee93E76R+7QDliqMF3Z2E98svAUhyGlezG0K
	g/smZZmGNq7sQ+ywNAxbEpx26n3RdUmNfB25nFk97F0jkclIPUE4DcWlsi9aLm/VNaX62pUur+E
	5bk26aLhPDBiyGydCG/Rwj6sBwxq4RNTP/dbgR3oMi3TEcDv5HIQLxpWJL++L8D2LoUTIl163Ha
	v5jWNbK2/2NCvNCJGoBJZ4vDBsw==
X-Received: by 2002:a05:6820:2215:b0:67e:42ca:bf1 with SMTP id
 006d021491bc7-6821fe62163mr1788720eaf.35.1775234562721; Fri, 03 Apr 2026
 09:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403153019.9916-1-fangyu.yu@linux.alibaba.com> <20260403153019.9916-4-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260403153019.9916-4-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 22:12:31 +0530
X-Gm-Features: AQROBzCuQ5MlY1qXpbAGUgE7OvJH7RKCeYopTbo-0zq1mBL8wwRCkjds0LobFsM
Message-ID: <CAAhSdy30Eg1GvnyfJyqABLEyP9_rV3Zb=Ts5TAxWWnv0frWRYA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] RISC-V: KVM: Reuse KVM_CAP_VM_GPA_BITS to select HGATP.MODE
To: fangyu.yu@linux.alibaba.com
Cc: pbonzini@redhat.com, corbet@lwn.net, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	skhan@linuxfoundation.org, guoren@kernel.org, radim.krcmar@oss.qualcomm.com, 
	andrew.jones@oss.qualcomm.com, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:00=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Reuse KVM_CAP_VM_GPA_BITS to advertise and select the effective
> G-stage GPA width for a VM.
>
> KVM_CHECK_EXTENSION(KVM_CAP_VM_GPA_BITS) returns the effective GPA
> bits for a VM, KVM_ENABLE_CAP(KVM_CAP_VM_GPA_BITS) allows userspace
> to downsize the effective GPA width by selecting a smaller G-stage
> page table format:
>   - gpa_bits <=3D 41 selects Sv39x4 (pgd_levels=3D3)
>   - gpa_bits <=3D 50 selects Sv48x4 (pgd_levels=3D4)
>   - gpa_bits <=3D 59 selects Sv57x4 (pgd_levels=3D5)
>
> Reject the request with -EINVAL for unsupported values and with -EBUSY
> if vCPUs have been created or any memslot is populated.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/vm.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index fb7c4e07961f..a9f083feeb76 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -214,12 +214,52 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>
>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>  {
> +       if (cap->flags)
> +               return -EINVAL;
> +
>         switch (cap->cap) {
>         case KVM_CAP_RISCV_MP_STATE_RESET:
> -               if (cap->flags)
> -                       return -EINVAL;
>                 kvm->arch.mp_state_reset =3D true;
>                 return 0;
> +       case KVM_CAP_VM_GPA_BITS: {
> +               unsigned long gpa_bits =3D cap->args[0];
> +               unsigned long new_levels;
> +               int r =3D 0;
> +
> +               /* Decide target pgd levels from requested gpa_bits */
> +#ifdef CONFIG_64BIT
> +               if (gpa_bits <=3D 41)
> +                       new_levels =3D 3;        /* Sv39x4 */
> +               else if (gpa_bits <=3D 50)
> +                       new_levels =3D 4;        /* Sv48x4 */
> +               else if (gpa_bits <=3D 59)
> +                       new_levels =3D 5;        /* Sv57x4 */
> +               else
> +                       return -EINVAL;
> +#else
> +               /* 32-bit: only Sv32x4*/
> +               if (gpa_bits <=3D 34)
> +                       new_levels =3D 2;
> +               else
> +                       return -EINVAL;
> +#endif
> +               if (new_levels > kvm_riscv_gstage_max_pgd_levels)
> +                       return -EINVAL;
> +
> +               /* Follow KVM's lock ordering: kvm->lock -> kvm->slots_lo=
ck. */
> +               mutex_lock(&kvm->lock);
> +               mutex_lock(&kvm->slots_lock);
> +
> +               if (kvm->created_vcpus || !kvm_are_all_memslots_empty(kvm=
))
> +                       r =3D -EBUSY;
> +               else
> +                       kvm->arch.pgd_levels =3D new_levels;
> +
> +               mutex_unlock(&kvm->slots_lock);
> +               mutex_unlock(&kvm->lock);
> +
> +               return r;
> +       }
>         default:
>                 return -EINVAL;
>         }
> --
> 2.50.1
>
