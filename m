Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D24963D7
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083119; cv=pass; b=uJBTBZzAkJKozj0qmizATuw8sb3DjYovMTOTw4Hj9qZ3xUM5AS+KFLgcGEkSAW1MBjH9Jmb7ErfAIew9QJ/AFoCTZBKC+tg5Sg+wzu2yDLW541VZ9izx3rQY9I4nJZy2FH6nOTbr97dW6WnxS5Ze9jyCmJbVPL3yAvrppDtobRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083119; c=relaxed/simple;
	bh=FhSYlENSAfffr0fB2hnLYwj9NycYdYCk8jtg8WRyAe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS5tCzN6GvW4lVWGM61AMZtpnVkubnfhenidYYBC84pMg7BPB54gRiOncfgoM3nzRg3ocgmb3drkaMMw1n1kZ67kQTQzkbWx+GolRK/5S9FXkUV8m9R5nPaatF/DQ+UELrDs6GMQJVKpk9zdyUmJw437bbcX9s6hOSwGhmW9w8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=R4DmKnlh; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="R4DmKnlh"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dfee30612so404871c88.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 08:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778083115; cv=none;
        d=google.com; s=arc-20240605;
        b=OhkpD1RWymnHdo69HKWu766nwJuiNw5nlZx9flXgKB2NtEwEODk+v7Z7QO8NYHjZDW
         IXcz3A0+OTRjaT75uO5RIDg4Fp4C67wMyXkpeFA8BQ5ZtfDEi+A7P8mfNj7Y7HbHq/XQ
         +aBaE6RBdpwRSynqb0GWqGm+Qqd/gmryjwkTrTHj5IPMUmpK46PSfbUSyNTQQPJ9qpYH
         2f8mHtU0KNZC9LWOoIn15ArYnuTqc6m3xSu3rw/DRG42P2pmRIgMmJZexVN8gw8eWj/M
         h7/WlC6A4OcusL5I6UcDB3QG6eltfO7MPizorvJniFrNZhzmskcjBhK+3qDhpGySmVu5
         pXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o7GIM54i3SVstJr/lO8ZPGq5HIJS7v25gtjFcSTW0Uo=;
        fh=olqoQ7CDFqIBGnYAbtDcmDb8q6lJi0epAF/c6lWaTyI=;
        b=jVJ+S8O4elBYil8exnmzEMUTysqdYK1UOO7cME/O5Byhiv7FPIV+Or9HYm3qiDsGcC
         ONcK4RY4KGEaqgyXB8UQGpLKIYsZp441nKrM4n2Dh12L0I2tPaHp9q2glsJ8aA65Atm5
         cJzxpd5hD0mUzhg8+XGYKhNpG9orTRa4NB/+1XH4tTKNVaVpbZerKGvPLq/80jMczsKp
         qjFOD1fcaA3ebmrNP+kyTrEM8WXE5IabkH7bBJcp5wLqI/8rC1fLBbPQ6AvrBTxzjSYn
         w/b/NnPY7hg7RDN06t573EBjdQAbRcffBe9laVmldIRawM0Z7ALQWidXcjq1EfnavUd4
         k54Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1778083115; x=1778687915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7GIM54i3SVstJr/lO8ZPGq5HIJS7v25gtjFcSTW0Uo=;
        b=R4DmKnlhe9Xkd6ii1SFFgWffWrhL952M55i3IPFu/E71lsrV8VEymv0VLo640wan3u
         teo0vILjc6k+F6neFPFOyQg+GfEvEQcP8JJUWiamtmPJt5o4x7avYSUWOaSsNz63PyJg
         c+pqD4VsfbVVsKmP0NGlZesHI+Ux5OxO2B/zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083115; x=1778687915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7GIM54i3SVstJr/lO8ZPGq5HIJS7v25gtjFcSTW0Uo=;
        b=sfODc2OilIPRUkYdE/vWAOMP8TCY9eiQmwZWAX1Fu+tMOWI3X/hjQvwa5pMtdHyO7/
         TshKdMKfFY1CEmGZD2lvGGC1zTtgkaYFwZpkGnYeOMmNRK1gS+i+Vu/M9cBuKGlASl4/
         +HIrjhtoHD8Yb8i3N5NVXA3rd6CvKQSFCWgqZuSCauWW7uGmnH4IoF1o3lLxjmAmX+iE
         u/8ayhYTuTcFtVBCRl8JD4+cOZQ8pJ0fJ4xY8zITtYzcByu8lcTBdLZ1q3p0UctZDMmK
         o506PpHwopNt/4TRiO17BPOdBtbi2Yft9Lplu7Y2syF4vzDyBBLoHf/WrYykAcDMdhNq
         mEjw==
X-Forwarded-Encrypted: i=1; AFNElJ++nNI+Xyg1yAdqDEoq8j1y3dgGeH98qog7zAnXSLVJh7G/4mBGnF2hvM2r5aV8+zxodkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKe7sZ3/LbNfLtfhDprA/BLbqmDzbcHEAJPwazsMMy9Y09gDl9
	yKF3IY2a5NR/ysumOBxcztJcMBuZxRcA4Rt38yzUi/+oq/TB/Nycg+GCKPRDk8rP8WdxCAh6Wsr
	TM8UbVylqVojYxtFwyLclMmr6B9v6VpQXk3e68LI0
X-Gm-Gg: AeBDietfPAlZQSuk5N7htrbbXHQIwCxLjNujkQkTp4z4ug2V02RKbDNXdqV2r/pX9MQ
	iu01bYvjLRFUDD6fKJX7juMlxMsZsIslopf/SAROjigEeemjpmMgKGrYi1G0+SiU4oXR/AdmNBi
	jratfm7MJs00FTL/rfx9uklMAL2RQ5TDCcXKxt6UN0IpvVKJ5khqSrIgmW+n/Z8yH4tpce9JQTl
	hbeA3n865vJ+BtjzKS8gOBmWq0rSkPrVerkR+BlADq/xKI3+k+1EKRwWNJn0PPrYtrRAgDgJCDt
	SeiUNsfxJnVG1Iglsm8=
X-Received: by 2002:a05:7022:fa05:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-131963a9b86mr2420082c88.32.1778083115090; Wed, 06 May 2026
 08:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
 <adf8Q1VSeAMMyCa_@google.com> <f1c742e0-41c1-4bdc-867c-a768a5eb89c5@leemhuis.info>
 <afs6PJzU3rHZwGv3@google.com> <cd8a2ae6-a276-480d-b942-bcd318a30451@leemhuis.info>
 <aftct6WWHdOG_EwX@google.com>
In-Reply-To: <aftct6WWHdOG_EwX@google.com>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Wed, 6 May 2026 17:58:08 +0200
X-Gm-Features: AVHnY4ISyvq7t1Jo4cNzuW8GhcCkTyIWQpR3YIS4f7df6O_vWqMubXb7G9-3F-Q
Message-ID: <CAK8fFZ4j1tYc+eYH79RQnNSjr9J-SocFL6duMuBg+76NHhRUxQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
To: Sean Christopherson <seanjc@google.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, jan.cipa@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

>
> On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> > On 5/6/26 14:55, Sean Christopherson wrote:
> > > On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> > >> On 4/9/26 21:21, Sean Christopherson wrote:
> > >>> On Thu, Apr 09, 2026, Lei Chen wrote:
> > >>>> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> > >>>> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> > >>>>
> > >>>> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> > >>>> every time a vCPU is scheduled when the master clock is disabled or when
> > >>>> the vCPU is loaded for the first time.
> > >>>>
> > >>>> Restore the throttling with a per-VM ratelimit state and gate
> > >>>> KVM_REQ_GLOBAL_CLOCK_UPDATE through __ratelimit(), so frequent vCPU
> > >>>> scheduling does not generate a steady stream of redundant clock update
> > >>>> requests.
> > >>>>
> > >>>> Fixes: 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> > >>>> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > >>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> > >>>> Closes: https://lore.kernel.org/all/CAK8fFZ5gY8_Mw2A=iZVFNVKQNrXQzVsn-HTd+Me9K6ZfmdgA+Q@mail.gmail.com/
> > >>
> > >> Was this performance regression ever addressed?
> > > Nope, not yet.
> > >
> > >> Looks like this fall through the cracks, but it's easy to miss something.
> > >
> > > It's in my list of patches to apply (probably for 7.2?).  I didn't want to squeeze
> > > it into the initial 7.1 pull request for a variety of reasons.
> >
> > Hmmm. CCing Linus so he can speak up if he wants to about the following:
> >
> > Given that this is a fix for a performance regression[1] I'd say it's
> > not as urgent as a "something stopped working" case -- so I guess it's
> > something where the "[fix] "within a week", preferably before the next
> > rc" approach Linus recently mentioned does not need to be applied strictly.
> >
> > But Jaroslav OTOH reported it more than 7 weeks ago already and back
> > then called it something that "severely impacts KVM hosts running many
> > Firecracker microVMs."[1];
>
> For a setup that is likely broken.  On modern hardware, the path in question
> should never actually be hit.  I do want to resolve the bug since older hardware
> and funky setups do rely on the old behavior, but it's not pants-on-fire urgent.
>
> More importantly, the original reporter(s) hasn't responded to any of our questions,
> or to the proposed fix.  I'm not going to rush in a fix if I don't actually *know*
> it's going to fix the original problem.

Hi Sean, Thorsten,

sorry for the missing response from my side, this thread unfortunately
ended up in trash due to mail filters on my side and I completely
missed it. I currently don't have the full context loaded back in yet,
but I'll re-read the thread and follow up properly once I do.

For additional context, we are currently running the latest 6.19/7.0.y
kernels with a revert of the commits causing the reported regression,
and the hardware is AMD EPYC 9454P 48-Core Processor.

Jaroslav

>
> > and a potential fix exists for 4 weeks already. Due to that, 7.2 feels a bit
> > too far away for me, as that is still ~15 weeks away. But maybe that's just
> > me.
>
> The "user" is also a fairly sizeable company, not some random person that's trying
> to use KVM and is blocked.  I highly doubt they are still actually running a buggy
> kernel.  E.g. based on a "same workload after rollback" comment in the bug report,
> I assume they simply rolled back to the last good kernel (6.18).
>
> Who knows, maybe they also took our hints/suggestions about theire setup being
> wonky and addressed whatever hiccup was sending them down the uncommon, already-
> slow path.
>
> All in all, AFAICT the only difference between sending this into 7.1 vs. 7.2 is
> that the reporter won't be able to upgrade their kernel (without patching) for an
> extra ~8 weeks.
