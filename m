Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092253;
	b=B7On+swCd8l5adsPFYJYAaaGl7EGO+HlK8WFSqYs91+hNE+r6YoWEYX0KDrv26gfyiBH
	 UUGck88dHsaTO/5HBYcU+0+f1kN3QMQzGHbKAvEH3/ITpFP5c/0BkwhOYLCgMn8Tr5tvl
	 ox0X+AJs09peDFwVPF7jZEE6ZxBidWHLZkW4Z4o1drZ1InGdtFqaDF4Io7Uk67auu/Vn4
	 krD35w++duYp98K1r4RtPaOuGDlmgMlOi5NybOYY0QP+aFP+Q48TQcooNM8vO/ArA2zqp
	 /8J4ZxL8Yum8eh1pJuDNXl3aN+IT5iDUZQSouzyHE+6rd73+MgfOc5+ui+tb3lEr6sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092253;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=odGKjtuO2fcSEp2Bw94sYra7hu3Cvd+3dwpUXKWdflc=;
	b=X2++fj56ocmg29vs2JaRHqLEnOWr+oq7U8sgTcE8gPFOvfr/jn66tt3Np4u6fP8VzvkY
	 owaYgXncTefy+mbz+3FHeMiq3ZbGk4IQuFQLovdCyM6PLCLMdQ3Vk2LqDf41vBLzxJTZ8
	 C5z8HaUcUj4hpFMpwZdTnKpjFWE+G0Ur4XWCU783g42NEvFKjDwOSzprTkE/556m/OUgz
	 UKJde6qxWoukvoF/FcoFIBR0umS/fIlZyIjpklnzLyztiNMEB+BZIDX+NmRtLzt7gLaRX
	 m6brSZMvxrkcBrfH9cyaqXczoo8ZNZrvP0SyWAksoDWiOE4JlTTtcXmKbIsHA7QCzUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Txr88EII;
	arc=none smtp.remote-ip=95.215.58.180
Received: from mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591B60A2612
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 12:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9591B60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Txr88EII
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=odGKjtuO2fcSEp2Bw94sYra7hu3Cvd+3dwpUXKWdflc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795092250; v=1; x=1795697050;
 b=Txr88EII8eXZ3BevEgepLqSR+jMiGMvjtzRJggX8o3nGTRQTo+fQQTx1REoBdJqI7joAdDG5
 uwviIaBbEpa/dfx77TEyep/BMu4/hGvWJ+/LJ4Z4sQxFV9UxsiMBhZftgc4TnRXnQ4+4Zr1XuSK
 TM12+YTiz8yM2FIUUSz+mzyw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dd592c93a745dd4a;
	Thu, 19 Nov 2026 12:44:10 +0000
X-Mizu-Trace-ID: dd592c93a745dd4a
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5c00d7ac49dso5401e87.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 04:44:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFW7ZIRS89ojSEfCM1p529otaXrKERjI1DMCSfWA9tl+3JG+ZlrVMnEymqFYmIOWukxMlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nyrkFuOsyxdWzgoczkHbdOJColDN6RJQnrlLpVbHufySOz1wD
	zN4uYjvvvqzpFAW0kSqJxc1z2BgkVn1VKXORxrDVulrnHPzy5R25zfY86kOdVJXxLDqqMfKWxhi
	ICnHAn2JocFbikdhgaI3oRt3rmXrkA4zdoPAxuPaR
X-Received: by 2002:a05:6512:4011:b0:5c1:4d61:20ff with SMTP id
 2adb3069b0e04-5c1b6774040mr72185e87.10.1795092249237; Thu, 19 Nov 2026
 04:44:09 -0800 (PST)
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
 <av5CBjbeidUUWiLq@seanjc-mac.roam.internal> <av7bYb1geEGzaj8e@gremlin>
In-Reply-To: <av7bYb1geEGzaj8e@gremlin>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 19 Nov 2026 12:43:32 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwzdsMKw2MFB9kpV=Xtm4JFpTbWRn0BOSwSB+x=RJhVMA@mail.gmail.com>
X-Gm-Features: AclHuK9ExBlvjAlpEcQpW7OIX1pR4w0klOAvsUXwgDHyVbn5Bw8uFWJCaQ8SOYE
Message-ID: <CA+EHjTwzdsMKw2MFB9kpV=Xtm4JFpTbWRn0BOSwSB+x=RJhVMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's
 dirty ring is full
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Thu, 19 Nov 2026 11:18:48 +0000, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> > > (note that it skips CSR, SBI also with a changed exit_reason).
> >
> > Ack.
>
> Probably worth referencing in commit msg I guess?

Will add one in v3.

Cheers,
/fuad
