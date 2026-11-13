Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577759;
	b=sZXDMhCZ9WhPIUMDCmpq7eqk0iqzj4w9RLuKEotHbhgVU94QSdzdVG5VE6e4oBj+ho50
	 938RjVtgrS1iH0DrGLmxmWa7PIMx8NEtovrjZoZzremkkSo4a3tLZj7HidoPCMTRzL1et
	 3bg7TkuzcZzW1tXFmXDLE7xk1mV6i7CVnxmR8n2zygreJ1ALaYoU5nNS4q1icrXA7XG57
	 HSurS8UHoFJ4MhnSFV83Eed4Q6GZtzQuhXSzznsWLbCSaIq/SOcHuGeGvyMHzFXvRs+N9
	 6Cv1FnOLJvHpykm08rjY9qf8i2G9F/qOW0zKC+JyqFfJ7bIvErrBJs6ZdrePbx1C2cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
	b=K1q9m3ZF/NgpQ9qMGllGQavukUqxjmieVAq2n5rfwtl8pRYJfm7nNtieR5oI9GJDi72l
	 mCL7zLnr/0iCP+BBcvUxDkd9egTqXR4ZJkIpeBDz6p7OJ/2YJNKkAMkWxDl/MDt1JxLRO
	 bEvGMuVocZjwZT37ywqBkLtJ63975p/XioBh3LDeLYbT+2mCxjTMpS4bFn6ItMSBlGlO6
	 1gxGUls6gMedITVPyJ9SIIpPbNnBMpRJXa6eadYvk/YAgLP6aR5piqADIc0j/wT895/jC
	 m2iJyUD7NzD8we0dwZydHyv2ASWh76wxaSBwsLl6/qr1wtQLGUMUEbFqVlpJeCpLjwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldea60Y7;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1B606A337
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9B1B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldea60Y7
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so630386a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577758; x=1795182558; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
        b=ldea60Y77L8XdLaoFVYj7SbvCOAQT3aoZ3sqpFSGcD2f4plIFiedS905Gt0APcYH0k
         jRhtDQqE6zKe+9LpBG1ufAX2UgJMZjkqk6JGSV8hTx/qi4J7v2zC1shw6z9KhL2i9V2b
         COfWUvBauXn5tC0VJRNPvD+YpGN95+acz9kH3Q54VDHOFSsvQkEGUBWscp23gYhPByLb
         X9VousiCKXhv0SVOSb/7ukmkTOeSMoLk82UfSBOgUCbuJcBSvf3sdZ9ezWcb/g3E6yAZ
         t7JEj0yWX9AIjqbrPiYqbbyU6GyuC6f0LvWDWgtr1feCG8ugz3F8FjfCbPziVJh6A0+6
         P2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577758; x=1795182558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaZEgFBO0oN7uYyRNO34L79aitowmvFZR4PRL3xrbhA=;
        b=tuU8Dzk0yKbkoDkxDqzOJrez+QW/Ff1IIhfPwaHLFk/U5tPKg5vulbejQ/p9/1659K
         wf7s0t1IaEglP9iBmCMX5zqudYVWhmvRd0+aYpS3zTQiNNIbEOoUn2BLxhBeycw8k6Al
         V7SHWJwi89DIe3Rv7+ecYMFOdEij5zn9tVbD7OmORGyhR8u+MRJy0BPhW9/rVOpkWYXc
         JPZnJ2767ctC1s5O6+iMN6WxMH3jvyPEbuhjEI0XSLY103NoP/r1VE0oL1s2K2Esyaz8
         vWF3AV48GLuWEkyJFcTAkzMJnJL3CgWQAxkxYPxCtV6l6YHMD6OHjYAOYGOUHNqJ/VBy
         48hg==
X-Gm-Message-State: APuU4Z82klqbwdA0L9TU/cbwYDHz2J/Goea5ArTUU3xThnX/0G1312In
	vM2q2PIscHpSnwNEmRRo/037yKHYElTGado8nJXoMk5ukkgk8gWN+aEQrEumgSh1wyFXC4LLjc+
	U+hN/ow==
X-Received: from pjbov12.prod.google.com ([2002:a17:90b:258c:b0:3b0:ac19:f886])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cb:b0:3b1:832b:bb3d
 with SMTP id 98e67ed59e1d1-3b1b0ba66d9mr2028281a91.57.1794577757932; Fri, 13
 Nov 2026 05:49:17 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:38 -0800
In-Reply-To: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261006093354.590415-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441841896.82698.8297015734174614821.b4-ty@b4>
Subject: Re: [PATCH v2] KVM: x86: Cancel PIT timer on failed creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Bruno Produit <bruno.produit@trailofbits.com>
Cc: kvm@vger.kernel.org, Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 06 Oct 2026 11:33:54 +0200, Bruno Produit wrote:
> Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> device.  This matches normal teardown and ensures the timer no longer
> uses the PIT before its memory is freed.
> 
> KVM registers the PIT's PIO device before registering the optional dummy
> speaker device.  If speaker registration fails, a vCPU can have already
> programmed channel 0 and armed pit_state.timer through the published PIT
> device.  When I/O bus registration became fallible, its cleanup did not
> cancel the timer before freeing the PIT.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Cancel PIT timer on failed creation
      https://github.com/kvm-x86/linux/commit/381a21cfe810

--
https://github.com/kvm-x86/linux/tree/next
