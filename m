Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790493;
	b=WXtvVpn6Dz8lAb/qEeMZzDz1od5E6zsWF0qq0xig8u+9JFZ1cVwoi8J8lYsWGJ1lpGSi
	 guWFzxHH3aQ6H1oJ8JH4vPTKWqZ3LMpJamCDf0YaRa+iONHe8RO7FWR7iT69rW97BXfAU
	 LATSNwiBffUWF3ACAmGfIdJ91oORoernikvExpoCNq26oOe4uBHKL33KLCQcLQtG2xe73
	 2hwcPFslmO4jI7at/uenhza5Ue5xbUYPqJsTTbcG+XxlVCkzFV7bA1wG459vqCH6ct0+M
	 R7vBW/g424FS0oXYyIffOQa/HRLEVVjOXtAzhJjEo7kYrPpVklJx+PZOSubBgNBNb1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790493;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uPJH9rUiDiuBGBWRfMNxB+icGyCLuKc7Vf2NeFOffTk=;
	b=0dXt57pmKBevuI2U+q5n2UX9xjbIMpfuiZDvM+DZwaHMoq7qk0DXHfTQtMOQQWaKNnpa
	 bJMB0IeOJWJE3SR+dgQ2KjBXi/3RMKUOsu8RwVfctV++U7WhQZMAXLN3f9xhnFrm45K6T
	 kp2RA6alnZa48FKbBlWsfWP4M6o5WyKoK4E8+cn0SAnYPdLwI6MKXzDoni7HW403n6y5N
	 eFWzhprrw8Cn33Hnkmkfe+Jbs/kh6KY1/86/Tg3AZrH3jnt6v9mCruA8aU68SLtCc/m1X
	 Tmjfs/ReuRrEeufX3i013AgbJE39dm3ZbJxPxi5BdQDFQjmDTV6rkYptXfuAg6Aw0XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qh4Np8TW;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50E606A31A;
	Fri, 23 Oct 2026 21:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C50E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qh4Np8TW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792790492; x=1824326492;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=aG/Bdou1r9pe+8zbQRCaY4qypFhQCp0vvCHrlWqqNoc=;
  b=Qh4Np8TWIv4vVTFr5RzZidaEDPcPobEKAyyIPfo/2+WxNJy1dRWtpw/I
   kGLl33yi7CmIjPIKa2thoWLrBsIfiECLYUiLC6OEGcFgAkQ93O1AbT7fn
   G5gf1U6MqI2e4HwnGGJjNaQS/3wIooYCDoKMA4tTnNgvKZXPlFZ8WelsR
   ecrcEHb4zmx5Io3ye0UxgbhVsVrz917AU8O6QVhxei/ZqeyyYZBpiIU/9
   Ol7HT1LatBKZZWyKU0PsIjKqP3kFMtCC5FUmzQLeOnxJ1PyvV9FqnGLR0
   Nr6UEVxGUw3OSD8EuIMhzil68z3hJSCOPLPfHjSj7c0/GplpFaVq7s9mg
   A==;
X-CSE-ConnectionGUID: qgho1o5sS1mlcOSPR8Flbg==
X-CSE-MsgGUID: +C8hVPniRR2Lk556Cagz5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1560749"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1560749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 14:21:28 -0700
X-CSE-ConnectionGUID: Gv6hCAr5QASp3dkFzOplRw==
X-CSE-MsgGUID: 0vcg4BatQJqaHOyfMP8IXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3669481"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.4]) ([10.125.108.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 14:21:22 -0700
Message-ID: <5c74f231-46a7-4f37-8fcd-bff84842a923@intel.com>
Date: Fri, 23 Oct 2026 14:21:20 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Shadow Stacks Versus XFEATURE_MASK_GUEST_SUPERVISOR
To: Paolo Bonzini <pbonzini@redhat.com>,
 Yang Weijiang <weijiang.yang@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Allen <john.allen@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
 kvm@vger.kernel.org, binbin.wu@linux.intel.com,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bae, Chang Seok" <chang.seok.bae@intel.com>,
 "Mehta, Sohil" <sohil.mehta@intel.com>
References: <2f0560df-69fc-4fc1-81fa-447e289ec2df@intel.com>
 <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <bd608c7c-676a-4b65-97dd-626d0e8a5514@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/26 14:00, Paolo Bonzini wrote:
> On 10/23/26 21:03, Dave Hansen wrote:
...
> If you want to quickly work around for your !CONFIG_KVM kernel, I would do
> 
> #ifdef CONFIG_KVM
> /* Supervisor features which are enabled only in guest FPUs */
> #define XFEATURE_MASK_GUEST_SUPERVISOR  XFEATURE_MASK_CET_KERNEL
> #else
> #define XFEATURE_MASK_GUEST_SUPERVISOR  0
> #endif

Yup, that'd work for sure. Thanks!

>> Any thoughts on what we should do?
>>
>> Actually context switching XFEATURE_CET_KERNEL seems kinda silly in a
>> lot of ways. PL0_SSP can always be derived _and_ it isn't actually even
>> needed at context switch time, only when running userspace.
> 
> True but, just to understand, what is the performance like if you
> actually use XSAVES/XRSTORS to update SSP0 on context switches instead
> of WRMSR+cache?  Hopefully the microcode does a bunch of optimizations
> as well.

First, we can use WRMSRNS for this MSR, so it's faster than usual.
Second, on kernel=>kernel context switches that don't go out to
userspace, it doesn't need to be written at all. It's kinda like the
user FPU state. Third, I'm actually reusing the fred_ssp0 cache, so
further reduces the incremental cost. Fourth, it's not _really_
context-switched. There's never a need to read the register. It can
always be conjured out of thin air. It's possible to only write the
register, never read it.

I can benchmark it, but I seriously doubt that an XSAVE/XRSTOR at
context switch of three fields is going to beat an WRMSRNS of one.

>> I could just aggressively blow away my SSP0 cache any time an XRSTOR
>> touches XFEATURE_CET_KERNEL. That would be easy. But it also seems silly
>> that XFEATURE_CET_KERNEL is being blown away at _all_ during normal
>> context switches. Heck, it goes further than that because:
>>
>> fpregs_restore_userregs() does:
>>
>>     restore_fpregs_from_fpstate(fpu->fpstate,
>>                     XFEATURE_MASK_FPSTATE);
>>
>> Where XFEATURE_MASK_FPSTATE contains XFEATURE_MASK_SUPERVISOR_SUPPORTED.
> 
> The actual mask used by restore_fpregs_from_fpstate is tighter though,
> it's "fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSTATE".
> 
> Can you replace fpu_kernel_cfg.max_features with some fpstate->xyz
> (sorry too late to think it through :)) that has CET_KERNEL for the
> guest FPU and not for the regular one?

Sure I can give that a shot.

There's one minor issue in that we need to init dynamic features which
_aren't_ in fpstate->xfeatures when context switching. There's a little
note about this in restore_fpregs_from_fpstate().

I think what you're getting at is that we need _something_ to say that
KVM fpstates should muck with XFEATURE_CET_KERNEL and task fpstates
should not, even though the task ones have space for XFEATURE_CET_KERNEL.

That's certainly doable.

>> So a "restore_userregs" function is blowing away supervisor state.
>>
>> IOW, I think we're using XFEATURE_MASK_FPSTATE a bit too broadly.
>>
>> I'd like to get to a place where only the KVM code even has
>> XFEATURE_CET_KERNEL in its RFBM.
> That I agree, but I think it can be handled in {save,restore}
> _fpregs_to_fpstate().

I think I understand what you're going after at least. I'll poke at it a
bit more.

Thanks for the thoughts!
