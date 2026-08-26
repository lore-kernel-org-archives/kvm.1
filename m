Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF457377A86;
	Wed, 26 Aug 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787771445; cv=none; b=Z2m1Y2nBbvh18BWioUq8TeOOngFv89Ow1QfDGV5kGCe99toXvtkFHaHqgM6r7UygcR6VbETFz0/BkAiGHuI535bETfoOan7+EL1a3HIvkVK/ieXJOmUX3KGh/xidPAt+1tVt9YViXQyRWHSLqpU6eTYKLCiGA5ihFE0FiYDuPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787771445; c=relaxed/simple;
	bh=3telYjFYiWNOnHqk6Dt2Y5vLbqkVmH61rJgzRfZORkE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GKHkH6qGrJySm4sHNL6tLdLT3CdX0WvzNXhu0ikHE3sXNnsCQgeGlBejVnm7j5YKZJd27tT+h9mZGDMGRmp5uECwPijyJj4G1e/4WbLsdHXqgw0pgBKSh2ADlaoXfHS+BmKFjpubggUu4JyigrCRjgoZKoMvrNz0Y66G+tI6Ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c6vy+PSi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6vy+PSi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3telYjFYiWNOnHqk6Dt2Y5vLbqkVmH61rJgzRfZORkE=; b=c6vy+PSit0j/le3s0QJFFYImMr
	IHaddo0nuwaFMQ/MVxza04PgyCm9f0wR/uzkxodvR8a2Fj8SdTkJH4CkiG5KjCWySBoPoGg/YQpGv
	7XsmN+r7L9z/BhTvpD9T5o42mHwxY2mDN5KDnJ9Tow7hwByKqmATZlWA3ak60eo6H3Go7fP+F3oEf
	h5onVBx3nbtrWxIOEGzmbNXxvacoWAbeqG5yCr9ZtSKGa25ud2vHSUeeAKmZBuTfNkJBPpMGiQidY
	+YhpZmPa1ZSobw6Mcq8O2ZVCbOySpe3kZTSvdS2WPrLr4HWhYRXGxTANNvurBMtC3ep+fvl1Etqc+
	S+3Af6Tw==;
Received: from [2a00:23ee:1948:28bd:e7b1:3e8e:1bc4:19da] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzJ0m-00000006xg1-2wXV;
	Wed, 26 Aug 2026 19:10:19 +0000
Date: Wed, 26 Aug 2026 19:01:24 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, Jerome Glisse <jglisse@redhat.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/mmu=5Fnotifier=3A_Remove_non=5Fb?=
 =?US-ASCII?Q?lock=5Fstart/end=28=29_from_notifier_invocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop>
References: <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop> <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org> <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org> <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop> <ao3z7Rtw2FROkVpy@google.com> <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop> <20260826073233.T-KtFXmj@linutronix.de> <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org> <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop> <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop>
Message-ID: <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org>
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

On 26 August 2026 17:28:27 BST, "Paul E=2E McKenney" <paulmck@kernel=2Eorg>=
 wrote:
>On Wed, Aug 26, 2026 at 08:05:06AM -0700, Paul E=2E McKenney wrote:
>> On Wed, Aug 26, 2026 at 08:38:27AM +0100, David Woodhouse wrote:
>> > On Wed, 2026-08-26 at 09:32 +0200, Sebastian Andrzej Siewior wrote:
>> > > On 2026-08-25 13:51:14 [-0700], Paul E=2E McKenney wrote:
>> > > > Very good, preemption disabling it is!=C2=A0 It is quite possible=
 that the
>> > > > PREEMPT_RT guys will need something else, but one thing at a time=
=2E
>> > >=20
>> > > This reminds me of classic RCU ;) It might work in this use case bu=
t I
>> > > am afraid that other users might come along where it actually hurts=
=2E
>> > > With PREEMPT LAZY the preemption within the read-section should
>> > > hopefully be the exception=2E
>> >=20
>> > Given the way that PREEMPT_RT treats other locks like spinlocks and
>> > rwlocks =E2=80=94 turning them into sleeping locks =E2=80=94 I suspec=
t it makes most
>> > sense, and is consistent, to also turn rcu_read_lock_atomic() and
>> > synchronize_rcu_atomic() into plain rcu_read_lock() and
>> > try_synchronize_srcu()+synchronize_scru_expedited()=2E
>>=20
>> That makes a lot of sense to me=2E
>
>Another option is to instead fall back to non-atomic SRCU=2E

That's exactly what I thought I was suggesting; I think I left an 's' out =
though :)

