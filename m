Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E334A13BC
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290037; cv=none; b=i+5F8dFrrTzc4LRuDCK6JC0QCRK2hVtkl7iKUSdaTnzNraxpEaLkhJLHjt+KjeSAdVyGjGtAR0SHFNtiDjqkm7/7YLg6WypKxGrWDFl/ufOs6H70B2euIX6TaZpmdqDybbBPXxLOEm1v1PUAmSA535tGpJ7nTA+v7knp3zO8Sfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290037; c=relaxed/simple;
	bh=6h5m8oBLmcsaN8EsPH+tpcDxvt17SGebO468AlTg5Us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7zfTk/CPtEJiMFOsC0GPgkQ/mpIElKAvAqY7XnfejuNBOj0Y97fcoev8iZIEkLZx0L3xGHm91CQNmN/wigIYhi5LNMn3BM83bzoPk3aaVqYg4Z0vcaQkMHkUz+rRJxkk0LxACV+F8uz7N1+KE9U5L910jO7d2UPyeAii81L3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpPV1p7F; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpPV1p7F"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b80835d5so267331a12.2
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788290032; x=1788894832; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cC/v4tGqIHa7qRI7tcSqJWeetrZS27j4AD0COX7TVh8=;
        b=NpPV1p7F/V0mz7x5SRug0O0TpoI41viG7ONLH6akUQMu+kiHqphEbd3Z4M9HnDnloi
         eKka8m+hyJm6PmCEN118707TbcHyWKT0JP3QnEkIptiVjbGzX1XbzwdXqd0Ska+Q0CWw
         TTvIRwGSDuQ7DAt6W8URxcM4T7PJe08wJekXp2xK4R+OC9GsWAmMWcDNWCLKDQnP/MPV
         sYp1a+SxQtTG/T3EmQSAuVoH7DC3wGWSryEOT7rrAsKInqeRdZTjGeIyV2jq/1Wc8b0b
         FybPJA6FpC/fh362SWNmF7TrbYxddsTqxUBSIqQ6tbARZa2xlr3EwZZRQ1wK8H9ZWN2T
         Aa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290032; x=1788894832;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cC/v4tGqIHa7qRI7tcSqJWeetrZS27j4AD0COX7TVh8=;
        b=s/MI43YkHDgDTH+N88TNGaNrRbks9CqkeHMzxebOlET2e/9oODPtO8l5EEGWHklrzM
         zuokl6QjPl6DcHWXvSmrKbDDA33NAhvgJqtOnuaeNQs53Kd/EQLJFglPfo7p7/RJPiCt
         IWthwz2cVNYbqK610qX6PiAZbEBzUXPo5kbyXnLZGDdFlVySVsYGuewr3wm0O08gdEn6
         DeSzsOt6CzXHaZmzvO4JRcFG6GEWULvIK5caXgbPVqWy4Gsr/ad8OIUdoWP9Psf8soov
         kRVwVsV6k0nuG8CSglKfPfJgNZNSoJPIyBqSUMW7CtaiQsS49HSCizkciw1RTljIMuGE
         PYKw==
X-Forwarded-Encrypted: i=1; AHgh+Rrg5ENR6Ti3YyDY3st1NDTFcmhHP1CuC95CstG59+hUEsGTPKcERytSZF8uELzeoMmWQIc=@vger.kernel.org
X-Gm-Message-State: AFuF++nUujlPr0H6UP14CBnoPeTIHKJayiI2atIFgiJ7CM/Crcya8M5v
	QN0P5DqLLOOmr4Yrj6XtZ5+5+/pj8chwfuNxd4o9nJZsNFU1dsajqJM9UlNBpbIQ3/7ZlveHuWN
	p19smrw==
X-Received: from pgcv12.prod.google.com ([2002:a05:6a02:530c:b0:c8e:c0e0:e670])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1611:b0:3d0:8abe:9e08
 with SMTP id adf61e73a8af0-3d7ad780037mr15285138637.3.1788290031806; Tue, 01
 Sep 2026 12:13:51 -0700 (PDT)
Date: Tue, 1 Sep 2026 12:13:51 -0700
In-Reply-To: <CAH+3ta7b7MudRedhFG4xQH6-3ZK9gfkcEPy_aHsAHBwjyK81+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807112818.958190-1-kimjw04271234@gmail.com> <CAH+3ta7b7MudRedhFG4xQH6-3ZK9gfkcEPy_aHsAHBwjyK81+w@mail.gmail.com>
Message-ID: <apcj7xrcIhEw7lCl@google.com>
Subject: Re: [PATCH] KVM: x86: Use active memslots for the per-vCPU MMIO cache
From: Sean Christopherson <seanjc@google.com>
To: Jinu Kim <kimjw04271234@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, security@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Jinu Kim wrote:
> Hi Sean, Paolo,
> 
> A friendly ping on this patch.
> I originally sent this on August 7, which was fairly late in the 7.2
> release cycle, so I held off on pinging during the remainder of the
> cycle and the 7.3 merge window.
> Now that 7.3-rc1 is out, could you please take a look when you get a chance?
> Please let me know if you'd prefer that I resend or rebase the patch.

No RESEND is necessary, this is already on my list of things to grab (or to make
sure Paolo grabs).
