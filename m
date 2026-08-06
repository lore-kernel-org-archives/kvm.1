Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A1239E60
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786039864; cv=none; b=swdkGJ2kBtHA2GkxZzPuSBAxziQNFQdoDABAiEL64aAKmYi82KsakRggLtvcon6T3etoV6Rz60xqDYAXS2ly2M8+5M/FTJsQI615rSQNkYN8QOBTFtnCip0e8yeqg3GecowWxi0NhuUvgQefnX6nfM9MAeBC5j0EhB+JdaIf3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786039864; c=relaxed/simple;
	bh=5LtdVhcoevxaYMFWpuGUrwt2xnJVWoRAhm65donaF0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X+jeyB/VBh43o0Y4t6Qvam3shxxxhR6NdypudNMZGyJa8qAt6GmYMrtzxcUkxXw8dhY95DdNWLXl+K9JVZnvAT/yYNIkSxPym4UuMJodtjXkszVM1Jep6rNgYTl3QRhtGxPIcNTYMUg66EfhMKw9QWQas0Uul/vPEnqX2zpsNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfQCoKiA; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfQCoKiA"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8488ac68185so6041472b3a.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786039863; x=1786644663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8NDXlvuU5iaMcvHK7I7xV9onstvlMkGv+ggfJ4d2KnM=;
        b=HfQCoKiABxxbL6CWh7rVNMlY4aDi2brkpskxbONZp6xKckPfXDIAbTOMRdsJ4+Saxe
         DBU96XbfxnQ6IJmUwGXn9XjxovH3/JBqDoo8JHzLMb3aqPKoasDpEyvV21L+IPbefeQJ
         bUM/mIHOY4+zO3qCTWnMA2i+dotvDTOcKTzKCJ5KECmnruByvJSg3sPurvPOAoZM5uVD
         yFvCLdLkJADPpA+IarILtWQIkvgOXhwLKXaHtwODKYQui11lSU6dZHCuYPhOMTCXmVGr
         CQB56u54x9cSkPGek3VGfsFq91leV8h6m13j5UULZ722Wj8JSC70Tm++P6Cl4fHKdsPO
         +Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786039863; x=1786644663;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NDXlvuU5iaMcvHK7I7xV9onstvlMkGv+ggfJ4d2KnM=;
        b=JQmvHO2LFUodMpbUwqRzJHabXMv1yXODIfn0Yo12w4zUhXr86jxkgvmkq2dcvL7ROi
         nQuxv0XfFMGFa6B7XYtFib6q0LKvsXXjRNEwBi097gv2LyI8seT/dajz56TSdKV/qGb9
         BkpoFRVmzGxCXbtssFytJMK65/KVe7JfVyZpxpzG1u+VOJiahMxHH1PgK7tLdQD2s0MI
         6RA5z95D//YCaQdvsoqnj382FFENoRPcubD9rb6XTW3ah4R4UjA0bkDjNFK7oRc9uC1s
         LN0oCq10jdT/zOasiYBE2j45APDorNr8JsNdfYyg9reGbuRud6D5i7LXX2TIxt9uX3gu
         fbJA==
X-Forwarded-Encrypted: i=1; AHgh+Roa1yodKcGHwOur9HYyEirysYUYXacUoTlHGPWtZ1Np+JvTEEd6OIlWKoKYol5rkPL2pdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYVMrmYhjs69+2RAr/BNO+6b4ptWALFvYjRQG0ZIPRJnrjMWt
	tFvAxJ01i8pVsU+L56SGHVwsJgRbq6L8xQLK5NgwrX8NmIJpsFqseM4vO9Wx2WwXfk8VM2Sce0L
	Gk/QSOg==
X-Received: from pgv15.prod.google.com ([2002:a63:154f:0:b0:c8f:f76a:4b22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2295:b0:848:62ab:7b7
 with SMTP id d2e1a72fcca58-84f2e0402b9mr18010383b3a.16.1786039862668; Thu, 06
 Aug 2026 11:11:02 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:11:02 -0700
In-Reply-To: <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805195528.3853473-1-dwmw@amazon.co.uk> <20260805195528.3853473-4-dwmw@amazon.co.uk>
 <20260805203608.D3CA61F000E9@smtp.kernel.org> <anS8C4Cxqy6ehCo3@google.com> <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
Message-ID: <anTONuMjSSD0CepY@google.com>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a rwlock
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2026, David Woodhouse wrote:
> On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> > On Wed, Aug 05, 2026, sashiko-bot@kernel.org=C2=A0wrote:
> > > Replace the per-cache rwlock with RCU for the read side.
> >=20
> > I don't hate the idea, but I am very against using RCU.=C2=A0 Unless it=
's "impossible",
> > e.g. because synchronize_srcu() allocates memory and breaks OOM kill, I=
 would
> > strongly prefer to use SRCU, probably with a dedicated kvm->gpc_srcu, s=
o that
> > synchronization doesn't need to wait on all CPUs in the system.=C2=A0 T=
he tail latencies
> > for synchronize_rcu() are horrendous, especially for many-CPU systems.=
=C2=A0 If it
> > were only mmu_notifiers that got hit, it miiiight be acceptable, but si=
nce this
> > will affect vCPU tasks in the refresh() path as well, normal RCU is pre=
tty much
> > a non-starter.
>=20
> Yeah, the refresh() path got pretty slow in my first attempt, before
> optimising that *not* to have a grace period if the memslot generation
> changed but the actual GPA=E2=86=92uHVA (and memslot) don't *change*.
>=20
> > Even SRCU could be problematic: if synchronize_srcu_expedited() is forc=
ed to wait,
> > the wait time can easily get to 20+ milliseconds, which again is a non-=
starter for
> > things like steal-time updates and nVMX pages.
>=20
> But we don't have to synchronize from the read side. The code path
> which will do so most often is gfn_to_pfn_cache_invalidate_start(). And
> the refresh() path which is already the fallback slow path which can slee=
p.

It's probably a slow path for all current users, but it definitely won't be=
 a slow
path for nested virtualization, because a refresh() will be required any ti=
me the
GPA changes, i.e. any time the vCPU runs a different vmc{b,c}12.  That's wh=
y I
think we should treat GPCs that are strictly bound to a vCPU differently.
