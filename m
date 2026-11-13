Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577856;
	b=bFa+p/M4Gw/8krvyEW/R/y5HH42e0NjZscma5GJp6IKIwp695toPomRJMTKZV79ZUHBV
	 bBFtOfwC1bQnP1eePDz1W7SmGZfYMko+V0IMlRsIIUQmz3f+2nXCL3oV3hm4CJUPS9POW
	 S7j8E39mg3qikIlrxcimeMdE28wywdx4Pe+OIzmGPbHF/2rrmXtpmOPEOgtsGOvIfueD9
	 RDNjFv0o1mNtH80WUQUDV51yYI+DwWYgjxdX/MQtiZHBe57eJnMFcyx/SiHmIVpG4e7RT
	 h7c8T5T95Ne7X2s9bDy5wolw/P5fefuONLoLC/jy5sxmzaOMQ80ObvtIb8yc4WxpL5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5yckwOBS7WejdenQlSVU1d+F+ViL007aqlGTgu3O5JE=;
	b=mPBCB4OeJ4arTdqoWC7dBjYDYRhs5itFnLlrG63dev6K70OLGsP9C98R/scDxRqah4UF
	 QT7JPj5ZWV5uohF3bslSsew65GzJriT8ep+UxTthXXpal1+h53CeHM9YJi4+KRFKeCq7g
	 70ybWXPvjXr50GDnMMxTB3MJPJqUverimo8V+9DLmy5zdnXuMD6cRQ99sYKboPWJyjkun
	 3EZbsFzNsjHn/yIRWjsGAT5p/DM84QkozHg+RUgQpWvVvXMzDEMQc1pdFMj9OlAWvYyuw
	 RDY4uM6KFiXiU69lKlt9v7BzgZoVGbA/AOkAkrIGTgefgOgPGJwfIZh7EciH9rxQnAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZaxX0Qv;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9183606A8AD
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9183606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZaxX0Qv
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed05b3eaecso7157495ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577855; x=1795182655; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yckwOBS7WejdenQlSVU1d+F+ViL007aqlGTgu3O5JE=;
        b=nZaxX0QveTvXUZQ6FF+rYtycsnzLY0zhEJLylL199xZlKGoAmM6tgqiunZdzyyitv6
         z0gNLWUVrUfa1bWxDMcxQND7Hz+Cuy5jt2Q5V6Bu4y91FRyFo+9LO1xeHKqF/WZqErgY
         vRjX2igNmOyyCn01Z6XN+4ojjwj9mu5tIUG6G6l+6Kbq8gi749835gGRZ7LTpQ5wBC4O
         6FLuG3pixe0qZ5Qka90firpYf5Z+kHSugnGzEXnZiJYa89IYqidXk71eKdxityoIkUmb
         DOu7cNDspZ8bgucF0ulPJ83IT6wEJwCNq+6SGApCz/XN9Kp+iVExufIwAHRdvBgjSqJX
         v0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577855; x=1795182655;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yckwOBS7WejdenQlSVU1d+F+ViL007aqlGTgu3O5JE=;
        b=kPl+KyuHo2FG0BL6Hx86T22eaMZdXjfxLERBkQ8NgIiHJY/7GnI+JWMmdq6LbnXRcK
         ZhJuss9G+NoTn2SFq25gWeHJSbwNjHuWat+6ilblbULgnrcegRY/2M2M44Uaq/p4fZWT
         br6W5VSeHGL6hC6VYK3Bh6QK7fz3CeabQ1+QhaX9EqcMegIYMayy4SLcFWOGrSedU+na
         EkJQEZkVn4erb+EpKTXP0VcQAivHgvQ/RFLrBYyGVowVl1ZeDQB5UuSebqjSUz3enuCN
         4XGYke86Aez3hOfbdlJ8oA86t6S/pN+TJQc13qrMVkgEsAXEjH85GLfEU2qdn+qB5OuS
         5BvA==
X-Gm-Message-State: APuU4Z8aFHPIMqybiM9HWDlVhM9ZkJfU3uOPR99oIGtrQ/nfxyWvUJNw
	Ro9j0Q86aHmlUXPtVV685VPcv8xDzfTRKjUNzWmo+o6gXvfG9DS4Joa1l0cuf4avBYbxkPEMGbp
	y7B/Jtw==
X-Received: from plki12.prod.google.com ([2002:a17:903:1a0c:b0:2ed:1d20:a33a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d591:b0:2e9:7ace:ccd9
 with SMTP id d9443c01a7336-2ee0df8f7cemr26087855ad.52.1794577854829; Fri, 13
 Nov 2026 05:50:54 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:04 -0800
In-Reply-To: <20261022022209.300964-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022022209.300964-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441773300.75844.312134211621387845.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces
 present SPTE with MMIO SPTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 21 Oct 2026 19:22:09 -0700, Sean Christopherson wrote:
> If KVM is buggy and manages to replace a shadow-present SPTE with an MMIO
> SPTE in the TDP MMU, WARN but emit a TLB flush to prevent a potential use-
> after-free.  It should be impossible for KVM to resolve a GFN to a memslot
> and then later find no memslot, but due to flaws in KVM's handling of GFNs
> that can be generated by the guest[*], KVM can/wrap truncate GFNs when
> walking SPTEs and resolve two different GFNs to the same SPTE.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: WARN and flush TLBs if TDP MMU replaces present SPTE with MMIO SPTE
      https://github.com/kvm-x86/linux/commit/94b5cb50abec

--
https://github.com/kvm-x86/linux/tree/next
