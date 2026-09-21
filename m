Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452764AE8A8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006351; cv=none; b=jFyA+pJsoHby7Fq/3NJDts5uxiHZt8br5hs0/FC3Z5b4Ca4gaIZW2R9hmdqr/1hZ5eQ85Mnur++NsWMB1Z13HIbkcjSqNZFyePMXpHnVmLinc2W9AiZilcqb+0riDy7opul9B2kMKpOecbKh8QmxPOkt0Uhev268JaXyyTSPmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006351; c=relaxed/simple;
	bh=+vA8+IlTPzIJ3kiWyLjpPWr5FYWusu29ap2ccVZ0Mqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JV36fv1D+HDBN2RgYZWHgtjVTNQzKtlGkmf5fpsE8ExyPMHq0000tvs7eI6e57QAQXdmh/ycWMaYJB/SgVA3+DtuBCmnbjrHUMLtcy8H/rL8BO30Cp26uLWf/endbIztWnO1hiE9owVPng68zM373cmoytsJqe3aJ8s6ioRD23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Izxp9gw9; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Izxp9gw9"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a0dc7f26cso4951000b3a.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790006349; x=1790611149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HCdnP4avwYqil1ySzLR4xj2VYr6SB0X0kTKdhPBlqMQ=;
        b=Izxp9gw9Br1S7Rt72cnEKozTKjk72m7OMp+1S0HabFE3hATlzwCM6el4DXOKh5mneC
         sGhz3v37soysyqGI+81vuZdKqYS7UPxWj859Eh4NFwjwFFuNLHd1hg8+u2j1r97XP13O
         Jd5OKalzoeyfU8moGvbpvyQFlBqfQYTBrLFcjs2girjN0clfGZ8YIx6wFpwAXqfqMpEs
         vNJvFBqKrFGeY+PKQd3lk3Ztw5av5NqhfA/zwoAAu48DpJtPwOEh/ucj/1ADP2MkesZw
         1dvg20bnmDfO3Q9qUFnE4BRCjdTeI6Tj5MNi338ndjLeZjSMukgnjww2IaXjVCGP0dxt
         dNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790006349; x=1790611149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HCdnP4avwYqil1ySzLR4xj2VYr6SB0X0kTKdhPBlqMQ=;
        b=dlo7bJznosIq3YlL5mta1tVYSxQGC7ysPFzjXY4uXyidiWKsZqo+nyYHeTEpNxeAHt
         GYO4ECIVnBYrY1Tu09U8QM706NWL9AXXNrYetOPJn0vV/m2m2udgxJ2hoGY+dLhdYbYD
         D4v0QqCVrcwpfZaq6i1ETSDLMgqJWTa3w+Xf/gr1NSQxHHV7JoYYgBNbTGLSBjzEoJDo
         vtpeDBOdlBdNz8kaH4P+Xbbgqm3AVjhAtlL3XyE3PqkVQ0qLHw0Gq0n1CHW8yizrrs5a
         TUol2uAKwt52LgxLeg127iNVE5UI28jFAscXCpViuZw0OIc3vdgmWToysHgNMZcf6ecj
         lqFg==
X-Forwarded-Encrypted: i=1; AKwUvByMb7lq6Z0Hh/J1orUrto46GVpiJIBrLigWVL6FRP0aiyoOuX8yt7m/iPdXzo+45STdQnc=@vger.kernel.org
X-Gm-Message-State: AFuF++nIG2wa+DYRQUWj35kHlrTRBMcZFnhjOh/xaTWOSa0GDrG6sVg9
	2JFHHICI4GJH520Cz6up11EV5lFZf+YDqzKJIkRgGxHq4hfZyRHwIbHf031LN/3NUi0OGSTcuPm
	VtPBPfw==
X-Received: from pfqn14.prod.google.com ([2002:aa7:984e:0:b0:86d:2ec3:d4c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a8b:b0:848:4754:28e5
 with SMTP id d2e1a72fcca58-874dd6fef50mr15682186b3a.16.1790006349330; Mon, 21
 Sep 2026 08:59:09 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:59:08 -0700
In-Reply-To: <20260824012716.753022-3-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824012716.753022-1-dongli.zhang@oracle.com> <20260824012716.753022-3-dongli.zhang@oracle.com>
Message-ID: <arFUTBLuLdVVaqxX@google.com>
Subject: Re: [PATCH RFC 2/2] sched/core: Defer preempted remote vCPU task
 clock updates
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	dwmw2@infradead.org, joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Aug 23, 2026, Dongli Zhang wrote:
> A remote update of a runqueue can advance rq->clock while the owner
> vCPU is still preempted by the host. KVM publishes the matching stealtime
> when the vCPU is about to re-enter the guest, so the remote CPU can
> otherwise charge the stolen interval to rq->clock_task.
> 
> Defer clock_task updates made by a remote CPU while the owner vCPU is
> reported preempted. Fold the deferred delta back into the next update
> that can proceed so IRQ and steal accounting process it together.
> 
> This requires the hypervisor to publish up-to-date stealtime before
> clearing the preempted data.

What happens if the hypervisor doesn't do that?  Because it's infeasible to
guarantee this will never run on an older version of KVM.
