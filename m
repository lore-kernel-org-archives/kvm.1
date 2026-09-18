Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90280331EB0
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711118; cv=none; b=Bj/2OVdP5iqPogvDUugu7eETxtfrHccXAG8zQzXt+NLTUBM1UzqoMCoqmuPWBorBUfNDSBFHlV67WxBLes2A57WvyfiTayp1hMldvOIuruj8GfczGL2lkOGS/YiNwX4HOUHLz8C9ECnEkl7PpmfvaHs6PNMNsvzo9rQMlWRCQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711118; c=relaxed/simple;
	bh=s3FNz3hIVPd31vm8p+rjax8IwIio/UW3zpwH2Nb1rI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAEsKRH2WAfkA3WMpDlD6VGiNC4oIVuPfpbosGCxyRMxp7OrPWbjEQQiyX72xjukXCiLrpA794GkcQpPxENAqWGz3AolqNaZCpR5UMIWXNqoXU73ThaTLRTHU8hnA5P4mgkyFxtjcyydM/Dp1edI1nTvrFw3oa5uo0dRCjaXdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU7WMyrB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU7WMyrB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789711117; x=1821247117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3FNz3hIVPd31vm8p+rjax8IwIio/UW3zpwH2Nb1rI0=;
  b=LU7WMyrBX6OyJy+l1BCxTbJfBjHJtOI6Fsf5EGeatkoi39CiGE07uZ+w
   YUPPGpJZfP4rcgbjw1cJa2vjUylWQIWRIAD4r2Z6pOiIihvjM5h4iT1N2
   QFmgdqmQB8d4FlegcBkSiQRIsIiHz1o9YtAfAjz62DZmdD83gTV24nnxK
   bTSpQv2LgzyUgBiN5JzNu1LbPX3nPqfplwsrlWYGVya+ctu1IdPUDNCZw
   QnFBvDIBCy9QdIfBJAKHt8dVgrnts3QRWPQE9kA60NlEYPzW1E4IGVf/J
   dU3RPl6ItT1DYRA5R1elWkuN3Nv4bnN57vkxVFoo0BCPTWOPdJQ7qeDnJ
   A==;
X-CSE-ConnectionGUID: hsDAO9goRu6WBV/nqVOSMA==
X-CSE-MsgGUID: 7+AF/viKR4aFc4Ub1E4ILw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89330367"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89330367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:58:37 -0700
X-CSE-ConnectionGUID: ESAzzBHeT6SexdeiZ6MGwA==
X-CSE-MsgGUID: wbBUUOnWRj+dV9U7oW4Hww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270535531"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.112])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:58:29 -0700
Date: Fri, 18 Sep 2026 08:58:22 +0300
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
Message-ID: <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
References: <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5906521-858b-487b-a262-7a86891a0731@intel.com>

On Thu, Sep 17, 2026 at 09:32:23PM -0700, Kishen Maloor wrote:
> On 9/16/26 11:42 PM, Tony Lindgren wrote:
> > On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
> >> On 9/15/26 10:09 PM, Tony Lindgren wrote:
> >>> So trying to summarize the common flags for the role and separate vendor
> >>> flags:
> >>>
> >>> struct kvm_migrate_cmd {
> >>> 	__u16 command;
> >>> 	__u16 flags;
> >>> 	__u16 vflags;
> >>> 	__u16 reserved;
> >>> 	__u32 reserved;
> >>> 	struct kvm_transfer_buffer buf;
> >>> };
> >>>
> >>> Is the above along the lines what you were thinking?
> >>
> >> No, I was suggesting a 'role' field carved out of the 'reserved' space,
> >> like this:
> >>
> >> struct kvm_migrate_cmd {
> >>       __u16 command;
> >>       __u16 flags;
> >>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
> >>       __u8  reserved[3];
> >>       struct kvm_transfer_buffer buf;
> >> };
> > 
> > OK yes thanks for clarifying, that works for me.
> >  
> >>> Ah OK, yes that would also tell "the hardware has been initialized to a
> >>> certain migration role". That seems like a usable common feature.
> >>
> >> Not quite. It tells us that userspace asserted a role for this VM's migration
> >> session. Whether a TD was created for import is a separate, vendor-level detail.
> >> The generic layer only needs the role to reject a session that never stated one,
> >> and to pick the export or import callback. That callback then knows which side
> >> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).
> > 
> > That's a good point, the hardware role may not be set yet.
> > 
> > I'm still wondering if there is a need to stash the userspace set role in
> > KVM though. Likely only the hardware specific code can properly track the
> > state of the hardware and adjust to the userspace requests. Seems just
> > being able to pass the role in struct kvm_migrate_cmd should be enough?
> 
> Passing it in kvm_migrate_cmd is enough for SETUP itself, but the commands
> after SETUP like memory/vcpu transfers still have to reach the right
> callback. So KVM would need to remember what was asserted so that the
> generic layer can dispatch to the export or import facing callbacks.
> We've been sketching (on this thread) an alternative UAPI set
> (3 vs 5 ioctls) for consideration which this stored role enables:
> 
> Proposed in the RFC              Alternative
> KVM_MIGRATE_CMD                  KVM_MIGRATE_CMD
> KVM_EXPORT_MEMORY                 
> KVM_IMPORT_MEMORY                KVM_TRANSFER_MEMORY       
> KVM_EXPORT_VCPU
> KVM_IMPORT_VCPU                  KVM_TRANSFER_VCPU
> 
> It's just a record (1 byte) of what userspace asserted for the current session 
> at SETUP. Vendor code still owns the hardware state and remains free to reject a 
> role that doesn't match it. It is also what lets the generic layer reject a 
> command to a VM that never set up a session.

For the TRANSFER style operations, I would assume the direction is passed
for each transfer, just like the Linux does for the dmaengine. It's
possible that there may be transfers going both directions without the
role changing.

So looks like we have tree things to consider: userspace set migration
role, the hardware state, and transfer direction.

What if userspace always passes the role and transfer direction where it
makes sense? And then the hardware specific implementation tracks the
hardware state?
