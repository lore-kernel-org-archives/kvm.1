Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DE3EF66B
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022728; cv=none; b=jCfz6dbhz70LruaAwaDosIz8JfYkTuKsdRr0EqCIzq2dC0O5iUAxgkwNASFHrrMTEYXw6wjIaWj0pE5k9R54xw1S2ZeNx2c5gKVttLi/7mtTijudxKY+RzlCQgrZ3ubmwag95TF/rquG8lyR43TwDbYGTH3+LZnY9hmReTrumgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022728; c=relaxed/simple;
	bh=EilUjJ5tsk2DBMwZKiRIc7u0FfmkYWg6EBLgxLeSHkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ihNL3AVcqJp42UVT/rUVxEhiwlV3amTDbHyjse9x8xRfhou0LTRMHo3eCSxV9NfzMjOqfCHD1uaU/U2/n6302/Ed7L1u+OqNKxolSAW5oWfi0dVbA7pQiunE99Pq1FumEFAS6sfdUlg086t4fIv6qSdGp7QYrmIT1oIlwjm+1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZaY/qytb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaY/qytb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso67299105ad.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022726; x=1781627526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+ZYrUUTyCSvXOyRn/JSFOaPfBccTVZQ3KVQPFrWhbM=;
        b=ZaY/qytbhz0TtyNbi112m5+mOn+MA7tKLQVXDjy9nMGsZXwgXnh1+EcwOKUz0djtOW
         YNL9tv/xkEn6YKaQFZbTD2AYRJzMz1bVcmhKEQMJ0D6ED5lkHIJlNP3BqesNUVLQ1BKD
         GrXx131DsDaMpxXW4nK8oHbdBoxCL2cFpTT+Ia/9sAJ1Zw/jbkMbjTGj2KCCSqQlztFS
         /gTbN1iu3iGFkmDEwte7gtwvGJB80/fsqj3kcmIlvNJbZVQWdVBQMfFSc/jkuwpVImuW
         v+Hi53++E65MDmbh6KIELG3k5pCxhjb46xyrrdQKzk61jU/Vc/xur2Xlvd8dUOFDkq6s
         P8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022726; x=1781627526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+ZYrUUTyCSvXOyRn/JSFOaPfBccTVZQ3KVQPFrWhbM=;
        b=ITe5salr6WoAikmjO34sU4EsWBVfeytDA8K67Bx8dRBNrP4LeugVX2khReg5VNDwXr
         J5WplHWh9ek1gyjJqjw7Y3zL9Cklr2YH1JkSj8T6Qu7QqTQqjSsenWTeJoMEy5Ei0Im7
         +zSUIDuM8PzFpnNMb9iwhCfuKPQl6bmoZdI54YTnaYFIBR8gSA7XM4eah2xnYzWqUG2n
         dIBvHJfKxjq1DSyIWvlW5HEesetL9VdNQHDQCiPtPOU5A7nPAtw1OCmj7x9vbp8HLuZq
         O/MjNzJSthLw0kGxeytOcjm1akNS00MCzXMiHT6gDFvxvF6B3pEQe4gWCc6nH9j09Nfd
         upBw==
X-Gm-Message-State: AOJu0YzFu+JlIDx23cxGEvhACiHj1mGp6n7aoaMwtPiNjBkmIu8cfyEc
	WReoEJVsB3HBbZ7+MugRfsFAwDOWnRwCn+1XNWSHxmEj+Iu+s14PTPvLhL47aICYWEK1Q8EUX6j
	62Fmjlg==
X-Received: from plbmc11.prod.google.com ([2002:a17:903:2b0b:b0:2bf:32d1:a319])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4c:b0:2c2:1982:527a
 with SMTP id d9443c01a7336-2c2198254f0mr184307915ad.16.1781022726075; Tue, 09
 Jun 2026 09:32:06 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:33 -0700
In-Reply-To: <20260604011106.315176-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604011106.315176-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102220598.2734345.18029704765979146835.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Kai Huang <kai.huang@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 04 Jun 2026 13:11:06 +1200, Kai Huang wrote:
> Commit 9717efbe5ba3 ("KVM: x86: Disallow guest CPUID lookups when IRQs
> are disabled") added a lockdep assertion to catch unexpected cases where
> guest CPUID lookup is performed in IRQ disabled context.  However that
> commit used the "linux/lockdep.h" for header inclusion.  This header is
> kernel wide but not KVM local.  Switch to using <linux/lockdep.h>.
> 
> No 'Fixes' tag since there's no real bug here.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion
      https://github.com/kvm-x86/linux/commit/b8d3d74d8b5f

--
https://github.com/kvm-x86/linux/tree/next
