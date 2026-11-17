Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883270;
	b=VzvW4fuLIrEj1Ah8BKekBozgU9PPOeTd1qd0ujRNgN6zCQpHRHVJHGPQ/DJfbeGygDpX
	 QU15zXHoKqtDrUCIgzUmkXsx3vcOxQZchDaY4jVAAgwbrcEFUie8LBNyvt6w9sCseRh+B
	 IwVdM+JqA1JTBwL6rAniUY/Q7vEaBqHT2GfZJC4zdgkAVP0PYLRYAjpwCZDeQIjL4nt4y
	 BGJff+pmT1+drItagDGGzFl20cQpDOsjBzWbx2CEDDAEhtxv8cOMrwWoFRct3xrehSCtd
	 vpaAuoSjPAVuVoLL+jXj2KVeTujWQg1KnKM55NSgnClJ+4gOlxBaRxx0g4ODcunAjEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
	b=W8gKCrhLNbDkNZ1TPhlAeHTjXb69okuIwd3do8ItL2++Zqqy5BlizN39ZIpRccRkqXP4
	 VI7szAnlU8EokN+hXYbQ3MoiNu/nvRUSll2uv3AmN5Mn+6+LNObjSd/VZsMVtBwnRJ5pZ
	 Tc/5J/DM/2pg1uMwAP7/VoUJTAamTFxXYS9aDmF0iFkpimE7RDtxKtihEefVxbcBmT39A
	 raA9hFSDlUppNzNoBaGPqV6F/h8TzlMrUUJUFedlvcdOqeAXIypImUrOYYYvoOZqaDPkH
	 IuCBeFMQs9bOnXf3ZJHECCjg3tAIzPu51FTsjM+kJz0JC+bOnhI206WsrgfmjXnWtMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bK+mM2hz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E5606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 02:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3E5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bK+mM2hz
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53634b8328eso42703091cf.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 18:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883268; cv=none;
        d=google.com; s=arc-20260327;
        b=AkKSzfDdJ1S70rK4FL0OUjlPuiRa8tD8N5LPmj6R37IMu/0o4+ryOxMDBfJOF2MfT+
         7zia/rcBI6LI5JezCzqREB6u+bGjy+rGBfMuwBtfY8W43umIHcxeRKxE4xzsIvncqnrH
         awMNBDNXjXDpjyvMfYz3PgzGHoXKCvwj/cN4kEqKBwIR2K8b0Xu8/cGAytQV4Ayv1l1B
         oKuce2Yeq62oBMLdl9JA0h3rklu7RNVMAwoJj5mYhC/AieQfci0clcx6nRl1h45LdjVa
         nN2a+7M+90tBegLRyUFFW+iwOjyVS7ImGEOufZMP8Cde4UANSRfy4HxeY7+Dq/3dRLv3
         1UrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        fh=FBp/GeSkksd4Rh18gk81thmBVYpjk254L7kiolu5tNg=;
        b=cN7m2N1L5FjS3YTaGzuiw3Ew2biOtMa/8O295V5TeVRTsu/inqd43lQaXPYgRPq1Pu
         QUtEBPvjU+ormLvQWlJqF7lkGyepoYQz3zADb8TgPbHypcNp/Mnd+7TKqXQmN6AUhjK4
         aVXwFJRihIY+Z04CqzE0tPfL+NEj4/ZLW05Bd98N3bn5lUgBUTQmjhVBBEBQw1e/+G/v
         cVLoLxu826sykOSRDewzpC7H7Hg2PIs26nAf7MuwkbjMRFY/Uqr+mDou72MIumcZmjwe
         bBZg1yB56RRgfjQ4oREdkmQYrSWCaIL60lzYY7txvg56OtGjpyMNOV2+jH/ztvWfxgb/
         myZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794883268; x=1795488068; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        b=bK+mM2hzhL6PojsFAyjZ+/eGWqpn/8XMwiX1TU71mf3U5ZH0W5J3evhcxVHf3RrJoN
         gZl7Zzml0rB2J/0XAjMI3L+03DZWIF1bE7PPrVD16H8Tz5ItO4OlAOtzCaIxBKJ1fBas
         Djdb5G2PP/+dk7IlJTKvJCvgsFUxQd8yvB38p0mA3g8yKOwrZnXxR5xtI0R8PytvuJvu
         FJI92kaoiAemxXiJncgByNZ7rKfOLZQqM4XWr0HjzZISX+aE9BUVJvDEyi23Kh9iizs3
         Q24rbJEjpzmBIhoG8q1XzZs8c1ZvqRUJclGmSBnQO65jBwwIwAmvFz0XneOFFYfN+e06
         sgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883268; x=1795488068;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HvQs1sv0nGP1vZDuQ/BDK5aYspXa/hu3w+cobCl25Dg=;
        b=o3Z8lyPOCwBXP6wODqeUqawv2y3mJ0Yz3uW1ilO1jF2HQ+Jmw1Xojn+QvpzBzPA9cb
         1zPlb0ES7V0r8/Kyn2I+Re06jRJAtLCkqUeDvUtC2FvY2SuRRP2rBsDuKbplp1J5XEf0
         w/O/ZczgvYz9ZQ9Tej7IYBg5frIOZH20h8TPfSR34JIPk9pxfsl2dpyXzsgkkwZDiB9i
         VJbNWlvOjLvUkIPQmmWkOkNStqnrrjLGmKMlNmT1OR+ti2H0AD+ydP7W+cd6Ran5aWI3
         Mos5joD4TJmzQ+0ILi5lqE5HwmMZPq5RLVI2gbBWb0xYjIykoqQXbpUoiVwRLTiaPo24
         j0Jg==
X-Gm-Message-State: APuU4Z8PVor1SUTNdoY88pw8ckyFjJWl2y/UzLsvv7bOxMhbm1/bBihW
	bVRLPjjcYCQqpq+DdrSkSuJ5+zVLxwa5vwj98AI67XPqChghkAfswCmSDgis/bCAi2+9migopH6
	pYrFLTlqPZF2EtCju6Y8plsA/yKdXIZXmUr2y5jvEcJ68jcv0IQkc3sGh
X-Gm-Gg: AYBFou3dN+6Iw0iuBMKH4ze6YbssHAf6X0JoYSlkXb8OBVp194q4DxvFujMu2lVUE+L
	tufVE5k4HRoju1G+/JPJlL/ZmhurvhDa1X7Wu3yQ7JFoce/9ZYbUpL2TnMlHC5AttbxnMzKAk8o
	o3kNhHymil2rQine1VXcACBHipyKt9lEXFtV5dvyv3fx/Zwe1a1CsguqDuvq4zTn1cCRNrnQ5eE
	z136mdMV/+D/AUJzNsoa2yg7PQLA1Rhpanv6tYfmRGvsQgPK8l5Ro3S72hLrtMVQgq4ALsBUD1D
	fe2UcgTfNqpvHCkPlOKzwd0euIXL+SJdzd30T8+k/V2B2L6oXlrsmxzkNXrJB+tWqRVx/GbruLM
	Y56TZVXyRarmZZ4uMexXsUl1QMzfXHiKDFw8/7/Xx9C0mW05Ol2MXGEUtt3zhL5eQI57FnmK7bW
	sfdIU/sazlUAU=
X-Received: by 2002:a05:622a:258e:b0:536:64fd:7b5c with SMTP id
 d75a77b69052e-55ac857d00dmr229653051cf.58.1794883267864; Mon, 16 Nov 2026
 18:41:07 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Nov 2026 18:41:06 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261117011513.39419-2-seanjc@google.com>
References: <20261117011513.39419-1-seanjc@google.com> <20261117011513.39419-2-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 18:41:06 -0800
X-Gm-Features: Aa3M54pz4hKgLgbckwPhwESAbXAcBthYlRHInnCY8jzXIe6R4fuYU-9UgF1wqkE
Message-ID: <CAEvNRgGH3NABq6gioOQ3d1mLKi4dz8srjOy9LYvUSaqXVzJsAw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] KVM: Disallow prefetching PFNs (for SPTEs) via
 VMAs for gmem-only memslots
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Disallow prefetching SPTEs via fast GUP, i.e. by VMA lookup, for gmem-only
> memslots as the whole point of gmem-only memslots is that KVM MMUs should
> get PFNs *only* via the direct guest_memfd interface.  More importantly,
> this will allow skipping/ignoring/eliding mmu_notifier invalidations for
> gmem-only memslots, since it will be impossible for KVM MMUs to have any
> mappings based on the to-be-invalidated VMA (as is intended).
>
> Fixes: 576d035e2aef ("KVM: guest_memfd: Track guest_memfd mmap support in memslot")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/all/avdAIMDfgL_wy1rx@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..9938b753948c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
>  	unsigned long addr;
>  	gfn_t entry = 0;
>
> +	if (kvm_memslot_is_gmem_only(slot))
> +		return -EINVAL;
> +
>  	addr = gfn_to_hva_many(slot, gfn, &entry);
>  	if (kvm_is_error_hva(addr))
>  		return -1;
> --
> 2.56.1.703.gf848ed807c-goog

FWIW, I also looked into kvm_read_guest*() after being pointed there by
AI. Those take a HVA, but don't take any kind of long term pin or have
any reliance on MMU notifiers, so those don't need extra guards.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
