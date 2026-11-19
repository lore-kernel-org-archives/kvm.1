Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074892;
	b=DSLBRlrmLYUhQukC6a8NUcB25/jJaXmtZ3GewMqOPfFFAs9aaFJgtVj5+F7N4HvFjsj+
	 NFC4JCIb2QNoVkH8I87h1Uh3Mnr7q8O/FdUUEzdvgOkeFFEslxRoq72RtN8QocygMSr97
	 xkVt96sw5dwIln/RB+bPXGCTND01CLgm+qs70KFVhjTa/kZL1W9D7lH0p56xjxIRamcba
	 z8COwn+w4/MyH+C7z+a1ddpQOsnhYCPOQec9e20ZN/BRp4HyZWt9W0pLGkUVOZvpVkyAM
	 ishlGXH/LcKPfUEA232Cqah+SBUtQpGy4IivnGsy2VBzQkU5QMO06jr0fr3XwAeC2zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074892;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+H4AVHAkxU3vkubZcic9ja82r8a7H7wKS0//pc/pxSA=;
	b=T9dLGoA6Fe0SDXFFrO6iWrJkOhZ1YzOZsqP6U1FHOasmIy5mZU85+YN456I/3agPhC7t
	 OFE+RWQEV57hsy71wrAbfEzvDG5V6GGnvKom5g8O/7NOInYVfV1Gkdy0jKiQ4b85nKpJN
	 jk2JBZztqY67wHfPkGune2oHFyQ2T40lV1g1TAy0bC/loUuoteKWuEnsD4IWHSLoDceLP
	 tZrAmZ606FD1wJljdUTmj4bO++LYefYMXuruL0qCOfrjJtgaSsXpm/C6DQt/no7aR6RJs
	 Yr/JZ7Fsm8ETHLGxB+i8oSznGso0XhYdbIBgPlJ0L+k8fEGaHfECQQuFxNeb7x+Ky8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KuJGoeNK;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D24606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D24606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KuJGoeNK
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IUkhtioo34/vN9L4UPndwkkOKppLGI8BNNMRdeeG/sE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795074890; v=1; x=1795679690;
 b=KuJGoeNKfp8ZRX9z1xtwdyg5UlGXJB3V95N2p1KhrINQPMX5k/e7NTz/tTSFBejPEz4lBSZw
 umhNa0f00PkOVbNYUyFwKbNgkVImWn/9wNDHixJGKG22PbAmnwANSzYXsCZBmnwycP7lWA3q9Qt
 f383rBgzQc/il6irhBZKKOMk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c78df25f66d7d465;
	Thu, 19 Nov 2026 07:54:49 +0000
X-Mizu-Trace-ID: c78df25f66d7d465
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so3771e87.1
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:54:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHq3jfZV0+hIGA8/hbGjG/3PfJuswpoYpSUcLl5Z5uTTNSIbtjlSj1jqavmmBTL5FdDp4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EspbZuKWiK3L1hsXJOtmT20CUrE2U7rL292gg8mTPX3TExQHc
	CQTtlb+Kwt3JWzJRrHtJtofHgafn6AmIIdhEzieI3MbwgCDDp7U3ypTlv5XQFyp8oQDd81vxen8
	D16DaOsZS1rMlflhPEjPPgtbPPNYlsj04xugBtdKF
X-Received: by 2002:a05:6512:3d20:b0:5c1:ac33:5a4a with SMTP id
 2adb3069b0e04-5c1b67303bcmr26361e87.14.1795074884909; Wed, 18 Nov 2026
 23:54:44 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117074428.7544-1-fuad.tabba@linux.dev> <20261117074428.7544-2-fuad.tabba@linux.dev>
 <avxfgWNePsGPK9mm@gremlin> <CA+EHjTzUrDxLSMEo6X66XhKtQ-=ew3zZhMdFWR6U9Ga17WLWkw@mail.gmail.com>
 <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>
In-Reply-To: <av5CBjbeidUUWiLq@seanjc-mac.roam.internal>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 19 Nov 2026 07:54:08 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwdkbx=1yQNP5=-BhE=S0uaoQnO3F-83d2WbYC=j9fd6A@mail.gmail.com>
X-Gm-Features: AclHuK9mtkqv6V--RBoHl1Fg-Xb2-fd2-ZgaHzAt1DD9Kl83ENlFhqESP2uZHtY
Message-ID: <CA+EHjTwdkbx=1yQNP5=-BhE=S0uaoQnO3F-83d2WbYC=j9fd6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean,

On Thu, 19 Nov 2026 at 00:25, Sean Christopherson <seanjc@google.com> wrote:
[...]
> > > Maybe worth mentioning the exit_reason thing if we keep this arch-generic?
> >
> > Sure, I'll document that userspace should complete a pending exit with
> > KVM_RUN before it pre-faults on that vCPU.
>
> If we're going to do a documentation update, I vote to keep it vague and scary,
> otherwise readers might think the exception proves the rule.  I.e. if we say
> that KVM_PRE_FAULT_MEMORY isn't supported, then userspace might think all other
> ioctls are safe, which is most definitely not the case.  E.g. something like

I'll go with that in v3.

Thanks,
/fuad
