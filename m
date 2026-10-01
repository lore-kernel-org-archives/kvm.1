Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009D44E64A
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896312; cv=none; b=AnTgvtJLFLGyxgAeQloBC6yMTSvXsrKwMtniGM+/Z8oUfts+itkgD40Ah/C+nXBCyOxr0V7e3IGdYKUU/1p0PHpQv+fV+yEs9rtV6sdl4YaViNYuARUWhDmwhyDhJ+zsJOCUGobg89TwAhSHU1EGEtH0qk597AVz5iVBBE4pNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896312; c=relaxed/simple;
	bh=TNhmvhGlub+ZzKwtl8RxUpuyaJEUSEHmWLF0hGRFojA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=knpKA2X2z80DtH/2VtPI9Uk0UpAdDT34syAEbKo9h3vF+NyOJHSwRuaUr2OplyW6HhuRVkNiEf6qvB6KCAB8yLTLzt8ug7OhdC044kSnSktyv7qkMOQ92wglsCfZHs/E+LKLL59YvR44qOQczkwT0zmxdSBXnqIjPW0evJ8DS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kOx4PSSx; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kOx4PSSx"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so60661645ad.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 16:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790896310; x=1791501110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jnyEHhlGxvnuoA1nvmtdC29EmxOTtThmrSlZkBmHAw=;
        b=kOx4PSSxJrDKclu38Of1lHUNKmXAZrVmXEggUkkdNSq+6VrWBkzO66qmQbBao1LgR0
         cT+pPfnqZQFdkv2RSEBfVthzKn4zdyNKIWhGQJw21goMderkeVv+KKMcqt/4yVylr9lm
         eSzWZlWD5J8DX6tywI1OEOe0kgPNBOr8753Ao80AcBOgH+nlW7AHLecz/6P8kQ1Ujtfc
         JXhCzmuLYtxdFtByLKpGaSR7JFt+xmFXtAH8YcN57GwxN8tMA8qTj6fg48W14LXeCr5s
         WBxSBo7D5qgO6dOVXHi7Z305u6f2C1pw8d9s2A0Ppd47EmHWtTXGHXhxDU64ml8VrsRt
         A2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790896310; x=1791501110;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jnyEHhlGxvnuoA1nvmtdC29EmxOTtThmrSlZkBmHAw=;
        b=LBGvnLsrFXfabHqowJwuK4k6J7IwiEAuBJ2okuSSOqm47r5lRC/egyywM36BZc1OTW
         xLiHMOfeMh6HAMDAs1Z2X4Dqvtf17mhc6V67E6vqWC4WVgkuCZWahNbYoQOC6oNB/ct7
         3WT8JlmnrhJU1jSqwv/aPxMQXVY1jRHLb7fLaaGR4A8ZUmH18ON/EK074UvMKhw9YZUO
         AZ3oGjK46h5eu2X2p6ieczRQ5dxsKtQS4PiBLOxN7gXgrwwh0K8uMa5lSU1SPMjk6fDw
         9mLYRyXFL5i4UN7OtGUDBTpzwofE9zx2D35LK6g3ehnG0K7qA7ZSRtro4JeGFTRbSaVJ
         mlqw==
X-Forwarded-Encrypted: i=1; AKwUvByXGa9BmP9PZN68OEDSEd0/ZDJcXGbzX+2fYNPtXSov9pZ9mWi/VqkvpARCgG1Hqn/U9NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJ+kkq6tiYiAF+QqYGcJAzJv32Bxy7ibJDj649kNb3sOucVYtB
	faPbvtxrhfhvGQ43SQpxUkEnJZ6lQpfVnUWRSgBl49MuINj8zGAwFebZehV+LpxqnuWaNH12iZ6
	jS+OkWg==
X-Received: from ploc3.prod.google.com ([2002:a17:902:8483:b0:2e1:2697:3947])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c4:b0:2dd:ad73:5b6b
 with SMTP id d9443c01a7336-2e49b6808f6mr7876695ad.27.1790896309991; Thu, 01
 Oct 2026 16:11:49 -0700 (PDT)
Date: Thu, 1 Oct 2026 16:11:49 -0700
In-Reply-To: <e905df55-6d91-40f1-8761-6bcf600d8b7e@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721050600.87268-1-shivansh.dhiman@amd.com>
 <arazNV7Y93gnflU2@google.com> <arb9YBIW8C5KXuXK@google.com> <e905df55-6d91-40f1-8761-6bcf600d8b7e@amd.com>
Message-ID: <ar7otaTgi8SYLUfF@google.com>
Subject: Re: [PATCH v4 0/5] KVM: SVM: Add Bus Lock Detect support and refactor LBRV
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	kvm@vger.kernel.org, x86@kernel.org, yosry@kernel.org, jmattson@google.com, 
	thomas.lendacky@amd.com, nikunj.dadhania@amd.com, ravi.bangoria@amd.com, 
	santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, Shivansh Dhiman wrote:
> On 26-09-26 04:31, Sean Christopherson wrote:
> (2) BLCKDB=0: DR6.BLD=0 is lost
> 
> 	/* KUT test continued from above */
> 	write_dr6(0xffff07f0);		/* DR6.BLD=0 */
> 	wrmsr(DEBUGCTL, 0);
> 	cpuid(0);			/* unrelated #VMEXIT */
> 	read_dr6();			/* -> ffff0ff0 */
> 
>   #VMEXIT: exit_code=26, vmcb dr6=ffff0ff0
>   VMRUN:   vmcb dr6=ffff07f0, dbgctl=0, v_lbr=0
>   #VMEXIT: exit_code=7b, vmcb dr6=ffff07f0
> 
> KVM loads BLD=0, yet the guest reads BLD=1, so KVM isn't the one setting it.
> The VMCB still shows BLD=0 at the next #VMEXIT, though.

Yep.  This is why I view this as a hardware/ucode flaw.

> I wanted to understand the practical side better, since I may well be missing
> something. My reading of APM 13.1.3.6 is that the processor clears DR6.BLD
> only for a bus lock #DB (so only while BLCKDB=1), and that system software
> then sets it back to 1 before returning to the interrupted task. I'm not
> sure if any software is intended to work by clearing DR6.BLD themselves.

It has to, because that's effectively what VMRUN does by loading DR6.  It's not
as straightforward as MOV DR6 (obviously), but for all intents and purposes it's
still a software write.

> Are there any flows where a guest can end up with DR6.BLD=0 and BLCKDB=0? That
> would help me understand where this bites.

In practice, I doubt it will be problematic.  But it's not completely absurd that
software might do something like temporarily disable DEBUGCTL.BUS_LOCK at the
start of its #DB handler, before reading DR6.  That would work on bare metal and
*usually* work in a VM, but would cause the guest to "miss" a Bus Lock #DB if a
#VMEXIT hit between disabling DEBUGCTL.BUS_LOCK and reading DR6.
