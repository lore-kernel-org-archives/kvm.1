Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577915;
	b=Bv5kJQh9yZmRmPTepwy3c5Z404ucxBQWL5UeVx42TsQjix9wgByTsmBlc4RbYwBJy+BJ
	 b0NmAJ7u3g8DzMaHAQ8cwmi3gNCMNPYLavvYQj2g6IgKyTloxB7rYmuu159J58O4kw5be
	 GBH21Do00E3ZS4i46jyaWS/NMrl74X6BR229lmE96ilDri4/EvRaPgwde8PITyIuRwpr5
	 FtS/ReJLV8nchMmA4URcmAOWdayFthnXJqpTIYMu5hAKhxEdZ8W3Dh6Y37v8pODWjzvkW
	 qaXlgDNpOHTq2D5w1gYW8a3Cz9Bb9txh7p7v6QCkbYTEgtyrCdO+mtSqMFSkpr0+7WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=VjaqT3209uv6MC202ND13nLcrUczNX+A6aMg0FaxB88=;
	b=LXwEy+oN7hdHmHUvlepBZa9a1C0lbhQT6h20qAhGyIZUovWPedACyDs5QluRq1tmH+X+
	 /Oe0Sl0eGxqoFtYtazVT1iuCQi6i8KbZ0gawxkxBwzDWifT0r0jER96Kkh7tOOZ7+iAUa
	 bEVriZNaDO4Q5zn+DYVVL3lLf6h6JmjOuEDPA1YdfwK1CC/flh7VXpjrAcbh2IPWgH6eR
	 y3H9OKS6+iQrsYdQXZtaCCwplSwzYvTovAex+/+IDuANVPt7cyvSrLTvNb4xfUMEQZOcI
	 uOOlbADZHOep9hjmdd995epwZIG2fJiY8Ch8MKMCascnGxmN9Kr9WhXDPW/TsQv3zBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kULy1qMk;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A7606CA34
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15A7606CA34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kULy1qMk
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0f667a666so1367771a91.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577914; x=1795182714; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjaqT3209uv6MC202ND13nLcrUczNX+A6aMg0FaxB88=;
        b=kULy1qMkrEvLFqNPD2ea4MMpEZMW5F8AX8btRQtJfle80qdC8bsC48WmN6jWuwA0JH
         KBiZe/XdV0VJ0fvE0Z3bO1zzaogNS1Nv5o40Qxok9rD6eJLHQRo1Hh5cEJYaPdecvH0h
         fjBYxYdZj0HqWqzYAIOCqZCcN4QlgfvE4UHCXBt5IJgM0pTVQWileSsIdT8T8SKYYvTf
         K15JxyQFk+u2xmlowfxRdwS10Ame2modkb9RIKo7yFMHiJ/G/R/7KVKpUD8Hyw4q1Cuq
         wJ6r72lIGg0KT/8ewZf+bbCHE4hL4NUJG7cd6uTdgiEQSYJTBA4viSKzUBKIc8yAPb3A
         IWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577914; x=1795182714;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjaqT3209uv6MC202ND13nLcrUczNX+A6aMg0FaxB88=;
        b=JY5aDsYYrX7rrcT/heVlLDbXH6fdLfUWxdVQmafGa7/4cWY4b+xdKHi47ts3UA3myP
         ox2PRUAlqCw3Q0KiK3WYKVYOXQcmPFjZ1KKpMKTd14RZffaML/PeTomU08/BT9FxHvJP
         zSlZsXbo/ayefruOk1D9vSWG+AjtZFgvc3LQAZSd36TnOGRJcIBwXtASQlptEAvzjHiW
         0jfAh6aCZuP4aL+4NbWpK1ekfr6txjnbBWlYKiEKSLMsUekuOW0HhF5umah8MlKhWYK+
         fvwHX9qTmFUVhKWgsRrXlThY9ncpaN6IawlKR59i/BCRUdYeR595Y4IC8A5vrFil+M1c
         Y6Pg==
X-Gm-Message-State: APuU4Z8yxHkixFC5hQCrYsTDUQ0nRhYtwC4oOGh7WuI1LqRS5oOM8BIK
	StgKYbsDkTnVLvKK9ilXKdWl3s+SM7iOxxpBRGvHcE7pz/Q1PfM0y5fwg7PRamdEYgXYfvvtMdk
	Kul3goQ==
X-Received: from pjca1.prod.google.com ([2002:a17:90b:5b81:b0:3aa:ff61:94cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c8:b0:3ac:e6a:1b2b
 with SMTP id 98e67ed59e1d1-3b1b05ea8cfmr2418462a91.0.1794577914038; Fri, 13
 Nov 2026 05:51:54 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:20 -0800
In-Reply-To: <20261022203028.595318-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203028.595318-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441776823.76438.16222114675545424492.b4-ty@b4>
Subject: Re: [PATCH] KVM: SEV: Ratelimit all #VMGEXIT-induced info and error messages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 13:30:28 -0700, Sean Christopherson wrote:
> Ratelimit all of the kernel log messages related to #VMGEXIT and/or GHCB
> handling, as they can all be triggered at will by the guest.

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: Ratelimit all #VMGEXIT-induced info and error messages
      https://github.com/kvm-x86/linux/commit/6611ea2bff76

--
https://github.com/kvm-x86/linux/tree/next
