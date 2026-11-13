Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577925;
	b=iaSvqzCxNoVeIp+QbkzLlxoENiyJG3ausCV4/QuxbH7ddvABvRt3BQhHT6MsvBJcq41R
	 Gq4GvkFoPwPrw/Wk7Gmj2Hw2zMRhahMAzabPoS34E4IangxJhxPpWR3vKg2MgppA3UCI5
	 voJM8CW87HJcsDfbOMCA+Xzgi7fnuZ6Ytzvn2pYNX2+yRUZ4u4NCZcZ+lTZk3xWpWL4Af
	 4imF90Fz4sVsW/MdlbsZp76sb+a6ed/2S5ActVvyKTDVusosbc39sm79YWWwPGP2kuSZk
	 q5uz1S8yvo503oD0b1JMx+V0YPalsoP43P2YvT7VPaIlDtq9d2WuDT/bR0KrPPdSLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K0IB6612mARPt9Rl8+nBzWxg6uJB0se+VdqdMW073D0=;
	b=yFv3MaoQw4oJC23Mt2/EU8WxSPxQ9rx5buMiw+KQYB+vRz+M0AaaMC6yXVKdGzQgwL9I
	 uiPGlUNo+6W5/DA/ZnQ/VbNiirFRESP4D59idBmXD67te3vy6iOtyHYVUir16T5nLh7g2
	 8Lr/K//ryEXTkRLpKZ+5lQ77QRAq4fDjm5kx3MiT35OuBFEW2GpC6k+3gYRHWu//UlIEQ
	 YlhG7qn0B2Tl64cKtW2VMDBwAzKnJb4k+sHTSc6S2UPyb7qG/YYEBYA5E92xGmKbn6AqH
	 rlL3PwTrpZNer1lLSS7L1Nu8wf1SxFReUlGHM2K4wkTDAt7hboIfvms3CBWowG2mQ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eh6pJWz7;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BB606D690
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E3BB606D690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Eh6pJWz7
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so1468912a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577924; x=1795182724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0IB6612mARPt9Rl8+nBzWxg6uJB0se+VdqdMW073D0=;
        b=Eh6pJWz7T1EGWR9ZMg3kvHAb3D4q7eDnUMkg6lFRPG0fyXrqW43hGFA6ViB0SdkaKf
         HT5Am0V4NXhDxOmL9MpkHQY4ttg93d6MpvGAQCf7zF7bDQx+tIxDak5CNVWwBemQylBb
         RcnNKFppa+sO6dGaMFKziyxnnG1JMEm3LvQ41yyJwTEv6ZFzd6TM11FqSBu8I/Sj+DmF
         T/3SFAFlzIZ5Oa5VwGSqoK8084k+xI7nCanELiuDW9xBS2QnAihWw8SRv58yivXJWuZo
         UUmBSy/pD0e5mLKosiCM+2JhTxpIZw9Qd8UXhhKyTd8yTaIXlXw2GXIipLJQnfC27WiW
         2MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577924; x=1795182724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K0IB6612mARPt9Rl8+nBzWxg6uJB0se+VdqdMW073D0=;
        b=O2PguomUSBAQYw6UlsSFh0DiXdI34W3lHAU9CRpU0F5FTvoYi1IpiMUk/GhnqjBNBx
         1cEVFbEb6zRSGHSfkhTiztOShAiAv7M2zYjoLIT7z4k5zi7kFWLzXxY/uiy42MAUhnzj
         lNH7q3e2sxPcKWm9Q+8/O87+iL6FzbEqrm4TiZmHoq1jNWnxEPv7NGFlRN5tONQHG6XV
         NcKmEwDnqV6miPCAFM8Y+3EkExO6wx4d438BENzDZQDQ8padzfQNujX71Ueh8Ut3O/81
         59Nm3drQEIhS2U9o7OqMDVk2YcPz9agPGtjxAhVEiwhWQsf9UNWEIf4YkPlbNjwRk0KI
         tiBQ==
X-Gm-Message-State: APuU4Z+mv4KYzc4DLYp8Dp+HpizuQld3vSvhiABDjhZeIhUI9a0Es3Uf
	NvHP9EhdfLqqGBLKBrBKKQar4mO31oXavokGANt4MkKGmQMrbPTmbILG5MG/O1QiPNOzFIAoam+
	3tq4SAA==
X-Received: from pjkk4.prod.google.com ([2002:a17:90b:57e4:b0:3ae:b67:263])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e8c:b0:3ac:9d14:fe9f
 with SMTP id 98e67ed59e1d1-3b1b0ba3320mr2196813a91.31.1794577924365; Fri, 13
 Nov 2026 05:52:04 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:24 -0800
In-Reply-To: <20261008065920.56705-1-flyingpeng@tencent.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261008065920.56705-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441836671.82170.6029845388944217333.b4-ty@b4>
Subject: Re: [PATCH] KVM: VMX: Remove redundant CPU_BASED_TPR_SHADOW check in nested_vmx_check_tpr_shadow_controls()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Peng Hao <flyingpenghao@gmail.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Oct 2026 14:59:20 +0800, Peng Hao wrote:
> The function returns early at the top if CPU_BASED_TPR_SHADOW is not set
> in vmcs12, so any code that reaches the warn_on_missed_cc block is
> guaranteed to have CPU_BASED_TPR_SHADOW set.  The repeated check in the
> if condition is always true and can be dropped.

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Remove redundant CPU_BASED_TPR_SHADOW check in nested_vmx_check_tpr_shadow_controls()
      https://github.com/kvm-x86/linux/commit/098a8194caf5

--
https://github.com/kvm-x86/linux/tree/next
