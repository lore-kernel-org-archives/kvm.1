Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B578350A0F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078386; cv=pass; b=ldR+mNthiKaygNeDHacs9mEVL+MDwpOxsFAZ0mz1BMEToHY7b/NhTEvg5RDusV4KDEmvtgXTP8EP1XXIxBCw96Di/sXePEv8K4uaMZzyc6TuIaM8FwqGvaqQpWw0uvvsGSHjL0rMeLI0wowZIEctM9mourUW7cV6+6GRr2F3c9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078386; c=relaxed/simple;
	bh=sodDgfsT1RVJb+qM64kkX30lYVIYeaiSqv7IloOimi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDf383VVQFTvTGhMQ9mD4qQIpiebuKwAt1013rjK29iLVWc+NIyNN818ywfut/rGUdBz4UCzTtMj0+rI+Vy4AHK2Ff7/SLGEkBklXmIjnwtad7vaZyH75bt1EnDWMYXQXHdtw68CAndKsMEJANSQImun1zbHbkNU8I2dGZh9VcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/S9cZnx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=thfPnsH3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/S9cZnx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="thfPnsH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776078384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPSetIpbfE3df1PFZk3nWltj4hEeCZg0mILEIr/LUxY=;
	b=K/S9cZnx4wz0+Mt5zk6zxugrma+08KK865C8hAidez/GVNpi1pLFrRbtuMh5G/qIMJprie
	Xp/yLsPT5rJ3hEvoBVXqGR31/6el5zpS5jxqzI8kyZkm8eGHe3TpFzalKIYF8fnOkH+zgG
	pNSZ6kjyVijo5Zs7EPCXIr0YSXrMwCQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-wwlRHbXXNfKHETgrrdaISw-1; Mon, 13 Apr 2026 07:06:23 -0400
X-MC-Unique: wwlRHbXXNfKHETgrrdaISw-1
X-Mimecast-MFC-AGG-ID: wwlRHbXXNfKHETgrrdaISw_1776078382
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d70c27214so1008665f8f.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776078382; cv=none;
        d=google.com; s=arc-20240605;
        b=cr7ht7HUJDp0AvpaD4KphpO8p5yaRVwg55nuz4HZFroLsBSppIy4Masvcz0QfwDioX
         IDR9zGHgbd0q4aSVlYUvvpDNjLSU9/3EQX7IAXARhqqwOTDwCiqJCJ8xctocz1cF5zCW
         OOWGf1joDBQDy1wp0/IskLiZGI95UZixy222d6UWe1fgq3bvWK3SlrAo/5wzFmi4fBCQ
         4LqEKuqMJgzF2flMx8QtZU5O0JmvRSjTBDX1iiPc5CPOu035Hr1+A3/dppoGyOGEr5Wy
         079+eELsDn1iOkFpxMiSt8H87y3pt9TZN2RP8kXIZu35TGtM2KinHIXO6NNZY7U9Uely
         AFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPSetIpbfE3df1PFZk3nWltj4hEeCZg0mILEIr/LUxY=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=ZFrOyM0UkbuA31WE8M3VBTIK4kyRsVXOtSfDeelsIbRBjEVLzK4jPVFdWX1sbTa4lE
         CuVx6wlXvOTk1lf7CaBHL5bPoHBJn+6egT32cINMehdNfE0DvK/LReOg1hHH7rTr6Y/e
         /SUUr0sZdYN+bqjFL7pUsUunE3iCbN5Ff0EPAYG3mpcDGiJH7nU4p4BpYPozcY2AW92C
         dH18wV0kGM4/67H4NUXzcho8BQZllzaiDSIf55j3wJR8MXezii1LHW+qx3z0hGdpG9Fc
         zKKFK0bF+ih4sWpL5r0iijt6HEQnuucspZzQeM+Zk/bIATUHwB8kUX81GrXcxK/J7tqc
         uoog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776078382; x=1776683182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPSetIpbfE3df1PFZk3nWltj4hEeCZg0mILEIr/LUxY=;
        b=thfPnsH3BezqjeweohZlcYteCnJwR2vaelOz5fK8OcDtT/c+dIDFXmAuZckuV3qr1J
         coaYVQDMptUk4YnojJap6JrJgfllkXEhDUkSb/U4K8sn3QTpLDkBbfz3wkRffh3LX44r
         rCb+vKIicO7wKonRF7uTCyptybuNypXRY2fZ4KfMC/WWY9Cv4xcvVAW1mY6EeLRmjPRd
         El5U/I4Q2Pz36n1KGMdoqL7F5B8CafeQmvxgnAb1fW2Qv644kWEQXILWewRTLGypXjWI
         mcWLmkUKDZ67U9gLaHD1rQNpQMv/Gps/pCLXoQYUm/n+GEemvFkJWgp27mh1aPwxYrXL
         y+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078382; x=1776683182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPSetIpbfE3df1PFZk3nWltj4hEeCZg0mILEIr/LUxY=;
        b=doZPapG7xHaSPBwDxb1AjLOgPjKMX+G29Ijg1EvjQ2jJEZ171pBPPeBd3mFKBVxP1d
         5KHRatpNNXui/cirAlUOdk+jFn82tGEvSOWpesqrfodpInP9jnc2DIG0Qs3wQtqwMiez
         QSs7OLDCMROro5qJGapBIGQjcNj8lQPboSGmEz53N10pH/Wv6jNknA7aEb8TpCuu+hnj
         /4zXbDCPdYJulQPhE5syPMH/B31kmfeCL/LFc5cS4sQLK8V7rZp0jiRKSSUkJzTIGXI+
         EkAH9a1/eowmBUCEF5eKjOfJPlcRFc6otf14jSUyc2gSHb/Z8ivCY1geVqtLYfcDMF1N
         cV6A==
X-Gm-Message-State: AOJu0YwnUIITiJKxtcjx6Uha4MdmCQL+AwYkUaWoOBSRn8n9QXijUgSn
	iKzbEhPEVJBtJOyQUFXtRCMOREuPShN8iGEf8L6EpGkWn+a+7U8WKb5XX12mDfJBJM5ZtDNOL8T
	OXPGdLXJxF7dxT3WmRGMhHjA00/8daIdzz+E2vwlzsQpPh4t4uPsVKmP6S/mkVM+UQrEg3egWlG
	86HgOUugt/d3MZKELGretNr0/1DQIX
X-Gm-Gg: AeBDiesXnv97TorGsG5olVZ6CqTbkA6rngHQ/mzw+f9ox+v4vTbl7MOpWM8JSzWXZpW
	6S+1kWNEUjtFArprO3cRvJXaY3/cT0SFKXtdwQ9BsM2z9Zx4oC29a7GaLGkkP9l/ddbbIStFtul
	lrCgB8c3q0fn+Wq9O+tBQw82KTjSUOkvpciMAuLZMQPKLdxre2js2ZgjqBjHGzZXefSGtoaI1gp
	yQZuZMjP92rGc6VZ25wOKr0HqVnZP05IobDoL9ukbhVuDd1DZ7DmitlnmwKwVcEBLW2W4WBbIPZ
	uEaM
X-Received: by 2002:a05:6000:2411:b0:43b:8858:1146 with SMTP id ffacd0b85a97d-43d642c1adfmr18867643f8f.41.1776078382149;
        Mon, 13 Apr 2026 04:06:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2411:b0:43b:8858:1146 with SMTP id
 ffacd0b85a97d-43d642c1adfmr18867583f8f.41.1776078381607; Mon, 13 Apr 2026
 04:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-12-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-12-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 13:06:09 +0200
X-Gm-Features: AQROBzAMyuu8hBZzrW3Wyy58Bp9Cd29vlup1EDq0nBQqiHmEw9foDW3xNZJopys
Message-ID: <CABgObfZNgSL3YUj=t4=f-=kSbQEk_VWx93_mmTfOqprDFF_XCg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: VMXON and EFER.SVME extraction for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:59=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Move _only_ VMXON+VMXOFF and EFER.SVME toggling out of KVM (versus all of=
 VMX
> and SVM enabling) out of KVM and into the core kernel so that non-KVM TDX
> enabling, e.g. for trusted I/O, can make SEAMCALLs without needing to ens=
ure
> KVM is fully loaded.
>
> TDX isn't a hypervisor, and isn't trying to be a hypervisor. Specifically=
, TDX

I changed TDX to TIO in this sentence. TDX is definitely trying to be
a hypervisor :) but non-KVM users in Linux don't use it as one.

Paolo

> should _never_ have it's own VMCSes (that are visible to the host; the
> TDX-Module has it's own VMCSes to do SEAMCALL/SEAMRET), and so there is s=
imply
> no reason to move that functionality out of KVM.
>
> With that out of the way, dealing with VMXON/VMXOFF and EFER.SVME is a fa=
irly
> simple refcounting game.
>
> ----------------------------------------------------------------
> Chao Gao (1):
>       x86/virt/tdx: KVM: Consolidate TDX CPU hotplug handling
>
> Sean Christopherson (16):
>       KVM: x86: Move kvm_rebooting to x86
>       KVM: VMX: Move architectural "vmcs" and "vmcs_hdr" structures to pu=
blic vmx.h
>       KVM: x86: Move "kvm_rebooting" to kernel as "virt_rebooting"
>       KVM: VMX: Unconditionally allocate root VMCSes during boot CPU brin=
gup
>       x86/virt: Force-clear X86_FEATURE_VMX if configuring root VMCS fail=
s
>       KVM: VMX: Move core VMXON enablement to kernel
>       KVM: SVM: Move core EFER.SVME enablement to kernel
>       KVM: x86: Move bulk of emergency virtualizaton logic to virt subsys=
tem
>       x86/virt: Add refcounting of VMX/SVM usage to support multiple in-k=
ernel users
>       x86/virt/tdx: Drop the outdated requirement that TDX be enabled in =
IRQ context
>       KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys =
init
>       x86/virt/tdx: Tag a pile of functions as __init, and globals as __r=
o_after_init
>       x86/virt/tdx: Use ida_is_empty() to detect if any TDs may be runnin=
g
>       KVM: Bury kvm_{en,dis}able_virtualization() in kvm_main.c once more
>       KVM: TDX: Fold tdx_bringup() into tdx_hardware_setup()
>       x86/virt: Treat SVM as unsupported when running as an SEV+ guest
>
>  Documentation/arch/x86/tdx.rst              |  36 +--
>  arch/x86/events/intel/pt.c                  |   1 -
>  arch/x86/include/asm/kvm_host.h             |   3 +-
>  arch/x86/include/asm/reboot.h               |  11 -
>  arch/x86/include/asm/tdx.h                  |   4 -
>  arch/x86/include/asm/virt.h                 |  26 ++
>  arch/x86/include/asm/vmx.h                  |  11 +
>  arch/x86/kernel/cpu/common.c                |   2 +
>  arch/x86/kernel/crash.c                     |   3 +-
>  arch/x86/kernel/reboot.c                    |  63 +----
>  arch/x86/kernel/smp.c                       |   5 +-
>  arch/x86/kvm/svm/svm.c                      |  35 +--
>  arch/x86/kvm/svm/vmenter.S                  |  10 +-
>  arch/x86/kvm/vmx/main.c                     |  19 +-
>  arch/x86/kvm/vmx/tdx.c                      | 210 ++--------------
>  arch/x86/kvm/vmx/tdx.h                      |   8 +-
>  arch/x86/kvm/vmx/vmcs.h                     |  11 -
>  arch/x86/kvm/vmx/vmenter.S                  |   2 +-
>  arch/x86/kvm/vmx/vmx.c                      | 138 +----------
>  arch/x86/kvm/x86.c                          |  29 ++-
>  arch/x86/virt/Makefile                      |   2 +
>  arch/x86/virt/hw.c                          | 360 ++++++++++++++++++++++=
++++++
>  arch/x86/virt/vmx/tdx/tdx.c                 | 326 ++++++++++++++--------=
---
>  arch/x86/virt/vmx/tdx/tdx.h                 |   8 -
>  arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  10 +-
>  include/linux/kvm_host.h                    |  16 +-
>  virt/kvm/kvm_main.c                         |  31 ++-
>  27 files changed, 720 insertions(+), 660 deletions(-)
>  create mode 100644 arch/x86/include/asm/virt.h
>  create mode 100644 arch/x86/virt/hw.c
>

