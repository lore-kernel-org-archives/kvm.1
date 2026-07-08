Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EDD433BDB
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519491; cv=none; b=Z+t9q1KJ9qBLKZfNNkVl8lKu3rOPYjhHTjvdAkBs3rXiTwUG51bxhginpIOgOxuU5nAU4wC7h24e3Tg7ubP5YQ7AxQC9Qp7K/aQhDUP5dAwc5ONRNlWu89AaBxRCPysPqj3mHHI3UzIk+yXwAYxcuFiJtEEb6z9Z2zrit9kXWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519491; c=relaxed/simple;
	bh=VDqnd98Y3F+WCkp6CVStlwKiEamh19fMC2n1d0p2he8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVSnDET32NTPwApk51Jwy14l44ncx+yDjXctLZbL6DuQNB2eo+IzqMolnoUmmvMmG8t8hw2SPPV4KYgYmHjhGkXpJbV/YYoyyNc27J7Q2QpwTIdjh9O3vSn99Br8ysQh4KIjP3sT77lj4/OadQFVDnWogWjtOt8tYJxQPE8vlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJ/jLqsA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJ/jLqsA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8484f26852dso234932b3a.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783519489; x=1784124289; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYqhNi51VCSViGg3RpcK/Rx0LOdHhkEWxN1ahKQcyxQ=;
        b=dJ/jLqsAD+teKxkANpipbo9aow+OLWOqkbbIsATJ9tT40pHlTn222PSKcyFzf8Q4NR
         ECRsHIGtip2YK9Z7h7HrvZv88JRcui/duhQIdNJnQYnWKyUU9ERKlpg+FaQ5H0RhabCs
         8tCGsFWF8DfesXsnWvxebMtzMJixJo+WMptHKFUosH4lHj7BjvFt2U5fZIyKdlBplpET
         FKoJtHRyjsDNvrmT0iVm9TCiMOv9Fnz69jGVIyFV59GutEeF5Wnnr9dytIcH02Ak90OV
         YWk3X4jUL1tgVeW+q/PoM/RRZxW+VVXmhrRv+sRILlZxW2xWwe6Cq1KEX7fdhi6zjpcg
         21JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519489; x=1784124289;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AYqhNi51VCSViGg3RpcK/Rx0LOdHhkEWxN1ahKQcyxQ=;
        b=OgZsooIOsBKR+i5GZIn7Kekj2qkRebv8+I6w1HLs6IcWsmBu7snDkD96faAsKWT2Cb
         3rFZrVFMOZ8LDJ6HIHDyI8gAbDn9Qt3dR4Va47HRw0weC8A/zkDGZqmr1a5pf99zgLkN
         jEgniaZ03NFg4Ztl1nyt4PD/FfGxbdseN3+uzJD7F7y7b0YxuxyicPaa0ItUwJymLCB1
         f7fazezdruM6a/KQYM2r4XgUhefu3/CXaf2nwXtAWFL+6C7Vg2f8LOyC1ijd/5KwT8y6
         7EgjL3GiUjab+94xA7KVAranjdneTp4RH1yPYwcZzNLPi9aOvfm5RSJZt9fIbiDcFdCA
         aDIA==
X-Forwarded-Encrypted: i=1; AHgh+Roq1HOBvvDHXifrzjXUs8BuQC4ABndlBgUXgbPbA1hAVjzQt3vXS1+9BqheHgdsmPnNw9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVw0gn+kNuvgJpXSVqH5mP4E7l6b71JSnJY7fTB0Swh0wscETQ
	E8Pl+9J+RDP6WxwTHSWIQjIK/B//Ezog0uMmwXXKj/OMR3F6Oqqpy2FTjoZtgbocsZJ68ZoQGUh
	E4AqyRg==
X-Received: from pfbdr7.prod.google.com ([2002:a05:6a00:4a87:b0:846:5d01:2319])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6f18:b0:848:4810:2b67
 with SMTP id d2e1a72fcca58-84848102d18mr1731912b3a.21.1783519489171; Wed, 08
 Jul 2026 07:04:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 07:04:48 -0700
In-Reply-To: <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <ak1-vF3qUjeszzSC@google.com> <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
Message-ID: <ak5ZANYxYeWmDGEL@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
From: Sean Christopherson <seanjc@google.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 08, 2026, Tina Zhang wrote:
> On 7/8/2026 6:34 AM, Yosry Ahmed wrote:
> > On Mon, Jun 29, 2026 at 08:52:03PM +0800, Tina Zhang wrote:
> > > The SVM DecodeAssists feature is reported in CPUID
> > > Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
> > > of the intercepted instruction in the VMCB, allowing a hypervisor to consume
> > > the decode information directly instead of re-decoding the instruction in
> > > software on relevant VM-Exit paths.
> > > 
> > > KVM currently does not expose DecodeAssists to nested SVM guests, even when
> > > the host supports it, and does not propagate the hardware-provided
> > > instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit.  This
> > > leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 from
> > > using the same hardware-assisted decode information that KVM receives for
> > > L2 exits.
> > > 
> > > The missing virtualization was observed in practice with Hyper-V as L1,
> > > where the absence of DecodeAssists prevented nested SVM from being made
> > > available to L2 guests.  The fix is not Hyper-V specific.  Complete nested
> > > SVM virtualization of DecodeAssists by advertising the feature to L1 when
> > > supported by hardware, and by copying the decode-assist fields into VMCB12
> > > on nested VM-Exit.
> > > 
> > > Add a selftest that triggers a nested page fault from L2 and verifies that
> > > L1 sees a non-zero instruction length and instruction bytes matching the
> > > faulting instruction.
> > 
> > Taking a large step back from all the discussions in the other replies:
> > Is there a measurable performance improvement? Not trying to say we
> > shouldn't do this, but we should at least see what we're trading this
> > complexity for, it's obviously not straigtforward to fully virtualize
> > decode assists.
> 
> I don't have a meaningful performance number yet. My current understanding
> is that the main value of the series is more about architectural
> completeness and enabling the Hyper-V L1 use case than about a direct
> performance win.

Yeah, and I wouldn't be at all surprised if VMware follows suit in the future.
E.g. see commit 176bfc5b17fe ("KVM: nSVM: Advertise support for flush-by-ASID").
