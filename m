Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E883659EE;
	Tue, 11 Aug 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471178; cv=none; b=poGndBJSuTVEi5FuAszm48b6y/Clyo/o55jJOlqnIEfLCGzfINXKiR2mJyZERgGew/LckwMN08x2Vh3MxefkGD3QYhJLs/FpGmg92QzZw+eCYlzD2Z590mcBIgumilY5xfH2W5N+QlEqPw71bUK2LSXUo0meGALk/UDpYAHS+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471178; c=relaxed/simple;
	bh=oRvfQO9cDNEHPUpYghEoRHI8U5YFrjYdfy5eDC31QM8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=G9jtM3oWY4VXpJtRo0lcCUCoViPwuGZ1O7W3eWXcOSR36zuCLCGh7nP/JTnUdB3tF0GPh+827xX43q0mFEIDadZwJST/JG/tOwyFW2wKFM4/Sd692fxKJmW8X289t7FxcRjjm/1ERrZ9EZLKt2EilasRCxSFPVxtf4svdCYbA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQ9gQAla; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQ9gQAla"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oRvfQO9cDNEHPUpYghEoRHI8U5YFrjYdfy5eDC31QM8=; b=JQ9gQAla8I6tnTLbk3jn327tur
	rLcbskMcowhYir94h3SCFzHud0Jjt1adZbaN+pCNn3G1fiNBQ/1Qg+qkKLcDGERFs06dk5qd78//d
	6fD5+pidgQpg0ZXKN0PQWyxBED7KbJzaM7JhRHjJ0Csupm70s0q0dgQeLf3tyX706/uibY8AUQV6N
	FeIM3AZPcKspNtCP12unuRSix8bI1peGmFumGpCRevkecSd/ulouMoEsa+XBXCoPSIgaru+4Wik3+
	lD3/TqX53NgO2RJT1llhhfSAhVg2tcLQilflaOSKq1Gj58q+JTeiI6upavSD2Qu5P63xchOiSW8sN
	9eXVBT0A==;
Received: from [2a02:8013:6d1:1:1427:d5db:df17:4279] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtql3-0000000EpgO-2Qy3;
	Tue, 11 Aug 2026 17:59:25 +0000
Date: Tue, 11 Aug 2026 18:59:24 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: akpm@linux-foundation.org, david@kernel.org, mhocko@suse.com,
 rostedt@goodmis.org, bigeasy@linutronix.de, simona.vetter@ffwll.ch,
 jglisse@redhat.com, christian.koenig@amd.com, paulmck@kernel.org,
 seanjc@google.com, pbonzini@redhat.com, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/mmu=5Fnotifier=3A_Remove_non=5Fb?=
 =?US-ASCII?Q?lock=5Fstart/end=28=29_from_notifier_invocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260811172627.GN544626@ziepe.ca>
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org> <20260811172627.GN544626@ziepe.ca>
Message-ID: <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 11 August 2026 18:26:27 BST, Jason Gunthorpe <jgg@ziepe=2Eca> wrote:
>On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
>> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
>> > To be clear you should not be using any synchronize_[s]rcu() primitiv=
e
>> > inside the invalidation callbacks=2E These are well known to have
>> > multi-second delays on loaded systems which are a completely
>> > inappropriate performance characteristic for these mm callbacks=2E
>> >=20
>> > This statement has nothing to do with deadlock=2E
>> >=20
>> > RCU is always a trade off, you can make the read side run really fast
>> > and the write side is ghastly slow=2E If you can't handle the slow wr=
ite
>> > you shouldn't use RCU techniques=2E
>>=20
>> The multi-second horror stories are about the *global* RCU/SRCU
>> domains, where the grace period has to wait out arbitrary readers all
>> over the kernel=2E
>>=20
>> This is not that=2E It is a dedicated srcu_struct, private to one VM,
>> and its entire reader population is a handful of KVM fast paths that
>> until now were under irqsave rwlocks=2E
>
>Are you sure? I've never heard that srcu has those kinds of properties=2E
>
>If its so fast you should just propose a non-sleeping version and
>leave the notifiers out of it
>
>Jason

I've got torture tests running for correctness on the GPC RCU conversion=
=2E I'll throw in some metrics on how often even in that pathological case =
we hit the wait case, and how long it actually takes=2E

And I can prototype the extra-expedited case that never even falls back to=
 the WQ, but frankly I don't know if it's even worth it=2E
