Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D32C08DC
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206341; cv=none; b=paxC3bSENwdB5wRtlx53XgH8EpTG64Ho7wEdMK+XqREEJK2/dJ6Pw/XcAbRC8iBmeGxmbPV6TZAFgzS3Ts18cRCGHx8nYX0VjVyJdHfN6hqpiYYO6BmPdBC0IA6YztAYWvlLHFuB6YcCVqyzHaqyGOuBX2vOjjVX8xxLjyUXOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206341; c=relaxed/simple;
	bh=jyNNu6CF3tM975V6PcONy5U9p2ftLc0N1pfgPHoAIaY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8BCZE2xudGez0PN7pr9EZ19/hs1DLI7Y9pNmm5B3MLseoQEKzIvrckUSvqfOxhHgYqAsMNu6FKeE+Wdjrxr1XCc2QVp/zfRVh++N+b3qFtyY8JDoMQZuSt71uE4V8qEKG7FLGB8eo+bsqAuvjVjrHJmm/BVvxJ+6ZOnAqzWpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUFnMN4A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUFnMN4A"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so3159934b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776206340; x=1776811140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=stm35/IY3TODjr+mpw9XhLFzvYJAzwSOp9T5zlC+DrI=;
        b=MUFnMN4ANRzgFqwRky9PFVLn0BcMAc4H+eWZJrGAf2FtSaYixTAgBT4TRwo4NTgCMt
         3wkgLvO+JzlJVI4WKydzkoC/6uygWr8Yh+AlYbzUd0QqtcmCXXSDYZDwj0S/v0rvavUd
         o45/bHnLAz8ZM6vSpYolFTZL4JFWGcgSQzfQ3RPIyC0oJ0JnVM1Z2ut6VAM+Nim/iE/j
         xLvoXLVIWBO0zx/cDSju+9y/YGbCAiIP4MVHLSTcHP9SIghk9pqZqKh0rd04sjeOhgki
         rpZ1FyzhoAKNnn0FsPW5Qi9konRYk8I0hz0XcKPbYU5gUphNMcTlmOD9D3lDdM05kQHN
         jdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206340; x=1776811140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stm35/IY3TODjr+mpw9XhLFzvYJAzwSOp9T5zlC+DrI=;
        b=Jq16TxA98Y3jW2lRS7tlV3HIrf+UfFXtzI8W+UIGHjoRDUYUf9knV4W0/hOTG8JKOh
         caTqRtkTo/ZQTukefNwjSRLk4urZSXWYC+zhG95ZMeXTsU1zXw+YIbfeSOtXEXAaqTtK
         wO5ptQvg8+SILf67H2wTP4JauoATsbuyfnzsHEq5s2JyQQ6eW7+tNp4FnO/PFIuZc2Ge
         FCkVyXTMIIKySKUNJG5eGmZycReoFx1OBuJu2rtmVrkQstzvFygbhbHXC3EFjubXRpN5
         JjtmbUz7GSwbTXGbYqReBLJC/FqHzP2aI/qmQFQiHRuoyq+r88iFHpQDv2q+3PjSYWnd
         MaoQ==
X-Gm-Message-State: AOJu0YzSnybWxBXKctCRx8w+lxsmgy52gZI0fSH2e/oTs/lcds+/zPuH
	NgfMwWIc1areMJHxrfAqYMc/Q/CW2iNm/8neDN6lasHf8abc4yDO5tkzkHmifUTZ98cYCXN0k4M
	fp8Mbtw==
X-Received: from pfbdh21.prod.google.com ([2002:a05:6a00:4795:b0:829:f706:70e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a223:b0:82a:7471:eb90
 with SMTP id d2e1a72fcca58-82f0c299062mr19287033b3a.30.1776206339773; Tue, 14
 Apr 2026 15:38:59 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:38:58 -0700
In-Reply-To: <cb458ee1-e0c7-43e2-83a0-9effd9a723af@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409213333.1995382-1-seanjc@google.com> <cb458ee1-e0c7-43e2-83a0-9effd9a723af@redhat.com>
Message-ID: <ad7CAgFO53yNrT_L@google.com>
Subject: Re: [PATCH] KVM: Drop kvm_vcpu.ready to squash race where "ready" can
 get stuck "true"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanghao <zhanghao1@kylinos.cn>, Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Paolo Bonzini wrote:
> On 4/9/26 23:33, Sean Christopherson wrote:
> > +static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
> > +{
> > +	return READ_ONCE(vcpu->preempted) ||
> > +	       (READ_ONCE(vcpu->scheduled_out) &&
> > +		READ_ONCE(vcpu->wants_to_run) &&
> 
> wants_to_run doesn't seem important here, because blocking will never be set
> outside KVM_RUN (unlike scheduled_out which can be set within any
> vcpu_load/vcpu_put pair, if you're unlucky enough).

Oh, good point.

> > +		READ_ONCE(vcpu->stat.generic.blocking) &&
> > +		!kvm_vcpu_is_blocking(vcpu));
> 
> If you get here you have done the finish_rcuwait() in kvm_vcpu_block(),
> meaning that you've been already scheduled in, haven't you?

Gah, yes.  I didn't realize finish_rcuwait() is what actually completes the
wakeup from KVM's perspective.

> So, you would need something like this:
> 
> static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
> {
> 	if (READ_ONCE(vcpu->preempted))
> 		return true;
> 
> 	if (!READ_ONCE(vcpu->scheduled_out))
> 		return false;
> 	if (!READ_ONCE(vcpu->stat.generic.blocking))

Hmm, I think this could actually be:

	if (!kvm_vcpu_is_blocking(vcpu))
		return false;

Because my use of vcpu->stat.generic.blocking was purely due to missing that
finish_rcuwait() is effectively what clears "blocking".  That would narrow the
window for false positives a little, e.g. would at least wait until after the
kvm_arch_vcpu_blocking() call to treat the vCPU as blocking.

> 		return false;
> 	return rcuwait_was_woken(kvm_arch_vcpu_get_wait(vcpu));
> }
> 
> // in rcuwait.h
> static inline bool rcuwait_was_woken(struct rcuwait *w)
> {
> 	guard(rcu)();
> 	struct task_struct *t = rcu_access_pointer(w->task);
> 	return t && !task_is_runnable(t);

Ah, and I missed the task_is_runnable() check guarding vcpu->ready.  I suspect I
assumed kvm_vcpu_on_spin() would do that check.
