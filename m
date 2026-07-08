Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D84C244685
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516168; cv=none; b=H7/CY4OXfcTa1ECvzW5HnyqUdornHrLdLfU7byzuMNQZM0AFXH6IO2LyerREeofmAy51rf2sQ9qj4xxeYmFmhkOBNoj4ntZIPUq72fjkbaTF/aO5/yGp9FZX0cz4wY4F82tmdQZCo61MgtuhfczauKU0fvTUYvq37hG1qJdCiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516168; c=relaxed/simple;
	bh=B5Xz8Cj9GtmmGY80Bd0YjhzOg0FM3M/FDbxUTOq1NjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=URKFmJtCoMWutKfLRA3LljVRf6ln+tMQMpbTpNvZc9IbwbcRFrzKG8IvKWnuANSoaudCeHC/Tr5nM5VbmRZlVsXsnafbvKTkhhg37eheVtMMHEJDSQq+byMf+e1LAn02Sw9+rccz0x647WAY9zpgtImdi77SJRcF2N5asqZ5wUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4MmRFsQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4MmRFsQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845df469a26so1990724b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783516167; x=1784120967; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhlV9UENadvdIZ8Jme39kIw2BfFgTNLEABu+Fnas5o0=;
        b=A4MmRFsQyQpSxzhJssPLjr4qlStuG9Op0q7nPcKsQfb674scq5GJfyJnxDXzT4gdEj
         BLxZh1SxWTwrHn/mRiZj3U1X98boTPW5FufLJhpTsYMFAwM8MDZJprkG3/ca9WORaENN
         GASs87gT/f5XD69dscepbH3tiIZIZJzD7GiYkrhN4B2fkDCHv3cpr3BMoSh99bO2XkB7
         W4CF8PtB1HacEnzfb2FXuo/Jp1H6pBQGQF9HfBLBSam3nWLQ7Bvi2kVesS07/EA1uUCC
         3+luK0cwC61vNdArFxoIBAiSyeeTSUXEuLS3w/7VNmWoZWfSPhN4Fg9mBnTaf2tvH+/r
         XofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516167; x=1784120967;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhlV9UENadvdIZ8Jme39kIw2BfFgTNLEABu+Fnas5o0=;
        b=DOwg2eTTM9QYbdJiFw5NquKP9XeLRnhWWcW0PO8Jt8UnZeLNcfCadCu+qptAa2K+F6
         cXZAFjRb3xgEnusrRLRznmo5QeOhCcfU5n6AHrJJBpsq0vmQp9F302HRiUguRXNQYvn8
         HhZHAZyL7gNHf0jt+inBZz/c8ORndmZoV3jQBBt525VAxoO9xE1SeRTdhZm8aJZJZyqp
         5WowQY2iGhkVQfhIWItnz64jMHragkCrcy5aism3Yi/UR70puBgqECYvMh9Hw+alGPh9
         AA10hf5F0afHacVPm3MwoodkVyiVhpYOdG42sfJZgDdPIrQuWcZz7wOe4mR1rLGUit2B
         GYMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrfVZTp/8yziUIQLTZAsQiyODkpK7bnhg4V2CF3DGq5mqtRWcK6V3aB1bjSc4sv8rKY4u0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8xGOcCfqNIBLinx/6Sx7bdvB8ZdZjKCZgj0u4igUlXy/H+wa
	Gr/eVBKz0cfWkpdwkxGNzBZJ1YAXDgGPBfgnjlEV78OVc8ryAlrfqA7umgiPjvZBlqvlrWzkgdI
	ZUn8BLw==
X-Received: from pfnv11.prod.google.com ([2002:aa7:850b:0:b0:847:840c:ba17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8896:0:b0:848:2f77:e2dc
 with SMTP id d2e1a72fcca58-8484392a53fmr2471240b3a.69.1783516166709; Wed, 08
 Jul 2026 06:09:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:09:26 -0700
In-Reply-To: <20260708074249.157987-1-1234567weewee457@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505065849.81691-1-1234567weewee457@gmail.com>
 <ak1Dd5M6EtzOF1k_@google.com> <20260708074249.157987-1-1234567weewee457@gmail.com>
Message-ID: <ak5MBptLdRl9nbDb@google.com>
Subject: Re: [PATCH] x86/kvm: Include linux/types.h in asm/kvm_para.h
From: Sean Christopherson <seanjc@google.com>
To: "WEI-HONG, YE" <1234567weewee457@gmail.com>
Cc: pbonzini@redhat.com, vkuznets@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thuth@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hank20010209@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, WEI-HONG, YE wrote:
> Thanks for the review and the suggested fix.
> 
> I checked the commit bf3647c44bc7 and agree that mtrr.c no longer needs
> linux/kvm_para.h. I'll send a v2 that drops both the stale linux/kvm_para.h
> include and the linux/types.h workaround from mtrr.c.
> 
> I'll add your Suggested-by tag in v2 unless you prefer otherwise.

Works for me.
