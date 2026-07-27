Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE52F872;
	Mon, 27 Jul 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142322; cv=none; b=Cf/eZOw59xBVYOJuvHR2ctPeYeG2HZ/rxupq+Yep8z5QqkJJe81h1wu2p3o+dlihlA/BX+/ujMxb9aaD/Kucg92lgpIVraIt+h6e4tO57NEphfUtT2vuz7sw4DOnZrD1hzbOReXUPEar+8vUa1c/RSr5lB4x4o6Z+C4EfsH5RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142322; c=relaxed/simple;
	bh=Qi2/Amy+Yz8pYiHcdsnU06L/Xea+DV6gN99v8la2fmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmftn3V/g83C7YRbfz33OtOMesQo5xuu0ACU3ufq0bM9TLxB+X9OEJnduWKPdzc4oMhr34Lr+MIQCCah6RTTyOAQR8LpHnnkgldRowqu4rh5l7AJ9EflACOrcWa4059bEQ3vrqc1likGhDfEOz8j3CYSwqulCjn6YFcsG/Zu02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4fk6uTc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4fk6uTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785142321; x=1816678321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qi2/Amy+Yz8pYiHcdsnU06L/Xea+DV6gN99v8la2fmQ=;
  b=G4fk6uTcCeraUhfm5mgvPWZ+0HFciTkZu3feZiHb/VVefJ2hID+1yKuM
   +JcGvfy9YDNtrQKcOMmRa+dvADS7tI316H85AKvqIkwO3fVb0y6DodYl4
   755nK5NDq3e+rgczqkZSBgPRWGl+CzBtFvJZLa6LRsgoKlUtph4rfhFi1
   PfTxF2eZB5rhfAkiMNYBeU4up0NGlRmfExK022LIY822ctqZMAOATwYED
   a3q8BLvI4pQosyyZMSN47au7TDvBHw+F2fCHmZZOQp+xdn64Vg9Y92v2D
   IKpY+5aBpOPU8GRfwHniOS1L1wbdT+8SVJDU9gzNfmQXwdoHZMob4wlzJ
   Q==;
X-CSE-ConnectionGUID: hIIzeWoZTjynJRI766epXA==
X-CSE-MsgGUID: 9+ukbRXYTG2IMyfUHfy0eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="85896311"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85896311"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:52:00 -0700
X-CSE-ConnectionGUID: INT4cdWiTXuooT/icHLmQQ==
X-CSE-MsgGUID: Nb2tP7sSSvyjbOAn6ATCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255421600"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 01:51:58 -0700
Message-ID: <e1b65566-7b5e-43f4-92aa-fec27fbfed80@intel.com>
Date: Mon, 27 Jul 2026 16:51:56 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to
 gmem_make_shared()
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>,
 Michael Roth <michael.roth@amd.com>, Fuad Tabba <tabba@google.com>
References: <20260723210811.72720-1-seanjc@google.com>
 <20260723210811.72720-4-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260723210811.72720-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2026 5:08 AM, Sean Christopherson wrote:
> Rename kvm_x86_ops's gmem_invalidate() hook to gmem_make_shared(), as the
> hook doesn't invalidate anything, and so that KVM doesn't need to add yet
> another vendor callback to support "convert to shared" once in-place
> conversion comes along.
> 
> Opportunistically wrap the ops declarations with a GMEM_RECLAIM guard so
> that attempting to wire up a .gmem_make_shared() hook without selecting
> CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM will result in a build failure.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
