Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316393AB28D
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937042; cv=none; b=Kh57JEGaOexn85M3O95WTQ4LUS8I1GFLPzGE44ansAbpWwxFfYcuvokn0Lx9pKIOsIsBqoNkKxhtNELFlKZ9p1GiBRR5bfC9/AoihPntEwdd92BtObqVvDjQy7JgtUVs3YT/y8NTOHJa+fmlg+UbtRJmFHl6DxEs7cWEkA8gsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937042; c=relaxed/simple;
	bh=Muz4809RXXTGYktOPh9Kxzs6be+cP38WhWb+4Y1a9xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdZD+x0rhoLP6hP8TOvkCyAmjYpQ6s4qJSHpPK3PJMXuuWncLP8Rf6GGloY45gerEwbIFtuVMBCqAZehh/fBG/oSA6BSSmMEe55psnaBWXyGhNRr3aNUO0LV7sDyE7g3zpTlkMqQpH68/K6gChTF4PWkQ7T17Mz9kLAjlhStxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1QRN1lo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1QRN1lo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788937040; x=1820473040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Muz4809RXXTGYktOPh9Kxzs6be+cP38WhWb+4Y1a9xM=;
  b=D1QRN1lo5I6JORBrr1iRB78A+0CccTX73iIF83epS/uHx4yS8YlqB3Nm
   xy4BDy+k6AFXv3yKRAwis80GcLTa8K652/CFrRyWNy1sysv9dTIvQXKtI
   z49mhriD5qc7pLObYU+ktYzUl+OngvpVn5EEEPzZmG+lLSumVU2Z4CxOQ
   +uEN69GUgW480zyEkjibe2qrC4GZROFhLXWLnoZZfNLrsxen2t1rExoT5
   ovbt7FIAsNKAx/Bsrt8SWwRgGbbrxWWJU49o3nre76PX6Vu9Qe69YTA5b
   U61eqRC6J7UGi3s1JC8MqHTkEkNs92dUlOTzCHmYnEtphGVIc9ti3MWJC
   Q==;
X-CSE-ConnectionGUID: PgQqVxx9Tda3C2PqGvV1OQ==
X-CSE-MsgGUID: wbzmxlPjSBmM7HIsScl7Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100872747"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100872747"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 23:57:19 -0700
X-CSE-ConnectionGUID: qtA87y1RRsKimAmBVGcU+g==
X-CSE-MsgGUID: 1+WNMJgRQX+0CfGZYe2n0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301107459"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.118])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 23:57:10 -0700
Date: Wed, 9 Sep 2026 09:57:07 +0300
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
Message-ID: <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ap6loazXtvSCqmpR@tlindgre-MOBL1>
 <ap64dFXpiDb_Hqxl@8bytes.org>
 <d25d652c34dedc209ccb3b758e7f624b9125eee5.camel@gmail.com>
 <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>

On Tue, Sep 08, 2026 at 05:22:30PM -0700, Kishen Maloor wrote:
> On 9/7/26 9:43 PM, Tony Lindgren wrote:
> > On Mon, Sep 07, 2026 at 04:32:33PM +0300, Artem Bityutskiy wrote:
> >> On Mon, 2026-09-07 at 15:15 +0200, Jörg Rödel wrote:
> >>> The direction is always the same over a single live migration session, right?
> >>> So it could be a setup flag, on the other hand having separate KVM_EXPORT_CMD
> >>> and KVM_IMPORT_CMD seems to be a cleaner ABI.
> > 
> > OK
> 
> 
> Just sharing an alternate point of view:
> 
> The roles are fixed over a migration session. A split ABI is certainly more 
> self-describing, but it restates that invariant on every call, and therefore 
> also permits it to be contradicted -- a failure mode that does not otherwise
> exist. With a single KVM_MIGRATE_CMD and a per-session role recorded once (more 
> on that below), there is no need for per-call policing: the role could be 
> checked once when the session is established.

There are two occasions the role is set or changed. On starting the
destination the incoming role needs to configured at least for TDX.
And then after the migration, the role changes if re-migrated.

I don't think there are other cases for role change, maybe cancelled
migration could require that for some hardware possibly.
 
> Along these lines: it raises a question of whether the MEMORY and VCPU
> calls should be coalesced as well into KVM_MIGRATE_MEMORY and KVM_MIGRATE_VCPU.
> As posted, direction is implicit for KVM_MIGRATE_CMD but encoded in the ioctl
> number for those transfers, so collapsing them would at least make the uAPI
> consistent about where direction comes from, and free two ioctls.

Using naming KVM_TRANSFER_MEMORY and KVM_TRANSFER_VCPU might be more
descriptive?

Eventually these same commands could be used to save the state to disk
for power management use.

And going back to the dmaengine like analogy of what is being done..

The transfer direction flags could be KVM_TRANSFER_FROM_GUEST and
KVM_TRANSFER_TO_GUEST?
  
> >> For direction specifically, we could pass it to KVM on every call and let
> >> KVM stay stateless about it, or KVM could record it once and remember it for
> >> the rest of the session.
> > 
> > Yes the "record and remember" is another option, it could be a sub-command
> > something like KVM_MIGRATE_DIRECTION.
> 
> 
> Agreed on record-and-remember, with a refinement on scope.
> 
> A VM that was migrated in can later be migrated out, so the role is not a
> property of the VM -- it has to be recorded per session. SETUP is the call
> that starts a migration and runs ahead of all other migration calls, so its
> arguments look like the natural place for userspace to state the role; a
> separate sub-command would need its own scope rules relative to SETUP.
> KVM can then ask the vendor layer whether the requested role is permitted for
> this VM -- only it knows the confidential-VM state -- and on success record it
> in generic KVM state, where it then selects the export or import callbacks.

The role can change, but it can be VM specific for starting the migration
destination even before migration is started.

At least for TDX we need to specify direction for migration destination on
init to prevent fully initializing the TD and vCPUs.
