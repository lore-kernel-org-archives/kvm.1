Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03B3939C2
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521739; cv=pass; b=J0wZmaWh4yD2/gSeSTT3ScrwseZLP0k6mOXqv12zMrL6qDDmJl+A9sLb6zohCEmR7KI7zItR4gS3V/bW0TTsxXa0vHrqKBHJGCZcED3BWfJdZRhmmsyEphUmke7fgTYHjuTo5PgbloJrDMxOo1yTT1WoEfvIzndoxH+mUiG9QG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521739; c=relaxed/simple;
	bh=RWNwgY6nvbkoNOyo3h3qny82YPNg10V89sEXAbS+GrM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFWVnY5XXdg53Qr+wQL1VR9o1kUURqyzy62gbwc/r4SWwip5caV3XC+U7L6qN/OmAhtqACnzaBOP+fX2StTwOetOtZG8cW/pyEKFUkMr5CBchJBsCY0WaVm880KwfPBTfps6JS783fNtT6QuWGfCrGTSs9N0Ggdr1c7vlmEtSFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izW1IRlw; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izW1IRlw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3074adb8fcaso1915243eec.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 14:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780521737; cv=none;
        d=google.com; s=arc-20240605;
        b=dyOVIzJzhOCHjh7JQJsX8fCpSGfyJEHdJWnI4N1t1PaZdH0DjlwM6Zkb/qf9YHgnIj
         cBw9JR9dbWIyXyrzy4GRoJWolPUgOTj2D98I7/Iub/DDYih5j88Wz+O+Jr46foRFBUsw
         rDdQhM+xIFkpEcLnUMlskw55nSktZFKQrK80KEkGVqUfinggqUMiFxvwcXPptqfhh6oO
         8UlX90XGWtOSbozuH2IQE1bEtnhD5si7uVhqVlJRMXvAEhO9AzKFu1cr/FcXEHwgbriC
         knQAD6r9QxYr1Hkl+6JgxzjiCIgWPK2NFIygRRRJK80y7Fze85obtYbhkQ5VrNjuQoaB
         r4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=f3cu2RPTvjqp0oeoiNIdRmHOIl8ZKDXHQ5y2DINTJSU=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=FGlG7GVComFn1WWAF32TwcapfP43GLLJHVLXU1vx6jH+17AiUJFGwSJHauKQXQ1Y5X
         vQZTxZJe9roxr6bqiFdwURX5r6onP0VlLK5fMWDPQueKMj+vliX5CTJ9GrOl87zIeyGL
         d8AluUDzfw9tYivx96KiPvSWl5hNG1YLkXPDoZc216dbDWcbFcRpDIGgUQbxWR6gKybS
         ECxgkGhq8UpDCkzvjKIJMgmDIO9507KIJNZ1gD10+5Nl2fhRs3Dd80L/nNgT2r5wm5wU
         RCACm4hHaP7t+/Kan0+5JPc6Ye1ckjFM/R4sXOgNpBOSPbV4/B9cctdeXypCAhF987Q6
         3MQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780521737; x=1781126537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3cu2RPTvjqp0oeoiNIdRmHOIl8ZKDXHQ5y2DINTJSU=;
        b=izW1IRlwBMwJv+HYpxeoT7NUh0BGBHbYkbt0dkthk3gVaQjdVKb7qV0zChtWNeAaAk
         w7d5kiJiqmovB670ge67+bVL9Y9VlZgUO4Fqo4UlOHnDKtAaJcs9lYaG0rn/o8hRDF5d
         4tQ1o7cJPoTH/+6HWuxqWhU3tGSQpWwnZmWl3lNM3ix6Spht/NMCyPQTnd1OZaSKvKTM
         /lrz39mEDC+BrUfU8GTyCOSS2581EX2UZuLB84nmxLctyPcaHqQr1nkBM8YUukZEQjho
         wIpuhce/EaOw+YJJSF8AZVw12oEanfyXm1nzvGQjv6wXRbSpeb3dZ3Z1VYhH2/TowiPe
         p4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780521737; x=1781126537;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3cu2RPTvjqp0oeoiNIdRmHOIl8ZKDXHQ5y2DINTJSU=;
        b=LsBEaBWEvgd6ihUa6zaXNlgGLlQA3uwZ11/n4MEB2jvR1UhrLn2q92ydm0tIM6V3Fq
         AXRTiDJ66guWY2QsdjSzdG7pPxQFm5Txcwij2HgsVkClFE2flUfowEL3cbvS/LrM+XuS
         1awJiA+FWaIte1g4xupx8V2Hl0oJH8LFNr4d3vCuxKGKP7yAfkISqHtmwdk/XObuXU32
         mswDgIMDjlLfUueoseIB46FEskQrjPsqn3aRGOwPp/fYQKOTLmLWerjnPS04ccNxeQYd
         jwaVZqFITGlW2S9M3qMKi6GeH/DQKprnR/jX4c2RcaJR/917CcDRgkmqarvvy16ncZZY
         WvyA==
X-Gm-Message-State: AOJu0Yxyr3b2TMe++MX41f/6J/GFe9p/Jo5mURbYyp53XoTpR/0gnE7/
	FNfYV9mJ1DbjTHyMUanj59XcB6HD9HHPtd/HK6BH29MLTO1YYiRvLqhOBAS73s7hnWJ2kD4QSm5
	k87P5UKd7Qv+gjk4LOdTS0URXHFsUrcqK527sQqME
X-Gm-Gg: Acq92OH9wQIfHg8fz+q9cX54eCfYXUzFDgNQ0hwCPYECDuaUcDTuQ3n/1/SY44uQLvd
	sPSpCfVxLFaRXzbAcfZtG1BdR8Srey9Gl+ARALMCT89H37QRLsZILFXiPeLAL4bNWBLdG4xVZVO
	xrgdMGgxQ+EeQ9hussS1zFVBvOL+mcDtPT6rI6ZqvZ3CUgBwzsoUfTgjQ0FYtkkva2eIdqgInAQ
	nTqp6o8cUR4kKQbQseNzPni/tZ1xxfOHg4+BwPHdC3px+3MUEWvV2jN6gw7Df9HxNcoNBmoRX1+
	S4okTvrlCqYrwnUj6HvZl6o5/4ZAGH80iltu1xhvrYxYRg+9ouqp8BsEIdeltRM50viiZFpwIbJ
	oxfvy
X-Received: by 2002:a05:701b:4185:20b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-137f6bd997emr2010151c88.31.1780521736748; Wed, 03 Jun 2026
 14:22:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 14:22:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 14:22:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523010752.CA7AF1F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-21-2f0fae496530@google.com> <20260523010752.CA7AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 14:22:15 -0700
X-Gm-Features: AVHnY4JrVmBL-PpY_h76rfTQEL1WoGJxRizc7dL5aP2fkeFucmBAUIPr9JBEYsE
Message-ID: <CAEvNRgEVC=fFuKVgZYvWyZD7t_zvUZihFG8hrACjvtkD5cwugw@mail.gmail.com>
Subject: Re: [PATCH v7 21/42] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Uninitialized host kernel memory is disclosed to TDX guests =
when performing in-place population.
> --
>
> commit 38e76d2ce3c699d4b64b580ab16a7b4cbc2b189a
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
>
> Update tdx_gmem_post_populate() to handle cases where a source page is no=
t
> explicitly provided. Instead of returning -EOPNOTSUPP when src_page is NU=
LL,
> default to using the page associated with the destination PFN, allowing
> in-place memory conversion.
>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -3116,8 +3116,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm=
, gfn_t gfn, kvm_pfn_t pfn,
>>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>>  		return -EIO;
>>
>> -	if (!src_page)
>> -		return -EOPNOTSUPP;
>> +	if (!src_page) {
>> +		if (vm_memory_attributes)
>> +			return -EOPNOTSUPP;
>> +
>> +		src_page =3D pfn_to_page(pfn);
>> +	}
>
> [Severity: Critical]
> Can this sequence lead to uninitialized host memory being exposed to the =
guest
> if the guest_memfd folio has not yet been populated?
>
> When KVM_TDX_INIT_MEM_REGION is called with a NULL source_addr,
> __kvm_gmem_populate() attempts an in-place conversion. If the target
> guest_memfd folio is unpopulated, __kvm_gmem_get_pfn() allocates a new fo=
lio
> using GFP_HIGHUSER, which lacks __GFP_ZERO.
>
> Because __kvm_gmem_populate() bypasses the normal kvm_gmem_get_pfn() zero=
ing
> path (where clear_highpage() is called for !folio_test_uptodate()), the
> allocated page contains uninitialized host memory.
>
> Since src_page is set to the same physical page here, will the TDX module
> read this uninitialized host memory using the host KeyID and encrypt it i=
nto
> the guest's private memory space during the TDH.MEM.PAGE.ADD SEAMCALL?
>
> Could a malicious unprivileged VMM exploit this regression by passing a N=
ULL
> source_addr on an unmapped guest_memfd region, causing arbitrary host ker=
nel
> memory to be disclosed to the TDX guest?
>

This is true. How's this fix:

Author: Ackerley Tng <ackerleytng@google.com>
Date:   Wed Jun 3 13:24:56 2026 -0700

    KVM: guest_memfd: Zero page while getting pfn

    Move the folio initialization logic from kvm_gmem_get_pfn() into
    __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
    kvm_gmem_populate().

    With in-place conversion, the existing data in a guest_memfd page can b=
e
    populated into guest memory through platform-specific ioctls.

    Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
    might contain uninitialized host memory, which would leak to the guest =
if
    the populate completes.

    guest_memfd pages are zeroed at most once in the page's entire lifetime
    with guest_memfd, and that is tracked using the uptodate flag.

    Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
    kvm_gmem_get_folio() since other flows, such as a future write() syscal=
l,
    can get a page, write to the page and then set page uptodate without
    zeroing.

    This aligns with the concept of zeroing before first use - the other pl=
ace
    where zeroing happens is in kvm_gmem_fault_user_mapping().

    Signed-off-by: Ackerley Tng <ackerleytng@google.com>

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2a719faebed8a..7b1f2f0288640 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1140,6 +1140,11 @@ static struct folio *__kvm_gmem_get_pfn(struct
file *file,
                return ERR_PTR(-EHWPOISON);
        }

+       if (!folio_test_uptodate(folio)) {
+               clear_highpage(folio_page(folio, 0));
+               folio_mark_uptodate(folio);
+       }
+
        *pfn =3D folio_file_pfn(folio, index);
        if (max_order)
                *max_order =3D 0;
@@ -1169,11 +1174,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
kvm_memory_slot *slot,
                goto out;
        }

-       if (!folio_test_uptodate(folio)) {
-               clear_highpage(folio_page(folio, 0));
-               folio_mark_uptodate(folio);
-       }
-
        if (kvm_gmem_is_private_mem(inode, index))
                r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);

>>
>>  	kvm_tdx->page_add_src =3D src_page;
>>  	ret =3D kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D21
