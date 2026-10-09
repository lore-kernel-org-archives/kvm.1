Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E35360ED0
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526312; cv=none; b=d7GkQhalTMOlwZdGdhrHITdzwB2kmQSGSEUnQ6OPnpPoWMef3ZaVfrkN5PDNZR8lUBSf7IB6UmwNK2mlEJyqSbY9s5UhG+vclwaUSyVaAD+lbfumGqU1ajljION1XYtbMHKkmiSQABnHHGJ1wL2uoCM7ZGP+nc6rCurhBLHF5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526312; c=relaxed/simple;
	bh=Nvj0GoITwvcLaayGpMbhWbsOI0ZNw+EEUEzktAMJfB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN+qKdrJEtFVReP+qhH2xGzJWnnTN4ujKZskGUjM1s2JrBo7Btk4cnwb7EicyuxLte9e8RG0A9KawIpR2J8YDkmwrurEyZdhggCDWA8y9czmJxQjk0rkEnh9T64uyyj8IOMaqYTo8jbYtmXD1QWUUTNqqT1TXr1+pK9nVbnfohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBNDL3pB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBNDL3pB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791526311; x=1823062311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nvj0GoITwvcLaayGpMbhWbsOI0ZNw+EEUEzktAMJfB0=;
  b=hBNDL3pBWoW0MBjM8zuToi6bPCCz7doQujIiOtbH9J9Q2ogL8Wuc6pjQ
   nqIYC1ygFQx82NJwpotvsrPGSML0p80RwuwKkNmdITaTj3ouSOnSMUuq2
   WzVKTWG0FLBAg2b/YE196TZ2/RZVpA0NVz6mpurQN+eZY6tS0LjVoY+mZ
   034axtoNGfLSPJetHqnthl4J84CtRrkS0VEk4+ulMipZVOWRcrOgVUMNV
   AY+GNGqSk4UhlX9U/0QApDaRlcnv8G0zVcUPxT/L1ffxdP9ZkebuQa2lV
   IjKb4HlEz5m806k+NE1lwEKJzz+NU2gJK3YIgWKZvYK9Z8GOgF0op8oj6
   A==;
X-CSE-ConnectionGUID: 7hwAO4OUT/qtYWNPEU/+tQ==
X-CSE-MsgGUID: hUJUe2nUTbKEgcczA48OVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="205442"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="205442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:11:50 -0700
X-CSE-ConnectionGUID: 7JIassDWSU6L3+15dE+Kfg==
X-CSE-MsgGUID: Us4y4fl8Tmq2k3ieRShkUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="223976"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 23:11:42 -0700
Date: Fri, 9 Oct 2026 09:11:38 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <asiFmhftFi-Yq_z4@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>

On Fri, Sep 18, 2026 at 03:46:32PM +0300, Artem Bityutskiy wrote:
> In general, I feel like if buffer size is not enough, the uAPI could fill it
> with as much data as fits, and communicate back about what GPAs were
> exported. The caller could export the rest separately.

For the "communicate back about what GPAs were exported" part, how about
we add a u8 status array for the GPAs with the following generic values:

PENDING 0
DONE    1
RETRY   2
SKIPPED 3
FAILED  4

Memory transfer functions can report how many GPAs got transferred
(DONE and SKIPPED). A failed transfer can return an error and could
also set the FAILED state for the GPA entry where it makes sense.

The status could be also stuffed into the unused bits of the address
if that's preferred.
