Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577850;
	b=Fa+B6rDDzqwwiyelQb4cYVxEKUoGrf7gCf33EznBwezGeLI/6CLHquF8528uogVrWpRV
	 xGSu/Eu0cdSHTSxFAWjmtKdeOVeU4YQ+Un5V25G15/sXJP4dp/h5gqAVBrI93eG/uj/do
	 Cc9XnrXjvYDjTBviyMnf2+HsaZP/joUalO3LXd8KYK1ImjHzsqF2GUqtSSLyEJxcjbou6
	 uxhCgePHCYE+jUmsCa5yRbn1oldU5lI3zV8owL4HYGkTtn0+GMo1gUu+dQO2M2sernXA1
	 jPb0RscbGDadGlA5c1P0545gEN88HCJ9n0ZW21CX1FicTV3Zbiv77IcRdsEmEVa7rPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VsgiRDhCW6kUOuC4NPdpStyHzvYs15vX/Q4TGFl8uM8=;
	b=aI4kxrSVaTMNM2NoaNESCgNgVboNGHXIsapYOj1FzD1/UDMz2bTHlWc/lLfNNuDvOsNn
	 sy+Bia20jj189SG0u1azwW7wLn7cQhEoZ6tcfrPI7TO4xfWJO3nRZx93KvF22oA97FDZ8
	 OL37rOBgV7LIMpDluIAhcUQO3KlaIgGxkpJ/IvsgTgoRq95po6nwNgzgnWaDcAXOEGMrv
	 fzJilIYzT3jm6Z4rwv6FlKY9xw6fnQ+wSxqv8+h/0+lOBqxKhs4LspQkpyo+xJYUgzyIm
	 ZqOuo5mbGcQ6MFWkGqHem2Lh1MoV2A9SjFFn1ldcQTUmjjx+IHMSWboipiVHsDvsh+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="As1/gTaC";
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C81606A331
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C81606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=As1/gTaC
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so1434920a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577850; x=1795182650; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsgiRDhCW6kUOuC4NPdpStyHzvYs15vX/Q4TGFl8uM8=;
        b=As1/gTaCGV3WndjdCd4UVwjENbxbsrV2cHNKAd00yDrAI67AHKkq1V3cLPHpvj6Yuh
         lRMLM6kCUTmwjyHbKqeJ8tF0tAEjOVO+GOhiLIKffMLpqbfyRaxZITOJYfwAm4+wN4M3
         tkccJMqGQrJqOsbFi/59m/h9+H7mkIpxkjlCSNjXUljuXtVfh3DKP9U6hfCHPm6pcWj8
         M4yqsKLcpN/oEhSD5tG3g+gtdtn+0R8PTI/aLVR9hoQk8d0tXHuzWGrJBLPFk/A3ijbS
         nIhiamkiRukB6+dZauKmvJ9YqI4pqFGTqReinFfLJ7u8ficwkYqdUduyeMWl4DgLRsjh
         4ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577850; x=1795182650;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VsgiRDhCW6kUOuC4NPdpStyHzvYs15vX/Q4TGFl8uM8=;
        b=bQBEYIjc20EcSTsLIESBKYDzW6mY088b0hZV4dY4UbtiK9bg/TbZyjN1tDKdoFkM6E
         EgxaHN+E8oBBWJ9js8ujLf6L27eEuBPjxxsApotm6B6OrqwaltWGU55WjR6qHZHzGWaI
         +lTQj3bO0EPSQKv+TKo0WS+zfVs7SvzPo2wZ55QCj6Y7UbZ5G3pKCAEqqLMYxwsBQagu
         ePSR1UafRNxicwGiTMxMgYWQO0JzkPTDJ8u4jfXHlwmNyOBT4OoVI4ZoP+iZYxqTHcnn
         oHZFtoyz+aiYDKPQ9KahBeaO6iO0wLNsWQHDcvOE9eDciHhtJwl8TcDDy06pKuAgSIKn
         yZ6g==
X-Gm-Message-State: APuU4Z91pEpNm/tqeH+XQj/LVXb9r8NBJSGW0+eIPaQKaWOxs1x4EFI0
	ITllno7CSlSEaKdP1sJkDZPWiZ8xnfkAu7hVGerPHaSrzcCCMAZ83NRCiMFxjXgZSEuP8xo81Ic
	i+cdc0g==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:3b0:ac19:f886])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48ce:b0:3ae:5572:c4e2
 with SMTP id 98e67ed59e1d1-3b1b0a4e8aemr2306804a91.57.1794577849633; Fri, 13
 Nov 2026 05:50:49 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:02 -0800
In-Reply-To: <20261008095935.1237325-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261008095935.1237325-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441836288.82026.13479268434351715518.b4-ty@b4>
Subject: Re: [PATCH] Documentation: KVM: x86: Update nested live migration
 status on AMD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, nikunj.dadhania@amd.com
Content-Type: text/plain; charset="utf-8"

On Thu, 08 Oct 2026 09:59:35 +0000, Shivansh Dhiman wrote:
> The "Live migration with nested KVM" section is stale for AMD systems
> and needs an update.  Migrating an SVM L1 guest with a live L2 guest in
> it works, and has been tested with Linux 7.2 and QEMU 11.1.0.  So,
> replace the AMD-specific caveats accordingly.

Applied to kvm-x86 misc, thanks!

[1/1] Documentation: KVM: x86: Update nested live migration status on AMD
      https://github.com/kvm-x86/linux/commit/a9dfce9b3fae

--
https://github.com/kvm-x86/linux/tree/next
