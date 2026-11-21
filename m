Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263861;
	b=2c45kMnPsApuO5NYkU27aNTeZ5jl5cxEaoIe0ABfViZBX2YHjA4aX6NzvjBeaqCMeFwO
	 m7R43sf5zbx7+9ebb0KWEd5QNMfpaZvKXNRofz8WW6W3zGDyob2+X/PU4Mvw8TplhT/Vr
	 3On02aI5uRrsV3oJQmWzCwLycgTzY4KSg2St3/ySNHPt7Yiik+pS3b1GAoixL4+w501Jf
	 B6YuogrvyF17tIIC+UKna+klSZcMPo4/2vS6Ysx4HOjXgTdq5mCGThxwXq2bD6eNntey0
	 r/Us2RHbya2kuKS37iqGkOrBFjloazxWQ7BEkOgHklf6YYqS5VNe4CbOZQwVWIbRsIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263861;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NwYHmgGAq0gr3pmS1w1vNCx8PHu20jV0n301iN0c/jg=;
	b=gYCBdngJTnc+YdHWXBXCuQWNFMIwmIBO3XAZrwSDGYlblkOvlGt9XhVXPW/PVHYXzQyo
	 rXGpBQbXF1RmT5FuMO59XKkyq2I1BRom0We+SIcVsE1Gpanaoojts28IencVoRsvMOTi3
	 sG0wzh2CcDcMnA9U5ROwU5oqiOEq5Kcr0leZnmkXob/kRUFhgTpSavIB7Cgr+sNpFhr0k
	 mDgQV9FUXFof6OF//gScsOwBmYwq7bhtGVRqQi8ThOORh1GgcPqkNWjwlNluLzf/GazdB
	 DYaWl3T7G8a9qATkU89XRfKayGkmwNSF62m3ZsSPaoqr+QW/m8qMTmNCTYGqANYjSZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rQSz0yWH;
	arc=none smtp.remote-ip=91.218.175.71
Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD4606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CD4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rQSz0yWH
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kGo36nDWG3R/lg7h5mo5U2JYd2ZrcZDPHK/RX0L5Sqg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795263858; v=1; x=1795868658;
 b=rQSz0yWHSitaI5TMgyh9cLcZsijOZRJdEfSQ/SK1ppGtIJjX3TZrCslafhecHOIbdnl3Uq69
 HIR51w/UdxpAdRuue7H0sg6PTb1IVHA5ofoN5NpdQ7rkC/DOHkG+Q6GBw5UmuBd7pXM3rH0av6w
 +Fj2Ei3wfke+PG66Fw/BhC3s=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7318615b7222aebb;
	Sat, 21 Nov 2026 12:24:18 +0000
X-Mizu-Trace-ID: 7318615b7222aebb
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 13:23:43 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Koichiro Den <den@valinux.co.jp>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Bingyu Xian <shanbeeyoo@gmail.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] RISC-V: KVM: Batch user accesses when updating steal
 time
Message-ID: <awGJaUFUmBOa4xfO@orel>
References: <20261118062242.2914385-1-den@valinux.co.jp>
 <20261118062242.2914385-2-den@valinux.co.jp>
 <awB1hZGh3LYztjqL@orel>
 <awB6FpVOpZ9fhMt1@z790sl>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awB6FpVOpZ9fhMt1@z790sl>

On Sat, Nov 21, 2026 at 02:20:17AM +0900, Koichiro Den wrote:
> On Fri, Nov 20, 2026 at 05:40:29PM +0100, Andrew Jones wrote:
> > On Wed, Nov 18, 2026 at 03:22:41PM +0900, Koichiro Den wrote:
> > > Updating the SBI STA shared structure performs 2x get_user() + 3x
> > > put_user() calls, each of which toggles sstatus.SUM.
> > > 
> > > Keep SUM enabled across all five accesses to the shared structure.
> > > 
> > > Note that write barriers are added to order the odd sequence store
> > > before the steal-time update and the even sequence store after it.
> 
> Hi Andrew, thanks for the review.
> 
> > 
> > The barrier additions should probably be posted separately with a Fixes
> > tag.
> 
> That's exactly what I wasn't sure about when I read the ISA spec.
> It was unclear to me from the Zicsr ordering rules whether the SUM toggle in
> the old code's get_user() and put_user() calls also order the stores to 'sequence'
> and 'steal' as seen by another hart.
> (I don't think they do, but I'm not 100% sure. It feels a bit like trying to
> prove a negative, as I couldn't find a clear statement. I may have missed one
> though. OTOH, the new code surely needs the barrier, so I included them.)
> 
> Do you read the spec as allowing another hart to observe those stores out of
> order in the old code? If so, I agree the barriers can go in a separate patch.

Yes, we always needed the barriers since we need something to pair with
the virt_rmb()'s in pv_time_steal_clock(). get/put_user weren't covering
for that omission either because CSR accesses are weakly ordered.

> 
> > 
> > > 
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > To reviewers: please let me know if you'd prefer
> > > scoped_user_rw_access() here.

For scoped_ or not, whatever you think reads the best. I prefer scoped_
when it makes sense, as it's harder to get wrong, but readability also
matters.

Thanks,
drew
