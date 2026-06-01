Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190773B5F7E;
	Mon,  1 Jun 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325249; cv=none; b=JjQHduSyhMS2KpICzUTJoyUmoXKQ+HePL5uBxNXVNn/1mFn8QGq+NNGWHSA8vXt3gHR90nLAEMgrz9iUMVbGRIH/VHd6h/Fs+MWyGGv0/eUq2xZSfwDMrBXA3LPlq9DiKyQBl61DOlax70mbDjREvZmYOLQNiSNjDHAWAW67msM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325249; c=relaxed/simple;
	bh=I4qvV690ukthv0AHkyn4U6UrYplygOXQ4VWkll9nyuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBwxLgZWMDOtEdV9bNg+s4tTgqQtYdGK8LqF1TJ/dLXzyc0KOpK4FYDXBBqrmBuI6y1y8hNoTjPUvkIWgdu21kZWsdN1Zts2Lpyze8s+G2WBRpwxNgM0DzCLaDDoAHi8HIvVm9fNPL2ecSCiJubF2TN2ChbqVDttjTvWL0vA9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EZEGUT0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rMvZ9Nb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EZEGUT0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rMvZ9Nb"
Date: Mon, 1 Jun 2026 16:47:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780325246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pO+MbAwxuh61FOFjKgaKEUTdkcShMV0KP0Co9dVPO9w=;
	b=2EZEGUT0UQUltojw+cCSveZwhkQsu17KGXXzmR/IZxF8p+4HX0tpoFPwsHsSGfoKx+u1nt
	OCPc0GImCDCUz6YgzEW7rwHCZ75bqBj+85CQGVKGpuM/4VNV3B8ok17QqxkO8Dm1wSPc2x
	QSAppp7MLqGaRJ8+nHhjgQVuwPyqRaVSjeezJn2GFlItY6Ie8W9a3FLd4p2pOBteC5E+V2
	ztoK7/G99Qo/dhptnxPVbuWI1aZmHMb0yOKdxZg2DgAbO5SBBGV1yBpAkB7p9NVD1Pe40w
	Bjx5bjg7L17c2D++RFtQBYaGgIuNkszZpjkuMdRMjsYXdZHgrCVZtmiqjPcqKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780325246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pO+MbAwxuh61FOFjKgaKEUTdkcShMV0KP0Co9dVPO9w=;
	b=1rMvZ9Nb+MEqMIJwtard8GkR5g7hlY+xT6ZeVzTDiMPhObGDn/sorceqrULY4qM7ph0gDj
	dNy+gLIVGMFVpCDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260601144724.ARQR8tYh@linutronix.de>
References: <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
 <CABgObfYJsacrCDHRouLDsEz_QF0EBQd8pu3g-V_gta6Eac2e+w@mail.gmail.com>
 <14442dbf1e6d758fdd4756f2ed5c8cb2738582fb.camel@infradead.org>
 <787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org>
 <20260601134008.rllwJtn-@linutronix.de>
 <a9867c036a1f6b6d29c0838b8e6884d814dfde66.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a9867c036a1f6b6d29c0838b8e6884d814dfde66.camel@infradead.org>

On 2026-06-01 14:53:14 [+0100], David Woodhouse wrote:
> On Mon, 2026-06-01 at 15:40 +0200, Sebastian Andrzej Siewior wrote:
> >=20
> > Okay. This complains about non_block:
> >=20
> > =E2=80=A6
> > > [=C2=A0 429.927260] KVM: non-blockable invalidate_range_start, non_bl=
ock_count=3D1
> >=20
> > and commit 312364f3534cc ("kernel.h: Add non_block_start/end()") says
> >=20
> > > =C2=A0=C2=A0=C2=A0 Peter also asked whether we want to catch spinlock=
s on top, but Michal
> > > =C2=A0=C2=A0=C2=A0 said those are less of a problem because spinlocks=
 can't have an indirect
> > > =C2=A0=C2=A0=C2=A0 dependency upon the page allocator and hence close=
 the loop with the oom
> > > =C2=A0=C2=A0=C2=A0 reaper.
> >=20
> > so a lock which becomes sleep-able on RT vs !RT shouldn't be a problem,
> > right? We also don't complain about about scheduling within a
> > rcu_read_lock() section if it is part of spin_lock().
>=20
> Right. This is just a false positive in the debugging check, AFAICT.
>=20
> It's actually *fine* to take a spinlock or rwlock in the OOM reaper
> path, *even* if RT makes them in sleepable locks. And I think even the
> KVM_REQUEST_WAIT IPI is fine.
>=20
> But to fix the false positive warning, *either*:
>=20
>  =E2=80=A2 non_block_start() shouldn't complain about "sleepable only in =
RT" locks,
>=20
> OR=20
>=20
>  =E2=80=A2 The OOM reaper path shouldn't use non_block_start() under RT.

Looking at the list of users it was probably introduced for the mm
folks. Let me add this to my list of things to look at=E2=80=A6

Sebastian
