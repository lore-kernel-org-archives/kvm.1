Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787D423A80
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895278; cv=none; b=soak5KiQv75fdK8Tcx+0ncRRDnX6Ik6Y0LYkeougwzfpTDI7pfBeTARqC5wNcgZXFCODpC+AjYU00erIWq5TSp+/+wr5OE9hp5VFzacje4kY+1giFv+GbRzupChIBHYP7kOGOezlrtX3qxYirTn37LdaKlgo1CvupC6gLWtYqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895278; c=relaxed/simple;
	bh=xhyXzRInQ1hVIcFi+/mRkOJnihyjq8eBvrX7aKxRaZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eb0Jy5Hf7JdFw5Vew9x47QqFi2YAfq+vGV5jb7Ws0h1KZ0ZxWp1BedQDcXaatpMLIm3Cdo6RVAIHxOwU/SXC6sHhv7ErIBRrtbTom8ra23zwclIOcyWjkl8DQ0yck6kE0wVRtXceB7yJRNbTKqOSqeWo7XGPCecbgEZ5UoABbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H65x7YQJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H65x7YQJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b99eb06178so25372285ad.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779895276; x=1780500076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BC30JWKH/aly7zj6nofm2S0xQsc5N6Du5fBIfFIP3QE=;
        b=H65x7YQJFVfIbBV3/pZXu1EWK2JHsBNny/3wsVemeifD0ak2blERgx8Kq3BReQZkoc
         3xOziBexxAm+dRPVAXKuCbOGYQKc4LrSWtbfS1O9izpvxADMVA/lotD05rHT6viPpHw9
         useBiF9T3rwGSOYrMyPAl2syukjVspiorwUnEbE0ajn68PVX1JUU4XYW6yS0B6y+g2pN
         d5KH8oi8VUre3WkZYMdzgd0vmENPdz8gi+BBM1T5PfC18PQ/Mc7Y3QMWwuR+cBQJo/Wr
         PughSRhTK22ziDEUzbBLngtZCNPLDsI5ANw5CLmbyVpePjUFxP1gg5ZkzKTyEUP91K+s
         CjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895276; x=1780500076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC30JWKH/aly7zj6nofm2S0xQsc5N6Du5fBIfFIP3QE=;
        b=pIaVe4EwUjgBcXjYZf7AjOkDXHQ6qZadt4GganwxJUvz3oZRPRIaSTCV9mBd/MuxdJ
         c45igfl0NNOVTEA6Sf3+j9THLFnVLNh6pMB2eTcOIqJUlmHbWTvCxPel/Py68+aePSGa
         oGvPp0JFBRK9LUW09g0aGs07hg5DRbAgffPrasLLUUO0Zq/a1mJdajhLPvkD9WDy9qdh
         Je3pSMcK6c2Nbukh18LB4jhA9yiaHQv9VSxsocCFyc/OZ1PAzMpF3TfQ/5xG7VZDLztY
         LoIj72MhBjHPTHW0QrgkW8sM4bOzu9xcgDPF42K5qpqoIQwtWa6l7RCF+7HxyJhxj3R+
         nSrg==
X-Forwarded-Encrypted: i=1; AFNElJ95w3SuducKoXXBeI49SnisvG2nE6izmGbGeWFWltz9E0fCs0csPyC0Ob14t92TrMO1PNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhjqRhutxUgCjpLWaF/Fxq84zyPkLdkfXJYLXuE+K7FrXe/keK
	+tL6lONVsmng+CpBkOtPB2nd/7kpG/wYI2nM17smiO8Poa5Lo9uChd9pSAiFfaiPPyS6cr3MJPI
	dsEnRrg==
X-Received: from plsh9.prod.google.com ([2002:a17:902:b949:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccf:b0:2ba:fed:7891
 with SMTP id d9443c01a7336-2beb0626253mr283978245ad.30.1779895275535; Wed, 27
 May 2026 08:21:15 -0700 (PDT)
Date: Wed, 27 May 2026 08:21:14 -0700
In-Reply-To: <d3cd9e60-3b4e-4df0-abd4-5677c30f20fc@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527151232.4058615-1-seanjc@google.com> <20260527151232.4058615-3-seanjc@google.com>
 <d3cd9e60-3b4e-4df0-abd4-5677c30f20fc@intel.com>
Message-ID: <ahcL6tprdOooMISu@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/2] x86/vmx: (Re)Add a nVMX test to
 validate load/save of DEBUGCTL
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Xiaoyao Li wrote:
> On 5/27/2026 11:12 PM, Sean Christopherson wrote:
> > +	for (i = 1; i <= supported_bits; i++) {
> > +		if ((i & supported_bits) != i)
> > +			continue;
> > +
> > +		for (j = 1; j <= supported_bits; j++) {
> > +			if ((j & supported_bits) != j)
> > +				continue;
> > +
> > +			__vmx_debugctl_test(i, j);
> > +		}
> > +	}
> 
> What a clever idea!
> 
> A minor flaw: Both i and j should start from 0, since 0 is a valid value.

Heh, I knew I should have added a comment.  I deliberately started at '1', because
'0' is used as a "base" value, to be able to detect changes.  I.e. '0' is getting
valiated on every test anyways.
