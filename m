Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818497081F;
	Sat,  7 Mar 2026 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845259; cv=none; b=WMVETCVv+hGFAsy4uK7TV2v9Avk8BTy4lCiorqgk1PMLLObhZS90q6XCzo1YeSE7ICW5c+7I2Aa5xhBdIcpaXFZ8NxSY3T6jlsTm3b8P+0B39ocv8027SaaZWkRoFzZn9UqzfFLazYPM89ZKgnYTodjJzfAhTu0C6Zn/Noz2PtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845259; c=relaxed/simple;
	bh=DM2m/EB+rzYKgohnfI8eBA86iz6o/k0Y2C3m9vQOhao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHZGS43PsytAtrRRKF5hGu7V6l2bhSJmJUS5jUqwvq+wm7497S/2sqFm1wEC3PQhKrzfJJMyYiabPSKGFoRE3Ndn92brrSYhn4+zX+Csw5XjqLXFx9/qDl7u+wdtUd2anXsYQdhLP1V5rwYV+qFoyhjMPzvFf4SNvcjtEBw3qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4olsN23; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4olsN23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772845259; x=1804381259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DM2m/EB+rzYKgohnfI8eBA86iz6o/k0Y2C3m9vQOhao=;
  b=f4olsN23Up4Ym3zwKWvS6iFClj+MqvJqy5csgxSSHZRNm5BpPEIDYtPf
   O3ajoV8Z32WRsSTfhf5LQYURzHJK7AUcrAF+7hkiZjk71mvjAMJbvy0aP
   mUAF7IOaJCEmiaRTwd2gfATQ+b8SPT8OEH9tbREmQMivJwf6U8BS3DaYS
   +Q4bI/CYuNJtuTIfshJeaIXAxGb8RSR3T6vjAmFIgLw+ZwTzYEFrUPRyD
   cIghQoeUvm5uK42G4QDySQDnAEZR8QJH7KMb0Zn9b2rQyT1MrDfeMxqSV
   GJRTFx6QkC9T0W2IR48Zad3PjhZd7Yh7qLO6d/x5qrz8NSYwIA35Lvl7Y
   g==;
X-CSE-ConnectionGUID: 1BjpoX7JQ2yC3BfiE7DXZw==
X-CSE-MsgGUID: Z7n9vE94QC+GUot2Jh8cEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="74149237"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="74149237"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:00:58 -0800
X-CSE-ConnectionGUID: wtRa8MAnQbuQHrpuLsBXpg==
X-CSE-MsgGUID: WLHE3aDtSIu/hH0JV/924w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="215031585"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:00:57 -0800
Date: Fri, 6 Mar 2026 17:00:51 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, David Kaplan <david.kaplan@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, David Dunn <daviddunn@google.com>,
	chao.gao@intel.com
Subject: Re: [PATCH v4 04/11] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260307010051.u4ugg3nyvsu6hwbg@desk>
References: <20251119-vmscape-bhb-v4-0-1adad4e69ddc@linux.intel.com>
 <20251119-vmscape-bhb-v4-4-1adad4e69ddc@linux.intel.com>
 <CALMp9eQNBZsJNdfCVwbJ4v1DgCNqRV3DVcEeCPFt=dd29+qy-A@mail.gmail.com>
 <20260306223225.l2beapz3nvmqefou@desk>
 <CALMp9eQoE13d1cqD3PNJtvdKUGZeVm1g-9TWh+M+MJj_sm9CzA@mail.gmail.com>
 <20260306232920.dja5n7cngrsyj6tk@desk>
 <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>

+Chao

On Fri, Mar 06, 2026 at 04:35:49PM -0800, Jim Mattson wrote:
> > > > > I think we need an explicit CPUID bit that a hypervisor can set to
> > > > > indicate that the underlying hardware might be SPR or later.
> > > >
> > > > Something similar was attempted via virtual-MSRs in the below series:
> > > >
> > > > [RFC PATCH v3 09/10] KVM: VMX: Advertise MITI_CTRL_BHB_CLEAR_SEQ_S_SUPPORT
> > > > https://lore.kernel.org/lkml/20240410143446.797262-10-chao.gao@intel.com/
> > > >
> > > > Do you think a rework of this approach would help?
> > >
> > > No, I think that whole idea is ill-conceived.  As I said above, the
> > > hypervisor should just set IA32_SPEC_CTRL.BHI_DIS_S on the guest's
> > > behalf when BHI_CTRL is not advertised to the guest. I don't see any
> > > value in predicating this mitigation on guest usage of the short BHB
> > > clearing sequence. Just do it.
> >
> > There are cases where this would be detrimental:
> >
> > 1. A guest disabling the mitigation in favor of performance.
> > 2. A guest deploying the long SW sequence would suffer from two mitigations
> >    for the same vulnerability.
> 
> The guest is already getting a performance boost from the newer
> microarchitecture, so I think this argument is moot.

For a Linux guest this is mostly true. IIRC, there is atleast one major
non-Linux OS that suffers heavily from BHI_DIS_S.

If the enforcement is controlled by the userspace VMM, it is definitely
worth enabling KVM to mitigate on behalf of guests.
