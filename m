Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23F29D294;
	Wed, 12 Aug 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557009; cv=none; b=ITcBm8JT+vFPlTsQHf/DGKDAjwW2FK2N80aHbkTVUol9mpGtlkVRH+NXOfhchKJfgAD8Ms8+nlM7CnuhQ+Z+QOCnLef8DCZoGYSDPQDahIldz09TlFhwKRYmJPa9tHXUYxua7/Vx5YiOoSZBobMgtgkUfZAFChol4buYamJlhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557009; c=relaxed/simple;
	bh=6oJcE3WviuFcwmiorKYX689u3RKCK952CYx4b0iuvtw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=If7PUQX+4A43zLy+itpPKZZdOGMSi52FIH8gdBCgLEC0umhluMHUoWMzNj8N6v660YJq4ZAkPhzqWdIcykDFohFgFQq5qswdc0sRbf2DQuPbXeyatIRlp+0/bKjCIWFRg4/BqY5OxmAMoAvzntJ4eGOzcVXdWPNhO8EqGgbBwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e0sq6gSu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e0sq6gSu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bgdPYYGyUUn1IOAhtILtpO8XLrtOMFaovKbcoEt2Z6w=; b=e0sq6gSujRTYecy98463RKSYr5
	ck7/pgTc+ObD6YsHZxdGLX56oUpdEwt0TgoOeohryUJY+eNLzKbUGii3Gzdzz3oy4+sb28IbywOli
	ids4I0XSod+9N+LZ4qRHgHAAPeEL96JLTHIAr8kGOKtZ9LmxXajdrIPY7LExV40+EZWg24QGNJwhT
	WF4dkdryVKMANkONGNaBPt7hwk9SpPypljTF3ayIdDtcDNODd1t7y16tRl70/YXDWNow6FB3vTMSY
	/Vrj5k2L5YNxTvo7hnao6a45HYurKw74ie71aDfNvNZUKl2q1/gGFoGPjUzjG4JSRuj68kiclo/3T
	TZw6HBhQ==;
Received: from [2a00:23ee:2678:290c:4649:38e9:2279:b11] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wuD5M-0000000Feu3-2mNa;
	Wed, 12 Aug 2026 17:49:53 +0000
Date: Wed, 12 Aug 2026 18:49:50 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?ISO-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/mmu=5Fnotifier=3A_Remove_non=5Fb?=
 =?US-ASCII?Q?lock=5Fstart/end=28=29_from_notifier_invocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
References: <20260811135537.GC544626@ziepe.ca> <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org> <20260811142730.GG544626@ziepe.ca> <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org> <20260811104229.72fdd928@gandalf.local.home> <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org> <anwraNIKJV8zwrNT@tiehlicka> <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org> <20260812122759.GA662699@ziepe.ca> <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org> <20260812134934.GC662699@ziepe.ca> <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org> <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org> <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org> <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
Message-ID: <5364F424-42B7-4D1B-BE55-B6F9E68B0F2B@infradead.org>
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

On 12 August 2026 17:04:47 BST, Paolo Bonzini <pbonzini@redhat=2Ecom> wrote=
:
>> + * Atomic-flavor readers run with preemption disabled, so every
>> + * read-side critical section is bounded and running (not blocked) on
>> + * some CPU, which is what makes spinning here sane: the wait is
>> + * bounded by the longest such section=2E No index flip and no
>> + * grace-period sequence update occur, so concurrent call_srcu(),
>> + * synchronize_srcu() and srcu_barrier() are entirely unaffected=2E
>
>Making synchronize_srcu_atomic() spin in CONFIG_PREEMPT_RT is a
>slightly tall request - it's basically putting it on the same level as
>raw_spinlock=2E But if the MMU notifier guys really want to make OOM
>notifiers atomic, this would be basically the only way to do so=2E
>
>If instead it's okay to remove nonblock_start/end under
>CONFIG_PREEMPT_RT, for RT kernels I'd rather avoid
>preempt_disable/enable and only make synchronize_srcu_atomic() try to
>skip the index flip:
>
>   if (!try_synchronize_srcu(ssp))
>      synchronize_srcu_expedited(ssp);

Yeah, so in the normal case it's truly atomic but in the RT case both read=
ers and grace periods quietly start to sleep again=2E=2E=2E just like spinl=
ocks in RT=2E That seems reasonable=2E

