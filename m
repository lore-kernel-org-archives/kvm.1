Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210080;
	b=TCUJc0YxNs+G4+D1H2mb8WZc7mSIcZfYrnEj43/DxZd00t73RMwqcivhGlGsCp/y95UM
	 YfdckwTQ4RP5Zh1U8ggmjDETlxnRwRzQksoqr3sQUHQD5dEUaVWC6HMVNY+zIU4J+cWN+
	 rSthPM3xlznrUOinQHRL5xBEgP664u7akPMuyQbAEFML0Q/JRwwkDHLqGCU6HcmjZwk7D
	 WLrlZZK3UzEJuC5kgtvEX8KpKpFLUapLMWRAFRcsYfX0c2aEsO+VSmydXKLLssqgCY7YQ
	 vH4BLraPgl1OxV0PeWkw3+5Axy+SN9wYlalgRGuahT84leucLWYRiIX/C9dCai6ZG5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3/KauWaXYG3OmrhCNO3AADgebVTxE9yJqLBY2sG9Sb0=;
	b=V+/yDYhlHhgPV8fqfIJtDN5T2ltp8UDZ9s6nxiKhbeWevSW+bMThsdyHLEvdAHXqz3WD
	 vObZIz3OvBhoGjbf5anDIbGeH2qwvYwnk8aloU2tOpJ0hTFKrY85hSV6Q8a7yIx9N+DkT
	 ZttA+UGA8NVgfrcr+m4V0Mn+s4b5xHrjzxqU7CXAetX2ylvB9afGYwBU0Q89AKknjhdgQ
	 fxD0GLunf8FNPEG6zRAXkxWTNV3y2A7axTOPhhimX87uEtJaTxjufGyGWyz88QXIegLOB
	 tWBd263qhbRqssCsWnSnQz5Lh7lLZgcJDTa3/k7hjTfuAayasTmD9Sf9/gHxE4D/m5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m4cYYQcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11084606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 07:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11084606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m4cYYQcL
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so2895e87.0
        for <kvm@vger.kernel.org>; Sun, 08 Nov 2026 23:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210078; cv=none;
        d=google.com; s=arc-20260327;
        b=m/iuL/5xVBwasQ4RiCyMx0BJl57796OrLbJQYpWb8j9aqSuVVNW0zu/SQOP4SlaZFM
         ccmU/O5vpxxdwAFzkeaLGuU5drG4aR094SKXHoTeryofalGGS3L9WjNEaJGx9z9HcBIH
         veTtzWM4wTazDyYsekT+mIF9Md/20a4c6AomYJT2228dhIpqNZ4ZktJJBrv6V26irWig
         /jwkW3utBeK5G21mv5pUuDXvdTkZre8l3ocVaE7TUT21uwR0vIA3k9HH6uYAcQO1bvoi
         sd5hiki8A6mKs6oLo9GzBz+FOUAkfCJxTkiO1X84D/urEQH2UokfuXCY9Cln7Mw7v/nI
         9v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3/KauWaXYG3OmrhCNO3AADgebVTxE9yJqLBY2sG9Sb0=;
        fh=Vv2aEUQS8bHabk7InrCjHwMVi2HjVRz+W5bgkr7wYAE=;
        b=fM44mQT2pFKdm137/bDRq+Q4r1JWExBvBoGfuiSOs+wF+9mOAJC1+vtF4UbGqPpR2O
         J/3jl+9yXD2Gd7K/0sxTQV3URwkhWjlOsb2kUi98kHm1Nrudr/zGjvCpUGTFqDspX3wM
         xKNZTjpTUXPVoO402BA0cCCV3A2inedXfcSzWF/IiqyVChzIOBj9BhJInnzI6Vl1VXau
         WVcYLuldNn4jOr7CdozoEnS5xRWWswt/i9COXPsdme83H8aVJEGB8Fb8KniCJYyVYKw7
         uymPZrCg92CBB1X5d71qE1GYh58Lboya66SDgzRvLjEnVA1EdpArjjYqqUCa79ojYjM5
         CQOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794210078; x=1794814878; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/KauWaXYG3OmrhCNO3AADgebVTxE9yJqLBY2sG9Sb0=;
        b=m4cYYQcLOjDJNyLJBbj2eiWNCZgHWEYIjNWb5gxgks/V7UnS0mFtgDe+y8VrBj6HHj
         O+wdwjFOPj8yVBMIKhWFUPWAj7f0zaVxCl522Ku0Xo6BXm4mLVZLzwKfzoALGzis5Hea
         E01GsqmmaiAIffPd9GvMnzslyzkSTuUQb0fySKAjPwrHP1QXC8A4DyQ4nk9/2Si32oUd
         6NM92zzswF4yN9nmShRGmKNU1MVeUtumJsAf5ZnU8vYEhHdh+OIC8byiAcU7f2e/T+SH
         7x+u7qq6p5RH7JKpPnhfa0Y8tOFeUhscGnk7dDZI4l0ZveS8tYFBn3ffvs3MoSb6rI2k
         XRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210078; x=1794814878;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/KauWaXYG3OmrhCNO3AADgebVTxE9yJqLBY2sG9Sb0=;
        b=fOJsxj79ovWbfFUh2ALcjQ/JpMQDZyHb2Ua4KoVfiQ5+p0SSTrdvk8KLmbDgcVY3Gv
         gMPJl4Lr7aLvtOuXGbdLI81rWyGitCx5n3Ifk6DNzGKE4tL9F+wAC8ok9tD6EiNd35Do
         4vBdOG3M2e7yD77rv1un9g8UM66Q0Cp0wK7eEDPtr60g3yB+5OhsC0iEnu8pmGPpNhr9
         hRNt54KtXQunmjZD2U0alkHOdAzXhfzxOWjDpiM1J0/ohbYHdEqG/fxLb/DAf6kUtvrQ
         2Qnfro1c0iz9rq64K0QVNLK6md6qSmLVHGeo5rJHaJ3p0U2c40r/oxhWE8RAQWsspUP8
         62FQ==
X-Forwarded-Encrypted: i=1; AL+hErE5yBdgj344fEWUqySx2bx1KYwOP6bL1qdXAEl2ChN5LKVxdUuQy8tX9ZF9O6/Qvj8o66g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zPwPclTpVbQOwmOXShQ7FvoGPUy9jY614U2nac0DRZ1ACl+oW
	3GOBAyeMG0tviW6ExSKXVVKA7qZCWiMiB9EQaMCoe72evucbcuCXn5CcEqyx4h9k+UlvWvo+Suj
	SbjgVQXeX099sqahZWE+FkG7NxUR0JGJjcT3ax8V+
X-Gm-Gg: AYBFou0zIudOwxYol6oXvmBS5zLYWRaP15nuu/XbYvfYf21xL2QalnPEeEpzhdeoMpn
	Ua6wKR6Tk2bkb3B/Y4yVqNSvmBMibdhyQBBH73Xu447IKIPWIYGeEmaMgrqAhhlQcw1kVxfka9F
	BTclDhwExATEgccHPkalIukmmrbWpk4cWOj09A8AvyeVXzN67O9sZO46Vh6iwm6t8F4z+hfZSVN
	Ewa8aDQN5pdYjNBk+7oKzCjYqTzRle3hPMNhePEG2uFqpdqiFL7hI4ES1N8UfuqzOmicW7g+bx5
	HXXAHuTwyBdVRDIt/TwAGeYryfH2LW4/od2JDEu9m2ZDcAeZfhVI21ZxowWtCO+dInd+/l9HKcS
	RcBOp5XjoG5+ekoRTa3iMi2X8o9c6eJbxmHn+RgOisi+KxAYk0IIWxDNITC17CDjf3o+t0rarxU
	8m4N3RCjLaWRvooj57/kHKolO3qQ==
X-Received: by 2002:ac2:4bcb:0:b0:5c1:53b5:2029 with SMTP id
 2adb3069b0e04-5c153b5217fmr3411e87.15.1794210077813; Sun, 08 Nov 2026
 23:41:17 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102141304.126883-1-steven.price@arm.com> <20261102141304.126883-11-steven.price@arm.com>
 <fa0ee5a1-4c49-4c1f-bfbb-c270dc4b6301@arm.com>
In-Reply-To: <fa0ee5a1-4c49-4c1f-bfbb-c270dc4b6301@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 9 Nov 2026 07:40:41 +0000
X-Gm-Features: AclHuK87iuKTvXEWJaczVerdWgxPEZxpPBN7O-wc8AIa5Wl9vz0b6-1H_UF4Qbg
Message-ID: <CA+EHjTy970AWnhYoZ5OqxQ8ojCAELeejw60y2NmpDsM_ZMdu4Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] KVM: arm64: CCA: Support runtime faulting of memory
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki, Steve,

On Thu, 05 Nov 2026 17:30:16 +0000, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
[...]
> > @@ -1816,13 +1828,28 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd,
> >         /* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
> >         smp_rmb();
> >
> > +        if (kvm_vm_is_realm(kvm)) {
> > +                is_realm_private = kvm_realm_is_private_address(&kvm->arch.realm,
> > +                                                                s2fd->fault_ipa);
> > +
> > +                if (is_realm_private != kvm_gmem_is_private_gfn(kvm, canonical_gfn)) {
[...]
> I am wondering there is a way to make it a bit more generic. The issue
> is, only Realm has private memory with guest_memfd for now. Don't know
> the pKVM plans for it.

The plan is for protected pKVM VMs to be backed by guest_memfd too,
which would also hold each page's private/shared state [1]. So
kvm_arch_has_private_mem() will be true for them, and this comparison
applies as is. Only how the expected state is computed differs: for a
pVM it comes from the per-page share state rather than an IPA bit.

Steve, could you gate the guest_memfd checks on
kvm_arch_has_private_mem(kvm) rather than kvm_vm_is_realm(), this one
and the memslot check you proposed for 02/11? Only the
kvm_realm_is_private_address() and realm_map_ipa() calls are
realm-specific, and they could be VM_REALM cases of a switch on
vm_flavor, as Marc asked for on the v21 memslot check [2]. The macro
would then only widen to protected VMs when pKVM's guest_memfd support
lands.

Cheers,
/fuad

[1] https://lore.kernel.org/all/CA+EHjTz+WgXEW5RTxXf4oGeEb1Tsm5Ha4nOc4S1jBcp7jxP4+A@mail.gmail.com/
[2] https://lore.kernel.org/all/86mrsw2jrn.wl-maz@kernel.org/
