Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D0383C7E
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330972; cv=none; b=Cw/Tojz05Zpuf91Gg8Si/sYMOBZ0F2fK4IePILXcSBuOKTMc6UBSDmZvP227hiV5WRVqjH9EX0y1+NAnA2TbmlCK5Wi7DhS+fb3/dSV/33p9SyQKQ98fxDIRinKFbhHXCtknKvMy3lLu+VxDfWdlFHRHURUkXy6Ev/fjnXArpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330972; c=relaxed/simple;
	bh=nMt9DQos2cpVVgP4fn++MPAr7rIx63tEkLJQLRZ9ABs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ908Q+9BRh2Ja4xBvcmsA9QqpM9ISzlkUnJuaxQC/m2Wu+16u35rIfWJbx8ZWMRF0m56jOii/GU31g0p+aNdXBQtxdjD4BIg7lufYWcB8MKdxT4uU1WNWMT6p2k6JqQSh6bbh417FgLovu67iD9qWRDUHfvOkkif4EJEVUV/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpYjVr7r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpYjVr7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776330965; x=1807866965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMt9DQos2cpVVgP4fn++MPAr7rIx63tEkLJQLRZ9ABs=;
  b=PpYjVr7ramYsSppl1b/8q2FOhynb68XGTNfGdTiot7EYI8ijRGyXXnv0
   2Xm1cj47lTgxo2bnGC1WpErZl5xdZG0snDwsvSx1yqzjStjW3y6+HM6ni
   lOlORYY6Xf2/MydVXsr4F4X+Ud6tD+Jce4hvLFbXpgnmFyAgpuUSgWzPq
   b4NjSBqsef7T+ylrbPVa4I7a0CVp6E3/+ZlIZGw9tj5+ukR+3u2Raq51s
   EQ4V8QVDGES1e7Oz6k9Iv1TvUjd0hA/rjVHHCD+DkP4HPUE5P2zT96VPY
   uE7EVUe7kqWFutl0n4sGibl2hqbgN7uvfRPRyvh/n8eFSmJHHedOiWqEe
   w==;
X-CSE-ConnectionGUID: 3v2vzbOAS1arFYyr5l+0kg==
X-CSE-MsgGUID: roWnoTIHRg6nVR6NRjh4SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76357041"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="76357041"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:16:02 -0700
X-CSE-ConnectionGUID: QGkZ9pZIRn+rvS55OEwPjw==
X-CSE-MsgGUID: AeIVE6OqSxe9vkUI9MDuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="268674213"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 16 Apr 2026 02:16:00 -0700
Date: Thu, 16 Apr 2026 16:54:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: PUCK follow up: Trusted IO call details
Message-ID: <aeCjq46ljL6iI9r6@yilunxu-OptiPlex-7050>
References: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6e9052c0c748f023e880503ed0001a9a919599.camel@intel.com>

On Wed, Apr 15, 2026 at 06:59:05PM +0000, Edgecombe, Rick P wrote:
> The call I mentioned is officially called: "TAC Subcommittee: Linux Kernel Special Interest Group (Linux
> Kernel-SIG)". This seems to be the info:
> https://confidentialcomputing.io/about/committees/#Linux-Kernel-SIG
> 
> Paolo, unfortunately I did remember correctly that it is not an EU friendly time. Also, it appears to be
> canceled this week.

Here is the Link to Dan's call.

https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be

Dan said "The April 16th instance will be cancelled, but will pick it
back up on the regular schedule on April 30th"

Thanks,
Yilun
