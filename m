Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6526C39E
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789398; cv=none; b=EmVBSqIDVMhtynEUHkA3o1NNdog/KpRX2uOdjXVJK+gd1M3fI/4JRLCvYIlYLLSZuymHW8tTekLGPRZyoGuqRZBC8f9G8u0XIlXwBN3Dq5Fq4sGUGPn3hGhB04Vd+1PyWCLK/1tLLqERkmKh7A7Mf/7Yw2yV2n8HsrSuwTJArS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789398; c=relaxed/simple;
	bh=znWo9nsColSxcabZyAKOOm4iIhGimwX6ddJbvAW2zTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QAYT5oLdoGdzynse42JebEOYnwBlLqSI9Hs3r/qyW070ZqtQmE8YAFWnfj+19l1CjfU9QbTdz+1YXA9LDNFMR5Rim2h7afzduBCdgqg88OnpHjHlk7h+d7OlI7sIIMQIvOByKKji/znZccpFO0MIjRpw5N6zsa1w+GZuyn6J9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm2nqHt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm2nqHt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A7C2BCB0;
	Tue, 21 Apr 2026 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789398;
	bh=znWo9nsColSxcabZyAKOOm4iIhGimwX6ddJbvAW2zTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tm2nqHt9SvUeo7TNqoykbBMbd2UdDGnAKsfnskNATB+xrDgJ6KZbMg8wIyQYMqBsy
	 yg4B9FnTi4PBHBH41yNb2Hd7Q7G4MtCPyvFKJOqVkdJRt4Gg57xA8qykjvRmteN5sh
	 d12Tg/398p5AouG5YrwJYVJ+y0rLP/oqu1x8vTa+wbC6KGFaZbNXOjeVq8k/zgQEhO
	 PD1BBfx7NyOHpH5gd8Eg1L9kt2fYQ9XfgMB84sg1JGJHQiC/T7op0b54MZt390ddFY
	 cZJ0y3Dt7X9BlaOwQjTZYCsqdo5YhaX4VLN1ifkfoSg7UgWgt41jSJKHbYLN2WwdnU
	 R+3R+cRcdF/CQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Wu, Binbin"
 <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <20260421132913.GB1064669@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <20260421120531.GF3102924@noisy.programming.kicks-ass.net>
 <20260421131953.GA1064669@noisy.programming.kicks-ass.net>
 <20260421132913.GB1064669@noisy.programming.kicks-ass.net>
Date: Tue, 21 Apr 2026 18:36:32 +0200
Message-ID: <87h5p4b78v.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 15:29, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 03:19:53PM +0200, Peter Zijlstra wrote:
>> > Moo, you can't do that either, because it will ERETS/IRET and fuck up
>> > the state :/
>> 
>> How insane is something like this?

Pretty insane :)
