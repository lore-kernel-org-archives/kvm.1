Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1811393DE2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913058; cv=pass; b=Bb+3M5zGp2KCINkrRvJ7mqeAGkY/p4OCEqsJNjWmBdcTgJ7gf4HjkxPTkib78N24LV0MGzFZPJ6o3V2BBW0TXPP96dsvUVyM+qoozQC1MZoAgZXggFdU2VyCvjY/WTMeBxWB4xEqSXU/QnhWp8K1XaMJTvYB79dXNcYTE4vsF7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913058; c=relaxed/simple;
	bh=D97WCjEUn3j/vQRA7CTe83R6yLyzMyBDDHUoRbcz52Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo21YCY2TQne0DKWjHqD2gDK4/yMD6HaId5guF36h/yOk27R/Kw6sYxtJ7z31HKDGvUkRA5gYrQ1C9yPHNxltvYZrCOUITfrni0Wo2g3LssHls/LYR0nFMtJ8Ua7ZMCxkFuNVF+JQI3G6ViewEzWU/kZSUMPLf8Ut33lJbFHqMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkiV1TNY; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkiV1TNY"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-133466cf955so31988654c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779913056; cv=none;
        d=google.com; s=arc-20240605;
        b=QfTBzE3+LiRUm4E/xZxW27BvPwygdAQrp232dU74k9flREf2dzNwrsrtpR2+RhMYdK
         LocnrM2zfceyXOJUkOOlQZrZO35WJ9KYpFo+pE8Qv33kdpcFSrMM3K3R3vXoJG3Gb5FE
         dYibK3N81ejw+AKuPckcKtlS9uwktYcgXjRgYmbICRGppyTKUvivrJ5sq0wIP4x2WgLf
         msgW5skWXd8nXGwLzzCR5EUHRwzKfd+QlqcMRIAijCxpmtq5QAvNZdAmRmIG7IySwjDT
         qkOl9tvKtxIX62D2awk1EBW8q3LujmQtKcGRAJy+MsOK8nL3+ZgAG2Re/goAXxdnqC39
         DLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8vW9yiVSKiux9kpNjpgYi3apIQhlbRURD4raj5ZwDmk=;
        fh=Amm1lC+adrnb8gdO9SVQN4tGmXBVTrB3trlCnAi5EIc=;
        b=XC8pukPe5JYTLJ3E3Nk4iesOUkEh1KeGa+hK7VeqMfynYSb3ez28H2dtv2YSwBdVqX
         g6ARsDUa7rONxGybLPel4bFHxWCiI4JzwsdveCXbUH9ojmJb4Fztmrf2gTXJHpJFDup3
         W+QLclNUEoMD6osAL65zvp6hlPLo09qa/ATVdFYWcOrq8IPvgXUTF5Oo2f9CZhPL/k4s
         cCa/n+YH8f5RIEBRxy4V7ez9e+7z60n85gNP6+w/F494X4LbP8TK34vcrz+pCIk22aLy
         aTaIThvUcTKP6RKvOUvYBhFnTQ+uwD1Rlh482ectI7rChMnZJ8PfuUAxwTLGNHywfArT
         8l4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779913056; x=1780517856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vW9yiVSKiux9kpNjpgYi3apIQhlbRURD4raj5ZwDmk=;
        b=PkiV1TNYM1MVh9RVQEzCv8WgUI5p5rXqrOeiydA1hZemtd6qpdh82IC1hM3PR3kYMW
         +z7/Tv3PGVy5TgzlUeil/WstEot2jdyML0GfMn+ncInJVbCnKdOR7DCYF0zZjNlpUev5
         tD/5pTNdXF0GiQfcN5BkqLH1tUylV2X6w2EDVAOjY2S2+iwFxC+e7A5HZwXjvmV9OhT0
         Qp0rKPIFNzO7+ppgzsf7cRyMfMVIDInbrmbh76Xi5uchaST4dB61mYHxEeSs9qj5S5Fg
         vUOGORks77VINVIUoAesJFMOwi0M09AAcSgnBAdii5LEe0RQ093zG/0EwCSujH7zo7Mz
         PNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913056; x=1780517856;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vW9yiVSKiux9kpNjpgYi3apIQhlbRURD4raj5ZwDmk=;
        b=sjvE2qmNMlVrkFwPHLHyfnwXUHB9VcfUcT3CWYa/pzPINK2euwLypYEi5dTOYm+8Zd
         SOI5wqmgltw5uaFXRet4ZKR+7vPtyVa42l+LL2MDvWjf/5d6IfcEwuSZhlCOiLNyEmHE
         nqG1YW41SP0I2XMgr8rj2/3zPdIz8WI5YfHyjmXqLvRRPW7RPeYPe30Iy+gUPd5KVNcz
         pz4KZZW+sJlB7a25aSVbodjAPjKIyXOqDF96+SJoiHfvb+JVQo6nxD4ZcKNhrYCBVOqu
         6q/Fon0HouP2Xc8jqU8JGv5PgXiy3a+i8mqI7aqkG+/nPpFhbpTBRejlq9BhoDmeMvvL
         rsvw==
X-Forwarded-Encrypted: i=1; AFNElJ9r5zmjCo0nxQzQqoA15xfbW7CIKmLKhC4VwCvSz5Kq+HNM3elJ8Z1XVU0LJtRa/RI7aAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVl3bg7FICcgcaI9Z4fxNd1SXyX7HpZpo93YsX8G303H1B8ulD
	XsBsBu9opixB/qimnfxa6U7ZKwb1T2HAWF9nK+aWcuTzWTOnL+IjtzpkmMVS+MWKdWqw0MHtvse
	ml9R1XI70fL0T8NGQx5Ru7bjs135hIk74zWGn6DmJ
X-Gm-Gg: Acq92OFqzTBJSn3tONEF4ux3U9p6KBOuBo96voe1/LUQpx7aLKRHnmmmNylu35w2LIm
	RFSrMqtaaAmTzxCCnltr69263aGgMIRFZXrHsaxmCJd8tjeojTVLVhQgz4X84IfMYR8K/HvMz4o
	G8/tK2R2LKcnfnOJMow3ArU2tJO1w5OgIaDKH3CgeM6az/1CUe7L1/KybJjrc1a5JntSLU9JhyU
	2yQVrNiuksgyUSM8EuNLzJgcvV4VvZ238ALFSiCk+cDPSR60Ut3ea1iq9SZ8MxjCF4PTHyDTs59
	fSXXTHyXegknp8SLns6I05zhNiDse6mi2DdYMpKq187qnp0HDMNDS0sczx9ieHnAg7ulTbihdRH
	70gM=
X-Received: by 2002:a05:7022:f313:b0:12d:b7e5:a67b with SMTP id
 a92af1059eb24-1365f81e628mr4828248c88.14.1779913054985; Wed, 27 May 2026
 13:17:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 13:17:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 13:17:34 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahdFSxXnWhhsjhKe@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-2-3f196bfad5a1@google.com>
 <ahXB_tBWakUUjt6q@google.com> <CAEvNRgEN6syKVLjvFX-s=xU=r3CBZ3KtmeKvVYOC09uvFGXSFg@mail.gmail.com>
 <ahdFSxXnWhhsjhKe@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 13:17:34 -0700
X-Gm-Features: AVHnY4LTkCqwZJgAdbJtHYJu60g77wWFGV10HPdHsIfRUwfgRQ4VgItFe8O8W08
Message-ID: <CAEvNRgEW8nph=Hz-3pcQD7ZxRuAOcjcOfj8afgJMsRgESD-Wbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: guest_memfd: Fix possible signed integer overflow
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> >> [Use size_t for size instead of u64]
>> >
>> > Why?  Oh, right, because kvm_memory_slot.npages is an "unsigned long".  The
>> > discrepancy between a u64 for the offset and a size_t for the size is confusing,
>> > as they are both conceptually in the same "domain".
>> >
>> > Rather than u64 and size_t, we should use pgoff_t, which is what KVM already uses
>> > as the storage for kvm_memory_slot.gmem.pgoff.
>> >
>>
>> I picked size_t more because I thought it was semantically correct to
>> use the size type for a size. size_t may have different sizes (64 vs
>> 32), but in the comparison offset + size > i_size_read(inode), size is
>> promoted to 64 bits, and signed inode size is cast to unsigned for
>> comparison, so I think that works.
>>
>> pgoff_t is also unsigned, but I think that should be reserved for page
>> offsets/indices?
>
> Just to avoid confusion over the definition of an offset/idnex:
>
>   * The type of an index into the pagecache.
>
> I.e. it's not the 12-bit offset into a 4KiB page.  Which I'm pretty sure you were
> saying as well, just want to ensure we're on the same page.
>

Wait yes I meant index as in the key if you think of the xarray of the
page cache as a key-value store.

> I like pgoff_t more than size_t because, for KVM, it's really all about addressing
> memory, thanks to the offset into guest_memfd being associated 1:1 with a GPA.

The offset into guest_memfd is associated 1:1 with a GPA, and this
offset is

    offset = index << PAGE_SHIFT

> It's not perfect, because GPAs are tracked as 64-bit values, whereas the kernel
> restricts itself to "unsigned long".  But that's a non-issue in practice since
> guest_memfd is 64-bit only.
>
> But conceptually, I like tracking the gmem offset as a pgoff_t to tie it back
> to using GPAs to offset/index into gmem.  And for all intents and purposes, gmem
> is nothing more than a glorified pagecache :-)

So we actually want to use u64s for gmem offsets (where offset = index
<< PAGE_SHIFT), and pgoff_t for indices, since indices (aka page
offsets) are semantically the offset, counted in units of pages?

I pulled this conclusion together from filemap-related code like
filemap_add_folio() takes a pgoff_t index, so I thought gmem should
follow that and stick with pgoff_t for index/indices.
