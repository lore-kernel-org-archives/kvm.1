Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F0136197E
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021727; cv=pass; b=e/z+JWUXwzFSH1ofxVP2jn0JENjDvTTn5w+i1VQgRXfrb9zoT4b3RLC4YLhvSZWuWnb16Y6NUGWl/PUmiVyN2GfYgXtg5RlPfYvE3sLoBJ/GUXoj0r2zf32M72If1xy7hCNWkh9ppG/nZ6dPT7u7/iBi9eA12Cnse86EF7EcEw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021727; c=relaxed/simple;
	bh=YsfGWbRhqS8xM7Mt1x4IfeUEEr5EkkjPx1tBWKpgz+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+P3WDXWNwS+NeApCrEJKbKXILUNZzth10CKxQghD3qtTpYxBjAel2VSks0pxiJdLxKPYo7Kd4FPrewZw2Mb5NW3NNTKhZYNpRE5DDaqFfU6jLMv0w9hk5ZZptzYRbZt5FYTbdFhd/V6HjbsxGkJn9soxagfkaPTSdbO/whN2qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=uDW63teZ; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="uDW63teZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so108659f8f.3
        for <kvm@vger.kernel.org>; Sat, 03 Oct 2026 03:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791021724; cv=none;
        d=google.com; s=arc-20260327;
        b=Cf1s04hY3A0xSAhpz7X9T88bxfUHxwfFEnDKDjIptiAQZw8RFwhn8Unlwt9q1Z4peJ
         VqySTw9UclM2SMjUoL2Jz7j1nLIfD4vA5FlBvmNVIt17QrGOt9yvciEMiOCZvrvksz67
         GmsCU64mVGAHpV1TiGtbfTw5YMced7ermlMVEABdw4DIgEWCxNYUlGTufFlDvTU9Bpbv
         QLrcdB3k4H2muWF08vf416CjHOhZxeJ8IMji4mOcn55uJSkQoZQVPdPpNp+UKluRxJed
         QXfU7/Nj72CzO0xJb5A6kPw+h2Pp//8qkn+YycRi1/flnkRRdbNZAz4WKwCbXOpr+m9+
         13OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MP8Sqa2CEbzPapCdfasmIP+eBvUM/xKkRDsl2sHLpvE=;
        fh=dFWOUbJWmgAHAKUi4kyzknWF/V0bxMgMsR/YXNCZZOE=;
        b=fNNUZEVl5Gsg5pOHIgtcHhPPuTHU5UljTmR0nNLOC6VpjCvkZ0mOYmiRknPsNbaZSe
         sq9OxT9OpuJyx+vIYip6HwI6rK9Rourw9KJ315f1sDG1zLiA6PFpOVh+qxTZRLVjf7ui
         fufjSr+VUo8S1PUNrY8MZtaZno4xgSysODehTgtcyQG9prYVhNcoh4YrLR/TrKvSXPaa
         m3VJgGkA0xc8izK/Io/qiGTmJ/MxMcSZYH9ec15IavQlxg6N3zSAeWGjZ7jpc8Nl7OQe
         IltaF/Bg1Hq7li9MpEmDJAh44jGdNUKUGtTSYoKnzf1yw9vXsi0YeoAS6f35Cv2JV91I
         XI1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791021724; x=1791626524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MP8Sqa2CEbzPapCdfasmIP+eBvUM/xKkRDsl2sHLpvE=;
        b=uDW63teZBt4Slha+5k0hfBGgMP2J09fY2f380Bt3ouYrtSHxNOWccaZttKxvuyjtSX
         rnV5aXtcRQ23xZOh7ncmdcxUiI0fCO7dTxupgFJNlK3eD+m/EsdMZLApfvVPjmoLmUv7
         j1c4eM2d5o8LNbZb8wvl9Pg8FDNczvdUmNZpoKZyHR84w+zyH7bneIGWs7nIdG3F9WAl
         mkjXK1hjwpbnk6GHWrMev7yWOSn8zCG3K5knUU8tjUt4Zy30gXv2zW3uOfKE3rYFHd8C
         zF04PqWqrifjsF+YSz2jStiZ8GRgcpXYXb+jLO4haQc0SFq9aKZHAfo8ivl7Q2HObLOg
         foTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021724; x=1791626524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MP8Sqa2CEbzPapCdfasmIP+eBvUM/xKkRDsl2sHLpvE=;
        b=UGreFcnC20NjKsUPgxDbhHvaSI68yB/ITKvOn7gU9EH00wKgw3kikn8myWN0xoPlZY
         r321Hj7es/xzonklpk3BYy1QpaGtC11wDApdSbb4wAx/0LPs6QqtiAJc9MFLHkRBG99L
         OL57DIz+wwc6v0uMr0VMofZomzJ1IyuRZoiosqwy/VBhRalGaUZ4vEQIvZ0JWrnn2sAD
         tBq6GPnyjgCf0zjyndpVBKGKE1Cp3Cm/tqJo5mST0ZQqgFRMujuqbwO4qLMCbkvKlVWa
         9v+/qwsIIuSX9dDFlHkJ6q3bGoU1pQYlTUaqECmWFQ6m/ZeureSK2YryZHnRKZcb2LpS
         6phQ==
X-Forwarded-Encrypted: i=1; AKwUvBw68pWqKvjtfBXFgWEzPCrVo2wrDbcYE7xJODhKUwxS7haCK1XNhm8Ana+9USoovDVhOBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx/hn3PPFOVsNMJ8lDjSg7ClokQwICApqRGUK33/kPkHwB8ENA
	PtVaek7MOy1FW/1eLFJjNfbDNgEBK7z9ol6MV3gG6TuiOV47WZLj+oSzYa6LkPoyKINV6ee/h5l
	qRmzQUJhh2NKaVmevJz6XieLjDmtfvU19sxRk0a8NTw==
X-Gm-Gg: AYBFou3TevrUmufWrXlaZNQBSSQzFXbpwLkdTbldcLU2O8lej/tG2aUbXWQymyrHvDI
	bD4qB3n805UTgKvuv+nNULXS0iWChXVr1nb0TpEQmoPfa9E9kRVx+Go/pOy56NLMSzTBIo3devs
	wnlE+X5pg6XXl54JHXBrrmDYKfbiqkQz0zK7wskhtIfJl1VRakm9nzB2Urcwz7C6fWZxiO/qNGd
	+u8ny3ZhtKcPIOAx65BnsnAZwlcNXiHT7ZqVo0fBHtm9E1/GNwc2XIg/cREE98SDKAnvV+MQYVV
	cuU+cBJUWBfU4m3SKhk9JL5W7fWNeFQzpH79qyL5vmLPAZpod+2T+GHrAneqi4k8rQ7MlL7Nnxl
	eQw/QxyifD+O7fu3B8cYdB8LCnfyS0WeTwUANQbeAW76LIAJWJwq39lFXnMX1m3iDBEhPyAAReF
	A=
X-Received: by 2002:a05:6000:1846:b0:48b:1bf:ffb1 with SMTP id
 ffacd0b85a97d-48b12775c61mr10366149f8f.54.1791021723743; Sat, 03 Oct 2026
 03:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814114507.583424-1-jinyu.tang@linux.dev> <20260814114507.583424-4-jinyu.tang@linux.dev>
In-Reply-To: <20260814114507.583424-4-jinyu.tang@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 3 Oct 2026 15:31:52 +0530
X-Gm-Features: AclHuK-r6E6EOJLR4dsLSLuGmbe9Jaf0ZQFpEhYpdE-Qre9_eJHe2jf_2nwa2RI
Message-ID: <CAAhSdy3D+4Oh9mD+MFP8RwoeTDB855ZQoGRgjEnYJQwRH4K4=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] KVM: selftests: Enable pre_fault_memory_test for RISC-V
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: Anup Patel <apatel@ventanamicro.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Jinyu Tang <tjytimi@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 5:16=E2=80=AFPM Jinyu Tang <jinyu.tang@linux.dev> w=
rote:
>
> RISC-V now supports KVM_PRE_FAULT_MEMORY, so include the generic
> pre_fault_memory_test in the RISC-V KVM selftest build.
>
> The test uses PAGE_SIZE from the architecture processor header. Define
> the normal 4K RISC-V selftest page size so the generic test can build
> for RISC-V.
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.4

Thanks,
Anup


> ---
> v1 -> v2:
> - Drop the per-test guest_modes_append_default() call from
>   pre_fault_memory_test.c.  RISC-V already initializes supported and
>   default guest modes from kvm_selftest_arch_init(), which is called by
>   the common kvm_selftest_init() constructor, as suggested by Sean.
>
>  tools/testing/selftests/kvm/Makefile.kvm              | 1 +
>  tools/testing/selftests/kvm/include/riscv/processor.h | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 6fc34e9bf8e1..ac64ac92fd4b 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -225,6 +225,7 @@ TEST_GEN_PROGS_riscv +=3D coalesced_io_test
>  TEST_GEN_PROGS_riscv +=3D dirty_log_perf_test
>  TEST_GEN_PROGS_riscv +=3D get-reg-list
>  TEST_GEN_PROGS_riscv +=3D mmu_stress_test
> +TEST_GEN_PROGS_riscv +=3D pre_fault_memory_test
>  TEST_GEN_PROGS_riscv +=3D rseq_test
>  TEST_GEN_PROGS_riscv +=3D steal_time
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index abde3c71c891..70487c8ed155 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -12,6 +12,9 @@
>  #include <asm/vdso/processor.h>
>  #include "kvm_util.h"
>
> +#define PAGE_SHIFT             12
> +#define PAGE_SIZE              BIT_ULL(PAGE_SHIFT)
> +
>  #define INSN_OPCODE_MASK       0x007c
>  #define INSN_OPCODE_SHIFT      2
>  #define INSN_OPCODE_SYSTEM     28
> --
> 2.43.0
