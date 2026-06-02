Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A206A36728F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432899; cv=pass; b=s8hvtv/6HjD7wc2uM2w4gIm+zkXyCKgyFuN5fyaTj36w6i3Q90JQbV67lBIroFf98fm7LcHpNX+cN+x9inP3FVczESAqhE56pcJBfT5AO9nfmRXv6ksYm4bbEV5BDQeTHnXaKBzPPMpueWDq6amR+97C3lEqF2BBi3KyBagqGbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432899; c=relaxed/simple;
	bh=nTYPsQanuHPOf3+YdCHnJYoAoqYTW65WA3kXZLPmJs8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4Sa4JOIHl4udW9rKJpscAFzSN42Okc6eRQupS9ysmfgf0oZBVwFrp3AtOUmO08uYNvz4xa1kQjg7iW2igmnXMJWvOJXtl6QZtXKV8DQ0YPYKSkp8bZF7K0pRLjfEkIk4rDkyYWNsLZ4zAtivLGxy1p+u9lLFr4nBDd2vklnQps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeLpvLxs; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeLpvLxs"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137f3cb3f46so503510c88.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 13:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780432898; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWuBiTcpaC99tVLhGcgJydylv3k26t+qJ+UrnN49unNZXOiN1Eghx4rrvuwqJVNyvk
         Cbtsj+mQLS3IIUnnfHb3+6us1VuJl+m8v1i/Olo1DriGTF7oTdOiF/ApsalfJRtc+Irw
         IHI3dyzt8RjfbK07rlv9aK9ZBtmg/G4GkOgztxvgnHks64y3pN5bGNanHo5aRRG8sqZi
         PSmW1NMPAT6RAdZa7PSSw+tZyux5HP+9YVqjDKo+n6leZC65WJSmJNCYJWBDBhf90P6t
         FV0HvxPItkWB1TLwYhke+US1GH0ZnM7SuApr79sV2SgLOxaiwYOC1OFfgGWFOTKA4wsh
         cR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=Q9DfpYFNGzsB6sazPDXo4YOkWRxIbqoOx7DhukB8QIE=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=I/qGR5B3qD6alAJ6A6HaNmH7V40LVYtC+8j0tbgxFOLjXAkeR47c/OIPdbg2ijaFMi
         DMMyFcsGY149i9mZ/43Lx1wilPpM35WcsM9DpOV4ToxYAV63wgv4Agzn6c8M+96dV/ED
         TnVUm1lLb4qVwn8zEodMSYbkyJIjLJQfklTfRGK2oMyg8l7k/MhlSx9LS2UnHwkkhPmn
         6sJf7gHB5CoMFtq6+1QEc0OcbkAL07yGEZ+HFlJAK2v2hEN0aTw7vDB7fsfEDKrR4bdi
         iG5gCkGIUP/46Ja5dw6y1VgeEVZig/dNQnGilJGacjvXqwZ06ScH0w0NwgqOHlUDVeh0
         p/YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780432898; x=1781037698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9DfpYFNGzsB6sazPDXo4YOkWRxIbqoOx7DhukB8QIE=;
        b=SeLpvLxsk86H2IYyN1pxBQNFSD46FKGI4tyeF3tJVE3cmTU0VS1ooour1p/d7Ry5O9
         DaE56dO1QC/SHP7yXfhWiRoEkeDLqxYl9aW1OiIi9l1veRmrw5RD52BSC8w8JvcC4lpU
         NWHGynR+735fGymCbbBg9Ko33vAqWXIQDoXZd0q6R4bKnztqwUrbler1nZek+dEvIzlo
         obf6uA5z0yp66C85n0eOpuajk6ntUWUrAlrW7E3V114iiLnicJnijlwFEohwqssyYoXF
         fQA80s2eMFncnj+YvexvPePElYVi8tWW9zs4aDAar4QveWY2DBqQ6wUyhlSHGURQPeTt
         bozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432898; x=1781037698;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9DfpYFNGzsB6sazPDXo4YOkWRxIbqoOx7DhukB8QIE=;
        b=PJTE8Hl3IrTtRlkadwoEtWqmVG6InkgoJ5tqDMVos1OGCY8E8QE0vFMZ3c1pmM6QWu
         5dbIIzVlOhWcV88/lXTd23Y6aESe8m1Emvs8AcaGPs3Z792VV/fyhA/zZO5QYDeS6fVE
         GDA8M4E/GXR5pwUGfFDeSAALqrcfYTNjLrAtjseil9ZIpw1WbSv0F1JihfVsLWsuAJq3
         w7cTjuV8XraILDURruMGJRuCQJSdygHLjxJqCh/XRtqndILigR6SNimsoqtQXTOh6QhS
         nIT9QXCgkfld+mfY53ipA1WBpEhC79JU3lbaoLoTdLZJfKuxjak3hWXHdEYDlWby1RH7
         FSjQ==
X-Gm-Message-State: AOJu0YzbTGMjQFIcFrOLKiUNsijOBPRKwL1DoOYFEuX1Fzesfo/LAlIx
	bOi4OqNRc7HIvav/n1RU0xzEc92z6bRcKYn4nhSa0/j7n4ohrnsEeZM6BvXKgE8lnaaGMBT8MLP
	ncq6XlhaMtfzTXhtWuwIJVT9Mmo9htI6vLcuYG3Ab
X-Gm-Gg: Acq92OEtdVeqfGIVCWPFL+3AA7hWZ2xBXtqI2/7OjKmz79VRRzRSjLnmNth72I47W9o
	FrgFLcprIR+8TV3Wn0+pvERO4jMA6Vklqmoav+0KT++xw/PFDNGxRVZNjb0H6hBDq35uuO5JsGJ
	PIh6KSwgL59qvyqr5KmrKyyzFkrZuFeKjaFImDZgVQ8d0w/8ByUB5ZKXUn0W+j6tcLX1Z4Bj40y
	R6PcfZLViWfJte4Cf/TiQoI18lslI4tguna0mBs6Q+51fssBVdDDJVv2iXIekaCjCDfC+df1W1k
	10nzliAj4Lzf5knRA39bil7D3+7TGRCVXMJzfWFcUyzrvuS3P2IhR3MuDBYVQQkovlhsT6/VL+y
	fAIqf
X-Received: by 2002:a05:701b:2058:20b0:137:eb26:117 with SMTP id
 a92af1059eb24-137f6b87c7fmr108819c88.13.1780432897006; Tue, 02 Jun 2026
 13:41:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:41:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:41:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523005223.5B9651F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com> <20260523005223.5B9651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 13:41:36 -0700
X-Gm-Features: AVHnY4I-p28f6R-pwlANnTjmbkkEzzn4cv_rflApgLZ-buk8YP2KDCX9f8QQ2KQ
Message-ID: <CAEvNRgHn44ASMxyBpDWXYO0QiGi1PgREUWfopgdk_aQ7bFx_UQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
> [...snip...]
>
>> @@ -908,7 +910,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_mem=
ory_slot *slot,
>>  		folio_mark_uptodate(folio);
>>  	}
>>
>
> [Severity: High]
> This is a pre-existing issue, but does clear_highpage() fully initialize =
the
> folio if it is a large folio?
>
> Just above this diff context in kvm_gmem_get_pfn(), the code clears the
> newly allocated folio:
>
> 	if (!folio_test_uptodate(folio)) {
> 		clear_highpage(folio_page(folio, 0));
> 		folio_mark_uptodate(folio);
> 	}
>
> Since clear_highpage() only clears a single PAGE_SIZE page, won't this le=
ak
> uninitialized host memory in the tail pages if __kvm_gmem_get_pfn() retur=
ns
> a higher-order folio?
>

guest_memfd only supports 4K folios now. I'll fix these when I get to
huge pages.

> While comments in kvm_gmem_prepare_folio() state that the code is ready
> for huge folios, silently leaving tail pages uninitialized could lead to =
a
> severe information leak once mapped into the guest.
>

It's actually not quite ready, but I think this series is big enough as
it is, I'd like to defer the hugepage stuff to other series.

>> -	r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> +	if (kvm_gmem_is_private_mem(inode, index))
>> +		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>
>>  	folio_unlock(folio);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D7
