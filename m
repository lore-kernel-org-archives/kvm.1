Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289593242B8
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513318; cv=pass; b=HC2WvE15L4+wad65ieEjMQb9qZA2yzLydQXiJP1e/alAf/CsaDDAU69/EPBhzCsh5vBY8rHdnW3Gi5PH9dYQtFZpSrEKdds9lG0j8gB1dCIe6dDIyjjDiYkpufZjV6ENAKymIEMH7682uKmoUy+slh4KX4PiBUUQCtUQdE8wtv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513318; c=relaxed/simple;
	bh=Xc5kcfMakf+nJeCEsm2n26H/r2PF//roHh+fh1kcMqM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYRXB1C6Tq2Upolz9fDGS3Ur0rRHrPYpuqigodJx9ylhzOJjbxVpMmAuCgba1SGvuO8oKXLASE9XI9VDmra0z6ofRop8kFgEOb0sIYUO9Cfh9FIkhPkUSThtcTF05lzoJ9DnEFBpkzj2DmBYsFO+VXZmkovF5Q7BfpD7FUBVyPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umN6tYJ9; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umN6tYJ9"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137f0aa125bso4661185c88.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 12:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780513316; cv=none;
        d=google.com; s=arc-20240605;
        b=M4AKgo0p26sTeYo/oLhP6S30FFPyL/5EwdHQxhZLBV8bDO5cGGOFe7lck1PjJzZd/Z
         NKw8F4Re0L5LF+dsjtg+Iafd+bEpZpRJGLpVuhoH9bAbx6dl5rFkL5CgKb0y2lX+MTeG
         nFhkIGj+LlYNRdYNCYZqsBftn65JYwnMzUDRAXrmvl/CX2FICJj1LVpbafyYeNkeHObB
         P9TAM5bvOz8MxcXyMJMCnCHaQalY4ukblrMBFEBNWfkEzC6ArPQteqBOZJmuzLMfXbLg
         3UsGpYltXQR4bHb3N+1nWkfd83k8c+0ZrZTmkeKN4g3oHwrvyawx3J+rJn4UW1u8AlQ8
         mffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FrdppwqBUMbQkQbLbGXJfGioEcfkU9p7vcumdWWrqwE=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=lqsb5okDvR59RdUKwDJGasZDnheH1Kkxp1DRSS5YPzi6U/barQMZShpLY9VgYnrQNv
         ZTSnYuzjI/5M5JBQuyc1ucsBCqBmJIVpqSPSmK3Vop+rjaF8JpUhjPnZaC9FvdDPB1Qh
         SF6k5LI0cmBLAvVuBDC92cvBOIHuoraEyh2P0KeI4SbZZMDOiKWjouJtGywYa948WXvP
         vJpnzVCIjv7md5iJ4MH1xahPwq3ep12MqH+pb3z+ccRsKGKF4sreNKOTghdc3JvdYGYl
         0c59+K87hVgtBCtUP0+TR+Osv5/58jd2xOdVrYuAcdwR/WsT9KQDumuQ1iSAun1ohZFY
         ofgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780513316; x=1781118116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrdppwqBUMbQkQbLbGXJfGioEcfkU9p7vcumdWWrqwE=;
        b=umN6tYJ9aI9/seg/ge8Dx3B595TrK8bJ8Rgqj1AZvQRM/ptGBTdMZO0eWuwJNg192Y
         Ah+OFNCn+R7/ojcBrB1flrdtsNcJ6GSgpyn6pR7SRbDotdwaNPmlGoh6yD04OCcJ7o0I
         61Vs6v2VnntgY+OTcUCM2kfWgywxZFXWcyjNYR4bfPd34qahCKqUj6NHfIVs7jQIJSpr
         dm5edZAK9awWDRWZVzhTweDnkDrlntyrP0Tbxpsdylhe8Jnqdl8rMP3bbVsGrxZum9bm
         l6Vt69uomftvveCpAin54f4ZKDaU6cXdQSWgTMEZK10Rx0E5YCDOzgY7ANvEkam1noQ2
         YSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780513316; x=1781118116;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrdppwqBUMbQkQbLbGXJfGioEcfkU9p7vcumdWWrqwE=;
        b=G7Yr4Pa+lSSl2L7HKoDrxWButfjqrytqg+Wt+Qpn5P02bablsAAY7Hd69q3e0qWDOZ
         He9wNEnlqEGuG1tjl6ZH1cBQ2gMixHgzLkAVmikOZ2wUMCcroc0CICj2fv+/wwH2vX5Q
         83y+IiiKkFDePzBKQT5E0JsZrwXNgOZvcZOZNNlPBFE2O+fNuMCtQ0YI8hhdL3MR8v43
         +sKkYLKel5SvMur/bpEGg5WMFb88ttWDUVOR0HhuzIde56uRZVXKSXIOnAkPETc9udrY
         gDoZTQJxBAWVo1A3+vNFMzywL7+jzHFNgL0k3HXiegHeWFi6tjfxSXmR5yeQt2ysjs2t
         WdCg==
X-Gm-Message-State: AOJu0Yz8IwE4PHruu5v/K5EIDgiblEO5zQdJAjheqPCfAP9lscrfAOE6
	7MLBcxV1KMJwMGjWS/VPFug6T3rOP9cPZrmKSJkt2CenajUOojApQtJPE5c1OJlCBmLtnZb/GzX
	Jjdf66VMiowA3JloF8rEBlhIO/Sb0fj0ZX6s7R3vF
X-Gm-Gg: Acq92OHslIzVGSQ//Iyfgi1xlUFdDORUJykDCjWnCQ8XEMa9BlEWrwFTzbHfDnUMWHL
	DQauM2F0SJH0q6VudxnvKkqrNhmV5Wb46BOl2i5OemypvqSEFf4GpoCXMFd8DqxlGmb8UDUq62Y
	l8zFVV/I606qd35ZvNtkjienruE4LL+vAePEaEMjTIRyDeVVMIdeob6eUmpHRfe4F5E5Q9np9p5
	0dzE5OzqE5VpWDQMI1ZAvkgdLpOpnLU92vw4nSo2GPQdBnAecBqDNP0NejqNLkcHvqd8SfSnRgv
	ayox1QYkmJKAp/mUySAgPv4QvkRPazQaxXxXKVrHvOcxCiEb5iU8hgoDNB3J69e6XXZCPt2iF9W
	EYg==
X-Received: by 2002:a05:7022:2390:b0:135:e312:47a4 with SMTP id
 a92af1059eb24-137f69382a9mr1895079c88.9.1780513313859; Wed, 03 Jun 2026
 12:01:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 12:01:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 12:01:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523013557.8DE1B1F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-37-2f0fae496530@google.com> <20260523013557.8DE1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 12:01:52 -0700
X-Gm-Features: AVHnY4KsbUCYkAg_J7QB9NZy7MzgdWA0kDAtfdN45OW6sA1mj4HkxgKzF-rW7mI
Message-ID: <CAEvNRgFWBWPKCPWQYCQ_14Ec+Z80jtU28+-ojAAh7rtr9AFwPA@mail.gmail.com>
Subject: Re: [PATCH v7 37/42] KVM: selftests: Provide common function to set
 memory attributes
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sashiko-bot@kernel.org writes:

>
> [...snip...]
>
>> +static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
>> +						size_t size, u64 attrs)
>> +{
>> +	if (kvm_has_gmem_attributes) {
>> +		gpa_t end = gpa + size;
>> +		off_t fd_offset;
>> +		gpa_t addr;
>> +		size_t len;
>> +		int fd;
>> +
>> +		for (addr = gpa; addr < end; addr += len) {
>> +			fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
>
> [Severity: Medium]
> Does this unconditionally assume the memslot uses guest_memfd if the host
> supports KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES?
>
> Since kvm_has_gmem_attributes is a global capability check, it doesn't
> guarantee the specific memslot was created with the KVM_MEM_GUEST_MEMFD
> flag. For example, test_private_access_memslot_not_private() in
> private_mem_kvm_exits_test.c explicitly creates a memslot with flags = 0
> and then calls vm_mem_set_private().
>

I think calling vm_mem_set_memory_attributes on a address in a
non-guest_memfd memslot is something that the test author should be
alerted to ASAP, hence asserting and failing the test is the right thing
to do.

> Calling kvm_gpa_to_guest_memfd() here will trigger its internal TEST_ASSERT
> verifying the region flags, which causes the test to crash and breaks
> bisection.
>
> (Note: I see this is fixed later in the patch series by updating the test
> to skip when per-gmem attributes are active, but pointing this out since it
> breaks intermediate bisection.)
>
>>
>> [...snip...]
>>
