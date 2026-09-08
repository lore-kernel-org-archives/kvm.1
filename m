Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC51B31F998
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840943; cv=none; b=I+YW3lKzU0ZkkfBZdg9CtNns6EckcQh0R932wDthqp+HXYiwH48GqaE5uRKg+E+HDzM27UgCxmmWdm8qWne6Jt7fnLWFU8xI0XKl8cBHmJeKKJoI0HlrItLwnJ46bCp9AAfJOpvXFDxGDzIQ5XdCUtrQZ6HVgfxS3V/YfHFGKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840943; c=relaxed/simple;
	bh=87P2fw1N1x5+J3oooXoY+YNoQ+RVxijkSj1sGgkBBtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDybkrCmdQ7Zg2yEVV6x2fxI7osY+Rr/V5u13LJ/Mvj/EFksqE2ncukeny+xkgC+b08K0vBpMsmhHtpGqvF7D1l96vJeJfNuspXBzMpZVYXnooqj7NFBRnUg5VkV8lhyCgpG0Ma9Gd2JdO/1VFqJW28lPR7Pt8GNvpDwdJXQ8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVNv5EcV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVNv5EcV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788840942; x=1820376942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=87P2fw1N1x5+J3oooXoY+YNoQ+RVxijkSj1sGgkBBtU=;
  b=hVNv5EcVGBEik+VHUirgv+iRsy0a/jjlx7LVn/esYqyFhRvPTVnCBtUr
   aFOQ6bakDSvwA619+Y+jnb3YFwqgmF3fppmmiQB9pc+SkYH2unIE1n7hw
   hoHaGgVTcqdrGkZG6IyRzPoMA+CrGE9i/u6eaMK1121moqzr2ydqoS4a1
   C1vqHKmR/1tkNERYSRq+JTb6XeE0r5Ompr4Oh1oIxnF2Ybud4oWYpTqFH
   Bpdr7jUHBl/pWzwqHgfIKyH7JLigyJSdcNk0UMXbq0Nnt8XVdBn7Xs1LU
   9AXTmqx+ieBzJ5HvSAkserdL1dbQhp78eCDE9vrKULyZT6m8/Jk3b1fhq
   g==;
X-CSE-ConnectionGUID: 5d4BDfgsREmHiyI/VDoDjw==
X-CSE-MsgGUID: g8K6A60uSUWXc8rzLMasBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100588866"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100588866"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:15:41 -0700
X-CSE-ConnectionGUID: 4UgrYRaITAqHqmoir0MzCA==
X-CSE-MsgGUID: e3FXVTVbTheKnU3ar3VsVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="300751347"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 21:15:33 -0700
Date: Tue, 8 Sep 2026 07:15:29 +0300
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
Message-ID: <ap-L4eQm6Ky62FSU@tlindgre-MOBL1>
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
> Our TDX live migration prototype keeps some per-migration state in KVM,
> for example the direction, the migration phase (setup done, started,
> paused, and so on). This lets use validate inputs and issue the correct TDX
> module seamcalls from KVM.

Yeah for TDX, we currently keep track of some of the TDX module state for
migration. For most part it can be done with the existing kvm_tdx->state.
The paused state is additional TD_STATE_PAUSED.

Some states are trickier though, the setup done state means the TDX module
has migration keys configured. If the keys are not installed, the
migration SEAMCALLs return errors. Does the kernel need to keep track of
this? With proper errors returned, maybe not.
