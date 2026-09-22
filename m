Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92938DC7E;
	Tue, 22 Sep 2026 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043423; cv=none; b=G3P7oPwrzsSidJzQ7HGoEjFF3cCXRFfWfVEssxIpf590Zdx0hFF5tBAyigpaySQaSfa2RANZ766MHtx6ylC/XI6h8bxRAtndbSM8ycX+dkcdPVIXkpZmgW/4RrgRhKRL4w0xI1d6JZUWJY3F8hl0ftL/6oPiN8gTV0Fk0354CMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043423; c=relaxed/simple;
	bh=nXBRK9QHnUKXIzFOAw0hN53sY//YSFicelihEikfKo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLCKO0f9YS0zRO1upuQIEx0BNET3g+r4mkt3g7PQwtsx5iGBAUbBKbAmqtyemCL1Nms0dic6Dz42J4m7cYFXYpRSNB05VkGgtBVOTLzzmD8UYNsUTVSkbUDwoHw735Msl+H8Oox5MKgbo005ZSzRJn5mGpovvZKfXw2m3LLUwAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCH4a+WN; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCH4a+WN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790043417; x=1821579417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nXBRK9QHnUKXIzFOAw0hN53sY//YSFicelihEikfKo8=;
  b=SCH4a+WNkjDzLpbjD65EV6pcycy5K65Sm20rRj3GDUFV1TZZ/XErkwiA
   L1jUyURWfeV33MpzUFXcN3r1mKIrmfy49Tt9VFKchwMkFNY0zbCRuL3Ko
   xELVEwVtQkzuz+YFq0TzhkGu2Adb/gDHt3U6qOVS8osZoNIfREds8Yd+R
   +oFr0YMkYyUQHWCbVHGGeg6QmtBgBrMI+ETaNwaLiDpfAuceMq7cPYg9r
   uNXXDIQ2mmU/bVbFkaqcokfCeyNi7zhIjhS3CIaeWC1MPTeg8CJds25Gy
   NlFpGjqYPNpoXxdjhOSXNUIxcSmzkp3ShdUBYKmKI9oncqFmZmWgG4JVR
   Q==;
X-CSE-ConnectionGUID: Bod8DmeDSD69erLXwmwK/A==
X-CSE-MsgGUID: NdlkX97qRJOYPqI5honVAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1111510"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1111510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:16:53 -0700
X-CSE-ConnectionGUID: 9djDXn0kS7S/5/YRmnT1hQ==
X-CSE-MsgGUID: 474vMr2oQkGdG4YI99fOdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="271454774"
Received: from unknown (HELO [10.238.208.182]) ([10.238.208.182])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 19:16:51 -0700
Message-ID: <cd58f445-34ca-4239-b5eb-deea1dc65128@intel.com>
Date: Tue, 22 Sep 2026 10:16:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used
 for failed VM-Enter
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yan Zhao <yan.y.zhao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260921235656.1107929-1-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260921235656.1107929-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 7:56 AM, Sean Christopherson wrote:
> Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
> to stuff the exit reason on a failed VM-Enter so that the magic can be
> reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
> defined value (though the whole "dead" thing makes it pretty darn obvious).
> 
> Opportunistically add a compile-time assert to ensure the KVM-defined exit
> reason never collides with a "real" exit reason.
> 
> No functional change intended.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Binbin Wu <binbin.wu@linux.intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
