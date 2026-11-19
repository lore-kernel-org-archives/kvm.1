Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047945;
	b=jf9mdrkoZlG9Qer0qVarDt8MSzg1giuAOoL0Vode1/l9fLbzM101OgNrRLn97Pmoz+AR
	 AlIneZMCwrVUYbVqILq/0BXg8QPaekka7TeWOp05GyGoZsUf3peKxTc26cNHTkfmsJPFY
	 7t6csHBh3mLjX7KiATrjkZSv4BJumsPxNXnufidt4x+svcwd/QKxlrHemMg38J6vghsp7
	 9M0dFo4J3RUjlsWHs6CP9MGylWgkWjm4KhVlsB/AYAMSQpVQkBvw21hyN8Ij+xQU1sf5P
	 dTJKo7FI/bowRP+0CyjUGZEhIJo68KTyGzwHyIFP86zw3aIcKO65rADpvpr4jPzOCPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
	b=r2bkEqyPGKw+wvgAjjwb+ffjPEV2z2fODvHnpGdaY2xLcf4U9ST5ze6jC4HQL3vI8k1n
	 bL1Buygt3JBtO1Urzc3CZ6zDgTQQzdeK1zyoZBUm49fMUunh5t4v8CYgjSZcnibSl9PEk
	 zz84kywIBA4JDR/HMHxHSTVdzWOXfxuthKjppWUI9lXAL4OC99VqnS5Rxv+WDqXsj2Scd
	 EP+NAaE/dJKMzcuN4S2b8gs5Fb5KBo6EXiPLJpPfzfWRyhV5GTbr+U38byXgLAe1g8tJy
	 hNVHBIp0OHjyNfj/5v2bVJc6WZzbF+nFH6OwmgHTEFnTVZvuwwaTzTIYuC2oDdH7R8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VUzzRT1P;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E9606A32F
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 274E9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VUzzRT1P
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-567e742f481so1012598b6e.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795047944; x=1795652744; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
        b=VUzzRT1PmPN3kH/c5HD5qxg23YbKceVpVl7CPJfi+KdLeS+giLCoHmbo8TeKtLKScO
         4M+h/q27Mc1BJm+qXrZzLChZ7Jay16UY0fuOIPg0LSSY01/l6RPxGRyiO5Cf022TUr4f
         NqNygd6qVz76Q1ennc949Z/jfRVOM+uQc4kDStu6gb1KA1ibwjKEf5D6Xr9kxDP9hqM+
         84jm9VV38N9kQ5om6sreRHX4BiEQfYGGyUW8pxu/mj57il7NS2aTWOHjJo9YIv4yLiLi
         8ruKnViQKijKVdHUpz2Wp/g7k5CYbNIwKI93rKmrhMayqMFvwaNsAnxv9xRwBunbZQFZ
         aNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795047944; x=1795652744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yb3RT/dSHycHHUvHrQYfX0MzmZ7Zlc0xT6PVwRVG2IA=;
        b=GryARyo4W6GdkhAYFIVWBMrCp+znvhIzrtvRR2r26X7dxRvk+3cNC6KMpg3clcpw7o
         /8XxVsOE8IGE3hdSEfPV3z8iCEXmfGiTFvu7vQ2sR11xhXLrdU0BseGnAIMtUag/d0n6
         O1rRakBJdlnOZn2h7CVbHSIEXU4x+FNM9dk0rVQx+XLY5xPC+3fka45u07j3GyXPfqLy
         U/adHpBwTCQSHmaDkEmRSpGluVNtsBYVrOQbRiC9xxaHcSBifaxp0/lr+O2Iwd0FLlLO
         rUHBP7dUDrFyU92xmWWd5izd0ewMDQ5dktxWSzGeBkXIlHvz55vuO1OVFispGqS/yr3P
         pw2A==
X-Forwarded-Encrypted: i=1; AL+hErF9w0VycpZjg0JaQXU84SYTn/ZnCr40Y+Ey9L0I9saYeMIeWad/tifMfMMHR2b66aEy6kg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cXRhNnXJZsJ0GyM6qZTsutkWE2Eq12iZ0InTnnIlKrNsWIqCg
	FaUF3COXcPY+5dg8PznZ4c4jpm4Oc2kVkSYLxBt+dPvpb3fsCISUVF9J3vzzdeectmrEuWhbTvK
	iIH7K1A==
X-Received: from ioru16.prod.google.com ([2002:a5d:83d0:0:b0:9e2:9e82:a2e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:250c:b0:53a:8c5:d7de
 with SMTP id 5614622812f47-5773db2428bmr4568078b6e.1.1795047943693; Wed, 18
 Nov 2026 16:25:43 -0800 (PST)
Date: Wed, 18 Nov 2026 16:25:42 -0800
In-Reply-To: <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117074428.7544-1-fuad.tabba@linux.dev> <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin> <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
Message-ID: <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 17, 2026, Fuad Tabba wrote:
> > But the overflow bug only applies to x86 (see below), so is this something
> > we should worry about at all?
> 
> The ring overflows on arm64 too (below). As for exit_reason, I asked
> Sean about the arm64 MMIO case on v1, and his answer was that a VMM
> that pre-faults between a KVM_EXIT_MMIO return and the next KVM_RUN
> "gets to deal with the fallout" [1]. I think the same goes for riscv's
> exits.
> 
> [...]
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> [...]
> > >  The dirty ring can get full.  When it happens, the KVM_RUN of the
> > > -vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL.
> > > +vcpu will return with exit reason KVM_EXIT_DIRTY_RING_FULL, and
> > > +KVM_PRE_FAULT_MEMORY on the vcpu will process no more pages until the
> > > +ring has been harvested and reset.
> >
> > Maybe worth mentioning the exit_reason thing if we keep this arch-generic?
> 
> Sure, I'll document that userspace should complete a pending exit with
> KVM_RUN before it pre-faults on that vCPU.

If we're going to do a documentation update, I vote to keep it vague and scary,
otherwise readers might think the exception proves the rule.  I.e. if we say
that KVM_PRE_FAULT_MEMORY isn't supported, then userspace might think all other
ioctls are safe, which is most definitely not the case.  E.g. something like

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..45dc1e3c0b03 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6971,10 +6971,13 @@ to the byte array.

       The pending state of the operation is not preserved in state which is
       visible to userspace, thus userspace should ensure that the operation is
-      completed before performing a live migration.  Userspace can re-enter the
-      guest with an unmasked signal pending or with the immediate_exit field set
-      to complete pending operations without allowing any further instructions
-      to be executed.
+      completed before performing a live migration.  In general, userspace should
+      exercise extreme caution when invoking ioctls other than KVM_RUN prior to
+      completing the original operation.
+
+      Userspace can re-enter the guest with an unmasked signal pending or with
+      the immediate_exit field set to complete pending operations without
+      allowing any further instructions to be executed.

 ::
