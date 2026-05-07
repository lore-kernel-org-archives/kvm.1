Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1F3EF643
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180952; cv=none; b=IQVKoMtdVG+JZhhYMvvOKPa149t0lBvdy+92TTe4RuVfldMElAzdmShjDyAydR8yazzKiRVfqTQ7W/tgFoS9igZn7f4IwzxS6FnlLqkRpGdoc1S9FqUyZUf016ZKs/poLbMaEGBuwrt8uQF/LNhu1D3mJHne4rd6qQZCcaXrrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180952; c=relaxed/simple;
	bh=Ms2KvJFVR6HYBltl81OHgXxkhjfuXDqHHtKaMZKJquE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qSTp/aZBPC2+llaNXnL/a34WetAZ44Fsf0XvvGK48n71lwu2cXFXnLxN4KpCj51A/E0C7NEkaWQPEOjT0I5tuSLOImsrcMVwQSIlI/dW15OYjM9rYZ9ReKBxbzgeKmkjKKa0oG0hBy3grrVdqSnFm6MVXw75WoOywLrGSW9iqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWx2uA+p; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWx2uA+p"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9b8137828so13478205ad.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778180950; x=1778785750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KoXjOK5QFOjtrkDoTfqMRdZ3nPGO5a5QHereU923po=;
        b=XWx2uA+p+2REwzJrj916lCFldNJ0UALgNvGcG/DN5sEqE0AOkOUi7lSAtnVlC8A1i1
         L06LWKH9p/KtyQLcZ7q1FRnghrkb3nwc9kt6JRGVpBqqycsNiz0bQKv7tP4f+T8MeQd3
         ZAc7t/ZAlHTrfX5du7q4HHVp0QbcWSlTGnOW1XyU06uEzN2zrIluu4wcZRGI00SUAXmg
         EE7GJqFEyk1IhvQw39cv2eV03DfOgIHDOSlm7XZDRcx2L+ZFeqNAT6BazvjngmGKpf/B
         67AK/ddBWLuIu3am528DWAz83QbKIEZgTUTxVdABiSV6TxxUnwihWIo9goxWe+I9F7cS
         WBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180950; x=1778785750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KoXjOK5QFOjtrkDoTfqMRdZ3nPGO5a5QHereU923po=;
        b=Y4szYVIv9AjT/k0Tqw1QG0r+Vw6JZ0aXb0khoJ5mO5jadU0HdcFmFCT6FUwXXBGSwy
         J5UUxAplkyMdRitsZHLV0y9w7mJKxoDlRqItOzFWhBZ5cb4lGqpEXFsTbef5bIugCUs/
         Wvw2wHhjt80si+doXRPm6URoVPZI8j4ouh1Z/CmSEo7e/46q3B3enfGAiIJCW0jOf63/
         XU27d0iQmT7f4RMCwT9HBFTTbwwxYdh8FhQtge3BbXroLh9SdEUtuFAmf1RoW4Iv+my4
         YeNeUiTyBZj7UOwaRaCr2kbKZ5Q75lgYxP4rUR3375sU37JRvIv3nNXtldg/tCkV6rTB
         MpFA==
X-Forwarded-Encrypted: i=1; AFNElJ/EaXQzlN2bXBNnbN7LcjrWHzjfezAJ3/dYRBdZuSp1CdhlGyNOP5Q4pRI9OGwYmTo3cKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOiic3wowfegBkLg9KTDXy6bmFTUieWbpevmty50JUcnF2B7De
	d+RPL/Dr9vfva5P195uFUWDy/tCnkU8R0SToJ/K4s5rX3q7qkabJ/w9/jj77i/6NYo8JEId9F0R
	p+8ar6Q==
X-Received: from pgbcp6.prod.google.com ([2002:a05:6a02:4006:b0:c76:a6b1:ed23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328e:b0:39c:643e:f062
 with SMTP id adf61e73a8af0-3aa5a9056b6mr10273614637.7.1778180950020; Thu, 07
 May 2026 12:09:10 -0700 (PDT)
Date: Thu, 7 May 2026 12:09:09 -0700
In-Reply-To: <CAK8fFZ7LEyyR2ChXCD7B8vjvDcyG1c4jtv3wYMV4GCiUkOi1Pw@mail.gmail.com>
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
 <afulNSVKMzrx35i_@google.com> <CAK8fFZ7LEyyR2ChXCD7B8vjvDcyG1c4jtv3wYMV4GCiUkOi1Pw@mail.gmail.com>
Message-ID: <afzjVYupUl-nlaDK@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Lei Chen <lei.chen@smartx.com>, igor@gooddata.com, 
	jan.cipa@gooddata.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 07, 2026, Jaroslav Pulchart wrote:
> > On Wed, May 06, 2026, Jaroslav Pulchart wrote:
> > > > On Wed, May 06, 2026, Thorsten Leemhuis wrote:
> > I think the only remaining question is why/how KVM's master clock is getting
> > disabled.  But that's more of a question for your deployment than it is a question
> > for upstream; it's possible there's a different KVM bug lurking, but it's more
> > likely that something in your setup is incompatible with using the master clock.
> >
> > Note, it's certainly not "wrong" for the master clock to be disabled, but it's
> > quite suprising, especially for Firecracker VMs.  It's worth investigating as
> > there might be an underlying issue that's very easy to address, and "fixing" it
> > should provide (very) small performance benefits.
> 
> I've dug into the "master clock question" and have an idea.
> 
> Our Firecracker hosts are themselves L1 KVM VMs (nested
> virtualisation) running on AMD EPYC 9454P and EPYC 9455 hardware. Even
> though the compute nodes use cpu_mode=host-passthrough in qemu kvm,
> the invtsc CPUID bit is filtered out by QEMU, which I hadn't realized.
> Without it the guest kernel marks the TSC unstable at boot:
>     tsc: Marking TSC unstable due to TSCs unsynchronized
> and falls back to kvm-clock as its clocksource.
> 
> I suppose that in turn prevents KVM from enabling the master clock for
> any L2 guests (the Firecracker microVMs), am I right?
> 
> I have resolved the issue by explicitly adding +invtsc to
> cpu_model_extra_flags in our OpenStack nova.conf. After this change
> the L1 VMs now correctly show constant_tsc and nonstop_tsc in
> /proc/cpuinfo and switch clocksource to tsc. I also confirmed the IPI
> storm disappears without the v2 patch when +invtsc is present, and
> returns when it is absent on a vanilla 7.0.3 kernel.
> 
> So could this be the answer to your question: "the master clock was
> disabled because QEMU silently drops invtsc even in host-passthrough
> mode"?

Yep, that'd do it.   Linux-as-a-guest will prefer kvmclock over TSC if the TSC
isnt constant and non-stop.  That in turn will prevent KVM (as the L1 hypervisor)
from using the master clock, since it sees the kernel clocksource as not being
(directly) based on TSC.

Thanks for the follow-up!
