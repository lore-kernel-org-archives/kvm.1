Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE252E046;
	Tue, 13 Oct 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932850; cv=none; b=R57IuXy41HpY7HTsYqM3dAb6GH1vrNH3obVpjiux2VccJDxAWpejjHh0WUURT+A4fU0kZ4hajm2iL80sw1kGfUleWf7GuZpsmC215ttP1hn6nSI+iF4PXWcXHe97TG8okPpSGaDEiGMpVlXcAeWvNyf4xEmbAutFXotFFj2JnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932850; c=relaxed/simple;
	bh=3y7Xw7YkNHnuviBgkfoYmKWc1LtddiF+VIJ9Q5vJFCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGGGf1V/ukRxL4i2/NMVdReXpCDL4H9zxYf0TRZiqyQFezI6aIAWmeeIGwS90lgdd/rkPGsENwHq7iebT5UUTdJt/v1NBgB/iz5LB3IcG2X2EJcmSF+3A55AYZGVIpxlsk/56YxLgDWOtFuJltEQOgKGyWsmD2663SIV6Tjz0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TzF5CbIh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TzF5CbIh"
Received: from [IPV6:2601:646:8003:f231:356f:4b4f:2ec9:d15a] ([IPv6:2601:646:8003:f231:356f:4b4f:2ec9:d15a])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69DN6o573850101
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 13 Oct 2026 16:06:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69DN6o573850101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1791932812;
	bh=JJmD+/QY5os8wQkB/X/NCAurpKkUQhavruhI2yQUGvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TzF5CbIhbMJrANvDVDlsjrXZffPmaHwe6HTcaeZpFw0yw+73stVWu3k82+jxkOrGy
	 YTHVCg8DGFcK4PL35piseSZW4rYX7/REXaxlyZrGZwh2IFfJDOGqZxPiYQhgmf47al
	 Z3aYh4AzgBYpGLKe2kB0uHjvc4J9MAi+cTmneTGlJUqrdwSnbsgzItKQUW3TpC5Zow
	 0Nt2KoYcLIBxM2hWp14omb6TjNa4mTI/5rmopZSRZ+dR688jlyFw2WqGHi2JppdGr5
	 gJonWVvvwT68a1D7RXLYudQyZlKZKkVRRb16zSlevHkkkrfSt0aPp+rKE8WF0jcwTT
	 X5j/GO9BCA8Wg==
Message-ID: <59691ed7-1da5-44b4-8b6b-c7eae92b6161@zytor.com>
Date: Tue, 13 Oct 2026 16:06:44 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/x86: Add a test for LASS enforcement
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Kishen Maloor <kishen.maloor@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261009020025.4175228-1-sohil.mehta@intel.com>
 <b6cee0b8-c5cf-4136-928f-96cb0a58eaa3@zytor.com>
 <c5c1fec0-8cd7-47dc-9a22-d90c80b2429a@intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <c5c1fec0-8cd7-47dc-9a22-d90c80b2429a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-10-13 12:51, Sohil Mehta wrote:
> 
> I had it in v1 of this patch. It seemed excessive to do specifically for
> LASS:
> https://lore.kernel.org/lkml/20260806011536.4172258-8-sohil.mehta@intel.com/
> 

"Specificially for LASS" is the problem here.

This goes under the "do it generally, do it right, do it once." Librarize it.

> I agree, adding them as generic selftest helpers may be useful. But,
> /proc/cpuinfo has been unreliable in general. It is currently buggy for
> some features with Kconfig options. See:
> 
> https://lore.kernel.org/lkml/f6f113b46199d996c4f81fc89858c2f484256418.1774623092.git.m.wieczorretman@pm.me/

> Also, (I think) we have been generally discouraging folks to add more
> bits there. So, I don't know if creating these library routines is
> useful right now. IIUC, Boris said that the CPUID rework would make some
> of cpuinfo stuff moot.
> 
> https://lore.kernel.org/lkml/20260331140216.GDacvT6IPW1gf003z-@fat_crate.local/

> Thoughts?

This is a great example of why these interfaces *are* useful and why they
*should* be fixed.

	-hpa

