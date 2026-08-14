Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB4963AC
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734670; cv=none; b=sLiuSl0iL1jLNwwpQexZEBy9WX+U74thKgALh+tiM25eiJKuZjSMmypjRCQReF0Dad6jFkoGaGKLQ1oFk3ZwP8M9PNysuVHsBU/s47qWiw+9IGHLBXD193ypSztbfW0qUahyxXUbk0hunLwvXNCR9sGy/N7/Xh6tbIgao4z5gJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734670; c=relaxed/simple;
	bh=w9vAK1GoosRceLnXS1z6Nay4ihVtxX38bQKCwzrAPKs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bUThQwwjp0Ly6ACxe0QLOGp+gB4tJ8dI6pUwykmqtov828J5djk2cAdCjNCoKCm0oXi5OfmWiu8gdKmVihs5h50rtORz/t2lpMWXaq0JQLqAsSzA6Puwy2YxcFBkpGlcym9+kQvAQLgyoGmN93fs2liAVMZlqlfJ0fnbAjsqBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnI2TMhh; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnI2TMhh"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e048a801dso1542622b3a.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786734664; x=1787339464; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFEy1Pzzmf9oV8+r6B/Uh7d0hODw3XhZm9afSq3e+o8=;
        b=EnI2TMhhskdddhoRMYDznQch7mAGVzN6usJ6fj+ffWw3m7qiZs7L4CrQQC2/+W3d7h
         pEsn30S0cwI8ERTxhEP0doTNHzGskSD9rOFGvOvv1V965zHQ/YpH7LxwdQ3a/M80JvzI
         WPns0fGFSdsYH+l90e7AnNIswcNhSTa5z3L/qiNKksTk4BpUb8FajDQNy5TRhhI1PqAr
         ekWk2vFsMGbOfvWK9aLaNXxZ0jBeUN2IIgJofrwytiJGdSGr2VX4dHZnrnJWtz7Y4cXl
         dzaUtwoBxo/ymMn/liIF6qPzwI4/BI/lxMV4fZquFsoMBDtiDrrMaHg+OrIbbmIej0Wa
         ySoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734664; x=1787339464;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFEy1Pzzmf9oV8+r6B/Uh7d0hODw3XhZm9afSq3e+o8=;
        b=atOwinPXDVHtHmgIalqUXujz5vwq8zOvPRAiaHGKry2auGtB5VO328ycJ7QoGuf1q5
         ZqDIxSc8pMXhzDqRwa4fhKY5cgYeFtThDgn3PPPWrayuHyXVaRtnBx/UXWDZgbPrPMYv
         cR8/OcPLFK44lW66exTCk1QBecxhjczFLfOaEyiMBUWx2L9pvfZfTHxhLyO+93FY7/Sr
         MS+K8YRzh5qx+QYdTmvaa8BR+c5nYMU7L0KSyg0/I0vqELiHLMdQ2pGJGtQnyiviS2GD
         ssDbIjeFXN2Hhs1wUdKmYWB782y7DxUtpzvQ0147cw6CvWHWHteOxbYieGnpOkKHMhQU
         P/Cw==
X-Forwarded-Encrypted: i=1; AHgh+RpxdBEUndZ0EG6zRkI6zaXSHf3oaSEOeyrPirdOsVTUDz7nTK1eR2ZoSri9IUtGQVVcFlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYT4IRVGawJpeW+RLRxxzFOIAKM70TogbKkXi9r37KHvZ0XyW
	xPd7R5yllySsgAkdWResdYEpZvI3AtfTA5VNQ9xKDlqzMo2uxciZDHdV9Ic8H19SxhCSNlHWymh
	qIIgmuQ==
X-Received: from pfbkr10.prod.google.com ([2002:a05:6a00:4b4a:b0:848:569f:3464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4004:b0:847:99bb:b6d8
 with SMTP id d2e1a72fcca58-84fde251c75mr9480785b3a.26.1786734664084; Fri, 14
 Aug 2026 12:11:04 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:11:03 -0700
In-Reply-To: <an9JNUln8dKaidQc@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ak-EKSslAz1uqEtv@J2N7QTR9R3> <ak_wC4Q-mQe14DI8@google.com>
 <alDI1b8fC99SG4_a@J2N7QTR9R3> <a127176a-1722-460c-aa84-754e1d343f53@arm.com>
 <an3sEiQlIuGEjUur@raptor> <b6080c23-a2a8-4bc5-b3bd-982bd766c648@arm.com>
 <an5UJ4S_P1LUFmzD@google.com> <487aa57c-72ad-453b-971d-ca24a8380429@arm.com>
 <an8SOvLybeilzCEU@google.com> <an9JNUln8dKaidQc@raptor>
Message-ID: <an9oR3dBVgFs7j7q@google.com>
Subject: Re: [RFC PATCH 0/3] KVM: Dirty page logging for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: David Hildenbrand <david.hildenbrand@arm.com>, Mark Rutland <mark.rutland@arm.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Alexandru Elisei wrote:
> On Fri, Aug 14, 2026 at 06:03:54AM -0700, Sean Christopherson wrote:
> > Yes, I'm supportive of KVM expressing to guest_memfd that page migration isn't
> > supported by the VM.  I'm only objecting to expressing that memory must stay
> > mapped in S2, because guest_memfd doesn't care *why* page migration is or isn't
> > supported/allowed by a particular VM.
> 
> My naive contribution is this idea I had:
> 
> 1. Userspace queries support in KVM for feature xyz by checking the
> capability KVM_CAP_xyz.
> 
> 2. Userspace knows that for feature xyz to work correctly, it is required
> that memory remains mapped at stage 2.
> 
> 3. Userspace creates a guest_memfd instance with the right combination of
> flags set and _unset_ for feature xyz to work correctly - i.e, to keep
> memory mapped at stage 2.
> 
> For this to work, new guest_memfd features that might lead to memory being
> unmapped are enabled via a flag, and KVM keeps memory mapped at stage 2 by
> default, to maintain compatibility with an userspace not updated for the
> new features/flags.

Probably?  It's impossible to know what the exact flows will look like, but the
common theme for everything will be "don't break userspace".

We might make guest_memfd page migration opt-in, but if all of the incompatible
setups can enumerate their existence prior to creating guest_memfd files, we may
handle it all automatically, e.g. enable page migration by default, but disable
it if a TDX, SNP, pKVM, or SPE-capable VM is detected.
