Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879463A1699
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 10:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359722; cv=none; b=kWGQ8faCrPOiv3eLm1B075Dd5aXc2zt87r4xm+0UeRQ+HC616nBWFqw4HmS3soKWd1S7ZdKFUPkYCl8a48MDzuPXxZqu0Dbjd2oq8ooH4RCv22EjcDtaueOD7X4/h5pKZRh3lmi8+SZOzD/Sy8oZin4BdXaOFDKhg7JNkBuRL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359722; c=relaxed/simple;
	bh=WnA60ffiZtBPXEj8+iL5h8jntJoCIxVb6VGio6fUA9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLwNG96Rr3hPIwbNtuPM10Ei5FxOHrBO8gBn3JxoqbtKr9ZSy4qHUe3kzcrY1YPdqGN9humLHEX0fP/KNa03S7adgNX8CW7EPiKo/h8pzh0lcO+XhDjGv42nHSjNPYCtxNmniD15dDqdI25wqfpGv+G0/xIjcrZhkHV62Igsuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Mzs05lqi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Mzs05lqi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d7c12e48eso62687041cf.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779359719; x=1779964519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LTlutl0M1qd21S38TNfkRuuRJadQX3Wy/1eKpxVvsew=;
        b=Mzs05lqiZjnyt9WZEUO0LqsG5/xJKf32wGi2+O0uBsOQAo179puiR6teKpaaM9L/Jn
         6cK0hMjtIa4zRGit9MO8cxf2uz88SGahJwNBun+t4J67O7IYKQ1KS/6Q2sAwikj1rYjd
         Zcqg8L8nOfxVccoYjlk9OQ9JzDF4LFr3pvWrczKkGo01tI6RPwE2GninWH+ttfM/ohia
         qXGzPbPO9ax4bGMmo0x3ypm+w5KXFMTSmfj/cIyvbgL/tSvEaG2AH4dS/Yj0k3pIz3Yh
         JjpO+RMA7rPFxSwnkdwhLZxvSVy5811nDEBADxZzh85I2lbKaDI3HlMxdoXSCFbmB+GK
         TM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359719; x=1779964519;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTlutl0M1qd21S38TNfkRuuRJadQX3Wy/1eKpxVvsew=;
        b=GFDSk8yGeLpqq1X5bf17OS0cQM3t3gs8CepqkBemlsP3dg/Ma73sUCmCSZ0dJjvGst
         tYesYCDAyMeLf6LJFrcq+N+i4ijsacoVGd1dNMy0iBg2UJvwzltsAtndPFRjWngoCuMq
         Yd1sHw5YzOxv7X4KASaPNbJ2P4KQdBiilkrBGhRr5Tw2sHGvPQ2Fl+5uHZFCLkUwcXnP
         JV7uaatd1i3PeUD2+z+95YUVffK9pDR9k0fnutkGDnVPP3Vi773Dkjp2fU4VbyvnWWQZ
         G7tCCVJ2CGKVDS5E27y3j7XNzAyZltY7ECfztL+q0zfGkSOBPG7FW91aZ9hp3bc/U0/Q
         gjFA==
X-Gm-Message-State: AOJu0YzwhzrLALxlMDLtX6ulXrzZbnJryEjjuxHPTBHGP5eqtwquUUFD
	VpOC9HlipKe0bysp20g+lJNybGzfjbBfNbQ//kb8ixIW8WHKbShTR2VIKSCRUCK+VHU=
X-Gm-Gg: Acq92OFA4saRWnVCOCLSwsFCXZ42DGDauJLtgYcXoeZw2bCmVsTGDPBgxafaRLP1QKR
	5vT/vIyecSJu1MVMOYLqZuVNRG6MZpv+R1CCZFwPtQyeTMJF9FYUALCQNlXqhM8/uaWJ16KGO+V
	n6t2bzQdRR6Qw2lcCk6fOyatFI3zjnriVvSf0MfZTQ9oaH193/bhYSbvoW3UdQB4/35hvChotq9
	UnSQ0ojHBkYtJXWpc9QMt40q61/ZopSUJ5nCIOoPOyp2j7lZ6u/XYhgzCqYOt3GHagEqa3NNBqS
	w8JkdGb3Ce0zwoEfGfPUQEFMuxwferHSinn/o+gcUw1VcxaqyuOG6AuN+gLVoqKpxOufWeYL5qs
	9H3cknUkH1Cg9BSDGbeyn8Z6uYaJOTwQjlRB0uiPLRxF9Poggz04xVaWnM+1N1mWFusYmOrA9Xh
	3aeAmBi4S9JvgunNh3yNz6l5Y8J60fLUTGvwIFPEh06kqN1r6xAz53ETvFKQ+jwpd+z2Fcfu7ZP
	Fqlf2Wrk2wUSOluPHy/niw35XO/T/TrEbqcu7sQELY4V+o2RFQ1EI6Z
X-Received: by 2002:ac8:5a54:0:b0:516:82c4:1105 with SMTP id d75a77b69052e-516c54ce868mr23495381cf.9.1779359719484;
        Thu, 21 May 2026 03:35:19 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccba6b97sm3966101cf.1.2026.05.21.03.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:35:18 -0700 (PDT)
Message-ID: <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net>
Date: Thu, 21 May 2026 12:35:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf
 functions
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.05.26 11:24, Paolo Bonzini wrote:
> On 5/14/26 23:04, Sean Christopherson wrote:
>> Finally re-posting Mathias' work to provide better backtraces on x86,
>> which
>> was blocked by a fatal bug in the nVMX SIPI test that was exposed by the
>> stack frame side effects.  This has been sitting on my local system(s)
>> for
>> something like 5 months, and I all but forgot I hadn't posted it.
>>
>> Most of this series is cleaning up the nVMX and nSVM to play nice with
>> multi-CPU tests.  Then to fix the race in the problematic SIPI, abuse the
>> VM-Entry MSR load list to atomically detect VM-Enter (I'm still proud of
>> that hack).
>>
>> For gory details:
>>
>> https://lore.kernel.org/
>> all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net
> 
> I'm applying patches 1-18, adding the last two give

Looks like Sean already integrated them into
https://github.com/kvm-x86/kvm-unit-tests, including the fixups that
came up during review.

> 
> gcc -mno-red-zone -mno-sse -mno-sse2  -fcf-protection=full -m16 -O1 -g -
> MMD -MP -MF x86/.realmode.d -fno-strict-aliasing -fno-common -Wall -
> Wwrite-strings -Wempty-body -Wuninitialized -Wignored-qualifiers -Wno-
> missing-braces -Werror  -fno-omit-frame-pointer -fno-stack-protector   
> -Wno-frame-address   -fno-pic  -Wclobbered -Wunused-but-set-parameter  -
> Wno-override-init  -Wmissing-parameter-type  -Wold-style-declaration -
> Wmissing-prototypes -Wstrict-prototypes  -pg -mnop-mcount -std=gnu99 -
> ffreestanding -I /home/pbonzini/work/upstream/kvm-unit-tests/lib -I /
> home/pbonzini/work/upstream/kvm-unit-tests/lib/x86 -I lib -Os -Wno-
> array-bounds -mno-nop-mcount   -c -o x86/realmode.o /home/pbonzini/work/
> upstream/kvm-unit-tests/x86/realmode.c
> cc1: error: ‘-pg’ without ‘-mfentry’ may be unreliable with shrink
> wrapping [-Werror]

Bummer! I should have tested gcc-16 for real :/

> 
> with GCC 16.  This fixes it for both 32-bit and 64-bit builds, but I
> thought I'd run it by you before committing it:
> 
> diff --git a/x86/Makefile.x86_64 b/x86/Makefile.x86_64
> index 5b221a48..dffbe8cd 100644
> --- a/x86/Makefile.x86_64
> +++ b/x86/Makefile.x86_64
> @@ -66,6 +66,8 @@ $(TEST_DIR)/vmx.$(bin): $(TEST_DIR)/vmx_tests.o
>  $(TEST_DIR)/svm.$(bin): $(TEST_DIR)/svm_tests.o
>  $(TEST_DIR)/svm_npt.$(bin): $(TEST_DIR)/svm_npt.o
> 
> +NO_NOP_MCOUNT += $(if $(filter $(NOP_PGFLAGS),$(LATE_CFLAGS)),-mfentry)
> +
>  # Workaround for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180
>  fno_fuse_ops_with_volatile := $(call cc-option, -fno-fuse-ops-with-
> volatile-access,)
>  $(TEST_DIR)/intel-iommu.o: CFLAGS += $(fno_fuse_ops_with_volatile)
> diff --git a/x86/realmode.c b/x86/realmode.c
> index 0a7104d4..3b2d8c12 100644
> --- a/x86/realmode.c
> +++ b/x86/realmode.c
> @@ -24,8 +24,9 @@ asm(
>      "test_function: \n\t"
>      "mov $0x1234, %eax \n\t"
>      "ret\n\t"
> -    /* mcount() stub */
> +    /* profiling stubs */
>     "mcount:\n\t"
> +    "__fentry__:\n\t"
>      "ret"
>     );

Ahh, yeah, almost.

The lack of '-mfentry' even makes the cc-option test fail for i386,
circumventing what the previous patch wanted to achieve :/

So a better fix would be something like this:

diff --git a/x86/Makefile.common b/x86/Makefile.common
index f5cbd9cf79c5..d8bc6c61f19f 100644
--- a/x86/Makefile.common
+++ b/x86/Makefile.common
@@ -51,7 +51,7 @@ ifneq ($(KEEP_FRAME_POINTER),)
 # We need to defer the cc-option test until -fno-pic or -no-pie have been
 # added to CFLAGS as -mnop-mcount needs it. The lazy evaluation of CFLAGS
 # during compilation makes this do "The Right Thing."
-NOP_PGFLAGS := -pg -mnop-mcount
+NOP_PGFLAGS := -pg $(call cc-option, -mfentry, "") -mnop-mcount
 LATE_CFLAGS += $(call cc-option, $(NOP_PGFLAGS), "")
 NO_NOP_MCOUNT = $(if $(filter
$(NOP_PGFLAGS),$(LATE_CFLAGS)),-mno-nop-mcount)
 endif
diff --git a/x86/realmode.c b/x86/realmode.c
index 0a7104d4cff4..f6aaf289fef7 100644
--- a/x86/realmode.c
+++ b/x86/realmode.c
@@ -24,8 +24,9 @@ asm(
        "test_function: \n\t"
        "mov $0x1234, %eax \n\t"
        "ret\n\t"
-       /* mcount() stub */
+       /* profiling stubs */
        "mcount:\n\t"
+       "__fentry__:\n\t"
        "ret"
    );



Thanks,
Mathias
