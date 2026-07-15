Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702D219E8
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074260; cv=none; b=et8Y8QH/KvlpqHJN5/XGIvDLPBeiz4icuaiIdrU9LROSO/LEc6wa+zPUpL/i6icn5t76O2yojt/FSMsVU6btd3d3WXawcCGFJFN5qLYo/M0kNG52PKEVgkxSzdJxMnS175vESMqFYPAY2KPMUMKDKmcn2nxWjh+WOtoQNxVc/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074260; c=relaxed/simple;
	bh=FMSJZadlcgd+A7MpAhd72+rcWZ4vSJmY9sFHRGA+t3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZDHpkRuxrGBErZy2I+eWlkuxNtWAnK8qJFzzfUacMSsWpj++Fqucwv7NtpVJPJCim//4uZegKVOechvjAD2Qxejed/Kvi2qkTGBV0c6zTXAEi90RieNUIAYjJnSrlsMHf6TDohE+v9Q4QC+DiiU3Y1lc5YSSuyjQWtrN3QAdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4dIqrRs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4dIqrRs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c354050c34so83663045ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784074259; x=1784679059; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1rv/O3i63Qn52gM6nXIO1foOK5d+gOMzfG7jT/SI1U=;
        b=U4dIqrRs/tFht83P9eK2yhjZb2q2NewlSJXpQ1pPeo2GTKc4M1v2NlQG6f8oFyscBg
         CDibz0fylQUSm0Zb/HNwC9+C9GUwqFefQnVTMG7MntRfG2kE2YlVXYciJuhp0vcndIV/
         WbgBnpqYeQZnTIrtzHSWoCSgK3Xflgr+Ge0lJxh9IsBTJjvlp85G5IaDfeY7uV09M5xe
         /ac7kI3lCn2dIpFIvguNl8rrIg3BI5JDiZ9DzNHxNdFJz04MKW8kH9KxtX+MHCMUZGyM
         pffGxITmzWSxp0DZS1V7N/6LEBhUN2+K14UxzLWVomjgnFyJKtrJ1qWOpwS/qfcVX6Jd
         mgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074259; x=1784679059;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H1rv/O3i63Qn52gM6nXIO1foOK5d+gOMzfG7jT/SI1U=;
        b=S1MBnGp6XVj52R9Ya6byvzu1r12bVrPJX6wZGJr+swxrwexTIjGcy6rH3bGHQ5nND6
         XlLuEjpTo5xptpM1L1KbTwa9WZPAPzp0uMns7YVQvisvdlpMCvbo5y7gr21NUH9eqfZK
         rH6BZiaDuJ8v0parqW77mbWuD/E+lIj0DhFsuKmO9gB1WnM/H32jULQtyYFCfx4obRlA
         +pfiloVrGaAHlVwoDEbUyUedbolKyjL4lnuszqYL4UKH88jvDdVz0ll+zY9SZ4GIrNpM
         Q47ENitgKMAzHKjgenE8R7oKGQCKWhMavJOKS5qr+7FN6Cm5XnRAvDntD3FGA4W9aFho
         mC+g==
X-Forwarded-Encrypted: i=1; AHgh+Ro75hMtrCMtUP2WSc7FeGUsmsPE81vDvbRrE2Vt7RfSWgUo7kas9ePWpw6OGaX8rs7sMEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EKAxugl+fpTCI3dM8YFL3y5bjlH0m8kZDqEeaNqSiWrLvDTQ
	aAfKThxi9KM2Qs9ft8RXz/jsW99R79YszqmQGifj3G2eijXqBfZev5h2C8qP2GRm2jup3jtMWjZ
	WUQF+CQ==
X-Received: from plqt9.prod.google.com ([2002:a17:902:a5c9:b0:2cc:b904:3254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:2cc:670d:9b2f
 with SMTP id d9443c01a7336-2cf03d9c767mr4896855ad.33.1784074258756; Tue, 14
 Jul 2026 17:10:58 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:10:58 -0700
In-Reply-To: <CAEvNRgG1Jm7k1F1H9TK3ACvsbHYBzoNEohvii_N0_da_ForTRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-7-seanjc@google.com>
 <CAEvNRgG1Jm7k1F1H9TK3ACvsbHYBzoNEohvii_N0_da_ForTRw@mail.gmail.com>
Message-ID: <albQErGisdVyHoQL@google.com>
Subject: Re: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 14, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
> >  void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
> >  {
> > -	kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
> > +	WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
> 
> This setup means later pKVM would have to define a .gmem_convert but
> actually only use it for reclaim, which seems kind of an odd
> definition. (We can fix this later.)

No, pKVM (on arm64) would just implement kvm_arch_gmem_reclaim(), and then do
whatever it wants under the hood.
