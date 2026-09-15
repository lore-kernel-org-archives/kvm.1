Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDD430309
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447457; cv=none; b=dVdePfdQIBRwZfz8iGK7l8Fz3tzaerK/M1BUWQ8dSBy0+Ztgo/hQMNRVbAmo7dG/5gNq43Q30DGAs1/xNBSsr22XwJRxKrNkyRn3UCzNgXXz2ZCKKyHfhQ9VQLHln7CJwbzh7b6MLn1+jLmAkvvTOSYmk0Sh45rad4pZ8H31QFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447457; c=relaxed/simple;
	bh=UwaPiZLgnjFuVCvp+bYj78Yv0H48SK2if+wPIk6MZW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwtzRZqa2GCzj4k+mSXXYmxt0QOx+BQJeiMyPFWnmN2iRbGozFjdpACl1ehywiEuL5YvmNRQ2c4w3OnQ+kQCFOkKLJmPDvJtSwH4SfpxQArBaSK67jzA7RSR5OajMb6+7WvX/56qLoO/eIUJXYtp6h6kVdHSaIF4aG3n/CFnbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgTfpEuH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgTfpEuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789447456; x=1820983456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UwaPiZLgnjFuVCvp+bYj78Yv0H48SK2if+wPIk6MZW4=;
  b=JgTfpEuHQHz1HfIhxbl+i7jtRjYNKVAMmVdzB42JAoF4tywMf6Kbhzkr
   KVErcoeXRN941oMvjwmghcbMY0OZvABN9ViWRWoIt+uSmbtiI64RUOqvr
   aBZfv1nsK+mEFtNsQGMdymd/t8JT68n51uTC6TA7FLfpdMB46MhMKkZJT
   Sa2sA51R2KDHuz61b3vJafgY3zHhuRCi8QL+rJLoe0YuJwDOgEDQJLnr2
   jcqcfE6pSgRVHC2RtCrSvziZ8V9+QI6i/YZ6dGz1AIOuvUvEmyV3sKf8W
   LLKuPDEmCe/QMVB/u3gm9Qg+vYPzzGg1yKCG/LevE3RaLyY5V5Hqg+FCB
   w==;
X-CSE-ConnectionGUID: 2PS9X9fXQUWNAeRnxOtVDg==
X-CSE-MsgGUID: Fy9ATss6RO+S/gpn7lNfjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77362903"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77362903"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 21:44:15 -0700
X-CSE-ConnectionGUID: OzrG+IgjQASuflWUzr6P1g==
X-CSE-MsgGUID: GN4RKdbbQyiKY67fTI0jhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="266619402"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.253])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 21:44:07 -0700
Date: Tue, 15 Sep 2026 07:44:04 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
References: <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>

On Mon, Sep 14, 2026 at 05:14:32PM -0700, Kishen Maloor wrote:
> On 9/10/26 9:23 PM, Tony Lindgren wrote:
> > On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
> >> On 9/9/26 11:33 PM, Tony Lindgren wrote:
> >>> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
> >>> ...
> >>>>
> >>>> As mentioned above, that is a destination launch time directive that we needn't
> >>>> conflate with a migration/transfer session role.
> >>>
> >>> It's still the same role though. Yes we can set it on init, but would
> >>> be nice to have some generic way to do it for qemu -incoming.
> >>
> >> I'd separate these.
> >>
> >> On the role: it seems we agree on recording roles per-session. My only point
> >> then is that a VM created through the delayed_init flow doesn't additionally
> >> need a destination role recorded for it if SETUP will assert one when the
> >> migration is kicked off.
> >>
> >> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
> >> A generic mechanism would make sense to me if the flag were consumed by generic
> >> KVM code, but that isn't the case here. Userspace has to make a
> >> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
> >> on that call. So I'm not sure what a generic version would add, unless you have
> >> something else in mind.
> > 
> > So we could add a SETUP subcommand SET_ROLE or SET_INCOMING.
> It might be better to pass the role as a parameter of the SETUP call
> rather than a separate SET_ROLE call.
> A separate SET_ROLE would bring its own ordering rules relative to the
> other SETUP sub-commands. 

OK a flag for SETUP sounds good to me. SETUP is needed anyways for each
migration session.
 
> The specific role (src or dst) still needs someplace to go, and flags is
> already the sub-command selector. An option is to carve out room in
> the __u32 reserved field to carry a role argument, something
> like 0=unset, 1=src, 2=dest so KVM can verify that a role was indeed set.

To me it seems that 0=src can be the natural default starting point, I
don't think we need 0=unset.

> It could further be written into a generic KVM struct (kvm_arch or kvm) which
> could be queried on KVM_TRANSFER_MEMORY, etc. to identify the relevant
> callback.

Yeah eventually some generic place for it would be nice. But that's easy
to add later on too.
