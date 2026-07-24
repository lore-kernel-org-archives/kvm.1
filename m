Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F9326D44
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915230; cv=pass; b=avnxHzmFtD49n0dHEgu2mHOrHcDclU1M9XeFfeedwTpQaDxHKM/yErp11t6tnAYOJtQJTk4nLDhA3+q9uyw7jZpMeKGnrp/2ae8gHH2c2J7muqsYTCy4KJQnoW26WAXTEPesjtFIgDFllreF6wP13Fd+t/v5e9pfDxGtXfViopo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915230; c=relaxed/simple;
	bh=FVjpkpjbK/QlTtu6faUlrgXcvJ5NpyHhCn1dRJ+TWNo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM9LTGyBXUs0Z7kn7EmMLr8zuycROk+2oBaOrYu2PlbYWapVnZknnu0oGCie78tVJYs5FBV2LpMvMvDMGhXScU1uIi99oP7N+8crC/XrzMRiPQRh73y/c57rCkt12gODaGoJxAIaRrsGW1EEb7qlwXsA3S3Llnzg5/s1Qi8FvBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNYdWr1R; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNYdWr1R"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so94595766b.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784915227; cv=none;
        d=google.com; s=arc-20260327;
        b=qSDfNgBSu27l6M6ZLZ28OHmLFLAxT7cMV/fRfncoFyeFoBBAeu90B1uc+wRw9165ny
         u2nRpcrtIJ4bXX+1OAh44V7aRVFivimqrE7XngVoK1RAs8dT6ZZ1X9M8YfyxTunQgYBs
         JK9aWPd5krqmED8IYNy40MMbK23yAcFEiBm0bv7h4vMpVaCANjihvjd8kkSpblqjZ0tF
         hluJZVHLaAmg3p2ohQIPRF2m1JcxQSzTB0UoQ4wUs97rcHIvJjJj/aAW0q+jzKpFPHjl
         wIRja0PZAQKLnK+HKcWy+wFwsqEusGw1JODr0vx3cREiOxRzX/tG+6/YqpKLc/wFPY+I
         ywnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ll94BS9gDG4MYSaKiX6tUGubsdhXDXOt0DHIZFvQC2k=;
        fh=LA1/a+onor8vtV1Cp2uBvavFFoFpKQ/WubYEQ1WiESs=;
        b=SEluGBWccR6Tartodu+UDMw/xrV7Og/ysd8Kuc1Co7uHQdie6ZbbeHO/+Jk6Dxejwi
         t9dFE7S6mC5ejlOrFEIxIdN+/CMV5HFHWBfDPeAgzoJKtd2ciHmi+KVOgZ9dNDfczavR
         r5QYnygFFNNEcYtoNh4OD/pF5Dof4il0C/IxuGpL7IcIhRS7sdXDpCY0cu3Ge22v0A3z
         FI4vrUQ3CVAHMNG+94lUxiIfuqIYY/MGSb2X3123GSXC7U9Lb5hmCjVRYUn/PkHkcW3V
         UKm8GOjM6msODJnVPpuZOQPoN3YjMMB9MFLzfzidGxsXKv0Q8XisTetEuVaqH3WaWLco
         udWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784915227; x=1785520027; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ll94BS9gDG4MYSaKiX6tUGubsdhXDXOt0DHIZFvQC2k=;
        b=GNYdWr1RfkoeZ5mSJB2efdV9IYgTeIWCuAI/4GX7v90lfze14CGohJiowZ6Ppw5luT
         J80HV8LCGZrdXSuk8Nkw6NU9plqEvrs2BHK21WEr3WoZ/bVjx9Y/lb4aNA3nLcpf+PSG
         P3gJbEwUwayQv3ZYx0dpLO/KrADQonc9bte17khwz98DxA8xjH81oZyHs3xzr6GUfTov
         GUNCzZDN+rPMl24VVtdLZv38wxrQMUioz8BOM/plSHEir6q5R9pcvSVs+c37wwhhx8ub
         duBCtSklV4GnP3g9TgNOKS+JccGxwyOT2PrlMUK8gc6TXn69RyV5PW329Mqw/KPz9O9d
         XMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915227; x=1785520027;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ll94BS9gDG4MYSaKiX6tUGubsdhXDXOt0DHIZFvQC2k=;
        b=IkW0Wn/y/V8l0JbMbN5nCckdylGyY7Yl77Fhfdw+PSvoydnQM7VnSjiJBxk0SnUWDo
         cfSn72AlWJGmTw/kv7yfm6iwSfUa9Qp9zC77L4TKVV+YKUfqE0wgKo6cK+lgREjFAJ6h
         kzEZ65lryWTTa0T21RCiF4Z8ekfMY8mvRp8BD537UfAzSpAECGqaXbS9w+bmN9UMZR6e
         +ivsTprETeA8M/Rk5NmdpS1HN7fVdcFTIXPrnIMCsuIgB9z2VTVh1PsG7f8dzYUD6Ygy
         oqx7lLhp4Gn6qr73CWyk3ipt8nAYzamevyQmIEeoNYFA3/Sr7/vh0KNQQRL9b35zxKox
         HQOA==
X-Forwarded-Encrypted: i=1; AHgh+RrTDJwSjloAcCtble7cx1RQxiaqTLlBCXV1oJzXmteqZMTJm18yRpw3enPPp2QLvAJkBeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytuSIBR395eJY5nLIqF3+fi1eKTyWFYul7x9vnM44gCpZ5CVxl
	IObeObuw9qnEyW0SaCFHNBz8H1M6XgO4/Yfu//GObAHkkxsv8x9O0RI/JZKrAD+SJfTVOfoPRdw
	FNGYgM71GadFVvoyNUs+PxIouCqCr6KpDral9PfrCyDgMOt5emI2G83tV
X-Gm-Gg: AR+sD12Jfx4hNugq5qXOD1uD19XtnZEPBCZ82Hdz6DLVhgfLtsUIIM+8mch3r12SBbs
	rPLOTW+HUWIWawXE8cPHtREGH9Xfj7H6cSvf8rk9ZdTXE0+AzJ+ucWLHHoYEEvIvlzJA/CJyu5J
	BStuolZaxaljfKcGzrIT1xf/f0xYb5z8zFKS02KgjapXZwrl7KuWxhWwav48+ZKscvYc1+LH+Qz
	50ffNtXmdT8hk5Hw64lIHGHUxCfrIcxSfR+B0ZwfJFzNEp681RRv1qC5RPySrB0/es0I5nm5a8x
	M/X6Z+mKAiLZh5gwyqIGqiVNo4IFz/d9k0xep10+Fxg/WXmR
X-Received: by 2002:a17:907:9346:b0:c1f:1612:d3cb with SMTP id
 a640c23a62f3a-c1f1612edd9mr49687266b.33.1784915226809; Fri, 24 Jul 2026
 10:47:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 10:47:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 10:47:04 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amLLoRkCCaK1EHuM@yzhao56-desk.sh.intel.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-19-seanjc@google.com>
 <alc8Vi9yNIFR/yGE@yzhao56-desk.sh.intel.com> <al_BAjCNRQUvuX2c@google.com>
 <amAoijqis2Gn/K2Z@yzhao56-desk.sh.intel.com> <amJhzgyQMVNVD1S3@google.com> <amLLoRkCCaK1EHuM@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 10:47:04 -0700
X-Gm-Features: AUfX_mzWYufbEplzuyXOuyiC_uLww3xAiiO34PtU3OwH5vTmt4babx0J-pTz3vs
Message-ID: <CAEvNRgGhzjA07-0jwJNLbg6tBN9EJYXpSeGJsfBvs8Hc1Sv3GA@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
To: Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Thu, Jul 23, 2026 at 11:47:42AM -0700, Sean Christopherson wrote:
>> On Wed, Jul 22, 2026, Yan Zhao wrote:
>> > On Tue, Jul 21, 2026 at 11:57:06AM -0700, Sean Christopherson wrote:
>> > > > Asking this also because there is a .gmem_convert() for TDX huge pages [1].
>> > > > In [1], .gmem_convert() is invoked to emulate a to-shared conversion in
>> > > > kvm_gmem_punch_hole(). However, the per-gmem memory attribute for the range to
>> > > > convert may not be shared after the punch hole. Is it acceptable?
>> > > > (To me, the .gmem_convert() in [1] behaves more like .gmem_prezap()).
>> > >
>> > > Ya, these concerns got raised by others.  pKVM on arm64 in particular wants to
>> > > hook reclaim but not conversion.  The plan is to keep the reclaim and end up with
>> > > this implementation for x86:
>> > >
>> > > 	#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> > > 	int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> > > 				kvm_pfn_t nr_pages, int max_order)
>> > > 	{
>> > > 		return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages, max_order);
>> > > 	}
>> > > 	int kvm_arch_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order,
>> > > 				bool to_private)
>> > > 	{
>> > > 		kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
>> > > 		return 0;
>> > > 	}
>> > For TDX huge pages, if we want to trigger private huge page splitting before
>> > converting to shared, should we invoke the hooks like this?
>> >
>> > __kvm_gmem_set_attributes(to shared)
>> > 	|->kvm_arch_gmem_make_shared
>> > 		|->kvm_x86_call(gmem_make_shared)(pfn, nr_pages, max_order);
>> >
>> > But TDX needs kvm pointer, and splitting pages may fail.
>>
>> Ya, but those are very solvable problems.  They just don't need to be addressed
>> today, because SNP is the only user of the conversion APIs.
> Ok. I'm ok with the change for today's usages. My concern is regarding future
> TDX huge page support, as I am currently preparing TDX huge page v4. :)
>
> Sorry for the confusion -- I should have stated my intention more clearly.
>
> Previously, for TDX huge pages, you suggested introducing .gmem_convert() to
> trigger splitting before zapping S-EPT.
> With this new direction, should TDX huge pages instead leverage the
> .gmem_make_shared() op for that purpose?
>
> If so, should we introduce a CONFIG_HAVE_KVM_ARCH_GMEM_PREZAP guard around the
> .gmem_make_shared() invocation to serve TDX's splitting purpose, in order to
> keep the two use cases (SNP and TDX) clearly separated?
>

Another thing we need to figure out is the ordering... You mentioned
that the S-EPT splitting can fail, and I remember you were suggesting
that we merge the S-EPTs back on error, something like that?

We'd have to figure out either a point-of-no-return, or some rollback
mechanism anyway, so that kind of depends on conversions and the
guest_memfd hugepage series. Probably good to defer this discussion to
later, when we have more certainty of how it looks like. :)

>>
>> [...snip...]
>>
