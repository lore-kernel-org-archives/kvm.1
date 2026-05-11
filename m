Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84642EEC1
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518270; cv=none; b=Zu6zm+FTGVunj1Mfc/zx+P9cA1bjng8GWl9cMmX5Sym0cxW1aLa9y3Il0e5PYnBklFohzuZd1r2fGuKatim8Y++Js9n9Zi5sKbpurUMenGjnI4iKPI2gino5g0AKImkDKJ/qdmP6XIzUzn1CBnDi7XV38p09089+EwYgw1TUJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518270; c=relaxed/simple;
	bh=3X4xRBr2112PvEE0OwmnbAt2eKpuQ6Uuwxlk0Ytyvf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mv/Bcy/jGg9Ul/WvD7TBV9pQE/6gvEkp3HrG4GrqN58WBuuMrUTAKGnOu3x/J0jubLCballJiqbICkfoFRm2/7BFXqSgSaZoN4cualRRWSmtWUuXztXw/7x4cbU2WMZ++w0oYx3H5DaFEBifmQn0WPuWJBA+nHGLAizMmoKAfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6BnKp6h; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6BnKp6h"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso1969353b3a.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778518269; x=1779123069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iom8ndLx++CwN+appoNm2rlIoGdhrDtcVkMkfINFBqs=;
        b=U6BnKp6hyngpUypeo8HgytUJ9HjrQOt2a04IqipLTE3m9roiLaIefJVGbgtRPYpUOU
         4+JO0BdJpTc8I7pseyDmaQD0gD18XcsgLMIOyApntlNRjWZ46kJktGjE66GPh0olIqCR
         adVlYjXNgoHR78G/9k0B3y5G7ts3NFjxQXBNKwQWCBANbxBL7JiZ0ZE41kePMxVK1tDf
         U3ljs4jfKGSaLs4XqEDOmFecNaQ5KQVnl83KW/MWpA3fGIoT/X2g5iHxZKNF6vQO3JJH
         bUJTBaVHX5/E/SgyeL+D8drN08OeTH0+vXGT0OA2/poRzl1p/BBr+bS2Ko1e4nZ6FyqQ
         YByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518269; x=1779123069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iom8ndLx++CwN+appoNm2rlIoGdhrDtcVkMkfINFBqs=;
        b=eeDfLLS3LmRRbN9MC3B9TqJbXYtAXW8TzFM3Ei9288TXFARgQAiISUEYbtSkoINJ5U
         L7RuGAvyTu3OP/sqAvph+ghZAPHW3+X9Zaq4jWjh9RzoK+822/9p7j6gsB9NRVMzzq1h
         SkIgG9gasqpc4ho89eLpqn5IX5BeANid+8cypfyjUCMNMPmUNIyn/9An8+okDlY4ppaQ
         lfaxwN3K9Hzy+v9DlmOBUsHieqq9U8hIaNDAZPGrg/h5BGazs3+wRK8qFV+EpI/oHle4
         yqQaMXMQnNWdvzvEhNvRHsMOeUHxGykWSa216+44m+bgfT6pnnOpbQkes2/NMUxlKTlX
         a0Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+yW0zRfwZA9R/aQ4A7R9k0ZZ43KpuWr/hblwhsyZ6aHmdKuDGihO7eEKL+E+cLcgG4XZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWXtA3CpiI+jmwDB5tDRTRiyZKyCDHhXPz+9gD8IHzoU1F6bZ
	AEZjLBgIeuy8u+yyYBQI70jhNK/trGytypMQnFlnv3j3UXx2xcLEhqMzQt50Pb+xgKEK+wL6An7
	H07QJdA==
X-Received: from pfbgh1.prod.google.com ([2002:a05:6a00:6381:b0:82f:2f42:2da4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3013:b0:838:3404:c2b0
 with SMTP id d2e1a72fcca58-83a5b8d9aaemr23075127b3a.13.1778518268359; Mon, 11
 May 2026 09:51:08 -0700 (PDT)
Date: Mon, 11 May 2026 09:51:07 -0700
In-Reply-To: <20260508181717.3230988-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508181717.3230988-1-dwmw2@infradead.org> <20260508181717.3230988-5-dwmw2@infradead.org>
Message-ID: <agII-2_f_gYMdPzL@google.com>
Subject: Re: [PATCH 4/7] KVM: x86/xen: Remove unnecessary irqsave from GPC
 lock usage in xen.c
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Mauricio Faria de Oliveira <mfo@igalia.com>, kernel-dev@igalia.com, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Now that the hardirq path (xen_timer_callback and set_evtchn_fast) uses
> read_trylock() instead of read_lock_irqsave(), the remaining GPC lock
> users in xen.c are only called from process context (vcpu_run, ioctls).
> There is no need to disable interrupts to prevent concurrent access from
> a hardirq user, since the hardirq path no longer takes the lock.

No longer _waits_ on the lock, correct?  I.e. the hardirq path can still take the
lock, but only ever does so using trylock.
