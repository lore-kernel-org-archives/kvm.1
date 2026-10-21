Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566095;
	b=gKFuXbLBqX2eWZGBr3P9mr91bhe4MNc8lFXervFsUwwco4w7YnIZA2nEmr2+hJssiVEC
	 kfKWFl7s71rEtBG7UECPoSZcbQV7i+Lz//yUdB+GkiZ46IsqCNe+1I8XSoa16gHW9vKfZ
	 2KAYDaIPAUhvj5TZLiMAnc6PNppcNcmwLtzJyWM561o/Pk8WEf3DL1R26ckuhc2Y8+fvL
	 RpdD3H9NbvtuvrPxp+pJ2z8oH0ovpawaQUFn+fbRZKSwsYbFqB+v3srfgaBkjkfvnW7Nh
	 N/pn2iCHbsWrvYTiexrNmSWw3RIVH3CsNEEgMc7428REl2rvHG+Mf5I6YA6ME+hS4Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566095;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LW6vT8/bJRD2PuTEJwndC38LlBOnCHCX+4SCfvFcgSg=;
	b=AaZnS8G4I63RzWBwckEWo7+rNdA6ekr5oC9qcLXCjJjpTLf8ys3BNjoNRFa3+8zOx+ZF
	 +DP2RuvL+Y+etVlIxxi6d6dAMihhMs6FaRJwdntBTx2CpWqVU3C/vdWJn1smPGABjc6RQ
	 +CaiVmib1woeJWMG3+Rz6kLQ+X/lvJ3u+EqKk9FK53YmaVAN2cykpEMaqV8pw1yQem4dU
	 2D16duf6CqXUwAOEnz0YRHc5tEKb93Bw5czxLc0LI2fhT1TKz9v3SiPiucmY3k4PPX/in
	 fPPjLjt6oVlB6z1WRjYH6/sEcGHDYVH9lvyWzs4OBCQDG33GfTO1X8Yh1O17SJyJc5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q/vTJsmy";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30042606A31B;
	Wed, 21 Oct 2026 07:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30042606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q/vTJsmy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792566096; x=1824102096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NJ31YHh5++zU4DamiwZUEuDhe5/eYnwgnLLc8jg5Nd8=;
  b=Q/vTJsmye+4m4tZMPhR4vjd8b/BNhtcp8prp8iDmPFwODzob2ghIjm3n
   lGrh9+93OP/AEll0VxQNR3QtrAsIaNEAaDU9eP2CgIKZ1o5RTxuAMAKyZ
   VaC2QcawYn5xehslHiqejT+IuySQzcN4cYEoQ8Kb2xp8r0WNGFI0MR/OG
   S+qQ9g9qh3L/Ebs+TIadGBhFJ76P33Tf+h6C6r3b/EOKeLCIg/kFro6Er
   0u9MeSkyNk80z3zMvFopV1n/aggR3xB10aAGDCSJxliaGq1dTHgSB1OSm
   F+WGeYKXFw9X7maM9POws+9+/9uaVpIYo6kmUDMf0jUm1Ud8Yg6XIP4Gc
   w==;
X-CSE-ConnectionGUID: HHf49g/DS0u06byCEGpnyg==
X-CSE-MsgGUID: ybdSDO5eTrmAHC5TpXVp1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1298824"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1298824"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:01:35 -0700
X-CSE-ConnectionGUID: e6Co0PlaQvunqGRtRrT3rQ==
X-CSE-MsgGUID: nt3EcC7mQNm5sJP0uFPQeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3026620"
Received: from unknown (HELO [10.238.0.97]) ([10.238.0.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 00:01:32 -0700
Message-ID: <579383f0-3192-49e8-af14-43504cc39ebc@intel.com>
Date: Wed, 21 Oct 2026 15:01:29 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: split CONFIG_KVM_PRIVATE_MEMATTR_VM out of
 KVM_VM_MEMORY_ATTRIBUTES
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
References: <20261020131447.122096-1-pbonzini@redhat.com>
 <20261020131447.122096-2-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261020131447.122096-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/2026 9:14 PM, Paolo Bonzini wrote:
> With Linux 7.4 the "private" memory attribute was moved from the VM
> to the individual guest_memfd file descriptor.  The old semantics are
> available for backwards compatibility via CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> However, this ties support for VM memory attributes entirely to
> a backwards compatibility symbol, which is a problem when adding
> VM memory attributes other than PRIVATE.  Thus, make
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES the equivalent of the old
> CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES, and use a more descriptive name
> for the private memory attribute.  Do this now, instead of waiting
> for more attributes to come, before distros start adjusting
> their build configuration.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
