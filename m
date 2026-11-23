Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417012;
	b=i9hrxOQjWSfqc+khPw1/9wYEOvdrQw/AISYiKQTnG9yVEskcVYffAz14oSM4P9zDBw1J
	 9sBSwTq190k+olmIeC5y60Xn9PCMDmQD2RpwuL1K/kHwjib5u0fZHNdkEPM3v4zWv90CF
	 VNJcTnbabmUydMAPRIT5gYrC2SzgGDAYsYXtNH6uEXThB41ymfdFPZ3vQ+rrwEnhCmAm+
	 C7D/UD6IJMxZIGZY6VXsbbDaKqPDDQv3Lpjmw8dXTjHMPqVoJBFESytgZ4+JJXj8z94tG
	 ny8otFfkIJRf+eajk7WV6j0mGywI317XEE30f0qI6s4erXPRi0ARwIm63rXdSnKTt7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417012;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QPC2xSiezq9/+xbCAN6Ly1G7V33iCP9kEl4PZLvCvTQ=;
	b=RDXy9KyDQkRtCSZyHoQXx3jNdN03+OOq4j8kNWdDjXBZEeG4nY+aVKiWI0NL9fFMOXAv
	 7f12Ro4KJYbTJQpCSz8w9UZHo+fxa0mqHJOCdEGAfcnT9t2SMwTVcoNPaFvN9qO5zeiJ3
	 EIXBQ0/Q5VJc9bIBqldzXy2WmbrgWqP7xesBwG+60PKFUjttWuro5zfKFUcQEVqJGB/3B
	 ERPG0TD9RB+/CuLaMeQyJ3As35VlEprjHVbuyrDVhF1bFAcx0ofKb8A9gWUmDnW6Sz1CK
	 C1T4EyNffRurIbgMFBXrMxvPCd+dn+CHGCvGv4Gy5xz2DVq86wzd3cF949IEsm98iJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jwDiOS/K";
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CF606A31A;
	Mon, 23 Nov 2026 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 038CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jwDiOS/K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795417012; x=1826953012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4z3/TUhePIQkYeGiWHGOtPC2mWHdb9QMrezfaVrRXTE=;
  b=jwDiOS/KwucFVVNmcZRrSHZU76gZboWUmc6yOlljuuUj/85jexaRqwi1
   iYpYFOpJ72QnrCL/dlgbfI6+iZmhtSIJH2Nbevpbxhp6+cLIWvdi6x4UF
   R27600YTGNoMEf4VPCQgir0oQjocftN2zjijpMYV9z5oFJZTrbH84siIs
   FIGpWRwnAP3f8GqeI7Sz2CWg6Fi8Smj82QjoaMgycZGXm4Y9EYJgw2ZA3
   Ds2+bH3neNDBIhd07Z03E23BCyiGuP+SENSL5aYX2+gsbfAOmDkXxD/Bi
   AyaTil2IqKTDp19sMVAVn2ik/UI1meEJ8ZoZBkIvM8nZ0H4xf91gqdfAn
   w==;
X-CSE-ConnectionGUID: PazZ1ZOCSeeq1nOuSwsF/w==
X-CSE-MsgGUID: 2EzVEajQQ22ghtjlK0iS7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4123822"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4123822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 22:56:45 -0800
X-CSE-ConnectionGUID: RapmhKIQT4yLfAwgdOH2tw==
X-CSE-MsgGUID: YdzHOtYnSqiOQ8sIKG7O3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11426154"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 22:56:40 -0800
Message-ID: <f29fb935-8877-4488-861a-3c88c12d664f@linux.intel.com>
Date: Mon, 23 Nov 2026 14:56:37 +0800
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
Subject: Re: [PATCH 2/2] x86/cea: Index exception stacks by the ordering enum
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov
 <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Chao Gao <chao.gao@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261120235025.2809042-1-sohil.mehta@intel.com>
 <20261120235025.2809042-3-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261120235025.2809042-3-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2026 7:50 AM, Sohil Mehta wrote:
> The exception stacks are generated by ESTACKS_MEMBERS(), which pastes
> each stack name into a member name, once for the physical storage and
> once for the CEA mapping.
> 
> The macro used to be the only thing keeping the two structures in the
> same order, but there is no ordering requirement left to enforce. The
> stacks are mapped one at a time and have been paired by name for a
> while. Also, the sizes stopped matching once the #VC stacks became
> config dependent.
> 
> So, spell out the physical storage and index the mapping by the stack
> ordering enum. Also drop CEA_ESTACK_SIZE, which just duplicated
> EXCEPTION_STKSZ.
> 
> The stack addresses and the guard pages are unchanged. No functional
> change intended.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
