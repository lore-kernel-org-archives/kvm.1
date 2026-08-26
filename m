Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1039A7E7;
	Wed, 26 Aug 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776278; cv=none; b=WpACgI3Qxnln8vvCaCI67QSzppXn64DJBooA41f43z+zDlJmAR3KP2Bf5Y+IL+kCxLGoYOfTnn3CYh8rxZSUq07HRT7GWmybch20GtMujY1MBUmA3uLxSHcqOe5wXqvR3b9dTSzViNot3DDGprkjfaEhBjA5mmVzb9GsvUs1JEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776278; c=relaxed/simple;
	bh=7cdU9DVUgBmZ+eSuN/s0PxtkyqmH1fW62wSh+non1uE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=btE2nKhtFXKzu/1w4MIGZZUK1ZB2Zjbw91y4b7WG0veuIGDgQBIDWnDN9d6sKd+s60m0eW8uXM0vsW0k8vnXjqGbVSJo5HzBHahwRlfqZ+XZtjK4/LKiTZsVdh7lKfgJWd1h9eo7ArWVYRmPCcISFqj4Wr7zZ4tp+e6423wT2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c4kFMpO0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4kFMpO0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LBG22HuFcKqOwRZzaBQg3Yl2Pqe1f3bp1oSCi5Wuvuo=; b=c4kFMpO07XdDA3nuabyURhNL4n
	CnmGgGISYBozl+T3Kc+Aluw1/eCEKfqDm8swAtP7ANgxu1NAp4QXcOc8B4lW7TMBnhRzjRxO7+FOD
	r1vGc/uaTNnV3dbvhifA/sugDLwVPT/z20JeLIYUqrYd0gxSV3eHTG84xAomqL1fAtMy9dCTBOmVi
	gYTjOHZxv+8SSoqlQUEtZeB3xTijoDODX3O4DY7b2Fp0Lp6u3ynD3EcrEbO5G5h+kKckJsuSYyBAH
	xzU7uYvIdhz2sbe5+vetodF/3taBUINZCp2zYUrO2GqB/3iU/1s6wpcYeZa5A/H99KsNg63d4GeaP
	ue5Ye/Ew==;
Received: from [167.98.59.108] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzKGi-000000070A8-33Z7;
	Wed, 26 Aug 2026 20:30:50 +0000
Date: Wed, 26 Aug 2026 21:30:43 +0100
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
In-Reply-To: <e62a7362-7dd0-4615-8877-6ab675971ab2@paulmck-laptop>
References: <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org> <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop> <ao3z7Rtw2FROkVpy@google.com> <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop> <20260826073233.T-KtFXmj@linutronix.de> <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org> <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop> <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop> <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org> <e62a7362-7dd0-4615-8877-6ab675971ab2@paulmck-laptop>
Message-ID: <06F9A0F0-2177-4173-A201-56325A73F89B@infradead.org>
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

On 26 August 2026 20:59:31 BST, "Paul E=2E McKenney" <paulmck@kernel=2Eorg>=
 wrote:
>On Wed, Aug 26, 2026 at 07:01:24PM +0100, David Woodhouse wrote:
>> On 26 August 2026 17:28:27 BST, "Paul E=2E McKenney" <paulmck@kernel=2E=
org> wrote:
>> >On Wed, Aug 26, 2026 at 08:05:06AM -0700, Paul E=2E McKenney wrote:
>> >> On Wed, Aug 26, 2026 at 08:38:27AM +0100, David Woodhouse wrote:
>> >> > On Wed, 2026-08-26 at 09:32 +0200, Sebastian Andrzej Siewior wrote=
:
>> >> > > On 2026-08-25 13:51:14 [-0700], Paul E=2E McKenney wrote:
>> >> > > > Very good, preemption disabling it is!=C2=A0 It is quite possi=
ble that the
>> >> > > > PREEMPT_RT guys will need something else, but one thing at a t=
ime=2E
>> >> > >=20
>> >> > > This reminds me of classic RCU ;) It might work in this use case=
 but I
>> >> > > am afraid that other users might come along where it actually hu=
rts=2E
>> >> > > With PREEMPT LAZY the preemption within the read-section should
>> >> > > hopefully be the exception=2E
>> >> >=20
>> >> > Given the way that PREEMPT_RT treats other locks like spinlocks an=
d
>> >> > rwlocks =E2=80=94 turning them into sleeping locks =E2=80=94 I sus=
pect it makes most
>> >> > sense, and is consistent, to also turn rcu_read_lock_atomic() and
>> >> > synchronize_rcu_atomic() into plain rcu_read_lock() and
>> >> > try_synchronize_srcu()+synchronize_scru_expedited()=2E
>> >>=20
>> >> That makes a lot of sense to me=2E
>> >
>> >Another option is to instead fall back to non-atomic SRCU=2E
>>=20
>> That's exactly what I thought I was suggesting; I think I left an 's' o=
ut though :)
>
>Heh!!!
>
>About 20 years ago, I was shocked to learn of a valid use case involving
>sleeping RCU readers, which resulted in SRCU=2E  And now it is time
>to be shocked at non-sleeping sleeping RCU readers, and especially a
>non-sleeping grace-period wait=2E  ;-)
>
>Anyway, easy enough:
>
>#ifdef CONFIG_PREEMPT_RT
>DEFINE_SRCU(whatever);
>#define my_srcu_read_lock() srcu_read_lock(&whatever);
>#define my_srcu_read_unlock(idx) srcu_read_unlock(&whatever, (idx));
>#define my_synchronize_srcu() synchronize_srcu(&whatever);
>#else
>DEFINE_SRCU_ATOMIC(whatever);
>#define my_srcu_read_lock() srcu_read_lock_atomic(&whatever);
>#define my_srcu_read_unlock(idx) srcu_read_unlock_atomic(&whatever, (idx)=
);
>#define my_synchronize_srcu() synchronize_srcu_atomic(&whatever);
>#endif

We could do that for the KVM GPC locking, but more consistent would be to =
change *all* users of the 'atomic' lock under PREEMPT_RT to silently get th=
e sleeping version instead, like PREEMPT_RT does with spinlocks and rwlocks=
=2E

So it's srcu_read_lock_atomic() itself (et al) which would get that if/els=
e treatment=2E


