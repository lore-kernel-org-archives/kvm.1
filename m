Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080932BEFEF
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573333; cv=pass; b=ZyfJ5HAgaC7MNw5S5qFDkKjFOLMgjYKW19Q/PCGyFv+rhJBAFXYEUSRC4fKJK0IXmBoV4tjE3VZgD6fYhz8M7mlW1AONnSgRYSUXnD4I3lpn64h8zELpW8MQKnMW50/qbF9emrlonty7VC8vBKWdxQBkY0NzSEECloZaVZ/P41w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573333; c=relaxed/simple;
	bh=vtDT32oMB7ziitkHLrGHeg0kIpvwcPs2e+1P3OsUqIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDSHVMawo21cxYCGc8y08TNN5mOBhiFrswRk5f0hjV7GepQJ/EEgL70qsY7+nXjLhvlRBC9WRkA34d45ryV7ubG4WwPBoVG8ggzNKSYNFY/sao1qASnCsXT3NuF8APIaUm9JRr5C3V8TnLxKrbbMS7oH/5AkWz0N+pLA2HzqRtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=pvizaoFJ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="pvizaoFJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1826301f8f.0
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785573330; cv=none;
        d=google.com; s=arc-20260327;
        b=pRXJXubUVOAzQZa4sO2a159Ojx/Xr3yN6icmK6rLN40Li1gem3u/AHV7q2JHV4LAmL
         rJFoZ0FGqXHS4nZIdLGwTOk+k4n6xsROlakAAas4evhZ2FfCYHncoaGpQoX8e9rZyaYs
         /qEmDezrMFtpz+YCgwXNvbsaq7DsygBikyQcjxL7DOM2VynfmHsyulUYdjKpBaV764ud
         9Ogc3V8d0Nw3gFUba8qAixLxPv5zNfqCTZm8lpTncbE1+jG55J8WcKpJvUFZnoLHvd5q
         t/HRtqg7540rOTDXc4qfcwJYrLed/k4od+jBNT3DfwTE6hgcxzMq9XY/ZHOZo17BM/1+
         fTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUTf6pJUeP1uJ/800+RmRcBQOzqOSOy6aUpAs+g0B94=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=j10IsViPJ9r/FN5B0CRCVUFAShq4E/0w+hSgfeXR2/81jWaR1IkGN1OkJDbJ0wwhBG
         BUauX5GDkBVZtoIJbr6bpeq9fJpK1sspPXdUzWdMS7mVk+K6GbgP7shwASzrb/eJDDbf
         QLHBKq3f/np2xsb04QvgtbH/VBG3/YEjFj4n/P1wfiY3WBhvEQN92EKd5s407/d8SQ5I
         4KAgezj66isHc3q+liFKphq4C5d7e9uJ/Movb93FsxMrM+af7TXCO6AWfJsJHgWu9j1+
         t9zbD7UF6f2wCEHcCgDshRkm9l/dQgvbTjXpSCG90WUIiMMLx5MvXrB3zWaKEnOGBFAW
         oaMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785573330; x=1786178130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUTf6pJUeP1uJ/800+RmRcBQOzqOSOy6aUpAs+g0B94=;
        b=pvizaoFJh1mzZCSOGtWUEOgTKTOeEzvA7PBg9iheaEuO/xm+j4o5JrgDt4HyNrILiU
         GNsztYGwliVT5kcWTGZ2rXC70AxDz1CMx2FbJsCcxeRTU4s/WXYUGT8lf/hDySnm994v
         HhCaLla6NLvW7Ls+L5lYUGksnC4aeQKd3K0G5iDxqQxeEPpXvBHXFVEpLz4hip0b+cwB
         UZVULlgBk+0+N6gBY9hcbA7EmIvRcgtjmg5NpDhdM2tTxXEYy3mcGOBuPQGic+3SwKSz
         RuFisPsWMcV7KVf61Qrlgeh37hX4fZJTkKQlV9z4gZTr7TIImOlnNj/1LQ08IhRUOVpM
         wIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785573330; x=1786178130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUTf6pJUeP1uJ/800+RmRcBQOzqOSOy6aUpAs+g0B94=;
        b=gppqgMXVzAgrME40P9ngurgequUqoGYP+QX5/CQ3dojUa1YQ5ZQiGv8Kynp2vvPoXQ
         Oxusw7f/ZOGBya38L0gGgYWk7GCS4fgdB3Iemmis74ahVf/sXMOcTlnFVDLVLWTSUSXL
         BdoqZf2nOSxolRFenZ/XYLdwEdMhCb6PA3FA5lf+u6r2jwu7Kf7YcPWi4ffi9Ja1pHo8
         9SgVd+XUGMDIglpMOSlwC04bpbvULUL+XMFygjHjG/5Xf/cFd6peTjYvGRC3h3f3bUKo
         9x+Sch/yS0xaNUu+1g0AH4KSklgpCmr8oHXviKtiH+m5S6kM0xS+YV1y7qGPODTmg4KE
         OSrQ==
X-Gm-Message-State: AOJu0YxYGA3rj43Udw/WqY1N3/1rPW+H6O1WOuItz6ZSKx05dI+s6faT
	Y6UMWIagCz16xeS0JxZQBO4BtYn4jP9/j+jBd9ATfvpjwh5vjgPxCmxCoOAUab7PvFhqQtYocdC
	TvOG4wb4VqleDRnLvluuhDmNNlcQ5YhHOEWRkxpY353E27OPgnChzP4URig==
X-Gm-Gg: AR+sD13n3VbuLz688e7KuOD+gj2xm74/Rk/QRz0ysXM8teh8kzWKj+0JxDLN7O4yt1A
	Vo/wYn5veG0xIHALbGoOJCT4V9jopIy7LQBXCOYkpGJfBEh310bkHZRMx4B1dBq+iOyo49Ap+Bj
	F8vYDkxMd7iraExQiZGAqtlMz25sEf/r7/dDiAlfqoTC9Rrf2abeuMCklx/aHG08XDzHZBawbyr
	f23lqf+fhH8I4+ff5TncDiJ+qSnzOM2lur9e/2LQn9N2vkDsCR2+OM3F4zbLLA/zBmMndFsfBEL
	IbEl6f605ijPkar2Duxxp3SdAZ+AHEixtHaMM9IpvlrIrlEumERgFDCBhJh4iw90OlA0ZbQVblN
	znM7us6rXCgiF0+i7KQTXikNXDflyTpP3b+gllyxQM2X9vc2gX1+n4JoK53aGDl5KPt1gVzyamj
	xo
X-Received: by 2002:a05:6000:1846:b0:47f:6e8b:699c with SMTP id
 ffacd0b85a97d-47fd729208fmr5228759f8f.14.1785573330190; Sat, 01 Aug 2026
 01:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731093833.1551341-1-wang.yechao255@zte.com.cn> <20260731093833.1551341-3-wang.yechao255@zte.com.cn>
In-Reply-To: <20260731093833.1551341-3-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:05:18 +0530
X-Gm-Features: AUfX_mxVZMTqUYg5I25kzku9hNu-Y6ngd-XdOTNy6Xs3S7Apun6Etlayif9FnM8
Message-ID: <CAAhSdy1r=wfR3j5da2DtyiitNi6S5EOrRAh6Nv6kMqZDBpMMhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RISC-V: KVM: Introduce make_xfence_request_nodata
 for FENCE.I requests
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
> FENCE.I does not need hfence data, but it currently goes through the
> generic make_xfence_request() path with NULL data, incurring unnecessary
> per-VCPU checks.
>
> Split out a separate make_xfence_request_nodata() function to handle
> FENCE.I directly, and move the data validity check to the top of the
> generic function to avoid redundant checks.
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/kvm/tlb.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index c54522decaa64..fd445e9fa3f94 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -325,6 +325,29 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
>         }
>  }
>
> +static void make_xfence_request_nodata(struct kvm *kvm, unsigned long hb=
ase,
> +                                      unsigned long hmask, unsigned int =
req)
> +{
> +       unsigned long i;
> +       struct kvm_vcpu *vcpu;
> +       DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> +
> +       bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
> +       kvm_for_each_vcpu(i, vcpu, kvm) {
> +               if (hbase !=3D -1UL) {
> +                       if (vcpu->vcpu_id < hbase ||
> +                               vcpu->vcpu_id >=3D hbase + BITS_PER_LONG)
> +                               continue;
> +                       if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
> +                               continue;
> +               }
> +
> +               bitmap_set(vcpu_mask, i, 1);
> +       }
> +
> +       kvm_make_vcpus_request_mask(kvm, req, vcpu_mask);
> +}
> +
>  static void make_xfence_request(struct kvm *kvm,
>                                 unsigned long hbase, unsigned long hmask,
>                                 unsigned int req, unsigned int fallback_r=
eq,
> @@ -335,6 +358,9 @@ static void make_xfence_request(struct kvm *kvm,
>         DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
>         DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
>
> +       if (!data || !data->type)
> +               return;
> +
>         bitmap_zero(req_vcpu_mask, KVM_MAX_VCPUS);
>         bitmap_zero(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
>         kvm_for_each_vcpu(i, vcpu, kvm) {
> @@ -346,11 +372,6 @@ static void make_xfence_request(struct kvm *kvm,
>                                 continue;
>                 }
>
> -               if (!data || !data->type) {
> -                       bitmap_set(req_vcpu_mask, i, 1);
> -                       continue;
> -               }
> -
>                 /*
>                  * Enqueue hfence data to VCPU hfence queue. If we don't
>                  * have space in the VCPU hfence queue then fallback to
> @@ -369,8 +390,7 @@ static void make_xfence_request(struct kvm *kvm,
>  void kvm_riscv_fence_i(struct kvm *kvm,
>                        unsigned long hbase, unsigned long hmask)
>  {
> -       make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
> -                           KVM_REQ_FENCE_I, NULL);
> +       make_xfence_request_nodata(kvm, hbase, hmask, KVM_REQ_FENCE_I);
>  }
>
>  void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
> --
> 2.39.3
>
