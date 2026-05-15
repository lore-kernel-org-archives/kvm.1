Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274153AC0F1;
	Fri, 15 May 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832483; cv=none; b=CTfTsd9rOCw/R+SePUAXjw1jlb3b8DKO3mKLPYg5dynqJBVdTNbR1LKdlm/1UnWQklA66vQMs9LxFHLxBKC5I5HT84/Lrw2HphaCIQAft/lEEoi7BVEaRNsygOTTMYQcHEF58uSdKlyBBk2n7j+DhUbeJYC7ikcv3HpAayySzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832483; c=relaxed/simple;
	bh=L4xbnILFtQfwMZuuoR5NsGg7CtsktiFxrV89yF6moFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAGRT+xzlyKJGH859ux4OTL2BJ0WpR1cZoII9/bjU1B9O81gdrGNbkwSN9Xzn+KFVs+AQJn2KiPmwR/di0WmIa2wd6q2k4CjxKKfM0jdLQOgevFc83GS0koap6s+4t93J0xfmtrM3SMjfP13yvllDd3g09lugBPCd226BV261J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gefy0wCB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gefy0wCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778832483; x=1810368483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L4xbnILFtQfwMZuuoR5NsGg7CtsktiFxrV89yF6moFo=;
  b=Gefy0wCB4p/hM96mK9AP1Yof41NcqKz2kPYOz5N8jzDps37I3DgvHbs3
   cc92aasQK3CMspTfjRR4pxWb70yz1H7CQ/uDgjUkAl0LCl72F7Lgq1pON
   a9ZzBalNZS38ueNQyErPHsdOsByBnK+jHYfTS48FlkJeE2Yfn9EWi2XXi
   nYisT2nM8VuVH/miDRn0f2+NDJ5NrYRZs8L0Wiz9JLGDbA/Or1Eu0HVPd
   xL8ViJ0P8dlGCy6EQQkLazQVp9J9t/SJYi98LMgWjIBuCbpjiSjO/AQyx
   TslflOZtOd5ZyYcu84L0EAZMKt9W4OhrFnvwJ2veVrWH05ut6+Vgp1LUN
   Q==;
X-CSE-ConnectionGUID: XYZvr7LgSCWvMIyJIr/UqQ==
X-CSE-MsgGUID: 2LlReg5WQCypyXN4N6U+Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79827879"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79827879"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:08:02 -0700
X-CSE-ConnectionGUID: +Yr8M2E0RnygKRflOpKtMQ==
X-CSE-MsgGUID: PTnhYfUVTG6SzWxIQvNCMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262388372"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.240.207]) ([10.124.240.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 01:07:58 -0700
Message-ID: <03a5b39d-886a-4fe2-a9bd-6a8bda571a8b@linux.intel.com>
Date: Fri, 15 May 2026 16:07:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] KVM: x86: Move inlined CR and DR helpers from
 x86.h to regs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
 <20260514215355.1648463-8-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260514215355.1648463-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> Move inlined Control Register and Debug Register helpers from x86.h to the
> aptly named regs.h, to help trim down x86.h (and x86.c in the future).
> 
> Move select EFER functionality, but leave behind all other MSR handling,
> There is more than enough MSR code to carve out msr.{c,h} in the future.
> Give EFER special treatment as it's an "MSR" in name only, e.g. it's has
                                                                    ^
                                                                   it

> far more in common with CR4 than it does with any MSR.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

Nit: The shortlog doesn't cover EFER.


