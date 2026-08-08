Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14103AE19D
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177364; cv=pass; b=DDz5Fn54xy4siq2zJzIHgoZbPoamO32kIXRtsSkbRCFdm7VUDS4evUL/vOzacoS6MRfsm0bDMpYO4HUoW01P+eYVGjuCblC3eWRWfLJCi2jiy762E5t8BIgpJBXL6gx9Y3XnXrQHT0oftT1NKrVMDv163UgF3iJylPUB9kAQlwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177364; c=relaxed/simple;
	bh=0segiAsmA7pfYrdjdpIr5Jpqv2Hz0wt3DKwBCnqo8SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEYqlIMIYGXvFPFbHbo4bVrHm7op4frI66XTQzcOwyUpCH+BceTSUvnLC/U3ul53C6BQ1iFk0qy8N7nV9UVM4YO2ednCv7qefEVid69MYclPXshjdv9+jGogZpVs7y3aYbT44kz8ZYExVvXnhYs4G8fa59IY7VfLXeqMfrrtMaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=uG9yetNy; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="uG9yetNy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so2751155e9.3
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 01:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786177361; cv=none;
        d=google.com; s=arc-20260327;
        b=atp3Q7+ZYrc3p5f2pZqBUpKiBaFFFpx0V2c4sti/jR9ZvZhkwyMsgj2gqq1lrOxjMP
         sP4TO56/rNrLco6nhbvY38+To5KWLAcG6ZANeflzr38j0atWL9Vbu4luSRj4u7TkZ8IB
         RGha96ZlB6wZ+3a3gXAQfE4kq4BLJtnbNVf48H2GkQcNVnaYdpQwtfxgrXqixJlbWxb8
         rY4ge+nDbckgRddI9pE8A5EVrd05tdL8i/RtaPgzKS+YWWxZTUrcH2UDauhbokDjmChT
         OQAScQOzMLy7c4SVij8IR55JqlBZRoxpZE4vezR93jeNgJGp24d4cL9J2gbmkavRTdTF
         6p/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRXS8tM+rb30ygIbdTjOMxib33mj9VgRC9Oyc94RXsk=;
        fh=/qNOXQLtE0xeJ+RAOmZbESIyvKpXgk47Lol56LV4P8c=;
        b=i6uIuogBEYhQUyBnGWfHtT0FOLIFwPvwIN9BqrtK1A+qtUH90VOnRlSbR7xzYiH1NZ
         2jMKJqYSHtvJc9xajQOLfywfWCPCCVIYgg3L5/EdAKZCjM5FZBxYAe4KCY5A6OEhTH+N
         1eybN3IVYn8/heu3trSRSDZUGOccJxGvICCh+58vKjyP7ts2u1EA2nxAKf9FSHxXTC4g
         pdoEmDtYGiXLgntqE+nEkiwXZMULYUcnr6e2owc6CCk6vwX/L3nBxgKyzwJomLIJ3KdQ
         uUkJGOSBGDLh/njMPGCenN9YgO5bs7pUSicy7lQeO/zjSBTBBtqsos8h2Oe2ZyrBjRpM
         ICzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786177361; x=1786782161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRXS8tM+rb30ygIbdTjOMxib33mj9VgRC9Oyc94RXsk=;
        b=uG9yetNyEU+gXygwfdDgrXEJgoedvpg7Z33WDvtb5LVPRtFNJikhcXu3uh1WKN8tH5
         MsUkbrlnZsjaKmjhYRTankjNMd7Mrmbdw9HYy4Z0c2se9MIF4Dql3Nytg0sThAw7kK8/
         lEwXKVoiI+RcgIhv82EtufZY7S7tYDVoPZstWtJlLzde5Yz2Izl+YkhNOCkqLFBM2brT
         OjGi9pyaJiAbKNERme7lQffsCJMdy7RNXHXqt5CEjMarhNvzMOKEUC2GPku6mqvEB5Ab
         jzPmZY6Lfg7QxxmeVCJeIIouUV7owF8DyLufHAgIU2MAV28l5MkCWJTICncacGhlQYF2
         GbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786177361; x=1786782161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRXS8tM+rb30ygIbdTjOMxib33mj9VgRC9Oyc94RXsk=;
        b=ASimF0/r2rN20+t2GY+SeN8e4liSoXD7TpOe2dF6PZP7+QjBAx4FdSJ+7ZUNP5U057
         NuSuSbN9cbi7nL+Q0wlb2h3NpWdCm3SvJNJX7BxvueHJMRwliKI66l9ts5MgfE7TCIQP
         wx19Qsp7EkICWvxkDPC+mLr15K9Wczo0CNDY+hr2RCdizgTM+X3SuUYUzxndyN8a9xHQ
         sXDLtryTNuV884HeeuXojEzScE8KxbVtKxelEiXTW7sX3W4SSZymL39p/G9cY+aA5+UW
         PI0ObIgyUIclPiW/7RmTddczb/hwltz7EmIm7wI2ZXTITmpnsdDPonyVfmX+gyfKEtSa
         UjHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYoYEJpV3fjgKg2M8/yKlFcTFzDipAqsKdkIVxAXDTlFuJreOxkTKcwuaiLajJt4eCwtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEAsvxIMXuT0k1bgBQh2uG+4mTRDMeKT+HhTPfN4yhUuTQTQK
	lJdsrv9YIUt7wad2q0CYlcjHOreFns+YKyqAxlZcsjuJSaVjXwamWaXURYSgcqplF62/uc03mVs
	PZvQHVQewxohFTrSdW3HhjvqSn9tqisCerSY9a/KNuQ==
X-Gm-Gg: AR+sD101577sJxXNk/tZ1wi+s7zXWSWn96XwLrkbglmXfQMWDqEMAauOCPWEnzhq4pa
	mNf4UicJMUAOQuF8fKR1Pdl6PqM6xvjbHVHMNbKfMx7/cQXoxowow8a5JR+dusFgCmfkUp3cAtO
	PFCyF6AG1UTvSLVKcjPdjNnHFzOJ6b43keijWoH3ibZy3pTE9D4JsOVbHN81sqDUrMX0tWxR2cT
	o7Y5KPaH79i031MzSL3CwCZMRfheTQxiC7xZyh3bY1sKba9CCQEv2EvnKiSwST3BnSwMI4yseGa
	HvllGEs4ieP6az4RIkS4jRGIw5Z2wB/czxUW/K60zyMLB3Bns72yo+D3STAiY5aOFZXdp1o5qd0
	PY1Ars4MUF9hvMLOTUMqxXfuMTX35WTfbm5TnuY49SHPAjqMAsTbIJncA63NB8XxzU/Eo5+XR30
	Q=
X-Received: by 2002:a05:600c:314f:b0:497:fe58:d714 with SMTP id
 5b1f17b1804b1-4994e7baa31mr298099605e9.9.1786177360994; Sat, 08 Aug 2026
 01:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718040000.010.826fe94e-caplitmus-rv@iscas.ac.cn>
In-Reply-To: <20260718040000.010.826fe94e-caplitmus-rv@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 13:52:27 +0530
X-Gm-Features: AUfX_mzJLGOWo5ULHzUQYvejWaeDBnFMfy6noBsi8JH80jIcqgMsis0BI9D48ek
Message-ID: <CAAhSdy1Mkfekf5ViagmynJMVii10kFZO=XbgNe14pM_f7Yi78A@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Avoid one-word masks for SBI v0.1 all-harts
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 10:09=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> KVM already treats a NULL hart-mask pointer in SBI v0.1 calls as all
> harts, matching OpenSBI's legacy handling. The current handler builds tha=
t
> target set as (1UL << online_vcpus) - 1 before iterating the mask.
>
> That expression shifts by the type width once the VM has BITS_PER_LONG
> online vCPUs, and a single word cannot represent larger VMs. A count-base=
d
> mask also selects the wrong IDs when vCPU IDs are sparse.
>
> Handle SEND_IPI with a NULL hart-mask by iterating all online vCPUs
> directly. For remote fence calls, use the existing hbase =3D=3D -1UL
> convention so the common fence request helper targets the whole VM
> without consulting hmask.
>
> Non-NULL guest hart masks keep the existing v0.1 behavior.
>
> Fixes: a046c2d8578c ("RISC-V: KVM: Reorganize SBI code by moving SBI v0.1=
 to its own file")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_sbi_v01.c | 52 ++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_v01.c b/arch/riscv/kvm/vcpu_sbi_v01.=
c
> index c9c323d4577a9..de544ea3f28dc 100644
> --- a/arch/riscv/kvm/vcpu_sbi_v01.c
> +++ b/arch/riscv/kvm/vcpu_sbi_v01.c
> @@ -16,8 +16,9 @@
>  static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *vcpu, struct kvm_run=
 *run,
>                                    struct kvm_vcpu_sbi_return *retdata)
>  {
> -       ulong hmask;
> -       int i, ret =3D 0;
> +       ulong hbase =3D 0, hmask;
> +       unsigned long i;
> +       int ret =3D 0;
>         u64 next_cycle;
>         struct kvm_vcpu *rvcpu;
>         struct kvm *kvm =3D vcpu->kvm;
> @@ -46,20 +47,25 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>                 ret =3D kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_SOFT)=
;
>                 break;
>         case SBI_EXT_0_1_SEND_IPI:
> -               if (cp->a0)
> +               if (cp->a0) {
>                         hmask =3D kvm_riscv_vcpu_unpriv_read(vcpu, false,=
 cp->a0, utrap);
> -               else
> -                       hmask =3D (1UL << atomic_read(&kvm->online_vcpus)=
) - 1;
> -               if (utrap->scause)
> -                       break;
> -
> -               for_each_set_bit(i, &hmask, BITS_PER_LONG) {
> -                       rvcpu =3D kvm_get_vcpu_by_id(vcpu->kvm, i);
> -                       if (!rvcpu)
> -                               continue;
> -                       ret =3D kvm_riscv_vcpu_set_interrupt(rvcpu, IRQ_V=
S_SOFT);
> -                       if (ret < 0)
> +                       if (utrap->scause)
>                                 break;
> +
> +                       for_each_set_bit(i, &hmask, BITS_PER_LONG) {
> +                               rvcpu =3D kvm_get_vcpu_by_id(vcpu->kvm, i=
);
> +                               if (!rvcpu)
> +                                       continue;
> +                               ret =3D kvm_riscv_vcpu_set_interrupt(rvcp=
u, IRQ_VS_SOFT);
> +                               if (ret < 0)
> +                                       break;
> +                       }
> +               } else {
> +                       kvm_for_each_vcpu(i, rvcpu, kvm) {
> +                               ret =3D kvm_riscv_vcpu_set_interrupt(rvcp=
u, IRQ_VS_SOFT);
> +                               if (ret < 0)
> +                                       break;
> +                       }
>                 }
>                 break;
>         case SBI_EXT_0_1_SHUTDOWN:
> @@ -70,29 +76,31 @@ static int kvm_sbi_ext_v01_handler(struct kvm_vcpu *v=
cpu, struct kvm_run *run,
>         case SBI_EXT_0_1_REMOTE_FENCE_I:
>         case SBI_EXT_0_1_REMOTE_SFENCE_VMA:
>         case SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID:
> -               if (cp->a0)
> +               if (cp->a0) {
>                         hmask =3D kvm_riscv_vcpu_unpriv_read(vcpu, false,=
 cp->a0, utrap);
> -               else
> -                       hmask =3D (1UL << atomic_read(&kvm->online_vcpus)=
) - 1;
> +               } else {
> +                       hbase =3D -1UL;
> +                       hmask =3D 0;
> +               }
>                 if (utrap->scause)
>                         break;
>
>                 if (cp->a7 =3D=3D SBI_EXT_0_1_REMOTE_FENCE_I)
> -                       kvm_riscv_fence_i(vcpu->kvm, 0, hmask);
> +                       kvm_riscv_fence_i(vcpu->kvm, hbase, hmask);
>                 else if (cp->a7 =3D=3D SBI_EXT_0_1_REMOTE_SFENCE_VMA) {
>                         vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>                         if (cp->a1 =3D=3D 0 && cp->a2 =3D=3D 0)
> -                               kvm_riscv_hfence_vvma_all(vcpu->kvm, 0, h=
mask, vmid);
> +                               kvm_riscv_hfence_vvma_all(vcpu->kvm, hbas=
e, hmask, vmid);
>                         else
> -                               kvm_riscv_hfence_vvma_gva(vcpu->kvm, 0, h=
mask, cp->a1,
> +                               kvm_riscv_hfence_vvma_gva(vcpu->kvm, hbas=
e, hmask, cp->a1,
>                                                           cp->a2, PAGE_SH=
IFT, vmid);
>                 } else {
>                         vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>                         if (cp->a1 =3D=3D 0 && cp->a2 =3D=3D 0)
> -                               kvm_riscv_hfence_vvma_asid_all(vcpu->kvm,=
 0, hmask,
> +                               kvm_riscv_hfence_vvma_asid_all(vcpu->kvm,=
 hbase, hmask,
>                                                                cp->a3, vm=
id);
>                         else
> -                               kvm_riscv_hfence_vvma_asid_gva(vcpu->kvm,=
 0, hmask,
> +                               kvm_riscv_hfence_vvma_asid_gva(vcpu->kvm,=
 hbase, hmask,
>                                                                cp->a1, cp=
->a2, PAGE_SHIFT,
>                                                                cp->a3, vm=
id);
>                 }
> --
> 2.43.0
>
