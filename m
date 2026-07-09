Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671873B893A
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608913; cv=none; b=OwfG4B/2e1SvVYGny3VVTFfc5VoqpODcmdQ+iXSQvd0sRxjO3eGy0xFbF7enxVyMcAiCtIwY/KGMiBthJEluuba/7VFwKOlH/tWNXGwT3Jb4nS8276VHOq5bD9/jLO4qb4o1MG8wBuvJeTOeWk16VqJmn1SbTVYdooHil5L2e10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608913; c=relaxed/simple;
	bh=Z92wjpo4T3gw0Y2zNCG2Jd/Ba3+9EzNo1LTP87sUDGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MS5Ony6SWy0gBEvwT9Tjmq9SGLbjz8Ot1V8iU9JW4TPVQCWu6jr+Z5f6ODWsNcXYuGLOJYvqc3cZgjjIkg3CD+iK/vejhucz6xnBILzbEd0wQvB+F3Lgcctet5iP+nvqTt4tKbVNbQ9dPBffqqtiSxg/EVNTnZ48IPPwVADW8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV2ozypf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV2ozypf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84842381150so1423926b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783608912; x=1784213712; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvTDmaZA4veBPk22tfgJT4gMaQFjXb/XSia/PA9AeFU=;
        b=rV2ozypfHj2TGjGNnzUB71uX65+x8VyG9TDAJbVbPYBAdrwcGgUaocBlYfzgD5A41x
         MIMKO3djb3MP0xx9JP0PYrCZ3mMu/p4sGaMVURBr9fx7kLZK5on/oUW3B0jB7PEMl3ei
         wUh7XWMJ/Ju0hR06vZY+ncv2DNhdgS0Ha9LdFY5WV/laQ8a6ntijLABy3HZIpJKajAIS
         xlbfu9COFxHkCEFB6GoEgpBsKS1INFLJdi9bOTyNEcDqzg+p+47J2G0m8YDL211M+skH
         ta18t0kmK7QYJDNCF8oQ263z9yzInF4V0k0/CUnBiYHUyB0zZTgyIWgTw3mgk2uP+ab6
         0qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608912; x=1784213712;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvTDmaZA4veBPk22tfgJT4gMaQFjXb/XSia/PA9AeFU=;
        b=kur22JZ2NTH9lF2kby/XDpNYR8S2DYHBxNeaKd54/XPp4wYFXTbA9iBGwHVzcdolOu
         Qn0ZVQ4/u3sKaqTMkWP0AISmtgiZQGMjWlNrescyYeCpLXmsg9xyp9PeA6MAmlymCaOW
         kBEyyWAXpQNdMULJxjaq4qdyzEKfkEkMEY8TY+K7j7KuonXpGwKyiXVfpLpzm3O02r+s
         cl46yIXYMMegjqlAib9sRMShN6CTiVw4Spovtt/cQrwEaWhfFRNgavfaoZB3lHnfpr5R
         9H8t1yz9LEX0znSqipoaUJVyLwWoHTvUmeP91P0rsINwISmgtMffy4W6XWzEyrG8bpZn
         v0gA==
X-Gm-Message-State: AOJu0Yz4kvxs7mtTi7Qk5A18gHD0uxr4VektLHJVswFhQn8KjegrpKAc
	lREZkKp1a73JEWH+kqNJ7LbQVe5Ii3ijz2TISrjac3/20DbCvGP5ik/TI6zh0/hbufWSOxlBx/j
	6tJ+MXQ==
X-Received: from pfxx22.prod.google.com ([2002:a05:6a00:116:b0:848:5740:db83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4191:b0:847:7f3c:b5f5
 with SMTP id d2e1a72fcca58-84842ed2020mr7288680b3a.11.1783608911583; Thu, 09
 Jul 2026 07:55:11 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:55:10 -0700
In-Reply-To: <20260625070914.2175124-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528154003.3594107-1-piotr.zarycki@gmail.com> <20260625070914.2175124-1-piotr.zarycki@gmail.com>
Message-ID: <ak-2To4F5tNjyolt@google.com>
Subject: Re: [PATCH v3] selftests: add swap() macro to kselftest.h
From: Sean Christopherson <seanjc@google.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, vkuznets@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, Piotr Zarycki wrote:
> Add swap() to tools/testing/selftests/kselftest.h with an #ifndef guard.
> 
> Guard the local swap() definition in mm/uffd-stress.c with #ifndef to
> prevent a redefinition warning.
> 
> Use swap() in hyperv_tlb_flush.c to replace the open-coded PTE swap and
> remove the TODO comment.
> 
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---
> Changes in v3:
> - Add #ifndef guard to mm/uffd-stress.c to fix a redefinition warning;
>   uffd-stress.c defines its own swap() without a guard, which conflicts
>   when kselftest.h is included first via uffd-common.h.

Why not explicitly include kselftest.h in mm/uffd-stress.c and drop uffd-stress.c's
version of swap()?
