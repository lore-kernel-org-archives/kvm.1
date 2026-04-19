Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C52877F4
	for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615050; cv=none; b=EF10K8dX4rfHpfFSanSg+5fRDYynHo7QC7XoH3YbsoyCDAI+N2KwuVV1En701e4NgCh2z2ox5Ks93vS7Y7ELN6s8shdsjJ430DULCU3f5TyuQWc74LZy1zV/YyWSZ1w1PRZw94n3UG0c+jAm6s7Lb9CrBw8yBjTna/al0sOE0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615050; c=relaxed/simple;
	bh=e5Sy8oC/95NF/dg1ngcBerX98X/v6V5fD+uFMVCMJIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quRNlSqGl4bdPwhFEdVjZyXr6fwosvGG5smi5+b2eaRDhmEIXA0vw7wijL00YBShuC+8vDgxovgpyyxMYCPrB+zn6j9XYRKf+qBObg/Lc0GpgEzzocFAlPNYVk+wM9t55G7T53VV626HfnLCOHZ7DGabblfXRPaPjSn1BzhmC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmkcjs8s; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmkcjs8s"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4888375f735so24650155e9.3
        for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776615047; x=1777219847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HL80pioVPrcP9MAPQXRilyJEi0wxBmY35dvijnyGIE=;
        b=vmkcjs8sf6qnnxHp2QPpDFbaS+uKyRUSsL5CXyDjvg7SFwrqFIrP6VQl0xXDNGIukG
         1XvMeu67+ilrS09ulPloXbZCfB7+iNHwfedNJzAumWsHKrY+070DyIwGxPF3Em0yxMe0
         GrwwnFXNtk7FA+FFkkJctcMEhsiLgPJUjsVqViIWY/qiln45LmlwNcJsbEOx/J7mPbyI
         45BziYlQM2Lv64mfvtNYWGM3k+kgYc2Ltzy3ff+fJR0/szifK+R/DKpveoHh1LKsF3hB
         F5Tb2ay38ASvPabN1o4D8iJogCm1CAi1OI/8QaIsByt1hwajGsMOFXmV0cBjFzPiHBZU
         1kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776615047; x=1777219847;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HL80pioVPrcP9MAPQXRilyJEi0wxBmY35dvijnyGIE=;
        b=UTLld4ESNZ8QIj0BBTRDUA+O7J/QragJFh+VGWzccEPrKBkgsSsxS6VwZEGuNA/tKS
         GpD+SHgGkQ0XzMFLeoV7fOdvLG19Ew7e0BsDBCwj/e/zwwRHe14CZMSGxOjYvH4YJGS4
         OdfUuNlXJY0AHizZ/JFOI1luRtUrMQqFbzFhkQwyRLQaLWCnX7gbRwHokflqNdxECjvl
         dG08/NqZqYCwshob+ZUB9MyCU/kbMgPiCfb+SpYzZQZzTLw97AnWYW9lGa1QyvcEXZgq
         YfKRfE/aQZLf6XJi4laO6YLkyIOEj4IHHjERS3zsXaSnMyy48WUzM2B977NIEI927lVW
         7/vw==
X-Forwarded-Encrypted: i=1; AFNElJ+CTRsm++EWPKLTMu8gJ0e8c6puprZtPLK3lvPYEI43eF+7bkhOkn9wZF+K9UbPKVyvZ2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrwvaCol17rgv/UfBkmiPwubBnPO5hAtNa/LMXeXWL3qRP3vz
	NkdV43hPBNLAEbxGbGcI/HpxclDfKAto/zHVHKI2t6g0rd+Bxc3CZQVDLMTjeLSM3mRhE3lTz4n
	K9rBmBWg=
X-Gm-Gg: AeBDievgIXTbvgcKYDuC+eG5lIjJZdNCUq0B2MUmUrpkkQuxtuRTbKycafxO0hLLxOT
	JuoQf1Bqc9/9r1xKLG3Ps97DwWQHAYRElhvj4piiTeBqEDnwN2h9MHcz0t6foLXRyhQBkx/yKt/
	O2Adg4ZxAJrD63Fk58DN2J9tCV+GHKghz0mcQzElxskNzxamUlVL2NdTXVN1LbWeVcqkNlhHkVl
	aDaMWSLSg4wf3/VF/zJpRLLWK5A4AwRzNU3r7QMt/pGfHp+RYtbyL3Xs8CgDvHZpfp1YnZl2j5e
	8YeWoA8/GC/vACzvgqK+IqNxI5oe3vCSlgeVEAe5zj7VDcgkB2eOGABhj+JWvnH1ew10smrTRWM
	ZKt8MKmy8CcazrWACe1MwUvbch/WWLy/P0qPohbKEuKiLgVWlTz3ckGtk8vIV0t0W2fHiWinPB0
	YJc1OpAZ+SKi5I8UdxFjYsJMW0dL9v57/8uCPAsVWRyCX9Gpns59rWZNgT2zcBEH6aYBYnO9ay+
	8jW
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488fb796fa0mr137044735e9.25.1776615047261;
        Sun, 19 Apr 2026 09:10:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm19669804f8f.14.2026.04.19.09.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:10:46 -0700 (PDT)
Message-ID: <d64dff93-7129-4c39-bf9f-d2a8cf2ee4fb@linaro.org>
Date: Sun, 19 Apr 2026 18:10:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-6-philmd@linaro.org>
 <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/3/26 13:59, BALATON Zoltan wrote:
> On Thu, 19 Mar 2026, Philippe Mathieu-Daudé wrote:
>> Prefer the address_space_ld/st API over the legacy ld_phys()
>> because it allow checking for bus access fault.
>>
>> This code however doesn't check for fault, so we simply inline
>> the calls (not specifying any memory transaction attribute nor
>> expecting transation result) per the definition in
>> "system/memory_ldst_phys_endian.h.inc":
> 
> Recently when trying to remove _nomigrate memory region functions I was 
> told if some convenience function has more than 1 use it's probably 
> worth to keep it. This looks like similar case even more so as the 
> replacement is unnecessarily more complicated. So what's the problem 
> with ld_phys in the first place and why do you want to replace it with a 
> less convenient function? If there's a reason maybe say that in the 
> commit message.

We want to remove the legacy API because it does not "allow checking
for bus access fault." The cases where we can safely ignore it are
rare, and often ignoring it led to subtle bugs.
