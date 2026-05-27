Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C173BE15F
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917299; cv=pass; b=ARW+3kJ4YJlMn84SH1/b6Lh7jitrwRkafFucRPQ95XJ8N1+U2K8AsIjFIwX2IpNb2mF+X0ICMN9piJZKPISfWwR1lb04dDjB4P6ZBPNZU1NoV3daiKrC1gF7WVh8WF6UESpBjJhEzZKjNMiJ2nBJVERbHubcCoQrfCpkR5sJhws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917299; c=relaxed/simple;
	bh=a0SzG0MQbS2sQaqX/jQVnOmluG6OP++OsMAFA5gVs9c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWoWBHuRDpIIcM5OA9e+MpjAok1ZqHSiiUU8zawvfiPJnYLLt/62TD264izVi+igNJxAnXIp1V6A26xTB33Z1KALAB9LDqlulRO0hjfHObGP5iz3NYQ6zioXE5LT5RdCnz/BCjpGWFaA8zHS8HhDrgJDw2Y0hrixYPN+zP68ycY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s47Q3epN; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s47Q3epN"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30246cfd41aso2478849eec.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 14:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917297; cv=none;
        d=google.com; s=arc-20240605;
        b=TKh+6TsLx50Q0EkPdaD+98qI+HmiOq20pJ/D2NmR2DrI3utY3fWAj08DxEJO5zcCHk
         Zp8pVDWZhSU9XPKqrFIYSD1RapfF7uKX6qH2JmZV7e2H+Da3+L+bSUhsUty8d6yuJzZo
         6S3KLIPhyMvVbe6uRk9Yekt97tB30e85xSoSEh44nIwFlLe7vFA4n9Kh+DKS75lpKToc
         z9gCEGL2K0yDPA8vpS9vvLzRuHLt31TdS0iFO0ht2PboPcrFzUApe+8TqmBwaPhpd29n
         QyiqDHFFMljIZ25VanehcGG9TWabJ+dHy0FYITzNWSzCLaTeRYzUGii749ojQPgOHENA
         eUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=zdx5eXL6qL7cVTt6BBf4BlAi4V8PYwGAQ+sz/s4x+AQ=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=iz/3ZlWsaYmJhBpYJp3NOz1X4Auen1I7dLD5rnWbHleP3qNIbZ5SBJy102EfXSDXVS
         F9sgUFis3w9qshxaImvgE0+FQ+lc7EPlQq0XQdb3YK4EUOxhnN6GDyudVQ1eIWzT0Q0m
         RjS8k3o2U/90C640jGZwnG2vos+xdIBl4LRRoMA1i8aObagfwxsF1OgbIHIRn+c8L6EL
         Va27Gnm5XElmoxDXH6F7RraV49cUqHeXedvWQMIll0OLRI3DkmD84ojxQlm9gCRAF7DC
         XAr19TnrZHevYvaEcGJkMvWjJDlul3toUuPtoWrzsoKdFUs26nJL/5yYYfwVrbg9HT82
         vV5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779917297; x=1780522097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdx5eXL6qL7cVTt6BBf4BlAi4V8PYwGAQ+sz/s4x+AQ=;
        b=s47Q3epNLD48moVg2bw7qKZSeBkl2yVriK6j/hBF9uyE02pBfDQYVi3o4HFlGq+nGT
         3Cm+fQVlcrfP3SN2cfNX9yUzTTeCe2NWHluWc/lRx1DF7j2uXGimkLb5h/OpuyiHcfe9
         20Zm4eiPqinu4NUPAUbRbESajNbG13Lk9cwbIxs/lvTDAw+PrWEwaAwvXJpvVAOm22iZ
         oe1YdIFKlcwtB4QBH8ppX9q21PSdgsvmc47SSZ2Na8Oko+kMkXJyb800L30WuM9CcTdI
         vcxJEnMKbHB2gR56e7W0oFLa2pFq8+du9xIdfFvcY1SfAZ0/YtNhE9QJNiUnbATEN3mX
         mRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917297; x=1780522097;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdx5eXL6qL7cVTt6BBf4BlAi4V8PYwGAQ+sz/s4x+AQ=;
        b=eVSjpqv3uEnIRX5h0vW9f8+w9xeNZVbR94fxuioHRnpf/2diOjqNjKUZpyGQJKsWBO
         fjB/BMMm4YgcslzE6ZJDM3CynvyfVJCrubkfLm+JWCPeXkBS8MhejaFwgv/5wJsq2Tvu
         4D4+CZ94zLSPjnSLmpz2HO+nIwBj8qREtCqxi5xcgd4Q6SUXmS2NKbyexYYBjSLQbYuj
         Kem4LtRiPIx8meGwcO0PbwmViM+4pUM2h8PH3Wksal0U1vMDkWNeYcex9eo6lTloQN4u
         4h2F3i7MTu89FaVUKb6dv7PPkgPE0v+6Rl8q0CiWnGlcKCvmS0xFqtzCTTPfoYVdgBte
         n20g==
X-Gm-Message-State: AOJu0YziGPWRUu6MSFCkbrf/5bDX+pOGj0gt5aSAmHllaCkgobbLiJnv
	juRD/m0GBXqXZgzqRBt89Nk3V5ehAXbL9CiGw/2bNH1TRqiWPi7y+cJEBtnW8KpIFl/2MIgqniz
	LPXSknza1eKob2dXinhbPmsGdxSlGXie6HKWkBz/MaGm+14TDm8ow9jQ+/CM=
X-Gm-Gg: Acq92OEZ7pNeFL5e9i/LtchoGC4rai5SytV620xWulT7+glOTBLa+4mNczaeeM+SO8h
	G3LU4YALKOa9wQzmW5Wd7ZOLq3Xv/Vlv73cAIt+YUpBagpsSknwxBZR9mx/I+VvqKnLvkB8jNaC
	x7uOyF8GIPW62LoP75IVJuoHN+UTQXBAIxfNzBBJ7EBCb9OAtiz9+KoPqodlAxl9nI0gU/WPgBQ
	b2iIvRPO1AzeFauwGJ9EGsOAikve6eXXwsTYLUR5VjWTcF4PzbLpWg8ttdoRCnjvaAX49Z27mtC
	UDPX19FEiSD9RAablusVloWcANrTSV4qzGaKBPuQPbj8g7jKU3Zmpx02BLfagtRYm/CF7GBHK4N
	TSEM=
X-Received: by 2002:a05:7022:6629:b0:136:b8ca:e58a with SMTP id
 a92af1059eb24-136b8cae77emr6842627c88.20.1779917296897; Wed, 27 May 2026
 14:28:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:28:16 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 14:28:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523005558.BF1581F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-10-2f0fae496530@google.com> <20260523005558.BF1581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 14:28:16 -0700
X-Gm-Features: AVHnY4LLV5lPMeiEw2ty46ZWdsqSl4F90gDfEAfF0EGpnWud9wi7tfH7Cpi9rfo
Message-ID: <CAEvNRgHXWewsjA+y=4sT11rq27TNVFm82zoszwyBa8AMrs-tHA@mail.gmail.com>
Subject: Re: [PATCH v7 10/42] KVM: guest_memfd: Ensure pages are not in use
 before conversion
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
> [...snip...]
>
>> +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_=
t start,
>> +					    size_t nr_pages, pgoff_t *err_index)
>> +{
>> +	struct address_space *mapping =3D inode->i_mapping;
>> +	const int filemap_get_folios_refcount =3D 1;
>> +	pgoff_t last =3D start + nr_pages - 1;
>> +	struct folio_batch fbatch;
>> +	bool safe =3D true;
>> +	pgoff_t next;
>> +	int i;
>> +
>> +	folio_batch_init(&fbatch);
>> +
>> +	next =3D start;
>> +	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {
>> +
>> +		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
>> +			struct folio *folio =3D fbatch.folios[i];
>> +
>> +			if (folio_ref_count(folio) !=3D
>> +			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
>
> [Severity: Medium]
> When folios are allocated and added to the page cache, they are also plac=
ed
> into a per-CPU LRU batch, which holds a transient reference on the folio.
>
> Since this code doesn't drain these LRU batches via lru_add_drain_all()
> before checking folio_ref_count(), could this cause spurious -EAGAIN
> failures?
>
> If userspace retries the ioctl in a tight loop on the same CPU, is there =
a
> risk that the LRU batch might never be preempted or drained, resulting in=
 an
> infinite livelock?
>
> Note that this issue is explicitly fixed later in the patch series by com=
mit
> "KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion safe=
ty
> check".
>

Yup, it's fixed later.

>> +				safe =3D false;
>> +				*err_index =3D max(start, folio->index);
>> +				break;
>> +			}
>> +		}
>> +
>> +		folio_batch_release(&fbatch);
>> +		cond_resched();
>> +	}
>> +
>> +	return safe;
>> +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D10
