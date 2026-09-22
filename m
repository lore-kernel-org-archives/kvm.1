Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E43546ED
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054751; cv=none; b=tzjU8/jq02OvsNs+5Ze2c076gp4SbvVZ2a1n+kd4M79qzpAyL/rqmjh90J4EANHcTtAdbIAVAumaIsz1m18BA1zqyPIsKS9pzGA4JzD26R3IkS7PXGvY7WU7n08fi55wDxecPKCQHN0XS1X7d3MMyMxnRbsUBz3dxnf48oSXXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054751; c=relaxed/simple;
	bh=OVY8K4u5vt9aabgy7ZBzxjixH62UQX7fzousHaNcC3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNaN9zLfzqBm7FupisztRz6iEeYE4qzX7udDK+kH0Q/r/MuiD+PBrcYFp7lGTEUvUngsiOdPZUQI19MSxomtBhF/d1mONMyW32BqFdugI0eH9pf/vxvf7ycNIIit6ymWIx8ZNc+mXDBlXGM5cGDx3nceTyQ/F1ScGMGmDt9KMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nO0itRvP; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nO0itRvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790054749; x=1821590749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVY8K4u5vt9aabgy7ZBzxjixH62UQX7fzousHaNcC3g=;
  b=nO0itRvPiByLg8znh4mPJ9CfDPiMmb+S4f+AmJz5IqZNMss5EzgPHEVC
   gvVlCvm6x7N6yrQ2TfoLMG8osH6u9kWjVnnWn/F6/NWsishs3u2DYGejg
   g/w2/sN0uXNUvGP2cAhrT7B9uFqvgiapkonKAOTMs223HYslRhwgc5UTz
   P3Zkg2rFTVPw4EEtNPS4sLHYjDGl5INs9ZOzdl72qjhN9QqSkrEwNzH6e
   C/PR4DDvG+VsMgFbYXZFhZPHdWRQpwosoCwv+9OYesk0gi6CCPwsJ1sYd
   MplKYK90ejlMP2Z4cl6/ULMH4VPO86idahAq9sDi4+ShxP85Q8KWJGzbM
   Q==;
X-CSE-ConnectionGUID: 9S1AOyWaR9uJzJL1ssO38A==
X-CSE-MsgGUID: eKrK06GwTwa/N+S5bDsixQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1128154"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1128154"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 22:25:48 -0700
X-CSE-ConnectionGUID: stHD1VXaRkiLXOIZQsQI+w==
X-CSE-MsgGUID: XGcNSICSSNSBXOTxz8v31A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="281032236"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 22:25:40 -0700
Date: Tue, 22 Sep 2026 08:25:32 +0300
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
Message-ID: <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
References: <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>

On Mon, Sep 21, 2026 at 08:57:45PM -0700, Kishen Maloor wrote:
> On 9/20/26 11:52 PM, Tony Lindgren wrote:
> > Then for KVM tracking the role, I don't think we need it with the two
> > above. The role tracking can always be added if really needed. Any other
> > opinions on this one?
> 
> I do think it's useful for generic KVM to track this role (1 byte).
> - It lets _TRANSFER_ style calls dispatch directly to import or export 
>   callbacks based on the role.
> - Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
>   reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.

Having KVM do generic checks on the calls is a good idea. There might be
a simpler way of handling it though. Rather than having KVM track the
migration state, how about we add a function to check for the migration
session state from the vendor code?

So something like this for the states you suggested earlier:

enum kvm_lmstate {
	KVM_LM_NONE,
	KVM_LM_SOURCE,
	KVM_LM_DESTINATION,
};

With something like this to get the state from the vendor code:

enum kmv_lmstate kvm_arch_get_lmstate(struct kvm *);

For x86 it would end up calling kvm_x86_call(get_lmstate)(kvm) and for
the TDX specific case tdx_get_lmstate().

It would allow KVM to do the generic checks for the migration related
calls you're describing. And having KVM start tracking the state can be
still added later on too if it is needed.

> > The transfer direction is there with the EXPORT/IMPORT naming. Maybe
> > just let's keep that naming for easier readability rather than try to 
> > switch to TRANSFER style naming. No transfer direction flag needed.
> 
> I can't say I have a clear preference between EXPORT/IMPORT vs _TRANSFER_.
> If we keep the EXPORT/IMPORT naming, then consistency would arguably call for
> splitting MIGRATE_CMD too, which makes it 6 vs 3 (or 5 vs 3 against the RFC
> as posted):
> 
> EXPORT/IMPORT style              _TRANSFER_ style
> KVM_EXPORT_CMD                   KVM_MIGRATE_CMD
> KVM_IMPORT_CMD
> KVM_EXPORT_MEMORY                KVM_TRANSFER_MEMORY
> KVM_IMPORT_MEMORY
> KVM_EXPORT_VCPU                  KVM_TRANSFER_VCPU
> KVM_IMPORT_VCPU            

Agreed we should split the MIGRATE_CMD too. Probably the number of ioctls
is not and issue compared to following the KVM style and better
readability. So my vote is now on EXPORT/IMPORT style naming.
 
> I guess the main benefit of the _TRANSFER_ style is reduced duplication. 
> Each EXPORT/IMPORT pair takes the same struct and differs only by the role
> that the session already knows. Merging them gives one entry point per call
> type and lets userspace drive both ends from the same call site which could
> be considered a win. It doesn't reduce kernel code though as the top-level
> handler still branches internally on the role.

Yup not much of a win for the TRANSFER style naming.

Trying to summarize again after we sorted out the direction flag issue in
the transfer:

role            per migration session (cannot change during the migration)
direction       per command, EXPORT/IMPORT
hardware state  set and tracked by vendor specific code

And checking again against the dmaengine analogy:

Compared to dmaengine, the migration role is modeled similar to the dma
channel configuration.

The migration direction with EXPORT/IMPORT is modeled similar to
dmaengine_prep_slave_sg().

The migration hardware state is modeled similar to the dmaengine driver
managing the hardware state.
