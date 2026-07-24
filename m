Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF4E4446E1
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910443; cv=none; b=rFORvnj+wK1JWoeq8yrXDYZiB6MmYU3Nyl+kX3WYTL439YOLqsHzumgWBid7CTLPerhiR2BY22ZI0CXwtALSTXDbOpAy7pdHWPBdIJitWLZwqmV8MrOjJbE88i9soRTOxyrDUb4lf2U0gMbrsFcZ+YWnFp+mxLmYy4JFDh/jaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910443; c=relaxed/simple;
	bh=I5hk8Z6Nr/6W6A+zFCCYbbJO9MaRTnHaW3LsvGqeeaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWHNzVfPrmik45vc0zUv9vzhwYeDwmJELJtej+98MQGI92HRdjVWQCPyhXdywfoG7MUEu6eDNKYVq9sWYsSPEwWSyWxba+lNq5ss/W93glr9YsjgM2lOS1uuorwGWv1TtvJJHdagP9CAmqZATnDl6UaeFXuXm/Dq1ktK+BSqXVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=GypRR6Pr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="GypRR6Pr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so582277f8f.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1784910437; x=1785515237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3I2GZ1TBWEQICUe+MJj/gSymbGalygKtTBeukCBYeY=;
        b=GypRR6PrKweU2B9AzkRiX2C6DFUAw7BLo635GezUdMxpsRbsRShafl1BCw67IvFCDU
         I7jtXbifoue/9yETo61Thte/ObFjj6xJmFQgYYHzLOSijYUQRStLKwXRb4+IbapvYzfD
         uCm4TA+dZRPgNZz25gRVw8xtTRgyek4XgEp0XmND2chap+QlK2Q4gk0sNtAx30unBxyk
         AKoKMHpsYr4B4djnnp0lm1fbXFTJNP/ljtAZGMrfqY7/wAjClIc+IP67rvFlSR+WatGo
         Yp5NmW5iFs14Dm5YfuiXk2CflLbpZjQEXZI6+DiHUyBmKu8C6Z4O2/HcmbxhEVp5s4rD
         J1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910437; x=1785515237;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3I2GZ1TBWEQICUe+MJj/gSymbGalygKtTBeukCBYeY=;
        b=fQ7NjyCA/jwuoP7oT/5zsjzEQlER9nw/YaurllWlX3bhQlusp3o2FiNByPry0hlyLp
         PiHxYIpmkOSMdxZ/8dzy9ZyhKoQZlGVLBrk8X74htXP5JQYChRZw34IU1NapgSRTISbM
         XpYP8h9uipCYaHbiHSRPSotWIiUl4ur15Qc2IaEgtf27oJqO9R4AkgE31p+WjYZo96W9
         +exqyeDBE8RnBuSe0WYkFphxgAXHTdsxdDAnlPQjratIZ8Cq0XV2apdrDg6shezqEdwF
         R0cxk/YUmHfe5+acH1oobWyiUNMLQTdTZnl/J+/hNJJvxjXpWoTKDtKCddmYEeLSJzWD
         OHWg==
X-Forwarded-Encrypted: i=1; AHgh+RrIDPHeLFpFHGBvja9ow6urTTeRGEtUSW3arxIUpKiBdVDeRgWcf2vfCpOZAzXG5vm4ANM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNivR1yHVVMXFBdduC+WQhqFFN55Xspnj1Ym+fgYYGURBcC3lA
	a+U+e0eG07GyTZ+ZolGn/t46I9Ebzvyz3Safy1zuZ/lbOiLoCD/Kpudy/P+sIMpqTZU=
X-Gm-Gg: AR+sD12l+qd5FUvWzH4KAfGejHcKTuOrizoE4eqyHyvzzaS7z3JAHN6gnBQCymGo99u
	/9t3dGkM1ZYBz7wDi1JQAz1g9ugesQ1GzpPqmW2iZEfZKt7D259/KLybBmEANeUUHavb+XzcRMF
	vLx8h3clV8siEzg5PlkVtm42hwQH6KPjO446wQO9XIctOcpZZCjK7w724N8rZSFAf71VNwl2078
	PqHOPqnm02aW6wVTghxNb0Q6EFiXXlkic1prb4RvWgHtbegA5/ioFkT0OUqWJhm2aCkWkXpBWHZ
	9lw0G8ZPu5Af83g1IlRP2k5iVnyKnvbr91Z2JTY1Uyz4LQ4d5E3j8uAcbytqBTd9ytDNlgIbFZV
	RuclnSadgrG1OqRAQ79T0WO2zmMB92bONRzhBDgMe1sMbwsgkliwwZkU6J/ms6XvYNAH5SQmOPM
	ZQnW1jJ/LSjBRT3CqEstXivYLaQ1cjMRsUe31WTuaZUmRg2uUkJAnuyGnqWOWOFRnk02z3MabiD
	gSdmeNOlYdw0/gwRrnvMvarV+4ZvVodGjA=
X-Received: by 2002:a05:6000:2902:b0:47d:eedb:ee62 with SMTP id ffacd0b85a97d-47f8d71ef31mr11132335f8f.14.1784910436879;
        Fri, 24 Jul 2026 09:27:16 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm25270861f8f.11.2026.07.24.09.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 09:27:15 -0700 (PDT)
Message-ID: <7b3e712e-5b68-4c3b-8dfc-ac94e8482796@grsecurity.net>
Date: Fri, 24 Jul 2026 18:27:14 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4] x86: Better backtraces for leaf
 functions
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <andrew.jones@linux.dev>, kvm@vger.kernel.org
References: <20260527202219.1502399-1-minipli@grsecurity.net>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260527202219.1502399-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.05.26 22:22, Mathias Krause wrote:
> Leaf functions are problematic for backtraces as they lack the frame
> pointer setup epilogue. If such a function causes a fault, the original
> caller won't be part of the backtrace. That's problematic if, for
> example, memcpy() is failing because it got passed a bad pointer. The
> generated backtrace will look like this, providing no clue what the
> issue may be:
> 
> 	STACK: @401b31 4001ad
>   0x0000000000401b31: memcpy at lib/string.c:136 (discriminator 3)
>         	for (i = 0; i < n; ++i)
>       > 		a[i] = b[i];
> 
>   0x00000000004001ac: gdt32_end at x86/cstart64.S:127
>         	lea __environ(%rip), %rdx
>       > 	call main
>         	mov %eax, %edi
> 
> By abusing profiling, we can force the compiler to emit a frame pointer
> setup epilogue even for leaf functions, making the above backtrace
> change like this:
> 
> 	STACK: @401c21 400512 4001ad
>   0x0000000000401c21: memcpy at lib/string.c:136 (discriminator 3)
>         	for (i = 0; i < n; ++i)
>       > 		a[i] = b[i];
> 
>   0x0000000000400511: main at x86/hypercall.c:91 (discriminator 24)
> 
>       > 	memcpy((void *)~0xbadc0de, (void *)0xdeadbeef, 42);
> 
>   0x00000000004001ac: gdt32_end at x86/cstart64.S:127
>         	lea __environ(%rip), %rdx
>       > 	call main
>         	mov %eax, %edi
> 
> Above backtrace includes the failing memcpy() call, making it much
> easier to spot the bug.
> 
> Enable "fake profiling" if supported by the compiler to get better
> backtraces. The runtime overhead should be negligible for the gained
> debugability as the profiling call is actually a NOP.
> 
> Unfortunately, compiler bugs and nitpicks require additional quirks.
> Namely, -mnop-mcount doesn't play well with 16-bit code generation for C
> code. gcc happily emits a 5-byte NOP that transmutes to a 4-byte NOP
> followed by a zero byte when executed in real mode, wrecking all code
> that follows.
> 
> Fix that by selectively disabling '-mnop-mcount' for realmode.c, making
> it call mcount / __fentry__, which are provided as stub functions.
> 
> Another quirk is the requirement of -mfentry which recent gcc-16 started
> complaining about if it's not used together with -pg.
> 
> Thanks a lot Sean and Paolo for helping finding and fixing these issues!
> 
> Note, a fix[1] for the bad gcc behavior has been shipped with gcc-16,
> i.e. this workaround can be dropped when gcc-16 is the minimal
> supported version for KUT (so in about 30 years).
> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=114a19fae9bd [1]
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
> 
> Sean, I dropped your SoB because it felt inappropriate to keep it after
> mangling the patch so much.
> 
> v4:
> - squashed the realmode fix into this change
> - integrated -mfentry, reported by Paolo
> v3: https://lore.kernel.org/kvm/20260514210500.1626871-1-seanjc@google.com/
> 
>  x86/Makefile.common | 22 ++++++++++++++++++++++
>  x86/realmode.c      |  4 ++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/x86/Makefile.common b/x86/Makefile.common
> index a251dd71e3b6..88a671187fe9 100644
> --- a/x86/Makefile.common
> +++ b/x86/Makefile.common
> @@ -43,6 +43,27 @@ COMMON_CFLAGS += -O1
>  # stack.o relies on frame pointers.
>  KEEP_FRAME_POINTER := y
>  
> +ifneq ($(KEEP_FRAME_POINTER),)
> +# Fake profiling to force the compiler to emit a frame pointer setup also in
> +# leaf function (-mno-omit-leaf-frame-pointer doesn't work, unfortunately).
> +#
> +# Note:
> +# We need to defer the cc-option test until -fno-pic or -no-pie have been
> +# added to CFLAGS as -mnop-mcount needs it. The lazy evaluation of CFLAGS
> +# during compilation makes this do "The Right Thing."
> +#
> +# -mfentry is only needed because recent versions of gcc otherwise warn about
> +# the lack of it, that it may cause placing the profiling call not directly
> +# after the prologue but somewhere later -- not that we care but be nice and
> +# avoid that warning.
> +#
> +# NO_NOP_MCOUNT is needed for the 16-bit realmode.o which causes gcc before
> +# gcc-16 to generate broken code (5-byte NOP instead of 3-byte one).
> +NOP_PGFLAGS := -pg -mfentry -mnop-mcount
> +LATE_CFLAGS += $(call cc-option, $(NOP_PGFLAGS), "")
> +NO_NOP_MCOUNT = $(if $(filter $(NOP_PGFLAGS),$(LATE_CFLAGS)),-mno-nop-mcount)
> +endif
> +
>  FLATLIBS = lib/libcflat.a
>  
>  ifeq ($(CONFIG_EFI),y)
> @@ -113,6 +134,7 @@ $(TEST_DIR)/realmode.elf: $(TEST_DIR)/realmode.o $(SRCDIR)/$(TEST_DIR)/realmode.
>  
>  $(TEST_DIR)/realmode.o: bits = $(realmode_bits)
>  $(TEST_DIR)/realmode.o: CFLAGS += -Os -Wno-array-bounds
> +$(TEST_DIR)/realmode.o: CFLAGS += $(NO_NOP_MCOUNT)
>  
>  $(TEST_DIR)/access_test.$(bin): $(TEST_DIR)/access.o
>  
> diff --git a/x86/realmode.c b/x86/realmode.c
> index 7a4423ec6098..38bd6cdbabc1 100644
> --- a/x86/realmode.c
> +++ b/x86/realmode.c
> @@ -23,6 +23,10 @@ void test_function(void);
>  asm(
>  	"test_function: \n\t"
>  	"mov $0x1234, %eax \n\t"
> +	"ret\n\t"
> +	/* profiling stubs */
> +	"__fentry__:\n\t"
> +	"mcount:\n\t"
>  	"ret"
>     );
>  

Ping! Paolo, can you pick this one up, please?

Thanks,
Mathias
