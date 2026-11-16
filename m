Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849107;
	b=OKlBiwBDrwHWtDMCxD7BrxRW2fEQz4QiN234+tw1nLTqk67kRexoNh/AdPIoAXZRuwXa
	 3zQ/D7WP46TmTmQ8upH7eCUDa3BIVNLFJOKqGo01SghNmpxY5NeykGKt/IFaF/CZz3ZD/
	 6uidg6SjyMc+syM/WMs2jbX1fJccxFSwwPbfJGrGsO09PNuujNEpBqtXM+GQk9i9ZE2nr
	 NYH6t5gGuRR+W7534nu2RnrLFnLeutNINvhTiO+3nzCSPWLGHzNNqQ+P0dbYUNFpUWp1P
	 GhpMF/+W1WOCexoTjmHeNOTa90bncoswYAd/iP5b+q7ldt2EV5Kz5q2vDJ1TA3/rt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XSh28i+VhSML98fbPpvhJzYzMwMr+W1AdTaomqWNWcI=;
	b=11YkywZlV4QWLRyOQ5Kof1nfft9Rkg9OCMTQDYM92zujrVSx65gEhQJJL2u7STxFdqSW
	 ZpMFd2eXysapCfqpmmTXFL4w55p5o0UlDCIRyDX9Ctb/BukoMhL+6zklASZ6z+lEq1kom
	 KmBMTU4gjuk1LFk6v3+OzRjaIjtqwkhpmuWY3cJ/GFkZER57rVhC3nbdjCO67+8nztggw
	 ZDLANrMdjgvSw4DRx+XE9HnripiMWHbpLaMZNllbsVQdtZFxR7OoMt9OSOneFDyn0IIUk
	 P6Z2l5WxnVEbQlEe6AHKvHPFVmN85Z37RGyYypQLJ7XUPd+jDJRR8Xqhj7wDdEp9URg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fAdSLYMJ;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB5606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFEB5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fAdSLYMJ
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a06750c74fso3442262b3a.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794849106; x=1795453906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSh28i+VhSML98fbPpvhJzYzMwMr+W1AdTaomqWNWcI=;
        b=fAdSLYMJ506+m+diwF6sFIbKTIywITxdgd/t8G3MxgiF5OVoSL5ZC1zK6LiBufXCX/
         kvnhmlRoHgNzszyclZVB6Dn8Ez3iPNphBPeMp+BHzo33ndkbg9Avc/IOq5Q1jJ9uuwSZ
         B0wAlkywavz1RYVEanbvdZAgSx3dK5HuI7VyuegEwDxwnRyAbiAiUmrmbfYTB2uMA9ci
         eBUYBEjvL/M8WJhax76OndVS1Xd/tyXgvRlvl52mu5Pm3413we7w3lHoarUBVuwJanHB
         x1OyrQC7Tr1h0i/4l9bN6llc6NjEQ1Rjytk3sde0vFJyRCN/W5JAu8qrn1ojO497A93i
         wvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849106; x=1795453906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSh28i+VhSML98fbPpvhJzYzMwMr+W1AdTaomqWNWcI=;
        b=jubhnYayFIvypDLTpXsZCjYY3GEVitCLREt/UK9wfFIWi+Kxarejb2ikQGSEpPdPqs
         INYptNVhlc44EcYi6i4GxAv7jrfJWPEtT6LhfA/FbnTDvEdg+ga9Szf8tL/1u197Sdlc
         1cJMpmsLOhDlpFZeswETqiIqXC2nScdb79lylcahBh/St0zyrgmCHrmapMK3PBe8yZCO
         bv6dZbHddgt/JZ1eP5pM/DXqx7UgmswTkKzTmM29Uqo65GKz5L2FOZfvxJyDKjteomtN
         I+U2nXhMbSQbg8yM57mNvxNhxup4ZBytd60VfUJO2p/8n4Xlnl0fZd/jeajUdgyhFpv5
         hg5Q==
X-Forwarded-Encrypted: i=1; AL+hErHOgTdGoUTVVrzV4XRxNHP8kXf0RFMuxAmy0B+1EK4c4gBYiT3QfdUABb9Pnz3FLIHecCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yNAq9xY5yOzkPrdRI6MVmvghBob97QBnISlKZu2KtEpN595ZR
	r7QtrsIAm1/OcDgt1zsr+cABaOfHzxYdql0tKYmc280/0izKLR7uHCpY7AqJ+KZLcuN/SQ2PHI/
	EYTIH9g==
X-Received: from pffi16-n2.prod.google.com ([2002:a05:6a00:c290:20b0:8a2:1bc3:8884])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a87:b0:89f:9ea6:1ddb
 with SMTP id d2e1a72fcca58-8beb619b3e6mr9177875b3a.23.1794849105715; Mon, 16
 Nov 2026 09:11:45 -0800 (PST)
Date: Mon, 16 Nov 2026 09:11:44 -0800
In-Reply-To: <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com> <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
Message-ID: <avs5UD79FB_DG1Vs@seanjc-mac.roam.internal>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 16, 2026, Fuad Tabba wrote:
> Hi Sean,
> 
> On Tue, 10 Nov 2026 17:18:22 +0000, Fuad Tabba <fuad.tabba@linux.dev> wrote:
> [...]
> > > Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> > > clobbering vcpu->run->exit_reason.
> >
> > Will do.
> 
> After taking a closer look, the clobber is problematic on arm64, where
> KVM_RUN completes a pending MMIO exit only if run->exit_reason is
> still KVM_EXIT_MMIO. If a pre-fault stops on a full ring after an MMIO
> exit, the helper overwrites exit_reason, so the next KVM_RUN doesn't
> complete the exit and the guest repeats the MMIO access. The ring can
> be full at that point if the pre-fault dirties pages, or with NV, if
> the stage-2 walk for the MMIO access does.

Wouldn't that require userspace to do KVM_PRE_FAULT_MEMORY after KVM_RUN with a
KVM_EXIT_MMIO return?  If so, userspace gets to deal with the fallout of being
stupid.

> I don't think changing how arm64 completes an MMIO exit should be in a
> fix for stable, so should I keep testing kvm_dirty_ring_soft_full()
> directly in v2, or do you have another suggestion?
> 
> Cheers,
> /fuad
> 
