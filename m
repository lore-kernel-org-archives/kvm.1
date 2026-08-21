Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B9371067
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282560; cv=none; b=gLS44nkAbOxMPb6S1UDNadWae7juBGHmh5wthUu7LJsDZEzLcUXFbRRlHpCAEMS8mBIzpzSNKeoNM1xaapbQmM5xify6Lcg7jvsVhSTbMmwi4IsrK2x8i6uG6bzCMot6OmfrPH9iA1Cq4Tp5sArh9zdiGgx9oN8v8IIG+emUg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282560; c=relaxed/simple;
	bh=tgJloRfeeS7oreM0fNCdGrfk46K+Jnqydc5/4HZLxeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWEdClY871j+BuaB6lj5mf+cfOHfu3Ceoeh9heXkpIw1YF9OeRAjaqk/rZOb7r8HV6O6XnBZw+/0hUgWfXFSt7g8bCQgyKsnddITyZPBW2Wp0us3dMomeLdVqFXYx3bLVwAr7piNpHAGF5KlY+E9AdHa+CDfKE9wyqEUR9PGepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4p/2bZR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4p/2bZR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so487888a91.1
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 20:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282555; x=1787887355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FArwaMZX2eiWKPnzPqfz9Xd0f0Z/D0qbA/uRrn33MqI=;
        b=X4p/2bZRGkRwiBU992cep3/Y217FicN0TNw2aN21xdp+Nted+ls3p0xMhFSXjRxrGo
         8Px4bPYAP7uA+3pVxrw0KFxrfZUgUHrOwsdSI+5jUYI2LlNht30aN38fpvhrjthTWmj7
         JRdCqYK2Z+jM5MFkuxq3ClkKl2pj/GMA9W/hpuwCTvlCyb0bP6BZFokc//xiCW2Buyjy
         DgPJg1iEYG8l7UecFPMWcmK1t244P5ggVoDAYcKDXg4+RHTjAnsZhfL0BHe96QQz0xMs
         NjwGg0mnJvHWhoLWnJyJ796QCYSteR3tn9bSfpY39Wy6jFIdQMEq9IL8xbTVpaKb609K
         Mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282555; x=1787887355;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FArwaMZX2eiWKPnzPqfz9Xd0f0Z/D0qbA/uRrn33MqI=;
        b=nyI+u5GFhCQ4zFY3Mq2pjkhukQKGcfUargQ/mZaoDzOW0QrFO3xhyD0PP8MDiDVi7R
         1ev2dm8Db2vr4DgvAeEY75Wre2JuAPhUc7tggE0Dw83XwCQmE26Zmo1jG6JyYgJjl9M1
         fiNaW98HVUHy0DH3FzsgZKyuOQmQdhvL3oXP5Lpk4KGa2LMbBG4aR//0tW7eyBAhQ+yX
         GF64nyV7AK50haA6dfgx/4oyYwb3zI5JahNiyBfAp8699AIu5RFBDJrU1EKuQY2ie7x2
         XOl+i3O69IMGMTiurthbduXnXo2zd+tzpXA00mcbPvHLRHkOdtPDGeEct/jpXHFj0k3D
         If0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpNE4XDnuwpTIVIw20A0gamo7nVSaqya9ZSDKZ+CoN52WMDR9OINmZp399IDXIy4DLU2cY=@vger.kernel.org
X-Gm-Message-State: AFuF++kvhoR8aiIROW9IyQYD7V04EcP8Tl7poVhASV+TnWEqHYi4aX+o
	5PjswKb5EmNOfIxOptgY3LQypvuiuKjBzeWMj8lyZMtC+XhcSrhCwCX0
X-Gm-Gg: AR+sD10s112hx8/KzfsLOX5fc03irx3CkNHvkrQ286KGc3Sj35v7bA9yKfi/tjVWUyg
	r0beEicZEz6Av97xK1noF8hbPC/J9aK+7KZbLBGj/QfTV41LDdhhLfi1WgUXe5iH5Exo1rCe3da
	HQYcqVsq4PcAtllA/AOElzYX3vrWlKNBccDqP2huqlqZ1oP/J1LO7h9Sdpzzo3p5uo+R/bCePCj
	78vcn9N/RbHPVzTITqeVzoDN6pSUBqgwBNrZTzo+I+pInQdMh08BJczuyMWjcuLIYXDDUQVDNJ3
	sfDsKubRI1PyiNEmY1uiNBBlFR+wG9OHCJ1fTdSs60PtkClNpYFJ3evir2mK/Q2R1jjy+W2Ri7z
	ZDqvgKvesI20VORv4lRawVyACXnBdkHTMa/Keu0B/PuDgnVYEeTxb6ToL9vNz/0KSWojWLNWd8H
	eOrXSN5TBqFd406Yn7ofiJZMLIVQ1AeZXT2oKnxYA62yTGYqA8QULrXwMbBwqycgQaUjPHEdZMo
	uaI+TM=
X-Received: by 2002:a17:90b:4484:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-395c3552988mr4946396a91.14.1787282546673;
        Thu, 20 Aug 2026 20:22:26 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm1199574a91.3.2026.08.20.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:22:26 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sean Christopherson <seanjc@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	rcu@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can prove readers absent
Date: Fri, 21 Aug 2026 11:22:05 +0800
Message-ID: <20260821032210.792451-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0f4dea21bac43685d3286df329401177e4452b36.camel@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi David,

Thanks for the patch.

On Wed, 12 Aug 2026 13:32:48 +0100 David Woodhouse <dwmw2@infradead.org> wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> For a dedicated srcu_struct whose read-side critical sections are
> short, atomic, and usually absent — such as one converted from a
> spinning lock — the common case at synchronize time is that there are
> no readers at all. Even synchronize_srcu_expedited() still costs the
> caller an unconditional sleep and two trips through the SRCU workqueue

If the common case is that there are no readers and the new fast path
is intended to avoid the SRCU grace-period machinery, could you explain
what property of SRCU is still required by the proposed users that
prevents using ordinary RCU instead?

> And synchronize_srcu()'s auto-expedite heuristic explicitly
> declines to expedite within exp_holdoff (25µs) of the previous grace
> period, which is exactly the regime a burst of back-to-back
> invalidations puts such a domain in.
> 

Could this use case instead be addressed by making exp_holdoff
configurable per srcu_struct, or otherwise allowing a dedicated SRCU
domain to use a more aggressive expedite policy?

If not, what makes the proposed try path preferable to changing the
expedite policy?

> Provide try_synchronize_srcu(), which proves the no-readers case
> inline and returns true without sleeping, without the workqueue, and
> without advancing the grace-period sequence (so cookies from
> get_state_synchronize_srcu() and queued callbacks are unaffected). If

Could you also clarify why observing no readers during this
check is sufficient for the reclamation/happens-before guarantee
required by the proposed callers?

Since a successful try_synchronize_srcu() does not advance srcu_gp_seq, 
flip the SRCU index, or process callbacks, could we document more 
explicitly that a successful try provides the required 
reclamation/happens-before guarantee to the caller, but does not 
constitute an SRCU grace-period completion for the state/callback APIs?


> the proof fails, it returns false and the caller falls back:
> 
> 	if (!try_synchronize_srcu(ssp))
> 		synchronize_srcu_expedited(ssp);
> 
> For Tree SRCU the proof sums both epochs' unlock counters, executes a
> full barrier, then sums both epochs' lock counters. Equality proves a

One question about the barriers: the existing
srcu_readers_active_idx_check() relies on the barrier between the
unlock-counter and lock-counter reads to provide the ordering with the
reader-side barrier; the !did_gp path there has no barrier before the
unlock-counter read.
 
[...]
> +	smp_mb();
> +
> +	unlocks0 = srcu_readers_unlock_idx(ssp, 0, &rdm0);
> +	unlocks1 = srcu_readers_unlock_idx(ssp, 1, &rdm1);
> +
> +	/*
> +	 * Reader flavors which elide the read-side smp_mb() that the
> +	 * pairing above depends on cannot be proven absent this way;
> +	 * they need a real grace period.
> +	 */
> +	if ((rdm0 | rdm1) & SRCU_READ_FLAVOR_SLOWGP)
> +		return false;
> +
> +	/*
> +	 * As in srcu_readers_active_idx_check(): ensure that a lock is
> +	 * always counted if the corresponding unlock is counted, so that
> +	 * a reader racing with these sums can only inflate the lock sum
> +	 * and force the (safe) fallback. Summing both epochs means no
> +	 * index flip is needed: a stable equality proves there was a
> +	 * moment in this function at which no readers existed at all.
> +	 */
> +	smp_mb();

And, the middle smp_mb() appears to occupy the same position, while
the final smp_mb() orders the caller's subsequent accesses after a
successful proof.

What ordering edge does the first smp_mb() establish that is not
already provided by the middle and final barriers? I couldn't identify
a specific execution requiring it from the current comment or code
structure.

Could you point out the ordering requirement for the first smp_mb(),
or provide an LKMM argument showing why it is needed?

If there is no additional ordering requirement, could it be removed to
avoid an extra full memory barrier in this fast path?

> +
> +	if (!srcu_readers_lock_idx(ssp, 0, false, unlocks0))
> +		return false;
> +	if (!srcu_readers_lock_idx(ssp, 1, false, unlocks1))
> +		return false;
> +
> +	/* Order the caller's subsequent accesses after the proof. */
> +	smp_mb();
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(try_synchronize_srcu);

One more question about the documented fallback: synchronize_srcu()
and __synchronize_srcu() use
RCU_LOCKDEP_WARN(lockdep_is_held(ssp) || ...) to catch invocation from
within a same-type SRCU read-side critical section.

try_synchronize_srcu() does not appear to perform the corresponding
check. A caller inside an SRCU read-side critical section would fail
the fast-path proof and then follow the documented expedited fallback,
resulting in a self-deadlock without the corresponding lockdep diagnostic.

Would it make sense to perform the same lockdep check in the try path?

When applying this to current rcu/dev, the patch also needs to account
for the additional bool is_atomic argument to
check_init_srcu_struct(). Please rebase accordingly.

Thanks,
KunWu
> +
>  /**
>   * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
>   * @ssp: srcu_struct to provide cookie for.
> -- 
> 2.43.0
> 
> 

Sent using hkml (https://github.com/sjp38/hackermail)
