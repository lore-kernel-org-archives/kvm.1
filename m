Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037133BBD7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788842648; cv=none; b=Da46HlkleII6k5Onl4fk2VZm3E5Q3NWvbMdr+POzgCkELFjTYa5QoPst+vlnWzmR3bkdEVvZ8YB8z8fxOk/FTQuCxOGau5ImcsA8GBJVIcG2dv5NL9ibVgpHvaeY7zwZZLkOXpdtopms5pxMqFG7qOKJuGPLptIiayHn4DOG2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788842648; c=relaxed/simple;
	bh=N93yy2cSnalyHr04bMOVeqR8AIr0fIg+uFBrS273sM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/I5BkwQhPlPvNAX4v8RuzTtefWB7/v9lOk51rz6KUj6OTmOePxV0QR46OPOHdPS3rNpATV7dbCJsTBAqf/qQNVK5HibF8hxyfytnIREiE+nNvrf1k4p5CWBdeKyX8/9icHDUDHEvvjwkYBwuYs5xC0XjPowowdc7L6FUtqOCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeWcE9T6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeWcE9T6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788842647; x=1820378647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N93yy2cSnalyHr04bMOVeqR8AIr0fIg+uFBrS273sM4=;
  b=UeWcE9T62pzdr5n+F5iGCeiF9M8e4KhJUimjKWJbibt+Fcf9XtklVbSE
   wHcAsN+2IH57kL6TDLZXEldzcQF3iFDDcf/usi+RWAWegfO4fVfUPSQ8K
   SerGo3QsrTfykM3rptO5u2hc2JiwjR3bkIMhChIvTgtuH160brUBSisJF
   a0WeDw+GRF/RfGw5YH+1Edb8eyVwwWFnUlaf8gk0DvJ4GW8SyubJmfY1R
   RCKTtV/+McmDXzKp6Qwhb0UTzXqDRqG20s1AOqIxM1T9mUzaFMWCRgrzQ
   0zfQS06cRreo38414zpdjom+qqkHjMW8/ng2yCZOMBaYWqcS0QD6+O8Vn
   A==;
X-CSE-ConnectionGUID: TiQdRRMnQE6GEIsKqiDAxA==
X-CSE-MsgGUID: OVirn0/ATsWd3PvEwWhFkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89252794"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89252794"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:44:06 -0700
X-CSE-ConnectionGUID: FV5WqCjlQsukkPCCvegyAg==
X-CSE-MsgGUID: lvYpswhFSBCI8BohBu3mwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="270843380"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:43:58 -0700
Date: Tue, 8 Sep 2026 07:43:54 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
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
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <ap-SihGd0fk02QV8@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1>
 <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>

On Mon, Sep 07, 2026 at 04:32:33PM +0300, Artem Bityutskiy wrote:
> On Mon, 2026-09-07 at 15:15 +0200, Jörg Rödel wrote:
> > The direction is always the same over a single live migration session, right?
> > So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
> > and KVM_IMPORT_CMD seems to be a cleaner ABI.

OK
 
> Yes, the source stays the source, and the destination stays the destination
> for the entire session.
> 
> This is a special case of a broader question I keep coming back to:
> 
> ** How much state should KVM keep about a migration session? **
> 
> For direction specifically, we could pass it to KVM on every call and let
> KVM stay stateless about it, or KVM could record it once and remember it for
> the rest of the session.

Yes the "record and remember" is another option, it could be a sub-command
something like KVM_MIGRATE_DIRECTION.
