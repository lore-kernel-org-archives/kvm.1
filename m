Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9A24DCF6;
	Thu, 14 May 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779069; cv=none; b=WES2lMobpr8FGTcjOZQYBg8t18LFVD/wizvk5BXqPWPT75ZQyqMZxQpIFtF5YnbvVgxaEa2l5CAAYN5ZScoHPsAyPBJeCQU7+z9tjrY5UCjIkoq+Z4rCk3lYaNBzKkcFSYuHfORzxR8R20cECoM2m2g20hVW8ZNpEk0YQFYdDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779069; c=relaxed/simple;
	bh=SgR0N2Ki5fBA5Ifg838B48wUNmKlbgf7iRjRF2QdGaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqlbqmKzDP/ViANs84i2/nyPHLi16+B3rrz83irw4cMfbtvYRtOqtIb5/Fh28hi/uA1MUVApR3AUPC8QqhCBTBNTCjLuDBZXSJ7zQATqFZH/xgToOAlUi1asth6QYwbh+BUa/IYfufhHexdSXxnAau3vU4sJy2FiQpSP+br8VNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haOa3zyM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haOa3zyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778779068; x=1810315068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SgR0N2Ki5fBA5Ifg838B48wUNmKlbgf7iRjRF2QdGaw=;
  b=haOa3zyMlYiMQqKi7qbN0LW//qJPLlyBzY7Hs5C4+puA3w86tdSja9eR
   H9+C7BbeK3N4hGzM05bg7QxigZyxEE17Ibn0SwCkKLPFjY7T2Z5Upxsvh
   dj8hK6MUEuci0JYxy/eOyOuwAq/jBRxNRU4Fr3FdxNU8gTKa9cFIYWEAC
   oZOiqKhgE4kn5F75G3BmYf+OZqrGIAWhr6TrgXn7oCT0TzelPa8rUpZqh
   8T8i6P5szuOQrX0AtJArqG34105WOdzcmgY4FRVPurNzVGSF5ZUbK+pqJ
   oj08LC9cgjpxbrdHrRt2aW1gqRvqzHUW83/ozSzh2DRjWpqofjPEDrLlZ
   Q==;
X-CSE-ConnectionGUID: 5h3MZcabQu2YVBmBWJMvBQ==
X-CSE-MsgGUID: oU0WVfOeTHqZ9bsQUgMJuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79847444"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79847444"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:17:47 -0700
X-CSE-ConnectionGUID: SMnq6oI6QOWHO1evqDbfcw==
X-CSE-MsgGUID: 06y3Diu1QN+I5NrEjNYudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="240271431"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.103]) ([10.125.108.103])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:17:46 -0700
Message-ID: <eacff6d2-50eb-4ac1-93cf-f5652651df70@intel.com>
Date: Thu, 14 May 2026 10:17:46 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest
 FPU
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 chao.gao@intel.com
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com>
 <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
 <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 09:04, Paolo Bonzini wrote:
...
>> Couldn't we, for instance, just let the APX registers use the "fpu"
>> ABIs? PKRU is weird too, but it still gets to use those ABIs.
> 
> For PKRU it makes sense because it is not kept in the FPU even for the
> non-guest case. This is not the case for EGPRs, but I guess it would
> be the same if the kernel was compiled with APX? If the kernel entry
> code would have to stash r16-r31 from userspace before entering C
> code, then we can add similar "unsigned long *egprs" arguments to
> copy_uabi_from_kernel_to_xstate, copy_uabi_to_xstate, and likewise in
> the other direction.

I think we're getting into the weeds a bit. Maybe we should focus on how
this affects the ABIs and work in from there. Like you mentioned, we
might or might not have kernel APX support and the ABI should make sense
no matter what we do inside the kernel.

The functions we're discussing for this patch are:

	fpu_copy_uabi_to_guest_fpstate()
	fpu_copy_guest_fpstate_to_uabi()

which implement the meat of the functionality of these IOCTLs:

	KVM_SET_XSAVE
	KVM_GET_XSAVE

So the question, visible to userspace, is whether the
KVM_{GET,SET}_XSAVE should APIs should be able to manage XFEATURE_APX
data or not. If we decide *not* to manage them there, there needs to be
a _separate_ ABI.

Are we on the same page so far?

If we _just_ look at making a good, consistent ABI, I don't think
XFEATURE_APX is special. The registers can be managed by XSAVE. There's
a KVM XSAVE ABI. Why would *this* feature be special from all of the others?

I don't think the fact that the kernel is using those registers as GPRs
changes what makes a good ABI. That's a kernel-internal implementation
detail.

Now, that's not to say we should ignore kernel complexity. Maybe making
a nice ABI is so nasty to the kernel internals that we shouldn't bother.
I _think_ that's what you're suggesting.

Is that right?
