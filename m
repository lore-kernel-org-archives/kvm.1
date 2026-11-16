Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845367;
	b=BVT/yXhrRe6PjRGLXl1MGnGFrFu0AKVfUBTwZDFnad3kQte8k69fGGRuA6Kbm/PSdBux
	 7o8OOH09pkzMUsLrBaeGbcmoH9iKQ2KGobDTuksD5k/WnMPulR8PY+CM/Q/BYelVaZqiB
	 cJ2YvnAdZQyKkCLwbEq7caaqdzfpVMvGIncxEtsC489BNbnDMoJMbi1Cd86W9aJK/blxd
	 43Dh77YHm4AtQE5Qzpw4PguW0xFd3e6ZFmZa/2+rTPM2F9KzH2ifAZGFxM+ySbdvIVD0o
	 emmgNqPwLOYg/m/fIhArDE1hHE5JTn4rXsjF11lhFYrdcDINMxcGVgAOTHN/TdwRv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845367;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xuWJrrizIQaSrZTQFgUO3V0HL4ic1BmuoACdN3FzMhU=;
	b=UisVrguzoBE/MB/XutNtEcol0x222ZENfroXO9h2SRxMJBbrSeCFdMmAVQDIARc+XZtn
	 HqOTxnmOcwi3mrHCONasEPJsnkbZRoTFJE/TdyIyEGPi+L4vDjJnosnabEIDdlUCbqeYS
	 vvuzSHMoSo+ForWizlsrejjWsj14fasNBJaEHNfXLsSySkQNc+GDkkSsH+NgQFVopOms5
	 CKJRJmI44X+aGawB8Q8HqoM2ey1J3qN8GJqrBja9JPWpVSfnAz5F6TJS2rZKMBSOIMqJ3
	 WfKZwBfMuLCTr2q8NeZtgADLjazp+YZgN8VSXIjrZRDDHzTSIwIyjXFV1yVpNdn2jGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="FZJ7H/75";
	arc=none smtp.remote-ip=95.215.58.244
Received: from mta1.migadu.com (out-244.mta1.migadu.com [95.215.58.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75F606A323
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD75F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FZJ7H/75
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xuWJrrizIQaSrZTQFgUO3V0HL4ic1BmuoACdN3FzMhU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845365; v=1; x=1795450165;
 b=FZJ7H/75CAqBzC58hJN+4FVMl2DuXZkS5yLiKg7VhrFHQjcPC2mBO5uMibGtItsKgKd+rfhG
 atP8eTFXhORoUfKIRNJfeylvJAX3cmil2nmPNJxL5VSrPu1P/eUiNlFoga4Q7cGoMm/EXuresX1
 QlbykhUYjpkfluKkigFD/EHE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 05c0e8fd5d053a3f;
	Mon, 16 Nov 2026 16:09:24 +0000
X-Mizu-Trace-ID: 05c0e8fd5d053a3f
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so12532e87.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:09:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrHeGwSDZMqbqe9ohNUTVWfP8DJ8bQbKjz6IBGHK7Mh6LqEk/f6OHYYBnljluXd2uGOgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HZ9asMDjYYjPAvQCbfjOQm2fGQcdtFuVKAboJpS5MUI37TQKZ
	suq1pjJbE4T/E7hmwHa9fXZO/YgaeKFYUzdTRTS2kVBs203vfu4XuuQhLOOb5m5w9dNo0FGWoKz
	lrRHCFlCPvVIaIGUxWM9H3OvrrrwLTcBJ8AC2xtw3
X-Received: by 2002:a05:6512:1304:b0:5c1:4cc8:2f22 with SMTP id
 2adb3069b0e04-5c17e4b9f86mr221482e87.8.1794845363481; Mon, 16 Nov 2026
 08:09:23 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
In-Reply-To: <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 16:08:47 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
X-Gm-Features: Aa3M54pa7DZ_uBY7ynCUhZPG35ZaG2vJ1bC6E24f7r2YagR26_2vzli-PPKoWqQ
Message-ID: <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Tue, 10 Nov 2026 17:18:22 +0000, Fuad Tabba <fuad.tabba@linux.dev> wrote:
[...]
> > Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> > clobbering vcpu->run->exit_reason.
>
> Will do.

After taking a closer look, the clobber is problematic on arm64, where
KVM_RUN completes a pending MMIO exit only if run->exit_reason is
still KVM_EXIT_MMIO. If a pre-fault stops on a full ring after an MMIO
exit, the helper overwrites exit_reason, so the next KVM_RUN doesn't
complete the exit and the guest repeats the MMIO access. The ring can
be full at that point if the pre-fault dirties pages, or with NV, if
the stage-2 walk for the MMIO access does.

I don't think changing how arm64 completes an MMIO exit should be in a
fix for stable, so should I keep testing kvm_dirty_ring_soft_full()
directly in v2, or do you have another suggestion?

Cheers,
/fuad
