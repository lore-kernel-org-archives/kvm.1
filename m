Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17A3D810F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975466; cv=none; b=fWbiPHNzyohQUXw/Cgb8S0UOeaS31QLRc9LXS8w9WOtjgCdc3MoYnSNMWKOjLVjCVju/Nr3diZujNPtfFg3n5qyfhel7QiyUmx7ppVkzK2zlHoi2H9sNky01BR2ts+lWnf+qIVOFt2gqtAdsVSpUiyxrp7B+3wXz2fem1wPVyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975466; c=relaxed/simple;
	bh=Up1o270UO0Wn8XfUkEOsM9FDLrESyUhRMGpDmkb0x1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpwyxG8QZ5Yp+tho6AxV+aHlJ9pQOUkGWREHExj1hs3ehk0TAhibpd7QgORwYBsFg9rxBLVH4JSvISlyj4ohGx3G2o9XJ3OgkT6CTghJkwwV6t0wyJ1UrHzfM5KbdcLT/PsU/5vWFKMC5VXd8LGX3xXI2i+iQeYIsP1xyXoqRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rIx9dGCI; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIx9dGCI"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so19964a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975462; x=1791580262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=we7ZuWdyXUKVmsiYMM805gi/tNVCEpvmuR9qYLitMR4=;
        b=rIx9dGCIsb+GytV/+0p0MGMvJ5TLsfaUCc74/uA1TX3R9n9Dfvi9DOIK+5gtbcJgwi
         cxLfqZ03uB2JepsukWmMpLSSZk1s5dj1rUcDl2jc3XpiiOQ/XpN+Z4G5qA9PjzNF3RcJ
         +SrfJwqQhqcvKT1uqUt1H1CZrnR8y/PXhijAOOsB+GWGuOBf6MDyXDBgmEkVQ4XJjACJ
         1YexwzHw87VgZPeqYnZXOQhs0642X1OaGrT4lkcfkbjMAQTl/0jdabKIExIwozwA4H5E
         f3WAqVK3kcdnaded/5IFqT4pEUBiFNs43ypCQt+48OUblvMJ8tx5ab+WXNGfAG0mn3ul
         CwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975462; x=1791580262;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=we7ZuWdyXUKVmsiYMM805gi/tNVCEpvmuR9qYLitMR4=;
        b=DXuZ4U058zkqhVaHQctKsS4UNvUiove0RbFXG+fcx/HAujxvZ8e6HyEoS9HUEhV83f
         zbDQYhFZ9fP60fsiJvXP5TPRBBrF32RRhnhFpF50GLwzkB0OKBEb8lo9MWYy7+EHWcC2
         y+76mrmlxYw8tS/n/Um5QANiu6gCJsvYWv3MhbHxQyG8bOKk0Frp9WwdjGiTtBqHscd0
         v9Up0XiE4rLhMvSp+n1JZ2Qc8X/N+xrO/jyiw5AUivkP7aOuiFSY0RNBP9uGk+Upf0nu
         0Ug3cich7OlTDHWfqrxMWCrH3ClJ3qpudx9qCJcUqz8R3P3EXayMzeI54D17EqyOzpa1
         QEHg==
X-Forwarded-Encrypted: i=1; AKwUvBzZxXsHsuw1Yqz+hMFIkw0hHnUSxGCRPNb64hstZYkvGhGAG/iyJcpPPMzY4ZSE7Ujgo/0=@vger.kernel.org
X-Gm-Message-State: AFuF++lo+k4CqtW+vKEk2qOEt/YXXDAGPv+mXs57A1QF+YJAKQUxiZ29
	mmkGEoE3VcTcbWjo/nRl68T1xgt7XMUgonugpUlVVIpMuNJgOoerdflBNdnDDs97v3QZ/VF0N4T
	/CagsEA==
X-Received: from pgbcp7.prod.google.com ([2002:a05:6a02:4007:b0:cc7:db17:7dd0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244b:b0:3bf:a543:e7f5
 with SMTP id adf61e73a8af0-3e0bc9af015mr3844191637.3.1790975461693; Fri, 02
 Oct 2026 14:11:01 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:26 -0700
In-Reply-To: <20260817234328.196560-1-yiranirenewang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817234328.196560-1-yiranirenewang@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097479132.4073373.18109305366120106986.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v4] x86: pci: Support unaligned register
 access in PCI config read/write
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Irene Wang <yiranirenewang@gmail.com>
Cc: Andrew Jones <andrew.jones@linux.dev>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 17 Aug 2026 23:43:28 +0000, Irene Wang wrote:
> Per the PCI Local Bus Specification (Section 3.2.2.3.2, "Configuration
> Mechanism #1"), port 0xCF8 (CONFIG_ADDRESS) requires a DWORD-aligned
> register offset (bits [1:0] = 00b), while byte and word offsets within
> the DWORD must be selected via data port 0xCFC + (reg & 3).
> 
> Previously, PCI_CONF1_ADDRESS did not clear bits [1:0], and 8-bit /
> 16-bit helpers always accessed base port 0xCFC directly. This worked
> in QEMU because its PCI host bridge emulation preserves unaligned bits
> in CONFIG_ADDRESS and uses them during CONFIG_DATA accesses. However,
> in strictly spec-compliant VMMs (and potentially real hardware), bits
> [1:0] of 0xCF8 are ignored, causing non-aligned reads/writes at port
> 0xCFC to erroneously target byte 0 of the DWORD. In practice, this
> causes pci_find_dev() to read the vendor ID twice instead of reading
> the vendor ID and device ID.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86: pci: Support unaligned register access in PCI config read/write
      https://github.com/kvm-x86/kvm-unit-tests/commit/4251fa0d3d0f

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
