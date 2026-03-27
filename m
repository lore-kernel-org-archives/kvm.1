Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DB3FCB00
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628633; cv=pass; b=oYhvn7Yc3IfRTzztUxozuv6IDc14rS+ya0HWhfnjPk1WB2Cy/A+CHjs7QFVQEZqlOdzLnNkPwmv7K8yWqZEcvyohzvVuiwLvRnBDdPKFYRmNLYmtVR24ngwMvveqYe1G6J/8ZGgxDC9gw9cirvGTp2pyXdPlN41vu4yUqgqLWlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628633; c=relaxed/simple;
	bh=N6rST9ZopQWUhJaBvDdEgyYVzdRlMkjbdWYlBGwnupg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVR7vGzVmnb0XcZ8+VBcW/rr+a/6uhFxW+TyDajxkvlQtrwZN2RaUMPp4vPGEcIO9L2JXtvBym3hLTd1RQp68GusRXgqQiG+Nz7Njdm8TIKdNGdvGvWxOcDALZ0y698acljMAg+HiWZ5+YRo+YRfjO4Nz9wJS1UBP3+OIRm97W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=bg8yWW6F; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="bg8yWW6F"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d751ef36ccso1245971a34.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 09:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774628631; cv=none;
        d=google.com; s=arc-20240605;
        b=Ta874pW267XOyqI5obucfqrsFLnUAq2oW2sdT31f2mH1bs/y8mimsmzeHnjvDgnznJ
         0o9kncoLMLH0s549LoXtRu+nzVmeRIDY1LLngyfISENYNopzMHJIeHzBOjkXoeGjP07P
         BhkgAc7tpP9VQ9as6VNvvqQPrRMhzVB5tIuVu6hGSy0sbrtnVxxqjhEiQqpatnHMFK4c
         iXHA9kQ8dDVlamX2Osz06qBQDC6fy9B4R1JsdaJK8wnkol3b5XHdy9VGiJI1btLhB0f6
         lCRftTgtjjXBmvzfFMJ7+OILpLwEQvzEJ1dU5jqrE1sZ5bU+SURaod9qG15gzWBf3kxR
         SZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5i7AMnECXeGliuvzkSngvQOxbDfImYVhWzHk0/VD+K8=;
        fh=YmtMqoMu1eIG7yJFFr152VF/Vx78xan9gBrh5Z6u/ms=;
        b=Ui1PZfNZxoYeAS9UcHws1o75apO5GjWlqRVhTe/Z7jzAXN4KrTOSU/qHKMgLDWaazJ
         qOIj0rtiPC9xZb+ioJzokmDL7PdKROHPfIxL23fe7ojFUW73FOwAtAIysooYldV/L9Ok
         anGL9ty1gfpwFxKm4AmV/zDUYWKSicj99fSZieD4oGJ/u1V7XTZZIGyK54orLv0yrgP5
         AbmXVrlg261axew9PlWqgIBu9Xt2pOdxS6/bxcgwPpZRR8Qy5Tk9iwjL6uCcVg+NPmuw
         BCR5LmPOuUDosiniVV2688QpqA7mdQpHu2Kf9OOjmchSYG9/PSRPwnGdfzLFzZhUnFNP
         Uv9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774628631; x=1775233431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i7AMnECXeGliuvzkSngvQOxbDfImYVhWzHk0/VD+K8=;
        b=bg8yWW6F0FlZMyZab8kY1wR3Qvk9S53JW4fQa70IrTsRCKln9fhMNk29oEldXnK+Vd
         Jebliy51yFF1lrKDctJP0jPX99HXxV/+bcmUgqrwE3+AJ6IO3Ol8KpAOCqzdKFGGUlIl
         2dkALgQNaB3kCIeS2wY3i9fdqcEOQ4PIUY90Jh3cI12ZNLood9QD3ktAouaPGnUXRTUd
         kmRf+enY0HyniD2RMJOyOTCTS2xF1lxs/Y6Ky0zHudHZ0iRIIIYvmMnbiIGbGhtsW06B
         BRGPz3OKDWJ+q6X0vonX4m36EodecYblRJte634CBBN7UhTbX7V00ZNmokN5TPPzctlb
         Y+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774628631; x=1775233431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5i7AMnECXeGliuvzkSngvQOxbDfImYVhWzHk0/VD+K8=;
        b=d6PqIWck3UmIzy437v0Vh7UYCIAyeFo7Mu4qM0wtcNcVhxu0XljQulQEU2ydDc/Ujn
         hypI6a1kaA+bedOHeaQ5hTT1Rd4mWwFDZKC1nXOE9L6L28VoUEbsXJemIMVqEMMQ3zZW
         zRd6YBewtO/5RSE8v9QNBMwueiU0Eb9SjWEmt0wA3prFIyWUo9GRH1NQPYB2gfikaB44
         Vwvd7LOlt2EHsyxVIw4y2p5F0a65ynBfXeJfpImaCcFZqDLHhvAX903IMNxYdjwpvFbg
         G6TClAMTM3D+WzNgNi/zvS4TUAyazWRSNDBh5KkCElUiuq1HQPWC9VTSjNi7Pp3JuEHi
         tV9w==
X-Forwarded-Encrypted: i=1; AJvYcCU3mIgpAfQ7M+kldUZvpUC2hgFEfFlQUer4SdOX4sFxMdEJnIsIFMzx24EiMgdhjpiSE3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhA+vKUJ6O6kIKDY2GrQNt1IpDFrUmonxMhxR95UIb9kNjK296
	WpQ419YVbSff62vh2CoWypdH1xxLbyYLGejvvuD0ybdp9RUowC9VmdmkS2SqBdlNZzpUYEoInw8
	jbWLXMSY8QFfo7dtEE1pPoW2lNVXWAj/xqhX2ikn2pA==
X-Gm-Gg: ATEYQzwF9JhLHuvlUCZJVs0ngOlmdaaS+d6aRB9Fzf/9nx5jZQd2vSokyrh/QQffsqU
	iE7o+EMDUIuJxqiZXDqR1dLZm7M3aTlJDtryA2t88vEfWX36deCTtJa28fDV6swWQqe6rUVRpOB
	Yym5B8ULtVdWqagVW6LbNdTpyDXN5QvbV2nfuyx0pHpmmEXen8feBMsHl5c3tAHH0VILpXhycyd
	UZcFqPC4e/bOHUQ3kZOOafFBzUEJxezRmiysA7rZFDf4zurDbGGC67CjAliO4rQVHXn8Ya9JvLM
	Eiqmrw/7wx9z9l1baes8NHq9cXsx3FnPioHqy7RaIekelYfElkZ+6WPHJqFybyygGbtiToEPvZc
	fcPQP9+9pYEpZ6/Jqkqm1eQFoOAM=
X-Received: by 2002:a05:6820:2916:b0:67d:2cb:2079 with SMTP id
 006d021491bc7-67e1875bd34mr1529379eaf.58.1774628630795; Fri, 27 Mar 2026
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316014533.2312254-1-xujiakai2025@iscas.ac.cn>
In-Reply-To: <20260316014533.2312254-1-xujiakai2025@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 21:53:38 +0530
X-Gm-Features: AQROBzA9STNkwcnpYQkGGVqwDqCIWR_7nCDRTW55e5KIm3IP1CNA2fjdu_Yz16A
Message-ID: <CAAhSdy0CeQOnLdsCqXVxZcP-mxMDqjSMhEnLVVYTr46jbj7iWQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RISC-V: KVM: Fix array out-of-bounds in firmware
 counter reads
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 7:15=E2=80=AFAM Jiakai Xu <xujiakai2025@iscas.ac.cn=
> wrote:
>
> When a guest reads a firmware PMU counter via
> SBI_EXT_PMU_COUNTER_FW_READ or SBI_EXT_PMU_COUNTER_FW_READ_HI without
> first configuring it with SBI_EXT_PMU_COUNTER_CFG_MATCH, the counter's
> event_idx remains SBI_PMU_EVENT_IDX_INVALID (0xFFFFFFFF).
>
> get_event_code() extracts the lower 16 bits from event_idx, yielding
> 0xFFFF, which is then used to index into kvpmu->fw_event[]. Since the
> fw_event array only contains RISCV_KVM_MAX_FW_CTRS entries, this results
> in an out-of-bounds access that can be detected by UBSAN.
>
> Patch 1 fixes the issue by validating the firmware event code before
> accessing the fw_event array and returning -EINVAL for invalid values.
>
> After fixing the kernel behavior, the existing KVM selftest
> (sbi_pmu_test) fails because it attempts to read firmware counters
> without configuring them first. Patch 2 updates the selftest to
> configure a firmware event before reading the counter and adds a
> negative test to ensure that reading an unconfigured firmware counter
> fails gracefully.
>
> Jiakai Xu (2):
>   RISC-V: KVM: Fix array out-of-bounds in pmu_ctr_read() and
>     pmu_fw_ctr_read_hi()
>   RISC-V: KVM: selftests: Fix firmware counter read in sbi_pmu_test
>
>  arch/riscv/kvm/vcpu_pmu.c                     | 14 +++++++
>  .../testing/selftests/kvm/include/riscv/sbi.h | 37 +++++++++++++++++++
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 20 +++++++++-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

Queued this series for Linux-7.1

Thanks,
Anup
