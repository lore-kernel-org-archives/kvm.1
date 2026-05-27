Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22E261B8D
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921943; cv=pass; b=XW3LjHWqWixcGlkzImR3zWAoRV3+Ky6+cBo9MRDSimGHlkvdW52tg5W79EO53My3TZiMKZOzkpWhcfdx9R8hcatQt9bR0SKUYrr81VSBiJ+f3xxskemEruUUbnO89jymjFnOt3hcbDbeX25wI5JWmcMkuMH5rms6KmZ9eyVcu6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921943; c=relaxed/simple;
	bh=6e5WtMjcBsDBDJ8IqEqJkKqSEnkZJFoCsLTVw+spA/g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxLJ2iRueYxi4Y97dqDN283WcgoCx0tnokjdd9O0wn0YtSMmxKz8R46Yi6e44dFt4/XqCFs4oKEUlJlHB64YPfEEvMG6WmK5JLKA4XsCXTjUoSprvoBuRK0CcIClMrNth1Gu8+E5wookEmnRMeEkTi4d6DeW7DLabVYb2i+G4mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAmNxA/d; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAmNxA/d"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-135e7f4a295so5109979c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779921941; cv=none;
        d=google.com; s=arc-20240605;
        b=RlJAgR+/ifZFKpPnKx0uV4oFu4/sQEPAS2p2vo6opFSKxLSX1rDk8vbb6Ud722h0+P
         yymvTbSsymHCfqVjjZRyW3s4Sqo69HWAXxiP7xdogTovvZIA/cVVrpCqyQLBxffaiO/C
         6a5EzpU1hK8txLKImhvcOE/8SuX26wKyUddz1QxtDzQMOD87ESUnNgdr3oYBwQqewL9i
         WRYJNcdvvu6dPImLNXk7JO9o63pPfMfySU4gAsFxua+vks2yUGKuD2ShgL+/4d2hHuln
         dbtVJhQVOrOqspnOlm48Z+ZsjjcD60sAC5rIw9XLkTMb3YZFuwAC9tCRSOJxsm4ruzS0
         zxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=+lPtc5dmsndYutIZiuP5KynRR1ndlzwDT+9x2AXFaWI=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=CU1XhwJNAZ212MyNQpvX8ncUvO3u+pkqjkPD4oZSTwi7GW/E5DLZ7FjXnHF82fA8R8
         OmQVV7LE7YrLhqSI9q171jUo27YhuZb2a3wVuVEYk+L+g1iZPoeLRg+GkBCNyps3ZzAN
         YTSxGjHSm0an/0FbA21CMqZyUBN0f3HZgHfveLIh1rQ7OURLCyIsat4GTJdCtHAYaSRo
         htSfdCJ4ApmQIiu6Fc0gBKI1CO56mPGLG9HEyOWN3nDiEdwhtRdguzgIbFW3Pe/eitjW
         yn9iyFRL0zq16sH5C7HOeMZP64kfGm6rucu8g3IyXOd/LIy/pPu4t2k9E6xBhTctTPSI
         0BbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779921941; x=1780526741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lPtc5dmsndYutIZiuP5KynRR1ndlzwDT+9x2AXFaWI=;
        b=vAmNxA/doEw4soq1ByJrxLlrqbCw5l6pgUBz2It5uRHJuMq60gT9rB9xlP5cAr4PPx
         tVhWOCTwciPhE9Fik/95W4Il6KuR8MtFAA8GElS5QmGgCt82XGNKXOIv4U4Y/ypf1VgJ
         a68SOpQws5wRvTDbErNsPnb9WYZs3mgAAyRhYbhPrVf2oRuwi7iw7wC2PFF2o9hit1cm
         8hPjZG+YK1mVrdgJrSDc+264FYEKreeA44Oiax/HrFsvyW7ZaYzsY6Ne7aEAEc/0EadH
         GIYw/NNFXQigOouwekG1twZjTKefQseggQ8u7GXN5MkzfznsSiP1+kPUGoUWQMxnUQxj
         q3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921941; x=1780526741;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lPtc5dmsndYutIZiuP5KynRR1ndlzwDT+9x2AXFaWI=;
        b=rRdCXHK58r0TMRC7ozyTxl1qJcJmmV3stTnmmnrJqBjiaXrkPjIbmVIwnmOG7JQvDn
         BtJ1ahqiDJJgDk5qxJZPkFILlZsbVMV9v2yupvxs2j9xJrWtMxdtAtVZI7lpjTACKPwp
         iicvaFBwOiJL749rmbvUT+zT+rqDaMXEmw9viSX1cPW+JvlVcQ2GComwbBOr6AlYnSKH
         OeSNyqsl4G6XIdt0H7XQZJ4yHwykx8vjc8wryUxyxkFyNlAPSMp8GUjgiHyyiFw6qOls
         zMIeP/0AHqprI5Cp3GCXtn8oCqdBjFqH9ZmQS73IInNnrtXeYrZc6OyzGKn6rx2D8lFF
         VQRg==
X-Gm-Message-State: AOJu0YzQ21vrnjny4YPWhs+k2NBCCkn2w5Lei867iKAcb9G3URTB3SrJ
	ZYWE1ex2MuY/wf1jwXfmlX+d/2kTe+w9IcEcdr6YNmkkqjQdHGOHJujA38glob3KnZiA4Yi43I1
	dGEKz8Mtt8jgkXgpYXaMOXrUL8q3paW/VXiS6mGXkTmjt4Ld4sTYe8JjRMPs=
X-Gm-Gg: Acq92OFUO7MwYZXeP2JJeq20jo025q8KXQyfrlDDZJCR87yl55PZ1IjjG5m4gKeTB3u
	dI2LKav6YQTYLQG/4Oax4uRuMMbPiyIbJMGdSZZnuv9BtBXWt+mFWL6U3cA3MNkwuCam8w4K3h0
	y+KAMvrUUcvinv+PAaAIZ5L3V6rA7cMrnq7/+RipSL1QAstHKmb48IPrMkOVfoK3bRD5GUzuAVR
	6GE+qmAGdfzehsOVOZnrmJxyIs3mIY5RLBw+YgP8HzaFk422WhmKN3ThQVz5tjr19pbvFMR0dCY
	2zLHJ2c4YBH9ceiXN5qYYbQt/w2TzkXaZrjeEuFvMGKO8SGLW7udH7j9tsvlyxvqevY5OrSo94P
	pZi0=
X-Received: by 2002:a05:7022:3d12:b0:135:3983:2131 with SMTP id
 a92af1059eb24-136341c8b21mr9992516c88.21.1779921940478; Wed, 27 May 2026
 15:45:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 15:45:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 15:45:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523010607.CCABC1F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-16-2f0fae496530@google.com> <20260523010607.CCABC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 15:45:39 -0700
X-Gm-Features: AVHnY4LIsg0HNghLgZYcP1TwllMFGycwHKfgPLHe4qjPEhOmdYUpg_w7XPilrVc
Message-ID: <CAEvNRgH21BoKT1mOQzgmKHKpDi4xbwtbMuenGv5U1ZUSENrJmg@mail.gmail.com>
Subject: Re: [PATCH v7 16/42] KVM: guest_memfd: Determine invalidation filter
 from memory attributes
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
> - [High] Use-After-Free of KVM memory slots during guest_memfd invalidati=
on due to missing SRCU read lock.
> --
>
> commit 405f31b1513a8790de48221d335a28b8c5c7bf77
> Author: Ackerley Tng <ackerleytng@google.com>
> KVM: guest_memfd: Determine invalidation filter from memory attributes
>
> This commit updates kvm_gmem_get_invalidate_filter to inspect the memory
> attributes maple tree for a given range. This allows KVM to identify if
> the range contains private pages, shared pages, or both, and set the filt=
er
> bits accordingly.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index a361b3f672516..4570e90f8c042 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
> [ ... ]
>> @@ -244,7 +256,7 @@ static void kvm_gmem_invalidate_begin(struct inode *=
inode, pgoff_t start,
>>  	enum kvm_gfn_range_filter attr_filter;
>>  	struct gmem_file *f;
>>
>> -	attr_filter =3D kvm_gmem_get_invalidate_filter(inode);
>> +	attr_filter =3D kvm_gmem_get_invalidate_filter(inode, start, end);
>>
>>  	kvm_gmem_for_each_file(f, inode)
>>  		__kvm_gmem_invalidate_begin(f, start, end, attr_filter);
>
> [Severity: High]
> This is a pre-existing issue, but does __kvm_gmem_invalidate_begin() safe=
ly
> access the memory slots when iterating over f->bindings?
>
> In __kvm_gmem_invalidate_begin(), the code iterates over f->bindings usin=
g
> xa_for_each_range(). The retrieved slot pointers are protected by the kvm
> srcu, but the read lock doesn't appear to be held during the iteration:
>
> static void __kvm_gmem_invalidate_begin(...)
> {
> 	...
> 	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
> 		pgoff_t pgoff =3D slot->gmem.pgoff;
> 	...
>
> When a memory slot is deleted, the code calls kvm_gmem_unbind() and
> kfree(slot) after synchronize_srcu(&kvm->srcu). If the read lock isn't he=
ld,
> could a concurrent memslot deletion free the slot while it is still being
> accessed in this loop?
>

The issue here is between __kvm_gmem_unbind() and
__kvm_gmem_invalidate_begin(). Since f->bindings is protected by
filemap_invalidate_lock(), I'm dividing the analysis into two cases
where accessing slot through f->bindings with and without holding
filemap_invalidate_lock().

## Holding filemap_invalidate_lock()

If unbind happens before invalidate, we have

    filemap_invalidate_lock()
    __kvm_gmem_unbind(), would have removed slot from f->bindings.
    filemap_invalidate_unlock()

    After this, slot can be freed.

    filemap_invalidate_lock()
    __kvm_gmem_invalidate_begin(), which iterates f->bindings and doesn't
       see bound slot.
    filemap_invalidate_unlock()

## Not holding filemap_invalidate_lock()

In kvm_gmem_unbind(), __kvm_gmem_unbind() can be called without taking
the filemap_invalidate_lock() if !file. The only places where NULL is
written to slot->gmem.file is kvm_gmem_release() and __kvm_gmem_unbind()
itself.

kvm_gmem_release() is prevented from racing with kvm_gmem_unbind() since
kvm_gmem_release() holds slots_lock, so since kvm_gmem_unbind() is
called while holding slots_lock, it should either see a guest_memfd
memslot with a file or no slot at all? Perhaps I'm missing something
about get_file_active().

Would like Sean to check my understanding.

> This race might occur when __kvm_gmem_invalidate_begin() is invoked witho=
ut
> holding a file descriptor reference, such as from kvm_gmem_error_folio()
> after a memory failure. If the file descriptor is closed (refcount is 0),
> kvm_gmem_unbind() observes a dead file and skips acquiring the
> filemap_invalidate_lock. This allows concurrent xarray modifications,
> potentially leading to a use-after-free when dereferencing slot->gmem.pgo=
ff.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D16
