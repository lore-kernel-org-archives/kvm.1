Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4A136351
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789965326; cv=none; b=eELAA6txnX/Fm4/5xELlPwGyojj+al2apVSd5nqfbcD/hm/2zHPE77VY4qiuU/7HZaO47yPvKFBMCinHLwJBE1P3eNAUyBqq1NUUCFOzwoQCHJcwb6u9KwdaG+GRiMjZ/FCV0F+Y5bhGrcOcduj41QHdGTicjM3cdIkjBbtAYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789965326; c=relaxed/simple;
	bh=jlkRAQH61TfT3ei2srTFzJg2Tdrh6ntPhArPunouXxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty3rgExn521APbgqv42iVp28ERnCBwWbEs2ethGX89CvuZHGTHfIWNVQrzgdGZQO6VO0mKsoFzxCKem+Rx34B3tmoNMg0iJXa5ekkV3/17mb+venEi67CT8YB8/oUGT9R+bT87GbzPv+QkvtTYXKaBBndqlNSjbwfrBQXbGz1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URO9UxHv; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URO9UxHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789965324; x=1821501324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jlkRAQH61TfT3ei2srTFzJg2Tdrh6ntPhArPunouXxk=;
  b=URO9UxHvn54JOLEUD1WG1yV0e6wCWqUn53gIHsu4a/Ew9Va4WXydYp1e
   mQTzsVA4dsHMFpR3/JAhheMkHFCMSU01VV6ZLwad1CZ1qN/hG15sO1o7P
   vxhjno+ZyIql40ToLJ/O6My5KPivs7YqTGwmctEwlRSWSEmVzb8qMj1eB
   nlCxBm7gUGN6iuSf5wJd4SfGsjPjwuCtjuMN7+8rfZby0GVOiHU/7kpid
   J/BiqgEhITcJL5tUSBkGRVCqU4ZBFWUm/DPtfoA6YKkupXTy6V0iWF/BA
   /K5rltJeClcuSpJOYxMEJoy+z/F1X+ashU++qZt1UJ5QxPEEuVtor0x4i
   Q==;
X-CSE-ConnectionGUID: VzFYE5aZRJ6VraKOtxSPtA==
X-CSE-MsgGUID: B70Xkt4JRQWD+DyV6fKYSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="962788"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="962788"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 21:35:23 -0700
X-CSE-ConnectionGUID: Cz+t1X8KTdW1bd5SHsZ8Xg==
X-CSE-MsgGUID: P8NCjgnwRMyzSb8WlitWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="269021974"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 21:35:14 -0700
Date: Mon, 21 Sep 2026 07:35:11 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Ionut Mihalcea <Ionut.Mihalcea@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <Steven.Price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?=  <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Mathias Brossard <Mathias.Brossard@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arCz_0_q180KCrtG@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <VI0PR08MB115655F1834CEA1262DC09FE88A872@VI0PR08MB11565.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR08MB115655F1834CEA1262DC09FE88A872@VI0PR08MB11565.eurprd08.prod.outlook.com>

Hi,

On Fri, Sep 18, 2026 at 06:36:38PM +0000, Ionut Mihalcea wrote:
> On 31 Aug 2026, at 08:13, Tony Lindgren <tony.lindgren@linux.intel.com> wrote:
> > Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration
> > sound similar, can you please take a look how the API might work for
> > SEV-SNP?
> 
> While the x86 implementation is outside our scope, we're also currently
> investigating how the Arm CCA ABIs for Live Migration ABIs would fit as a
> backend for this API. We will provide more feedback on the API shape and
> semantics as the analysis progresses.

OK great, yes great if we can make this work also for ARM too.
 
> As an intro to our approach (and a potential touchpoint on the topic of this
> API), Mathias Brossard will be presenting Arm CCA Live Migration at LPC next
> month [0].

OK
 
> > Dirty page tracking does not add a new uAPI. Userspace keeps using
> > KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.
> 
> One concern we currently have is about an impedance mismatch between the
> non-CoCo dirty log APIs and our approach to dirty reporting. This is just
> to highlight the concern at the moment, without any explicit proposal as
> an alternative.

Care to describe a bit more what issues you are seeing with dirty log?

What we have noticed with TDX is that KVM_GET_DIRTY_LOG works with
additional vendor ops for live migration. But it is not usable outside
migration. We currently get a list of migration candidates from the TDX
module and that status sticks until migration or cancel operation.

So the dirty log stats are invalid outside the migration context. This
means that for example qemu calc_dirty_rate is not available before the
migration for stats.

I guess we could eventually get preprocessed stats from the TDX module to
for reporting the dirty rate. But it seems that initially we may want to
return nothing for dirty log outside migration.
 
> [0] https://lpc.events/event/20/contributions/2476/
> 
> 
