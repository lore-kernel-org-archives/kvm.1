Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B3AA1B5
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099512; cv=none; b=P7fcno/yqc09SdluDko7M/NVR9aCaxftjmAlPINixIvm/fn2OeAu3T8vaNNk7xeXeRZr/F1nrVmUJsrDLveUvU2s1nHOStkDBSPOQZGRblem6ssn1Nlk4Zc4X5CNNHSVslJSPY9gXBJjwhnWGaGkWAJGrMP+g3L33XIgzj6YV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099512; c=relaxed/simple;
	bh=k/tQwvqVISs2bUVt4y8ukWyBJx8foARltb1HBIAL4TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R+8nzW0ZRYo3Vw5Z5bQSH/DUQUZWnusIbOAulSxWeWjK9VmyJtM/Edu3ytLkCT2MX8IWqijPVb5XKUykO9Z9UGPlbYRqXp9O8RgfB0qNf9ssDKNmbooX4tlVG49T9MDONO44S0Adsf9wL88gn4DoDigl/gRJV9RS/abtGS06tT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJZsoMAx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJZsoMAx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d0d71c61so14812b3a.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778099510; x=1778704310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PN+d90pj33BIESVazsrPULAMfBqv5rE6hJ/NhtaGIIs=;
        b=qJZsoMAx3o8x2lPEKa4tww+PZrTRBx3VWfydi9YZxgYdq2jSnmz77NpYFSauby3LA2
         Q3tttLIRFmxVmd6nFxjoG2TxoIhGXlr/dLMyiU65nWeeX5onwBE2piLo9uosM7B9v0N/
         D2sxg5Ydh0Hw50zrQXF0YklpORkHzxtIuU2wBdMwlsD8b8LdNY7t+dKPUfHzc2DJ/G6S
         V9x79PDUlFg8HH3RkHlgvORTQ8ljwvk7Jcxl0ZIABA3aX2WC8vR/G556VedRZlkOMndb
         I2R/rlL848s5ucougm+0COxHWav0YNqTgpERL47aFTe5bJOOUp5o8hV03E4iF1Mge1iw
         c/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778099510; x=1778704310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PN+d90pj33BIESVazsrPULAMfBqv5rE6hJ/NhtaGIIs=;
        b=HbuFX32xzu4pk9VNbSudfnrdlIgL2+Qxsm9zEdqLyJ/lv12pqgjjm9aWMPLYFsegWF
         iOa8k78wonxcQPDu7vCCEZVV+CDTSVF4F1Os6ZI2e20muqp8MG84IR/8/jnc2qPWkv7B
         abFHJBjSPl+aZ0A6Xz0XEdlq8AhzePnJYk6v9ujKeCzERkqEPLAcCKSQLAUcfHTnPYun
         hVh8KQ8lRupg16xu3aDzO0vP9OcPWXxSNIlTf1urDPtS7RKN376l7O2bVVNkq94CLPfu
         Ohrv3ciZpYz2kuG5JOD/FW82LnLv+1QztYDT1WADPTeRQXOpntWua3m7uDISPvfaL3Bw
         hX7A==
X-Forwarded-Encrypted: i=1; AFNElJ/Uh6jVBevq15YNcccbRSNjn6XZyKmrzqJ3SiYxQwhyTVpt4F4x5WEhS5PMz1KBPYHWO98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+wDul+wnT/iklVNt/3cvqG/7pzqwwor/1CsAR2vNaqgTMi/E
	1anmtadqxKCKikQNlTOqCY+olDSIKD91ZiS46PC5RkcewNjEhNpSNf/z1FvXqLGQNelixXWm3Rw
	4UvP2Qw==
X-Received: from pfnx18.prod.google.com ([2002:aa7:84d2:0:b0:82f:bf29:61aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124d:b0:835:7c0e:b529
 with SMTP id d2e1a72fcca58-83a5bcd244cmr4790051b3a.12.1778099510363; Wed, 06
 May 2026 13:31:50 -0700 (PDT)
Date: Wed, 6 May 2026 13:31:49 -0700
In-Reply-To: <CAK8fFZ4j1tYc+eYH79RQnNSjr9J-SocFL6duMuBg+76NHhRUxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
 <adf8Q1VSeAMMyCa_@google.com> <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
 <afs6PJzU3rHZwGv3@google.com> <cd8a2ae6-a276-480d-b942-bcd318a30451@leemhuis.info>
 <aftct6WWHdOG_EwX@google.com> <CAK8fFZ4j1tYc+eYH79RQnNSjr9J-SocFL6duMuBg+76NHhRUxQ@mail.gmail.com>
Message-ID: <afulNSVKMzrx35i_@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, 
	jan.cipa@gooddata.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 06, 2026, Jaroslav Pulchart wrote:
> > On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> > > On 5/6/26 14:55, Sean Christopherson wrote:
> > > > On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> > > >> On 4/9/26 21:21, Sean Christopherson wrote:
> > > >>> On Thu, Apr 09, 2026, Lei Chen wrote:
> > > >>>> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> > > >>>> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> > > >>>>
> > > >>>> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> > > >>>> every time a vCPU is scheduled when the master clock is disabled or when
> > > >>>> the vCPU is loaded for the first time.
> > > >>>>
> > > >>>> Restore the throttling with a per-VM ratelimit state and gate
> > > >>>> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> > > >>>> scheduling does not generate a steady stream of redundant clock update
> > > >>>> requests.
> > > >>>>
> > > >>>> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> > > >>>> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > > >>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> > > >>>> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> > > >>
> > > >> Was this performance regression ever addressed?
> > > > Nope, not yet.
> > > >
> > > >> Looks like this fall through the cracks, but it's easy to miss something.
> > > >
> > > > It's in my list of patches to apply (probably for 7.2?).  I didn't want to squeeze
> > > > it into the initial 7.1 pull request for a variety of reasons.
> > >
> > > Hmmm. CCing Linus so he can speak up if he wants to about the following:
> > >
> > > Given that this is a fix for a performance regression[1] I'd say it's
> > > not as urgent as a "something stopped working" case -- so I guess it's
> > > something where the "[fix] "within a week", preferably before the next
> > > rc" approach Linus recently mentioned does not need to be applied strictly.
> > >
> > > But Jaroslav OTOH reported it more than 7 weeks ago already and back
> > > then called it something that "severely impacts KVM hosts running many
> > > Firecracker microVMs."[1];
> >
> > For a setup that is likely broken.  On modern hardware, the path in question
> > should never actually be hit.  I do want to resolve the bug since older hardware
> > and funky setups do rely on the old behavior, but it's not pants-on-fire urgent.
> >
> > More importantly, the original reporter(s) hasn't responded to any of our questions,
> > or to the proposed fix.  I'm not going to rush in a fix if I don't actually *know*
> > it's going to fix the original problem.
> 
> Hi Sean, Thorsten,
> 
> sorry for the missing response from my side, this thread unfortunately
> ended up in trash due to mail filters on my side and I completely
> missed it.

No worries, gmail's Spam filter is my nemesis :-)

> I currently don't have the full context loaded back in yet, but I'll re-read
> the thread and follow up properly once I do.

I think the only remaining question is why/how KVM's master clock is getting
disabled.  But that's more of a question for your deployment than it is a question
for upstream; it's possible there's a different KVM bug lurking, but it's more
likely that something in your setup is incompatible with using the master clock.

Note, it's certainly not "wrong" for the master clock to be disabled, but it's
quite suprising, especially for Firecracker VMs.  It's worth investigating as
there might be an underlying issue that's very easy to address, and "fixing" it
should provide (very) small performance benefits.
