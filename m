Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7548C40C
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080956; cv=none; b=KTNQV2F5ducbAdAgTXDoY3auHS6nWWqy1OfxlXm7dixiTBcbPS/EmvlE52qxoIvTBOKMYFzuUhn/zk8oGQnoolonvwmxl3myrUz8nPbWH13HOX5mmeV+Zaw6oQlLEddHYfczjIkqgPCyCw9MfFJ2/3qjjlrkC7trDg81r3PJ6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080956; c=relaxed/simple;
	bh=hbB68Mo6u/IPP2ovVkT2sj3ajh8a4Sa30RDg6ZHW2tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BH1MXitR6kvNmXYIYjenmKbdyxVwAm8V7agBdBagMrhEWLQZUFYfKoWOgZx4VC6+3QZVOn/zxxxGsB47kLKOmB9wPvQOfZHdUvDQB0iqSWKNc4uk+a0xwHdRED4OL1VexqvT1bO/ULTZ+iDTr2rL/QVwutLMaELRdCL6EUqBCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEFGuM1Y; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEFGuM1Y"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82437a0e6bso432698a12.2
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778080952; x=1778685752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=buwWB1nkgqPih7qI3rf/2APZUYQhP2m22o6eBnTuB5o=;
        b=qEFGuM1YGm9hlCzeRbUMoHY0PvIgrioMx4kR8bGkln27dewGOeWw574dYJia8YaiF+
         C8PJQoU2kA0N8I0tCtPFjtE62hWJaSARWheclQjehF3fY/xZGKAFsE+bTo+lJXYBUCsx
         HA+JdbPUAJlDLNxnaoE1GZppiJuJdsnIJbtzbK79KHyo+ftYEO+q19HuomWAQZ3l+hWa
         uJxEyeDN7Sq2prM8tr77cL11/WrpDhEMH7hSubffbA6HNBvBmt9R7mFlRCZOAI1AHBIc
         O2X4GaePf7kAVmB8L4csu8gZ+pDEuQAURGj0lvUmyd+3Pc5I4iphPJTAb+Q3L7jY+ope
         i1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080952; x=1778685752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buwWB1nkgqPih7qI3rf/2APZUYQhP2m22o6eBnTuB5o=;
        b=HJIfCYMIJqitjzMOebFYlkRwjVAsnAG2N8opImEL6l6arpnPjlnFE4QJ1XwJGUu/MB
         aA3+e+paa3tgIXBOaZO4w+xXuRVXIQon+D2PlulmWzAAuKSDPvURW7FQbxhGwKp+6ruc
         iLQc1NabfpdhGYGsFc9+wU//A/fUjKQepzBAnY0wYacEvMsRRPnQKm2IV7vQL3pAs9+p
         bEQoYZSRiNyXc0jyxdjyv1nNDrKQhBdze9SKykKsassj28a6JRz/8XL4Q96JGOqFeN8l
         FdGuyf2DVbRqJ8xnZBL3+MDRXXYJR0ttFde/c00eoAizgP/71Gk3g9IBHvYtaUOWjB3U
         vSlA==
X-Forwarded-Encrypted: i=1; AFNElJ+q0WKG64pSwEG9TCXN1H/YnAUPhP9UJpyW560XXiwDMFmG/ByGegxSlvqs5+3NddTl2RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YLRwvekdDNyiETq8FEQ5HaT52yx9AUTK8XhDuCK0Ys02HsFU
	A/yVZXfIcheZE21ZYiqnQ/sVOH2HcRQvhVi98k4IhLnPNJG0NF71DWfXluCHQwoOER/VeKsdmx1
	sPuhntA==
X-Received: from pgbcq2.prod.google.com ([2002:a05:6a02:4082:b0:c73:97d4:afe0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a09:b0:3a2:f14a:4290
 with SMTP id adf61e73a8af0-3aa5aa7a02dmr4080837637.38.1778080951955; Wed, 06
 May 2026 08:22:31 -0700 (PDT)
Date: Wed, 6 May 2026 08:22:31 -0700
In-Reply-To: <cd8a2ae6-a276-480d-b942-bcd318a30451@leemhuis.info>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
 <adf8Q1VSeAMMyCa_@google.com> <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
 <afs6PJzU3rHZwGv3@google.com> <cd8a2ae6-a276-480d-b942-bcd318a30451@leemhuis.info>
Message-ID: <aftct6WWHdOG_EwX@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, jan.cipa@gooddata.com, 
	jaroslav.pulchart@gooddata.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> On 5/6/26 14:55, Sean Christopherson wrote:
> > On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> >> On 4/9/26 21:21, Sean Christopherson wrote:
> >>> On Thu, Apr 09, 2026, Lei Chen wrote:
> >>>> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> >>>> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> >>>>
> >>>> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> >>>> every time a vCPU is scheduled when the master clock is disabled or when
> >>>> the vCPU is loaded for the first time.
> >>>>
> >>>> Restore the throttling with a per-VM ratelimit state and gate
> >>>> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> >>>> scheduling does not generate a steady stream of redundant clock update
> >>>> requests.
> >>>>
> >>>> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> >>>> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> >>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> >>>> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> >>
> >> Was this performance regression ever addressed?
> > Nope, not yet.
> > 
> >> Looks like this fall through the cracks, but it's easy to miss something.
> > 
> > It's in my list of patches to apply (probably for 7.2?).  I didn't want to squeeze
> > it into the initial 7.1 pull request for a variety of reasons.
> 
> Hmmm. CCing Linus so he can speak up if he wants to about the following:
> 
> Given that this is a fix for a performance regression[1] I'd say it's
> not as urgent as a "something stopped working" case -- so I guess it's
> something where the "[fix] "within a week", preferably before the next
> rc" approach Linus recently mentioned does not need to be applied strictly.
> 
> But Jaroslav OTOH reported it more than 7 weeks ago already and back
> then called it something that "severely impacts KVM hosts running many
> Firecracker microVMs."[1]; 

For a setup that is likely broken.  On modern hardware, the path in question
should never actually be hit.  I do want to resolve the bug since older hardware
and funky setups do rely on the old behavior, but it's not pants-on-fire urgent.

More importantly, the original reporter(s) hasn't responded to any of our questions,
or to the proposed fix.  I'm not going to rush in a fix if I don't actually *know*
it's going to fix the original problem.

> and a potential fix exists for 4 weeks already. Due to that, 7.2 feels a bit
> too far away for me, as that is still ~15 weeks away. But maybe that's just
> me.

The "user" is also a fairly sizeable company, not some random person that's trying
to use KVM and is blocked.  I highly doubt they are still actually running a buggy
kernel.  E.g. based on a "same workload after rollback" comment in the bug report,
I assume they simply rolled back to the last good kernel (6.18).

Who knows, maybe they also took our hints/suggestions about theire setup being
wonky and addressed whatever hiccup was sending them down the uncommon, already-
slow path.

All in all, AFAICT the only difference between sending this into 7.1 vs. 7.2 is
that the reporter won't be able to upgrade their kernel (without patching) for an
extra ~8 weeks.
