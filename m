Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E975346E51
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034092; cv=none; b=ChmViK9vLIL8Cjj5Rc0l3tHMcYs6ZLMRRd6nAloPdIYAz3tm+UcHt++ktper1StorFv1u1kV3JPrHYznoK1YKbt+dLPyMWDxFKYxTxMiLeZwvyl5wudg6W99Ku+yNA8tAGcULAyEnB4IyOEXsYaoW1ZYK5uegWb7JDauiDcMi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034092; c=relaxed/simple;
	bh=XR1aSjT2w0MZt8yLDynin1FoHl5oC8qEyd2xwg43Hh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8sDeSmALxZm5Jdnm/fgPXHhmmbGsrHiiFVhr9HqrqCpIm3r7kMoxMSOBPVSyIvC7KpgVKeKhm2whaiiShl5owp9ur5o57qjX6W5y6mGeFwQVo1k+1rGCasc8kFcGsb2WBXmAjhHE2h+BT1KdofW7Xg8xEmgU6LBSOYhO9wVpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJwOlUYI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJwOlUYI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0bae9acd4so1900735ad.3
        for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 14:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769034090; x=1769638890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DAEPyBb4ZzOQ24J0pMAA2XFBdEx/TMihaOHYjYMi8G0=;
        b=JJwOlUYIbD66JSwTsdxli8AgRJCcA1CqvahnGszMR/YKd/nFLCEMo2UhgAaaRu11Xl
         D8hwjl/+zK61BSmF0K1xuDSucI6c9jbI0n6n2P2qFKMXjhZJ93CWRZn+ho1FmHzUrMad
         ZDthI9iC60FhVTJYcFovyCnviYo5Ki5r2VEWmS+MJ2gjXeufteEZcsmZt+xzyXrOJYe3
         uNB7o9XYl8X1qiMiDO6lNb2XU8xUsUDDyC97yFyEhkyiN/sCkrBQpelvwZpoAK1Roq8/
         kbuK/YhhYEu8chJP/I5QlLye6rzYeB8VV1RUNYGm4r+BvJEUKGYc8BP0cP2T5k5wEH1+
         zNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769034090; x=1769638890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAEPyBb4ZzOQ24J0pMAA2XFBdEx/TMihaOHYjYMi8G0=;
        b=pP/14hvrnAqTrMGmZd7Jr14XfRJCKRYhsR0f2qmDCiI+ymhpxEICYv6nbw/G797I2Y
         lZGe3NgRWiMB6HIu0YvhdcTzyjhP42uFh/MPqOkeHFmHsg11B+WKtYdcAqfMh71xZfgY
         xQEIX/byQ6bdnvpy32hj/ThXspOOeyIEFs5VpS2ToTMle2WMNP6Dc24QZo7H50XPCWJL
         pfi+bVyMMPqLTOcHFhP1MxWeI7Cvn93fjW8QCosQ0Cq0D4j7LQpI/iuSyITwqKLI/+HY
         FsvCquNAuY/cuhKWGd4id12buCctGGjmlMbLdDM39LS2FsUpGVyBxC7djozNBYJH3ZAC
         juVA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jkdmlbn0lS1NHQvH4YbBk6H+6cNqnYrWsgJBUCuHtA+chlQEe2rBCb5VoRbD/K6Tyq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEftSnu7RGzKBfmCgYCjOJvzwF6+RuBRzEhY6I1c965oWlBakb
	LMqgQiIUvcmhKOCpHevS9k2HO9zatLX8odkFQ/91hpJzMzrSrgdhpo+zEquTiVf/hf7CsuWJ/cc
	Ih2QLhw==
X-Received: from plbkf5.prod.google.com ([2002:a17:903:5c5:b0:2a7:63d5:5774])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e951:b0:2a0:b02b:210a
 with SMTP id d9443c01a7336-2a76b0517ddmr49653145ad.37.1769034090503; Wed, 21
 Jan 2026 14:21:30 -0800 (PST)
Date: Wed, 21 Jan 2026 14:21:29 -0800
In-Reply-To: <20260121004906.2373989-3-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121004906.2373989-1-chengkev@google.com> <20260121004906.2373989-3-chengkev@google.com>
Message-ID: <aXFRaQs5nGpTN53Y@google.com>
Subject: Re: [PATCH 2/3] KVM: selftests: Add TDP unmap helpers
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 21, 2026, Kevin Cheng wrote:
> Add __virt_pg_unmap(), __tdp_unmap(), and tdp_unmap() as counterparts
> to the existing __virt_pg_map(), __tdp_map(), and tdp_map() functions.
> These helpers allow tests to selectively unmap pages from the TDP/NPT,
> enabling testing of NPT faults for unmapped pages.

This is both overkill and insufficient, just do:

	*tdp_get_pte(vm, <addr>) &= ~PTE_PRESENT_MASK(&vm->stage2_mmu);

Then when a test wants to validate more than just !PRESENT we don't need to add
another API.
