Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0D41D4FE
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975433; cv=none; b=Gbl2emyAtFhXy7zmg4qKeUktKvdsaZ2kc8jXM0Sih7ukGzN6XPyKYYvKfF3BDoE+d+u3PxVQnQ1Y1mhacnLYGkdH/mxWEMDwFhuy066sXBJYmFRps2LxHMTHL7fEn0n82ZTsn2tVyR+uz21zOoji5jNHKcvPI35d6udw5g1qOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975433; c=relaxed/simple;
	bh=rc9ZDuLCJ4cr3EktrFcFU7glvgvDeZeO3gxJ1AUk1xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rreopTMlOpTNToBGS/gMIgdvP1jUCJgMgB2/lmAPwDGdLva+GLDkPGcGONrdCbNJE3w5JjpvTWSg8P+GEG33WB6sQqwEFTSZ5kOsDxsG1DPSyO+GFesLhezE1e5s10wN9Vydxpe1xwoghCKLIWJwZGsFw8MPsRm/6X7RC+LSB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbveHy82; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbveHy82"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a053dcadso323302a91.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975432; x=1791580232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=17LO3gprIAfGhz+hbXDhwbv7x7ZyaJdC1maPvC3oOkg=;
        b=PbveHy82Lb9D9o2k1WV16yNaQyRdGhulkDijUYr5XTVaE3rV7mUMywpgChHsapSGcU
         WeQIeSVBOWl2eacllIvFNd1zxDED5kLclmhgve8qce1KPgIgcQdlNUnY+9pHq++/DSjg
         Mr/9NCxoD1fYBMRqR/p6Bd+G3uATklSZ94iVufb2iTfNhRVbG3WySo2VFlnFqUawBnkY
         VDLVRjrEiAOtdfflhpUTJqUq2oNH5pJkk5Q3xbpkERoIWbQX+JKRgh2TJTfiPhwQsBO3
         Ka8HYEXSu5pw9qQQywzvH3R1V4rKcIMew3t26IsfzEkUFN8Q+cquyl3uPh1kMBIn3BCP
         nyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975432; x=1791580232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17LO3gprIAfGhz+hbXDhwbv7x7ZyaJdC1maPvC3oOkg=;
        b=q0XAiysJ0XyJwQQElouaOKDSjvcVHfSIoh/puubfIwDxpu5NOw1wl8TmuTrppbxwQ2
         oWQDMO21u1Mp/iGowuKf4ixngZLbEE90GeV9Nlcns8iwnoPva9OzTRMNZ57P0EPrsZDi
         WUt8un/7xfawjbB3sZYCeCHDJYVLbcmehzOnA7KjzK1fizflRCIBhgDCQACOUMEy2mGh
         G9EIpGC3sELRU7LPfuVyyZPYGDSfAqJbFZwN1Y9rew1oloLmWWY1v9jIbqzKpD+/Bx4G
         nyEOS+v5odLpOScANVMwebco6N2CcG/3fiUoanASEW8kaVMqjEldjK0In1HfFvN+7ve0
         QFCg==
X-Gm-Message-State: AFq9FYK1tkMVLo6d/6plW0LLhPdwsbidnci7CE0PaR/KmF5WQjdz7DeA
	KJLEFRfM9NCqLeFqq/UVSAS4Ml9lnAeGyFX9Izv34bGHF8f9DosOrcCOA+V3gMMPmEGeun5qAH6
	GGcfgAQ==
X-Received: from pgaa3-n2.prod.google.com ([2002:a05:6a02:6483:20b0:cca:dcca:4599])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2684:b0:39e:6ec6:f4d0
 with SMTP id 98e67ed59e1d1-3a6ce606ac2mr3645667a91.8.1790975431628; Fri, 02
 Oct 2026 14:10:31 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:20 -0700
In-Reply-To: <20260930210201.3482775-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930210201.3482775-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179080256174.3490520.2017851811237946114.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Treat all AMD CPUs as having
 instruction/branch overcount errata
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 30 Sep 2026 14:02:01 -0700, Sean Christopherson wrote:
> Apply the instructions and branches overcount errata to all AMD CPUs, which
> count VMRUN as a retired branch instruction in guest context.  I.e. any
> asynchronous #VMEXITs during any measurement will result in an overcount.

Applied to kvm-x86 next, thanks!

[1/1] x86/pmu: Treat all AMD CPUs as having instruction/branch overcount errata
      https://github.com/kvm-x86/kvm-unit-tests/commit/7999ff1d28b0

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
