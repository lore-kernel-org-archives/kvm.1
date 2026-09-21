Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3F4A0928;
	Mon, 21 Sep 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999060; cv=none; b=uELanV8IPoOtsL9joyBCLLZKZGH6JnhrAygQfj/c2wXUfg/TMDkRI10WvvwRGPn4CNdb4o4UhOxm1NmP9CKpvkuCf9jeCT9ZlED3k3uOapyyGzjFXHKEXd6wAOCapgNm8nJtUH3tWa4Zfe035hO7IRaadH+ydv1u6LLH9bH1lMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999060; c=relaxed/simple;
	bh=KgJkAAJbACGMZwia7K5q37gDCSuUQ1dkzquNcdjbP28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbbwC1EOes5i9zjPL1moPvTVFtaFgMwlVdg5pqJ/lwr9ISxdRhj0Unn7LCt9c2DfnRd7NwOOAMdMCiu4lvqhy+0F8j2KIUgjo6/BOI+thI72tXWs21R6eKsO1r5rrHhRTQhGZoGuVV+zxIfND/+IXMwGO/hfDoOcD3gklBAyzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Of898EOW; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Of898EOW"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpPtk6tJ2z6P6n;
	Mon, 21 Sep 2026 15:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789999055;
	bh=KgJkAAJbACGMZwia7K5q37gDCSuUQ1dkzquNcdjbP28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Of898EOWdGU601ui/uuhVOsbBmeMo81ca7JZtRGoT1ulrZwx62LVVvn+/OSqm+Ait
	 vgIe+yPgDrtx2jPic93b1zoqCzsn4pcvzlGdXpYUaYy7k5hXyDXaMjsfyHFI4njksG
	 wWp+Z87qgw034oJXC1R7V8820nYk14YJEwHIdv5BMsp4fvmk0gPD6IlDH3sVnZD8Xx
	 1nUBuKMyWBF6SpIY917EYkdKxScw3jRc12Q1mRBABxRVkHo+21fULir9XhxKOG+BPA
	 JR/bmik7WV1C56i1YSHuH3LrNrbRLT51jOpffDSA7GHvE1uTCIIxiYM0+4NuuzDGdu
	 HGUa5SvEx4mJg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpPtk68cvz4xTm;
	Mon, 21 Sep 2026 15:57:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hpPtj5NwNz8tcb;
	Mon, 21 Sep 2026 15:57:33 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 55CE65FB15;
	Mon, 21 Sep 2026 15:57:32 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <c645070e-9829-4f98-bafc-b5d44ff2db45@leemhuis.info>
Date: Mon, 21 Sep 2026 15:57:30 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Christophe Guillain <jean-christophe@guillain.net>,
 =?UTF-8?Q?Pawe=C5=82_S?= <spawel523@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260914181223.289061-1-seanjc@google.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260914181223.289061-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178999905283.1501695.3621712942188863182@mxe9fb.netcup.net>
X-NC-CID: xIJ5pFtLm6HGBbuU8vIKnskTtiWlbD4WY2eodwQ2KYTKD1yWp84=

On 9/14/26 20:12, Sean Christopherson wrote:
> Serialize vCPU creation by holding kvm->lock for the entirety of
> kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
> by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
> possible").  I botched the math when justifying the vcpu_ids tracking; it's not
> an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
> "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
> something we want to do in general.

Hi Sean! Thx for handling this and sorry for pestering you, but I have
to ask, as this fixes a regression that was already reported two times
and introduced this cycle:

What's the plan to merge this? Is this aimed for the current or the next
merge window? Ciao, Thorsten
> The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
> does parallel vCPU creation.  As with so many things, KVM's current behavior is
> the result of decades-old cruft, not intentional, deliberate design.
> 
> Patch 1 is a tangentially related bug fix; I included it here because holding
> kvm->lock for all of vCPU creation allows WARNing if KVM attempts to lock all
> vCPUs if vCPU creation is in-progress (the caller is must hold kvm->lock).
> 
> Sean Christopherson (5):
>   KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
>   KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
>   KVM: Move check for existing vCPU ID to the top of vCPU creation
>   Revert "KVM: Check for duplicate vcpu_id as early as possible"
>   KVM: WARN if vCPU creation is in-progress when locking all vCPUs
> 
>  arch/x86/kvm/svm/sev.c   | 10 ----------
>  arch/x86/kvm/vmx/tdx.c   |  5 -----
>  include/linux/kvm_host.h |  1 -
>  virt/kvm/kvm_main.c      | 35 +++++++++++------------------------
>  4 files changed, 11 insertions(+), 40 deletions(-)
> 
> 
> base-commit: d599822bdb66aeec5ec76297b0fc6efaaeefe07c

