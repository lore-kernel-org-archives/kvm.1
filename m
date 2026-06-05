Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561C283C83
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695936; cv=pass; b=K0aB4xXQBYDcdGweI8AKgwRH0oqFn2PouaAk3hD9d5++2+1X3mr2Gv6VcV7pfIJfD6s3tkwoepS4HoHjyvYAIewC1HZZ24we3i01BRkws+RMxIezIlbnM3ZiGDscl7tQ3xjMmm3FOzNpjkbyBGV30aagNKqX79AWFQ/HWo1eDaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695936; c=relaxed/simple;
	bh=RbpDg/kYl6mwQXCz3qR5h0Vix9nrhHwv83Uv0CIXV0g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6ZThWTS4b5iR2D1sycqpSu2y9VZ319vlDDm8XDKhZk5LKwL3WG6B+JDODMygkYcHBVxZydrzA6jcZiRKMg/BzjQwYuKQdr2PjXVBFU8At1cnw0ht2Kdf7sbrA8rEe6L5SOiIf+ZRKC5g2m6bQd21AGaL8BMQxWk2gtk38Dv/ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLGV0o6h; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLGV0o6h"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1370417c01cso3465759c88.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 14:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780695935; cv=none;
        d=google.com; s=arc-20240605;
        b=bxP69obh63vpSExQntZFEnOjW5JlBf6KxC9vfPkppKK0Opi5edrGFGzIcTBLj87iRB
         1c1Ja0J8QRdQoXrDPq4QgOtqY/wGHqUtma2YFsOISlw8pUl/6nk6U+0xOBqa1y+UgbcA
         qbVcnHNAXWYgTVhVAlPDOjMPdpwZx1rHkqVox9+Cvcqixpl5hrn8jgdNLP93t3dr0K+X
         1/+E581BUoTJlvEpODTC8EwwTvqdaQtyaj7qGSArr2d9+mf0Zz4ANBOx94luueKEP9q+
         ySlewsg37GCWToISbiAWFapZObGVVnUT4BaOfxRI7MwiJ4/EEq+lR5p/7YOAlEnxWZF9
         DjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=GS6Ei4jhGsPE0OXhrjRIOP6JH4B+eek+wO3pczZDLKA=;
        fh=ZyFRa8rTfjxUv85tFBTZuFfOM0JRfmpI5JSVEPpKPkM=;
        b=gPy70hFgBA7tkHYtG6Bp8fBOkgUusDHsUv1lG8BqJHwX468orIcN/1PGV/f0QHYh4C
         IeI6LmRNNhDonlRDI6/K4K9KZjEh8epKvv61mOxRU0M3EWyX0oVHmh4WVMwnAmj9mmbb
         rpdpfUCEt/3Rjqs3+glbyyioJ1EOCeIPVuDT1cYDjs0q6j+NDpfamgxmc63uJjFX/FeX
         NX2g6t9O9xqWUxy//PpyaCRdFcu2S7LFS/YE5qkn8p6+j8fuFlm/6dZIF68rUqz5/h68
         vAW9HxhryvHGDBd0Vmpee3ulOwMuB41juCEW8nHpUelF344Z5k6nJjI5Cc3B9IITeD7r
         7s3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780695935; x=1781300735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GS6Ei4jhGsPE0OXhrjRIOP6JH4B+eek+wO3pczZDLKA=;
        b=CLGV0o6hUi+JS0+86o0Si5phckCR2/vQFDAWC75m5IblbvSJyv95Qgo3zxcaKhaOHV
         hIUV4OBLNnxRs3Chb5gmf08A9RQTYO30H9tq+k4W6IKa6gwp9W6HB0V+bJvn5GNCbc9N
         ujgf6LSq+UfbsYU/jkGzytMYs6VYhdXkCYqfl2A6AhFGOK+s44uh/2YC7+aB4k5V1lxl
         IP+1pKqKJ76NZ40A4fiGeWK0v0WR6dYlk+NICU1hWLnpsNKdO0FP00Ignef51tk2K962
         vZYhnlydKCAdVvj/chFXn3Ci46PnM9YsXKxFMpvUYsKRMl9T73Kn+gUSNLuiZ3N4ZrHP
         wEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695935; x=1781300735;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GS6Ei4jhGsPE0OXhrjRIOP6JH4B+eek+wO3pczZDLKA=;
        b=Zj6ekUXmrHmX9X4NqriVeP5WcSm4rXLqLhE4foKUMXSfLTzpd0qAPRc6oL3hkE9r5X
         ykHlJDxyvgC5sPrviIEw/T4xNdFh6uIqINP9ESyynex+fMNzOShXgvmKrcsdy02+Lwot
         wGaGhwDQMRnGxMQaNx9MQ5qGp+pDM4KOKvAFZy7aLoALnHzemjefo8B7ehVw0gmlQBZ/
         pe6pijTYVqvEikONgK0G61Uv42qKodw5Lza7HwT6wi+tPkmURWqhLXH51w108tSmR2Nn
         HNxzCDVgQDgfDFYX4U6L3LK+fvAb3qYRgXKu+q9OL10Qrudfij5NE3EAy2UbKGoGTjcD
         akHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VJvT9tf7M9RshyKORpUv35CMx8Qc/+0iWj98zXlNYHEhz26iSDhJIqmrpFwz31jJ/u7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5r84PEuCOScMD37Bi6hhK+MVeJySxp+UtAr9br2L5/T7OQQX
	XwcZz/SzrUs+VT/CvpycNgNRgc0deHM5tTAJSjdr90MJi2GK82TNb43JaC93fsBB2aXdkxsOdMC
	mXptLN4VOXfdUselcZ/jhBtSFqX838o5FKjBRNlh2
X-Gm-Gg: Acq92OEYr9ZPDPBnVrJ5LrYumVsi+GdVi4yOMA2gYkWgvDvzCgllTB8giBIyHzxRM7F
	1IBe4Uwn1F/0oXFBC2hIGI4vWZJNyJFUqrP9i0xsKqBVUvWdngImTzoZaU/OGu2nQahl0nwyuJu
	/lbk7P3CkfF16d6yzcXhkK8bFNIGHjbeh4BMH4+hkFRUQ6c1vr2RmlvlN1EW/QEP7sBof2nkFr4
	hq4vLRYTjx3cTK4zSaP/zHfoNNZZrQfH/4wmWwnjiQAyozufyZAcsJVoN4t3+GvxSKt5CRujdWI
	cXQ95U12IPvd534OLDH4/qXfALOZ9kiXgKd5CT6qdYlLfUVUtpPHTnUWMuumPMjEvREZ3uY2wPx
	POMHP
X-Received: by 2002:a05:7022:204:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-138066fa2ddmr2670055c88.29.1780695933835; Fri, 05 Jun 2026
 14:45:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 14:45:33 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 14:45:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiCzNbtQ4FPu2yCR@google.com>
References: <20260603-snp-selftest-cleanup-v1-1-73b29fe31ce6@google.com> <aiCzNbtQ4FPu2yCR@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 14:45:33 -0700
X-Gm-Features: AVHnY4JzG7VB0zlH5sUGVOnVVh6RIseJI5Gt8L6YDgks9g5Fz-PFBNcjuaYOVuo
Message-ID: <CAEvNRgHtpFa+HAhPVBvB4=ixUuEW-r_Xh49SHEPktUmHgzYcAw@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Make guest_code_xsave more friendly
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.roth@amd.com, jackyli@google.com, liruxin@google.com, 
	darwinguo@google.com, jacobhxu@google.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 03, 2026, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> The original implementation of guest_code_xsave makes a jmp to
>> guest_sev_es_code in inline assembly. When code that uses guest_sev_es_code
>> is removed, guest_sev_es_code will be optimized out, leading to a linking
>> error since guest_code_xsave still tries to jmp to guest_sev_es_code.
>
> So, don't do that?
>

I was commenting out function calls while working on another part of
this selftest and ran into linking issues.

>> Rewrite guest_code_xsave() to instead make a call, in C, to
>> guest_sev_es_code(), so that usage of guest_sev_es_code() is made known to
>> the compiler.
>>
>> This rewriting also gives a name to the xsave inline assembly, improving
>> readability.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  tools/testing/selftests/kvm/x86/sev_smoke_test.c | 24 +++++++++++++++++-------
>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
>> index 1a49ee3915864..8b859adf4cf6f 100644
>> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
>> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
>> @@ -80,13 +80,23 @@ static void guest_sev_code(void)
>>  	GUEST_DONE();
>>  }
>>
>> -/* Stash state passed via VMSA before any compiled code runs.  */
>
> Uh, so as the comment says, the goal is to stash state before _any_ compiled
> code runs.  Shoving the code into inline asm breaks that.  The compiler *probably*
> won't shove anything before the first inline assembly, but there are absolutely
> no guarantees.  E.g. you're subtly relying on a tail-call optimization to avoid
> any stack operations.  If I force guest_sev_es_code() to be inlined, then the
> prologue becomes:
>
> 0000000000402a10 <guest_code_xsave>:
>   402a10:       48 83 ec 08                                     sub    $0x8,%rsp
>   402a14:       b8 07 00 00 00                                  mov    $0x7,%eax
>   402a19:       31 d2                                           xor    %edx,%edx
>   402a1b:       0f ae 27                                        xsave  (%rdi)
>   402a1e:       b9 31 01 01 c0                                  mov    $0xc0010131,%ecx
>
> and we're hosed.
>

And omg, I thought I was running the tests!!

>> -extern void guest_code_xsave(void);
>> -asm("guest_code_xsave:\n"
>> -    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
>> -    "xor %edx, %edx\n"
>> -    "xsave (%rdi)\n"
>> -    "jmp guest_sev_es_code");
>> +static void xsave_all_registers(void *addr)
>> +{
>> +	__asm__ __volatile__(
>> +		"mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
>> +		"xor %edx, %edx\n"
>
> This doesn't even build.  When using input and/or output params, named registers
> like eax and edx need an extra '%' to escape them, e.g.
>
> 	asm volatile("mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %%eax\n\t"
> 		     "xor %%edx, %%edx\n\t"
> 		     "xsave (%0)"
> 		:
> 		: "r"(addr)
> 		: "eax", "edx", "memory"
> 	 );
>

My bad, I was compiling this while having the caller of this function
commented out. Didn't realise that even within the same file, the inline
assembly won't even be compiled if there's no caller.

>> +		"xsave (%0)"
>> +		:
>> +		: "r"(addr)
>> +		: "eax", "edx", "memory"
>> +	 );
>> +}
>> +
>>
>> [...snip...]
>>

My bad, this patch is such a goof!

I still feel that it'd be nice to allow commenting out functions parts
of selftests while developing other parts, but let's shelve this for
now.

I think to clean this up I would do something like

1. Enter the guest, GUEST_SYNC(STAGE_READY)
2. In the host, write VMSA
3. vcpu_run(), guest will perform that __asm__ block, then GUEST_DONE()
4. Host performs compare_vmsa() to verify

But this relies on ucall support for SNP.
