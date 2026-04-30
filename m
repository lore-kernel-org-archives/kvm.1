Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9B375F69;
	Thu, 30 Apr 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577871; cv=none; b=oCNUlTiNBFkl+Ol38Ew0S+/YNNi2hqP/crIOetQFNXGQv9fISjvMXw4xd1tpzNY8xBUzwQfJq8G8Z5hCrxufr6AVem33MD+/nmqq7S8dKH0B6pYsRxWdm7yp7fwC0K5LpuG54zwLY7kKfxp1EG+bPJUkKlc+ccj0QcnExA6ORsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577871; c=relaxed/simple;
	bh=PK0LEXe3TtNKQhIlbceGzGtKMvMj/2zt+eO6bxlynKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rter6SEJBhBMrVboXEysNS+CCP8SVR2VENiqV+jN8/cQ7B53tBR3i1xjhOy4w5yR/EXzeH3FePjuVNsq4/gYDTp3rRpyE0LSeg55xONCiTreeXpTdPM4NodCm4DOcT+jbPOTnK32XyDK/fSNNlcSFNw4E6OKGOmYF9i0OKcUo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWf17YT3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWf17YT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777577870; x=1809113870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PK0LEXe3TtNKQhIlbceGzGtKMvMj/2zt+eO6bxlynKI=;
  b=AWf17YT3cIYeF6v+NbMXYk33dWOi2RAXwahSwLP3bGueJP4BmLiJDXYi
   PnFZi0CNqc149LcBqJOIfRAZBrl7AaTFlmWtEkYuqxWY+6YXZLzRFyski
   B5DoyZK23CArNWyuTF4GDPd9jXUDfz7uVI0EiozuyFhchAk/KxiGH8+ty
   x/uS3UI80LSfZ0GPEiQb8XK0Y13xYYXyuUbURL0TxZYhmCdAbTN3Yyphj
   YZAAOoa4RZb11vdUUoEBA/GSIcfOvC6r1VZOHi4tVO+WWBucsgEaUmWXA
   s89D3LMYdXvxn5s/DK+GviuJUwZeDqPBrMsQZYwRDm49g+Tvc09RPI7+o
   Q==;
X-CSE-ConnectionGUID: N7yRV4FHR0eD3YXmT3Qq9w==
X-CSE-MsgGUID: TRIz6CapQ0mexEela3L0wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77570727"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="77570727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:37:49 -0700
X-CSE-ConnectionGUID: dlsul9h4Rl6x5ByS+BX1eA==
X-CSE-MsgGUID: a+pkLobjT52J8iy+XkhrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="233640285"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.109.74]) ([10.125.109.74])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 12:37:49 -0700
Message-ID: <3067bbb0-b528-41ae-8739-c49432f9a62c@intel.com>
Date: Thu, 30 Apr 2026 12:37:49 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Yan Y Zhao <yan.y.zhao@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kai Huang <kai.huang@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Xiaoyao Li <xiaoyao.li@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430014948.24226-1-yan.y.zhao@intel.com>
 <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com>
 <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
 <afOrd7JYkUfe7wcZ@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <afOrd7JYkUfe7wcZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 12:20, Sean Christopherson wrote:
>> Yea, this is used to construct u64 inputs for seamcall args. So I think it
>> should keep returning u64s.
> +1.  IMO, we should treat the TDX-Module as an extension of hardware and pass in
> u64s where the spec says it takes a 64-bit value.

+2

In this very specific case 'phys_addr_t' is 100% the *WRONG* type for
mk_keyed_paddr(). Why? Because the thing being returned is *NOT* *A*
*PHYSICAL* *ADDRESS*. It's a composite type that contains a special
physical address plus some metadata in a special "hardware" format. It's
as much of a 'phys_addr_t' as a PTE is a 'phys_addr_t'. Yeah, they
contain and are constructed partly from physical addresses, but they are
not physical addresses themselves.

At the same time, if the kernel has a type-safe way of representing
something that's also a 64-bit value, we should use it. Just because the
TDX spec takes a 64-bit virtual address doesn't mean we should use a u64
and not a "struct foo *".

Let's please just not go back to a sea of u64's everywhere. Use common
sense. Use the kernel's type system where appropriate, but don't
over-apply it.

IOW, I agree with Sean. But please don't take Sean's advise too far here.
