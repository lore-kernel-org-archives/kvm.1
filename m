Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C81A6838
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664679; cv=none; b=BK5B7UqGnYws1AAcezg1Cbd3L1PHbifXLL1Xbn2j5jHVLJMr3YzYIBjlMqMkjrG+9MUvdgnQ3hfh+X7UHBoYM99dQNLGHp5cc4dhauMMpTwDPw+Ue+h2zftSuLWMjbWiQ2HgdHpdnPiEjr7MJMSGR/u50ro/B+gTDiG4MgFBgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664679; c=relaxed/simple;
	bh=srmb9zTlyp51XEA972IHbfAxn8h2GD0juy/qxH/QcN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EUiHivxrT1uUaZ/TAhbAXu43KaqkVH17fb8fLG6tiLt1SU2qhLZzzkoa1vmxNAReXXJZa/8w+IfaXxVqWoxthcCp47oEOzSe8XrygKCVnE9oYrFAXbcIVTTFOpdeJuhjGpei2zycx5oJUIhMspmcGd64GyRNf59z962MD3kU74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRp59VjZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRp59VjZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso639944a12.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786664678; x=1787269478; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqxisrCvBgfkAZVjDOUq5Fmah125u9gQAdSBbncAguA=;
        b=BRp59VjZa69+jyEp8HmXQYlqdnCafxlpL7O957vhw96uKv6nrME78ZvAlhJzed9Ifq
         npCHtv/9KmtSHmA9WcXP/ImWc8CJVHJHFeqXHIV16MI8i7U5BnjCPn87AsnEOh0Qoh0d
         Eb0egyJfcxsFxMHwKArabvAPqALdW/JrDL9phNhJAQFw4HuGhSU5Bc/pZgur5+R/nSD+
         FAUz83rZkBJxwOEBdDf692/JFdcX8YQV/GXzRtmuYEH9Ec1ZlhywLKFWFxDEpOC4QKGj
         OAh7bN421acrARzumtK1SJznk9xSQHqePjxx7sqor9dD5qWB22V9Z9n7w/SQGOgs+C9/
         1low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664678; x=1787269478;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqxisrCvBgfkAZVjDOUq5Fmah125u9gQAdSBbncAguA=;
        b=hnIcnEh4dBcRfcSpm9y8sekLG5i5JKAbvk3vHBIAJp23UXYKtOx0RtCayWWdnY/InX
         pztJ97rqU+uvUPS3sXh/7g3swrkAP4nLR3vpwhQwKKXXSu5tC8SLtRtDDGgpomzejxWk
         HS6QjFKwHWW/pHukBDIexlr3ZYPFQETYBZ6joh4M/qYpRLJsneI35LrtqucjGf0OMpQH
         DGTI2PwbPGt9LCh/VNefWn0e75eDCmJu9qz8UZjRIKT9NHUpQ4Tx2bLdC5aacEK5mqTk
         /4u7nDfxSUR4AfYa/t9PbSREQ5jlnnKzMBTqt/EagA2eBgicJThAsaaDl81LNPdb+XsG
         ekAg==
X-Forwarded-Encrypted: i=1; AHgh+RoTXOh0rI+MVhbIWH6pVYDKEurB6KPTcG164GbQnzOkLLaHZXaUpmpoJGeGxl4yGiwWfPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGvZkuEfffDeokorTX/VF3eNft+sw1L3r+IGPb+J7ApGPobrU
	S+6RI1dl0F//xT2FILIg2iy3CcMA2uKGwP1fF/m0aBae67zVjJCTjteb18s1Aged03i3CEMBweK
	Oqy4Opw==
X-Received: from pgdf6.prod.google.com ([2002:a05:6a02:5146:b0:c85:9c9a:ab5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e613:b0:3cc:55ed:dbfa
 with SMTP id adf61e73a8af0-3cc71cd3ee1mr1657677637.27.1786664677905; Thu, 13
 Aug 2026 16:44:37 -0700 (PDT)
Date: Thu, 13 Aug 2026 16:44:37 -0700
In-Reply-To: <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com> <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com> <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
Message-ID: <an5W5XC97HK229MX@google.com>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
> Side note. I really dislike how tangled this area is for something that seems
> like it should be much more straightforward. Deriving partially I think from the
> overloading of the TDVMCALL leafs with the exit reasons. So we have things like:
> ...
> 	case EXIT_REASON_EPT_VIOLATION:
> 		return EXIT_REASON_EPT_MISCONFIG;
> ...

I peeked at that code again, and FWIW I still think swizzling the exit_reason for
TDVMCALL is the least awful solution.  If we don't do that, then we'll have to
update every single use of the exit_reason to demux TDVMCALL into the "real" exit
reason, which will be a mess.

And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
more logical and easier to follow.  vp_enter_ret holds the information about why
VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
but again, I think that's a better alternative than demuxing exit_reason in multiple
locations.
