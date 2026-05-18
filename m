Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19A48C8DF
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114563; cv=none; b=cu6VCtgzjfyYAbgj6kkcTXcH5iIvQhu15e474pRzCl3zMCkD3Q5ArIy8EgE3bvhirIFJBTSeNw51aZsL5eRVeU4LTz5Jiiv/DYypA7Q/+MFuaH0X+3czyyPtSbyjo9ahvQXVlXpJ7hdzAuqkS0ebjJWb9/Z8MFGcN9RFA+rnk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114563; c=relaxed/simple;
	bh=uQxUt9aTdAUFES/ufe+2hLvK/7DjWdNptJkdNT7/DW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g9XQP2xzUKC5TPLffetwXc0ZD3BzvRYCQjig9VtpiRYFcsXcxobaoYQSs+2mjUph+HKiq8+Wcn4zmPgSwP4JQQjwABWct0KPQYTKEld2P76ywVOF0TMq3UX9oF2XDbgANy2ORXGb2NUfeS8eCVbAQAjk6jGGE8kFGfB5kuEY7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eupZewte; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eupZewte"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828ab3b033so3290228a12.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779114561; x=1779719361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymuC28dYrYts/hTf1mXmoAxJXflD/PyX4wqZqcbMCVU=;
        b=eupZewteVioDwMAsTK+3cM/EPLZ+ImkadY97UI24/TSkL42qoDKtGQAd2q9cAuPPAw
         ImnUVfp5MohocTz+P8OtuCBD5lwECdBR2ND/b3GiEyVmKlQpfZaswJwkbQIGjFLiSeeg
         AYy51B169i9NTnVn+01JHFLQYWrhgMLBAAJ3OSfNHpt6/mX8VWHvl9ICfMfR31vf7mUB
         GexObYqndfjB8uUOmP+ZmdaFUm4e+lCy+GItdUwkGlL4qwtlWGYHeYATLOG2dnIOHKDD
         7Pro0KvlsVVRiJ5SPj+9/hmnRl5jhdQixNVIHiPEgiNnWxlzZq5dzIMxe5n7I3xbKNbd
         dWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114561; x=1779719361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymuC28dYrYts/hTf1mXmoAxJXflD/PyX4wqZqcbMCVU=;
        b=F//ojpJEvedD4WruMe6kajh99Q5ATMh8e8UyqsvZdNK6GqHtxAKhgj9cbOrjoX05Xv
         6TqCzQI528qlZsM/KiAUbH/o2V9Eip8cx5eB7FInJtY7N36ElE+Ji6BRznZZWNCdovVm
         ioC3wz6EZ2tVDPYmmeh41NTY4zIfKNAv8sAmR52On0zkd0IiogSjxtY7+P8rjS6GSgtj
         +Omjdd/zguWTODRHlIqB3JfHLrzjXHAxTkimVzyU77NaXkhvuCfK9WyuYN7PElX05LH8
         SCVw2B9iZK1y2r7uNK8T9+45r6O1nQHK+OvPkAFbUKDOguDAVym1gnygYu2/TbsZuMaW
         hXyg==
X-Forwarded-Encrypted: i=1; AFNElJ82GRjex9IHZjTBZFOKCFgb62HS8yCaJ8jNcD7zw1cetgDRj0sgFhxk8YCGBxmfmc5fSWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRTEdrKbJoXKAfsp46erxcLf+Knxx510JBU8rIH02bm8+7sSc
	WEORIKB6YLrTIb80jOM0ZL33iZxRnaxaGXkDTa3sQH869OluXMjyM5Sux6RQpsCtzfvdGfFrUo8
	jw96GcA==
X-Received: from pgjm24.prod.google.com ([2002:a63:fd58:0:b0:c82:bdf7:482a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:39c:4e62:b838
 with SMTP id adf61e73a8af0-3b22e829a63mr17058789637.17.1779114560795; Mon, 18
 May 2026 07:29:20 -0700 (PDT)
Date: Mon, 18 May 2026 07:29:20 -0700
In-Reply-To: <bf569f46-8690-4f82-a2a0-d196970880de@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <50ccbe42-4b74-4c2a-b530-a367f7285de6@intel.com> <bf569f46-8690-4f82-a2a0-d196970880de@linux.intel.com>
Message-ID: <agsiQGikhZA0CGTY@google.com>
Subject: Re: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID verification
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, chao.gao@intel.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 18, 2026, Binbin Wu wrote:
> On 5/15/2026 4:08 PM, Xiaoyao Li wrote:
> > On 4/17/2026 3:35 PM, Binbin Wu wrote:
> >> Hi,
> >>
> >> This RFC series is to allow public capture of feedback from TDX
> >> developers before we have too much internal conversations on it and to
> >> initiate code review of Sashiko. It is not yet intended for review by
> >> KVM maintainers. Sean and Paolo, please feel free to ignore this version.
> >>
> >> Originally, we had issues on TDX when a new hardware feature, which is a
> >> host state clobbering feature, is supported by new TDX modules/platforms.
> >> A host state clobbering feature requires KVM to save and restore the
> >> feature's related MSR(s) on host/guest transitions; otherwise, if the
> >> feature is used by TDs, the host state will be corrupted, leading to
> >> unexpected behavior on the host.
> >>
> >> Currently KVM hardcodes a deny list for unsupported host clobbering
> >> features for TDX, i.e. HLE, RTM and WAITPKG. However, KVM can't keep a
> >> list of bits that it may not know about (e.g. the upcoming FRED support
> >> in TDX).
> >>
> >> We had been working internally to propose a TDX specific solution to
> >> solve the host state clobbering feature issue. But during a PUCK meeting,
> >> Sean mentioned that KVM had a more permissive CPUID configuration
> >> interface than desired and there were problems due to it in the past for
> >> normal VMs as well. 
> > 
> > It will be better if some detailed example of problems on normal VMs can be
> > provided.
> 
> Sean mentioned it in PUCK meeting that google internally had some issues before,
> but he didn't tell the details.

For far too long, our VMM didn't sanity check the vCPU model being presented to
the guest against KVM_GET_SUPPORTED_CPUID2.  That's what I'm envisioning for KVM:
something akin to QEMU's default behavior, where QEMU refuses to create a VM if
the user enables unsupported features, unless the users also enables the "let me
shoot myself in the foot" flag.

> >> Sean suggested that KVM should introduce a more
> >> paranoid mode to check CPUID from userspace for VMs in general, as well
> >> as an opt-in interface for userspace. And TDX should use the
> >> infrastructure to enforce paranoid mode non-optionally.
> >>
> >> This RFC patch series adds a paranoid CPUID verification mode for KVM on>
> >> x86, where KVM must be explicitly aware of every CPUID feature exposed to
> >> the guest. When the CPUID paranoid mode is opted-in by userspace or
> >> enforced, KVM will reject any unknown or unsupported feature from
> >> userspace. And it starts to enforce paranoid CPUID verification for TDX.
> > 
> > Regarding the opt-in interface (for normal VMs), I want to know what the
> > benefit it brings for normal VMs when it's opted-in.

More or less the same benefits QEMU's default behavior provides.  Whether or not
the value added, relative to what userspace can/does do, is worth the complexity?
Dunno.  I haven't looked through the series, but this:

  15 files changed, 1298 insertions(+), 525 deletions(-)

definitely gives me pause.

> > If it can make the host more robust or prevent potential attack from
> > malicious userspace + guest, then it should certainly be forced on instead
> > of userspace to opt-in.
> > 
> > If no good benefit, I doubt any userspace will opt it in. E.g, I can see
> > one benefit without the paranoid mode: Userspace can expose the new simple
> > x86 Instruction to guest before KVM supports it by adding one line of
> > F(xxx) in kvm_initialize_cpu_caps()
> > 
> 
> As Rick replied, Sean thought for normal VMs, it could be opted-in to do debug
> or even make it enabled by default.

I doubt we'll ever enabled it by default.  I can see us providing a module param,
so that a deployment can effectively enable it by default, but truly enabling it
by default in KVM will likely never happen.
