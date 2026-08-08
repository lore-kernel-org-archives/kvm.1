Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5BB3E51F4
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786196097; cv=pass; b=h1mTmCo3V30sbs/T4G/RsLv3YF/cMYgmja3L1N2+0sz1LHTeOxp2WafB+zupJaATzTlshsEEBGqYZTCNQyOM/jF7+CcSDF4x5wchCNdy8jUbFRjIy1V98NgHvdsEN4O7um89loBZrTQpe0+Ex1J+9pOEIgfbGPsNRymzf8SK22s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786196097; c=relaxed/simple;
	bh=zwTrg49edgse317noppGMxg2ocpBELbZBZtjuGPS97w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0QM+J/EJfCpKLuYQNqaC3XVVp4MZGfGbCaqR4o/ASUXPOuHVgGDfHxiQrW1YPw5vlHa9jjGeO8LiYWGcAJvaKw9IXyHUYgkeznaNpIeiKDKJ8z8VAgFl+hJYjT8LOx5K64CYdcGtu1oLfc4Nj3JpmJxOpBP79ZSgAhBtqejU7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=qrTol5Mo; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="qrTol5Mo"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-476a130c138so384256f8f.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 06:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786196093; cv=none;
        d=google.com; s=arc-20260327;
        b=oyu1Ru1DQPIgHfNyqprXFml62YQS/10a3Lwp1oGLcC4AQB+xc9HnVwGt0eQ5zRZKfP
         D+0SLEq3gHr5Ub0zFO/S/fM5vjzJIDrtKPBudk2AVkIVSRzZVivSUZoimSJD3BNZcnZ8
         98VdNa6oGLtM9UpMrWY5YzzxRiiEt9n2ExPZqMyCV13St3g69Pf9L3DfdotScVR9U+8l
         VZT3Twq84cG8APWQViFe9uZYt7nbP3lEzM4xLwYRSYPj6+q8+wDFxY2oHyYrGcyraFHm
         uzd4MzEs72BOSrENbEuzorbVJ0x6gTulx/D5oQv8WGo8HQh2r1vu1Uf5y3qCf+KExVua
         5cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yl8fdA8yXOrqRq+FEuCqTh3tBcUJBI/1F+CCsyjPVok=;
        fh=P4jZVuLHFOyvfUbJKQmmR2NQpjWNMHqhmQDAiIRD7QA=;
        b=LYj10h18RzAVsews9cv7QHn2BVZHDPhYerEKtA2y8VVPDrT9BnbZQWWOqn98WGfdk1
         IWgevvxibjqg745rzsiMhqyGfVIjJywcRfYZYheioZ6IuSewdQR+scoWsRpoyq1G1ewt
         Y9ge4ak/dP+OEAV/+LsN33FofCa9CRJhZMaxeJBYRT2EU89BLWfpgPLZfYB1r3eBHrhy
         PKEA3RgodpRjbX2RxMHlMDYr+G7j8Ks2UlroYGam71xdCtn+mIyYiKr+/294yRAd6tPT
         0VsFjQyiiTsNL8an/lHYhTyMJIsQARP5U0fAi+jzAbGR1WRfSewuzL9JOGGHQmlNYHKt
         ORzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786196093; x=1786800893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yl8fdA8yXOrqRq+FEuCqTh3tBcUJBI/1F+CCsyjPVok=;
        b=qrTol5MoPX83CLSoRVHu+lMOx8dgIwDwLZxAYiUrXBFu5Y+I1nKl92+86VlKidHWwC
         Azn2NGnKY+nf27J6XRZPl2I0ZKuEvqEfO3L29T24GFq5LSur7qYkkQMqEMlRcoboQNdI
         gQpp9loydMIeiM+t1HJ1Anl3Ep1cjklZxoj7aFfmJzFO9zEwSFBdWWRlhunf29oxyBNC
         epj1t5YhWUJwv+6T33Hsn7p8nai8MGv5F2Vc/Zt7Ej17Es+/2Bp0e5LicK5X9h+yxupP
         NQZrtUoZ7OYA6OknQicfs1I2gWfOy0IrEY7STyr7SCBifjqtItaLhkyzdR4N+pmBA45L
         dXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786196093; x=1786800893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yl8fdA8yXOrqRq+FEuCqTh3tBcUJBI/1F+CCsyjPVok=;
        b=o+GydPNyDNDuyknTcWyErJzWS3uCULkzxSgHRCbdb8jJ3D/b9fCaEzGic6ZPOw+pzz
         8hoUmmF1iIk4P06IiPuKri9iMvtEy9l5u39KYxBiYla4kv1Pr+HjYJ0Zx/sYTDig7Lob
         1uZjhyXpKp22eRsvopEPtrmv+Oe9H9JR57BxBvILfBB/Ji0WpCB48AyafYZnwXv7Qdtr
         ijUGXCPM6ioRBhdVSADAx4rDXK/TbBgJTG/vBz6U+CyMyalISUPaOTg5ODWZkRDWkhfB
         nIhJk3u923ueCoHSFlvXwBymPi1eAF7zITBn7x4CcXV4bY9xdWhe9jlH16iz5AukHKKk
         WhWw==
X-Forwarded-Encrypted: i=1; AHgh+RpZDtDgPD0TX6sdlOGvQqn/CzNc6UoJj0tImOLnAi+tw1pQydZcTHlo5CF5iaE9vhcObSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfZY0lYQLm1JNSOtQ3r3wcFrYHHO48NHo42z6b8CG/A32WkbJ
	UPV0lDsmqswlvneCqVSSVHWSE3MPTYIQ0y5gJLS+pvj2s5yRTngBihfb8e/XeIB5RNcEsx9uoMn
	5urS4Sx5sOQV250gZC7t7X+SsW0wVMkYzFx6/4LyQDg==
X-Gm-Gg: AR+sD11Dnw3nDbrhgcCzenHDLZ1fVx0aCVxfPLcCcsR7LBXX8mINgSPYibzhCiVZ4F5
	P7rHOr2s0M+Fob8gQwh/xR28cIjd5Rozb5zDOB13oLSLg+DX0TPvRnjlXQphkAlFnBuDLjOT7g7
	LZyt38QshvrgFO9q5Z5hWzXfnBLR5yffoGpeFpbFuKDphSsy0HqFZjMdtJ7XwLpcW2C8mQg7CDh
	T1SsWh+MMvPZygkUZdaWloujBYlOi5VL+Ub4Cex4D2IBYIHUwKBG1RRy5bnXnfrR/z9ma0MF2mv
	9M/IAVgSjRLhmW7hBk7DEJLneqmYP0vc+6f8v1O2Y2ENKFzR7NMAinopzaw0nq2Y+SgfotKZeF9
	cmWDi09bRgT7+XDhCkyxv7VMa9GBoy1MSkUI1aAi5fy7TCtCpsW2jih2C6gp9kOYJyuDIkUc0tw
	==
X-Received: by 2002:a05:6000:22c6:b0:480:d9:ee6d with SMTP id
 ffacd0b85a97d-48000d9ef38mr19159307f8f.19.1786196092900; Sat, 08 Aug 2026
 06:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730092533.1369531-1-2045gemini@gmail.com>
In-Reply-To: <20260730092533.1369531-1-2045gemini@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 8 Aug 2026 19:04:41 +0530
X-Gm-Features: AUfX_mxF5QLiDNwWJi1r2zyquEo16mGQMd4pYVKBuDSSM2KPfXd3zXkY1Hm3xzY
Message-ID: <CAAhSdy2s7TuchTcjw7S5HQ0kEtOX1zYevNh9H4jZghaU3hHcpw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] RISC-V: KVM: Fix PMU event info array size overflow
To: Guidong Han <2045gemini@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Naveed Khan <naveed@digiscrypt.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:55=E2=80=AFPM Guidong Han <2045gemini@gmail.com> =
wrote:
>
> SBI PMU EVENT_GET_INFO stores guest-controlled
> num_events * sizeof(*einfo) in an int. On RV64, num_events =3D 0x10000001
> makes 0x100000010 truncate to 16. KVM then allocates one entry but loops
> over the original num_events, causing out-of-bounds reads and writes. A
> nested guest triggered:
>
> BUG: KASAN: slab-out-of-bounds in kvm_riscv_vcpu_pmu_event_info+0xa4/0x14=
2
> Read of size 4 at addr ff600000074d46b0 by task init/1
> Call Trace:
> [<ffffffff8006471c>] kvm_riscv_vcpu_pmu_event_info+0xa4/0x142
> [<ffffffff800690c0>] kvm_sbi_ext_pmu_handler+0xca/0x268
> [<ffffffff8006779e>] kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
> [<ffffffff8006008c>] kvm_riscv_vcpu_exit+0x48c/0x540
> [<ffffffff8005ea0a>] kvm_arch_vcpu_ioctl_run+0x37e/0xc80
> Allocated by task 1:
>  __kmalloc_noprof+0x19e/0x4b0
>  kvm_riscv_vcpu_pmu_event_info+0x72/0x142
>  kvm_sbi_ext_pmu_handler+0xca/0x268
>  kvm_riscv_vcpu_sbi_ecall+0xec/0x1e6
>  kvm_riscv_vcpu_exit+0x48c/0x540
>  kvm_arch_vcpu_ioctl_run+0x37e/0xc80
> The buggy address is located 0 bytes to the right of
>  allocated 16-byte region [ff600000074d46a0, ff600000074d46b0)
>
> Store the shared-memory size in size_t and reject multiplication overflow=
.
> Allocate the guest-driven array with GFP_KERNEL_ACCOUNT so it is charged
> to kmemcg, and use __GFP_NOWARN to suppress allocation failure warnings.
> Use kvcalloc() to allow vmalloc fallback and an unsigned long loop index
> to match num_events.
>
> Reported-by: Naveed Khan <naveed@digiscrypt.com>
> Closes: https://lore.kernel.org/kvm/178345245327.72065.132497164507085398=
54@digiscrypt.com/
> Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guidong Han <2045gemini@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3

Thanks,
Anup

> ---
> RESEND:
> - Send v2 as a new top-level thread instead of replying to v1.
>
> Changes in v2:
> - Use an accounted, no-warning kvcalloc() allocation and kvfree(), as
>   suggested by Sashiko.
> - Naveed Khan reported the issue before v1. I missed his report at the
>   time, so add Reported-by and Closes tags to credit him.
>
> Link to v1: https://lore.kernel.org/kvm/20260718153620.829378-1-2045gemin=
i@gmail.com/
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index bb46dcbfb24d..8e1f6abb84e2 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -12,7 +12,9 @@
>  #include <linux/err.h>
>  #include <linux/kvm_host.h>
>  #include <linux/nospec.h>
> +#include <linux/overflow.h>
>  #include <linux/perf/riscv_pmu.h>
> +#include <linux/slab.h>
>  #include <asm/csr.h>
>  #include <asm/kvm_isa.h>
>  #include <asm/kvm_vcpu_sbi.h>
> @@ -479,13 +481,14 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *=
vcpu, unsigned long saddr_low
>                                   unsigned long flags, struct kvm_vcpu_sb=
i_return *retdata)
>  {
>         struct riscv_pmu_event_info *einfo =3D NULL;
> -       int shmem_size =3D num_events * sizeof(*einfo);
> +       size_t shmem_size;
>         gpa_t shmem;
>         u32 eidx, etype;
>         u64 econfig;
>         int ret;
>
> -       if (flags !=3D 0 || (saddr_low & (SZ_16 - 1) || num_events =3D=3D=
 0)) {
> +       if (flags !=3D 0 || (saddr_low & (SZ_16 - 1)) || num_events =3D=
=3D 0 ||
> +           check_mul_overflow(num_events, sizeof(*einfo), &shmem_size)) =
{
>                 ret =3D SBI_ERR_INVALID_PARAM;
>                 goto out;
>         }
> @@ -500,7 +503,8 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vc=
pu, unsigned long saddr_low
>                 }
>         }
>
> -       einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> +       einfo =3D kvcalloc(num_events, sizeof(*einfo),
> +                        GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>         if (!einfo) {
>                 ret =3D SBI_ERR_FAILURE;
>                 goto out;
> @@ -512,7 +516,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vc=
pu, unsigned long saddr_low
>                 goto free_mem;
>         }
>
> -       for (int i =3D 0; i < num_events; i++) {
> +       for (unsigned long i =3D 0; i < num_events; i++) {
>                 eidx =3D einfo[i].event_idx;
>                 etype =3D kvm_pmu_get_perf_event_type(eidx);
>                 econfig =3D kvm_pmu_get_perf_event_config(eidx, einfo[i].=
event_data);
> @@ -525,7 +529,7 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vc=
pu, unsigned long saddr_low
>                 ret =3D SBI_ERR_INVALID_ADDRESS;
>
>  free_mem:
> -       kfree(einfo);
> +       kvfree(einfo);
>  out:
>         retdata->err_val =3D ret;
>
> --
> 2.43.0
