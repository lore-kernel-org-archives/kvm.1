Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6647A0A9
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149687; cv=none; b=e4xXZ7lcYwafjaQV6j8tShTi1+axPmnzw5ZUq9fPM5DkNt0D4u4e2LiKwQTl3pe8x0PfLalkomN8xLpLmsIvyixpBjfkX/2yc1rVvfl1slsZY7Hzq3TCtvx8VrPQkz7oQP1Cm324wS/H7Vs3sx1ZroByfzQU8O1Y9pXC0GUvV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149687; c=relaxed/simple;
	bh=HeVS9XsCAoIM35TlkEqB62UzYjPlpdl4VrCCpvJjbC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ph9InSqgBEmKy8PrwpMkc4s7YupMBWi+k3HGUTbSKrZjylA8eK8MGptCGc9BlG/LGXaki0SYq1TS3WPguvBE3lzBRbFVvZ/8IavUleODTgrvXOrDAThoLGaqNTuRZ7qaH5mbZgVkTHvwf5okP+/4+BlMtcQVRkPPC/9LrFF8H2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1dEBH1V; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1dEBH1V"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf6acd760cso13471085ad.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787149671; x=1787754471; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVWozadQO7xAVs0CxEChlrBPcTWGOFFwMoQqLAdxyTc=;
        b=i1dEBH1Vu2tmvfiGgKfbaMRuuG4hnJzAX7c/OBC6zh9r/PLZYit3NqaMcuhn/ZkpQ3
         PM+MfVSrmQOZw5ugXRok23WkxBCooOsRJphHrMnEa9AYiR7C4610zhZiekDZ6ad63CcI
         Mp2EbpkcvI4xYcLM9mgY/i0PwzN4Uq/D/GnaoRdA7LhW56GzNnA7gBE2kER19CNlMEGP
         U6kQKvGX4OqxXfady66TOU2CD8OVsB+9bgAij/2Y7iyiCmhWBwHeNqSRhJ2II6Xs753h
         IcAkLe2a6S6QNtSJ1uJPWZc8YEeoGBcNMF22IhOpVTA0l2MrZp2N1XH/IdzlMxr8AEBM
         godQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149671; x=1787754471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVWozadQO7xAVs0CxEChlrBPcTWGOFFwMoQqLAdxyTc=;
        b=iqNTe7tNGGXP2MfD+qbzOaKHUpwaE6QtyFREebLrLT/kldqQbSJSccnA/JDciB7qyb
         ZAxn3m8coT3d1uYeoEd8NPhc2iG/6fYzQv9WTpSY/PrQjHsYlMTYkBKP5DdpNCT6VOSw
         lgs79ddnNaaNTdwEluyu/l1FPQAvqGPYf1IuVPudbeRNCI/7wTiEqF0aeBqh7Io2q2us
         4dPGOBriH6WhzepOUeB+d0uO0G6f9+5lwvQIkcQwUpXuFA/NdSjMYYqZdD7yLGiBUDrk
         sPiUREqSxMlqdI9x68Gb9m5XAsHg5sT6a6U9mwIdlKybx6myvuqnLb9OHBEFeqz5iNRe
         o80w==
X-Forwarded-Encrypted: i=1; AHgh+RpsFxa5BmW4LnCJkEnsONzSgOcZgC949vZKKWyVZcVxQC4DC9yaTBcXckXJvwKfqpWyMKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2mk+zIhkGdzkosPSasOhAqHwa7V6AhozILPobQrJ1SdiJIXY
	tDSvqWouPTBQ9mqnmNEM4saRROHjJ+XC8J9qHu9gRc+Xevtbk79jlGIlhlfz08JMreDxyNM0fAO
	IWE5n+w==
X-Received: from plos6.prod.google.com ([2002:a17:903:1ac6:b0:2ca:ddbd:a19c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f792:b0:2d3:6fac:d67c
 with SMTP id d9443c01a7336-2d5ff7c849dmr91033865ad.10.1787149671281; Wed, 19
 Aug 2026 07:27:51 -0700 (PDT)
Date: Wed, 19 Aug 2026 07:27:50 -0700
In-Reply-To: <7c368424-80f9-4491-8578-d26ccc7dc835@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <807b4b9f-b1ca-4b5c-bc9e-22bf0637ba33@kernel.org> <aoS4wd6Dy9DlluHl@google.com>
 <7c368424-80f9-4491-8578-d26ccc7dc835@kernel.org>
Message-ID: <aoW9ZhBWucR3HApp@google.com>
Subject: Re: [PATCH v2 0/4] Stop returning struct page from guest_memfd PFN lookup
From: Sean Christopherson <seanjc@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, g@google.com
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, David Hildenbrand (Arm) wrote:
> On 8/18/26 21:55, Sean Christopherson wrote:
> > On Tue, Aug 18, 2026, David Hildenbrand (Arm) wrote:
> >> On 8/18/26 11:15, Ackerley Tng wrote:
> >>> KVM currently expects kvm_gmem_get_pfn() to return a refcounted struct
> >>> page. Callers (such as x86 TDP MMU, arm64 Stage-2 fault handler, and SEV-SNP
> >>> VMSA / RMP handlers) hold this refcount across page fault handling.
> >>>
> >>> Holding a page refcount across fault handling is problematic for guest_memfd.
> >>> In-place memory conversions between confidential computing shared and private
> >>> states inspect folio refcounts to ensure exclusive ownership by guest_memfd.  A
> >>> concurrent guest page fault taking a reference on the folio causes conversions
> >>> to fail due to an elevated refcount.
> >>
> >> Right. Won't we still, at least temporarily, grab a reference while looking up
> >> the folio in the page cache, or will we be preventing that concurrent race with
> >> locking?
> > 
> > The latter.  What I want to aim for is that if the relevant guest_memfd range
> > has never been mmap()'d and there are no memory failures, then conversion is
> > guaranteed to not fail due to elevated refcounts.
> > 
> > Or to put it a different way, I want KVM's ABI to be that pausing vCPU is *NOT*
> > required to perform an in-place conversion.
> 
> Having the VM access a page that is currently under conversion (triggered by the
> VM) should not be the common case, no? Except, prefaulting, of course.

"not be the common case" is likely an understatement.  In practice, I don't it
will happen outside of guest bugs and KVM testcases.

It's the testcases that I want to "unblock" though.  If we commit to never having
to pause vCPUs, even if the guest is misbehaving, then that gives us deterministic
behavior we can validate, i.e. a way to detect similar regressions in the future.

I don't expect any regressions would be super problematic, but being able to treat
any failed conversion as a KVM bug (for the curated setup) mitigates the risk of
death by a thousand cuts, i.e. reduces the risk of gradually degrading conversion
performance because more and more transient references being taken by KVM.
