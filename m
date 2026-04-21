Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210C377004
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789048; cv=none; b=fuP67WGmM8e/q0y6FiciCLElZrBQOxDH5jXNSiM5jLIt+GBgQtFUwLxmOWrq6iVDfZfMr+LLEkepV9qjxYs/fXWyS0qx7egMYn72VKSffMVE8DSxETaywxEMyAym/jS2FL55UEP4sLBKQjjbZKNsW8rWNIEtBTTzD7dVwYrpz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789048; c=relaxed/simple;
	bh=nJNOdz8w/ILRpeAPqijYcJdfao00UEuhIVN3VcpFwq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOsggXWNNk4E88NcJCX5PypZpOiRK7XXbvQ2VyTi26VFTkl5qFVR/mrN4t4LJtnDGS2VnOX436SJ61bkeksBnNSN8kp7P5XXG/DNzLPyzvufa2jGRUtfn0gCcfqM7gfitrxUuc0j8ufleJVZ5Cjh2EsD0Pq/z6w87zhniPWp1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5aGK2lg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5aGK2lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA3BC2BCB9;
	Tue, 21 Apr 2026 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789048;
	bh=nJNOdz8w/ILRpeAPqijYcJdfao00UEuhIVN3VcpFwq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y5aGK2lgEAKjf9RANDIQZ4zx0xDQtq5YDZOlRGQu26rufC+58I8Fsl0+xZsbPJd5G
	 f9bSCxpKAK5pHR0FS7K2jBVD7l2BW3N6TVZQ56ZLADnGYoHb64zcQlY9hCXbiJHmrr
	 yyRFfSAxrW5bkCc+TRyKULhWZ/KanySdiEFUxxqtI2S+D3AQC8Z5oTcWDdfPzqBK4Q
	 gr9Cjz3qdrlOcXEeaVWZ0G/P8iQK0nBlPIMKLb8wOx2iuRZFrZYxlWvCxwQHARkmEK
	 teXlpjpP9XQZO/hnewK31NUW2jHugNOfRz+zj4fqOAb/yItYIlz/O06QpMUHg20S6M
	 qdb58XZKKlh5g==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Wu, Binbin"
 <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
Date: Tue, 21 Apr 2026 18:30:43 +0200
Message-ID: <87jyu0b7ik.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 13:32, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 01:18:58PM +0200, Peter Zijlstra wrote:
>> >  		/*
>> > +		 * This is sadly required due to KVM, which invokes regular
>> > +		 * interrupt handlers with interrupt disabled state in @regs.
>> > +		 */
>> > +		instrumentation_begin();
>> > +		hrtimer_rearm_deferred();
>> > +		instrumentation_end();
>> > +
>> > +		/*
>> >  		 * IRQ flags state is correct already. Just tell RCU if it
>> >  		 * was not watching on entry.
>> >  		 */
>
> Ohhh, wait. What happens if you take a page-fault from NMI context? Does
> this then not result in trying to program the timer from NMI context?

Uuuurgh, yes.
