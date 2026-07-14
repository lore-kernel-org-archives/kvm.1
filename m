Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74F27587D
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784073159; cv=pass; b=lgEQRPfNGUM0O5owtGdidV1cSt5CTlZkVppfQIlggkmtZIykWv2YjMFp4UUStUh8+hNOfDZWcgrTm95CzKiJH8OQKwAcboWjA9LMwGMmkBI6BYJDQxg+lCekjj9wozDWqWp6MVQLwT1zLwWfFAV8PqSHPXZJv9vYkmEkfbD/iA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784073159; c=relaxed/simple;
	bh=S8H1DPY/zrF0s8Hx4z9acw7QIO8LeTlOZIOEAQgt9Mo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pck+j4719G8Kx1I/cxPKQ+J3NBbDLxYqVAguN5wBAA/6Oge+2jRmYmQiXSU3j5H15r9Gr8WZsUr8RJDGdt2+MotAcLAKYHMVFJSYhF6xe5lP/+7d3KJkxrngSJGI7qgtpScvU7qq+jVSRSfZ92l0uhFjYcMZcxWcqmEKlaOCE/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z31TdyC5; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z31TdyC5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2688996a12.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784073158; cv=none;
        d=google.com; s=arc-20260327;
        b=CtmEPbDvWMblwtJsb3ycjaM30mxV9LANAkpwZAU1q9ON4J5def2znYS7ZwsJeUE4n4
         VmsYGyE2yFK7XytZ7lw03QGTfQDQs3fuMhaYK3ZyQwYS7iYGjqckC0A7PFjONBT3csZs
         63t9Yqoyvg7LgV+fseiIq8MrPqZIcW/5MBFteWkAyZLk3nwsPCh43ZHXXGN/GXcnzbrH
         BQX5TPRz3/q8AwjnOjEY7NhmTBgnV16mQfn9Y4lKyb8tib+Td2dpmF1xZ9B0rrPCsn9c
         SKrN6fwpHhCnd0rf7M916R9y5IV7QodX5ltvnzhrul/QQRXn/S42ha26xCikUEbHkpbG
         O/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=zy4CFxQS08BLYRIKZON8wjktzAN/UiX6c2pgmKL+X/o=;
        fh=ejauVw2v2JC22nsitInIhki0uBsyhmGPpwY68+5cDUk=;
        b=VAcIYTnReFLaBQHFuiJuPvkDQNdteGL09nkBnhz1lI1bo4XvKljRrRzTlEt7q8iaVu
         DXUTn/ZwJkB8s3AtrtfX94EealKPCNn1eJvq/h/7gI9CGgCxJKbiW1TgH/1d7/qa/5YU
         7ksxZUg/HcHdnK6HkzotjUMjdpqpevA7RbRBmyYx/VoliSV7Tu7qIOb5NPtVKHqQn8JX
         VI1Aco9Ltxk82yrRi9eL5hhv7uiFE6TUwuCc3/BrcSxFdsf1zKoh3MQbzpz8yiTFAJp4
         NQO0uftRCqGfeS97MADp1Klmn+l202vCkzDZcBfHfreGoDd+AshAuGj+EEwN4acWNoAc
         0XUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784073158; x=1784677958; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zy4CFxQS08BLYRIKZON8wjktzAN/UiX6c2pgmKL+X/o=;
        b=Z31TdyC53Hchy7B++UrxSuoY8JT26CrigyOgZvWVEOJaDxhMhrlcOpQRYdLQa+0Vex
         KcsPIjD3IwiUu7dDi/kUicU1ZUygjwpLYJkqFynsgsC/qG+uthGLOk3/dx9szZR1RZHC
         zdGAtCeubQwC/L/bYp2XkF+dApIXQ4ZyIixk2zOp7f3Xq+iQz6/aRrDMtTnpI8hd7yNO
         PyUd6Z1qNO7p/OSEMzQO4Oe1TdYtW/S1OCpbt9hpmdUJmcrGmHRR+FgghL5Ow7tbskq6
         BfwbEWgVC0kVVoGvJ+raicwrU3mdXSXZZ6tJmIfmHY5E2l7RN9GcVriqvno5sA7nKbxL
         RTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784073158; x=1784677958;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zy4CFxQS08BLYRIKZON8wjktzAN/UiX6c2pgmKL+X/o=;
        b=UPElGXNeyu+oNgv0jDgVoDh8KGgA+yYMl6scxHjAhHxL01as1VpaA9e1HnoLknUGK/
         n2eEsQak0aR7MHPBy2sebLSz9RGjaTlmnVwRDMXdYRu0LY0McKMyFQjK0nWSqyBa+9m7
         z5AUru0PnPLldVZvYGBr9aSiFScnQ0HC1vYiyT98hzjb1OL4uzsobH4zBlNixDtJnptZ
         wivoMB1kwuQx7p/t/voU1gU/RGumLsGvatS4zg8hdS8tM66pTssrvcTVPRycIZZrCje0
         zk1RDIPsl0DMNewkbDFKroN0VpKQw05Y1mFijmvgAqwebJzjpP9y9RDUVURJ/QDjIQqi
         SKOA==
X-Gm-Message-State: AOJu0Yz4hUTdwC/rO06ai9BAjZeW5bcwNCH0ruRA6F0K9kefD8UIcvMb
	XwxIN43HMTnrIsMTO32OJNleUVjqZkV1XWnF7Fmti8i3gUTvYLcdydHFePVi46Z0yynBWk936qi
	VavQfYanGiRgMwPAbHAgE12snsklQLzTYO+W26u1u
X-Gm-Gg: AfdE7cmclsAZg9XzFeiXv8Put1sFzF1iqu3CS8UjfOg+zlOrpRHIG896YwxIN0phD3v
	0cE2MV0LHmB0fYB9994OflWfhWDm47th7CSTglLphUvWxDdBJTIDoeC01LeglYWFSkq0cTmrzXX
	Y5Vrnxjif4oZ2+tRBGbEucoILtpFiAZ2ECEv68PUZHDpPGxLkmwhE8EZh4xm8ysFaNx7g1KDerU
	ULXSdIChl9e9FgR08mGSF6xTOlSmM7EpxC5Xjnfliykt1XhcOaV9Mm9+8+lXIbtc7SvTyPigBuE
	lweM4AWN5zoAeO2Iu0tEze/Sg4hAvsi6ZIgWUt4zxK2TdIy7WeK3ALhUYXk=
X-Received: by 2002:a05:6a21:7105:b0:3bf:9cbd:9a36 with SMTP id
 adf61e73a8af0-3c36c16aca1mr681440637.26.1784073157451; Tue, 14 Jul 2026
 16:52:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:52:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Jul 2026 16:52:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260714231015.3337831-2-seanjc@google.com>
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Jul 2026 16:52:36 -0700
X-Gm-Features: AUfX_mzFD_wob5N5abjRPCuW6hWhQWQNPWCMTp9Osq7TjAlHSEtX6GgWG_mZSEM
Message-ID: <CAEvNRgEB+cwMRiT6B_0oNXGp-A-qPyf0qA8Rtrv5b5xS=jqXtw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] KVM: guest_memfd: Plumb the number of pages and
 max order into .invalidate()
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>  static void kvm_gmem_free_folio(struct folio *folio)
>  {
> -	struct page *page = folio_page(folio, 0);
> -	kvm_pfn_t pfn = page_to_pfn(page);
> -	int order = folio_order(folio);
> -
> -	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
> +	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio),

How about just folio_pfn(folio)? Since we're freeing the folio this will
always be 0.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +				 folio_order(folio));
>  }
>  #endif
>
