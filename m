Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF51477E55
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034354; cv=pass; b=qhhb/aF9Dh3/TpsMJkDxv1k9zTdsCvOe0rYah4/CBdS6sCdoFsYJ9mnGvyABZWUWzcldZnIB7e0FHVC+iVa4WbqIUVRyOGeG8Wkpsyd9P2TIc/4sUwz+HMI4ZfrbmDhL/I0oZJUoGjaXzpQfLhCaIcY5saOklVOFMWIHg8ixs/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034354; c=relaxed/simple;
	bh=AsSH8uYLmJ8E3d5H9aN+JcUcbw1Iy7bHBfhVI7bYUqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSjrcPbfEY+JZ1K6A6K3r4yh1PGpHhXioVEU/tJ0dXRlI0brqh00RFy8Ry1E7/auGQjiwbhnyXt+rG4WeJG2xpvNME0QDMlvElZwH4sn45YNOsrkvurtyShWvcD1ZyltzEYWkPbanQ7stvtmdtG+jn4ojiCxwBejYg/+gVRm7jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=pfbra8AC; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="pfbra8AC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso4220862f8f.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 06:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784034351; cv=none;
        d=google.com; s=arc-20260327;
        b=jDXxOhYE6KQdBIJrmrN1bbS6xQ6smYB5ICXYWVDIAsFqZsq/JG9EcNlZAWcj5KUaZS
         Z1wRzakIlocIvVCU4rhzwHG0hZvVrOHLM9lMR8mNgxPAmz89vM4/MpsKQfIyOQbfaWyW
         Cw6lSz0iBBcwf1ggJx7L+iR5SvezFxE33ZQMRvBt808GfBDc9vZNV3RFCIT7ZD0RGOmH
         0dxlwjH+rU5djtOTxOH9Q6HWjvosZZMMOt+0nCa7bmfvDNnHg+C69HpEwkBMdbO1RXoL
         JgHUXqr2Wwreo5T/MbnfN4I70mOxmXnnydWQ0OqtrmlS8aSceTuruDRxeuTgEFf7seiq
         0sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2NcAgNw8LwbuTMFTQaVIRWiehiXF9APpf+nCDY9Hko=;
        fh=y9eHF5LjpfwyliS/TIopjAzrLCi+MPEhb7gpYK3MFh8=;
        b=Q/8s9qLRBmocnaeIFDjbElW1o3G8o6JMLpk3Ixc89Fr+jdga8TDoRtVcvjnsMSRqgi
         KkfnVJU/4Wmmn+Mq7FuDO+5ve3veDgqCm8BJyvFNQj/bAwYEnNqqgnCRyDc9hTc6qKRG
         Tx03eSiMazxHpxZST4ou1cylHePV9b+j5+8kDuXjszpFY+25BZ1+nGSWBQZTbklNH5Ir
         hnhM8QXg1fPsvOdo6A/GwKfzWBy3UzSpt6ZmvAlG+MNitXmn7EftaxlZosJ6ylePw/yX
         D3Af9CCMW2QMEsjsGV4P4NHblTbHv0JLK5VEW4f/a6S9IrHvVQmgWxtDeCe5rpDYh3M8
         2upw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1784034351; x=1784639151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2NcAgNw8LwbuTMFTQaVIRWiehiXF9APpf+nCDY9Hko=;
        b=pfbra8AC17ZYhFwPdVT2WCj510xGPFAYdp7Wd/SKoSsljsCMK7cqYbtPRiWVj+sVV7
         blKiN6vvuq8phQdRY8Lfj95Rg07HbzyoU4EcsulbjInJzkmqkdsiMqQ3CeMOMsCZse2R
         2HG1bhk6135YogWx1XKcm0fEmnpEsjxgwd1Jhb1ihGj4ePt8rtjFhW/UEM41wCHjyARP
         xcijHJPgH40CRYx2oA2Mxh0C+X1q+EX+uWdgUrb1QdIbGfIx3gY49AqwmQ7ArWhpMW19
         VrFlj2wcq56oEf6RxNFlmKn5K3LtEvkvSpqwTcWdxhgYstUdFk/6xHBzIGKKcd0Vl2XQ
         OnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034351; x=1784639151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2NcAgNw8LwbuTMFTQaVIRWiehiXF9APpf+nCDY9Hko=;
        b=hLp8PVriViiOLkWFFv/3o2nIeg71K95mkG+XkHe2CyHhjjyyofq51SoGN0cI2/IwnM
         OpweLsJbLAtc82oDIBHTD0LYpqv2Yu5FOcukqQk2OfpIQxnh4Kt0xaKERu2iFAeTDC7n
         Nf4UNWYXKYgJ6a8DK+ldv6f4BYv2Cvd2YbszlRUF5N3GkWVoJsQYoX33LiZVNxvRC8aM
         7RlaUfn/E2b6ZkEPKrQPKpI/IVNmBBAqQOUcHw7g9+l0c92QZjewEZF/UVBX7gwmi2+G
         3sHxZS+/4gkGTZ9wVGWHAcC2uD+sIY4veEdbPnDvx7AKxvPdrw3xJqgBYdq9PcDZ/yd0
         vZwA==
X-Forwarded-Encrypted: i=1; AHgh+RqJ/mHpyOIUrzldqtLUJgFu6VxkZ/HvLe7a5B3mBAVVdZJY6Ac2RIGu8IAu2QT8GigwIac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lMhW6t5DzxqnD5bnugTY9hxzl6/1PuZ4+puRWxCbg9a/9nEI
	z0wfdyMJ6MvDPMAMAYUJleSzHbzOzwvXiuhYh7EyqUxxmZQ7a61gbeArfa3XbxFnkBGGkWer5AW
	S0+cTHlR6N0Ea29fLRwti3KgX3fPSbBiP+bdgO0G34w==
X-Gm-Gg: AfdE7clIts2M0LewGrDxBGhzzlF7dalVFAJk1ETUnRUorVkMYJUb/ZZW/TWgBZ+sVub
	z+s8EV/Yp1oM4rzkUKWgmncWxDOrX91mTiYMdOoTjy47iqW2HDo8JaC1ywvraRtbnZ++5zDAoBY
	6V8O/BM7RdkQg//zN4VslMCIm854xsVBPt8BjKIiC1ROL6MyESe7N01x/yieg31ojXV6mn17xls
	hKRTvmRkIxSJXwhXFIWOIcxENerAhexBvvlp1q+SZFnb5obSk87OgPVm8C1NoT+AsPF29lRlxXv
	WnVfYldnhQ5rlpPkgOsCtlSKvkHVzl2l0g2jgyAqXHWBVhtek3Yw81dNd9RQTrbDK7sfsTElwmx
	hVJmc08i1d1oXDtE=
X-Received: by 2002:a5d:5887:0:b0:470:6dc:848a with SMTP id
 ffacd0b85a97d-47f2dca7fafmr15576550f8f.2.1784034351347; Tue, 14 Jul 2026
 06:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707122548.281685-1-qingwei.hu@bytedance.com>
In-Reply-To: <20260707122548.281685-1-qingwei.hu@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 14 Jul 2026 18:35:39 +0530
X-Gm-Features: AUfX_mwNt_JswCBrkPN8wo_MZe_qdY6E8a8GFKfn-nzYnLb-iI-iMooL3KV8GcY
Message-ID: <CAAhSdy1F3jrK4eiuVvWTL1uidZxEsVbrNoDQ8gXpsK-3MgzyAA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Inject instruction access fault on unmapped
 guest fetch
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 5:56=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.com=
> wrote:
>
> When an instruction guest-page-fault targets a GPA that is not backed by
> any memslot, KVM has no MMIO emulation path for the fetch. Load and
> store guest-page faults can be routed through MMIO emulation, but an
> instruction fetch has no data payload or access size for userspace to
> complete in the same way.
>
> Treat this case as an architectural access fault in the guest. On bare
> metal, fetching from an inaccessible physical address raises an
> instruction access fault for the supervisor to handle through its trap
> vector. Reflect EXC_INST_ACCESS back to the guest so the guest observes
> the same class of exception rather than leaving the fetch as a
> host-handled condition.
>
> stval contains the virtual address of the portion of the instruction that
> caused the fault, while sepc points to the beginning of the instruction.
>
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch as a fix for Linux-7.2-rcX

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_exit.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 0bb0c51e3c89..6c8530b9f29e 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -38,6 +38,25 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, st=
ruct kvm_run *run,
>                         return kvm_riscv_vcpu_mmio_store(vcpu, run,
>                                                          fault_addr,
>                                                          trap->htinst);
> +               case EXC_INST_GUEST_PAGE_FAULT: {
> +                       /*
> +                        * No memslot backs this GPA and an instruction f=
etch
> +                        * cannot be emulated as MMIO. On bare metal a fe=
tch
> +                        * from an unbacked physical address raises an
> +                        * instruction access fault, so reflect that back=
 to
> +                        * the guest.
> +                        */
> +                       struct kvm_cpu_trap inst_trap =3D {
> +                               .sepc   =3D trap->sepc,
> +                               .scause =3D EXC_INST_ACCESS,
> +                               .stval  =3D trap->stval,
> +                               .htval  =3D 0,
> +                               .htinst =3D 0,
> +                       };
> +
> +                       kvm_riscv_vcpu_trap_redirect(vcpu, &inst_trap);
> +                       return 1;
> +               }
>                 default:
>                         return -EOPNOTSUPP;
>                 };
> --
> 2.39.5
>
