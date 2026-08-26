Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779C3B19B2;
	Wed, 26 Aug 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729565; cv=none; b=AAqjCOteq2u02e9rRz8D+cnF8rtk4v8UTr0UEefNa0xTR1bWPnffvsYCFKpVVlvUSITWqrZZt+9RPxZXNDTOv3nfWoAUqTCqwOYA5Emgc9NE1SAyYhwthdZhsMZtd5w9uDI6EvhJldMDUfha7iojumeoQoioCQSwMRmDenzL5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729565; c=relaxed/simple;
	bh=44bsU91JLgcVuaZAxI42z3R4oe6aaUU0l1OSN9XNqIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr8ZAtSue6jiYgIvpuMUGm3I4uteMbrjrqwEh/noFEIjz6BwX7btM6Cp2KVj7ALTr3UEciu0Yt6IgPWA5TIWHtcsohUMhZc0PDE+ZQG3YpC52KX4XITUjhxqrPAvThfCc4l42dp6M8M96SMtnCmlWwfqOO9SOireAAOv6ReJtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMQGacdc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z2MdUAMa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMQGacdc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z2MdUAMa"
Date: Wed, 26 Aug 2026 09:32:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787729555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0qYw6dI/lOMP/K9P716HVlCet1n8A6GD/0q9HLVzrs=;
	b=VMQGacdcvMuc2msrSxPg8sy3s578U8lucEvh/cZE4V/kuiAr7MmALRl2ClMviXBxGNm52k
	DbiAwAFtpBiS4r3m3/8x0wfzKkcxmLnRbHqy2n/cBIG430HZhfYOX7I4F1BCgRQ1KPQKgl
	1iUepfgOJ9GiAGAOEDW3L01Ncp2uMFz/i9BWDfUuLNvR1nhKtFS1iI25NZVTck5Dwj5q6q
	8KosOZZD7dw+zVRg/8noxbbDhR8wEdzdU4bGFERhcMcIEAMuvENanuTyijfYqGjTNnsK9r
	TzT8azEkht+nlDD3AQN2+zNGXHPocQGutv2HAv/yecSdl7SWLMdzlhhdv2f8QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787729555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0qYw6dI/lOMP/K9P716HVlCet1n8A6GD/0q9HLVzrs=;
	b=z2MdUAMaarXzYXJUnZ9mDq2Oq8fo1ufaKMNgfCTuwIciKR+qIP2KDHfk5DiFU/9/pyr2Ng
	e/k7E2VBHGxqtJBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jerome Glisse <jglisse@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260826073233.T-KtFXmj@linutronix.de>
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <ao3z7Rtw2FROkVpy@google.com>
 <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>

On 2026-08-25 13:51:14 [-0700], Paul E. McKenney wrote:
> Very good, preemption disabling it is!  It is quite possible that the
> PREEMPT_RT guys will need something else, but one thing at a time.

This reminds me of classic RCU ;) It might work in this use case but I
am afraid that other users might come along where it actually hurts.
With PREEMPT LAZY the preemption within the read-section should
hopefully be the exception.

=E2=80=A6
> 							Thanx, Paul

Sebastian
