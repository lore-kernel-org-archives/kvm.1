Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F9B38B7D6
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308280; cv=pass; b=syB3UpJZf4hKAW5LTscb5vNHvDkslWivwn6f2wSjLHMpXGqPpiiKcXOqs7eJGc3wuw1jdMucU4ta1UvllJL5Cfhqg5B8EE0CsZ0ryqgwXh+xlIB+mNZ7jEYyUvNruLqAKD5Yoo8I1kmOkk386S/jN9uQWABc2Gia6PkUm3k7Spk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308280; c=relaxed/simple;
	bh=JbnF8tlvwsmPMUGz/K9mddurBUf197LtClXob6r9Br0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALabdMBj2X8LdbDZ79bi6YYGwp0SUneGiCtJvFSiYh8i60wVdrqu2bMm9kiEVKJpcyGpXt2yC+wigG6LgM2jH8G6Nl4ePvFudZ9Tj83pOTe7ZEtaCvjvuIXctnHCvBQ22L8gYajTxRala+azZiDBYzlNgXN+OeiHgnIjYzeQHg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lifd7bb/; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lifd7bb/"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-139aff562e1so1393750c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 06:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782308278; cv=none;
        d=google.com; s=arc-20240605;
        b=R3JJf7xCGx7xBvB4nAbPUCnR6TrvyJlHRBWAFxIBZOlt4cDIZpIDOdRikOEV+xDCUu
         qXqlV9Jr0H2hQxxaWxGcHSVHq3hTSud6I14zPGxcp0xfh50Fuvk9kGcfLFILd9mN61zE
         aOloZnIRmD+K/mVTGoCyq3ztRPPfOuUJdakvl4SId7P+34KEsCJOqtbi7RaTufIpd4DZ
         wS3ktazdWY41MYsDMh/M8/wJXA1WxlnHgt93T2eZiUoDZwGx+702OunILQVqvXi5Tmup
         XJdVKii+ZvggSwAvzeREZaeKiiI0PHXCvYl16mfdiyz4Ypm6gDxTWCy5SsEiBU3bE1uZ
         M+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JbnF8tlvwsmPMUGz/K9mddurBUf197LtClXob6r9Br0=;
        fh=+sMtzXO17SFEpfvNu+6FFRSgNuU3oJAC3xKN5THPy+4=;
        b=Y+1PbpnqGa34ejqdrsjp/T+KYevck6bX7CLpnj9g2GtYiEW7jI2Mmq/+3RgrdXgHW7
         ZiGytcKK0/tecscYh5pID/4LLc5hDPLn8aKrUOiQ2gQux2dJfU2MPnqNHICFQaq37UzB
         7y5s43xZkNrz4Y+8kD5djbiJb5E77p7RnWtmBeUHcuAcoBSIDjj0HZwtwTCzkBZMjSoM
         NbrtAx4CKQ8iOM/BIpKIAe1bUpycuRGBheQc+nOFV2X7M9QILO1d894wdFHDBAsRcgiv
         MpwYhTQjWQW5r83H79SsAEjU2rDZQD+daRHVIXsO0GiaY19TTUwpb3WzDsiHk9uz8yWV
         du/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782308278; x=1782913078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbnF8tlvwsmPMUGz/K9mddurBUf197LtClXob6r9Br0=;
        b=Lifd7bb/EEsZ21U1rIVIIO4lw7aO1OkGRLtrr/Q5gNUVtQOOmMJ6xWhbVRuzqRYwWw
         QRKNQkfQGyjdHCSYLTdq8DViGQMhXVip7Wj0XmhrOqfbC6q0gswPHeHdeG0rn9rXSjqz
         2A9useLOYJlldLb1blf4HTljrSMF2ipUGtBs+xIDRQBzep3JaN4AY2qNBY+uss68CI6O
         b7UVJr6tmJ0omX3msB0IeM2Naxi4VcuqM3G6lHJQ9Rh5ablpn7h16GZMBaamPLOeudH4
         IvACXAlwXHghq6grz3y/KMiqtRPendO981KT8dEqjEDFRdVacp5D6n4VLH/TvtxWVpoI
         buXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308278; x=1782913078;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbnF8tlvwsmPMUGz/K9mddurBUf197LtClXob6r9Br0=;
        b=Nc8Gw9it9MPX7Mxse2EnrrcVnaCNiT3hc/XoEpOLDtOwGzikYluxbEimYNY3lQvlZq
         1K9dNAxr4zyqnasXyRe7VO7xFDa6I0pkXup/XS5SbkGTp5msh7tI9F2GMnnqp/lgznvj
         PI3h6IaaJq6zE2SGC1CLMmLDu1pE7y463dAA5NHo8w8R4WAzuZ+Mf08/JaS0/q8fbStM
         suQsuqVxs1E40tlvXDn6Ex23MHqKFqRmD6zrulaY/tIQlcaYQ21oU1UaUsg3uNx95mZE
         dED4s6Z+4RD8tVCu2eFxKZTgIgkGl1PVA9M4Sm2EKMx/m9LiRwkEhMMHX5A6fFwbXvQu
         Sx9A==
X-Forwarded-Encrypted: i=1; AFNElJ/vqZwvA/vAJwdT6QX7ABLxMh2Gz7foUFO9ChCGrpURsxaTOyFrsSLcwKsQwmZFkWWAPRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFjaHCbOcacXM4Ru1VhooUdge8j3RJ8nRi34fNnpe7+dRvAwa
	zvTWPxsJQk1Q1JNui3qZw8n8fI2w21mNkQS5Qe2j8nZccTARWhj/3htIgJ+WPZR1wCFAVM0nv8v
	tFYdRw3t3mEeZvNeQpnNdiBxGw6OQz5ul5TbVzgXm
X-Gm-Gg: AfdE7ckC5Lk3FDHowYOqg3iXqhc168HuDUlDIIAwZNy8UuJGkodAjU2jImr9bflfoq7
	mmaBWdz6Xf4oKqAps6TtnTcs89t+qHIxYYP7oMXJqaSYIFxjkfLeIvzDVO4Q08/niW5+mhPp7uU
	WilVFF71q3+uBaTaSJ1T1NabMJ278jqRNvBvhj3IUITbUu4xjDDnN07ZJEJew4QKYqDic/FV2s5
	RAEgO5m16TXGzYQNhxSbuqsel+lHFgDsVlLuKHnP3zLo4yZWTkoC8S5pxU+2oG/CEE0sE7fyJMy
	nm2dBn6nkylS31uGqkWjOgVU2NUV
X-Received: by 2002:a05:7022:6624:b0:138:37a4:fcc4 with SMTP id
 a92af1059eb24-139d0c10057mr2617590c88.13.1782308277270; Wed, 24 Jun 2026
 06:37:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:37:56 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:37:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTxdN+TsqSyp+f+8QO-BbOgHEebmpMhJbmD0D8quWg3s8A@mail.gmail.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com>
 <20260619005533.984EC1F000E9@smtp.kernel.org> <CA+EHjTxdN+TsqSyp+f+8QO-BbOgHEebmpMhJbmD0D8quWg3s8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 06:37:56 -0700
X-Gm-Features: AVVi8CdiT8IYvHNr-i5_WMx1t0IMgMVlt_53LlQKQ1trLegTSEWDN2cz65gsFkw
Message-ID: <CAEvNRgHzrPAkLD6a2GYM6KpFBbHscghW3sVrVWv8XvjF+1BD1g@mail.gmail.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
To: Fuad Tabba <tabba@google.com>, sashiko-reviews@lists.linux.dev
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

>
> [...snip...]
>
>> Pre-existing issues:
>> - [High] `kvm_range_has_vm_memory_attributes` iterates over potentially massive ranges under `rcu_read_lock()` without yielding, leading to RCU stalls.
>
> Not a concern. The xarray walk is pointer comparisons with no I/O or
> allocation per iteration. Realistic ranges (memslot-sized, low
> millions of GFNs) complete in microseconds. The "billions of elements"
> scenario mentioned below requires ~8 GB of xarray metadata to even set
> up and doesn't happen in practice. The `!attrs` fast path
> short-circuits via `xas_find` when no entries exist. This is the
> standard xarray-under-RCU pattern used throughout KVM and mm/. Pre-
> existing and unchanged by this rename patch.
>
> /fuad
>

Thanks for looking into this, I agree that each iteration is fast so
it's not too bad.

Setting up vm memory attributes with 1 entry per index in
kvm_vm_set_mem_attributes() actually does allocations, so it is kind of
slow and affects VM startup time. That's also okay since it isn't done
while holding rcu_read_lock().

For the private/shared attribute kvm_range_has_vm_memory_attributes() is
on the deprecation path so I'd say optimizing the setup is a task for
another day.

>>
>> [...snip...]
>>
