Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41527FD51
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370193; cv=none; b=TEC4dZoJj7Efq0ultao5BzoDHr4n2/Fo95+03G+1KMGLDcY+ZhoAAcAsV7jKdmz9UAiKTMs1AYITpH/7ReqP/xVmx4ggxoTScdP1g0mQROm27F3LQEuSkSe2z/dEjn+DbYQo+MjP3g9qLwsmYeFlnw99Ps2ZTGjnXp06QQ6MMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370193; c=relaxed/simple;
	bh=T4h+0OngmiFLBNepEjU3d20+8UJV2w5wRPCm1XE6zT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eAttsJRHIbE/MgQ34y5fxWfD3dfZ/oIuB5t8Eidt9wa9KFeldjVhdCoe1lmvMA8RXcb8tYCK0j5RwQn2T6V5mg9BiM4qL+4Iq7Nri4oKyOyfHcG1oTVkblCzxhHNgIzjC8dquj3DiiUvJgL9x+MS4LirD1OqSTaHk9pMhBJuezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cc/T2yLT; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cc/T2yLT"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc88e22f92so49666225ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786370192; x=1786974992; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scUOSvWK83pq1cJ9Y23cB7+1ZF4+W+kSdr2X3LP0fns=;
        b=Cc/T2yLT/c07BtIK/l07CYzocsnCVLWmh0n4zfZHY7LgF/9R5h3EwEQEgb3cpVEXlT
         2rSB/Z5N9qMCtSzLqa0hb7Pcxs0BkiqsuGaCm3tjSf3vqDCD1qqVbQT4J5bpPEJeIprt
         nZQzkvn/+iE7w2qdrkZpY3zC82Z9ZW6sNhSAyZiT9GcJeQNzd0LtHTSh7gs292np+mvf
         pXBwiejtChxZ9lqPkJ1biXdh2qAMhRCF6TK7hvSo/uIBBohtljaRx4WLbo9ZEOf4xO5n
         tFjXzot8m4vOjZ7b0crM6qZ1qyo2QIWbQtfm0vlG4EvWTGPSCKcrlLiQ/fyatbyo3gGq
         NAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370192; x=1786974992;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=scUOSvWK83pq1cJ9Y23cB7+1ZF4+W+kSdr2X3LP0fns=;
        b=TM52M6U8tBp1LChDH//UZluWG9YSCVDcVGb/ChuLSUATmLvVmCu+p307C7DfUK597/
         cOzlrEcvkcX6LwOCbe8h/j/oy/Mol/n+BTNipWRW3CDbnj/dQbKUzu79wPv5hF0riQpY
         RrV7nsAW1+l49EL1UhuL/Jiq+IzotLDvO/FbKyAeEDzgp9JPCjXekYXyhI6LqrUKD1wc
         ScYHIrLPUT5s8nQr8SOiWKC6o/RVmNiNicNoqmtLGvydB5dOoi6ANqAGl8o4+rTZBoLn
         9Ih8PfjNtA9Nw1BNY9MYTG6z/9XhFfbudMzjjQReke+qOKRaEiFeLBS9pv2vn8CQNewp
         KEmA==
X-Forwarded-Encrypted: i=1; AHgh+RquidDKMPqbJVNYhFOuGakCmzdUpZL8kd+NKVTrtHqAyicYl/gUT0jj/45VMWYhdsUwf10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5tXg5PuA3GcCI5Ghd8mFhohTs9srSRDrwAkj3pAIKVbl4BGQ
	d2SgFa7M0eO7UNCgl5wXh1D2kdX8QwNOrk/SPruI5Dq2T7QLkBouqEmSlgLNH2Vo8UAHOIz2IVH
	OGJVR9g==
X-Received: from plml3.prod.google.com ([2002:a17:903:1843:b0:2cc:7ef7:ea41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:13c7:b0:2ce:9c48:22d3
 with SMTP id d9443c01a7336-2d30033718fmr21913835ad.11.1786370191619; Mon, 10
 Aug 2026 06:56:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:56:31 -0700
In-Reply-To: <d0ee3cf97854b904323db3799e05117d065a6ba0.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-14-seanjc@google.com> <d0ee3cf97854b904323db3799e05117d065a6ba0.camel@infradead.org>
Message-ID: <annYj0zj68hH8zIu@google.com>
Subject: Re: [PATCH v6 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kas@kernel.org, rick.p.edgecombe@intel.com, pbonzini@redhat.com, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, jan.kiszka@siemens.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	jgross@suse.com, daniel.lezcano@kernel.org, tglx@kernel.org, 
	jstultz@google.com, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, David Woodhouse wrote:
> On Thu, 2026-08-06 at 16:35 -0700, Sean Christopherson wrote:
> > Mark the TSC frequency as known when using ACRN's PV CPUID information.
> > Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
> > the TSC freq is explicitly provided by the hypervisor.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Huh... does this literally get reverted completely in the very *next*
> patch in the series? Kind of weird, but I guess in some ways it makes
> sense...

The literal code gets reverted, but the functional change does not.  Before this
change, ACRN is the only guest-side PV code that doesn't set X86_FEATURE_TSC_KNOWN_FREQ
when the hypervisor provides the exact frequency.  I.e. this patch allows for
making the "No functional change intended" claim in the next patch.
