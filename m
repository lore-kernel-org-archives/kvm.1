Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CC279DAF;
	Fri, 12 Jun 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301790; cv=none; b=INuN6YlAtRlN0VC3X5D12ch1kozAchxP46MG0YcChvG/9aqNpZzQD0MO/gukc+TNn4RAxPSx2m7YOj3IVYDG4kH+Jo/fWtEKrQL5bgZRjaIvpBc3ebsFSotAFOlpMcwPmdmDQoM+kV13fBv1qmh4TCfrgyVmiVsbflemrY9f+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301790; c=relaxed/simple;
	bh=G/AvIgSn3+X31HaTP3htYK8mnl79Zs3XKZUq4tOMUmw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JMq/v08P0ck7dcwUe5wKj77UoTRPnUkiVnvxuzY1HB6JU/IIyXwLu3hJ5yyo+7twr7Bufv0oFan5niCV0bgO3w/knYDYnQMY8lNDDuIPbNFhXotrQBcVUlG6sklTN+R+nhRSS30DXggPg7i41LrQe9WR1y33xfytXudpc9Iuimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crSbCsQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crSbCsQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3111F000E9;
	Fri, 12 Jun 2026 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301789;
	bh=Fp1FPICD/LxmEGBcHDIyrsbYJA9blA6dXp5/SJQ3EBk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=crSbCsQOp0jaoqHTp5tWev4DWn6S2z7uVjtgU92gIWpRq8/IZcaaVX5p5efmOa4hV
	 WIHHbRMOOflvXKjpx+70wlS3FjtcAXOFG2W9RSAfZ1y/+5K/oZ3ZIDmMxO02BCPgjf
	 7fRBoSPxYrvKOXWJaDNdzudVkJEguM2K77sWjI6ojQ9D85wgykFs66psUQKqBmZAkT
	 DKFus51EFa3QuBe9R7Ub5BAAT0i8N9FOoxtAd+/XDWYrPSnjLsnAevNbAvaYRy/1Ax
	 nrO3t0A5aXuMZ32AasazRau4lVCr6aP8IOMYxoJBV5JWbMIiZlyoa5XAJtXUd6R4yh
	 Cfhz8KZm6IJmg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id B86DAF40075;
	Fri, 12 Jun 2026 18:03:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 18:03:07 -0400
X-ME-Sender: <xms:G4IsavdQmnJZUdHYMQMZoYu-kAtRhW7TZeZmN1imZkxEJtq_CjPqCg>
    <xme:G4IsaqzC2fmW1FJuLfbpnypxGD8A6opLnyi_2HLE_snanBVtnSKIr4nR2NJ2flJ38
    BOLpRKAUO1-Oi0LNTOfklHNp4wXo_vztczYYMOETz9Fa3a5bCGaSOie>
X-ME-Received: <xmr:G4IsaiHzf7nn1lWpa3sKAiIn83rQXOxBuyKA3YfxE3JaBbef1NQgSuCZG7uv51XX6XsZZVwyWUtAStBPA397E2vSDlFntTbYwOk>
X-ME-Proxy-Cause: dmFkZTEL3FJk8teeTo/S7EZ6KqRA+02XEOzYvxHMshrjDcYxpHbJ+ANz7Eu63jr/UEiPSH
    VLpYM9M5h0946NWBj73X4/RGT14/kSCWDo+QJ1CTbpClITXoQsVsr0Pe71vmGIyhvG/7pX
    R1HspQ2KfCE4gPWifdJwMmvwGbUyvmZiBa2/OLOPAiyOnD+9/cFT83O0/7n3KF4LL8Bjn2
    CEbiYE3CxOk0+Ulcm0oH3XlmQDPx/rlx7ZcipbUfCG8y2z9M1FxWb5afjyv3LKtQSFOQCz
    mkpGydbZUcgDSwMirhdZBHxdEECJKx+WvbhB7Y1pXQzb9YjK4kJQWbsK4srLbG/vkSvAA9
    ee+R6mHIxrijzf7EXsdUeLLkpWsYc9SCuwS5MEgBqsr7KLcgNB7IUakvcoNcaQXdFWjbFg
    smffZ6oSZ3HzqEZxEvaXFmqBOs433a0sBMaVwMyGesxuiysyYnlrz87c55b/GAbDiuqmeF
    GYi+KTCEnHibRthxhONWZdMHRNlsKCvWup7hf3lAoXZguShsNaqZwarHwnGcIoanD3F3Xv
    nRaUg1crrlrOL02/txX/xa3zKCu+YOC4Tcv4OCVYsS/HscH9YLJrpIZO0LcGkwJr2Y5EIF
    b3lNTFz6vksGdz+OZ/gWWRHH0LMIXR9pvtqfMwOUNGmUywrXSC2Pg/ZBoQHQ
X-ME-Proxy: <xmx:G4Isah1p3I8bdOqymrghOO8CerP_EEs6vIBATRdmyXKGLVwxwLEMew>
    <xmx:G4Isai_rAMqWXQHXzAAeByQpB0ozEUelUA9yKWkdg9K3jEQ_0TMKTg>
    <xmx:G4IsasGoajjfGONmYZCjAUjYHbCErInjBG6oA_0XURguWbwrO-0o0Q>
    <xmx:G4Isagh-8pj-9HopBeXR53s1Rh2XqYk4ssUen5hsqRiBdnAphOMbqA>
    <xmx:G4Isap9XE1iA2Xlb-CaUWJU3WnAQZjIr3GzX2pRZoBgTm0rZp3RX6gFC>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 18:03:07 -0400 (EDT)
Date: Fri, 12 Jun 2026 15:03:06 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, 
 kas@kernel.org, 
 djbw@kernel.org, 
 rick.p.edgecombe@intel.com, 
 x86@kernel.org, 
 peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 sohil.mehta@intel.com, 
 yilun.xu@intel.com, 
 yilun.xu@linux.intel.com, 
 baolu.lu@linux.intel.com, 
 zhenzhong.duan@intel.com, 
 xiaoyao.li@intel.com
Message-ID: <6a2c821a99e3_9b8551002a@djbw-dev.notmuch>
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX
 Quoting
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xu Yilun wrote:
> This posting is just to collect initial review.
> 
> Sean, Paolo, Dave please feel free to ignore for now. Sean, especially
> the x86 KVM stuff is only here as an example for the init code, and not
> ready for review.
> 
> Kiryl and Dan, we are trying to get acks for the first 4 patches of the
> series so they can be serve as a settled base for all the other work
> that uses Extensions. Please review the first 4 patches and treat the
> later ones as an example for the Extensions initialization.
> 
> == Why it's being posted ==
> 
> The TDX Module is introducing a new concept called "TDX Module
> Extensions", and several upcoming features depend on them. The
> Extensions need some extra setup at TDX module init time, and the code
> to do this is expected to be somewhat generic.
> 
> We want to get the basics of this TDX module extensions piece sorted so
> that all of the extension-based work can build on it. This series
> includes those basics, and an example usage called DICE-based TDX
> Quoting. Only the first 4 patches are about initializing the TDX module
> Extensions. I'd like some review on them. The later DICE patches are
> just included to serve as a usage example for the TDX module extension
> code.
> 
> The first 4 patches will eventually need an ack by an x86 maintainer, so
> please review with that in mind.
> 
> == Overview ==
> 
> TDX Module introduces the "TDX Module Extensions" to support long
> running / hard-irq preemptible flows inside. This makes TDX Module
> capable of handling complex tasks through "Extension SEAMCALLs".

The internal implementation details of extension seamcalls buries the
lead on why this mechanism is important, why Linux should care, and why
this brings TDX in line with the other major CC architectures. Something
like:

===
To date, SEAMCALLs have been short lived routines that monopolize the
CPU for their duration. This limits their utility for implementing
higher order security protocols or pushes complexity into Linux. The
Linux appetite for ingesting complexity is low, so TDX now adds a new
class of SEAMCALLs that are preemptible and resumable. This capability
enables higher order service APIs to carry out a security protocol like
"establish an SPDM session".

The TDX "Extension SEAMCALL" capability is akin to ARM CCA's "Stateful
RMI Operations (SRO)", and achieves similar externalized complexity
relief as a dedicated hardware coprocessor like AMD SEV-SNP. The
mechanism is "give the service environment some memory", "invoke the
service API", and "continue invoking until complete". All protocol state
is internal the service API.

The simplest class of extension SEAMCALLs to support are in support of
"DICE-based TDX Quoting", a service to turn guest launch attestation
reports into a document that can be externally verified.
===

> TDX Module allows some add-on features to use the Extension. The first
> feature to use Extensions is DICE-based TDX Quoting [1]. DICE is an
> industry-standard, certificate-backed attestation framework that layers
> evidence through a chain of certificates.
> 
> This series adds infrastructure to enable the Extensions and then
> implement DICE-based TDX Quoting.
> 
> The Extensions consumes relatively large amount of memory (~50MB). So it
> is designed to be off by default.

This confuses the TDX design with the Linux design, and sets up "50MB" as
something to be quibbled with. The Linux design is turn on all the
features that Linux knows about all the time. Unless and until the "any
available, all the time" becomes untenable it just simplifies the init
flow to not play piecemeal games. Await evidence to change the simple
policy. Suffice to say the cost of this policy will burn 10s of
megabytes.

> It must be enabled after basic TDX
> Module initialization and when add-on features require it. To enable
> the Extensions, host first adds extra memory to TDX Module via a
> SEAMCALL (TDH.EXT.MEM.ADD), then uses another SEAMCALL (TDH.EXT.INIT) to
> initialize Extensions, and then some add-on features, e.g. DICE, could
> use Extension SEAMCALLs for work. Note that host can never get the added
> memory back.
> 
> Theoretically, the Extensions doesn't need to be enabled right after
> basic TDX initialization. It could be enabled right before the first
> Extension SEAMCALL is issued. That would save or postpone memory usage.
> But it isn't worth the complexity, the needs for the Extensions are vast
> but the savings are little for a typical TDX capable system (about
> 0.001% of memory). So the Linux decision is to just enable it along with
> the basic TDX.
> 
> This series has 2 distinct parts:
> 
>   Patches  1-4:  TDX Module Extensions enabling
>   Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.
> 
> == Some history ==
> 
> The TDX Module Extensions part was first posted along with TDX
> Connect [2]. Now this part is remarkably smaller because we've removed
> the generic tdx_page_array abstraction for HPA_LIST_INFO. TDX Module
> Extensions is the first user of HPA_LIST_INFO, and doesn't use it in a
> typical way (HPA_LIST_INFO can only hold at most 2MB memory). There
> isn't enough justification to make the abstraction in this series. A
> possible plan is to rebuild tdx_page_array iteratively when more use
> cases arise.

No need to talk about details not in this series. I would maybe just
note that quoting is the simplest first consumer and was chosen as the
lead vehicle over TDX Connect previously posted in case anyone asks.
