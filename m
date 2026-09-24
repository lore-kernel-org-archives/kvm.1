Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35D3B95FF
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790225491; cv=none; b=hfGfFdQO38vTVubueyF1na6hB3k5fvgTSvjvefu19NLHiQUYJ23gc3qKL4hkSXp9p8sa8alV6fwa5vuHnJ5JmiebKFZCreYH7sqW/7LuwtEPuIYm9r/dZ8TXdvCA8OyYI4YXLh0vX+Idm9AEhmbedDsNQeswPRSDHDqHyaxkGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790225491; c=relaxed/simple;
	bh=/3hy4Jao71LRNY5mWT3wlWoSPp5LUI0XkvFt2MicIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKZf2b5rBfPGc6epomr6Cjz9JX/VxZYc33VrKBqD81mg2nT5M3Iiqs+blV3bn1kw3eSgWCdhPPP/IwmVX7VZO9N1mHjhXpKLjYGDHwIE3D7GvhEKh8zm+aRm3zM1wFmNr1blAKK/mxsAEgAteqtS+iyTF43SuYL2ilb1gYAxXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP6a8Wdp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP6a8Wdp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790225490; x=1821761490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3hy4Jao71LRNY5mWT3wlWoSPp5LUI0XkvFt2MicIHI=;
  b=bP6a8Wdpx/7RhoNFBawoNL3qZQjpaAYyKnkGh9+EXRuS1HWG9KtHqpz8
   YV66j3dbm5wJ7UrYfXTSjI3xCCQSkhaqcAUoOBlPvvFuDyq8PpDzFlyNZ
   8VUfTqo2ycEv4MOGKKG9m4F0h6ZpI5f8dPQPd1Z9uanqMPrfr122/wgBd
   MtEfvCAyesgL45GDdTjJo9YFoiGexf6Erqc3zo39ut39u0Ue1xKezdrnd
   goggjzXUiEq4I9Ov/gka5cy/73xlzGSK8logN4HaKAvq7SZ/ENRmWpYLP
   NECq9BNn7nLgCMe+2TdLN/mC72+jy9c5P9vLFYXS24PnUefu1GcfwbkU2
   Q==;
X-CSE-ConnectionGUID: obPOgfNHRK+KWuCzM6YsCQ==
X-CSE-MsgGUID: QNLmnM6rTRGZYGa6/DB34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="107371060"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="107371060"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:51:30 -0700
X-CSE-ConnectionGUID: PF6depNvThmN0DmAf4vz5g==
X-CSE-MsgGUID: LVbLpii/ShKXUeBWeZkFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="274089264"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.13])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 21:51:21 -0700
Date: Thu, 24 Sep 2026 07:51:18 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
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
Subject: Re: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API
 for confidential guests
Message-ID: <arSsRtIHewY9L-ec@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
 <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <SI2PR01MB4393F419F425D1D54C389A54DC812@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393F419F425D1D54C389A54DC812@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>

Hi Wei,

On Thu, Sep 24, 2026 at 09:50:45AM +0800, Wei Wang wrote:
> On 9/18/26 7:35 PM, Peter Xu wrote:
> > On Mon, Aug 31, 2026 at 10:13:01AM +0300, Tony Lindgren wrote:
> > > +:Capability: KVM_CAP_LIVE_MIGRATION
> > 
> > IMHO this is slightly misleading, some "CONFIDENTIAL_" or other prefix
> > would be nice.
> > 
> An earlier version of this series used KVM_CAP_CGM (CGM stands for
> Confidential Guest Migration). I think it's cleaner to use a short
> CGM prefix for the related uAPIs, so they're easy to identify as a group.

Using an abbreviation like CGM or MIG or HW has a problem where it's hard
to decipher for anybody not familiar with the live migration. So my vote
is currently on using Peter's suggestion for CONFIDENTIAL prefix.

Regards,

Tony
