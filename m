Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635ED2DCC1F;
	Thu, 20 Aug 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251772; cv=none; b=c2ozArEZUuUgsOl8PPVsx1Gm0c+z8ezl4v4X4RZD6Fj21tYS1Yw3ePY1aax4yzOK9xhjFuwmaXYewFpn3sHFERR7L9eSDrC8JxPii1CjYeMIJ49raBoo/InAvwR/k8VIYbT/20MWvJkpAOcVp2PAztpm1ehN0hOmK1p/YvCPcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251772; c=relaxed/simple;
	bh=Bxoz+gQaajsA5pCxftnKj5mDXSS6NnATsxXZdW81D0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RfISf7ZwB7dneD6DtObQW4t9A7lD2XO2h0dPiWZDPM6+VehzJaFKrrrbjfh7Gf6os/1F2BSwL97cRbR+Pkpt4DwBDwB1FuEy+gsiVCIwm74zbC45hRhwLJdOOlAP7aINrTrh+NgCT7NxR8KO9jDjsBgTEJcozBe3GbFhaN92fhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ah5RL2tA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ah5RL2tA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Bxoz+gQaajsA5pCxftnKj5mDXSS6NnATsxXZdW81D0c=; b=ah5RL2tAnpSx6WytvpN6T2b/q5
	fqecbck3UKuInlaTaX2PJfYFVfVQ+a4wbzlJxkHBtW7BkCBWxyI6KcPi4ta6dBfk5r1fe0CZOYMyj
	8x7dsarhPKO/rS4PmBCK1o/Nel+v7nyYg7HPnF6pbv9fGq9k1/pgQP7Odtc3/RI+JKa3EbPLc6Lsy
	gUWw0CGaY+jWW10qZMinw0UTo+/sS8IXf6wNZQraHxeObzD1oWoxzZdLvvdG+jLJXl64DVB3uQww7
	XORkAw9jbt3754j+O8ZGHDE5UINSbulSN9HuCPSS5i+RTo11Tu0AZCncOaPIcCcne5+vldc5+h1Ik
	yKVzsxrw==;
Received: from [2a02:8013:6d1:1:5309:2aed:a2fc:3ef2] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wx7pE-00000003HyP-1sG3;
	Thu, 20 Aug 2026 18:49:17 +0000
Date: Thu, 20 Aug 2026 19:49:16 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, Jerome Glisse <jglisse@redhat.com>,
 Christian Koenig <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/mmu=5Fnotifier=3A_Remove_non=5Fb?=
 =?US-ASCII?Q?lock=5Fstart/end=28=29_from_notifier_invocation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260820153413.1EAmdFht@linutronix.de>
References: <20260820133020.7ZCRIhwX@linutronix.de> <448c5c0128b08ab98d175ae1099ff4d4874e49b3.camel@infradead.org> <20260820153413.1EAmdFht@linutronix.de>
Message-ID: <F376821D-AEF4-4DD5-A059-1714907E7E22@infradead.org>
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

On 20 August 2026 16:34:13 BST, Sebastian Andrzej Siewior <bigeasy@linutron=
ix=2Ede> wrote:
>On 2026-08-20 15:26:35 [+0100], David Woodhouse wrote:
>>=20
>> So if you fix the might_sleep() and Paul comes through with the atomic
>> SRCU thing, I no longer care *much*, but still think the whole thing
>> deserves to die=2E
>
>Okay=2E Let me look into it then=2E But "the whole thing deserves to die"=
 is
>limited to the kvm usage, not in the kernel?

I mean the whole of the non_block_start/end in the OOM path =E2=80=94 the =
thing that this thread started by removing=2E

It's always been enforcing the wrong thing, and the effect it's had has on=
ly ever been detrimental AFAICT=2E

