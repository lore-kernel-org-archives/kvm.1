Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F73033D6
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994761; cv=pass; b=NKlR1z4jEYPZ8C+IESWxy67uEYfnMrCS+Bpz5oDI+M8YRchGKtuAxNQNUDcQCkVJmwm7CXJxl9Ujn4F6cIRnYXO8Uzs/XGWv47hisaZTGl9WySk2pvUdqhnEt3VM5GF5BdPMUly0TT+QcnM7rfawbHp5EsgsxL4dMbWftoeUypE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994761; c=relaxed/simple;
	bh=YPar0ShThsM4Q1BDllzdHh7vLirwTr2RgYkhOXfVWaQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6Pl+a5ZVe/eAcMQZFPPkue/eJmshbpLgLh9vVu8BKefzpGFRGEEAlERVicK/OhwQ6OZZW8PQ7L5lpBvSylDWU3U8NtbGFpJF4Zb0/UUKE4knIcrbc+EYcc952Wz6Ocrg7/Ogua657wF+tLqmdYiQGkQ/B2vctxpsjlvIvO5Nv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBxkolYd; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBxkolYd"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90e9ad1a373so3342206d6.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 15:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788994747; cv=none;
        d=google.com; s=arc-20260327;
        b=Pr38hEsM0ogIUt1umxB0mUccEpnqlb/vhPFIwm/jUNrQotm6S0o9F+M+zi34gpt8uD
         6PdC/vc/Rcw+qQjkST5E1gCTcMOZIJHPWh0wThYqdKqvnpLpGhAqEEv3wWT6/3n4YrAq
         A2LK90Ty5JjaiN/gcYRfF+tIXrzmLFUr1YtTHEjWpYjq+MKnA1IsfedX5DCatZwvPNpF
         mRWHYae8AYy2kXsGYVmshwAmFVoCHZgaiakW/CIHV5spmighUWauXKxcM/kT4iJNg1Kp
         2eO4/bxATQ9RdbuGolCJ1yXQKd6iIGRM80zAqeTCUO/KMpHtV52Gfl6zC96gCnASfESN
         eCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Vw1OtfwMpNDQ32I6eviEJFWmodV7bi1grLL7dzsITvw=;
        fh=ADr7nJYrdOxFMY31++/XCyzQ0kjNVtflFqVLhsszdd0=;
        b=FBbmxCkYFzlphK9DStLdCWNBb6g5O5pCmeZpcgY/YQfCc+Z6ijuoEkrcjksN4tSwNA
         h25LA9QCPJaWxPqFqwg5yhDpkVPrUweAgORFTzGMO8a9bI8O/9FZ0+lz63cfJWK7FNzN
         LQEKnJr2korrtR5eJRuaLeE600qCl80hEaDsiXiyuIM83NfIicOSOdSNs4pYjige0HdN
         aHn4nR7bDN3z0Ed9yteWklO4ABJnG7QU1kPt5yjCvvkItPiNNprm0CWfPFOG2CzysOt+
         SvYfmbxHJMYHXJRdwRprkwDeaTmLXPN1bTbtHehpK6v0IRsjeWTVg+bqKReZGV5oNa8O
         c8OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788994747; x=1789599547; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vw1OtfwMpNDQ32I6eviEJFWmodV7bi1grLL7dzsITvw=;
        b=YBxkolYd5LJFyn3mordy/6VYhHmRZuxtFq0eCaSUlbBpwC+NsfuRNAlLzwR01UuzRh
         uJz5IiV9oGBIGrZe00rY4Znj35F2UOkN/qsIXj18RJYqnSid5RsXusEXyGjP4trIubDz
         Gl5ZwQPoqtgFXX4vE3+Ars4E6ztqyEa/TpjU6PSDDsmu2KkYW1aPOWu+S4luzBlEVTTJ
         JZhAUr2nt+MmzRT8lJ09YrgSmSLzS0+XoamfeO8OTdUeFbn1BY67+hbwta5xQPoWS+o8
         enz29BdweOS7aBbPlciP7b2C09omsVzXzdeMKfpP/15jJ8KBWF5pFp/w87Z686EZxWzT
         hWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788994747; x=1789599547;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vw1OtfwMpNDQ32I6eviEJFWmodV7bi1grLL7dzsITvw=;
        b=IzXkLKL+qfREm7/bjkciUrD2cwXp1oNnZtIXZBzHNQODgMQ4t4+K8V6J+atl+ZGCZ/
         3F9CIOelzb36qk6PG4kaIhG48R+0lg8wL8CwcVp9/HIW+KP5NrYLcoA/85GT7W47RVhr
         SyW95IGxHOPKTJlbnR2Q24pi6VDOi7G69OdFUk/NF2qbsb+AbY/lgaHR24tvEHBtwXbw
         c52EhR+ftepAdmJ65g6qKYXEb/mCM6LGzArgnmjKByxfM0qg0Ar35KTFntOYM3FIobLn
         cx78VuFaAiYenrv6sYEO8BrquvsCibcbQfQzz5+vC1E+lPCdflJIM+SJPm5N+JNFNqX2
         R+4g==
X-Gm-Message-State: AFuF++k0eHWekjlTJN92nmUYBzdh4NE/qRZ8LwfI8NpKhlWuvNgVX1j1
	lFSPis8EKzLXtpimwpQvMRj80l68EHvBIxcgyVJhmW3opO9XJwZJh7MReKsfKm9r+ikoxm7sdUk
	7HmtaTuuMUhSjVdw31Y2C2EZ4IoLDjlZneqfcmJkS
X-Gm-Gg: AYBFou3xxkZSk/YYL8Ha7pIDw28FFSwKLkHyeC5ppCeKEy8C+dBFzuAirUpSJoVElgE
	PP7hjnvS3+S5CD2b6zVoj7ETTFL34C9wp2noqtOxjFue9mfvmIrlv4/LD+gD4aXlsWgHWNa467U
	XgKgduIXQp/LUEvauICYZ1cPkw4Y3jqm/M81BsnuuezwHUs79za6ndDZDNhEpxwVP8+rUzd0RvI
	Vh2clHlI0TsVs1Ut0D26cOJLivqOaCkVyWNlQWJ7vzleXBDDInWMJdGwrkVC8/qGt0N4ic4yUcm
	sujj3rOS9J58WftTCBiyRAvBNqyQnt9UECcrKriflMlLryMnHFaz+XGyG1QZLwKMz7yMTBKZkRK
	XIz6MjjksQiPh7+W9dkxcRpFj+bcUY3wXj2A3vvtowA==
X-Received: by 2002:a05:6214:4992:b0:910:3923:cc73 with SMTP id
 6a1803df08f44-912029a7735mr22957386d6.28.1788994746438; Wed, 09 Sep 2026
 15:59:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 15:59:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 15:59:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <daa3875e-420d-4de5-9a1f-8c4138a1dbd8@kernel.org>
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-2-seanjc@google.com>
 <daa3875e-420d-4de5-9a1f-8c4138a1dbd8@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 15:59:05 -0700
X-Gm-Features: AcwNN1UaHhYdKckV1NwaFmURD33h2SSWZ23mfYpB8hlAgaooFjI5AU1EE7X-JOY
Message-ID: <CAEvNRgF6EsMc4iLSM_VZP-5fGGwKv1YJxf-D7Z+DVANTJhxiYw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: guest_memfd: Gracefully handle xarray errors
 when binding a memslot
To: "David Hildenbrand (Arm)" <david@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

>
> [...snip...]
>
>> -	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>> +	xar = xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>> +
>> +	r = xa_is_err(xar) ? xa_err(xar) : 0;
>
>
> r = xa_err(xar);
>
> Should be sufficient, right?
>
> mm/memremap.c:pagemap_range() uses that and just avoids the intermediate xar
> value completely.
>
> r = xa_err(xa_store_range(...);
>
>> +	if (r) {
>> +		xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
>> +		slot->gmem.file = NULL;
>> +		slot->gmem.pgoff = 0;
>> +		slot->flags &= ~KVM_MEMSLOT_GMEM_ONLY;

Was wondering if the changelog should explain why not move
xa_store_range() before setting up these 3 fields that need undoing.

IIUC the reason is that other parts of gmem code expect any slots in
bindings to have a non-NULL gmem.file?

>> +	}
>>  	filemap_invalidate_unlock(inode->i_mapping);
>
> Apart from that
>
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>

+1 on using xa_err() directly.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> --
> Cheers,
>
> David
