Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9263B27F5
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975356; cv=none; b=Xyq7MpyQu2HbC1wzc4jtMrutBgdIGR6smgML9atNsOl/WG1/sMGNPevhtBpcQroKvQRxR3YlNntaidg8jdQFUAljzxbKQU02V/IbWyoIKMexnBSjGkH1w1DibdmY6oFl/08exD4fOIrF8yW52rhFsjRGWIjQY7KIWZOSgMmxrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975356; c=relaxed/simple;
	bh=12g1B+d6jieqgrDtWRZtBbnN85f9oJqfSejE+SqWmWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ht0DNs6ceJ1Gf7p4s1nNZnr/R1+8vUG6PMyJPrxoWMLOCdRgQg5IAy2uLv2JfMAVbRtK22vMjWRU8UENmqRAflieRa+o7d81FJLffkluITIBNwAhgNBfCkfuR4HoecpHJ1BKgF2kEiHZAECaQgHiplwlIwM+LmBY3oYrga0T4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSqsFwJo; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSqsFwJo"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2f2bd5256so130255ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975354; x=1791580154; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/No+FWLO5FX6dCG1CGsMuVk9FKvSieZ4zaLtA9AySS8=;
        b=fSqsFwJoT3Z9jdRCEj7COW/fBv8yeNHkYHjNOiZgbzQz35ntG60lTcC/Mrk5+NIanm
         Hf3mQyTiOpy4XRrTOVcpxZ22z+RdR5BpPMFdZ5C4dTo4GDCGa1bJ71mvvnDbfMDyZw2L
         KtZUEHdnyNtBZrHhHnIZFAkWJJ/M/aavQlDUO1L6YEhjYHQpkZFNINBfO0BG4Fm6lIX3
         t0smuttoSax0/1+Jn4VAOBGv07UuRdAaN/1zAF5vIl7UhwQcYSqo9pGV6+XNExrRYnxF
         2CHAu9JMlQY0KUoaDznlA/1fp6ZqANzk6B1sDwimnrxnvAb7y5VoYtoV4QBLWwoT0CU7
         7OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975354; x=1791580154;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/No+FWLO5FX6dCG1CGsMuVk9FKvSieZ4zaLtA9AySS8=;
        b=ynkLyUz2GQfBbPCsYm1s81H3IAEStDOPmyhnaPNK729vS8aOaTyn9z+mJIUMLiy76q
         nRuHOAXXch6x/L28z9M1InyLp2XWtEa2cz7o9tov6SqYZMcYLfaZQcnfHMadNV1Ed+XN
         S7wmv8eTsd11OoN3XGZgBZDPeLl6eRag4ip7NFwyFnrjOOfGMMQ01WduIvv6OTSDYASa
         lxSmjnJGeElBHGz5EsoRmUTczgOOthvWqV+Ar0JQbAjUxnwE/1CaczlqS+d7snGxCLKr
         +8Xo7vgwuDCHbfprqK7aCy3bNSkBbzgzlgjsSHeiED6KoHWCjuhAPpvtqrB5l4tedhZI
         +/nw==
X-Forwarded-Encrypted: i=1; AKwUvBz5RC4DH0bX4tKSXYJrgP+uWkn4DcroS7Z4uqJwDw28ILqFxOd8grxDEHZCpVOJiyJkslo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6rrPI5oe0z1vhFkIZhRHT4CQCoptUiRTDdZP53g1cGygS1+u1
	4NaBe/NH05kZdpGDdYyZsmVOdHggjuwURZMVkLv/5oKitbbXEzI8J/M7jzCqLm7OQOkIlPjUDgI
	vHe1XiQ==
X-Received: from plbkq8.prod.google.com ([2002:a17:903:2848:b0:2df:a6c9:c983])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1d1:b0:2d9:520c:38e7
 with SMTP id d9443c01a7336-2e49a7cdc2emr32947935ad.1.1790975354228; Fri, 02
 Oct 2026 14:09:14 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:14 -0700
In-Reply-To: <b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179080256665.3490668.6166344362571990315.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Check for PMIs irrespective of
 PMU version
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	"Nikunj A . Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 15 Jul 2026 12:04:13 +0530, Sandipan Das wrote:
> PMIs are raised on counter overflow irrespective of whether the guest
> PMU has a global status MSR (PMU version > 1). Hence, always test for
> PMI arrival as part of the overflow tests.

Applied to kvm-x86 next, thanks!

[1/1] x86/pmu: Check for PMIs irrespective of PMU version
      https://github.com/kvm-x86/kvm-unit-tests/commit/af828383c365

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
