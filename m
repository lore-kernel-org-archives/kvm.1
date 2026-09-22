Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD064EDCC8;
	Tue, 22 Sep 2026 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116725; cv=none; b=Vv2SeQDj/E6LCVOIIfoS3ZI1VkdIoAIXcLe1wra15+BBPRNe1jrvfRW4x6HaFrak22VtS6uEBaCfmJtUD4d3ykwWW2n9ihxHu6nbC68vPZCeABbnyG78yRbQHMU/lTXA+N/Ugpe1OADG2PD8ljboHQCMvF7cyAkMOzPdRV8Y2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116725; c=relaxed/simple;
	bh=Xu65AFIawlYizxpmzwr4U/pdnhBGbXmHEBuegSL5sLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIZM3TjYDSabhcnR3BloegwzMhDnVIC6vbGlUw0bqpM5jlQKLzov3toA8Ge3GuAPNbYk8Gg7N2toyh5ZQmm+H+cjJjUhI6R8Fqm7OtQXlCYlNS7jfdOEPL92XqWPp+F506dUIOUx5DfTDzHoQ+fUyn00EQvCmqdMGJJQlW10T5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TADOecd1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TADOecd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790116717; x=1821652717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xu65AFIawlYizxpmzwr4U/pdnhBGbXmHEBuegSL5sLo=;
  b=TADOecd1IkRTtK3xx5+ibSqMo54xElUBV1TxdnhL/+/i8r8fqjsmNxze
   aZiHH8JZoLaz7me9NnsNW6ML/NpB7QrCDJKXORhkmpdZ9qnnxDnzixKyh
   WjWlD/RC+iWiew2qw1kFl/muFcggR55myfIYDMbRS57tEbn+drFmmFOcT
   jeg9mac+Rr4E1s7QRicArKzHExFUrc3Uj/vMFysDMNiULN1y77d4cgvPH
   ovwpRJd8sB4zeY9Vvy9GJZBh9Vd/2RPc1GgS5J5QDtML/ShIr/2XEb3oD
   kUZS+nBM6X9Phr58LkAlyQhsWtfTwLQfJnobTE+YxIiwRqdDRYkNo9PEY
   g==;
X-CSE-ConnectionGUID: wF9G6RycSiGc0WNcao80UQ==
X-CSE-MsgGUID: GJPmi5A0QDCb+ggnqICVNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90788363"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90788363"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 15:38:30 -0700
X-CSE-ConnectionGUID: j7CJg5pKQ5iGjT9AU/zfdA==
X-CSE-MsgGUID: ZnTENF3HQk+lx6QUPeyYGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="272816914"
Received: from gmitchel-mobl2.amr.corp.intel.com (HELO [10.125.110.75]) ([10.125.110.75])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 15:38:29 -0700
Message-ID: <199d392a-02da-430b-95ee-b176ed0f43de@intel.com>
Date: Tue, 22 Sep 2026 15:38:29 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] virt: tdx-guest: Use a variable to store the Quote
 buffer size
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
 <kas@kernel.org>, "Fang, Peter" <peter.fang@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
References: <20260915092632.2822169-1-peter.fang@intel.com>
 <20260915092632.2822169-4-peter.fang@intel.com>
 <620e7e38-4287-431c-8285-575c84aa1f6a@intel.com>
 <7ddf42ab-2f78-4edd-be39-ff9e5156d51c@intel.com>
 <1e6ed0923fe1ac938f3e0fa0f8d05d31eb2d0f31.camel@intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <1e6ed0923fe1ac938f3e0fa0f8d05d31eb2d0f31.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 12:46, Edgecombe, Rick P wrote:
> I was suggesting to make the new seamcall wrapper consistent in how it gets this
> data by referring to the global definition for the global key id instead of a
> parameter. Seems like it is against this feedback, can you give a quick take on
> that case too? I just think mixing global references and global values passed as
> arguments it too weird. Should we switch to passing everything as args even when
> we need to plumb it through several layers?

There's no one-size-fits-all solution.

It's really powerful if you can pack all of the code for a single
concept into a single small function. This pattern:

	int foo(...)
	{
		static int __bar;

		if (__bar)
			return __bar;

		__bar = whatever();

		return __bar;		
	}

Because you can, at a single glance, get all of the context for foo()
that you need. When it gets set, who sets it. But it also only works for
static, write-once data.

As for passing things around through several layers, it's OK to do it if
it adds clarity to the code. If the entire point of a whole chain of
functions is to get a global variable set, doing:

	foo(&global);

can make things clearer because you know *instantly* that only foo() and
things that call foo() can modify 'global'. It limits the scope of time
where 'global' can get modified.

Think of if foo() calls 10 other functions and they all randomly
reference 'global' directly. Figuring out how and when they call each
other and making sure there are no calls from outside can be really hard
to understand.

Passing 'global' around can make it really easy to understand.
