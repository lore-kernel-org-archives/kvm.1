Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF0399018
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916963; cv=pass; b=kSP1IWMKd+a4Tr4jlth8PGd9MfVH3Ut3h04+B7UPz9Xrdmy3Xs7omIsxgS+kDvV7wsucn/onXHjiaf/ji6moOVrdLXIvak7HL/u3fM/Sv7akiINai387IHvOhn7CuPKEPdO6HxEcNt4zDmIXWu+e2kdiPPsWjXoyljXLfH0SfJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916963; c=relaxed/simple;
	bh=XvYGqqEvBlv6YcdQYQQO/+p9qmdUFcIrokRBwG38fdM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITPTZ4Cj+cO2scGedQXRnKOIwr5EKKx4mAIKKxYL7C4s/m+LXjKgrCcIT+60jBenm2hPcjt87CEeAidZ1yTTDLyZ+0RbVtwWsMo3s+HyMrg205SCJBeZR76DFrEBKk2ieEReT1sozBCu6dnWR/DIOyvlAEc++PycRGxlrTGt0Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i3YSXqRg; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3YSXqRg"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-135e7f4a295so5060443c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 14:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779916962; cv=none;
        d=google.com; s=arc-20240605;
        b=epF1ditOuEHhZXuYCgkL5Atq7uXXUZVyN1ziHzKvrVaFU39DUsJZbpZDH8ZnzbZNn1
         HJgW2cikFRmzae28/sNHEx6jTw04VkWG9Lvd/jgE5qBGNOUGIIQMIymBY07bL/493b4j
         2aW+80lqpTL3oz3GVEqIsFrmORHEG+5sKq7nk8sFj5lfe1iRS5nURzFAYgiKltCkvupi
         AP/zpg8gm0Fsn9O8BVYNvgcRJLRQTk6qKROBfYKnHYXHug2OOpB0vlH+m7+Sv7mb8zXw
         LLPP/MSzCrVACnd2V5iSSJsZ4Lp9ri9oODJkFgZ0nLGIxpSPhPHo3sbGkYg+X9FAg5IL
         5yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=MqRrWniySfNgETbgp2UzJpDVVwuL7fhZGroChWwpnhI=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=BcjDSGijlSe592hmFs7P1CjO8TFEwEoQ6UPSe9Gds7QxOqDx8MVep/L8U7Np4BxLBi
         v9OSrKr0IXhfmQeunPN6s25//id/OPec6yTZiU/UtsedETSxkWzkiwCccOcPNrFa/TRS
         yfZNJzRwxPD8dCZR/7gKz4p6V4HuSM9sfXc9GyuTaaCm3wHZGaL+zKkQEp0FjsVNxhVk
         oZ1lN5zwTy9IUNhLqAeqUMjwWHXH0gWnf65ZL+JQXv9wJZitX0XA97TohtirUN7rRvj9
         N99hWs/vLi2hDMk/zv8RUGPAp8JJ16S+D3GM0YGlDtxgl5vJrqX9Omf04GE7fVQDIWtE
         3x3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779916962; x=1780521762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqRrWniySfNgETbgp2UzJpDVVwuL7fhZGroChWwpnhI=;
        b=i3YSXqRg6/6wMUeTrtHxQAEZ5qcyExujsVWzMHAqLF/8c5ZAnz/BF0VcJLkfMTtRib
         g9o8HATd5gsxtROcqJGlBS8w1QpFygNAt2+rJv6kin2mVpDKPASpLc8Cv2MJnJwWTnLX
         fyuEQSHFFGf425l0Nx6h8Te2sffjbCXQAFRU/glCFRwA7nN+qE/bxua6AqTXQV1phk4j
         I+h0hMevToSWac8bhO/boPrl5+iPhclDGqyLCyTpiF0Ubl1yrSSL6jyK+04Ayf8ZjSw5
         2pEtcWgsK/sAtsN3TpM2ICBxgn4zPWfOSz8xCswQ1Mm2phBUVH3AV2cvgVAYpo71ao/8
         NQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779916962; x=1780521762;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqRrWniySfNgETbgp2UzJpDVVwuL7fhZGroChWwpnhI=;
        b=IgOnwOmK5efwRR4iH+uYzhXXWRRx7RWzFnq4yfkoRbTaD6tI3PDZDYTVlt2k97Fm5p
         MtixG4946kEVpyMZ6RCbh7j4ZRaMeJO+72WbZiv6PfgWBFykXviRMNCzuxISq3ecmpnM
         S9QQkcmusMYzVy07qY7SJrjEEF4XuLvfbGEoORiUOAehBwd6hPke1jCbZyfhjqoqU0UT
         Glm9DKtxBVWXtnWCclYuxzeKL51igTk6wiiBJbUALrsaQUlwKPT8raJLRZwQUsuYENPF
         N2CKKaSooSNzfba5nlHLQ5PdaXqTYmTBPfpXVsPg7qe0ExX6l6BH6C3g8MPaqFNLzQii
         vRHA==
X-Gm-Message-State: AOJu0Yw/twQqWp2kJp/qlfuanJd0i6KucsnnxhSIOoFbt/uCUkfVJs44
	1JXLVidfbVnBjoawEE8HcNBT1xVt6ZqCTEIJeo02oWp0Hacf1/5/oL9PHmZC7zLx6pnlgK79qTi
	EDJRz/YamsT/2zZt9Xgvs+LY8ngXlpfl4JxDesUbwQB2j7wUisiNXg+QbZSQ=
X-Gm-Gg: Acq92OG/55TXBvihuEmeAmdoXsN7M0bRYbZXHdBcCmD3+zS9ZIlVtCD26BdY9+sNJdr
	Z07cMNoqUyfQ4t9+rU33AT81hiFRf5evW/QsNY7GLESWYeN0qrko9GXM5AvJafr06bI6oPc+hNC
	GZpl0J+u63Lfp4zkA4cc7BwnXrk7b2XeB+T5VCCVwSej7ax62xYppkVu/RRdhtiIJzXWEzic1o8
	sSqr3ISwEU3AMHyLhKtcrTOYJzMeEC3cQs/KlnITl89eRsP1D+KNLuejEoCTYAyv1m44Fya4Nrt
	phhx/FAsvQKY3xjHWxW04OyuJGQ3oJmkeow5RnuRQwSj+P7N7f6TCGT/pRnF7oR8t66pl9TGyW9
	DQL4=
X-Received: by 2002:a05:7022:1001:b0:136:4e2c:95a2 with SMTP id
 a92af1059eb24-13660b31dabmr6655425c88.0.1779916960937; Wed, 27 May 2026
 14:22:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:22:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:22:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523005223.5B9651F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com> <20260523005223.5B9651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 14:22:40 -0700
X-Gm-Features: AVHnY4IfsDU9jpMtFJKqZ3ZHdzH1mupxosrfwxX5_x8ImA5PvpS6zA3RdodDL28
Message-ID: <CAEvNRgFcJ8t=rxHAcGPmaJmQPpqHMCJ-edZ5CFqaF3+kMC+-ug@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] When initializing a newly allocated folio, only the first page i=
s zeroed, which will leak uninitialized host memory to the guest if the fol=
io is a large folio.
> --
>
> commit fd652f7fefc49fa2d4a303f4d6cbb5c2dad23874
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: guest_memfd: Only prepare folios for private pages
>
> This commit restricts folio preparation in kvm_gmem_get_pfn() to private
> pages. This handles future scenarios where the fault handler might call
> kvm_gmem_get_pfn() on a shared folio for a CoCo VM. Preparation is also
> properly undone on freeing or conversion to shared memory.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 9d025f518c025..4f7c4824c3a45 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>
> [ ... ]
>
>> @@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_mem=
ory_slot *slot,
>>  		folio_mark_uptodate(folio);
>>  	}
>>
>
> [Severity: High]
> This is a pre-existing issue, but does clear_highpage() fully initialize =
the
> folio if it is a large folio?
>
> Just above this diff context in kvm_gmem_get_pfn(), the code clears the
> newly allocated folio:
>
> 	if (!folio_test_uptodate(folio)) {
> 		clear_highpage(folio_page(folio, 0));
> 		folio_mark_uptodate(folio);
> 	}
>
> Since clear_highpage() only clears a single PAGE_SIZE page, won't this le=
ak
> uninitialized host memory in the tail pages if __kvm_gmem_get_pfn() retur=
ns
> a higher-order folio?
>

For now, guest_memfd only handles PAGE_SIZE folios. Let's tackle this
when guest_memfd supports huge pages.

> While comments in kvm_gmem_prepare_folio() state that the code is ready
> for huge folios, silently leaving tail pages uninitialized could lead to =
a
> severe information leak once mapped into the guest.
>

Support for huge pages is limited right now.

>> -	r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> +	if (kvm_gmem_is_private_mem(inode, index))
>> +		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>
>>  	folio_unlock(folio);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D7
