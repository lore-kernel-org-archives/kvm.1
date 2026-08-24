Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C83B38BC
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549989; cv=none; b=mdvwIE+YQMqKlfJwamU0eD2Ho284Z+aPgnoDaPzG8I6MlyLtCLK+8WSkXAMti6Zu8NyUSwM9EIpFfQyOlbMQNF7+QD4Bq30B9DT745bXyNP347yHZA9Wy4z10OCtGUvO5q7e6YqlwN8b/99wId1BzGPmg/qD7kfFPvZlIKSiNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549989; c=relaxed/simple;
	bh=t9jSKFqj4qNlGtrhWAFP8eR/NFKt57x0hrrGS9wN5fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc7LyxVRJr4Ijx2ElZ52q2zOCNviLAobvedWlBfHPeJ8DvlrGcWAIhPTK1hLCc3n1RuK++xGm1pfn8+lRrGRt+5/dt5BZKemKt3wTQeDnHUyMxsNwXXj/HCjLJztrK5d/eEPuEkGUHM/XPruknzPSGM0Yuch9DiH8d93Y80Ffi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDUYk6DF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDUYk6DF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549987; x=1819085987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9jSKFqj4qNlGtrhWAFP8eR/NFKt57x0hrrGS9wN5fI=;
  b=DDUYk6DFSFHNN5DqKcGF2DKfPvxnpr5LeD3q4g1t4RYB9/V2H4WJHS3U
   zEvIv+F+snrdsnaNWXsiTVp9yneUjEP4yQLL37YBJ/XJRVWib/gGnJTyO
   XLlyS4s5dBfAshURrBAgAAq+enoDHb4Y8R8/qlp2+R0ag+4B9b5UnXIm+
   4J1wCfopGkdjszTvwQLyzB2D1Wjhla6bl9QYEOjWIWOWVOgDNptd39ch9
   jix2CAvZPNB6o2lWO4iCNR6btJ6J3c0Il/XXM6V+qMLS2X3YbFeUD6Zn7
   zTyfFWZy63SszAsGCulKJmQD754avz2yw4iFqleo1Gt9oxS/zms6ARayD
   g==;
X-CSE-ConnectionGUID: PHaXn5KZQleUue5vyBf4xw==
X-CSE-MsgGUID: xOXfmjE1QVOoQol3QoxGBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="75530626"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="75530626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:39:45 -0700
X-CSE-ConnectionGUID: DsviJ1zBQia1Im1JhQnMYA==
X-CSE-MsgGUID: hXwX0MFFQl2ra9FQer2WTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="263187285"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2026 22:39:43 -0700
Date: Mon, 24 Aug 2026 13:39:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v3 06/10] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <aovZHhGT9nRfbb+C@intel.com>
References: <20260824045314.162941-1-zhang_wei@open-hieco.net>
 <20260824045314.162941-7-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824045314.162941-7-zhang_wei@open-hieco.net>

On Mon, Aug 24, 2026 at 12:53:10PM +0800, Tina Zhang wrote:
> Date: Mon, 24 Aug 2026 12:53:10 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v3 06/10] target/i386/kvm: Use AMD PMU MSR paths for Hygon
> X-Mailer: git-send-email 2.43.7
> 
> On SVM, KVM uses the AMD PMU implementation and AMD PMU CPUID/MSR
> layout.  Hygon guests that enable PMU and request AMD PMU CPUID
> features such as perfctr-core need QEMU's KVM PMU setup and MSR state
> paths to use that layout too.
> 
> The relevant QEMU KVM PMU paths are currently restricted to
> AuthenticAMD guests: host/guest PMU compatibility checks, AMD PMU
> information initialization, and AMD PMU MSR save/restore.  For a Hygon
> Dhyana guest with pmu=on, the compatibility check reports vPMU as
> unsupported solely because the guest vendor is HygonGenuine rather than
> AuthenticAMD.  If the VM continues, QEMU still skips AMD PMU setup and
> never saves or restores the AMD PMU MSRs for the Hygon guest.
> 
> Treat Hygon as using the AMD PMU CPUID/MSR layout for these KVM PMU
> paths.  Because the PMU MSR layout is shared, accept both AMD and Hygon
> hosts for guests using that layout.  This intentionally allows the PMU
> compatibility check to pass for AMD-host/Hygon-guest and
> Hygon-host/AMD-guest combinations.
> 
> This does not enable PMU, perfctr-core, or perfmon-v2 by default for the
> Dhyana CPU model.  On backward migration to older QEMU, Hygon PMU MSR
> state may still be dropped because older QEMU did not write that state
> back through the AMD PMU MSR KVM paths for Hygon guests.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/kvm/kvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

