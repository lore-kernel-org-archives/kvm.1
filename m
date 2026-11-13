Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577717;
	b=zdGUTolxrPtoO9kbQfhUg6dlul4xHtftjhueXdDTawm3M6V9eT2QEPPTMl6ZqkSj1c9m
	 Ptet2pj7qEFqZfK9NB5tY7tG11iMqnoq+QEYFDvfzM1r8kAEShaXJCTC0UBQhrdIinCQa
	 lilZw+oFAuzbX4J6PsSYb5H7jw+oBoDUh9WSZUBbkiYqgpep0nz+4yfprxYtSibB8K+22
	 pRhOECN29tnxdMHZNrHsENXJ9bOPhKzHh1kbVbjGKXdlRKY/KWD+F/WxW1g+WOqfwkinP
	 FV3rWs95csO+RBzZkqUg5zxeoS0CxgT+nwnQLqliFdaoirWqB/3b1DeuxKr2yn/hlbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
	b=IT6uSCn5yvjnj7YONodOS8ZfIVjaTexPDZB2K5Qm1kv11iNdneEL/DrOjahg0m2t6PjF
	 +51ydz9eCi6Ofa8WTlcO9kpuBbdiM4epEksrimXO7VqFXgVxYe/hsYuqigFr4xYZMBh0C
	 5KmTsJjHjcLwLf56vqYsKRah+hvMDrV0s+iC4mgoy73fguAUBg4ohRtLvy2/8oXJFGIaG
	 yZUtS0lWoX5dKuytmlkJj1zqTXQwlCp6qLK5pGWiQXXQM4GuEBqmcn80VMyqy0ZyJWdLx
	 0+599XzwyXc+FSaxTX7Py0Xmc9Dw90czpTsetEQiO6NwOce1H/1w3ynSeyiE5RNIGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H7l3hkV9;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBA606A898
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EEBA606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H7l3hkV9
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b17b31c3beso927432a91.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577716; x=1795182516; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
        b=H7l3hkV9qOW+6vyuUekiTht/VgeOUD9RY6ujvAaePTbWFCrkmneK+9URuCWnM4Idif
         nch2e3YuYB3HYE8YyaksiOy+sz+dPIgbz2pgiVFDHlKax3ow6perDCufFHfmW8b4vJc+
         81Lgwz4RGwV/C5+UsUDMJRAsEj1k/FdBFiL1HpUAWQnCSntqNX+L8s0MviUX1ZLfBTmb
         zO8HD1J4iQSnT12Uc9OvoZ7VZq8/DkBMzIgr+IqbUR+T6swRCGybzhPUoqSoDcGaym3l
         rEAqkj1YL4C4cFVzh1abOH6LXn7xq3Ql7P2pisU1h3t33RL1M/EAUhhGcxTC+zki18Su
         42Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577716; x=1795182516;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MRt/+n3qpNWP5atygjxku8RJqbtyvsNAOovAuzylIO8=;
        b=R9TAAo+b0RdihWY5J7BhLg+CyJRmu1qzdTr1OHdgq2Jqe4fYi5ah4CGc21fmXUQjB5
         eCGvFZKGloF/lPX60obtZmIsmnXJXTQangy4vLm0MIOTEl0XzuN3q12oeDJtslVFKv/7
         9OsyGHgKXhloc1MlwEt6q0eYBSt4K/jJ0b954y5FkzH0PlG25+OYKXuIONJaGYNzIwYT
         UV4fDWrwD5QS8gl83rjJs5m4g7gggUh75VGlPJRpzQCefceQVCeaYiwOANBrQ1h75IG8
         JfrfBB7X8SsIiWZ+rnT4l7Kn62NbsxGxSG//z6rm9uMKbo01hS7yzOeZaBC4ZlJCjHYh
         UrjA==
X-Forwarded-Encrypted: i=1; AL+hErHjrop8oYAI8b2METf77m6p4h2l+/BxNsC7KKwjXzCnfHbDEMGNfQVXv7GDQxmDRxL3eJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O0hN/8qaeTzE8dbrpYNoswJJpUiZLHSIxlqv/0OqkfcRXDELx
	+ytHHUORisvGzg2US27UxOZZ/ZMMBFo4GE5BFWFW9gSivUTKa2v9UAzM12+lAFDUyADAslJvJTm
	KNyEeXg==
X-Received: from pjzb15.prod.google.com ([2002:a17:90a:e38f:b0:3a6:d839:55d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:49:b0:3ac:bfa7:b079
 with SMTP id 98e67ed59e1d1-3b1b081bbd8mr2314779a91.7.1794577716202; Fri, 13
 Nov 2026 05:48:36 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:26 -0800
In-Reply-To: <20261013195358.163375-1-yosry@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013195358.163375-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441826991.81142.10798231327707439438.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: SVM: Update tracked pCPU on pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 13 Oct 2026 19:53:58 +0000, Yosry Ahmed wrote:
> When a pCPU switch is detected in pre_svm_run(), update the tracked pCPU
> and mark all fields dirty in both VMCBs (if nested is initialized), in
> addition to resetting the ASID generation in both VMCBs.
> 
> Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
> VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCPU
> switch, but only updated the tracked pCPU for the active VMCB to avoid
> unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
> tracked pCPU set to an old pCPU still allows an ASID allocated on one
> pCPU to be used on another:
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: SVM: Update tracked pCPU on pCPU switch
      https://github.com/kvm-x86/linux/commit/d41766c45065

--
https://github.com/kvm-x86/linux/tree/next
