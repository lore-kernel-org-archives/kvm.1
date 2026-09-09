Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1A48EC66
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992980; cv=none; b=ruwXBZbRyK+HYR9wz4hr6Ox+djaGRmyEMzbPaa3IdmrxG6LMnK/iGdUXhCpePXI2UFvGc6RTGy7p7t4gzK9WlmVMybq1As/HbOpvzVnmx/IR880l+OArzg5iCwH/RqUpfxKTv3JnI49bvTZvOMKE0nwv4E3esa0V6R3ZNvU+DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992980; c=relaxed/simple;
	bh=ZV6Mh6j+3Oal9AupKdhwuwolXUKq6vHqqrWhfLQuh5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=imle1vEWeXzLypNMmuZf12oxgNzGr++3YWnGya+9ho/08usKK0rkBnvMOnbbGBV4/0xyqEh6Sof+I8GeNInXYTYvJXFJ5w+XbiSRP/IoDb39iRRv9B/h0IBvGAaQXs5QnFtLkweMvzSrhV5YrfosnB03lyhiAK71oOK/acDBa4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2zOvSa7; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2zOvSa7"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so8529255a91.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788992964; x=1789597764; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eyMhrUmuo9vm1PIzya+RISiwkOlHJHTI6TE5UtYn+g=;
        b=p2zOvSa7qBa4M94Uy8LuMIGgeCmqcNZhmZbXhgpyMkzSoVkDYajtZUbmWQmAESH40N
         oqAQiCrSHDQG4zn1SwDGhj/U34rkZIJ5BoVK6nocdKLl4HwOwDn6ahYXi8++9QoXXBlK
         Bzjek9nqoG4E5oC7Ub2z0pkayWmky4k8NiqbmYOGzeg2+cZef6JkON0ajv7uKMvcTKRG
         fbjfcaQhvHqHFxP0m7I7D7luMtvM/wyNjoojg4G880WieXSh4Nusps6xMmJH0n6qpEeh
         9iTLYHWhZq3mJEfiKYPqrji9P+dhWafG31hfYn0b673Jcbx9kHqXzMKOOpj3phBVJ6YT
         FOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992964; x=1789597764;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7eyMhrUmuo9vm1PIzya+RISiwkOlHJHTI6TE5UtYn+g=;
        b=EhsCXUMGZhMy5LBkalG59co46hNyT7cZEyNKk9lJWb3sVbjyF3m90SVGjcgeQ4stNd
         OX61o+WALaP/ZxaXhrgyianMVH2FwA49vlxYyRz4fhTHheYSwfEl28HGDiyQqG2cDzNu
         OUG8TxZ9cUJAmTXawt1E6QnvAJVJytqISDIGAwMNvBtG9ytbWLatC7af3zqikiqPDMdN
         bvhaA3FUP7xQO//eKef5BXiPPrlAUNSB/eTz5ucIiJTbAbA0fgae9Zz6R31vvf1GXt44
         azFg49dXti5uKTY4V/EICy55OkVuHj3CArCfyLY/6BAW6EYJCIxoxJ+UKnYm0KaYulYo
         cwmg==
X-Forwarded-Encrypted: i=1; AKwUvBwydAgqpb3GzNJHxBjid0stogEWs4hsGe+wf8yh/rzxTyQGUX25qOZPCX3IqWYRuGWzRT8=@vger.kernel.org
X-Gm-Message-State: AFuF++kUtMHmPh/zfdIo4yIDxIgqr6R3WvmPI8/MFcjcXkpeRGFxbW+3
	g71oGZaOfT1LjmdoybXti8V3biJK4poeBW6U2LAWjPXG2IeRnxg9/wgNL3XC4zbWvAHdFBtwB/w
	Wb4jrxA==
X-Received: from pjbmj18.prod.google.com ([2002:a17:90b:3692:b0:39b:a309:1626])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a88:b0:38f:efed:5448
 with SMTP id 98e67ed59e1d1-39b2619138bmr53743124a91.8.1788992963477; Wed, 09
 Sep 2026 15:29:23 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:29:22 -0700
In-Reply-To: <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-2-binbin.wu@linux.intel.com> <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com> <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com> <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com> <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
Message-ID: <aqHdwkOFVR4XoS2M@google.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by KVM
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Chao Gao <chao.gao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Xiaoyao Li wrote:
> On 9/9/2026 5:13 AM, Edgecombe, Rick P wrote:
> >>>> In the end, they might be disallowed to be configured to TDs because KVM
> >>>> doesn't allow them for VMX VMs. This is also the point I want to discuss.
> >>>> Do we really want to make such restriction that KVM cannot enable/allow a
> >>>> feature for TDs unless KVM first enables/allows it for VMX VMs? What's
> >>>> reason behind it?
> >>> Sean mentioned it that "generally speaking, KVM shouldn't allow features
> >>> that KVM doesn't support for non-TDX VMs" in
> >>> https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/
> >> For existing features, it might make some sense. But for new features, I
> >> don't think so. It defines the enabling order for new features that we must
> >> enable a feature for non-TDX VMs first and then TDs. And people might want
> >> to bypass this rule by abusing the TDX_CFG_EXTRA_F() when only one line of
> >> TDX_CFG_EXTRA_F() is enough to enable a feature for TDs but more effort
> >> required to enable it for non-TDX VMs.
> >>
> >> Maybe I miss somthing. I would like to see stronger reasons for such decision.
> > I think "generally speaking" means, it's not a hard rule.

Ya.
 
> > As for why to prefer it, I think we would normally want regulars VMs and TDs to
> > work similarly. Especially those that have some of the virtualization handled by
> > KVM. But TDX module's behavior of a feature can conform to KVM's only if KVM's
> > already exists. Take for example split lock detection. The normal VM KVM support
> > initially went through several iterations of design. Separately, TDX ended up
> > with a different solution. Imagine if we had enabled the TDX arch one, before
> > solving the general KVM problems. Then we would end up with two different
> > behaviors, or a worse KVM behavior as it tries to conform to TDX module's
> > behavior.
> > 
> > So we need to at least solve a feature at that level before deciding KVM's
> > handling of it. This could be done while enabling the feature for TDX only, but
> > often would involve solving the problems for normal VMs too. In the end, it's
> > the generic KVM behavior that needs to be solved before enabling the feature.
> > 
> > Ideally we could consider normal VM and TD at the same time. I expect we will
> > start doing that after this series is in place. Not a hard rule, but a norm.

Eh, I'm with Xiaoyao.  Yeah, *ideally* we'd magically enable everything everywhere
all at once.  In reality, different VM types are going to support features at
different times.  More importantly, as Xiaoyao points out below in #1, unless we
enable everyting in a single patch, which is probably a terrible idea in most cases,
we'll still end up with staged/progressive enabling, i.e. we still need to have
patches that selectively enable and advertise a feature only for the VM types
that actually support the feature.

This is all quite similar to Intel and AMD feature enabling being done at different
times.  The biggest difference is that Intel and AMD are mutually exclusive and
so KVM_GET_SUPPORTED_CPUID always reports the correct information, but TDX already
provides KVM_TDX_CAPABILITIES, so AFAICT we still get accurate reporting for TDX,
just in a slightly different way.

> I don't think "split lock detection" is a good example. We are discussing
> virtualizing a feature, or allowing a feature to be exposed to non-TDX and TDX
> guests. While "split lock detection" is not a virtualizable feature and how KVM
> handles it is all about how KVM fixes the architectural flaw of it.

Yep.  If there are actual decisions to be made, versus simply adhering to the
architecture, then we'll need to incorporate the needs/abilities of flavors of
VMs KVM supports.  But for feature virtualization where right vs. wrong is
dictated by hardware specs, there really isn't anything we can do in KVM to affect
the guest-visible behavior (beyond things like performance characteristics, but
those aren't ABI in any case).

> Generally, I agree with your point that we need to think at higher level before
> KVM deciding to support virtualizing a feature. But after the generic level
> consideration is done, there can be different orders:
> 
> 1. allow a feature for non-TDX VMs and TDs at same time. i.e., in one patch or
> in a single series.
> 
> 2. allow a feature for non-TDX VMs first and then TDs. This can be due to by
> that time TDX's spec for the feature has not been defined/finalized.
> 
> 3. allow a feature for TDs first and then non-TDX VMs. This can be due to it
> requires more effort/patches to support virtualizing a feature for non-TDX VMs.
> 
> Usually allowing a feature for TDs requires far less efforts than for non-TDX
> VMs, because most of the virtualization work is done by TDX module. E.g., for
> TDs, KVM usually only needs to add code to restore the host states that are not
> restored by TDX module. However for non-TDX VMs, KVM needs to do more: emulate
> the architectural behavior of the MSRs, context switch states, and the nested
> handling, etc. It's likely that a series to enable a feature for non-TDX VMs
> spends several Linux releases to finally get merged. Making TDX support depends
> on it seems not that necessary.
