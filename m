Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A942C030E
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810304; cv=pass; b=XKSzxPKbA8v4g8ysZLUTXNU7dEPemchLLD9Tgb89bzGcjHOYdTQ2nwSyRW5dXULdcyS9fQXsRVaK9e04JwAwg0StI/tfMkd4eEgE0SJxVsg8Kq9fukyt0s5Slh6D9u7xBIaO9MJzq7gj27jmZ/Juljkl15X7oTHk2WdwtHVOvMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810304; c=relaxed/simple;
	bh=cc+5M1kxVfauc5Sz0O+B0zoCx4EMf3P6oC+oPwgAC7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7K+gUoKpJvmI3rcBE8g1Rbf4vG+kAMbnH5oJVpeA5gUAgu5SFheDKSWZbXeEFFtfCyAcndZ1TFe/yPdH98hLrvKl8AzJkjywPO+80NNhgFJNcalPblImjk6NGrl/I9Lf7a917ZThJ5X3L/SbyqUhC3ek3+fp0rlYyE1y9N3+OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/XpePKw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAXRQGRm; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/XpePKw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAXRQGRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776810302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cc+5M1kxVfauc5Sz0O+B0zoCx4EMf3P6oC+oPwgAC7c=;
	b=Y/XpePKwEw/TeOdJckHPx9mogPCj9JogruxiQPV7ScagkFs52ukoh+AsueDXaGlvzPvmkz
	YBtMAnXGAkP0H+/9NMC+4/R5iquyTphuH4awX2jSzCen6Zrsbcf3RFBtbrofKQgS2bvUcd
	ZpTAJjvJ1sZWLeH/IvvjzN9d5WWaamc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-3rUXS1M5PSCntKAqI6782Q-1; Tue, 21 Apr 2026 18:25:00 -0400
X-MC-Unique: 3rUXS1M5PSCntKAqI6782Q-1
X-Mimecast-MFC-AGG-ID: 3rUXS1M5PSCntKAqI6782Q_1776810299
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso35975725e9.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 15:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776810299; cv=none;
        d=google.com; s=arc-20240605;
        b=jRcvxvJQdvDQZ2o7dfmVfj5ake4vYvzgboB4ss6J0Em0vh2CyNPPG6ZJ38gBTgaNyY
         /WaERT1ouIfGjPY8eXgZ/WXbZbWdPZhYG66zex/RXQ8vJFRulJDans06bGBKJTQT3FID
         sadzQyLOOijNWAGOCg4JtrNiO+E0Qiepxj35U5ygSf37JkB0bO/zAonYW16QP1KkcYpS
         9d6gSnRqTNJyXQlXs7luUfyctjLfpeQD6Yxo02v/t3i00Tt+iMBIV+Co7SnJe7qcfBFd
         R57YzFCzhZ38HlilINazoq3qTD2v/pr+wshjWCt6aEmRBkGc94sj2wTrAwlWVB35v2jr
         jmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cc+5M1kxVfauc5Sz0O+B0zoCx4EMf3P6oC+oPwgAC7c=;
        fh=VB0P7v3oew/KD3f/msdHkSd4xA1E/14M/zAYaG7rGYY=;
        b=R6lWsQ20V8Q0pOrISABzoynioVIniDyJq1zsUnWPvlLnExfYTECsVO9nkYfRcIHZbc
         US4cwT4ZPc2haqyfgPZboiFDMUSLtqnRgTGvnX1V8ukcMnpa4NMIpAMxtOdcIwyaPNf7
         iAB4CvhSeZzZ9xFUsC1RsjcdkiG3ooisNvqtTXfUDLtVrc5k8pOP+2iRwhDTtt2yh4qd
         LehDwWKzd5ikSgdHxJ0aXIUjQ3FARboI2MkFoL/b+9s9faBHbr1stnePAm++QyFbVjmO
         rNqCu48jmrzZGhJAUuOaWNxAFdSWXW7yDGBcg+DGuORBF+jknkNngVoVzx8FFLZyFWa7
         i4CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776810299; x=1777415099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc+5M1kxVfauc5Sz0O+B0zoCx4EMf3P6oC+oPwgAC7c=;
        b=UAXRQGRmRQDhFe5MtJR9PkYS2ciGf5h2YVQQPurzlPL0KPofKuanKdwGe/Ke/Nqmgy
         XTosl70wmOrG5Eno92u0vyn0f0zL6XQqw3MIC4kAUfpsfeY1gR6tdIbdqe4kDBUddHBK
         8YIOnvu+NKaEyTGmV9Sp4OuUxslJfi2wGXtqa627GlZgRrPOME8GkFW5m8FAl7csoqFq
         j9aWuJECI5ItSu6+QkKyEnSW8/mehFSTOqqzF6u3nVR50tcgHGfP4uzvKm42qDxDqjXf
         LxRAptWrmET+/uUqvuNgmpDR40XH69lP68MNOuM16fB/DUZ4+VdG16lHt/CObJ5vxZyD
         s17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810299; x=1777415099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cc+5M1kxVfauc5Sz0O+B0zoCx4EMf3P6oC+oPwgAC7c=;
        b=nonztDM++Gtsw9s8YsecmAqkJEbQ+oZ5dU90mQjgS8dnHDl6m+bMO39EgHLMf+XpDC
         Oi+Wu6wqs/Wt57qFjWQs947gP1x/BmQWwipMRFazIcEPhAmbXt8PTEzD598AAI1IvAnu
         uwqmKxYJWl28SPix0MJisIoLxQuGwvJq0QeO5ByDkIxqGaiVA4Gifj57UfoE0mM8GFKY
         H5mqe/Owz30004Ykyt2eRuYzwAv2xmmb1enNkAtGVJ6RgFnjwlElD8jfZPX3jOLfYz4w
         AGHbuw/P+sLdhll/MuI4QNay/eAAdGdrmXCMBPtUbMPnZR2joqZlYjLyQzr3/XVeYQ4S
         3vtA==
X-Forwarded-Encrypted: i=1; AFNElJ9fbvO/Y2ZQK9baYSEWyBOgnP8HaYAi+Oq3cLwK9V5KTxsWwyjeaa2KMUQn6nBdN9pp4BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbA/VnJ4BFJxhAkPCC1DqsUSEUyXmg9sUySqWprIJo0Sdx0vX
	TTYdEtglNMjJhakERwSxGowwM1tv+sixAJwlY4gkJCB0IMh6BnpFJe+7HpPlCpduwXZvFxR39SK
	Q2PIdUaVCHV2Fu3F9oRPPa+PYAJFg62wu+WZq7Z32y7B3KpsaWIqjahV+Tcx9GpvQHUaZHZ5mSu
	Yam3+8WZNsiRPwMppo54olEN595mSm
X-Gm-Gg: AeBDievRqmG6AfnN4hdkaA2kELqgS7dnZOHteWDSQkeKR0Z4E2NlYLXiFu57X095AV/
	t/aZj0lp0PuJd1Kekjq1uiMNqcOWmf+neuZ1FIUCMVo4mBKkLxJDLGqIue3coxjmRxb+reKKnJL
	mXAAT7m6yo96ExbtBHTHP6DPfEVjBiMZGPQy5FaubF3A/PhNLrgurFeX7Ckvaij92E25sQZz5QE
	IrbUfdpI9W+vest9gRVtrLiJQyX/hlFOWBer/uSrj06PWZxaYkke/+Fu5/OIoUIjoUgytncI1DT
	Gwcg31Gnrk3hoA==
X-Received: by 2002:a05:600d:8496:10b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48900a4e79fmr146829795e9.21.1776810299362;
        Tue, 21 Apr 2026 15:24:59 -0700 (PDT)
X-Received: by 2002:a05:600d:8496:10b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48900a4e79fmr146829595e9.21.1776810298890; Tue, 21 Apr 2026
 15:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <87zf2w9e78.ffs@tglx>
In-Reply-To: <87zf2w9e78.ffs@tglx>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 23:24:46 +0100
X-Gm-Features: AQROBzCK6bSGiZpuGxrvzL1iKU44vaQtQLRzajj2JeMH-1Xo-xkY98ygQSi1rIY
Message-ID: <CABgObfa48FKEOZc0cn5CdrUc66y+e5FJVRMiBcSKr0mG3PEo9A@mail.gmail.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
To: Thomas Gleixner <tglx@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Vishal L Verma <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:49=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> =
wrote:
> This got changed by f2485b3e0c6c ("KVM: x86: use guest_exit_irqoff") in
> June 2016 to save an completely unspecified amount of 'few cycles'.

Sean answered in way too much detail :) but since I was about to do it
too that is a local_irq_save/restore pair, so 20-50 cycles per vmexit.
Nowadays, due to the overhead from mitigating side channel attacks,
the cost of vmexits went up from ~1000 clock cycles to (depending on
your settings) even 2500-3000.

Back when posted interrupt support was added, "ack intr on exit" was
always used when available, but was optional. In 2016 I made it
mandatory. The micro-optimization at the time had a consistent 2-3%
gain on some benchmarks like UDP_RR, but also on realistic workloads
with lots of thread wakeups; the simplification was also a nice bonus,
but these days this part is almost negligible these days.

However the optimization that Sean remembered is only a small part of
the story. The real issue is that "ack intr on exit" is a requirement
for posted intr support. For each interrupt from assigned devices, it
saves a full vmexit/vmentry for the vCPU. Adding the extra latency
from processing the interrupt, writing to the eventfd and triggering
the vmexit, that's at least a couple microseconds in total. That's two
orders of magnitude more than the "few cycles" that commit
f2485b3e0c6c added on top.

The reference to TDX is not clear to me either, but I am probably
missing something obvious because it's a bit late here.

Paolo

> You really want to come up with real numbers which prove the performance
> benefit to justify the extra complexity of this.

