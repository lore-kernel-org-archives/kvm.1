Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976A233944
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177113; cv=none; b=CBSGOu26EyX04/nX4bpVXj2HAqzUFsZaiy230Sv0tWKrsFJa3WtA0rAKn93yU0dIyISFEArEy8QDl2XXeDFNgYh16KzyvyPxDzXq4LFAhHaoP5eX/if6i+FhE9Ubfqmgzr0p3/BsLun1anTT1EMqfWgYjny2ZSvc5eiPUQcfego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177113; c=relaxed/simple;
	bh=h1i1LNzP05NiWqVT0BgGTuqxcgMy4FhngHTRP7/QFP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAMrGS+oAfASFTeqM58EoWIF0jQmz5iMnLYedjY6ae5rpNG9UWOR7/9MUCQWnNFT7rdHSRMkXbCBPV8RP2H3V77v7iHo59URV250/6960QDe1ZtmQQT5nWWXUnjEDPQh5X4AdfO7sG+OK7qtUrxjO+vI0R5bDVVckYawaOQuX98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlAbStSc; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlAbStSc"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so889003a12.2
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791177111; x=1791781911; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gvbUC4tWx+MypF8UOrqmL4kR8mGYeUXDAmn2/AhE9JU=;
        b=jlAbStScjAEVMeYQoqq9w/PdYiI/Fo3Y8DCHNyXcpfv4m/q0HIs3ljIy/5/RQu8f4g
         fIlpMZyRt7d4/6tbGEj2RaFIPzYu/WbUon/TtU7XyHT/1SZUaC88EBJ4aTauj+3koB/V
         TMtrUEeASGibizwsciOL869goY0qsfbVqmFpktcbyoUJmlXrWVf57lNuAl7GsSAKVw05
         krGLkfO50KXYC+UN1XPl7BabuzzdOwpmnzGpNorgDnigVR3/EWMa3+ZuciW8ERyIKPLq
         Tcf/hkqIDrwjBSD23/aX+We7VRrxlcyKtCfVUz+uCRaAir2Tboruu5zg+v18uQCtn+BI
         uc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791177111; x=1791781911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gvbUC4tWx+MypF8UOrqmL4kR8mGYeUXDAmn2/AhE9JU=;
        b=XNb5Nmlu/XVtP7jk7Hqu6fUHaVijYPkNSiUHzJDZyYfICkuBbowh3H+jEdtJE1NmHI
         /uhEinJPZMcgV74LaB/aMG/xyWwFqy1FHrK7BrD0UimzHAKmzb5cgDNVw2YLnvzLSmN3
         L/+NTtS4bjlk18fxPnCmQBJFw8RGmVhxDqoX9mnoZSIfmkPJMa0WqZ5xqnixDd3cBImq
         XMLWmB8vnJL0KIXWyxVtSl8JSHkFygSvFMBu1PLGG2ZGiPG85B1GLD9wKF5tRoe0JUza
         SiehotEIjTNbodi6fawoFCkqNCQPebG46Sv4Umoy/0jItCY1pg8yYYzEOj/+u0ki+gLB
         T6mA==
X-Forwarded-Encrypted: i=1; AKwUvByIe2T4Qepb1qFdEZhrUgqKby0mkCsBPVfbXGANI62F9Y5omfy04e2pshr6bdT8bN9piVU=@vger.kernel.org
X-Gm-Message-State: AFuF++nDTmMromPLHRqZJ0FCGNPBfNp325Q3VOTADnGgQoYxnkY/aAOz
	iwheex6vGU1XO7DwD5z/nqB88P3Z0yChNDvRwwIj4J8uZE+cOY71Ku2wVO0RUReKqASLx78Ojda
	+ZcyDxw==
X-Received: from pgct4.prod.google.com ([2002:a05:6a02:5284:b0:cc7:d0a5:4738])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b93:b0:3dd:85aa:d266
 with SMTP id adf61e73a8af0-3e0d6ce7dc3mr5912548637.30.1791177111114; Sun, 04
 Oct 2026 22:11:51 -0700 (PDT)
Date: Sun, 4 Oct 2026 22:11:50 -0700
In-Reply-To: <c18ef5464ff4fb4d607c6ae02c58024b41b3f17c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <20260922135102.GA24134@fedora> <c18ef5464ff4fb4d607c6ae02c58024b41b3f17c.camel@infradead.org>
Message-ID: <asMxlgG0BzCJvgDm@google.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, 
	John Levon <john.levon@nutanix.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Thanos Makatos <thanos.makatos@nutanix.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Oct 04, 2026, David Woodhouse wrote:
> FWIW while this is sufficient for implementing i82599 VF emulation, to
> get line-rate TCP *performance* I also needed a directed yield_to() to
> the consumer worker thread when it gets triggered.
> 
> And to get line-rate *UDP* performance I needed the consumer to be able
> to arm/disarm it, to avoid getting throttled into lockstep with the
> guest.

By "it", do you mean (a) the eventfd, (b) the yield_to() behavior, (c) both, or
(d) something else entirely?

> I'll clean up my proof of concept hacks and post them after LPC.
