Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676054;
	b=XVDPmwCfwhBdqvpZ/35Kfphk8BR9d/jeA9wuOxazrgPkbpUON+S51IxFQ+Ozyjc1ajt/
	 oyZ6gfaYpCL9s0R4aQ570rrbgv2XXksTAF4y777esTdH0E4IxknZjQfAOy0Sof2JG6tqx
	 HyGEw/HwZGMuWxVyTGNlYd7IPhkBwSBPao1qrNBNex3toxEBd1YW7hDw46MtMaI6q5HRu
	 4u3yKtRtA48fhg4hyfjFiOMw0n05saES5NXqGHM07WY22OCtp64v/kByezEZZ47e8jQNX
	 ytDZ72CYXIvtisFWGOjMFAXB2vurAWCA4fn4A0rbY6qkeW4pyyOTFyYORJzjS1oNl2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=s6fpI41ldXRDTZ3theMUIYhg/aGv3nEmbSPbCA6hXnY=;
	b=iaJhfa67fzqDYm5V+0W/+E3s0h85c0jO0N2vXIdZ3rgzOhZIMu5cieO0kvVOtseUV5eH
	 HyN23EVTK9p+W+If9UhLb+PdSa1TOLx/UoTK0cScvFtUZBSPS7TH2yY+06fgA5E2xMNrX
	 GS3vxMIRh9Pld98lydUkJJ0Z5+D0XD9QmyqayZTx0KIgYxJ5wRUpZP43U4E46e/1sf9Bu
	 ZhOtUvP8cNsG7JXqTnGNMkGXLCiu+GpmTijmVZpmEo4AVnNQVcyOz2UymcXOHad0WJnx+
	 +OFto5NXeKSOk1KZnaDJ8OxBAYXTYpUix9zhvVyqyJlY1PnQV8JQcGEejw2jTUjskjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vcUMFtjE;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E9606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04E9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vcUMFtjE
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad436a9d00so1856387a91.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792676053; x=1793280853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s6fpI41ldXRDTZ3theMUIYhg/aGv3nEmbSPbCA6hXnY=;
        b=vcUMFtjEE61jlmwLQaTKKSyXBSPY5maoItDCO9Ti74uo3xF49IxusXeu/BbaMNZnv5
         CfLLMhPqrtQTLlbaZJxOZlWE7dKyTuvKwO8gZed6eP01FeQKds1s7mbMXZwfGlvpKaiy
         gTHb+Can2amKrMeredy0DUFnc0vFU1PuGh9yUpWD+CcM3N6gD+ougRfZ3du/4Cpciuco
         imF3hRJTVUH6zAAeLUOmOIVthEFUBf7VslAdQ10n5JyHC2M+sWF1d8LYN0DHEtPg16UP
         a9Ssvq2lDyqZ8hBveK0ant3JGxi1709ppUrpi4PIq5UtrIEpPYwaLaI9iCj3BXgk+JEg
         BbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676053; x=1793280853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s6fpI41ldXRDTZ3theMUIYhg/aGv3nEmbSPbCA6hXnY=;
        b=IdiFCL/Vh3920ygpezsuQtNIU8GsLruJWMyZGyV0S/rCLkDaIhuuMCVgPaFozhaNLi
         64sl0qKPYN/tYGaE5DkIoOyRDBRtSu+vO01Ped1tHNP40j9VOSVVhKKtvreQd1EvySpv
         3eHa/gtspX2XnR8FdauXNh+1JMXLHOw8pLBNiGvLHLYzl4wj44O8sji1iUjG0X7yZkvl
         6KVqB9noAWmbFRs/itNtJBLvKazNHCKyDAVYch/o6z5btgxwXPHBt0l9zlYdHfg7VNs7
         AQkc502njtD3uHAjx0PqvX4q35j3/airTWBhl4D8Jho1hs3+YmI2eXngvnAz7pzc8Cd5
         IO8A==
X-Gm-Message-State: AFq9FYIgqMkB8wjh2tn6HxAJ2q7mQTPMV4kGWllibu394DcqGfHqm1fq
	9tlG5IxccvexppyBNGoXlMc9Al6IKAV4a9PytnJkq0pqj3sIjc8X2mLDxiQlzcJGWU2uYRZvn0R
	Ul6YPXA==
X-Received: from pjhz8.prod.google.com ([2002:a17:90a:5408:b0:3a8:8e16:d986])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4483:b0:3ab:9f1a:3825
 with SMTP id 98e67ed59e1d1-3ad86dcaf5amr4303123a91.4.1792676053000; Thu, 22
 Oct 2026 06:34:13 -0700 (PDT)
Date: Thu, 22 Oct 2026 06:34:12 -0700
In-Reply-To: <sashiko-outbox-180886@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022022209.300964-1-seanjc@google.com> <sashiko-outbox-180886@kernel.org>
Message-ID: <atoQ1Az63PUL8L0l@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces
 present SPTE with MMIO SPTE
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> When a shadow-present spte mapping a valid memslot gfn is overwritten with a
> non-shadow-present mmio spte due to gfn truncation in the tdp iterator, does
> flushing iter->gfn via kvm_flush_remote_tlbs_gfn() flush the wrong address
> when range-based tlb invalidation is used?

...

> Should this path call kvm_flush_remote_tlbs(vcpu->kvm) (or mask iter->gfn to
> the root's address space) when !is_shadow_present_pte(new_spte) triggers?

Eh, I don't think we should bother.  The right fix is prevent the truncation in
the first place.  If kvm_flush_remote_tlbs_gfn() weren't limited to KVM-on-HyperV
I would care, especially since this requires userspace to effectively misconfigure
the VM.  I.e. someone would have to go pretty far out of their way to run afoul of
this exact scenario.
