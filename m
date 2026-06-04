Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0330AAB8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590418; cv=none; b=SPq6yaaFRYoUknJwfY3ZFSOOut9wLqiL8Q2GZi75Nb5BzkDOZwEj/01AR89SLVsDX92A9L+/laGstzorQZYEGJXWXELR8AfcgrRt50SaT8gyWKiKY3ZpgY6S/xaqIXdJiuKbPmbccsqNDqa6wYvGUnl2K/o77EooBNJHzD8zDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590418; c=relaxed/simple;
	bh=rL8z0sb0aozORlljoVXFqnxfct+9nFDK0ox1JpGznx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acLm65PppxT1vVhUxuKxS2lY5koVXTHR4kkz703bgu3xg6SBYEEBTd5qX/xjZkmpuTnVhaYLbH7ZHynS0VzAB7GgT+w5M0CQbb+JZYJK27ZUSiz8ZXtfyxbEf/hD602L2gKYGbeB26oniUflh0XuP0V+sp8Q5UcFO3dyZyBEPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBPLKC+b; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBPLKC+b"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85dc345ac8so551832a12.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780590416; x=1781195216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1PAoVWOX5uTiJ2KXbRfOf7Z3sR4S4Ul08plY8Umtbg=;
        b=wBPLKC+boO33v86ArZBxo7qRsI1IYH8sjCIc5WJWjijZFBbGz7+aHykthQfvCgvaDC
         WEalyq1LGSwpmXGv+bH3GutgGUsF3VtiBbH2DpjL8JUyOhPA3XqDrRYmIK/NxGX5r0Um
         duMTEU7lkLztsrislRaihGQCVPU7do3bEEYNfy6ybIMrvB4G5de6loL3Hz/armetLXvf
         qcpOn9mHx4EGkb0Xy1e1/NCmVF1Sa1bVYKRuJWUJEgccsgEcWT5uv6RImYsmw5cWp7Dm
         bHCK9a58ab5Jzcc+lmhxXa+l/eqCn6Y+pfq2xdB/I+OpcfsNxBMS881xM/5K6HbnWePL
         5ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590416; x=1781195216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1PAoVWOX5uTiJ2KXbRfOf7Z3sR4S4Ul08plY8Umtbg=;
        b=THeHZ3/Z9sHlUkuLYaO12kwizz0Rk5g7YpIghCqFAiqskEOkSbeCRzpIyao/TQuKkv
         A2IbBJX/OLWQgTwVdF+hpFN3itkqyNaLIYntRaeW9Qr8ZGKqS3A5zKtHHLx/mY5ipdyp
         O5oa4cCzpg2yMdYmlfKiKCAHlz0VUaU9GtkYQX4zJU2nunJUFRs28EKIxPFP1yjXsNPK
         fE5/V/ABq7WdTFC8ziiwi5Ipyfa8EOahg7kO8iPjvxU7mzxzYski0qJS9gWuv+F3y7eO
         GqN2myf1aLoJMsKRK/nJo4Eg9buOA70Gctl7jZhEzluTMD5KyBx6qeLm2ng9jp949v6K
         gDtg==
X-Forwarded-Encrypted: i=1; AFNElJ9AKDkrZmQ/eiUgAqD+BwbL9FuOXDwHdaljn6+q9KFR87XF9uxVgmVj/CMyDjBJPuCzHNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXtEzJ7lbYZdwguIUkJm83a1z6EOJ12xxAKnDJojf2f9g4zYQe
	AMpbBqkAjF+QLJ03QemXq2tFdKoB+Vg4/eMXQDrYNLpwp0Yqkq6MAfHRq/p1zfDkQ9s1325cCKN
	K4dVs0Q==
X-Received: from pgbbq18.prod.google.com ([2002:a05:6a02:452:b0:c82:295e:3b51])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b18:b0:3b4:6dee:a427
 with SMTP id adf61e73a8af0-3b4976ba37fmr10251206637.44.1780590416182; Thu, 04
 Jun 2026 09:26:56 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:26:55 -0700
In-Reply-To: <aiGlib6tvRkyNCIA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-6-jrhilke@google.com>
 <aiGlib6tvRkyNCIA@google.com>
Message-ID: <aiGnT8oofyOiQrEn@google.com>
Subject: Re: [PATCH v5 05/21] KVM: selftests: Add IRQ injection test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Sean Christopherson wrote:
> On Thu, Jun 04, 2026, Josh Hilke wrote:
> > +		eventfd_write(eventfd, 1);
> > +
> > +		clock_gettime(CLOCK_MONOTONIC, &start);
> > +		for (;;) {
> > +			if (GUEST_RECEIVED_IRQ(vcpu))
> > +				break;
> 
> This is a kludgy and confusing way of writing:
> 
> 		clock_gettime(CLOCK_MONOTONIC, &start);
> 		while (GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi) &&

Heh, "minor" detail:

		clock_gettime(CLOCK_MONOTONIC, &start);
		while (!GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi) &&
		       timespec_to_ns(timespec_elapsed(start)) <= timeout_ns)
			cpu_relax();
