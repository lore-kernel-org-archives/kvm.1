Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369321F5821;
	Thu,  2 Apr 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111777; cv=none; b=iDrImjLbB9VwSidsbSqACRDsLCnn8qoQ7wEKK2wQ4KJI6KAh17SqG1b2DYiZf8uITGsW+oDreFMhSQPYDK9Rb74pkDVtl/q3tWA7Qgvsq8dwg2THqo+H7p6wUdl4l1xgf9b1mbVPalHev9ToisjlBDAxRIJomkquji5jf47iDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111777; c=relaxed/simple;
	bh=abPjanY1ELVOn0HUfcTH8+1kWmooYWe5YCZGT/mTdwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6sXNmXcBA+xqdrGFoUj2RbNffKgJKqQvMM4X4i2Ms8NlW9cfzYbSXcWhnsVkBI6hdi7KypdAFW+UtoSwqFEz6d7BpSUwSiEbJJKuqlbU9X73t4/p6l1/rSfzVcD4d0Is+vPOIkiWtVlODQFR/RoB0A/MNxQzTXGYVLajmDTbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qS/Hc39L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WqlEYd1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qS/Hc39L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WqlEYd1"
Date: Thu, 2 Apr 2026 08:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775111774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abPjanY1ELVOn0HUfcTH8+1kWmooYWe5YCZGT/mTdwA=;
	b=qS/Hc39LSj3QqeRTsqZkS7ncbNrhTIz/6J7U0LsjJ9jo4KqRQKbEqenpDwLLz6qGVHKMQA
	38fnf5nxzS5CFXSD7ji8gvfME6rMZlqS+qxH8BZeQ2lCoFTavm3ZV8GVHV9jIZI8nUSY5g
	3F5mCGvEveKVQywOopLFQqKoq4Xq947YzyyJEHUBmHxqnbx7QM+/RsWVhjd3yL1v6SveQi
	7U7d/gg8N3sMgeZy0L3rRf7QLgUx3m9hrXqx5x8YnbIhnvRXQ50tOmmxpseIvODxqqe08I
	ISz2L0HSUJSk/LjFtymDKvlqDuQ25jcFDvZwaWj7w7UbjTgb7FS3t8f4tfTENg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775111774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abPjanY1ELVOn0HUfcTH8+1kWmooYWe5YCZGT/mTdwA=;
	b=8WqlEYd14NFiRq9NXlLXX5wnxhY/PcrYYV2SSqj9kkVZO6VNeu+t0UQxAMJIgrz3Y4t6ej
	HtnWVuIsvkLBYoAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	pbonzini@redhat.com, skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] KVM: x86/xen: Use trylock for fast path event
 channel delivery
Message-ID: <20260402063612.VVXEy0qn@linutronix.de>
References: <ac08V4TaM2yh9SY1@google.com>
 <20260402013102.21951-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260402013102.21951-1-shaikhkamal2012@gmail.com>

On 2026-04-02 07:01:02 [+0530], shaikh.kamal wrote:
=E2=80=A6
> The function uses read_lock_irqsave() to access two gpc structures:
> shinfo_cache and vcpu_info_cache. On PREEMPT_RT, these rwlocks are
> rt_mutex-based and cannot be acquired from hard IRQ context.
>=20
> Use read_trylock() instead for both gpc lock acquisitions. If either
> lock is contended, return -EWOULDBLOCK to trigger the existing slow
> path: xen_timer_callback() sets vcpu->arch.xen.timer_pending, kicks
> the vCPU with KVM_REQ_UNBLOCK, and the event gets injected from
> process context via kvm_xen_inject_timer_irqs().
>=20
> This approach works on all kernels (RT and non-RT) and preserves the
> "fast path" semantics: acquire the lock only if immediately available,
> otherwise bail out rather than blocking.

No. This split into local_irq_save() + trylock is something you must not
do. The fact that it does not lead to any warnings does not mean it is
good.
One problem is that your trylock will record the current task on the CPU
as the owner of this lock which can lead to odd lock chains if observed
by other tasks while trying to PI.

So no.

If this is just to shut up syskaller I would suggest to let xen depend
on !PREEMPT_RT until someone figures out what to do.

> Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D919877893c9d28162dc2
> Fixes: 77c9b9dea4fb ("KVM: x86/xen: Use fast path for Xen timer delivery")
> Suggested-by: Sean Christopherson <seanjc@google.com>
>=20
> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>

Sebastian
