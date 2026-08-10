Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEF3DD51C
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368039; cv=none; b=G709kT0RT15FWtE+iXGpkfaMd5caAJ+ZqN1lk02ZUl5OeV7YiiasV0LLpDpHMUbV1seZbPPlbhPavEDtQSK5ZfjfQmb0baWNxctemWJZkQm6McDC54JrWp9BeTmryz7XAGFWNk9hHIs/1E2vwaPBa1RcPsZh3P4cRxjiAwOmPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368039; c=relaxed/simple;
	bh=C02jowBpg6icZy7M67rcd8sfmgZFev9qbAUxwJbAP88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APIf1r20fd3ZWtriiZYm467Irb7JGv3CFKrRfNoISmL31onnMUhkMt4O+kBAdo5eWx/IhL486qZfSb75VUtzxlpS/UBS8vnrQPC8CfPA8ZPo76iCyJoyI9Cj/IXbBZxoGkhe7zXxs+CombQ8ntM8hhwwqdXShVM5HWtAgagqO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfOKlsYm; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfOKlsYm"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15c32294e1so167834166b.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786368036; x=1786972836; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoXL2lcVuXDTzwRL1s4LiTCXpMnjYT/r+wP/urETSuU=;
        b=HfOKlsYm83vSaL/w75YVQaUCcjUT7asAf4J+kiJjAmUd+9nc5kNC+Eu/SDODK8E8Op
         Xp1ODgTITjADjskkaPl6UOpJNouTdTaJxVKYoegHaIK4NHke1y/Qe5pEtstir1RmhhzN
         CdX19QhdDlow4z3LaEtD/26fXHlGdMVtO4nhNejkupESYBYLdoTkF+k2rJN9jn0AeQyW
         9PWdKCETpXQ4SJCUEN3oFPnKn1rSJJGF7Yx4FJM4i7TWmOdhb++8X+bBOUYXPiRUFD2i
         OdA9AHNLK7ATg9yZyOFc9RpA/R58H8jNR6DYSgCp8bEMtO7MAd02Ph1epitcPP0X8JGm
         sogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368036; x=1786972836;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoXL2lcVuXDTzwRL1s4LiTCXpMnjYT/r+wP/urETSuU=;
        b=Evi/u9HWIW2F9kJZBBmCVkoJn9K98ar5M1Q5/vpiBulU0xgU4U2QwOr9F3POsYEzI5
         Kt4NPX2l3wPxApCFlRJlYrGMrHzZEDlQe2l3pMX3PkjV2U7QIYlBWg9e/KccDbZ5BZrF
         MIaGKXtvDMvhU4bANh6t2RtHhqIBfRZEOx05i1+/mMsOnaOi3xFqbXbzdmsYoQaVkpT3
         cQlCOYAYr0jstTbctwTvHDb+jR+MziEfF37gqK35OzJxWBChf+oOUDbaCDiRils/1Hae
         Yi6N9ZX27ZJ2+qq7my5I9LywXveL7KqNsyArEm/YtGZNBSDSQRelYRDplf9OBgNsjAJv
         oCmw==
X-Forwarded-Encrypted: i=1; AHgh+Rp12wNVafkQK5v4IPozJRLaUKHAqm2wA7eLIVU2gaTWG16UBz0QMEPzanTYc5wvn99hrMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnVbeXu1qAdWezRF7kwoNRbhLrHUQ4HVQ8G3djhXHZiOD3i13
	JdnLNgfbuj7SpGkX2WqDUrxf+nKQcAC6U6/QJRdXbuB4YnedCte6qCfdE0BiXU/vN0dBwKtOLA5
	USCQVeMZH0NrGCmiK4A==
X-Received: from ejczw12-n2.prod.google.com ([2002:a17:907:e00c:20b0:c19:71f5:ee20])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:ea8b:b0:c16:126b:98b4 with SMTP id a640c23a62f3a-c2039c03283mr2125010166b.3.1786368035983;
 Mon, 10 Aug 2026 06:20:35 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:20:34 +0000
In-Reply-To: <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-9-tarunsahu@google.com> <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Message-ID: <9huz1pc6863h.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 08/11] KVM: guest_memfd: Add support for preservation
 via LUO
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>>
>> [...snip...]
>>
>> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	struct gmem_file *gmem_file;
>> +	struct kvm *kvm;
>> +
>> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
>> +		return false;
>> +
>> +	gmem_file = file->private_data;
>> +	if (!gmem_file)
>> +		return false;
>> +
>> +	/*
>> +	 * Only Fully-shared guest_memfd preservation is supported
>> +	 */
>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>> +		return false;
>> +
>
> The above check can probably be removed. I think the core thing about
> this series is "we can preserve any memory that doesn't have any
> encryption state that goes along with it", and so the check for
> kvm_arch_has_private_mem() below would be sufficient to gate that.


Sounds Good. Will remove it in next version. I will rephrase the
Line: "Support only fully shared guest_memfd" => "Support only
guest_memfd that does not support private pages and also can not be
converted to private"

>
>> +	/*
>> +	 * It makes sure that no memory can be converted to private
>> +	 * even if it was initially fully shared (in-place conversions are
>> +	 * prevented).
>> +	 */
>> +	kvm = gmem_file->kvm;
>> +	if (kvm_arch_has_private_mem(kvm))
>> +		return false;
>> +
>
> For now, has_private_mem == has some encryption state that we can't
> preserve yet.
>
> This also gates off KVM_X86_SW_PROTECTED_VM, but I guess that is
> intended, since when work is done for preserving encryption state, we
> can then test using KVM_X86_SW_PROTECTED_VM, and only then, remove this
> check?

Yes, It will be enabled when private memory preservation will be supported.

>
>> +	if (mapping_large_folio_support(inode->i_mapping))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>
>> [...snip...]
>>
