Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FAB2D0C62
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718014; cv=pass; b=l7Hc62vNMR0sxLuotHGAhwC8T646FSRX04GubpBhstpUwsdoNx79+yvV+8H6R7/Pi79E4VnVlFvGONVYBOCoFsnBtH+GsjvVfVpvCznjWJQXe9L4WBXhQKQPld166z9vBSfjCygbSnAIW/HvqAR2y+aNZQBhXC1ixDeoyWk1k9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718014; c=relaxed/simple;
	bh=D1nk2qvUAEZS8QbDlL7McXKxIL+Nb4XXOhmGZeBYxLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipHzdOLnzs/K7/L9nhVD//lRrhz1wQh7xZYb4Ow1HEIZf4O6iqJh+tibY8RuZyziPLMpdxvpibIhHYFA+1uqO+tKBLKZEgxN/DXqPDV+mlljt1sljihbjXBxqTterm4gKnP+N2XiTeDWraCwItNekSPu6x1QQTpmi2w1/LyObUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qos4F/99; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qos4F/99"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so2049165e9.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787718011; cv=none;
        d=google.com; s=arc-20260327;
        b=rffrx9/jYbUzC7UBrhA7ekVsnb2ntSHUSNdSbNitv498hywP2NAintIkONMJn2raWg
         3OTN8oY/4pLMvmvpMTIprSWSLTOXx1x5DDzvP6MpJBVPT/y2Zc3Es247z8fO1UlLBb4v
         4s7YwBeUeyCKVi0iQJRabF793KlpOtHrCIeWCqXWjlEspetP+8vUnv/fIMfwzRAulZBX
         r5xVzSrwsTNSZYKLxPynu8HCOaM+1eNYhnYvpIkEs4Y4bjBi3s3ZDAjH4CoIzrP+sfU/
         FFe1U4uh8zmJoBd89wJlcwkBtDwn9hsMYCUuJS5yTIaFB8UmtSoSfor1hYyK6UvWTA4M
         Bnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        fh=eLdXS4PkYmlrA3qfNzoDW+u+NVa6oirFApq0uIDZQkc=;
        b=Z2tmy/cxZ1G0tZR6NMFQ0DKa8O7C2D8vv1e5VTJBvrDp8J0xE6SIrB1osQRmrnHtHa
         70uvscP5OeM0V7u6O6Sqmg0iGMAKS4G3n8tKfWEx8JBoH5gWnka/ga9ffT5UL4K7lZL7
         iYtLGxveDm2Bsl3v5/pjmfQG+7o5sp7dc2xnZT1sKJnR1Dq24KX4cQ1wYMBysGp3XhTc
         zLZtwQypCD2xW3t+5pBarP8KE4+/N6fngDL4JiFmbRZ2JYCvqi1NY003aZ3RtT9/QxAa
         oRN/m0PfXxkqtQjqAoX26A3m2EM87s3xiagNVfCDhukTFMf5J14XlLjp9W2zwh7vYbyT
         yzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787718011; x=1788322811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        b=Qos4F/99BxbUJc3xwYarX+r2AjD7dbp8Ku4vZdnKS8kEFntYRuOfTBcAWZYsrVEiqx
         H6w0TOnK5fv78cV6UCPWMurnkEKLAKfggbTcYn4+Pq9VZeZaCnFJtxzIaFiZ9RcIE1NI
         YWqv9jhcblldAzVi+IQL7Ezje2FuhG2E17ZRGDIO74zItzPBs8nF0e4rWxI0vwwo1KpF
         YAQSlluMDUda2fsPHSWTs/4ROQnOjc1l5zQYRfAJfEhzDJPiUmotWjokDoKPzFzpkAtY
         TcwFkkFL8IVIN6Qc844sF9NaxJCQlqU3H56sHPsk+4u7zsz5tbnKiXX/AWxImR6uYK+R
         cTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787718011; x=1788322811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hibpixmqyOvasuxRY1TWef9Bv6/eSVxU2MqEHB5Q8HU=;
        b=XwIooa+pSziHP/yO8VtTkaoLRtu8d4w2w5Vk24WDHRZVOkG+CYKQOfaTUDVRZBMeQ3
         lsYQS5FxM3gRqZ7LllaMwXoCFpnNbgPGaRy/qXpywPPAG73U2Thsx14RWzNUyiv3dggK
         Vr/t4u1kRFD6MCdoBOfusCvFQ9SIE5BocpntZDUnXVOfJ7kQ4Cm3a5z6qSLlnGTWxdJ4
         4ClIg8lcqk4i+hpLg+bB5+2z5cMv+X+ANlhkS9to+JrsKE+8Jhk20hpQmFMBVuWcCfRf
         rhjysw2eCozlJlAaS8pkhq64v52c3c1ldsJ9OHkqSAIi+w8SOzN9GPeEh+1r2Vh78oae
         +iww==
X-Forwarded-Encrypted: i=1; AHgh+Rr+yRNvcaxKtkzyi27+X+WdPCFG/60OdR9Ew8UU+VkYfnitkdAGZpEHGFx04pU323vnAXc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4baszsm+/vrM9K9Qd0+vYJu/8P8LMn/WNeQ36GADgL8e7DY78
	s7cPSDXnRKDX8iVjy/d8TC2VVbNTt7BeQzLFqNcw/nm15XDomWKrOVfdrhGEfTqj5/McWus0n93
	+LpU5LWYHBMvQsbJckt8eFsOUQ/cki4c=
X-Gm-Gg: AR+sD13JoATOVagoLc98NFeqQi/pv1OboQVbQ04FhqreQveaQXQiSPGr7Yp2ZJJKqhl
	ZjqXTC/jayLe8fE8tE7QPOaoi4Ka5iGLLlskc6dTPx6yOEr38Efc3FoxMAfqfsHwP/B0X7l6eAv
	mnY+iRc6CqJB/9/3FCpdtUHvqdv1mfvCEsiXK93Kc6nd06dSwVuwf6XICqgBTxp7j8vXpkS3OLM
	Y1EqtxXll53IdLtlPtK82KfvuHGEzc9S5GN/Jaz7YE0c6uN29dPvfCU6XXQmQ7Q9p6rvoE1Ws+k
	nOyfgu/Qx3me/2q6IIHA82qhtLKKSKzNyMOtqzN8OSACrck+f+cgkHsboNeZ7LxOIxd8MT4NCSF
	npQ==
X-Received: by 2002:a05:600c:a0d:b0:499:bdf1:7578 with SMTP id
 5b1f17b1804b1-499dc6e9b00mr31193105e9.3.1787718010248; Tue, 25 Aug 2026
 21:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821032210.792451-1-kunwu.chan@linux.dev> <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
 <42ba6de7-3281-42c9-8d7b-f7dc62c10f62@paulmck-laptop> <ef7c880f59eedf0cd2f2b26842016bbbc2b68a06@linux.dev>
 <d2bc6a2e-37da-495b-b27a-30324f327b9d@paulmck-laptop>
In-Reply-To: <d2bc6a2e-37da-495b-b27a-30324f327b9d@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 26 Aug 2026 12:19:58 +0800
X-Gm-Features: AcwNN1Vy-Kcef335itiOvd7r2OGI51aoY7vQkrbyMxmvvgeQjBDdDhEM7DLNSg0
Message-ID: <CAN_Opa_=_S=mjDW4_b6Q_4x3LQ3WSV3iVZkT3ZSebZaFRkm8Jw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
To: paulmck@kernel.org
Cc: Kunwu Chan <kunwu.chan@linux.dev>, David Woodhouse <dwmw2@infradead.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:53=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Aug 26, 2026 at 03:26:18AM +0000, Kunwu Chan wrote:
> > Hi Paul,
> >
> > I'd be interested in helping with one of these. Are there any items
> > that are not already being worked on and would be useful for me to
> > take on? I'm particularly interested in the Tree
> > `synchronize_srcu_atomic()` fastpath, if that part is still open.
>
> Please feel free to give it a shot.  The similar fastpath in Tiny SRCU
> is a partial guide.  The trick is that get_state_synchronize_srcu()
> and poll_state_synchronize_srcu() need to keep working.
>
> The commit that I just pushed to -rcu on branch "dev" seems to have a
> working rcutorture.  Seems.  ;-)
>
>                                                         Thanx, Paul

Thanks Paul,

I'll start by looking at the Tiny fastpath and how the state-based
synchronization APIs depend on the SRCU index, then work through
the corresponding Tree fastpath.

Thanks,
Kunwu


> > Thanks,
> > Kunwu
> >
> >
> > August 26, 2026 at 7:49 AM, "Paul E. McKenney" <paulmck@kernel.org mail=
to:paulmck@kernel.org?to=3D%22Paul%20E.%20McKenney%22%20%3Cpaulmck%40kernel=
.org%3E > wrote:
> >
> >
> > >
> > > On Fri, Aug 21, 2026 at 12:53:22PM +0100, David Woodhouse wrote:
> > >
> > > >
> > > > On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> > > >
> > > [ . . . ]
> > >
> > > >
> > > > When applying this to current rcu/dev, the patch also needs to acco=
unt
> > > >  for the additional bool is_atomic argument to
> > > >  check_init_srcu_struct(). Please rebase accordingly.
> > > >
> > > >  Ooh, shiny, I hadn't spotted that the atomic thing had landed. May=
be I
> > > >  should retract my 'if we get that' above... but let's see how it
> > > >  survives.
> > > >
> > > It is starting to shape up. Here is what is left, that I know of, any=
way:
> > >
> > > o A bit more work to get rcutorture to put up with atomic SRCU.
> > >
> > > o Tree synchronize_srcu_atomic() fastpath.
> > >
> > > o Disable preemption.
> > >
> > > o Reorganize commits to fix the Tiny hunks that got applied
> > >  in Tree commits, and likely other similar issues.
> > >
> > > o More work on error checking for use of banned primitives
> > >  with atomic SRCU.
> > >
> > > o Update documentation.
> > >
> > > Not that it matters, but atomic Tiny SRCU seems to be doing quite wel=
l.
> > >
> > > >
> > > > I also have more than just this patch to rebase onto rcu/dev =E2=80=
=94 unlike
> > > >  some, I'm not just hacking RCU for the fun of it; I get my jollies
> > > >  elsewhere :)
> > > >
> > > >  Btw, the current commit c68271c3f83a message says "no index flip, =
no
> > > >  grace-period sequence update" but that isn't true of the implement=
ation
> > > >  any more, is it? In fact, it *always* does those things, and doesn=
't
> > > >  take the try-path optimisation by counting both epochs, that I'm d=
oing
> > > >  here?
> > > >
> > > The current "dev" branch is here:
> > >
> > > dc5bf5c8fb26 ("fixup! srcutree: Add an atomic Tree SRCU").
> > >
> > > Tree SRCU always does an index flip, though a single index flip can
> > > serve multiple concurrent calls to synchronze_srcu_atomic().
> > >
> > > Tiny SRCU has the fast path, but must advance the index anyway for th=
e
> > > benefit of get_state_synchronize_srcu() and friends. It just bumps it
> > > in one shot.
> > >
> > > Tree SRCU will also have to bump the index, but will be able to
> > > do so manually, without doing all the grace-period processing.
> > >
> > > >
> > > > Thanks for the careful review.
> > > >
> > > What David said! ;-)
> > >
> > >  Thanx, Paul
> > >
