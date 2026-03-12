Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4E34E74F
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331394; cv=none; b=F7GNnQzxURALm8W3gMKw9pnuTkT+q1nYcj/LvyzrKhT4K8cEBi0nbHpWOMpSF8DrfSjHvkReutPuh/M261zKpfgZvARDwrNVsm2bUJadMRv2bQLKNXCyWhJdmx0Zf9f9XZYdT+n0/Xck1BwZSJNDiiSqJ0xJ1VYtj44npU89XOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331394; c=relaxed/simple;
	bh=+YVrai6jmlJOn4dLtUQsmll+LaXBC9VxjqzGvJUs3d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iWsHjZaePrwVB1VLg7cRtpp9ZCDPLmuFQh4D7Xi1sRjeibt8fOXYZooe9TsK+qSdqwfMOjO8eXKb3L/HnXNkzJ1FrMAGM8jyVP2dUyNnXI7EqiUMWZtY5Ec9zDWPlP1VgxtPVNE3r7rOFHHRsuxJkQhCLrbErpvmIuXOotz21tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGsko/Rg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGsko/Rg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so604257a12.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773331392; x=1773936192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKfhHHHxcHNtHeFXvVtQ4riJbH3ZtNiRh2K53JPW2kk=;
        b=pGsko/RgrOFoCgEEQjiRD2CP4e8Jm0y88qieqb+Vnzkj5/PHoMKnntJb9AzdNs9HMr
         1xD2AQaYSLoA1SevFB4UX1utqzRy2z3kfon02ij4DU7CZNGaX/nZybYaOUUC5bcHw9+o
         S3SjzzW7SqbAhZXEqYqcn4U+c0WJKBIjtoZ9OoR6PZrHtklOi/uvs10Mz0anAmm5hctv
         qaXH/2oV4dyQlEmFayBCRftomvnUxIhjB4oXzh3cZsg/B/BJBc2APal/OJoFvxjR49E+
         +VhrFq1PhpWHhXUApAmrE7+OLXuQ+sUS3Q2sAS8zjfBH92GkwGaFPtRJfz23PuBUhvLB
         J6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331392; x=1773936192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKfhHHHxcHNtHeFXvVtQ4riJbH3ZtNiRh2K53JPW2kk=;
        b=B/AUOQT4mzJlnUmCzzR8U/FX4qp/EpGGl8lKfjYw6Q18XrNh0kA4vMa7uaQji+PsoB
         HrPIiIW6Bm6DhMLu1iLLxYX2rVHnBq+I33FEMBlB62rc6EfPpXT016PpGESl6nu7Pd3x
         gaZ/o0CTjSHqLkHzIdLY5EQCq/+Y1YbMl4O5D1ov80ZdJmQKo2erImQhdmpmRayIHBvW
         SpNwIYqLuO/YpWsg8vQnr2JlMmrq6sI3f+z/mwzfp8ZHRwG8eDkBvjinXiWgqUaqHQiD
         7hFVzKA92wo39sPraoK/swY+Yfpefng+Z6evb9EroGbKtcIGAEsBXkxkSA336dDfiNmy
         WZDg==
X-Forwarded-Encrypted: i=1; AJvYcCXHYhYfAyQO7fAuQBslQRDxUVS0YKTwCjUKu6FofEoP9yOe3Bj6haG3MUThzmLDLeHXNho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7DzX7keKihGuA1M2r8k463V7S9rLNFFC8R4eKxD9parMICtcW
	fyGSd3u2nMrzhi2Mkljpq7kvBAT1S5VLIcQU4bkBD3pyXXmTXZhnb6AXN92yFOtfzIomA08fsoV
	ih2ZweA==
X-Received: from pgkg10.prod.google.com ([2002:a63:fa4a:0:b0:c73:cc95:c0e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2e14:b0:398:9ea8:9454
 with SMTP id adf61e73a8af0-398c617eedbmr6087154637.71.1773331391841; Thu, 12
 Mar 2026 09:03:11 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:03:10 -0700
In-Reply-To: <08c7e1fa-c78f-4c6b-b2cb-baf7233e681d@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com> <08c7e1fa-c78f-4c6b-b2cb-baf7233e681d@fortanix.com>
Message-ID: <abLjvqaamIedrbMg@google.com>
Subject: Re: [PATCH 00/21] Fixes and lock cleanup+hardening
From: Sean Christopherson <seanjc@google.com>
To: Jethro Beekman <jethro@fortanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Jethro Beekman wrote:
> On 2026-03-11 00:48, Sean Christopherson wrote:
> > Fix several fatal SEV bugs, then clean up the SEV+ APIs to either document
> > that they are safe to query outside of kvm->lock, or to use lockdep-protected
> > version.  The sev_mem_enc_register_region() goof is at least the second bug
> > we've had related to checking for an SEV guest outside of kvm->lock, and in
> > general it's nearly impossible to just "eyeball" the safety of KVM's usage.
> > 
> > I included Carlos' guard() cleanups here to avoid annoying conflicts (well,
> > to solve them now instead of when applying).
> 
> I wrote a bunch of tests (see below) to check the kernel can properly handle bad userspace flows. I haven't had the chance to test them with your patch set.
> 
> test_vcpu_hotplug() triggers dump_vmcb()

FWIW, this is a non-issue, especially since SEV-ES+ guests can effectively fuzz
the VMSA at will.
