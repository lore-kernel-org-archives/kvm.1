Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719026;
	b=Vi7FM9yFLz4mLP6hDAcEOlxQCj81IWXa7joNCwttUlunqJnsttf4YCxz+iWfotDIRYrs
	 0ShI59GGUaPouhAJzlycREE+dFfY7oozTvIb/Ol3pHXj1a6E58ID5y2PeagXrygZdqbuG
	 FQzVBmIRs19Mk4z/QseBRng7X0TWar9GYPYCKv2dwWrTzd0XfPyi4/MIfcqoZqdW4euEy
	 TScjfmUq6M1iyJBVOJh/YfjYKpxR9L81AIHrcxvVAJvfIVzr+RlydqIs+5MO/o/dsjJ55
	 HphB3W5gI2YqzWIw30ptWIqsAc+UxQuEnndeTF782WNCrMiB3vih5FKBH1TG4JzIS5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
	b=Q/CbZWJabNNgM6Bi3d1E+06C3H7XRAEfxr10WyP0he9vSXteRCa11LsPxCB76imiz0MF
	 xNuB2/icg1skapdF0inl2zBsRs7r3Nf31NcZBFdtakozRfNKlc4PCy+E3N9N5tt3uqC/M
	 QwRqJuW+q0BNynK4rOzquFx8Q+MsH2c7mYw8argKzukcCylPZxJfxiz7CPn08cYzSJkAH
	 nmIyhL0KT6lCSkHbcuQ2avQ8duS4nkiI6wGfOnUUdxgutbsG/QHO1S2GRBFLi59zfGf+d
	 usR4fVdBujbrX7R7NQ4AqH6XX9GGV6wrZERJxexmcsrc3Pzc3A16LgUnqGQQN2l2bOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mW6b0k6t;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6C606D2F5
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 15:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE6C606D2F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mW6b0k6t
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9d52f684fso42299645ad.2
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793719025; x=1794323825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
        b=mW6b0k6tkcAmvwTsiyUyrFOG0yYgxbMyq/CyLo0GBeVGkS+weCWHMTorKB4Qjre1c7
         PO0M2SjA5Sg21rXACBzADNYx3Q1wHocgyf2w1QU/jmNFDjP1hc9iHbstkkvCwf1DcJXX
         MGvGihb0mOoIGRo7aHflVO0L9IbYmO/JjAwc1i+h79nYEYcGZq70VG9ydwyjXGJjuHCb
         k3cTWif9RVMoLMyXIhBHMgEUoh0vm7o8L03BIUKfk9B7JKFdX/afmGGG4q2oFhEXOlbZ
         wipwtdfJNgS9uX7yUDZkedGmdCzauAaxEIAu8NXAb55FFTKLBaNv+5O74Tr5CB7ydWsW
         oq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719025; x=1794323825;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
        b=HQ465/2zVn0gMioRAJqUzwBVJzcPheRBskPfAC8/tTkZ8OwBudsJCJsmjZGXkYK2H1
         lGGfKv5MqnvlZZe5wV55g2Oog7OKMuhwuNpwSiIHSLWPsWAKdJKzJdKPwbDBWwXoAWVK
         e94PrxxymqlqT02EcCCb97b0BLUNNXM7/VEPzwHfmDDfLW5LB+cSplmm55mWky6rJYZP
         whX9EaO0l9qqQOep8ryOC/Us4/cWPKTbaiPZLE5b7tTnMaJH3ws+jOLiF1rmxcKX5QNZ
         66qNHlns5wFByZg491I5A7+l+oRgE0Xu/98V/5eRIbyQ3hd7zJbu2zHR102EAl5yPMvw
         +cdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvfkmA6yeOkytqRgXa6UJ43Nl1GeteHi8MjUiOvN/RvmaYOPI7+9B83xNB6Ugt8V1jY3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UpqIbo7kOGFQbwrGzs/b956V4oX6OhjFOUwEpeHV2pgmAiJHL
	pGmdfZnL1c+qcs+K593oAoiXehPajE4W/o3+qPMwk1/Iye8kduZItL6DPDjLYSLPUQuGKiMN4A3
	vawL5lA==
X-Received: from plsr11.prod.google.com ([2002:a17:902:be0b:b0:2ea:d63d:f2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c3:b0:2e5:334f:f47e
 with SMTP id d9443c01a7336-2eb36489c9bmr122626395ad.21.1793719024883; Tue, 03
 Nov 2026 07:17:04 -0800 (PST)
Date: Tue, 3 Nov 2026 07:17:04 -0800
In-Reply-To: <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com> <20261026224305.1254-1-hdanton@sina.com>
 <auCucDdZb8mig7UZ@google.com> <auDvUyfzg6nLtVox@thinkstation>
 <20261027163929.2bb28d5b@gandalf.local.home> <aujLx1FOc12E72rF@google.com> <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
Message-ID: <aun68Iv_z6Xiz9mc@google.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> On Mon, Nov 2, 2026 at 6:43=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > If so, we need to make that a thread for RT kernels if you want to ca=
ll
> > > kzalloc_obj().
> >
> > Eww.  I can't imagine there's a sane usecase for memory overcommitting =
a real-time
> > guest.
>=20
> While I agree with the feeling, the dummy allocation path should be
> mostly dead, because page fault should never (?) enable interrupts
> before waiting:
>=20
> #PF interrupt gate
>   exc_page_fault()
>     kvm_handle_async_pf()
>       __kvm_handle_async_pf()
>         irqentry_enter()
>         kvm_async_pf_task_wait_schedule()
>           kvm_async_pf_queue_task() <- registers waiter
>           prepare_to_swait_exclusive()
>           local_irq_enable()
>=20
> The dummy allocation path is only reachable if it's an L1 hypervisor
> that is getting an async page fault while L2 is running, because it
> enables irq before the call to kvm_async_pf_task_wait_schedule(). I
> think we can drop the dummy allocation for good, which would be even
> better.

+1, I completely forgot what this code is doing (although that implies I ev=
er
knew in the first place...).

> Whether you would still want to disable APF for RT kernels is up to you.

Nah, on second thought there are use cases for async #PF other than memory
overcommit.  Whether or not they coincide with PREEMPT_RT is debatable, but=
 I
don't think it makes sense to go looking for trouble.
