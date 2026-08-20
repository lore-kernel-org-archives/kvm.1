Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885B3CBE91
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217121; cv=pass; b=mx7jly+A9JmJYLQgibUULqLcTN1xLKa56Bbh6t+C5hbbGirtLuC43pJpdqvQ1ga1gMyYJSNPcuBQuUX7QHitjcXm7mf5EYRpso+tev7uz7OC3WR1N4AnYQ14KbhenYB1czDe4//8MZteMtI7xppM2kIUbhg0X7cj//U8o38pYlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217121; c=relaxed/simple;
	bh=2ZeMm8DE2O/5B0Bj4WZre28WSgQ7huhL/ha2kx6VGbA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8Y5pXqqJBMKiJ0FPf92wseaDfr5hwtDOJ4hqleW85RhSzM3+2sHVDevdTWuSX1PXI/Ygzk3BkDYXUetGiWvJYxFirL71rFAJVdf01vd6KZFBgVG20qEVniNB02e+LrsT1V6HfRzRV72x3EZ2psLafwiESNkoU3kpGBIWPCX3L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhKgEx9y; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhKgEx9y"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90a80860d35so22463016d6.2
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 02:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787217118; cv=none;
        d=google.com; s=arc-20260327;
        b=mDzOSnaX1JoAd0RqAAtWsFdVvRCpwMQ/A2zo7xsGx5XjiYo8sAZsVdxH8UZJrcbBHo
         z8aDP4NJjvw8xUFjsa/aEGCoQDQzckmr64qkcNySI3esXz93iDIFLoDONCNp8mbT7l7a
         C4pRIknb24hiwfNqC9fZeu5sFqLX3WfM/2USXskp6hLlIM2ZIPXUyCmB7GeikhwEgEEh
         6QofdfkDA36EeYQqF2+Bgqodg/9FDmu/Gs8gmW03mBiEnVNH5OkTb1H29lpltSrVzKEh
         UCpU5k2ury2HWjqNZoC3CKHGWvYRhQvnWRCbYPsGs+YIdJeBkKxNQaeT62e8Hci8eC8R
         OU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=T86+N4faSKKA7N1eC4Sy9A/XUrNm+NJ7hqhkZ646NMA=;
        fh=53VmE1GhrH6W44RH5ZUqdaftLWUYVR38MP+zbjX0Mhg=;
        b=aqWBRUACk8OhUjq/U6Mrxl6lP2imNb/viShGqGU1NPQ59O6AHWvFMg2wTy+dFLMVGW
         EtHXQrmNrMfHZGanLRfihgx/juz0+g4NABXpLQkeIxBba6f7AqfqJ4Iy+3fJHQE5xmZB
         3xZzxwg4K6F/1NY+X+mDFI8//G2RXhK/KFrcTKMVo3l/w/99zW0+Idrq08Bwk/W8dJX0
         D2jY69UmI+zbkx9JHz5EDSG4cDoqy0oR668QZYs/MiYRmz3L/jLySAVxX3UlhYrwTY1u
         WVknGOtjtlNVyheh60iGTxzcMELdHE8KSFAMlTchDi9qPKs+QhB1Wv5PlboIg1/cvbzP
         mdqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787217118; x=1787821918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T86+N4faSKKA7N1eC4Sy9A/XUrNm+NJ7hqhkZ646NMA=;
        b=bhKgEx9y8XJzQVqwUAJ5xDaRAvWsg+AxgbumYw+xzyP66mNe853Z+YEDwJtSn5cekk
         8dAFFabfX7AlQyiSO5903Jp+H9aF0VLIbCUSC49nLMgwcNtwgljBfydYlEo6zbtPBM8c
         Yby8Ea3epo+kL92j/97ecK5ciJdVOqGEoBJkkXz0pKsaBWiF7RuELceMS14tIhDhkL3Q
         vDfDF3vVUaohPb/ttVUKscPxrv25yCyOf61BXjEUFZ4ddw2VarjvbVtUmN4Gw7oOhJzV
         5l8aLrv0GhypkV/WfURoZ/IOokNzkD74CGsn+u69W2pZmoAus9yW35VZ5DnzthaBLH5z
         Q7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217118; x=1787821918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T86+N4faSKKA7N1eC4Sy9A/XUrNm+NJ7hqhkZ646NMA=;
        b=d39IMcdpW13+z1weIatRgjXN/5urtBNwYD33w2P9WVvub+M66qZsgUE5/i8W/u3jmn
         E/bNAzyBnBFOem6aPqVJia2ypWzWcQcdrz52PnMKk724d2KbEChzxAH5XsiP00C9ARg3
         5xDO7kyA0jOi3f0mZ9peDlKieBdDi1bep4jYa9Z5I1PkX/4/HIMNENHBafFWXgYlitl6
         ++M7VJLQwzo3GUrhsIhRo0seoMXdsyFx6u+KPjuoFKLe8W1c6kWEV5uyuC7rwSCtlbcw
         OsobLURUX7TemmVy0hc72nETPsEOD6+Br1wFjJpTbw555xpEHpv+lAxhnNb+6rBcspTK
         Rx9g==
X-Forwarded-Encrypted: i=1; AHgh+Ro138VBk1vfePnSISihZpcHqxszAgaTXv2NCUikb3t0IhaBnVQjpoGnpzNX1rIzEokPlRo=@vger.kernel.org
X-Gm-Message-State: AFuF++mqPsNo9vk177B4RNBZZOx2m5qXjZ856awyn+TgY7YOwij4GRaN
	Di9ex4i+z8FaEkEV1CLDKbehp2q3qdxUa0VDkWpE6frYvFj/Zsbg1OgNxCE6WSyla7eSBapjNpW
	ffyDjDEI+0vpgIww43HnFJJLhGNc3LA+vXERGC69X
X-Gm-Gg: AR+sD11lUpu0bxK5jw/sYbPYAwZYG5D8etzFBGpfcKNC8OZe3+Te2qwwO7+EdT7LcYM
	TuGqOOuaM9e4B6CK8vgYSRnMeoqmQ1mDdBz5oeWwCqGT/Y0NOtCkN4y3rupuZSDf2vcx9XbZfKZ
	spxo8vs2Ryh35EgF1oX8pjFXDYsHjljGljdPigGt6O/upVhh3vknx40f+QWkx9f2OqYX1kA1eCl
	+gATcdI3o3ToKjamwYIPPX2Iefq+bUTu9s2aocvv5ZRI39LGHvvFp0IoqozpnwznWyGnOdhfS8O
	PDBppg16wkaxgXKzm67Pqi6NwIH/WrQFGPYzmPZowIuZRN+nrycis0GmQsajN5XTBIjG3JppGvA
	QPh9JF3Ju1dAZ9n/HMU5RdnNTyM+QNQ==
X-Received: by 2002:a05:6214:2c0f:b0:8ce:b2e9:a4bd with SMTP id
 6a1803df08f44-90c5eaf6f46mr112398486d6.17.1787217117566; Thu, 20 Aug 2026
 02:11:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 02:11:56 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 02:11:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260818093102.06F091F000E9@smtp.kernel.org>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-4-5298f42d49bb@google.com> <20260818093102.06F091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 02:11:56 -0700
X-Gm-Features: AcwNN1XbpH7Dzoo1BVfklWznhbNlM9Zw2DBzd218nK1edqRg34m39L76lh6iCww
Message-ID: <CAEvNRgF08W_KvBvdxFskPu5rH1hhUyNm9GoVZXEq4w09o3qWKA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] KVM: guest_memfd: Stop returning struct page from
 PFN lookup
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Concurrent execution of KVM_SEV_SNP_LAUNCH_UPDATE and a vCPU=
 page fault triggers a race condition leading to a host kernel panic.
> --
>
> --- Patch [4]: [PATCH v2 4/4] KVM: guest_memfd: Stop returning struct pag=
e from PFN lookup ---
> commit 766989bc1910148a83bffa481ae22b1d1eb71f01
> Author: Sean Christopherson <seanjc@google.com>
>
> KVM: guest_memfd: Stop returning struct page from PFN lookup
>
> This commit stops returning a refcounted struct page from guest_memfd PFN
> lookups, dropping the folio reference immediately instead. This prevents
> concurrent guest page faults from holding elevated refcounts that would
> interfere with in-place memory conversions between shared and private sta=
tes.
>
> Link: https://lore.kernel.org/all/anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.=
com/
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index b596486d184ca..589762140c3ef 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>
> [ ... ]
>
>> @@ -780,11 +779,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_me=
mory_slot *slot,
>>  #endif
>>
>>  	folio_unlock(folio);
>> -
>> -	if (!r)
>> -		*page =3D folio_file_page(folio, index);
>> -	else
>> -		folio_put(folio);
>> +	folio_put(folio);
>>
>>  	return r;
>>  }
>
> [Severity: Critical]
> This is a pre-existing issue, but is it possible for a concurrent page
> fault to trigger a host kernel panic via a hardware RMP fault here?
>

I thought guest vCPU faults and populate are mutually exclusive, but I
couldn't actually find anything that blocks populate from running after
a guest is finalized.

So suppose the vCPU does fault in a page, the zeroing and make_private
happens under folio lock. After the page is obtained on the populate
side, there's no more zeroing, and sev_gmem_post_populate() would fail
since the page is already assigned.

Suppose populate goes first, the folio_lock keeps the vCPU fault
out. The folio is zeroed and made private. This time,
sev_gmem_post_populate() would fail because the guest has been
finalized. Still no zeroing after making private.

If populate finishes successfully, then the folio is marked
uptodate. This is done outside of the folio_lock(), but at this time the
vCPU can't run so by the time any vCPU fault can happen, the folio would
be uptodate, and there would be no more zeroing.

Seems like all is good.

After conversions, filemap_invalidate_lock() would make getting a pfn
and populate exclusive, so that's even better.

Let me know if I missed anything.

> Looking at kvm_gmem_get_pfn() in virt/kvm/guest_memfd.c, if the folio is
> not up to date, it zeroes the page and marks it up to date:
>
>     if (!folio_test_uptodate(folio)) {
>         clear_highpage(folio_page(folio, 0));
>         folio_mark_uptodate(folio);
>     }
>
> However, in the KVM_SEV_SNP_LAUNCH_UPDATE path, __kvm_gmem_populate()
> fetches a folio, unlocks it, and calls post_populate() (which maps to
> sev_gmem_post_populate() and calls rmp_make_private()) before finally
> marking the folio up to date.
>
> If a malicious userspace process races a vCPU page fault against
> KVM_SEV_SNP_LAUNCH_UPDATE, could the vCPU thread running kvm_gmem_get_pfn=
()
> acquire the lock on the not-yet-uptodate folio and call clear_highpage()
> after rmp_make_private() has already executed?
>
> If clear_highpage() writes to the page after it has been made RMP-private=
,
> this would trigger a fatal hardware RMP fault on the host CPU. If it writ=
es
> just before, it appears it could silently corrupt the encrypted firmware
> payload.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-gmem-no-=
return-page-v2-0-5298f42d49bb@google.com?part=3D4
