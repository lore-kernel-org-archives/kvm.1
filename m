Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58E2DA775
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780183045; cv=pass; b=fpX2hR0FyGm9KYSnGqzY7vjWGB2o8sPaR6dDIBXHibY+5DDcNeb3hXa0VZ5GDqwoLHYJxXizh7tYETRKpKCU1FTHtZqR7Iob+bL9TmdGrm2EvSvnm6Zrzw8UqFQ5+QybjtOza5b3+bBgxhyJj90D7Bm1hURCirY6JH7mZy/6Ph0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780183045; c=relaxed/simple;
	bh=QQSU1zzQnCL9cfy4Cb0A8NBU07sr7eZqMeoXplLn91s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4NaOPbgvXRQg8NXy9SFvaK/13EWovR1yFo7evWjzGaf+F6LfqUlSNSREOcns0u0jZACpleKV0Q5LFq2l4gOi9tJmRaRS2Fo9ZuJtWbBwydb6wOIEPusJWtqgR8C0KHLBBuhxNarvLpsp7iqURTdJVgmNuXQzGKVdM4yQE4rpWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRF9kWgt; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRF9kWgt"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13621cca8f5so5721716c88.0
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780183043; cv=none;
        d=google.com; s=arc-20240605;
        b=Ad8IC181up9VdEybiQgRD5UA9N3L1d3KRdxGbib/WZNSZKlIo9JnPn89SeLMGZm7bE
         EI8K0g6Fu/vCuJG6TNT5njKXnmZJJzHUxhEx3nDSM4YT55T4jYnq3Eq/vYoqaI8xQYHv
         6ZMb+gQTgXv5rWNm79RganNHkaGL/8whq2NOqW7o0iWExZuGkPILH1BsFcvKS6gIvqUO
         MLUPJVPczh67Ah07ylz4h8qajvFZrQLEaV9CFA4AnH8ls2hhPJfBLkF3MU29bh9K90Q6
         KdmfiLxqLjkcBioMLkSoDpJXU98RsnVIZNvlGvtpuszA5nNGulDZCmcDSAdUpibWCr28
         6sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=viCVJzQbV7r4+toyEfLLyYDk6SbXvXgwv3+sGjmcLbU=;
        fh=n/xVjRsPLSx48DK0mlLV8S98n4Bay9rv1xBpMnS6M6Y=;
        b=dhl/JZ/C//3/P1vOYZUy3KZKFKYpDGxMPwWBt75jXsQ7Z+b61tKqvGkcM+iB3VPapZ
         VaQBiFWkhIFl4XHJ92JuReuCD8ENQ7W+QaE8nIUQcHv/ZU6vBT9e+kLx0+iJOXICGqwU
         hPCgKfS9ZMIoXDfvO2DtQex8CPnun1dZ+PfzKNDbtHX6B7DB8xsC0gbhrCoTOeEZ7pYi
         crNuii//fSuf06YeNIrJ00DYGHVVq0lDVQXTOo0AtSYrxLwaXFjHv9gZaADnfhke6E3H
         zmLE0PxQzhr/nonMtF1dLlxtVvnGM5gz3bOmcU84BBZXaiaNsDjHKVhKYQ/R2mhLTZjt
         2yTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780183043; x=1780787843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viCVJzQbV7r4+toyEfLLyYDk6SbXvXgwv3+sGjmcLbU=;
        b=vRF9kWgthKNVGUhNQj89lNu9q+TBMpyDT9TukZj1VwWPd6V59CU6Y90f6TzBCb4oFY
         Oc7WMgJy9TdAL8trNU+ZArT9ypsq7hyk+SVdSe5IJcTqk2bZNJu5OSXKdxl4jedCRlYC
         CMKKSVipgLMaGXLFHV8DvrzP7BN/uaw907pLUrc1JOKeCVFPGXtJYnnHuerUTBDOygQl
         LYiBBrDuekeY5B1JRW1iHvQCpgIyfks6vGeyvwlxJsq/mFOODeQDd95NodnOCxyOomsP
         bQXK12NrzCTQmMKUU74/OEa5uZpIaCbnZhTZJOyNUT7LLvhxcgSoQqGmnPhYjYQj+9aS
         jU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780183043; x=1780787843;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viCVJzQbV7r4+toyEfLLyYDk6SbXvXgwv3+sGjmcLbU=;
        b=dfx6XSueva3hGR1DXOc03L5IJ+g9sTbcN4weV1p+t4s4vAPM9yKRHUiJsKOI2Zrfub
         skF4eok4P8ePfoS0qi9hTqc2qqWsDs2DlpxBBOFZxGFgo2fXlioBsCbYxaquj9uNt2Ft
         mHpH4tZF/W4bgLJidn206FvdFO/P/fiOQ7TM8JIzStGqN8m9LVwXoow7BxWPvabpP+Or
         bLcu6h0Hk2AZE9gMtysF/7mSGxu6XyctHKki2HdoXHTvTvtkOVvN4nVtSe5OQbTTw8eS
         QzfOLDqPfbKXK0hJHB3UoLNR1TPBfKsJpqVBSzYG5lnww/6DBOIiD4M4AyGYlYcdMJUO
         raNg==
X-Gm-Message-State: AOJu0YwFm6HFeRo9ysARxdap+SmnR7DvYqA1g2oEpSO+m3W5Ir0kLz7p
	zdzdg71lG+26UHb3vZS/tgqES54d5b6PFDV/AS28vj8XsWwhJrEKQJdzAvhqTvUvGyVitADZHvh
	YaLe2PsnJH29496U3H+lBuPw/BB1+Z0qkB0bao2Z3
X-Gm-Gg: Acq92OHtrxcM2N99TBx9/fmgwFUF/v78gbiHvrUlg+gLMsW2idQ8cI1opi1EumbJ7IO
	UL78kAazd19WU3od16++hXySng60vzpoUTJxoXN5eyg8thKVM5CrVsOkcm/CVTlZONEtKSuPkrQ
	9KE+mM4rfbwF+L1L9waTsr2uJmtUmyP+qxwOyi/gkOZH4S50HrpQYd0We7L/heYPTqQ4qqnjSaF
	hhUAJffr6VGsktZFmza55pXFXyyjU2EmulHoHdqyDqBrQdFUm3e8oM4vCuh14F+cZ1CI5s5YbCM
	uLYhAjBfOvRaUWxpU74A7mLtCC3pBuiV0qhsifqegAJ8FTn56xICBYvPmyN7NEMOlqIdK4eh67E
	s1AhBBw5N
X-Received: by 2002:a05:7022:60a3:b0:135:d749:574f with SMTP id
 a92af1059eb24-137d3f0f885mr2381955c88.13.1780183042448; Sat, 30 May 2026
 16:17:22 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 16:17:21 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 May 2026 16:17:21 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260528032925.BBCCB1F000E9@smtp.kernel.org>
References: <20260528021117.107984-4-seanjc@google.com> <20260528032925.BBCCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 May 2026 16:17:21 -0700
X-Gm-Features: AVHnY4J6QLRyCAUyZTY8SWiq9slHpWnhSD2XzBkrXjg8MYB91Ph4QMnrSosk5AY
Message-ID: <CAEvNRgECjs5UqJsBjsgMc2JF8rRirCPAtB02dKxSgsTY0LAe6w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] KVM: selftests: Add guest_memfd regression test
 signed offset+size bug
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
> [...snip...]
>
>> @@ -345,6 +345,16 @@ static void test_invalid_punch_hole(int fd, size_t =
total_size)
>>  	}
>>  }
>>
>> +static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size=
)
>> +{
>> +	int r;
>> +
>> +	r =3D __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, size=
, 0,
>> +					 fd, 0x7ffffffffffff000ull);
>
> [Severity: Medium]
> Is this hardcoded offset value correct?
>
> The literal 0x7ffffffffffff000ull contains 17 hex digits (68 bits), which
> will be truncated to 64 bits (0xfffffffffffff000ull) by the compiler. Bec=
ause
> this truncated value is very close to the maximum 64-bit unsigned integer=
,
> adding the size to it will wrap around zero.
>

Sashiko miscounted the number of hex digits, it's actually 16.  That
said, humans also have to count to understand what the test is
doing... How about this, which I think highlights the signed overflow
requirement on the selected offset?

 static void test_invalid_binding(struct kvm_vm *vm, int fd, size_t size)
 {
+       const u64 large_offset =3D align_down(INT64_MAX, getpagesize());
        int r;

+       TEST_ASSERT(__builtin_add_overflow((s64)large_offset, (s64)size, &r=
),
+                   "large_offset+size must overflow when interpreted
as signed.");
+
        r =3D __vm_set_user_memory_region2(vm, 0, KVM_MEM_GUEST_MEMFD, 0, s=
ize, 0,
-                                        fd, 0x7ffffffffffff000ull);
+                                        fd, large_offset);
        TEST_ASSERT(r && errno =3D=3D EINVAL,
                    "Memslot with out-of-range offset+size should fail");
 }

> Will this trigger KVM's existing unsigned overflow check instead of the s=
igned
> offset plus size bug this test is meant to verify, causing the test to pa=
ss
> for the wrong reason?
>
> Also, since the trailing 000 makes the offset strictly 4KB-aligned, will
> this fail immediately during the page alignment check on architectures wi=
th
> larger page sizes (like 64KB on ARM64)?
>

This is probably true too.

> Should the offset be dynamically calculated at runtime based on the page =
size
> to ensure proper alignment and accurately test the signed boundary?
>

The diff builds large_offset dynamically.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

>> +	TEST_ASSERT(r && errno =3D=3D EINVAL,
>> +		    "Memslot with out-of-range offset+size should fail");
>> +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528021117.10=
7984-1-seanjc@google.com?part=3D3
