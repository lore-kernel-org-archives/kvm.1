Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAC3C8721
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177630; cv=none; b=sidCe/j3nx412RpxawLLROLXd+QLtTpfNlYSvuJSa5ybLRe7ZjYd+vhX45t2wSeEBzdM8uCcZxyswY8/gKJazJRAvOBF8J3VUbdDv5bSAcRoC75x2ia9onmY00PH2fi3YZxzn113BQqACUG5hOd7qZc2ArBTV6HpYNsbDBw8TfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177630; c=relaxed/simple;
	bh=wPMni5fLxMgZIA7zEmJjLSjIa0nXTUe2U+XZrO3mFUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GCOPaWhTlclL6BFAwUCdMVwai3CNGE1yA4Kd6NOtjmMEByU0Rnov0szJt9/5AMxmVzl+KXvAM9Mtv+va5SdKsnnqcLDYSzJ/wMs3Aq7IlNr0YIYoiXjwqA5ITR/3Tn490v0T4AttQL4VncTUylv5IErnHgMUPcyZOfJB+9+4Yug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T9K04z8U; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T9K04z8U"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4cdfc468so95948945ad.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773177629; x=1773782429; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIkqMoEOlkm7KSfuOW4FwZ84jifXD213PXf9OCtMGd0=;
        b=T9K04z8UKWO0Y3xsbKqp1/MTuWHg7bkj7TslhBn03ndW6ndVk9YHLbDbKOFqfG8R8j
         yzVFucH9EE4W1W8JUufWr+bJB3OOxTrEdH77foqcpVtvi7M41VwQQaUpc+lCxduFAYKb
         fyW4+QvWSmSEkAg5lTlHk8+h+VT6RWWY57iQKyZ1rV6ZTppjAmjiHLzIDUknEd01XQHV
         Fijt+AcIF/ww1MPcgdAUy5bayP5jLdS6x5lFtfgTuta/XjaVeqX5ALIBzyFrrVuobhxx
         oiipbvHkXbrhOPq/mDsqPpQ6wv734Fbi8+1hrlGCiSWgEfghJIJlrSiAMcJG9FXXsrOH
         cPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177629; x=1773782429;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIkqMoEOlkm7KSfuOW4FwZ84jifXD213PXf9OCtMGd0=;
        b=UitbspQN66TRuKoZV1njTHmvcTDvOZ/gPDSntq9xijTO2oEpxVFQMeaURYYCkib1U4
         MfC2neb6MixU7rEjzecs1+LCQP8lGK+oJj1A9srS8HybURo/L+jHNn11rEsWaakrI8YL
         PFXYDpMib2xrHiy4X0UJrfd3Yjc+fMe/Ct2ycvdb4YMGHf+ZOQh+JJ/X6c4r6wwqzsv1
         +1FSJgNe8Xc04OIOYo3mS4J5TgcJo1dVj3Cqik3K1sVzwTtsw2fZEut+QlvoUzw6Z4Si
         x/gc5CLyhH0JEfSxRzR+eXFAm7xc50UGeOojgi1FIhS9odODp6Pzheo7qgF4qm3O//RQ
         lOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PgzeQ/dD4o2T8+htvT3DUWwt3YkzqyD8MV9F+Q/urk+MycCKfOpWcCVlUOvZCwAgP2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcyFi1+tO/LQeecBZt2x6fk/R247hAj5YPxCVB2z9xCfLcB56
	4e9aR4zcno3L/m9YoQKKZgQoyvWFXjKWKiZLCZuYWkCtQPdk4gwgq6wJhseXlEMRZidAIA5rtXx
	cUXgZ2w==
X-Received: from plhs6.prod.google.com ([2002:a17:903:3206:b0:2ad:bd3f:8b44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:298d:b0:2ae:a9c2:6ae
 with SMTP id d9443c01a7336-2aeae892edemr1788285ad.35.1773177628910; Tue, 10
 Mar 2026 14:20:28 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:20:27 -0700
In-Reply-To: <20260305193053.1643463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305193053.1643463-1-seanjc@google.com>
Message-ID: <abCLG4axO2gmpBb-@google.com>
Subject: Re: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 05, 2026, Sean Christopherson wrote:
>  - Update CR8 write interception when AVIC is (de)activated to fix a bug where
>    KVM can run with the CR8 intercept in perpetuity.

...

> Sean Christopherson (4):
>       KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kernel APIC
>       KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated

The CR8 write patch broke SEV-ES guests.  If you haven't already prepared the
PULL request for Linus, can you apply the fix directly?

Thanks!

https://lore.kernel.org/all/20260310211841.2552361-2-seanjc@google.com
