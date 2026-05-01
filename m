Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFBC2E2665
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660439; cv=pass; b=Leer+Beg8VfeLfYXK6gTN20JvkPdXfj6XcGZyUPnIGUDDoHYp0URi9b1DGa+3ZQb9E5piY/8lyhfpeaXfGunnwgKTfAaCC3zpYLVM1Vf2X77QDWXSmSX0od1jyqRQpFaON79RXY0sAwCYx5Td8jt/b1IzWJ5zE+S9KQug/FkaEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660439; c=relaxed/simple;
	bh=fqg3WAk9fcb68sFfknqpiSw4c3xDKlkyGKAWTbUwpGU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHqbpaNoj5Xzwm/9O05A4f3Kao0EoIRmKQQluiuwktrb8E5x4oXLoXwqOq6jRwirm12KYtxwCyfYB2Bho0Xp+TfbHkIXKwwMRhlcT6O6UxMip4lfCuVSO9j4wmyJa+83qUl9bQROTFm01EAXaUDLtVWQLP8YOU5DGIC92HdMZv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIKlddL9; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIKlddL9"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6102bac3752so1599201137.3
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 11:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777660435; cv=none;
        d=google.com; s=arc-20240605;
        b=U7D9RCAPh04o86xq/E+n0GpCpdMGH0jrx2EAuiWz0/9TZLONAi3MgRv1VTfAsu3Rxo
         Qe2XmNDiGEtjsoWlHzG81a4zVNrXbfGR+npNQdOao71bir937CK+PxMvobyb6F4ZPHpX
         HuNvpXdI1VrL4rscnvukh/DKKJMlOUl0jdj+rIQLHo/3pHAV298bsWqyiOSuKgSKykPf
         eYCm3R7KZnj3KxN5sCOXe41QQ+0nV+E+59ZzfFuIJUqzm4ELnWxvgFOi72fRvbujUJmV
         +ioXQg1SCW9eGIpYFJVewyH9VBupeBDScbfL1J9B72W7HV38HHe5NZ1HuSnqmTg8b02e
         LCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Bav75grk2ITDinFEb+etsys3gj6sTaCIDR0vYHpkPhc=;
        fh=WXg1Wofsj/SwvWDxGQC3c9JBVTPPz/zCMlKzYeZK9B4=;
        b=e3QNFkZxmk4mjhOCJsRXr6w3JH6nWEkn3IqyqIlTtqDsMEBnTBwwgau2RHjPOVC6fk
         x208UI520pJwkKtM58tmqUMYg6xQIWHbBhG0h1cEbddxVFxcBao1CfkTtb/stjy47H9T
         /KrSBycbSVI7GDeSd5lkF2xpz4ZD4PWshoJMjr6xO3KVea01Gn4nzFpmz9z3NtiEOa5Y
         VIEtZYP9Nr2RCFx8prUoLgGrZ7Z8jgrv316nTrBoaYZ6gvCFK6Q4LA9R9nwk9OYVFxm9
         /mSIbmzEg8PMpjyW4MIfbaa7qMpP1UKBkSL9kiJVKDP7wvKsIdZxKCoJkA75KF59NsrX
         Q0ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777660435; x=1778265235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bav75grk2ITDinFEb+etsys3gj6sTaCIDR0vYHpkPhc=;
        b=vIKlddL9RmLprrsjfvX2rQR8+RLEk82QfXQOCF3EIgeSjUYnxBIl+qhC4QTQnsHS+/
         XkNK/LnrdPBOsxgaPIxXOhJWkTtRXgZhVuY3Z6Q5Yay41kOfhXCVoeqCC8jxH4UEoBHD
         zMflQtdWfR116LeFGPHeSFGO/xLpYoIYJpswO2O85nfFpIbBLLI4/fDIp3H2tmFCj0oc
         PQhjDbE3A07xq70Jkcisw68FxL+TL16yIKCJ4AIR8DqwfLCr7XABw7LLltyqZk3vHAi8
         qko6YLijfRXB6QSVhmPJT2R3J7VjaGKmh4MJttIkFAUDO38RhR3IOpCYUTAfhstSCCL/
         N7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777660435; x=1778265235;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bav75grk2ITDinFEb+etsys3gj6sTaCIDR0vYHpkPhc=;
        b=RgvQsGi9B7S1KHg9hcHqqnEk5HuMv9nL8roUqpuTaGuObAe1duFIXOPvHimMDMXM8m
         SVRVSH/Th+NboihcSOd9SaNeBuVd4L+8waRPR/zGbSX/EA3Sb4kryteyT+F8W3VRo0or
         vuMcEq8aJbL2G4P5wu+oUNL4dCh6FIryq3avg6AVzp2HG4W1j9ovHEDAU4+MsA8Lqiaw
         wiCGvA4Nj5ZkzWVEhfg5h/7S57IFNHmpYb9zIIpbwzkoEmAPNsxnD+rOU6B6fCw0c4i+
         5aiHcLUnvoC8Dz2BiwJdTsi6SEwC1zO87LQ+snXf4qlHkPg9kulDf444ABEvMLgB/BYs
         I49A==
X-Forwarded-Encrypted: i=1; AFNElJ+ZB4ns9fcxWSJVxGdgSIp1lCTvIJPj4j12MnyadbeIlRcOHJSe5rK0ZPMRGKHmxS7nf7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ihFeRjSmh0Atpv5qF3tm8GCfmr/d57pudgLgO1gDFhAy5Ykh
	CyP0+zKFJsi8kg5KxiTfHlqgCxVcj8W8f8EpDBNZSJkxnxGQ0x+M9hwCFIXZHofKq5e7Yx+TOrE
	NOGVXVx/Vhwf0bPBF/l+iNyhdmNL88maO3prud7NY
X-Gm-Gg: AeBDiet+ZGkYTyzyhxeFdAeXVWq6bsNSb14uwseIH7XRtOheTJTLKfa8SosgcV9f33u
	kvWE3BxzafiG6d8Yklj4Eq3IP8QOxitf5U0c8BXT23iRJPrSOMY1R9xJputz0oDrKPa6sTr5uzh
	tC8t4sNSfzkhiMpoWIoLsWI1Boq0Og1aBNl9KQi9RtnF7Tg1p/BM8VbEFDhwy98nVOhodICAQbh
	1Z1eloLiLP7WQPvGVxHiraMq9o1MKOwP5fnk+R5y4V1y+4j4HUX+MmaJmDE5SpkciTTh9qOlW1w
	RtfxmnTP9to+9R/7KSUdIlszUTgK/YFY3r9+DxuXFdW56sIOQVs1+maNIX9wgPH5uPXOVGUl6p4
	NaW+ECW+YToSdnpk=
X-Received: by 2002:a05:6102:2d0d:b0:610:76c6:b74a with SMTP id
 ada2fe7eead31-62d868151a0mr372350137.14.1777660434999; Fri, 01 May 2026
 11:33:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:33:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 11:33:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <662ddafc74fa90be6fdf7dba09bccc53f821f328.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <662ddafc74fa90be6fdf7dba09bccc53f821f328.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 11:33:54 -0700
X-Gm-Features: AVHnY4KBx_0gaB7DjfqkDfKW0Ew0L3t0R6FaDd_9Z8Ub7GHIEHP6tTt4gOQ4jX8
Message-ID: <CAEvNRgHE1kVUq4vdFMLGM1jiQGnTMDehkDK1oJTx3vN29-7rxQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] x86/msr: add wrmsrq_on_cpus helper
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>
> +void wrmsrq_on_cpus(const struct cpumask *mask, u32 msr_no, u64 q)
> +{
> +	struct msr_info rv;
> +	int this_cpu;
> +
> +	memset(&rv, 0, sizeof(rv));
> +
> +	rv.msr_no = msr_no;
> +	rv.reg.q = q;
> +
> +	this_cpu = get_cpu();
> +
> +	if (cpumask_test_cpu(this_cpu, mask))
> +		__wrmsr_on_cpu(&rv);
> +
> +	smp_call_function_many(mask, __wrmsr_on_cpu, &rv, 1);
> +	put_cpu();

I think

  on_each_cpu_mask(mask, __wrmsr_on_cpu, (void *)&rv, true);

is more readable than get and put cpu.

I understand Dave wanted to remove the ugly casting earlier, but perhaps
it's okay now that the cast is wrapped in a function like this?

Just my 2c, feel free to go ahead either way.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
