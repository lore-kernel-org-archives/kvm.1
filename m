Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0D4FB9DD
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575572; cv=pass; b=FH92Zkqq2PoLdyo8MwnBati/8LfZphOWvytrX59Z0ulZDb8EkTXohDAFLb8H1PHIyFa6HsNGMcv/yQIgr5qHb/mJdtIdp672C4wH+KnuVpQvXqQTM4klAtw+zAKjzssgpenu09xeJdBCOckTkiyTg08+kx1JX5NG8CULslZp4zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575572; c=relaxed/simple;
	bh=2EtykzROyNRHqI7dfO5p5LrMDJMmvauTWDJWnEKfhB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjNnQuZXOJNiZbRrQBqUqrF7xqkmS+sgNx1TAP5/eB/wUt+8K2XsGberdwSrIR5lWoX5zwASxbl7cIZ18kAKyJOQiJtc6ln6xI5UXES/9OYeeYrf5fXUOhaW4vflTOZ8igXRhaX32uS0Q3/oeD7ylHSPLk3VGl9op+BP5czNIvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=vgeKcVP+; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="vgeKcVP+"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso28387e87.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 12:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791575561; cv=none;
        d=google.com; s=arc-20260327;
        b=kwsxgZlpdtggORXyoWyF5E9RPoeLjr11jdmyyadrEDQ6YmtH6MMfB7jGOpxP1B2afl
         07C3QzbRvpjbMyEsbqtnzwudAP67W7fBESZUr9QjxOqS+czgk+FYmn0U54RebWbG60dg
         bdOT+vTQNMIxC0q9T7wCATrITnQB/BeqM+LmpGxDxcdCEzUt7KTeGzpFEujnJPnxIqOP
         A3dFNIPT/XXQegCN5kxZjcfiJ2mDGxNvkjFPOhUNONV0Gs3OvKCyLZpJE5+T1L7aHd7p
         0ZpPvLZwiFyGZXlnemFMd4iqW2vnHbX8g6jvu0J6T0bvjPCfEChmjJac139eQwp8jab8
         YcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        fh=v1RTc0tdm7jWQKV7GsFkTH6hqNxqx0i+kFy0WZ+SSCU=;
        b=HPflxzRNC1DCbQ1eB+UYltYXxN8VD2LpyR+pgMKFjFKhoznP3q5RlNB624kj5cW+JI
         SkrHHAI+DHcxve88EdLP5xIcKnGNNdjs1JJbTPQu3vyrA0MnrgoyigUuBVKKZ9bBs8uT
         szd2yj0RT5xelASlIGUNe/e79I0QnD8t6bEsJThigQuXr1H9Fp0gklaJq4ahGtb2nYyp
         1BzV/dAjO5tqy3SVpUOXcL6OSlWSJo6bGDsYLskR8/zKu14aNMzHihMVR6aWDnSvXi2Z
         4ZgjU7UCYvDEOScLXBqWuoFqpB17e+v5C2aHmgO5A9Qy+NZbq+qqYAStjiJ3aSu117Xu
         OsXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791575561; x=1792180361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        b=vgeKcVP+wYgPLz4NnmhxxWhXCbKuyKqA6W8IcW3o+VF5mZCXBQBDJLRlwQPQFMGrYW
         t9BcnlqXQlX8FDX/GNgdfMOEy5ZrPIcy19wRyvvRdmC4hw5iZu08kf/Imv5b1+VPuvst
         iLUxsqFX1a8hnnty2iXltM6zcIK9UJ46mIOj0ecbTVQflv22tkmWeLuaucANb92pL6rM
         uzTyymxQDvgGS5p+xNhmmlCYuBDaGO0ClSS9kT2ktk8lFFGBJNqKE04cfjjdgusMGa8B
         lJr+7wojnVcdKqymP5urAH1m5IZRI1w2Ze4rSu7Fk5FIyZJIgtkEgYyDl6OS30gt11AD
         9Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575561; x=1792180361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8IOkLqKGpOfZvqZ//aJaXg6rNYWnLDF+R3NnxinhKE=;
        b=RfYPUiISbf4ZvrV2aAKMOIkoOBEheTr8gdv2qXxTRq0zgsBjDHbSyHzRdeI85SoiW4
         6S0DAw0U2NHEfNqwft54i0C0900DcmmXc5gxdVJKD/yNBNWVtyTpxFgeUx1rifbDtrb1
         kFw7qoMFMX8i8GDlhKXZyQkuMutTN+6QorVgOF3spkX5hDdU/VwAGgo4LxCCKJ/H1kdV
         xDMCYaBTqC4rd/LSvcHMe4SN0VO54wirHs73gZOqaVyfM9vRdy2n/uZ592+kBUq3I63x
         8ib0ZpjnygB8FHWfZIFheGveKOBa5QxgafXDI6VNxu7lWWu233ClX/fkK8TEL4q7rviL
         AFww==
X-Forwarded-Encrypted: i=1; AKwUvBydx1L9OQu7Rzau8Rr0RKgZhWF3Tce2G0prWP0XgTg8itHFFNVfEKHIOTyDP2VuMaMlTS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8afmHuF7F09KLVvJRL/WlMI99+QQlePZfp8BdkDNz1JyNpqnS
	eoBZnovQx6LO3KpQY6gNvwpJblcK3arZg0BtJfcXsGaN6KGCFch9YECm3HNLCA66TTEt+nxxFlV
	kC0+z2RWcIrmrfRQXYWoVppLsVcvBfkejjXLnZ6NUaYeFkbYw5QFqTY9Me6eLsYs=
X-Gm-Gg: AYBFou0l5XgvDcW3ZHQ1IDCFPxSYiQysvOFoE8n3KPZIDtu5cEQ3LY6oLKOKMmWcQ9Y
	m/8qqL6HCDrq8MCwVoAYfOLA8bStiEcPBzfgK5OYgqQC20sLQbhBPbZ+iENxnPWLzip+XZ73YO8
	xv79wP4c0ilX3+/zzNmyPZubTj1rqjh1EQD6vl62IKvHEXeiSA5Qc3et3noAv7sLoz68/AWDwAv
	kBhtcZhfVIpNraYzTMYHo/CyC34sArDClKFbozBJExnNwb/Xzny9O7ti+mdG734ZLD/SLlH/yKk
	AV1xi2H7pzkYDd/t35fMxPXK1fff2GxNzwGXMGSj44nUZ3537lNVMgOytbxnFdOJ+nzAOb0mdpV
	OB6tsH2AWbBC8n3E+hLHPQehVapQGyOTtSpSWSdQbA8UrlzZ+p7SzLLMhQH7adjw8dbGC7rH94g
	==
X-Received: by 2002:a05:6512:6c4:b0:5ba:3888:7055 with SMTP id
 2adb3069b0e04-5bcde8d8587mr987668e87.48.1791575560885; Fri, 09 Oct 2026
 12:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
In-Reply-To: <20260917122012.2577-1-yuanxiaofeng@eswincomputing.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 21:52:29 +0200
X-Gm-Features: AclHuK9LE_K8n8SBL5vcZdIBUie1cZWxyC_Q9G86b62TjkF_wne6tghiR0d8MC4
Message-ID: <CAAhSdy0CWoLshP7GyONS2E-wYOZF8hEjbBosOnc74LvtjkUbDg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix IPI delivery for out-of-order vcpu_id
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:20=E2=80=AFPM Xiaofeng Yuan
<yuanxiaofeng@eswincomputing.com> wrote:
>
> The SBI IPI handler walks vCPUs with kvm_for_each_vcpu(), which
> iterates by vcpu_idx (creation order) rather than vcpu_id order.
> Since vcpu_id can be assigned out of order by userspace, a vCPU whose
> hart_bit falls outside the XLEN-bit hart_mask range may be reached
> before vCPUs the mask actually targets. In that case the handler jumps
> to "done" and stops sending IPIs, leaving valid target vCPUs without
> an interrupt.
>
> Replace the early "goto done" with "continue" so vCPUs outside the
> hart_mask range are skipped without aborting the loop.
>
> Reproduced with a minimal userspace VMM driving KVM inside a QEMU
> (RISC-V virt) guest: three vCPUs are created with ids 100, 0, 1 (in
> creation order) and sbi_send_ipi(hart_mask=3Dbit0, hbase=3D0) is called
> from vcpu_id 1. Before this change the IPI is dropped and the ecall
> returns SBI_ERR_INVALID_PARAM; with this change the IPI is delivered
> and the ecall returns SBI_SUCCESS.
>
> Fixes: 0611f78f83c9 ("riscv: KVM: Fix SBI IPI error generation")
> Cc: stable@vger.kernel.org
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_sbi_replace.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_=
replace.c
> index 506a510b6..c2f1f7f26 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -64,8 +64,17 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vc=
pu, struct kvm_run *run,
>                         if (tmp->vcpu_id < hbase)
>                                 continue;
>                         hart_bit =3D tmp->vcpu_id - hbase;
> +                       /*
> +                        * kvm_for_each_vcpu() walks kvm->vcpus[] by
> +                        * vcpu_idx, i.e. the creation order, which has
> +                        * nothing to do with the vcpu_id (hart id) space
> +                        * that the SBI IPI operates on. vcpu_ids need no=
t
> +                        * increase along the iteration, so harts outside
> +                        * the hart_mask window must be skipped instead o=
f
> +                        * aborting the loop.
> +                        */
>                         if (hart_bit >=3D __riscv_xlen)
> -                               goto done;
> +                               continue;
>                         if (!(hmask & (1UL << hart_bit)))
>                                 continue;
>                 }
> @@ -76,7 +85,6 @@ static int kvm_sbi_ext_ipi_handler(struct kvm_vcpu *vcp=
u, struct kvm_run *run,
>                 kvm_riscv_vcpu_pmu_incr_fw(tmp, SBI_PMU_FW_IPI_RCVD);
>         }
>
> -done:
>         if (hbase !=3D -1UL && (hmask ^ sentmask))
>                 retdata->err_val =3D SBI_ERR_INVALID_PARAM;
>
> --
> 2.34.1
>
