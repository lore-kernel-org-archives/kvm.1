Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA23A7F55
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782292867; cv=pass; b=AUjdTzrIsm4Q+oW78MJPphuVTmSvEUH+rJ4I0XMCL5Uwm78JsVd6QYwGMG+h3K9N+ozTCQNp1vjZco8GdXvdvLp6e7xH0AwsDfwtXE5ssNr4uHMk5Uvzh27JMeoGDzWILPzK04PkGwRgorldvLGRwFV2QQF6c+P6x9f2TDVcN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782292867; c=relaxed/simple;
	bh=0zpwOpl/br9b692+15XowcUwPrkmatHZq4oq/a1EW6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUeiWeMsG4PvrG1a6J1HNAd/Jouek6K3lR9AFpPF6a0JcSs5ItqNZLhe5+5ILukT1mXtl8H0OEjyvPqwynZaISO21AMyY/mpIEwt49NvtUD/u4t7RFs8WBx0mbK7L6EXKd5YZ1Ux4RkigTnbTpbdE5eNL5Y1yXoPsh1U5Pp6Xk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGYMUrl/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTmpZVxg; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGYMUrl/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTmpZVxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782292860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zpwOpl/br9b692+15XowcUwPrkmatHZq4oq/a1EW6M=;
	b=EGYMUrl/KGyo6GIAZ8I4mtJpq4uWzRYhokJdXexdDoukjZbTmrLvKYhYvS08Ph82GcXV/J
	ZvdtvVURuMNux/V6cCv+UnNVcrjkGdenjRjx18p2iMmNPBBbX6Z4hHRuB81N4f44cA55O1
	qo8B8hQCT+/Qrb0DumorKg3Cfjzohew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Ml5C1yjAMO2ZcuZXdw2Hsw-1; Wed, 24 Jun 2026 05:20:59 -0400
X-MC-Unique: Ml5C1yjAMO2ZcuZXdw2Hsw-1
X-Mimecast-MFC-AGG-ID: Ml5C1yjAMO2ZcuZXdw2Hsw_1782292858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so6271975e9.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 02:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782292858; cv=none;
        d=google.com; s=arc-20240605;
        b=IevEwlHE9cmcMYkU+OEA5Cehlnx8JXZhUTljPYeBOHmdqsVun4uFnfhkyCWZhWUqi7
         +rXtGtlEQcyoW0s2h/hXAvI80E85m6azBkKOnD013ed0mL4tspO99cGHbF70pFb9//qb
         DZDpPVuk/BojFsZP4kLI+hIMq7had/U7m0QGz0CbjYrAN1n53bHDIHHUBLZWxOOUYKGI
         DAZ9EtYKT+cgmE+x6ge091vtpaZc1gdLFqedLPDDqAnr1rHExoo3g1CiuIaHfXox7/B6
         cD4T/jV4dHQvraOp5xG8Pr0wSS4ZaGL2iLcaY3U1kF6KFz1rbUf5CEpM19yjD27u+DQC
         oz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0zpwOpl/br9b692+15XowcUwPrkmatHZq4oq/a1EW6M=;
        fh=i83Z+2lvEWlT8WkUpbJqoieLbtXXLHrJer/zDdRIo00=;
        b=lb1uQ6RyQSDQao87feostH4EOs3ItoSS2hqe6kBA+5kVn159EqUEvgXJpzwoZn8G2B
         cuwCdnxxQrKsek7nn+BsiAK/ZULjnO+uxqE2vLTQQam/Yy4JZJIYn3xt4jFOqwVQWLSJ
         DRSoGQJlArsXGa+q9wX4N0oyzO//g3xo0gBK12P1M2Od3NEoO0Q9SMhHaM1try/Y5DuA
         aG5LRDWPpfYQDgDt4RcSyXTkKlAm6XAbIeAsHCSZLAeOb79xpfWNzVdnPzd3cVmSeVa4
         1L0mg8wUC/kifEsCnz12C94tJeYbkN+puHHwou+byNixYxtctlKBlvVOW0+iRE0+nM3I
         JQPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782292858; x=1782897658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zpwOpl/br9b692+15XowcUwPrkmatHZq4oq/a1EW6M=;
        b=QTmpZVxgZ38S5qYMnt0tSwWWvEAKYPgrr41jOa43C/8rKuDl3c78qzvvQ4V6r1KCY0
         tOdhGQZL7dFx+L8IKOMPQ/uMhOKnQlNVKq8F/zBXONX0JGYrXrg5XDzUlT2pnjDVoIVG
         YeBNjWr1gVD+N+7FWGL1y6iwwPYI5zNtPU9YREG4aNChzmH+ed7pHnjeZ137vPfnC9bo
         SD+4Ly2NlNt2INg2Vlxre9abgnar7L+q4iDNkanj38K84JdqfgiTWBRaPxzZe5n8KRK6
         M6hYe03KXMLarzLb1FI+Kp9jqOy9ckP+M5o7Po00uNemfHvQ72/tpWU1NupzJaUJv96E
         dS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782292858; x=1782897658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zpwOpl/br9b692+15XowcUwPrkmatHZq4oq/a1EW6M=;
        b=BOb+pKyAZDIwLZDJ7OtTPrXOTv9u59MEOrbLSITLWkM1WAPSFta6f1OphDnl06rDBm
         qUnn1TPbvNmsaoHgq4vUoidNVJme26Aa1XrO7N223RcAGXGse6clkvKS3gOOQQpCjz/V
         5t0ZxMPbkLYCEL6I48/hYn+2rzpnLFJfagQdNRNAfv3oCTmSKdNAkzw0nRU60+in546+
         2mnsL0chPewhZtHYGgBsfLUxcTPwd/rzgbT2VCF6bkKrdztaLQQI64XQ5s/WK7Irb1er
         5fzEiJu+OXWq33DwDTA3iP0bJjJylpmiuaNMnPiaea09nZlw+6on5q27hcu6AhwSBKuv
         ZHBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1bNjSc5oqEXR5RqHSzL97GkE+gQ0GRfBp5PoXdt/93Skv51192MDS5nKk/eo5SvHBhOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHdqvKFuxi6BTQEdsiVJMlY90yfYldjTJemy9/AuMVUwcf3Xk
	Ge1d/cPOEpPolSd8oujdxtvf7vx7txRhknlg0FpamjJwiOsXJpMlJqbVfYaPa5mO17My6kmSecG
	3qkZJuZOqgt+rWm5Cy/DVRHpsA5pEiSHKuFyJUogDiErJIYhIyUYm0+RCPyDELdx5ljeyppKEDb
	bMGmP5X07vPPgnWpHtTiM1WV9qI/8t
X-Gm-Gg: AfdE7ckLftgGzMdDLbqcDgqkg/f1eyk7lVBUTjAEZeIXtzU6u9Q4XXRTXBggTC/mOlA
	b3Sk1nLgz0CwQ5ti8PyHoS2j/HT0LheNdY8Zo24kwe0HzScUk8KK+KNB2nFvUR6uvW0ihI/Hbn0
	v/LWSR2xfRRw94bNyhd4lxJ0bJ1uz6XBKrjHQM2OjFnNdX14m9JrRORClFutx4FyYCX1BnPA3/r
	kAkY2dZbNuGrorpkT9APafNk6jCU7SjSOM4ysSHLLG10+OU1y4wWwokeCtuiRpSvO58UGtJ
X-Received: by 2002:a05:600c:4e09:b0:492:564f:5603 with SMTP id 5b1f17b1804b1-4926084b963mr34271625e9.14.1782292858083;
        Wed, 24 Jun 2026 02:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4e09:b0:492:564f:5603 with SMTP id
 5b1f17b1804b1-4926084b963mr34271145e9.14.1782292857661; Wed, 24 Jun 2026
 02:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612133727.411902-1-seanjc@google.com> <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
In-Reply-To: <CAO9r8zNa+ueRh0hf-CJ8sdyOFrcF+nEc7S06ZkMmV=GAvum6hA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Jun 2026 11:20:46 +0200
X-Gm-Features: AVVi8CeW8rba3cYmDbgCiDvP1RrZSOqLYgS4E3M0E7OQclHYmgYL9rTwZYisrQ0
Message-ID: <CABgObfYF09bB05zRRrr+ZEsaA5GqMxC9R9Zqr4RgHb-m0yKUNw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Expose number of shadow MMU shadow pages
 as a stat
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:57=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
> Why not expose indirect_shadow_pages? IIRC that was also one of the
> stats we (mostly you) used while debugging?

I agree it would be useful if you have the shadow MMU acting as both
L1 and L2 MMU. But is that going to happen in any interesting setup?

- Queued the patch, thanks!

Paolo

