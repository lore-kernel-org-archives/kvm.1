Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37AC39B486
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616386; cv=pass; b=iYdlhSh+4BsVzybuxzIDtzZpFBJ8F27zNXGzbGXaXpaAerk6zpByOU/5xj8RCx6eZXMmZIHKTMYR08P4+D8688cv1kK1dhIKEtdDxKhNcnsEpC2wdmHUE51z+gMaE8yOBKD5uFZsHrrJjJBcH8Y/UcRxtc4Ftv77eGA+Sl9DDuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616386; c=relaxed/simple;
	bh=ozuDkFvVq9yOIhaYMtBDUtrCZfh4dazZtVZ9qVU/W2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neZW9qdEsTtA9uZyEHiybV27bK75Y2lt/kEpIsiuFpRkjiliMcDZm5/K25ZM8IbI8StGsVjuHeevbbEpGXMA9H7FZkIVGSybes9amSUPQcPEnST5nhLIyYXDs/YMvhwUFzb+hk/kLCZS0gh0WRRhR+r1/u94C/pJmE4G2BlLQDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OtaAWIOP; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OtaAWIOP"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67e0d3f288aso972677eaf.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 05:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774616384; cv=none;
        d=google.com; s=arc-20240605;
        b=FzW5lCdidha9SIRAZJvH8X0tpMWVYfssJDuHcw6azMEYUcM6caP7HiH+gL9Yj7XIE7
         VBy7T1IfO4wgimP18m7wM110N9HqE7BtvzuT2bOT39WAM/YKajlkwzZ4+aGuFgh4hbuY
         e6zRlVA2hZLI087GiD8+AGF6+eo3K9Q1/kow9k7SmMSej47xHwIwq+owNs1KK4e/7Fdl
         wxuOmEEtH5ojneuLHt3L5VZc1qi1tb1eauvzzFeE3c5oiZqrNY9o7ArLRVKVWiqb7F+t
         blDmAqA3nuCsBubvbNUdse7w13kSbngsQpx+ATtnw4WUlHx8uQokUpv+UK9s+ZpUE+wD
         QdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSJNEQ4IUrIGBafuDjT61HQhcBt0f+9/E/O9i7xBSsY=;
        fh=AfGuZGSp2gr/Mw04v1DYUacwURp7yc9olpIlr0MqWAg=;
        b=YMyDkGxXdEWzFihODAE6wEbCOss8eclAMcvUmaxiZyb64vg9jjMwKPvKeZCvKvuRhH
         65X1S5i8xdry05jRL3xhFOOViyDFSkC7rw1/isBryOPJu1PYnXb7DqRrmOHgcGG2gCdo
         ed5WTRvIF7n+xxRn4ndEr8770BomDYyuD6px2ZQmHnMWoF5NZfeaeoSv00YSWIkBQszr
         hoJpjKPTX2rTsT6pkvMDIW/527kmuEYelh9AtbuXZFXjlsqND494td34Cna5h9grMfgH
         s4luit0UQUSinNO7usolshPhZbNXfA646oEDxL9fpQyTa9h9tw9brldkY11/4c0CdM1U
         nVDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774616384; x=1775221184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSJNEQ4IUrIGBafuDjT61HQhcBt0f+9/E/O9i7xBSsY=;
        b=OtaAWIOPiM6RbZVpXG6ZFjRNFEPuBYBBp00v5u0TuXcJ4JXTz8DS5A7Qb75a3prmGQ
         wX6fttO1v8mlZxz/5cPwu18czC3/Zz7W3C7e6uLUjdUXLMuJgHYwC15yiY6ucT3Xglh9
         18UeeQNGJ/GVhvS2PK+WifA2BQHuKlZRv46y0uo26OVXf6VRGEpXRe4Dkbbraez4IPXG
         taJUK1YEe21ZK5qr/kvp6zq8gy5SEGXicAImhiWDWHy1pBzKcjuy+uLNGcxSc068wsMU
         ZyumAxmy9/kJxTQKsYzHpGmfS/hJIox+VEij+jj72loRnzAAH2kbyq0duBkAJ83fxN1i
         y5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774616384; x=1775221184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSJNEQ4IUrIGBafuDjT61HQhcBt0f+9/E/O9i7xBSsY=;
        b=pUWPyRERptTPMm4TfygdgtEKt37gAlhCcbzSInXJGHwnxI95w//5RcVXc47AIjscAt
         VW3MTFZaQWnM9N7hgv2Sao3Fbbtfaqf6kSpbp22+qoc3vAcWK+ffRfE5GyQ/1Vmv31BJ
         5jdhpDY7m7JsRomVLykIbvKPwYhnevNziDAUWbjfFC0G6KY8MU2Q+G2ItfPt4TLGpME6
         +rnQ3HodddS+BcPqQtvAG3E++iNKCuvfC2c2XnAqKJEfMsVxuE8uEj9mBKKn8ZPQ2pDU
         7qmrT0GVg/+hCBZQv0F7dx+wnFzSoWPagREDJPqcSGn7EP63qqqlzOLfjV8bgeecGn06
         080w==
X-Forwarded-Encrypted: i=1; AJvYcCU2ADRefWU3i41D01q8bPZVGJjsbDLt1x5biofOk0cdtfkP1f4nT6Asa0yYG8Cs0+lJfvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEpOhkbf++l6soqcj6AMiQHCNo7B1dg7BNuXgSFL0fV8GAUPF
	71yDAkjbUZIx98FRA6RQ+d00iJa0MmQ8R/VkzagxspR+FLwF/ZUX4jTW47nUPimMQ4a/4l1i6pe
	/sfqtAZp1L8B/AKc4O06Wom1xjiKUeox2nbUwmUPOpw==
X-Gm-Gg: ATEYQzzfq19mBkKJ8xi08zjsBpmJ4Y1GWHO4u9eipvbzP9EmeZeTsyhurDy8tHAmqWd
	Odh98+lPeFKqZZ+s2h6YlD6EHvj/kPWp7wlJaeggNa1RAlDcLR423H+D+RHGjnYCAmknBQGVSTR
	bbX2xzBvRgAG0Cv9PG1OT2F0wzeFhoDoo9AGTEvg7Z+7L75CQu1a67r68gRC6ogFHEBRdNqrpQ1
	0zPmVcAxIjZGp/zeMBQxeWdW2n5+UBM7ciz+ybYRnvMeORBo6ZRc/fTtMn21BKnEii0SAqwX55y
	Mz7ikxlXcM8IHpecqgbQn7UMky1u4/pNXDgCFWz73QdH4pT2z3n/HM/k3X0s63RqFXJLAV2swIL
	4tuWFj9Wgs5COyYeB5l3T9qDrnA==
X-Received: by 2002:a05:6820:221a:b0:67c:2b6b:520c with SMTP id
 006d021491bc7-67e1875a871mr1122414eaf.62.1774616383734; Fri, 27 Mar 2026
 05:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303010859.1763177-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260303010859.1763177-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 18:29:31 +0530
X-Gm-Features: AQROBzCGKH8Yynm5vTwqjoLikHfT_rvE6B5eaTVPa88iE5QN8BHshTiNb-us74k
Message-ID: <CAAhSdy0Jw_XvVK5brSRN3QGvnYHNEJc=tL65z+iUnSSjFObuPA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] RISC-V: KVM: Validate SBI STA shmem alignment
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atish.patra@linux.dev>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:39=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn>=
 wrote:
>
> This series fixes a missing validation in the RISC-V KVM SBI
> steal-time accounting (STA) register handling.
>
> Patch 1 validates the configured SBI STA shared memory GPA at
> KVM_SET_ONE_REG, enforcing the 64-byte alignment requirement
> defined by the SBI specification or allowing INVALID_GPA to explicitly
> disable steal-time accounting. This prevents invalid userspace state
> from reaching runtime code paths and avoids WARN_ON() triggers during
> KVM_RUN.
>
> Patch 2 refactors existing UAPI tests from steal_time_init() into
> a dedicated check_steal_time_uapi() function for better code organization=
,
> and adds an empty stub for RISC-V.
>
> Patch 3 fills in the RISC-V stub with tests that verify KVM correctly
> enforces the STA alignment requirements.
>
> Jiakai Xu (3):
>   RISC-V: KVM: Validate SBI STA shmem alignment in
>     kvm_sbi_ext_sta_set_reg()
>   KVM: selftests: Refactor UAPI tests into dedicated function
>   RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
>
>  arch/riscv/kvm/vcpu_sbi_sta.c                 | 16 ++-
>  .../selftests/kvm/include/kvm_util_types.h    |  2 +
>  tools/testing/selftests/kvm/steal_time.c      | 98 ++++++++++++++++---
>  3 files changed, 95 insertions(+), 21 deletions(-)
>
> --
> 2.34.1
>

Queued this series for Linux-7.1

Thanks,
Anup
