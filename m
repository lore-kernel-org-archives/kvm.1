Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C5496D24
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988341; cv=none; b=u/mTYPzDH+v4DhXRzVfHMRuLh6HJQmQverDR3LX6Rm4DjbJBWjHjX7uZBvfWsg4Azw1TwEd7PRP31tOdXwR1MtPOMiw9+L3EXm6Gg+UqV4OrQDddciV10C3cYevwAN53a1SMxZyGfa7mXid6SO0vGqtJXihqT643m094RCck5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988341; c=relaxed/simple;
	bh=fXptvvFrmXsJMvApF4iaVsdGzvEEyBiHwrz4Qnd/vxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg6GebUXOU25dTkY37c30lqzyDCa0htW/qJ8ihjji43JcbgXdIbSPlhsxY8q2PFGj18y0mPMQnB0H0mBxMOHhdH5sXt9Twdh/bycvnxISdRxG2mcdj2ye8GBwz8kEAiQEGJ9cfapfcDBSSRasN9wf2vtvnFQRCeDLaDX8snSl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKFgC+6I; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKFgC+6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789988338; x=1821524338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fXptvvFrmXsJMvApF4iaVsdGzvEEyBiHwrz4Qnd/vxQ=;
  b=BKFgC+6I6DSpgcorDplyzyqQpVwn1qpY315VfgRPELfQ2aqdNi+K+KQI
   LnUGWWpPw32AcQ6hpJcql+bgdtkwHpH7ugsYUjmvwbPOZ0j/GEaP+1vyi
   OOdsl14PqAg0n8s8UouKz8OIuudhsIC/2BXybDPERQJTJ/uehWDWd8iXF
   3+pM1gXL2FhyrnBaCy9mriIJTBL8s390fv8mLxsW24Hbr7qaCFwmIsNSM
   ZvqWUeePz1lOHl3mw7FgA9e+qD+jYViWNu/Ji2l8+KifMWsmIvemjpJbb
   hHUIeEEzzk6fh+wndY6ygr1PY5KmBIhoBTqIfbtESkiqdaCcxrBBxC6O5
   Q==;
X-CSE-ConnectionGUID: fuUlWrapT1y5ehcevgY8Jg==
X-CSE-MsgGUID: sZcbXY/yTHyTZq722SutsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89419586"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89419586"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 03:58:57 -0700
X-CSE-ConnectionGUID: KfPD7dwGR6GX7YD3xVnzLQ==
X-CSE-MsgGUID: cSel6j+VQNGs4bKMEr9bpw==
X-ExtLoop1: 1
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 03:58:49 -0700
Date: Mon, 21 Sep 2026 13:58:42 +0300
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
Message-ID: <arEN4h1-SQ8E_qMK@tlindgre-MOBL1>
References: <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <arD3yu3SkN2wLwPN@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arD3yu3SkN2wLwPN@tlindgre-MOBL1>

On Mon, Sep 21, 2026 at 12:24:26PM +0300, Tony Lindgren wrote:
> On Mon, Sep 21, 2026 at 09:52:42AM +0300, Tony Lindgren wrote:
> > On Sun, Sep 20, 2026 at 05:13:10PM -0700, Kishen Maloor wrote:
> > > On 9/17/26 10:58 PM, Tony Lindgren wrote:
> > > > So looks like we have tree things to consider: userspace set migration
> > > > role, the hardware state, and transfer direction.
> > > 
> > > Two of those three I agree with: userspace passes the role at SETUP, and
> > > the vendor implementation tracks the hardware state. It's the per-transfer
> > > direction I don't think we need.
> > 
> > Ack on the userspace passing the role at SETUP and vendor implementation
> > tracking the hardware state.
> > 
> > Then for KVM tracking the role, I don't think we need it with the two
> > above. The role tracking can always be added if really needed. Any other
> > opinions on this one?
> > 
> > The transfer direction is there with the EXPORT/IMPORT naming. Maybe
> > just let's keep that naming for easier readability rather than try to 
> > switch to TRANSFER style naming. No transfer direction flag needed.
> 
> Looking at include/linux/dmaengine.h again, the transfer specific
> direction is depreated.. So to follow the the dmaengine analogy, I now
> agree that migration SETUP is the place to set the transfer direction
> like you're suggesting. And so it seems the role at SETUP and the vendor
> implementation tracking the hardware state is all we need.

Sorry above I meant "SETUP is the place to set the role", not the
direction.
 
> The EXPORT/IMPORT vs TRANFER naming both work for me. I find the
> EXPORT/IMPORT easier to read, and I think Jörg also seemed to like
> that naming better.

And KVM is using KVM_GET/SET_REGS type ioctls, not TRANSFER. Also, I
think EXPORT/IMPORT is better naming than GET/SET here as we export
into an encrypted blob.
