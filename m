Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664400;
	b=WUomDt012EDXE8qM1ORWvCzj9zD9CurmJ8IYGOvC5rmlRvjFqjvGagC8RCH0484Kzj+6
	 kZE9Rh/yXzbaSJkv70mEvzft9i44TF9BdsvY9xSAcwUtWeZjVGHt7ZRPrAH3Ob1OsPPMV
	 xpJylkB41D06B604Tvu8Xo45Mou9pLwwV8jTwbkANH7EXpOaBzd32RSVp20/SzpASJtfm
	 98xV2NHYCedBZb6QKeAMSp/7mqJXNy/xaZqIG1kMtj/BGN2KjbB2pkaro/oeVBoibxu9m
	 cBhplIK4I0AehIBrcCfSvqSXQrgnh5FFmt44tNAS/IvCgTUHhjTMU8Yn49iYuqyqCyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664400;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XQVVLU1ba+/S8iuiGlDoA5WyXQ1PRvRtOLIvZ2/GYJQ=;
	b=jQzfgCDISljHxVVC9oGVNHBWlDygbDqxaUK6okOSMBLJRJczjrfTA6ESXBn7DXt0bdFV
	 opudNOhWcuEp61qZWCwDy1MytJnCDh91DNSx+DmAsEEKcprGbnNiyCraUMi/egh3POkY7
	 nd9qsmdVpEMbGXCT3GkNs4ZVKefk8yASVw+AqowMYf5asawdLgdfJxZUdnw7kGNqRKfnc
	 p0H7vzq/pW69SH0r5mai7JipJNl7oUDpM+Cv0EsUB6GWee4bhC7uBlulddg6M0F6qaYN0
	 BFT970QXWaUzdHsVGWazR8S39KdLqe9+UwiO1zWS0u348cJEinBKgfDocVlWdvi9e4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GFFkNQFo;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7D606A328;
	Thu, 22 Oct 2026 10:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B7D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GFFkNQFo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792664400; x=1824200400;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vOJ6/0++mOl7qApE4su+Jm0d7iydeaP6y1XwyXgjbVE=;
  b=GFFkNQFoJFquml5ZyOmme98xt5ZRVlbxRoaX0413GWm5zhwLuG/KOpKN
   l1iUM0NpzvcnOSYq9ovssA+kWzsdwImYeXTjGlylbL/sSlM/2SA4b6D0q
   tKTwdHeHu4SY9bPHaA9zGA7njLkw+CReR913zLD7SeX05tyx7LhvTTxJp
   M5c95Db67PveiyFt/hZnNFbDVmHPbuiZC9dNE8L83F+KQa4RSzMVuA9vn
   AYg2PzWpD/KNZTY+wWDFm6j0gfyw3C7SSuaLRm74uufoLKQgLAGpOou7k
   luSv6NwOiATbsrnIlsNgCB2JIuLPy0A+VVcdPAYomnkz0tPmjVZhY1ARd
   Q==;
X-CSE-ConnectionGUID: NIMUUjofRfuAwBUIR2Zm3w==
X-CSE-MsgGUID: UT1wwQ1TTOycM8ns3FE67g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1283739"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1283739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 03:19:59 -0700
X-CSE-ConnectionGUID: IquNoKwRSpOeymgTemNNSQ==
X-CSE-MsgGUID: s4sl63QMRFuqWBh8ghVoxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3249362"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 03:19:54 -0700
Message-ID: <dcb8571c-47ba-4da8-b5d8-9e7708dd2466@linux.intel.com>
Date: Thu, 22 Oct 2026 18:19:51 +0800
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
Subject: Re: [PATCH v10 03/28] KVM: VMX: Disable FRED if FRED consistency
 checks fail
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-4-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-4-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Do not virtualize FRED if FRED consistency checks fail.

Nit:
By code, it only does one check, so it's a bit confusing about "checks"
at the first glance.


> 
> Either on broken hardware, or when run KVM on top of another hypervisor
> before the underlying hypervisor implements nested FRED correctly.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
> v10:
>  - Remove the comment about why not check FRED VM-exit controls in
>    cpu_has_vmx_fred() (Sean).

Although Sean didn't want it in the comment, but is it acceptable to put
it in the changelog?

>  - Remove redundant parentheses (Sean).
