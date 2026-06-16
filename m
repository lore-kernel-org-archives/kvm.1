Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC3BFE44;
	Tue, 16 Jun 2026 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576765; cv=none; b=VRQU6DQSWy02P4qeExZoh+4LE2LPAeIW6ufdMJS4+d1f9teecOkxPgk8Uu3/ZTk125uSKNuiJGYqaiOJ2yexhcLU5kv4xr9cDkmecw/t3Q8bVR+O+0ml36VCv8x3S4XGhLXKjxj6bniKTxPVd1S4RctcinYKraPC7OxA3UoPagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576765; c=relaxed/simple;
	bh=mX6cFnsvzh4y6WtFR02IUA4eXS3FG23ZVfGMcA+9hQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c497koonyKSdOVLcoTSJsz8x5zT+F38DheGwIa7qoOey1+7uMI1mcH3Zo++ieVLuA9FU0C/trhqYYR/Ew6lshKlkx/729EG+VD2+bOOCz+mBe9e1Ddq56mJ8MnbTB1941RPBkDhNT7JNrxZ5S575wXhXAq1yZbUBK93v0X3raY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=If50ss3Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="If50ss3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781576764; x=1813112764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mX6cFnsvzh4y6WtFR02IUA4eXS3FG23ZVfGMcA+9hQE=;
  b=If50ss3ZngSDW0IhBP6U5zrcEfm6m/ebjnn3X7Pw+pYh5p7Syx9WFeUi
   we4O1hKdV6f0zUUnXVtaltune6GsFqmMH4o78oSQ+rFhAw3FHp5zkuqQP
   MIksgDgWRaV0RApnFDp76oJbYpFas4PFTL4voGfPo3RJcuRJ0qKWlhVIw
   gTItcw0LkM2NnpDYARKMqlJojQAEKstHt1HTtRE5TOvG5e6iEKdGQV9Gy
   E+Gd9qGJosJcXYQ9t8r2nH43YYKZMD/KY4dqaQSEPvgJVBjvSqNS0HxA/
   px8OX9Dxlq4I4feyoTW8iikImiwQ5If3VHHa0wmzb94ar4RgjzLC/gAG2
   g==;
X-CSE-ConnectionGUID: OeqBAMp6RiGDrZjSwjKW2A==
X-CSE-MsgGUID: HP0BdgRQRMCnOYmb3doWHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93822005"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93822005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:26:04 -0700
X-CSE-ConnectionGUID: bJoZfTAFT9CgJfENYwrFRA==
X-CSE-MsgGUID: dYpK6I5cSlCqN6l3uvPngw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="246741949"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 19:26:02 -0700
Message-ID: <6c44716a-ec96-4701-adb6-cd69e54a5dc9@linux.intel.com>
Date: Tue, 16 Jun 2026 10:25:59 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/30] KVM: x86: Move MSR helper declarations from
 kvm_host.h => msrs.h
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Kai Huang <kai.huang@intel.com>
References: <20260613000329.732085-1-seanjc@google.com>
 <20260613000329.732085-18-seanjc@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260613000329.732085-18-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> Relocate declarations of MSR helpers (and kvm_nr_uret_msrs) from x86's
> kvm_host.h to msrs, to continue trimming down kvm_host.h.
> 
> Deliberately leave the funky read_msr() where it is, as it will hopefully
> be removed entirely as part of a broader kernel-API cleanup.
> 
> No functional change intended.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

