Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89D4F799E
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469110; cv=none; b=pAsS8KYZX2c3gOnO0zXwKgtzLcVz0/Ue0is09g39TTEVV9bxiUi2CboXEN80W+07YZuVedtGfy+i2ADZE/ZKN+LXucQkVJYSOayF1VNEVWcYJbzEeqM7AYS7uNPqSGSaryizEWOzV8qFtE+LUYa5pLgA9u0FqRc2Edt9uqph004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469110; c=relaxed/simple;
	bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e87wSj/5EtNRsrz5++pya7eFjG7W1/Xx62Ehza+wotyFBozeFVG0mJWqTrQfB4XXcz6PgqFg2ntPUCXgui4zgcx+Fy6pwbD6UT6O6SFpnoc1bQ5v+roN+A8C+QVloU0MSy2/qx5/KXJkO6TMOGzQZ8AS18iEfMFabj1t+mr6wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he+U4lTE; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he+U4lTE"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6df0a1e18so4516295ad.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788469098; x=1789073898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
        b=he+U4lTEFW1nfhPoTjVFtT5mzyjVaVDpSH1VJvB+UwX/8JSFkxwuRAjgiw6uew91Dj
         pYFrL580qkDPzEgnexsG++7rXXPa2VD+0fqcicIsX6x5HERKVyiSlS++LwxNypErQyqc
         uTn2aaas583NiVIAKiLSAjvSFaFe/5/NR5bMGQrawz+L7jbTI3BQPbpYC+Gtx570CMus
         xt12f6ugC5mFhgj7ebZz5gGtHdmqbNgjPg42jHsqvFOwECgv+rNDAOBlFWLg/k/tI4km
         OEwjmtXgbK/yr3kfv6vWWpo+RLzDSoAb/15S/w0R7vMfvi1mCXLccSqjlXAr74erlYLE
         w5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469098; x=1789073898;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L632ql4Sd/RozUuu0s8fdwZF7MOouQPT9rB6yRaOm7Q=;
        b=pMjvnPLq7B1bHXZHLeaYW5w5ehGECgbG9xh93NpK3Y7ak3AdtCrc6h22LNY+bra9fS
         eWuAydrIu/xAF+5HjmsD5pcGF9EHmXseiMuGzYM1Xle63e3JowxDCBu+dBwe7Cn0BXoP
         ySMDtYWdCDakcNryyyI6PmBq3zok+skFZ6cgUIlxrbK5YiYT2ylXaC0tbReb2324a73n
         a5DRPNaPYkH8uEae/ZIVlW+U0vPepMk2pYeZINk4twxz8Va4+hsNd8EV66wE3NbBneiX
         88HGrcIFHkXPZQGuIsHTlC3Ju5Kk1D6AyA2pAs6GSp7/j608T9iJ0Ow4qpbA4NQXheMj
         nRNw==
X-Forwarded-Encrypted: i=1; AKwUvBzPBjCgB8XiDF0qlm905VXUidEqnG7UPY6QwBCgE+WDObIaifyKRHR2LbFg6cWqaBfCyu0=@vger.kernel.org
X-Gm-Message-State: AFuF++mrepCHTsD93MkCkAc/HR7nIhvpZvqCycgBCTN82N11PVPN0tgO
	15nTdfCkke8WEgmle9gFG4RhPlLEFBtf4IuBIdQ8TE7e0bLli4XOFnkSUUUJSntLndpzXVUh3SQ
	J//PpWw==
X-Received: from plxj7.prod.google.com ([2002:a17:902:da87:b0:2d9:1c43:7134])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:120d:b0:2d8:d4cc:be65
 with SMTP id d9443c01a7336-2db12873c1fmr17910145ad.18.1788469097697; Thu, 03
 Sep 2026 13:58:17 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:58:17 -0700
In-Reply-To: <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com> <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com> <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
 <apmYPMMPCNzK9ZEA@google.com> <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Message-ID: <apnfaeWZoZTIsoZS@google.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> On Thu, Sep 3, 2026 at 5:54=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > I don't want KVM to be the. one that does things differently *once mo=
re*.
> >
> > Too late :-D
> >
> > arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y :=3D -D__KVM_NVHE_HYPERVISOR=
__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
> > arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y :=3D -D__KVM_VHE_HYPERVISOR__
>=20
> Sure, VHE/nVHE is fair game because the nVHE case is in the same boat
> as vDSO, arch/*/boot, and so on.
>=20
> Looking at a grep for (cflags|CFLAGS).*\-D most are -DDEBUG,
> -DDISABLE_BRANCH_PROFILING, -DDEFAULT_SYMBOL_NAMESPACE, etc. and in
> most cases they seem like a bad idea. Don't do it for KVM please;
> requiring -D for all architectures and for random pieces of config,
> when you can put it in asm/kvm_host.h, is just as bad if not worse.

Boo, it's never fun when a parent shows up and takes away your toys :-D
