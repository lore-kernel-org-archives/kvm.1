Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15B477982
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632287; cv=pass; b=NadLvYc6JTBxC+3g0Il8FwarjPjVVnaLO7HAFNPAes9CtO+s2EnM25Pz0sy0dNPP0xJJjuJpNayzzOFC+gefyh6JJY36HpG5hAAP2V1tHbpm0d6NufCAFSSRxJ9vYrd9ScM1VWjsZIWYFXcInDouOzDxl1Jc4MjW7tx+qunWx6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632287; c=relaxed/simple;
	bh=p2ANGxzNJ20KDUvX+I4Q+f5qJmFbZs4+5xfreNmKUKU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b63swfTZpl4YKzJbHQE+HRCzYXGsRM7hWwBz79ewAJ+eYnUErrQJybL/9mngswKl63URkRRF//KkhDi39NXUn51RcmKtvDfChWth8f6X1VxLtuMeqIcHExMzmgjbQ+2wFt0TXApWaQWfGO5Xxi/VAaencMyHE0Vp9gqcziedYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEqNkDh7; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEqNkDh7"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13986d61b4eso2378353c88.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781632285; cv=none;
        d=google.com; s=arc-20240605;
        b=dcxMCL+ouSRJLwbUsjhyu3hg3S+8m4xMBW3bxxTvImejIJ7DZVwWfs1mdDHgSag/vE
         0E8n3rNWHY7h/hn9o628mdycoGRw4EETJGdevb5L4vcIaWHMFBFV5CqrWefiuq676IS5
         aT74L9zOetYbNJMSGZ11AjHPELmw2Ox2rHLO82M/ZfJ2wzmFPWA5lZIc8hCwOZ2t8FE3
         6w3XZcEoNl5fJJV55HQyGSN0oforEwihc97WZfT1cPX4PiC1nYCjU1QUnzLMYEPbLYPL
         IXb61iVPzjg1WEXl3LWO4nJDvbaVjQvVWm3SPCkppAGibTP1iTt1rffvhVFOw2tQByCu
         SrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vAJ+Zx927BzPJvAUqjNTscby/9Gt71bp8RVRdDOhQVA=;
        fh=2gUTmJ60nfKPXJBgqbzhEM1xP42mFDyvA1kv2XbXrNc=;
        b=Et/UoNHO+Im6nvqAE48SdkWkiY9h6nc5zotNHJgVspkd8X0PUfqUNN4j9QHxL3SLSb
         CxZ0WDaDsTaiaDZxA8yb4m9XdRtaaiexNTaR7wU6dmmVJ34bHMwXjeg+5bF4bi4AYtqw
         5LT0qIb6GhrzGhX+koN881yUTAWAoMxmpbK+0YUPdaXXexLrA16aPtRZ4rmAO9KxSI5h
         7UQwrTifffqfHzKe5d91nKzMzVkA6ldIhkZ53RjbXd12rqRfvjO2RoHac2VTsQ5eSPk9
         R9QIGfBwImasgh3NUQrNzCe8dD5zNLjZLmgkLHcu03pJ6XJLt40bTLVySNTIAcZJ0ehf
         dkBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781632285; x=1782237085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAJ+Zx927BzPJvAUqjNTscby/9Gt71bp8RVRdDOhQVA=;
        b=tEqNkDh7OtzEQM5+tlxJ/beQBKLyfBhH5umGzBWse3QiQcvfJ3i4bt/PYPbmsBRyQj
         qlRmNtgkJtfuemc1OaIMsxV2Y961+21h/N0eS/iuG4Y7avMs8Tr6fNATc14iq5De2dQz
         /SZXKbwUeBervzs5CgbnqC3PWzhU0yiTKWnsMPDMy9LgNtm8XvvIQKKk5aGgN0ITe9dl
         qcOgY3i3T2sh4H6ARzHVDGCUeDgfTcqF1PV6eQb/LyhTUCpDZwvuFCdWztpT88FGWQhb
         atMfH10w0nLsTMfefjjMU4PD4wnQHM7RcZ9AmmM/QSuNMlCnwdSq6Yx6TLB22eWD2b5F
         L/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632285; x=1782237085;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAJ+Zx927BzPJvAUqjNTscby/9Gt71bp8RVRdDOhQVA=;
        b=qS+alEG2aDXNvczReGt5X8grkGlpY6wCFKik4u3Mrpjal+3CD8DAG4KWo4IadGyMyd
         136JoR9FTo7/AfQEc7K6XuCEu1wZjiSTgIfXK0bOtuRsZVNWQ3MvLi7OQ9w2sVyIkiZc
         Bqku4pbyfk1DSX64u5pv1XYoqtpG0NGCxVD+0t1MBXt5FY7BJHU3F/VjLnDF15fovr77
         IEY/XQHVYLFpmQx6fBI2jGeVkzPIzFb7wKsI3bb9cSsJ3ojHEn6vFu9aVpOIbmwNkGb8
         inVaMg4P+PQDj5m85r2OCTcQi8TAXQ9bUgl+dgHPqK+8XbMgKJQxmznGaLsryOA54vXX
         c5Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9/eBP+5bQyPeb9+SdiPyeoCoNJgYoEAzTgISC0+TSLb6+APNlOyiOoW/RfzRUJUEQKucw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmRjkzffFrCe02+bE8kg3kF7Wy4//S1C18kQm4zLPV6x3mntS
	bspf9rpewBtHPX97JSOoyvsWzV5KyQ1ueRNYyjZCeT1bt0XkWepgBvtsBpgfrqrajmyll4tTDCw
	HIDjKF9OehHKgjUpwEKBA92sYOeQKePVz/0jlgWvD
X-Gm-Gg: Acq92OEgoPnXC+eQL2AtuJxzBzKXzEMBW6DSXGnLHFgp9Oj4Av2GF5C7mpGb/J8FiYg
	VKwrFrmXtiUa5p6v6WF3XepeZ1Xrjm/TdCHrk1fngTdJQ3o7K+RorAmj6I+uRRjR26Criiu6WXc
	fGc/CQy3VFh4ZD/ORwO+g3A+eoU66rBjcwVvBgrdltkZU56x+ovm9t4v6SoGqqPAFMzTIRDPDMr
	4+OtCchCvSr5FIQxtecVVVIRxcxlGi2eI6oXXoeenSyRtquiKpFmtfxW9vyPlHT978VVwfLWVUT
	Kw/PBorTRrfT/Zy/M1SifttjlK9GfDq/k3JyhHXdiZye9nSTSakAWGF23PSQZs0Etf4INw==
X-Received: by 2002:a05:7022:6890:b0:12d:c730:c7f with SMTP id
 a92af1059eb24-13985f391b7mr2153523c88.33.1781632284036; Tue, 16 Jun 2026
 10:51:24 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 10:51:23 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 10:51:23 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 10:51:23 -0700
X-Gm-Features: AVVi8CeVvqhvGF5MX5YfSPvn-N1x5SmL7ZQyivueF-K8QCQbzjfdjv9TTd4B_6A
Message-ID: <CAEvNRgH7Lk=z9NqcY4OZXv=y5SeCZHnDNcB0=kHfarjCA4ZPTw@mail.gmail.com>
Subject: Re: [PATCH v13 00/22] TDX KVM selftests
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> This patch series focuses on setting up a TDX VM and adding all code
> necessary to run a basic lifecycle test.
>
> Unlike standard KVM selftests can set up the VM through guest registers,
> TDX module protects TDs' register state from the host. This feature of
> TDX causes problems on VM boot state initialization and the ucall
> implementation.
>
> In standard KVM selftests, the host directly initializes the guest state
> by manipulating Special Registers (SREGs) and General Purpose Registers
> (GPRs) via IOCTLs (KVM_SET_SREGS, etc.) before the first KVM_RUN.
>
> To bypass direct register initialization by the host, we utilize the
> standard x86 reset vector as the default entry point.
>
> The mechanism works as follows:
> 1. The host places register values into a specific memory region and
>    inserts boot code at the VM's default starting point.
> 2. When the VM starts, it executes this boot code to "pull" values from
>    memory and manually set up its own SREGs and GPRs.
> 3. Once the environment is ready, the boot code jumps to the guest code.
>
> The standard x86 ucall() implementation uses PIO, but it does not
> actually transmit data through the 4-byte PIO data. Instead, it relies
> on the host reading the ucall address directly from the guest's RDI
> register.
>
> TDX selftests cannot utilize the standard x86 ucall implementation,
> because the host is unable to access the guest's RDI register. Based on
> this restriction, we considered these potential solutions for the TDX
> ucall implementation.
>
> 1. TDCALL PIO with RCX-bits Passthrough
> We first considered passing the RDI value through RCX bits to bypass the
> hardware's register protection, which could be the closest approach to
> the non-TDX implementation as per Sean's suggestion[1]. However, this
> approach is blocked by the software-side implementation: KVM_GET_REGS
> currently does not support TDX VMs and returns -EINVAL. To make this
> work, the KVM ioctl would need a test-only hack.
>
> 2. TDCALL PIO with buffer indexing
> To keep a PIO-based approach and unify the get_ucall implementation for
> both TDX and non-TDX VMs, we considered TDCALL PIO with buffer indexing.
> Since the ucall buffer is initialized prior to execution, the VM could
> just pass a buffer index rather than an 8-byte ucall address to fit
> within the 4-byte PIO data limit. The host, already knowing the ucall
> buffer's base address, could then resolve the ucall content via this
> index. We abandoned this solution because it would require changes to
> the common ucall structure and impact other non-x86 architectures.
>
> 3. TDCALL MMIO (Selected solution)
> We ultimately selected TDCALL with an 8-byte MMIO data. This method only
> requires initializing an MMIO GPA and adding TDCALL MMIO implementation
> for TDX under the original x86 ucall path. While this diverges from the
> non-TDX PIO, it provides the cleanest implementation with minimal
> disruption to the overall ucall architecture.
>

Sean, Lisa evaluated your suggestion [1] (summarized as 1. above) but we
think TDCALL MMIO is better, what do you think?

+ Jump directly to where the mmio is used: [2]
+ And here's [3] how tdx_mmio_write() is implemented, with no more
  throwing everything in a structure. It's also not macroed/prototyped
  like you suggested in [4], but I think those prototypes can evolve out
  of future tdx functions?

Let us know so Lisa can try another option (if necessary) while we
collect more reviews :)

[1] https://lore.kernel.org/all/aQTcDH9LRezI30dm@google.com/
[2] https://lore.kernel.org/all/20260521-tdx-selftests-v13-v13-21-6983ae4c3a4d@google.com/
[3] https://lore.kernel.org/all/20260521-tdx-selftests-v13-v13-20-6983ae4c3a4d@google.com/
[4] https://lore.kernel.org/all/aQTdTkMIukzt-YlA@google.com/

> 4. A note on #VE and x86 ucall simplification
> It is worth noting that the use of a Virtualization Exception (#VE)
> is orthogonal to the PIO vs. MMIO discussion; rather, it is a question
> of how much we want to simplify the x86 ucall implementation. A #VE
> handler is one option to allow VMs use PIO/MMIO identical to the
> non-TDX case. Alternatively, having an MMIO_WRITE wrapper macro, as Sean
> suggested[2], is another option. Either way, discussion for this is
> likely a premature optimization right now, since the PIO/MMIO call is
> only used under ucall_arch_do_ucall(), and standard and TDX VMs use
> different ones now. We should optimize this in the future, but for now,
> invoking TDCALL directly is more robust and concise.
>
>
> [...snip...]
>
