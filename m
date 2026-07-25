Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33393332614
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992978; cv=pass; b=ARq0PxWED8hURGCBZPLVCLa4VBkDk+2OdvHEZ6I7FkMJPqJFRlgY/9k1AoXcwGuk/N9FwpYo40GHD7MBfkqn1mK6fmUAEDIqA7Ok/KxVCrWvnkzDGtHN/zhE67krIpf+tTRMg+q8+d28YkpcVlZpFYEXS9VQY8yfxBJNmjnWqR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992978; c=relaxed/simple;
	bh=JWeVwMOG8M0zwiyaT2ZInNolBAOlLdI7D1tLoYJjneE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1lZpA8KbuF3ICWMeO5g3655hzkFthopsV+4GzZKmJkvqNKXJE56ch8wRXrcVElimr8tM9FcfUuvx/zGMP37kmltX9J92g+YC7XNIsKu14yHwptyBj7x45nskwi1VMAW6xxtLFJth/eqp1QL+8/QkhWOv4m+jEyTXKnzOrIZSYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OahCXYv+; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OahCXYv+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso202475066b.3
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 08:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784992973; cv=none;
        d=google.com; s=arc-20260327;
        b=J2WlO+nkYUZZVUftxpGwaICseTp1R1mm6VWaw2goLX2dfpXfzWnPdChyDwJJriB7Jl
         p5VXYDYlasVV4Du43mVuDdTOGw60HSZbq//MwUTagr2L6rRoG6HoKksYzjkk1AV6bJ1x
         QDSq2kLIO69qJWS7UTxHRl+tu4eGwYhkEJCDtxXkx2nI78YKdhsrlmCIKrNwne09/EjW
         GpyVcdJ2WJIMXlpuUhNnPz8ofHYodgqOpyRvHJfLcfYp3NwZdntA6q+GB8+pJOQBo4BR
         O6pQVw1kOgFt0GA5OZ2lSRlWPdk+j0+wbUn2968POOvHFgx1CEZ0YB9hhHAbWwYhZa8x
         mvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ipg4U2Kh2ePIAiGISqJOA937XorVbA8vK+rpGRsn190=;
        fh=rwrYbFwf24hPID3nkl5yfZOxQTZWd//7Gp7H1M5VNFc=;
        b=WGqXya9vQlRgX0wPIqfmaDphJVHgXPlJk2B29pa3hZQLD5NqNOPW3Rik30evTLs0M0
         M/Bk9Jj5npxSscwY5NAn+nGa66kWMwWvDC17OGckAGmFl8sc/FTCYJA4ST4Jyfq+mWcc
         asO4bUkWrohClWM7dEAvA7ysTH+Fi1U2BEHyE8Z85JDB31uLVFgycLqIcAvKehcJ1ZMZ
         J8xaZJBajXYEx0hYci7l+6TRZxvkanq2muFpiYTq8/i+x54UddBi58+npXLgBGIX5kMA
         nKlKk4fehLY3Ia0NKtiyJwRTO42C+VN85BASDpdR4XmyejLSn9mQA4BJDK8/TTrNlUbU
         Ejzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784992973; x=1785597773; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ipg4U2Kh2ePIAiGISqJOA937XorVbA8vK+rpGRsn190=;
        b=OahCXYv+P1kVmbO6wvimUcpqxkW23lr9Tpl+TQhEYKCttka8FBjdI2aVGbqo2n5/OX
         UtniCu7HTBIVfqU90DYoAt1U5C2hYo3/4Kml6SfvnK65tjxEtV5aSIpMbolztOjIT6pv
         /AawjsxDumahdzXF8nw9cCWZDaPaslfgG7GwD4/ICmVCqe/nDc+yD1tsJS2NhXKdNk/l
         j++f0G70cOsYp6lwpI6VYzdrVNSW7aPsPftgTBySPQVfloD1is8sHC+jia3+nQrBEAHy
         YkxxvdfVL7Q6YpPLH/nPA5IoM8QpL28HZFRu08qVMZx+MLQ0dJZwyMzY0z8HjUbVFcDc
         S8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992973; x=1785597773;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ipg4U2Kh2ePIAiGISqJOA937XorVbA8vK+rpGRsn190=;
        b=nRAHEEar0CAstvcdovOSxiVedZ8eunCQTSi9Hvx95LbRdoj+/dFgOVU6irSle+QLOI
         lytjB2MAliSrUCiaB41djXPWzVhotSczojTFXy3TY3kI1EMJiaUxE7cI683CXH1TGeSo
         Mf74hpNwNCFyJHhRlANhR82dB1YcfCTqEopIm5pmPliEKFxqGc0rGn0h669UXpYj8cml
         /Nk2hncyVzjvDiNidIcsgUrSE67NO2P1xaXSWQkTMna7qfjsyw1yOQA1gbqDTyV2oXT2
         UZAW8+iyLQbs0tD7QxL5BoO5FIyB1fa9/l2rizQnrHSRXjc0iooDx9pxagMmxl8C3MGf
         TCmg==
X-Gm-Message-State: AOJu0YwaJRIRG5Cx4tXz2Q310kkEhQ3BZSEDtRGQHxVfa5CfW8UwguIR
	lksKmSbrGgvtpIwhbJLvSTxbNvohXWaldENdclA1W9daAmeB2bqNixm/+NYBV2eUOSnb7vhfsG5
	zwSeFFUl6ZDI+7AXVW9ZggK63jFbeWhpTRAe+40Po
X-Gm-Gg: AR+sD13wDghQNHdP2M+63WL76xQrSWYXq9ovgEniJ7nONQsqL4SkaqHLjfMMXCoBDDa
	ZQSRAIkmBjYTZvkYKE0hgfIq3H4bVtJh+lxJt40XWl3MsioM3XUS9ynynijcCmgM+6iZ+OAoxxe
	pk9q3IqiX1ctAeT+OnF3goT5X5JCUEDROgDFbmkAVxSbiTPFL6SZqlgT7H38RLsFyohYwW74bxV
	hdyu6xEeNDRvTdlTjZ17fqO+Td6IvaAo8Z8mE8MWksjJo2NoX7ArTQTq/lJdvjFwSP9hrjvsmp/
	X+7q6412IqPgeOeshg==
X-Received: by 2002:a17:906:6a0c:b0:c15:f0b8:eb91 with SMTP id
 a640c23a62f3a-c1f1ea072bfmr93962366b.7.1784992971987; Sat, 25 Jul 2026
 08:22:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:22:49 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jul 2026 08:22:49 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260723210811.72720-10-seanjc@google.com>
References: <20260723210811.72720-1-seanjc@google.com> <20260723210811.72720-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 25 Jul 2026 08:22:49 -0700
X-Gm-Features: AUfX_mx4T6qcUv6ljRAUcvFk6mi-WbUUOJNbTM4kjJ_pz_6HWEV5Vwp5DLTIL90
Message-ID: <CAEvNRgGAjW2-=K1PFH=hHbtFdr_5Jc+vf6O-rRTDjC=cK0q6PQ@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] KVM: guest_memfd: Make private exactly what can be
 mapped on page fault
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> @@ -799,7 +755,9 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  {
>  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
>  	struct folio *folio;
> -	int r = 0;
> +	int r = 0, __order;
> +
> +	max_order = max_order ?: &__order;
>
>  	CLASS(gmem_get_file, file)(slot);
>  	if (!file)
> @@ -814,8 +772,11 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		folio_mark_uptodate(folio);
>  	}
>
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>  	if (kvm_gmem_is_private_mem(file_inode(file), index))
> -		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
> +					       (kvm_pfn_t)1 << *max_order);

This is correct after __kvm_gmem_get_pfn() is called and errors are
checked for, pfn and max_order must be valid. and max_order is always
non-NULL after the statement with __order above.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +#endif
>
>  	folio_unlock(folio);
>
> --
> 2.55.0.229.g6434b31f56-goog
