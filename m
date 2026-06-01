Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4143DB305
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327083; cv=none; b=GvBRgxg1xjjVVu3CvqOT9L0sESkdFC1CVaNG/2c2AVya1/REqLbAcCg9sftX+Y7AjEkhKWtUGOzcL7DkzkRJtdbFAgV65ePAA5uIULDKk2ZE0cR1HsQ+35TghsKFVPkvv9pZCqtxU31DNOWrOcuFL9Fpu/CQjIjqjISv2Sq/Foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327083; c=relaxed/simple;
	bh=qt6jdTukQiCQTq9T+Y4Vz7LaPDtWdBuYDLgqfpjkrlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBKymQp5vWbfaJnx2STAXHNd1urT0yflnkf/mAG6K9L3A7aAdoccM8lx+yVp0FnLAQtSdgmljzTDCXL19WOcgXUGE9SBIh91Jiu+KQdQ3rumkSKGWDRhpMZp0e2p1ufYKsmro0zkcbyFw3RROwn6xt6stWjATm6lm4R3DtxO6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1238cLr; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1238cLr"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so18940445ad.2
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780327076; x=1780931876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahMbIkijP/BdXQhTZb9LZG5WCNYJS47pXidopl02Z6g=;
        b=I1238cLrhCkI9VJHolGVmGGJxyUvh7z1pEg1tmW/dRg7jjXhbYzbVS65N+cjvKTFzX
         5p8riIe8ojXeMJodnKMwK6cPV1c/02y658zrde4N1/3+k258La/Op8Hd4o5infjAgL/S
         o0D6nWdeVZqtHEQUMtNhkqQCOLnXNTD/9p7CdysIf7/Wakk5FQb9RMqbM8gwelqgGyY/
         eJ1ttLkqYHo9sSnzyouUIsEJALvDLQGyFE9Le5AUSMgxn2wcVYCO6sQKHs5ISStWzaGE
         6F9PDu78O2Au7HOy5Cooc0EoAdEFCtX0Y4BVNffoK5+GgMbmRCgOIwT78nuEsxGCLmCz
         10dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327076; x=1780931876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahMbIkijP/BdXQhTZb9LZG5WCNYJS47pXidopl02Z6g=;
        b=M7KVoOLMIzfIGiSZ7zFLAmRVL245GjWwFCd7pvvSAkqqYBPFsadW0HkgAGZjn9rjz/
         4venpiwusQoXVdmWa0u26mtFbd+gb6F2vIANeMNGPkDOo0HkRHxDPd2lpN2my7fjRd0o
         e9JOtUVPIlrAnmsTDETdsXIu75JfGJL4Kn21CY1848MgGpjf5E9FQg89lW6FA3x+WbHI
         wPIp+AoKaB5delZnnGA/krLXITTKqvbb4FYqtkoTIeRJoqvIefpczj1IudwLkKKPDNMO
         DsFIuUYASuQORgCHxdQMtPsQgka/hVq3Syv7pc9InqCZgTPP3kfaapYhpdfGHoZspBa0
         d6fg==
X-Forwarded-Encrypted: i=1; AFNElJ8Zi5MdWmrTZTQYJd49cl5uqwCvEtOa7A44AE4sLmk+D/ry4hx5nG9PTZA8bpu0F5aKaGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fQ13xvwa7+x+zVkbmqYquWY23Bnu1FniiIDxd2kNP1Rg1x+0
	NUAxmSrFTXsGlxAxXEJCFfwrROTSLmL234av42WePmhJlvYj7AyPuODkPpBc7FNdKMBJci/cHW8
	O1fa5Kw==
X-Received: from plth11.prod.google.com ([2002:a17:902:704b:b0:2b6:417:db8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cd:b0:2c0:ab82:6b99
 with SMTP id d9443c01a7336-2c0ab826c73mr105242275ad.33.1780327076177; Mon, 01
 Jun 2026 08:17:56 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:17:55 -0700
In-Reply-To: <aho2qWoPvqJV_5Db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-33-seanjc@google.com>
 <aho2qWoPvqJV_5Db@google.com>
Message-ID: <ah2ioxvvx1-Jgjup@google.com>
Subject: Re: [PATCH v3 32/40] KVM: x86: Move LLDT assembly wrappers into VMX
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 03:22:15PM -0700, Sean Christopherson wrote:
> > Move kvm_{load,read}_ldt() into vmx.c, as they are exclusively used by VMX
> > to save/restore host state, and have no business being globally visible.
> 
> But they are generic helpers. I agree with mvoing them out of
> kvm_host.h, but maybe into another header? 

No, absolutely not.  The fact that KVM has to manually save, and conditionally
restore, LDT is a quirk of the VMX architecture.  If it weren't for the fact that
VMX's segment_base() also needs to query the LDT, I would just open code the asm().

If it's a naming concern, I'll happily rename them to vmx_{load,store}_ldt().

Hmm, arch/x86/include/asm/desc.h provides {load,store}_ldt(), but load_ldt()
is only available for CONFIG_PARAVIRT_XXL=n builds, and both #define unnecessarily
constrain the output to memory.  Those are both fixable, e.g. load_ldt() isn't
used _anywhere_ AFAICT, so burying it under CONFIG_PARAVIRT_XXL=n is just some
weird historical quirk, and I can't show_fault_oops() would care store_ldt() were
allowed to store to a register.

So after the dust settles, it probably makes sense to improve desc.h's versions
and then use those in KVM.  But I don't want to do that in this series, because
it will be challenging enough to land all of this code movement without also
having to coordinate with the tip tree.
