Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577825;
	b=sIWjbX9S6CTTlVxUaBJ4U1FQjiU6dcImBD3T0QRsaEYB/nVxVOK5GMJrFiLUwai5ZbVP
	 4kZk+eMPOilwyDOr35/aO0eppyLcqvnYdf3BZPidIOOKf7TZor24pYoK3GABmrtsSTerv
	 4Se7D3D0Kw4iyhEKK5sbGeNzM/zCVgwDIEZNdHG2YVpxJwbN/0YyKlO3O17vBmbQuxppr
	 RMc075Q9eZZDYHu/9fqoQxr/BDTasvgARy4nIs2NR22B9da9wAGdMlj3Oa87GP7qzw9fM
	 9sPWt+ypJS8HltdMB6ENUJyQnJJihfB6Rx4OgFqELU3r8vp2Ds1gET1VW8Zj6MfFn0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Zqxp8I5tFMzdgWo41Sp5SqieihB7XXuPvOoZVDMQ8Uo=;
	b=H4XXlaCM7JGgSptTX7yLfSBZ/Z2/74f+BCh64hJF5VofquBwT5JI49SoH791w+1OatOw
	 oxAvVfBYlTBS46TdDJMpKfhV20Ydr4QXtCahG4C21hH9VVB8yzK6LzJllrtjSjFHat+jT
	 IVYPeAORCvL9eX3cXk4IONU5Q2QvUh0f1O3uEAvc7Npiu3LspK+JsGFHvpLIShv0cvPzX
	 4YD9ii+3VhE0q7r+AnvtM8cwo9SbSB8sZHkZfgBXnHWJMdyoEzTiVSpE9L5546/aM3eQh
	 46Qr/9gIr7DCRHf5Q1uYv44SpGLmRiQ/17vrcsCOZUn4lE7HltF87ao6YI1I9aZHsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUTG+q5X;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7619606A8A0
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7619606A8A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lUTG+q5X
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so1434283a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577824; x=1795182624; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zqxp8I5tFMzdgWo41Sp5SqieihB7XXuPvOoZVDMQ8Uo=;
        b=lUTG+q5XI2MbQizU4uwiiAtAgyxFq9jqb1nNLCQ4ABT8K/of110pEqsw45kldSobU3
         hUeo0mqy7S6d99KSGMX3p7yIwBFkpdKmi+s1HIJsecVqHqKr24Zd7i5MB5gxYkDQQlN0
         61GHtDIdgOdg6IrtkR2hAgBCFEzOyE0r+CS9pKgc+XTETvrlLlDhf6JepZxYEB6v2bjq
         UiDjgfinC2q3pkT+ihsPR5TWCRJSz8Sh0KF3aVBT4/GhRNTkQQB1BG4BhQwt+FiOrW4e
         Y9wfwb4DjWJldkYGUA6U5DSTItcYh8k+pfE7b+Vo7GxYGUgtR5skyh2l6USA337axdOV
         JEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577824; x=1795182624;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zqxp8I5tFMzdgWo41Sp5SqieihB7XXuPvOoZVDMQ8Uo=;
        b=mM55nqXJprAFr+9iTRAdZ7lQcQl64RnkvFoRWAhDmmbvDiLnpxsD6XNLlMP0UhTOd8
         9PuQ6/wnkNd1GWG3Y2fTMkOFvHScp3aZnCfgpYTHjZv5hImv1wItTWSAWrBurM5l3Rtp
         mkpMw/x1O+sXpkqKiPYxYscU6CijsttOa/Fvv2gTUuXrmEAOByppvE3Wga5QHyCkt5wX
         NflOFr6Mwy+BUAJOMex9hKu7tbq168Mfz32FDyiF8KNISoFZKgz5L7cWIe2Mk2c/XFCj
         pxLBM9cRP1f7O3kMjAfaxZjnRWyJQRIPpJlnLrgt1jYBjZrV4j+w/yZEFwCL3FxuMwV8
         JzIg==
X-Gm-Message-State: APuU4Z+eSn1+V7vneGrViOXz547J6wBW5QgPy1M5PmjIQBSftm1FeUL2
	0XY7i6Eb3Km3T8J3DXsWsJPR95WbBXQ9vk5mb7ilPP51YhBDS1DxNcx/qnCZnhaQ5Ga4orP3mxG
	PV76KOA==
X-Received: from pjblk18.prod.google.com ([2002:a17:90b:33d2:b0:3b0:b36b:66fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:3a4:f75d:d194
 with SMTP id 98e67ed59e1d1-3b1b0a20d40mr2509161a91.36.1794577823926; Fri, 13
 Nov 2026 05:50:23 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:54 -0800
In-Reply-To: <20261022193808.557206-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022193808.557206-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441775604.76179.10722589436007929167.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Ratelimit all I/O APIC and local APIC kernel
 log messages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 12:38:08 -0700, Sean Christopherson wrote:
> Ratelimit all of the kernel messages in the APIC code, as every single one
> can be triggered at will by the guest.
> 
> Opportunistically use the more modern APIs so that the messages are run
> through pr_fmt(), i.e. get prefixed with KVM's name and info.
> 
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Ratelimit all I/O APIC and local APIC kernel log messages
      https://github.com/kvm-x86/linux/commit/48f7e6d7ef7f

--
https://github.com/kvm-x86/linux/tree/next
