Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB703AC0D4
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859209; cv=pass; b=XfgdiCAN+fv7WyZkWXLdw3Nx3kTzFFsMWpyt4aPi+ewOnw0YmO5Y7EAuSBZCU0uXNPu6o+wFKl/NHsAV56K7E+vvL0U1L1EaWpR0LGT0VR4Qh+J19i+Ld1bsR9zDjN+dzEdA+NCsQFw73Ku52XZPIz9v1V/j29ndylAA/MN2f38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859209; c=relaxed/simple;
	bh=IhxgybiTrBtDOxHoMDpLJXIgUazGtbz1BMBYhnGZdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eh23ivcvze8WQZTYJKq89Nh41G7mjBuDREb+pIKMzuLm2BmzoyjtSWrdtNTAaHHcA0gXm5CfywiQFaMLuoy24c43DqmcoVn04Xpsxv+Tb9E2pTv8hXg4Q8NhjMInVAO+NOQjXUC2ZEeo7vYGC6hjkuWWWr259IcT1gPTqX3UUF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Z5QHjMEP; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Z5QHjMEP"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7eb85fb81so4200127a34.0
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 01:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859207; cv=none;
        d=google.com; s=arc-20240605;
        b=B1KKuIuDI2UppeU+1UexEZGC8DPbXIaf4G/7GkGcHiMdNDN7kTogz2Cw4N+8lbZwbB
         KIDBOpRq5dzWCJ6frNMSINHu/smYIZkUV0Un3LQ2duGTIDAEmQRHHSgnHtxprDSh6+d2
         UaaQx/5TiRL4ibBfgBzdOjcGRLDeHa2uVkuJWOmkewRFPve+gk7F5miEJj5sTRI8JvtB
         NnptGaJRpdkTqWlqebncsGznjRs1H1paWJMGrJYyeBk+GfXgGs3Ibz2GqBfgKhmCuD6L
         iHeO4mQ3ID/BM+okF/tNcn/sfEicBUJe2Ez97UTRcJZVXkuNB4m9EEb/5iUFRQui/sMA
         rjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gohPRZM3Pl5gGZYd1SEWk3NT0Z9V00jCIRMY1+DdSI=;
        fh=MbqrfQVppmldpNVVQhR0tLyK3WUUXUfjUPUDhyD89T4=;
        b=MO4hW7G2j1Geh3KXhfpmYWaeaPq/AGyNOAiy050gqOJlIaBv5h98YZqQDgn5b1wAKS
         t+1rZoQDxc0wp9lXWfLq03RQfK1+Q0n2Prs46CfRR7ixGY/xukU1+UaaY15BLkUinx2s
         YNR7tjpGpu7Az0DqIDAvlD6afGUiu86RMLg/yhLNDbIFyt0/WMQcMexNpy/+puRkI+tk
         BgZxGe6wBZL/KM3lU7koF0yYtqetopQSgDMF1+skhf5L78spC3mQkapLZjWfh+KrAG0k
         Vgm+mAymaCrlCAPvXCFyJn38DoUZpjFzCDZtWctBoweq8SDhhQjS/me/EKsFzvoQFSZo
         26cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774859207; x=1775464007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gohPRZM3Pl5gGZYd1SEWk3NT0Z9V00jCIRMY1+DdSI=;
        b=Z5QHjMEPBPtUlgT0HPgrKZ3jNS36dF3PsrH7BR+9nnVUjSORehFetYQbaA+TGU3ZI6
         h1wK7WxgPinzl7UeA/oT0wdN9UWSQpSkJgxMP5ldSBoTl0Smlsp8Tw29ZLzkIO2QDAE7
         icfwB6mw7fPevqXROl5wYdnoWRt9lpBTUfx5/SiKhNtPcZhKvxH0Wu8JtNTvOzYzW6pa
         ADA6TpbdsxqRxh8qpJlkzMuvYwNEnTKU1dbF4KnM9qepaTw+6w0qbh/TWW8ogYp7XP6J
         XwlL1ZQRIBTT/1foMxevnTKkoY9bUKXoWusgS/rhSpbsc2AbDUb0YXtac6HnKkTYVLkj
         ZOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859207; x=1775464007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gohPRZM3Pl5gGZYd1SEWk3NT0Z9V00jCIRMY1+DdSI=;
        b=knXeYb6/WgAKFHSJzvMfUb+mlNEarEMpAFq9PrUON2uXRng1YFEHAazrpC+dBy4FN9
         OZMjbVPtK/XflChPvthv0AufJ1uw2P9stOxmdhHhBpx71boBfTMslFD6U04aEfLjpcca
         qV82UMoQXR/voZZTOxl/S/nVK7Z0zItERXwNdk6w1OO/YYHaNIimu4jn8lhDHiCiyTIr
         A7fpqetNERiodTM1GWi6OQotH+xeF2nMBgU2C3wLY8N561azCehcokZSGEUYbY/T13mg
         OCH9hWhFts3c0mOWamgxxh+0zzYLFf07LStEvCdIf4DFW/UuG0rDUvR6URYn/M+NQ2WJ
         mYTg==
X-Forwarded-Encrypted: i=1; AJvYcCXnZx4qV5R/0TAB+4d+xD0926sPIAvwKKl1b7Zkxcr6rJkPslIBwnMgENXBew8jkvLQRdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/MEXSzD8G6lRpKo8Jx2Us7Zc2vInqpc77kAeaiFdU1bqio35
	oI3U1tKD0EPpta5VC/YZKxwxIPoQRSHOhEi3SJaXxL/cdDOhQ5gIL5lzqqSb4emPeIYCxB1Gd2p
	qUZSXTMsGULOOXqCII01BM4diRpN2Xkeu+ApWvZI8yw==
X-Gm-Gg: ATEYQzx6yei9kcbRRHD4IynUcbj1Sv9xxstBulo8voPy5808Fen6ijwA/lkW0Xqjs3m
	37vbVcbG0ISbdshc/kQrGSSgrcCo1FWA175j1+IdME0z6D0as1Dnhn6pntGo3LwVOOmGF59ubeO
	XPt37lZuQu4e5ZBoMAn2aiMXE4/NTjD6Tb43iYYFMuCNNZln+OIeh8UyswbDL0GqQdwYmeY5EtA
	30v07l1X42EJjEfYhfojLw/c7Om6fWouuVAy3uytl/SJJ+T1movskSdzr/waVO35td54jFqPV1V
	r82PkktPXgagvUyRt3ab3ExF0WF7a8puWdp8RotxrdX6iIh67+xKfy9AOJtiZnXV87XU9OIk/yg
	vgLnFCwbBcMlzfIkO7VbOqgzJ2Q==
X-Received: by 2002:a05:6820:f02f:b0:67e:2013:aa49 with SMTP id
 006d021491bc7-67e2013ab10mr5470274eaf.61.1774859207468; Mon, 30 Mar 2026
 01:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317114759.53165-1-r4o5m6e8o@163.com>
In-Reply-To: <20260317114759.53165-1-r4o5m6e8o@163.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 30 Mar 2026 13:56:36 +0530
X-Gm-Features: AQROBzBNAoeEH4dtJiurCDIIFIldpeiaCAUkebJle2PJfQjHD7l832yD7YxCj4E
Message-ID: <CAAhSdy21XejojvdgkYdqO-40iF9AfN6k1Nx8X0PSpmF2D6_GzQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: kvm: add null pointer check for vector datap
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 5:18=E2=80=AFPM rom.wang <r4o5m6e8o@163.com> wrote:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> Add WARN_ON check before accessing cntx->vector.datap in
> kvm_riscv_vcpu_vreg_addr() to detect potential null pointer
> dereferences early, consistent with the pattern used in
> kvm_riscv_vcpu_vector_reset().
>
> This helps catch initialization issues where vector context
> allocation may have failed.
>
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.1

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_vector.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 46fbf48f2503..e989cb9f1ac4 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -129,6 +129,7 @@ static int kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *=
vcpu,
>         } else if (reg_num <=3D KVM_REG_RISCV_VECTOR_REG(31)) {
>                 if (reg_size !=3D vlenb)
>                         return -EINVAL;
> +               WARN_ON(!cntx->vector.datap);
>                 *reg_addr =3D cntx->vector.datap +
>                             (reg_num - KVM_REG_RISCV_VECTOR_REG(0)) * vle=
nb;
>         } else {
> --
> 2.34.1
>
