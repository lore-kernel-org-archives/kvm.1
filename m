Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E543C7DB
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627396; cv=none; b=ZtGpqrxhusJt0ab1mPHeHki+rDu6m+zFPEIf2QMA9eh8cT85avWzTXVu4fc6Ni70kGxAIkTjt/+vBihTK8w3m7hAXA4v8Ar+ZB77iwrp0fYZ7XukBVWn1hSmTP2ASUJwCAGqD65wSmPvfWnT4cI8q64MHjnapKed7keC+IqAG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627396; c=relaxed/simple;
	bh=ZQm+16YtKzJtSPzx8KitG9tdFZSiMFjDllsU7eHSmz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALq7oQpHUih/tADzyfO/bAp0Qaj9MmhBm+nnfOI2nPQgw/uNii1OTRMDo6We5imjYYXxCLoaHC1nWJVxzxD2ZAgRjJZGUunZY60OdcTUlmiYX+5xfLxvkM6y8QZXfdfDHwfa2jg34BDu+bV62y4A1JU7o01JQVA+6E7k2kupCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT9DZf2Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT9DZf2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789627385; x=1821163385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQm+16YtKzJtSPzx8KitG9tdFZSiMFjDllsU7eHSmz4=;
  b=AT9DZf2YRfEjLRerI+FkbCnBM/U4E98yltFtugVpeST8Uw9mou4J+jdf
   HBRjUesxvG+wtspAU1Yr6OYvokpl3+PfI3ozJ7rtGK+qtSVK0kD4xU0/S
   Josi8JeTc5mJbkxdC40L4vZwNM9E5favyA/aCcCQofO9B4plLB5BXrQ5/
   7jOtM/drLbHPGvsL4GgePGi9OAcr2uWSDrwTYAeaWxWn47h/Ae7GMmkJ7
   qa/OKhbpEMMZsk0kOafqL83qamRgACUOvgWMp00pbiuAvkkjzW3ozwm3c
   3FKmFRptpU9CJ58HgcTH1HrLg2Mci2bc1PDMDamFa976ciPHvO5kEbmas
   g==;
X-CSE-ConnectionGUID: lt51X5MKSJe2MDAdkY9ohw==
X-CSE-MsgGUID: JMVjqtCqQceF8R1VnANw4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93844068"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93844068"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:43:04 -0700
X-CSE-ConnectionGUID: +xwjfWkCRG+ICriusOTPwQ==
X-CSE-MsgGUID: 5LbHrtf3RhetAMtX4+UJFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267385990"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.73])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:42:57 -0700
Date: Thu, 17 Sep 2026 09:42:54 +0300
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
Message-ID: <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
References: <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>

On Wed, Sep 16, 2026 at 08:31:32PM -0700, Kishen Maloor wrote:
> On 9/15/26 10:09 PM, Tony Lindgren wrote:
> > So trying to summarize the common flags for the role and separate vendor
> > flags:
> > 
> > struct kvm_migrate_cmd {
> > 	__u16 command;
> > 	__u16 flags;
> > 	__u16 vflags;
> > 	__u16 reserved;
> > 	__u32 reserved;
> > 	struct kvm_transfer_buffer buf;
> > };
> > 
> > Is the above along the lines what you were thinking?
> 
> No, I was suggesting a 'role' field carved out of the 'reserved' space,
> like this:
> 
> struct kvm_migrate_cmd {
>       __u16 command;
>       __u16 flags;
>       __u8  role;     /* 0 = unset, 1 = source, 2 = destination */
>       __u8  reserved[3];
>       struct kvm_transfer_buffer buf;
> };

OK yes thanks for clarifying, that works for me.
 
> > Ah OK, yes that would also tell "the hardware has been initialized to a
> > certain migration role". That seems like a usable common feature.
> 
> Not quite. It tells us that userspace asserted a role for this VM's migration
> session. Whether a TD was created for import is a separate, vendor-level detail.
> The generic layer only needs the role to reject a session that never stated one,
> and to pick the export or import callback. That callback then knows which side
> it's on and can reject an incorrect role (e.g., if SETUP asserted dst for a src TD).

That's a good point, the hardware role may not be set yet.

I'm still wondering if there is a need to stash the userspace set role in
KVM though. Likely only the hardware specific code can properly track the
state of the hardware and adjust to the userspace requests. Seems just
being able to pass the role in struct kvm_migrate_cmd should be enough?
