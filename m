Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240333B4E9E
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896718; cv=none; b=l5oqa7wWnUpqBNLzxfXzEQXGG07/O2aJuPcB/4+h6uSQHxV1RYPWJnLFDshEirXmJwzsr8UWsiDG0KV8Mi5V3hMkaTlXrU8rFxBn0MxHmmwFX0+VvtDWt/K9w8SmL+xMpUohBez9pQ9EJV9H+B/IIYFrGdhTaPyjly+BQbNo1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896718; c=relaxed/simple;
	bh=LGswsnZXJUBGkrzTvqTSLcIHT6gzuUHjJgJwgvTE8fM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MbQRGjdGFGkCS5wLV2mEEpZyppipu032Uypd0lcOSmyuUvZe67uIL9DjkB1NvPdIVFoqePRubeK7KoOkZ/X3bDJOz5vCyu32ApCeGbxKRwaSab6dWuviEGvkQqrXHXIhbh0HEA/9uXwcfz9UzC7LAdcvXisd49K8xlxzPKIq6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GB6KYFb5; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GB6KYFb5"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a0f55a3941so6765400a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790896716; x=1791501516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Bt4FBOS0I71ZeNU1qvl7TVnImsqea9TvROCXfNFv7c=;
        b=GB6KYFb5OU5KAXaieAWtPW9+eZVxGHI3jLY2OVL4FuPWCUoUtnpGmCzM91pHEfTCMD
         blI2zKr8HxssevsDsIPu/RINqwx1MB+Yq1XRe1x6hP/omS2JisYjZxtbzMuTgeT5FrX5
         eHbb74KQPzVMuh6XuIBpvxY7q4vXW5rpmdCKEmvbG04rthycnGxr15sTN9k1UkfkV1oR
         Gy528AW1i0YUPRl6lF/SIh+3ix6YBcgBI/NadtlMrYDhQdE8eqI7HKIFC/JxZ97n1gew
         DHWKLgiTu9JGMPx2IwwCSF08HYmgir1S/pYoWsFdF8ffK7N5tU40myZuvkv7kAO9Sy3a
         gCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896716; x=1791501516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Bt4FBOS0I71ZeNU1qvl7TVnImsqea9TvROCXfNFv7c=;
        b=t6laDlVbaKIp/6SQO+cL0cmuvs+k1dry43nh4aF9jAI/ZJ+HeEUdZ/qJzMObqyizw4
         xpnZn0mazlvahxFlK/Hso45SX7tvQuwGTjaK380yb12Ala8L3kyo7clNaJ+9uWCaNy6V
         GQ40mnIRT3rTGlm3IEEQuqfDpK/kTdYKoPQ6g1u/qflz6CQ7A1TSgrsn9yWCrm8Cugh+
         6wajZ+wBhc4M8ZsyabNouTTKbSA5S7K0NxguaGdJ5XPaj0WHsr4DeSQscK1dQbrLW3Vh
         uRSanSLqZBxWwJ5VvunWe82rn8Cy56F+fZ0kQQ5e6Zydt6tC7J8CSrdMNFqZW3Xo9PjN
         oxbg==
X-Forwarded-Encrypted: i=1; AKwUvBw5tG9S3GJm5EYEiSmpGBg6eF/Nfgq3hk/AlYhbYvzJ7byLOxTQrvmwQiDqSYXpiXsADQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxBiYzXGXhzOLJLFRasIRW4HrkKT0J/Pv2mI9t1MRVmxC0pPZ4
	ETjQgRI+VkOOzyNWGbtYR0LORNVC9D5b5B/rnT8zeMrf4IH1xwrTQlWnXeSrELBRxdOv9S5SnXZ
	3WyGzQg==
X-Received: from pjsc18.prod.google.com ([2002:a17:90a:bf12:b0:3a6:dda6:5b44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58e8:b0:39d:fd82:de0c
 with SMTP id 98e67ed59e1d1-3a6ce3be283mr769245a91.2.1790896716130; Thu, 01
 Oct 2026 16:18:36 -0700 (PDT)
Date: Thu, 1 Oct 2026 16:18:35 -0700
In-Reply-To: <ar5yW30S75THCfdV@LeoBrasDK>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-3-leo.bras@arm.com>
 <ar1xne00AHnJ-p_d@google.com> <ar5yW30S75THCfdV@LeoBrasDK>
Message-ID: <ar7qS3PeV_zo93iT@google.com>
Subject: Re: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Marc Zyngier <maz@kernel.org>, Josh Hilke <jrhilke@google.com>, Oliver Upton <oupton@kernel.org>, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Steffen Eiden <seiden@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 01, 2026, Leonardo Bras wrote:
> On Wed, Sep 30, 2026 at 01:31:25PM -0700, Sean Christopherson wrote:
> > > "Dirty-ring not supported in this kernel\n");
> > 
> > "this kernel" could be misleading, some architectures simply don't support the
> > dirty ring.

Hmm, the counter argument is that this is actually accurate if those architectures
were to gain support in the future, but someone ran this on an older kernel...

> So, do you suggest keeping it simple by printing "Dirty-ring not supported"?

Yeah, unless you have a better idea.  Actually, even though Kconfig isn't user-
controllable, it's still there in the .config.  So maybe something like this?

	TEST_ASSERT(cap, "Dirty-ring not supported, check CONFIG_HAVE_KVM_DIRTY_RING?");

That would at least give the user a breadcrumb to start with.
