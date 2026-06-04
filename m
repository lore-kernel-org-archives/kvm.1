Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CC3911A8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594921; cv=none; b=u3t4O6VyKans943xVaONlilWBPjKwdUKeTXShHYcpTT7oKCV0LtJk5p/kxhLFKZkDH3jmxICf1KkNSSO/ba1CLg+FtZ7Q0og7nEUrB+7GCKD6grwivJ4dIw8GClOoATDX76IKsGHSJ0p4rCTrYnG2fhVY5SUAAN5nUqSxAhwgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594921; c=relaxed/simple;
	bh=ezSlhog56VUDGe4X2nOnkDwxK++qGblH63of9Uv59cI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GsN66YigjPte18JzzJCAb7VI0A0VWCXK8G7LLJyrF1hCZ77X/5O6kSSbaOc/fNBtBna29Hb8pvGxamPcTHoohhr9nfSIWJAL6uTqtatZOFtXz9CCbOOsMkNpkQ/UW2puaYfZRXLMMuyQfGwkbnvuS8xTLHCX73AdmFISxDC0Dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhsB3Iia; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhsB3Iia"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84235f9b91fso750014b3a.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594918; x=1781199718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWduaCqIW5OJ/1rUkmACp7uJQm5U7cfJMYHZpLa1/5M=;
        b=dhsB3IiaBrGyjY0WQ2a6RPVo5BpWeDUKxXSwKFDDf31qDLmZ3uIfX7KzjkGeL1EFqW
         0zwuZtUOJQFRkO+1njGbJMc+4Zibr10Xjr68pdfdpXy6Wo56Uv6FYcFzY9ZfSWaEydPF
         pBKYuWCCNdbc64RzKhuLfb1MZbcnjOMhorGm6njnq5mwftwal2rrwkS2+nGI4pj6b5Xy
         mdF/R/XHE9mPLNxMoC8NvI3lxxh3pRLzh/HheVDbulq8rTu3ybeORwicG4BlgM+eG267
         gquLNvtNAYEXtjVNpRHwQRf+FLVbdve+6ifUxAXBhSncUpuISWIEfKYa/d6icuRs9h3b
         U4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594918; x=1781199718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWduaCqIW5OJ/1rUkmACp7uJQm5U7cfJMYHZpLa1/5M=;
        b=bxp6ZDwlgVJqk+fAMjnaaCSWYAQoCBAYui7iMr2CDv05PmnrzCrBAUZOmXknx+vZeB
         i2Ot4N3QG5cHrpU03xvy+4Efl2CV5f7g1HNYuiyDL+E2bRUAo+lUXiqPveHYq7/skczR
         1Zz2A7b1AYF5EsRXW5EP83spkDnGyyMx5gMh6ouG3R8D1UeYZoLT2GVejGV8YnBTBWcC
         l9HJTO+Uu952v6UoBW7giR60QY4AHkHN18aesj6mJbUPmKVDjrKkfTwIVxSOZRVHJjRO
         Xrvg6CkmagSYDhFn9kpP0Z+GednSkT9nNSLwfwGCCSBrQsl7J5c1dEnJH3yDmcFP/b8K
         ZyRA==
X-Forwarded-Encrypted: i=1; AFNElJ/tNcdkj4j0Nyl2vvdEXoCtWvXhD2TxPiRIVoEs0BLdEhVmHrxkJzaMeZSHOcJU2M2YN/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNX/PW3Sc15kSl8GcnwN3x78iwbEfcMROrM3HdkjX3O8oSUjDB
	7q7zOXNrrU5KcH55AUqad+lq73F3qXKsbxsMGOddS8cb2VVYxR36rDLcEauN8fvGBYBQG9Pj9z+
	j/WyqHg==
X-Received: from pful13.prod.google.com ([2002:a05:6a00:140d:b0:842:9ad4:d8c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188b:b0:83a:b344:826a
 with SMTP id d2e1a72fcca58-84284f78f93mr9224683b3a.26.1780594918108; Thu, 04
 Jun 2026 10:41:58 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:41:57 -0700
In-Reply-To: <aiG13utvmTJeHbnV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-21-jrhilke@google.com> <20260604022049.A44EB1F00893@smtp.kernel.org>
 <aiG13utvmTJeHbnV@google.com>
Message-ID: <aiG45cqd0gCRVgp_@google.com>
Subject: Re: [PATCH v5 20/21] KVM: selftests: Make number of vCPUs
 configurable in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Sean Christopherson wrote:
> On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] Missing bounds check on user-supplied `nr_vcpus` allows stack buffer overflows and out-of-bounds global array accesses.
> > --
> > 
> > commit 115e22303a8d11509c805d6bfdcdbd39b670c16d
> > Author: David Matlack <dmatlack@google.com>
> > 
> > KVM: selftests: Make number of vCPUs configurable in IRQ test
> > 
> > This commit adds a '-v' flag to tools/testing/selftests/kvm/irq_test.c,
> > allowing users to configure the number of vCPUs to run in the test.
> > 
> > > diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> > > index 1d66293b6d0b8..41c50caa928e2 100644
> > > --- a/tools/testing/selftests/kvm/irq_test.c
> > > +++ b/tools/testing/selftests/kvm/irq_test.c
> > [ ... ]
> > > @@ -213,6 +214,9 @@ int main(int argc, char **argv)
> > >  		case 'n':
> > >  			use_nmi = true;
> > >  			break;
> > > +		case 'v':
> > > +			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
> > 
> > [Severity: Medium]
> > Does this code need a bounds check for nr_vcpus against KVM_MAX_VCPUS?
> 
> Yep.  It also needs to configure the test to enable x2APIC format and disable
> KVM's broadcast quirk, otherwise running with 255+ vCPUs will fail due to KVM
> blasting an IRQ to all vCPUs when trying to target vCPU 255.

Oh, and the routing logic needs to be updated to actually shove ID[31:8] into the
correct field.
