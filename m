Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577740;
	b=sKH7a3jwEhERqMv69h5NusVPbJyM+6M38sMTAkElR/MoO1Dk5qHbdZYTNH4mS+l6TkNt
	 NlI6PgLnBWrXWgGg4AGp1WqYkFVe6cu4h+eey99IQ/1j680EhYqbbTSg5cKGaBEIr2W6T
	 2DiyGks70R2e9IkKLdKXQMz6xPFN429YKzEZGqtXoW3T7f1pi9g/ZnL6xi9tzXh4Q0Q9O
	 Tm3ETB9765LSI5zfjJ2bVyva1d/AJ9ruydo/I8K2J8vDfXmAkUUEtJY38q0Y3mzY/seBN
	 c9ZeveQaW6zzNU/psGDVJDG7NV89+kcZfJ3ncHt38sbJDG7o+e1padUi3v3frEUizIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nUA/XruHs1T2Tf0WpFoNgdHnIv/Lm/y++OYQw+7v6pc=;
	b=xaExgGfedW/uQNQlrDokHE/oyewt46esJoi4VdvQqQBBIm25QdepZ0Q9mtu02VpH5SxS
	 Pk43S7/IeIab/u3/n3p/inYgB7/xHXoaVw9+qBKfw0DvGDU1Rx/DnhLtSMZH6NZazbhpv
	 kP7nbdbB/aubXCkuBtZq6YQBLZzNwZtF5LIm+jjydxcTDpccYe1Yntzp4PNs1iMg/P20g
	 iPbDSSb/Ryzg+exyV5/TFKnf1vnmqUZnObmWCiUSkFpyH4hKGU1riSuC70C5Pn76Ajedu
	 SXeRoWHJBNBJzaXOUpl/l6ql/Cvxf8FT0o9w8yxk78bEi6r4SV0xpbVGTmDyz3YxGyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBQ+FCKV;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459A60A2609
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3459A60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBQ+FCKV
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so1574032a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577739; x=1795182539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUA/XruHs1T2Tf0WpFoNgdHnIv/Lm/y++OYQw+7v6pc=;
        b=CBQ+FCKVX7pyz+dQ5QKbM1hny+1ubSjujIi3qRVilyp/T0+yE1V8b9cVWf22zDenoC
         tjwuSSWg7a3QrAj8WecXcvHmgIRWj5X4qg3+BudzaHgS5l7FyC5gv9CPFyp+ww9oRyEt
         Za1LsSuXYb3w7AC1TcgQ8QR6wLhkDC1RLoic08ASNOYsKuNzstCDwkNVDld5k7y3hLkW
         zUD9eu1UQqI4u45bFgUefkvN65VbxrWK1Oj3ywn55s5q4lLyvq2v4GYjuBbWqK0xQ4x0
         +WuGtPMUGi4gy7/oFurNiG+xplmet7p0AGp1XFBMRPVjAv5OTaVMD410CTaqNXBq1olH
         hJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577739; x=1795182539;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUA/XruHs1T2Tf0WpFoNgdHnIv/Lm/y++OYQw+7v6pc=;
        b=lKe5rBDJ0V5kGSlMtztn1/iAnSKsSy22enWLgCDfNRU0bd8tZO3ZUcYxZfnwyxF2oh
         PdynsmIiw8bvK3ZzYL3fG7/6x4+soc0xa65mXASu344ZXbfo1cN0XGR0+AGWcpzec9Mi
         1On3n2iPKAmoC4C1VisgJb3/QmuflfL5nAS38dIpwdOjDne2N3e8lu1n3KbqYnV3vIXQ
         mM8NBkJZb3XPaHAEphZMSEeka7146K30dnBgfcdOWWFNTfNgHg62WI0jmOZVHn8cSKi9
         XHujluFs99lWUOT9xlvFMk5waWzXDtV2ogZqWJ2jci2Tjc1VWGgZFKVzM8mpAy9MjE+g
         b6hA==
X-Gm-Message-State: APuU4Z9MjRVexM71zYWZ3h00rvvvq8DhvGNW5jKZs3ZmR9u5zBKpY6dv
	IHY2J8rf1vtxkc3FoCbRBfMe0X5zPxWzeiJyI4esZ+KlX0T/3gx6IkTrJkA6tKvzGU2p/J2wbz6
	RTcdv1w==
X-Received: from pjyw22.prod.google.com ([2002:a17:90a:ea16:b0:3b0:9c59:c0e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c6:b0:3ab:884b:65b4
 with SMTP id 98e67ed59e1d1-3b1b0d4332fmr2502747a91.59.1794577739394; Fri, 13
 Nov 2026 05:48:59 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:34 -0800
In-Reply-To: <20261022021349.296149-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022021349.296149-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441757932.74670.12537566702126454135.b4-ty@b4>
Subject: Re: [PATCH] KVM: Don't WARN on -EIO return from kvm_arch_vcpu_pre_fault_memory()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+db7bd0f41c2a7e82d4ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On Wed, 21 Oct 2026 19:13:49 -0700, Sean Christopherson wrote:
> Drop the WARN on arch code returning -EIO when pre-faulting memory, as the
> WARN is user-triggerable and completely unwarranted.  In all likelihood,
> the WARN was added due to a misinterpretation of review feedback, and was
> overlooked in subsequent review rounds.
> 
> The WARN showed up in v5 of the original pre-faulting series without any
> real explanation.  v5 did add -EIO as a documented error code[1]:
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Don't WARN on -EIO return from kvm_arch_vcpu_pre_fault_memory()
      https://github.com/kvm-x86/linux/commit/ed4d60b4ca23

--
https://github.com/kvm-x86/linux/tree/next
