Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A023DAADB
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395269; cv=none; b=sEYJbah6m3b3SmyLEmDByQUwWnuDEhgmk1Uhnkk2Qa0aAduIBiBNsOqv/Smf/bY9xsubEc4k/GCehpwvGrlC0p2aNuX6j+7M2j+SMS/fFdjH02TNNbOLHJ/WIYyK8fJ6eD5kvNg4bx6vNQtdF7p83A2R+5IKlBTD1SDOx91xbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395269; c=relaxed/simple;
	bh=gyeaEwftckDvybivxL7Lcif/jhXrTAuwGvWuLKmrAfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4KjFkE0qXKSIaZhodE3ekQ91aCdgRLpUvcevNBOt7hPHMBWmbow6QGgD3yBdazcR1XFV0BR/ePkIn1NWEfZpagmgZejp5iOBw0NRAwAPsU5O22quV06PwzBDaAVLDl9AMcqL6oimxxq1V1gwF7jpRWPc0bNIPio7XXBRgUUyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYNp71G4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYNp71G4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792395268; x=1823931268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyeaEwftckDvybivxL7Lcif/jhXrTAuwGvWuLKmrAfg=;
  b=aYNp71G4wZmcYR6diAx+bEUikarQRCojl6FnViRe/P0zQeh7wgAKjDKd
   Uz7th6GEm+9aGO/KXLyY9g00OqLF91Y6v6uWdOtpLCjKq+fzP48t7WJDO
   dkVl+DMPM8obnsK9umfSl/QfW8Ax9HI2xX/QvU2ZCqZ4vHf12Z5V/TTTf
   K6YKxjInG6RzQRyY160qf9gYEuASLig2UlyGyHGpT/Vr1BLvErF4vSOcd
   LQ2QX+lX+mkTCG5VQz9RSoLMF+j4Um9lQjHgwSQ3qHEWia/+K1hy+hwAD
   /XnBppOQ5+SYzNJzpFpXcO/nmx8flQpjHBHk/JInu8E/JYTsy71138m0h
   A==;
X-CSE-ConnectionGUID: zk8qRyLrS+GagbsOcW9vug==
X-CSE-MsgGUID: Datyt7Q/Tc2qi1NMCjxN3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1065613"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1065613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:34:27 -0700
X-CSE-ConnectionGUID: FEFE/ynuS7mL68At1BFduw==
X-CSE-MsgGUID: 2O2orvY2RQe/kNzKt38wGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2891910"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:34:19 -0700
Date: Mon, 19 Oct 2026 10:34:16 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Peter Xu <peterx@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <atXH-Ii3wpPiGxKa@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <asiFmhftFi-Yq_z4@tlindgre-MOBL1>
 <48a48d12-4db9-4cb4-996b-8a862aad67ec@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a48d12-4db9-4cb4-996b-8a862aad67ec@intel.com>

On Thu, Oct 15, 2026 at 08:56:41PM -0700, Kishen Maloor wrote:
> On 10/8/26 11:11 PM, Tony Lindgren wrote:
> > On Fri, Sep 18, 2026 at 03:46:32PM +0300, Artem Bityutskiy wrote:
> >> In general, I feel like if buffer size is not enough, the uAPI could fill it
> >> with as much data as fits, and communicate back about what GPAs were
> >> exported. The caller could export the rest separately.
> > 
> > For the "communicate back about what GPAs were exported" part, how about
> > we add a u8 status array for the GPAs with the following generic values:
> > 
> > PENDING 0
> > DONE    1
> > RETRY   2
> > SKIPPED 3
> > FAILED  4
> > 
> > Memory transfer functions can report how many GPAs got transferred
> > (DONE and SKIPPED). A failed transfer can return an error and could
> > also set the FAILED state for the GPA entry where it makes sense.
> > 
> > The status could be also stuffed into the unused bits of the address
> > if that's preferred.
> 
> How might this information be used by userspace? Thus far, we haven't
> had a need for it AFAIU. From the userspace vantage point, the call
> either succeeds or fails.

Yup good point we have not needed this so far.
