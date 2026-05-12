Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069530DEB8
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623973; cv=none; b=aXj+phvpIoUkBJ41oKNmS35zs4d/eylQFEkO8qCuMnqSTAB/9QkRqjCu6w5BfVbnfaWJpRM8CCzEUUqHMpMWjxNeXEsfnfCcMuMhMKtRaJfL1XUNx8UTfw0rTT1t8NG/OHKQ7ed/ls4jO3zZVLIJhf5vSw0GpreWawI3nAF9qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623973; c=relaxed/simple;
	bh=VodWq1ohvW3HDzDgj03PGukS6L7umyh5sWiqIAuctTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hmdOMeR8GmmPWRSrJ9+0IK2UyWIBNLLxpCiWtJpatlya7f0fliPsLK5Onw0mI9h67F3Hk449uIijAx1/f7DwqmBml3xZF5Okv0SPppsLGk4UsbPsrqNFEreJIRWhFRwhjAL8EWj3tymjQZDhvcc+7a7EHRfgeKVzj8Zpk3FDoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DGxt4nQz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGxt4nQz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so3808341b3a.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778623971; x=1779228771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7Z3Lb6Mfhzm1Jnkv/E7DtrQ+HizMnAQU2VqwmCZXis=;
        b=DGxt4nQzkrz68AJ/TpcKwxiPWAIt8jz8Jk9ih8/Pg/G3JD0S1xyrgcIu+XNr6DGzdF
         9HbRLaO9tSzNNsrO3vWCEA2q1VUx9+mtxz5zLEWaBxKvXMD/4Nvghp09xOOTzTo6cH52
         6jW+4YkLEWF52ZiVrNf1FgRGAfSyjb63dg58x6xxD/zL59GdiMoXfPgdzD6/lDPj7s7v
         Kz//V+m4EOxxrk2wgvjT0qBl9jhDmYThiQ3JuekQ7ZYziC9IlJskQQ6SQr4rX1tyLThf
         YJGaL9Ppggl3A3JHBuXkBpJ9nXI+N5bQ6XfyfWnrpuC9nEyeftERNdGRSPfvaBOFLylx
         QsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778623971; x=1779228771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7Z3Lb6Mfhzm1Jnkv/E7DtrQ+HizMnAQU2VqwmCZXis=;
        b=aP5QXNbpnYV+Hj0OXC1GzR7w9p9CCxKaG69nBAZJ0gwsdZxonSAamsCfnWC5QyyI3G
         YmCuaWn+YPJa2MuReW4GEcOTAjXb3q6k8K36O7iH80GTh9Q+06ZvviQ4+Gbty8tsv7K6
         aswlvJrQ91zzJ8EMNcq+/PLZoruYvsx1dnlKPyGoZ3gw0DBnfscN0phQhivtwrXbY83V
         cmzW0QrGh5SW7AjvcZRaaynnWDIRF2wnxVx7csyZNVgUvefwHwnNaB1MOKKkzK1Ynr8E
         mUb/G4VcD0/v5NnRTeSazrQu66w/E7RFURzloTFf0EFatcZYoiOB9VhN3wI4KFlWGg0p
         Xipw==
X-Gm-Message-State: AOJu0Yx1MkGwK7ChAZtqTqqVcD7l4/sTM2aSjaUmbsE+MgBtdxoyALG6
	93vy1xZq0kF1FPVYrXetlMd/i1HR4r9/09MOM+oD9ah6gZTbjQjx7EtLvXf9dGLVMBKYnpBJT9t
	lnvibdw==
X-Received: from pfbkq4.prod.google.com ([2002:a05:6a00:4b04:b0:839:4a33:c35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:414c:b0:83e:b443:965e
 with SMTP id d2e1a72fcca58-83f03e949d5mr516745b3a.3.1778623971102; Tue, 12
 May 2026 15:12:51 -0700 (PDT)
Date: Tue, 12 May 2026 15:12:50 -0700
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420154720.29012-1-itazur@amazon.com>
Message-ID: <agOl4nYSFn49saRo@google.com>
Subject: Re: [RFC PATCH v4 0/7] KVM: pfncache: Add guest_memfd support to pfncache
From: Sean Christopherson <seanjc@google.com>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 20, 2026, Takahiro Itazuri wrote:
> [ based on 6.18 with [1] ]
> 
> This patch series adds guest_memfd support to gfn_to_pfn_cache (a.k.a.
> pfncache).  (This is still labelled RFC since its dependency [1] has not
> yet been merged.)
> 
> === Problem Statement ===
> 
> pfncache does not work with guest_memfd.  pfncaches resolve PFNs via
> hva_to_pfn(), which requires a userspace mapping and relies on GUP.
> This does not work for guest_memfd in the following two ways:
> 
>   * guest_memfd created without MMAP flag does not have a userspace
>     mapping due to the nature of private memory.

Sorry, but NAK.  At least until we have a *very* clear and generally agreed-upon
plan for how KVM is going to handle accessing guest memory NO_DIRECT_MAP (my brain
finally caught up to what this series wants to do).

Simply allowing gpcs to tap directly into guest_memfd doesn't allow KVM x86 to
use guest_memfd for non-CoCo VMs.  There might be a special class of VMs that can
squeak by, but any VM that finds itself in __kvm_{read,write}_guest_page() or in
FNAME(walk_addr_generic) needs to have guest memory mapped into host userspace.
Predicting what memory a "normal" VM will use for TDP or the source/destination
of emulated MMIO is simply not feasible.

At that point, the "guest_memfd created without MMAP flag" use case is meaningless,
because creating such a guest_memfd instance is *only* useful for backing PRIVATE
memory, which KVM obviously shouldn't be mapping.

This topic was discussed heavily at LPC 2024 (and/or LPC 2023?), and the consensus
was that mapping guest_memfd into host userspace is the least awful choice, the
only complete alternative being a *massive* rework of KVM x86 internals (other
architectures don't suffer as much due to limited emulation).

>   KVM: Rename invalidate_begin to invalidate_start for consistencyo

I'll grab this one for 7.2.

>   KVM: pfncache: Rename invalidate_start() helper
>   KVM: pfncache: Invalidate on gmem invalidation and memattr updates
>   KVM: selftests: Test pfncache with gmem-backed memory
>   KVM: selftests: Test pfncache invalidation for gmem-backed memory
