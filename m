Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A14368964
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982680; cv=none; b=YoIKhSp4VYwrVxfSMsxavthnMt8NJcqN4YPgmZhEPb3X/dxCl02kfqvi21IGLE3S4iv3GNKXNxmO0ABa2Gx6Fyda+lAPND5ki36mWngW5O8P4d8GeDXesyZbAbE0rTCgNE38VibnnzX3AhQM0iSodzvLRCHYuf2ZY3MQtncZXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982680; c=relaxed/simple;
	bh=cp83rDh97htt+z8Wz2CB7Z8ITESPz0+2ZtCcvQT335s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLEQUBrvj4kIYdf0Z850nvVam6gUZXVGgA8R5DAwcamvPpjULKbk9jLSND2+XgVH3FdoILXElpaABpGPjQ6K4NBx6rXrgpMZ1mM2vIN4i5iD/spJwBEbFWRscBnaFOVhIOYXIovVTslFOlR2GGysIuREXQ8gGYkUWmRsm0y92Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ju528Gc1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju528Gc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789982678; x=1821518678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cp83rDh97htt+z8Wz2CB7Z8ITESPz0+2ZtCcvQT335s=;
  b=Ju528Gc1+r/OtFX1laMB/725w+vAuYnnCyDvpcr33ZVzB+3glN3kUM4l
   4D+Q5HlaC2oeyUKJOIt28yDtM4QGJwNAMB9iJix73ctkHnsjJU5u0WvIX
   VuQ+u+R5GiKcnMEQgPkagnKEDrC0JX7403JWX+AXTmc6e4kS33jb8B0Ax
   4wzVzvx1XQLYkVv74GctJqKrv9PUbaW+bQs0s5RyfigNaUjfH3oZTYR0q
   EWQmEHJXXcntLMFvrZh6OTr0YIgVhyC5Le3Ln229Iywq73Bp8E2foEIGa
   i70opgnNSftTXEbXkZSCKk/YID7xKJ7yyrS0WZFm0ieDjJI2MImplS/Sx
   w==;
X-CSE-ConnectionGUID: 6yEVdjm7SGiMcr5vmA870A==
X-CSE-MsgGUID: M5un6b6bQQuZhucrpnn7Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90501106"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90501106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:24:37 -0700
X-CSE-ConnectionGUID: PjlWT5aNRKOFpS70RJJbog==
X-CSE-MsgGUID: 0fmTbqAwTreR1SGMfMAUUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="300512116"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:24:29 -0700
Date: Mon, 21 Sep 2026 12:24:26 +0300
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
Message-ID: <arD3yu3SkN2wLwPN@tlindgre-MOBL1>
References: <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
 <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arDUOl2WPKRxwrZW@tlindgre-MOBL1>

On Mon, Sep 21, 2026 at 09:52:42AM +0300, Tony Lindgren wrote:
> On Sun, Sep 20, 2026 at 05:13:10PM -0700, Kishen Maloor wrote:
> > On 9/17/26 10:58 PM, Tony Lindgren wrote:
> > > So looks like we have tree things to consider: userspace set migration
> > > role, the hardware state, and transfer direction.
> > 
> > Two of those three I agree with: userspace passes the role at SETUP, and
> > the vendor implementation tracks the hardware state. It's the per-transfer
> > direction I don't think we need.
> 
> Ack on the userspace passing the role at SETUP and vendor implementation
> tracking the hardware state.
> 
> Then for KVM tracking the role, I don't think we need it with the two
> above. The role tracking can always be added if really needed. Any other
> opinions on this one?
> 
> The transfer direction is there with the EXPORT/IMPORT naming. Maybe
> just let's keep that naming for easier readability rather than try to 
> switch to TRANSFER style naming. No transfer direction flag needed.

Looking at include/linux/dmaengine.h again, the transfer specific
direction is depreated.. So to follow the the dmaengine analogy, I now
agree that migration SETUP is the place to set the transfer direction
like you're suggesting. And so it seems the role at SETUP and the vendor
implementation tracking the hardware state is all we need.

The EXPORT/IMPORT vs TRANFER naming both work for me. I find the
EXPORT/IMPORT easier to read, and I think Jörg also seemed to like
that naming better.
