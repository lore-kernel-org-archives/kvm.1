Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40257134CCF
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964436; cv=none; b=QIjzzON5zKDLdzJiQ98dyoUd9CYftzTqgrTth6whIAp2J5U6MWRql2U0+G+axHHuMCy8Ex8jCyIAZ6l/EKgD4+793orjmfsLJQkQkuC8lVFU0uUN9cjBbZ5tcukPrt5e1SOtDiKuanrRYubDHmqJ+Ns7hChc6/Yn2QhLbunNSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964436; c=relaxed/simple;
	bh=yGLjIcr19iCqkNLFhMvjVFvgwabUt/82hv8z/mDDvV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbX8pg1gLBW2vAShzPHuUd8p7UmLo7fbQ1xeW2i7xRg4NzkW/2Nr64b6po9PupdDmxpzpgAlXiAkVgitE8c723MnmFIRTdAV2hLUJ5U5jiTDc7sou36FeCm3iD+qaJk+p2BhqyWKAgWA+sSYbW1OAFGCqWTVlcVzYaFxdcZ1oUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4CCmyq9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4CCmyq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789964433; x=1821500433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yGLjIcr19iCqkNLFhMvjVFvgwabUt/82hv8z/mDDvV8=;
  b=X4CCmyq92WcYjSmf2QdWJ4KMuV6TSKjWjBTuQ6TfhWVpfc+WcM6Q2+/h
   92AbFZ/u2qmFclYJYKEw9vZMA1YQ8hEnHS3ALkB8Y8SICw16Xl+fCQ1oG
   7iDJcIhRE44r0lWLKFl1FnJurRooVtQC9RRWyu9yQTA7hg3ejN019798L
   W+1te8dTgqr8Kr23L71xvF5u7gulmf3yI7spteG7LWCIMMvAsWLLp8gfD
   SxMIxKanwcjAvzGYFMI0/do7pzfNXNkxPjPXy4s2itOupv9knmyd22YCB
   5Uot+QqsmKxq5GuuELwcbqiwNXGmvomVcVRyigPfJHzYK4p2pH6bujQwq
   g==;
X-CSE-ConnectionGUID: Q2am31ByRZmAmeWmcyXW1A==
X-CSE-MsgGUID: ZqQH114aQiqOj3tsJujHYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101048271"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101048271"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 21:20:32 -0700
X-CSE-ConnectionGUID: 47d2ttsZThyxcmM6+wlQWQ==
X-CSE-MsgGUID: PCxiS8QJR1O4ovaEtoCx+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271027886"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.168])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 21:20:25 -0700
Date: Mon, 21 Sep 2026 07:20:21 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <arCwhd54AAgeNqrF@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
 <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>

Hi,

On Fri, Sep 18, 2026 at 07:35:39AM -0400, Peter Xu wrote:
> On Mon, Aug 31, 2026 at 10:13:01AM +0300, Tony Lindgren wrote:
> > +:Capability: KVM_CAP_LIVE_MIGRATION
> 
> IMHO this is slightly misleading, some "CONFIDENTIAL_" or other prefix
> would be nice.

OK. For the possible prefixes to consider, also HW for hardware specific
ops might work. I'm not aware of kernel side migration needs for this
other than CoCo though.

Regards,

Tony
