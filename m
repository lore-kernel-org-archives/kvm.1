Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29F19B5B1
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 00:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818403; cv=none; b=Jd8EJOIeHbYQSfIn6w3HuAmKvKOY8JmFjDOlpst29qNtxavmQLqhSv/vZQFu9f65nn/9OFYahF1mP+3Z12dgqZJYAmzeG/pA+1gQ52cBYVUs/XZQpO8ozwrwkviZGXSO3wWvX6cqm2ZzdX64GBj3qqqG3c4zb/xi4ATT8UgDX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818403; c=relaxed/simple;
	bh=J1tArWnulocLUn4+cJkKhjttTKFMjzmT1ngPpiM0o7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eENwteWjtXOpT8nZZuioNJaMgDxWZ5MYeQjdvwIf60E7JaVPN0eSi5SoBGlzAqFMzcUHvbb8kMvihQkn9kmzZuTJLyVZSTc2DxIfQU4MWfz8YnIrhOM+6Tj/Z4krlFRaDFRlFe/61MYgpXoaZydk0d4J1wapHq8mAs92vf5TDio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiWaKm3L; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiWaKm3L"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so2271974a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776818402; x=1777423202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=igF/cUsBIzKJTZC4XKIeh9By96551N+odSOFbiyoihs=;
        b=wiWaKm3LtymQQiCA6/uM3S/Nyw2XPAL+DM5O3NG8xzrT6/X3HNnJHAljwq3PXZ4Tid
         TnFKADBahozi/iY9OgwB93utPwiNDoo/33gdt/HHuYU7tVcJcgjnRz6mCz6NY39t++Zh
         kdB58E1LL2c0IXap3Nl/SBVQoDDZeZZKpcGmlgkOucFojcLAfEcu03DlJ7ZL++lRwMAS
         8+oUNWOJNc37BygQ5cWXS3j1ijFDlIGyC6ug5dfsHLIcPJB4tWXyyIyJPo94CxPmbylO
         sJyokRewaghyR60HURaLnZmfYG2huEMTVmcweDWWrENYP4R17Rd2TLCnn0QXo2z7x9Lm
         cJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776818402; x=1777423202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igF/cUsBIzKJTZC4XKIeh9By96551N+odSOFbiyoihs=;
        b=sL5HScD2Ps+COq/ENGvoCrEuYPr3zwch1iS2LHZ6MU3E9BxLJy27VTsdPbus+yY6+0
         QPiYuQCljcWPC543joCIr2p0/voDj/zfjxKdESogzckz2YYAEcjyVJfs8uuOccWSytU9
         32dowgx2OJjD+f5qKUn7HMq6jf29/Meh8KTBgG1QcZGyXhAx2SfzaoBi8IOUPByw6dlO
         DydnQVOWbUs6uwrIeIrRui0BSQW8U9+MZ8v/ea1lrexToVIZ682SGkHlszUe//CtguDE
         Xp75+FtDcpB7GGtkQvDl7Kfj0JZZyWp7b3YZ5gOd7NZSr+BwNRN7agyH35a/39WuRJmX
         RKbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BpsJcuNsCrnQJ98CflztASTC2PEXlfGvZtFlgkQpnZSdMcmaY2h4zKCpliYi+DUyksok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCD7J9qCGFLaqmfwYoaKDPoRD/HvnffB+1Qqkg/HjbniCeLPU
	ZHKuAfEb09fyN+DA1voQa/rJh52RZkznISlMY0NwTrn+XQHuqPLRcpE0yAj+UzGaDHjibzId/Z4
	s2sxPmA==
X-Received: from pfqf11.prod.google.com ([2002:aa7:9d8b:0:b0:82f:70a0:5bb1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:368c:b0:82c:e9cc:f61d
 with SMTP id d2e1a72fcca58-82f8c7ef3ebmr20336623b3a.9.1776818401572; Tue, 21
 Apr 2026 17:40:01 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:40:00 -0700
In-Reply-To: <aegIHrL1pqnRkhDh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-7-seanjc@google.com>
 <aegIHrL1pqnRkhDh@google.com>
Message-ID: <aegY4FF2n2t5B4pz@google.com>
Subject: Re: [PATCH 06/11] KVM: x86: Move kvm_<reg>_{read,write}() definitions
 to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Thu, Apr 09, 2026 at 04:56:17PM -0700, Sean Christopherson wrote:
> > Move the direct GPR accessors to x86.h so that they can use
> > is_64_bit_mode().
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/kvm_cache_regs.h | 34 ----------------------------------
> >  arch/x86/kvm/x86.h            | 34 ++++++++++++++++++++++++++++++++++
> 
> That's a shame, register accessors semantically fit in kvm_cache_regs.h,

Sort of.  I actually had the opposite reaction.  KVM very specifically doesn't
do available/dirty tracking for GPRs, in large part because it's not a caching
behavior per se: vcpu->arch.regs[] is _the_ source of truth for GPRs (modulo
RSP on Intel).

> but taking a step back.. is it even worth having kvm_cache_regs.h
> anymore?
> 
> At some point I needed to move guest mode helpers out of there too (as
> they should be):
> 
> https://lore.kernel.org/kvm/20260326031150.3774017-3-yosry@kernel.org/
> 
> With this patch and that one, we'd have <200 lines left. Is there a
> reason why it can't just be merged with x86.h? I don't see any of the
> headers included by x86.h including kvm_cache_regs.h.

What if we go in the opposite direction?  I didn't try moving e.g. is_64_bit_mode()
into kvm_cache_regs.h because that reaaaaaly stretches the meaning of "cache regs".

But if we rename kvm_cache_regs.h to something like kvm_regs.h, then I think we
can move more of the simpler accessors (and mutators?) into kvm_regs.h.  The
motivation would be to keep x86.h from becoming a chonker.  One of the regrets
with x86.c is that it became a dumping ground for everything that didn't have an
obvious home, and now it's sitting at nearly 15k LoC.

Naming is hard, but if we can come up with a kvm_blah.{h,c} pair, maybe we can
kill two birds with one stone?  Or at least kill one, and injure the other :-)
