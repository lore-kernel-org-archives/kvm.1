Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AA17C203
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418231; cv=none; b=SFnDpSPFrRWhZC1FdaArMtVyzlfCNLHZyf1gLQFALm3Tld77qOS7liHCoMbAYuld1NAbEG1QB4UWdzzIN0CAHoTigTZdMgYjnXkoynTUW/rtKODbR/HAe/jCdeRL8412jKnxxIGYJSvfE8X7fW4tQ0crsRqrh3DFvdHI9bTu5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418231; c=relaxed/simple;
	bh=hQQiHxSEGwQxiHaB38jAFN3VxMpdGtVAhsoVKmZzD5w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn/pWxuZec8oeK6XRT9U1d7qJzbawdueIC6nuZaGp0/sjDdTAlAwiQsPW5SD03s4okNyAe4iIdc3+/Lpf5G5jnKRQwHVh4H2zeTqJ2HNpv6rB2Xf/im3s3pFlCyltTKY/7bvaVzHnMOycHw0bg5nEQZBDoCU+unTtNTgcEegVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YWEVKHoj; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YWEVKHoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1779418217; bh=aaw0tjcGwBVquxN6n7fXt2Ki3JqilPt6rb6EfS5DoMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWEVKHojMFkqXU1K4HNVeJ2F3n06enttzjjHbkcSohCTWJH17KjUCbp+9NH0sq88H
	 BfZbjl0FJ4Aos2TzvO5sGbyCYSRX0pY7ZcrL2faoS7Pt7BqLy9V0vKuEIwm9rPJZvP
	 Fg27L4r9JKN77DrchgPT1su7vT8bGaqbTbwMv33I=
Received: from zh-pc ([116.128.244.169])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id C45B82C4; Fri, 22 May 2026 10:49:05 +0800
X-QQ-mid: xmsmtpt1779418145tg0xcller
Message-ID: <tencent_4A39169A103432A565EEB007CCC88D920109@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeG6ctf8VGuEJFCETY5hPzyYyGtlOeMkhPllnGyn2BzofElzzuhR
	 aOl1nbzJ2lmqwmbQ1hx85614nb85uiOEZcht3eNsAERd61Kf6yHS7VTcnxo8/Q3jimnNVA4FrG/x
	 9J+YiVqZKzD/0v2no3PZoyK1DigQdQlirz7+wAuZHUX8OwcrhbQcd+keILaPbb7WLCIty80sAvuN
	 EZRXoTIjwo6FthZjN/c5aW6hlI4LWtL4X1ttrfNnFcVzU4v/3nR8AyMhXM2yenZxrX/zeUihky0T
	 tUFal8LHzEk+4xYXtruymCptU/SB7l0sL7UTBVz7BaLvgl7VYaSwdEaMmWzxhzcmPYPTQmcA30Dg
	 wB4L5pC9NUklghr/Ccl2Kkdp7bi3Wm/nZe1whsK9yxNMxaROgu0cA9XHJ5ICAOM2mHUjRRGlmyWQ
	 zPeSB6qKRJMyvQ36QaCbgxCPSSnD11vMaZlKDwBiUJs8lhWU0PPxhfl1zcM22kHGCQhYhYljB9kq
	 eF7nKJMHXQc+eGP5OBQtEtpWA1IbNdBVqsLB7FGBYZUU02Wq5EKCXbOXWULQxJXd1B+m14NxqVac
	 Ra9fZG8m2DyQjvADLTYLQwKWFmZwRbAeEo5xUSDk/SmxpY6QwCmNFjhDyMEhaQxpH/scecHNmbN/
	 OHivwpaLBjDZ2l7XRTT4twO1ht6luUe7BhO3z3TmN3gfgcS/w4j4nY0K781J+OebhAH0jokQgGga
	 EScpfVdhO5utr/4pLMn7rdkeBEmA0N0+qmj94qY8RFqQRXApyukNrAr6WFxc2Wt5L6eCzufj3m5y
	 UxMYZe7L85ZunGeGzGbmPNydditD3Ca7qh8F0fVD+VWINjyS3qV9QzlhkwAEtwE/hOqaxIx1TAQm
	 0iuhFpn1BD1cMyH3MfhFiy0ZJiDJwX3l7vkho6gHtwgb/ysusJfyROS5TgaPGoL9ghC577omXJ33
	 1HALkUvBRcuy6jAmbtW62sfvHvzEi4L1lIQSF5xAUSNkmipnMiQqYPTJBEqn8izFhlLSSl7jJSva
	 SaRhrWa+T4/ehjMLdwIYKMUNlbpLxY+4Rut20fy0wx35RwtnN0
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
Date: Fri, 22 May 2026 10:49:05 +0800
From: zhanghao <76824143@qq.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Add tracepoint for vCPU wait/yield paths
X-OQ-MSGID: <20260522024905.GA77335@zh-pc>
References: <tencent_2A66410581309346060C5BDC8CD108053005@qq.com>
 <ag8RI8fX1w7jx4sA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag8RI8fX1w7jx4sA@google.com>

On Thu, May 21, 2026, Sean Christopherson wrote:
> On Thu, May 21, 2026, zhanghao wrote:
> > >From 0c8d4428390a1238a956f713c1ddced18eac83da Mon Sep 17 00:00:00 2001
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > Date: Thu, 21 May 2026 16:30:37 +0800
> > 
> > Add a KVM x86 tracepoint that reports when a vCPU reaches selected
> > wait/yield handling paths in KVM.
> 
> Why?

The intent is not to add a scheduling policy hook, but to expose a single
observability point for KVM paths that already have wait/yield semantics.

Today userspace can infer parts of this from lower-level tracepoints, but
only by stitching together different sources:

  - PLE can be inferred from VMX/SVM exit reasons via kvm_exit.
  - KVM_HC_SCHED_YIELD can be inferred from kvm_hypercall.
  - Hyper-V and Xen yield/spin-wait paths have their own hypercall paths.
  - HLT may not be visible as a userspace exit when KVM handles the halt
    internally, e.g. with in-kernel LAPIC.

Those tracepoints are useful, but they expose lower-level mechanisms rather
than the KVM-level point where the vCPU reaches an existing wait/yield
handling path.  Consumers that want to correlate vCPU wait/yield behavior
with host scheduling activity currently need to understand VMX vs. SVM exit
encoding, native KVM hypercall arguments, Hyper-V/Xen hypercall semantics,
and HLT handling differences.

This tracepoint is meant to provide that common KVM-level signal:

  - ple: KVM reached the PLE handling path
  - hlt: KVM emulated a guest HLT
  - pv_yield: KVM reached a paravirtual yield-style path

The tracepoint is informational only.  It does not change KVM scheduling
behavior, directed-yield behavior, vCPU placement, or host scheduler state.
The target field is also only the guest-supplied value when one exists; it
does not imply that the target exists, is runnable, or that a directed yield
succeeded.

So the reason for adding a new tracepoint is to avoid requiring userspace
observability tools to reconstruct this higher-level wait/yield signal from
several unrelated low-level tracepoints and architecture-specific details.

Thanks,
ZhangHao

