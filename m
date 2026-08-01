Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D382BEFEF
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573317; cv=pass; b=qanqqT2PcAJZ/Cw2aEQF4lKix24z5E4UQVyUr1kNWs4G/4Gpi/XPGdSXEN2J+cBQFfqc+etuDMKha84crsStRBxl9vrd3oeEIDWVlDfqHsnySzUDFHcwa8blPvdjWHDjPXSw39CLwYe2zveN51Dj4S5nioj9khdqZRwwnOOIfs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573317; c=relaxed/simple;
	bh=JVLt/VfCQ4ybmxrrl52fXJwS0Xia3Oy7iSLA+TtcEjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dELWJ56rD1oJ3PPCDDSc9d9QGXgz3HbPOtoY/L2Bl9Y1F0pmAmCb49vyJA/nGdCPL8pV/pwU35MTQatMQQFt9RDb8UDmaVlBLpemyvvrNlduFrHVnM1mMy0ALiYK3+XmHzbw99fg2uLc53VbEVAwyqTpHMf/wNsHj5RUsn+dJ94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=TPCChKIa; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="TPCChKIa"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so989523f8f.2
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785573314; cv=none;
        d=google.com; s=arc-20260327;
        b=j2FO86nhnM3W4vTBCxVVKcxQHdDe+HoYLxdX2M7917aVHrNOVx9FXuch5S7r671GMq
         wfm9FwRL0mbtVIDOlrjrjYjArSzrooBMLuhm77SQ094LdYjTbwoAgi22hBQZCr7c7SeQ
         W7jFXFfnkVS3+qEnugNREWZzRahviM7H5pCYY/oaYsDYvarh1xwc5L3fK0qGc4FP9wjK
         XeaGCvSH1RrG27B3GPgxqKQJzqFVt1UpnXEHIF9WYXcATOFdKyoGnzTMdPQf79hltq6f
         RjLQIcf/QJ600hp9FiXCZ0yTWco/qIZt8vPekzFDG8uebwzaJO9e4oZKf9AKn7ln6Zb9
         Aipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pjXyNG4M1zJXOBT1pnPYT12PCibopv8OC4ryVZx/p+M=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=n0IPdxFLwuqUgm6dXnOfGjLeVn3xmxRNXxY8xyefA+tt9Kdgxd2En8J1YxypGsRuSJ
         Xi4eNRkrbezmuILsMoV1D4M6sIvzICKCtWKIKbdioGB+rh2xKZkkeoNHZ13Thp16Dp+W
         aRpgQNcxDkryYJQ9IYWkfaHmXP1uLfJjQYMGTktZWoCpHrK6lnWwQ63neIjBTYESUU7q
         9icvttEJ+5F5l5uUhSO5R4VHrUqap3SiIE2X3lK2i6QOkO5nR4msCsRnm5vasWW1ts+Q
         WZNUqF3syeN4d5O2NS04wDmhL/eVblaumLqtPsPCljm8UFikdT36rGaYf99A78Dbbpxn
         g7UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785573314; x=1786178114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pjXyNG4M1zJXOBT1pnPYT12PCibopv8OC4ryVZx/p+M=;
        b=TPCChKIakFXaUPTnjrWarj44+oVEFAdngLVh3+sTDUO9S+gcZ2qlLSNLCMEbEgt7os
         lvNxlmEEbByK4ZT4P7GFoBz35zh+SigegF6zprqp+n8PRhaxQKfVRjF2sMmxBdoSOwy7
         MevZTi9sNfG+ExLPTNs2l+3qaQg5R4K3MFnS+4C1bVPor8TAMpiQHSs3ZVxmxXkHyE5k
         Ht7LG5xGISam+020bWDBNkfivqeAiFkdv7WIzzyPEmQ10W3O6nbmZ1C7a7jNCHYLq0UL
         IVO/K//GBCMgPBQ+6j3ES9D0drywrUrzLitI2uzWO7KlDJ566Kgs+K2vtgcb0AYlQyCV
         jgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785573314; x=1786178114;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pjXyNG4M1zJXOBT1pnPYT12PCibopv8OC4ryVZx/p+M=;
        b=YXd+mDcUKB0j4zAAeWTI+bIM1xEJftj5RwJebqYQ0DGkj1ltFI3cKzSmYUYh8k4QFf
         2CNfiWlp2tzewdqmrWMAZlX8+tfd/Yv8fnZZbNOErBW6hVy2KCX18Lzr2F3Qsn9O0ijQ
         jlX09esxLUA0LFsi0Z5+rny1bzS13Bb190kqMjIXk0kxsACHQpQ43Jyvdfxb/qhNglr9
         QYEqGIJc6odN8xdOr1uEvm+ZWKcFWyewwaV7UDKOI4w9TIoQLijDhXVVdrZmqUDZNiIg
         QRYMyyu39JbDyYPCdekQjhmSIcgr4cC6BR4moJ8SPLhhuAkn3xK0bmTOvmsHSX5zWQd/
         HKTw==
X-Gm-Message-State: AOJu0YweYLtzuFMAUA3BJykZ3r2eXEUlqZSAgyc62nSsxlpztfLLEs61
	RD8Axw66FVmboelc9jgeoP0FU5nnVE9LGB3ZdvSxMlGYi2qCocHaZ31wGMQelMF5v81BSMsHGwx
	DxOLJEo4+unklvW1150f7tobtsi7gQjPXvwhu/lL5lNRdx3rnsy//ck0=
X-Gm-Gg: AR+sD125wYXa/nPSooGXRQoiDWQ+E4sa8o27sJJkWenms0H3jPhn7DglKaVbM0L52bn
	YJMBzHxbU35zuXth5KNLs9q1A3EhPuopUfQri2gHPeiSZGSNC0+W+r3K86Q96X3fLyT2+0iN2Xb
	4YqT8K7oyqLVusZvlJskUZSgMmd+6XuhHaFSUkaPRXwPExYsT1CKLbIDg/pCRkzTAzPxBlNkdqW
	V9hBInUUTcaxA5wF/q0ETSTDNuwCvr0H0HEWX5QJv/9VAP2Mg/Erm77v89R0it7wxY8Rl3B50Ra
	AVt1aDdVw3nwiBihhJP75yqQ1+OYqH1/gjK78nmkXKNkOnuX2MkG0l9S6jJeHS27z1mKMhdlSXZ
	5TTbWtQms7Mlfwnp446CfK1qmH2xIO1lOc7Ar28mTdoHwxNINP9zn5AldL2R4r8Fu
X-Received: by 2002:adf:f504:0:b0:47f:6e23:64d6 with SMTP id
 ffacd0b85a97d-47fd72b070bmr5048569f8f.16.1785573314037; Sat, 01 Aug 2026
 01:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731093833.1551341-1-wang.yechao255@zte.com.cn> <20260731093833.1551341-2-wang.yechao255@zte.com.cn>
In-Reply-To: <20260731093833.1551341-2-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:05:02 +0530
X-Gm-Features: AUfX_mzbsVBnjZ3iyM-h0AGkXdQtsU_1jaxbI5xdNw7bsmFJ-QMjnUZ7jmAm6zw
Message-ID: <CAAhSdy1QwcYv_Dz0s5P_9RjRegJsJQz8fjiskGNmYYFXGOnB2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] RISC-V: KVM: Separate req and fallback_req masks
 in make_xfence_request
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:12=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> When handling hfence requests in make_xfence_request(), the current code
> uses a single 'actual_req' variable and a single vcpu_mask. If any VCPU
> fails to enqueue the hfence data (because its queue is full), the request
> falls back to 'fallback_req' for all VCPUs, even if other VCPUs still
> have available queue space.
>
> This can cause unnecessary fallback for healthy VCPUs, and more seriously=
,
> those healthy VCPUs will not process their already-enqueued hfence
> requests because no 'req' is set for them. As a result, their queues will
> quickly become full as well, degrading performance for SMP guests.
>
> Fix this by maintaining two separate bitmaps: one for VCPUs that
> successfully enqueued the hfence data (req_vcpu_mask) and another for
> those that failed (fallback_req_vcpu_mask). Then send the appropriate
> requests to each group. This ensures that fallback is only applied to
> VCPUs that actually need it, preserving the efficiency of the normal
> path for others.
>
> Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on V=
CPU requests")
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/tlb.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 993b25ea94d67..c54522decaa64 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -332,10 +332,11 @@ static void make_xfence_request(struct kvm *kvm,
>  {
>         unsigned long i;
>         struct kvm_vcpu *vcpu;
> -       unsigned int actual_req =3D req;
> -       DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> +       DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
> +       DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
>
> -       bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
> +       bitmap_zero(req_vcpu_mask, KVM_MAX_VCPUS);
> +       bitmap_zero(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
>         kvm_for_each_vcpu(i, vcpu, kvm) {
>                 if (hbase !=3D -1UL) {
>                         if (vcpu->vcpu_id < hbase ||
> @@ -345,10 +346,10 @@ static void make_xfence_request(struct kvm *kvm,
>                                 continue;
>                 }
>
> -               bitmap_set(vcpu_mask, i, 1);
> -
> -               if (!data || !data->type)
> +               if (!data || !data->type) {
> +                       bitmap_set(req_vcpu_mask, i, 1);
>                         continue;
> +               }
>
>                 /*
>                  * Enqueue hfence data to VCPU hfence queue. If we don't
> @@ -356,10 +357,13 @@ static void make_xfence_request(struct kvm *kvm,
>                  * a more conservative hfence request.
>                  */
>                 if (!vcpu_hfence_enqueue(vcpu, data))
> -                       actual_req =3D fallback_req;
> +                       bitmap_set(fallback_req_vcpu_mask, i, 1);
> +               else
> +                       bitmap_set(req_vcpu_mask, i, 1);
>         }
>
> -       kvm_make_vcpus_request_mask(kvm, actual_req, vcpu_mask);
> +       kvm_make_vcpus_request_mask(kvm, req, req_vcpu_mask);
> +       kvm_make_vcpus_request_mask(kvm, fallback_req, fallback_req_vcpu_=
mask);
>  }
>
>  void kvm_riscv_fence_i(struct kvm *kvm,
> --
> 2.39.3
>
