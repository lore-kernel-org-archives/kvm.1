Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491B2FDC5E
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799265; cv=none; b=tqQQDTqgEHMgZ/e0CzbnEy4wktEslp0R4Aqc+I1//ELf3inOeAhXYA1rGW3jFN5rG/soAzA/Tp5/SGF0KBcl83S76uGkLS54wdWS0Ll308xA2ZyBc3N+aNtpexo1tdQ2XxzEYIvtFWBFGdCVUvQoY9SdaAsohQtG7pwUxX3dtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799265; c=relaxed/simple;
	bh=EFrGcqJsUwcALUYIxLLTT8/N8l54sYTR737fc/v/Y6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XYynmcCU1UPNG5/NNKcY5lwMExyTvKXNL6/VGVFpfNna+SQ53nw9qBNw0L+Af77vssg/ekPOAH9VebNnRow3PJDaGlOyAxfdd7Rba+Hh+uXi600BUsetMd8Fx8rpOzDsxSc5JOTXHOneaIWUM4vVlL78jM3TDiTRv9EgOv1PKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFQDVF3w; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFQDVF3w"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8620ee0971so1235183a12.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781799264; x=1782404064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=smkUU1whOoOuP9yEHYoqcF40OmkenmipHC1Q68vdtSI=;
        b=YFQDVF3wP/Z3j4dO9Z80pFubjqZ7SgI21494KJrmplypdMeZsAmJfdsh8XZXF5365M
         k3HKMRxp7Q9zv+IzLw3I5CB1svBUhmqpb+4nu2A4M+Bm0wpVPFk/a4HRFGt3hIl9deu9
         t8ybuTBQdjW18BIcx6ACSjslLYaaxGi7jLYNaNG3GgaDfHT5tktv9r5+YRM+OOytTUlA
         y4bShga/gGXaCohTL+P3zs+ByvJ0NbDi0ky287v8YzTRpqoZrFLJn81QB3vgPauBAM9H
         pj03EWvfGoEsBmRISjR1fiYwZtHCC+7/idAifBg/sUMcBsGC0NgpxUI49zZy7TADc4aW
         mEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781799264; x=1782404064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=smkUU1whOoOuP9yEHYoqcF40OmkenmipHC1Q68vdtSI=;
        b=A8hIPeRTmlgzqEHc6HzldKejTXsWhq3bqAEfh2bSZrEsh/ChXyBLpWXGnmiprNvcpM
         +RuHPFzNWqgF1xavkWklpSab40qvPu1VJVCIag7W2w+ULSXB5SIJ3c9hSRn5wQFOZOrK
         hgKsbb34jPCEjKGbUGKrTDxmini6nAO5Hd21brYoi08mx3iSSK2QecMN40iXgyrrtXwE
         /zJ+MmH8lf+farjApF6gYfTeYvI6ErwjQY1C00L5X3lsbIUMBx4BwP9CBFaRRayNA/wM
         Zcogh4DFXolu916L4XD70HIwKOyLXgxlHorIJURuJqRTQvH88txMo6gy3nhtUgn9Szor
         SN9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9cmWtt/xXvVoEcOc3a1VlGmioxYWVtJ5ZfYISBp6zOprGbVVtWK0Islbo7fNJocDRXE5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/9wXIBX/I2Si3j5NyjN+g5t9cRWUzjtEczLCX2vS8mLfP0JE
	ECh5R6LcbU8dNG/b+gkBi7b4Vp3O1qL9R1FClHa1eBPfwAyRWygGt+c6850efI9M+cwiAjdusvF
	Jh9aRdw==
X-Received: from pfbjt37.prod.google.com ([2002:a05:6a00:91e5:b0:842:6be9:dfb1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1745:b0:841:dca1:8b69
 with SMTP id d2e1a72fcca58-8453b082c51mr4980798b3a.5.1781799263628; Thu, 18
 Jun 2026 09:14:23 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:14:22 -0700
In-Reply-To: <tencent_4A39169A103432A565EEB007CCC88D920109@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_2A66410581309346060C5BDC8CD108053005@qq.com>
 <ag8RI8fX1w7jx4sA@google.com> <tencent_4A39169A103432A565EEB007CCC88D920109@qq.com>
Message-ID: <ajQZXiOEqUU8MAhQ@google.com>
Subject: Re: [PATCH] KVM: x86: Add tracepoint for vCPU wait/yield paths
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, zhanghao wrote:
> On Thu, May 21, 2026, Sean Christopherson wrote:
> > On Thu, May 21, 2026, zhanghao wrote:
> > > >From 0c8d4428390a1238a956f713c1ddced18eac83da Mon Sep 17 00:00:00 2001
> > > From: Hao Zhang <zhanghao1@kylinos.cn>
> > > Date: Thu, 21 May 2026 16:30:37 +0800
> > > 
> > > Add a KVM x86 tracepoint that reports when a vCPU reaches selected
> > > wait/yield handling paths in KVM.
> > 
> > Why?
> 
> The intent is not to add a scheduling policy hook, but to expose a single
> observability point for KVM paths that already have wait/yield semantics.
> 
> Today userspace can infer parts of this from lower-level tracepoints, but
> only by stitching together different sources:
> 
>   - PLE can be inferred from VMX/SVM exit reasons via kvm_exit.
>   - KVM_HC_SCHED_YIELD can be inferred from kvm_hypercall.
>   - Hyper-V and Xen yield/spin-wait paths have their own hypercall paths.
>   - HLT may not be visible as a userspace exit when KVM handles the halt
>     internally, e.g. with in-kernel LAPIC.
> 
> Those tracepoints are useful, but they expose lower-level mechanisms rather
> than the KVM-level point where the vCPU reaches an existing wait/yield
> handling path.  Consumers that want to correlate vCPU wait/yield behavior
> with host scheduling activity currently need to understand VMX vs. SVM exit
> encoding, native KVM hypercall arguments, Hyper-V/Xen hypercall semantics,
> and HLT handling differences.
> 
> This tracepoint is meant to provide that common KVM-level signal:
> 
>   - ple: KVM reached the PLE handling path
>   - hlt: KVM emulated a guest HLT
>   - pv_yield: KVM reached a paravirtual yield-style path
> 
> The tracepoint is informational only.  It does not change KVM scheduling
> behavior, directed-yield behavior, vCPU placement, or host scheduler state.
> The target field is also only the guest-supplied value when one exists; it
> does not imply that the target exists, is runnable, or that a directed yield
> succeeded.
> 
> So the reason for adding a new tracepoint is to avoid requiring userspace
> observability tools to reconstruct this higher-level wait/yield signal from
> several unrelated low-level tracepoints and architecture-specific details.

Tracepoints aren't ABI though, and "observability tools" suggest userspace wants
to build functionality on top of all of this.  If this is for debug purposes,
then tools like bpftrace are a much better option.
