Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577805;
	b=sJ/Gs3dwzTd2axMyDaIn4JIftxRTIyfIS17afHPTygHfpBLMcLF7smqF6CioXGWkWpvq
	 dpQWuMAZY5WHtZ5JZj32kzlaSfra7dlhIAndHbavE+RNXhlZlgKn6BMwqNFD1iS+jiF/g
	 wVvCbyIRyuJVAbcu3tB6x8nXgon/42nWjCsiOQydlqTlPggdqZxOxR+Xztmtvb1EXlEIj
	 enC1xeqVr69VysDpy0qJmcpwnKq/fqbzhstNTB6dK8qV04mTPKuwOiblIXAdU8ZJ/2DCa
	 vNFmfcjdccCkyq8IM0o3rljktQioQjsuEyGKJCYZlVpUmXNnCscL87r8DM7gWG0mVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DiCkgNSK5y/MvI+rznjQud7W7zCWMAX8iwhD1RM5p4Y=;
	b=AHzCEB5Iikp8GzmzqX/A4HQQqsua1jwXqSvy1ZsoXoyj9latEn7id9AKyfOmiJ2flpbK
	 sOoBrTRRnv747GWZh/lM0RypqHoCr/ny7Acp5og55YK5/+HqG01PpGpQGTKtotezcZcnF
	 I2y6LZ3pYiyqfBF+0GOpmcf/4odrR48oygjVP9OVxOkFVqWA2wsOd8HSVm1HB6kWpaeCz
	 RGDH2EdkwadmHwciu7ygKeEn/xwhktgd/r+xtiteM+zgZZ6lOHcaMoq5i+osCqxGjDBaa
	 blvAlCB5Ko8l73qEhXLVGNZDxPY9XHD8wj29HOWFb8//FQ+AVzGH3Cn22fSUFainQ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="RGS3jL/H";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF86606A887
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDF86606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RGS3jL/H
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso830064a91.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577804; x=1795182604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiCkgNSK5y/MvI+rznjQud7W7zCWMAX8iwhD1RM5p4Y=;
        b=RGS3jL/HlFf8z2luT6W6Luk9ik0YGEeGULc1IYTgwVLLn7LE1CNTJ5Ht35o90uJeTP
         hUL05woXLRm9kVsuf8cG80uC2g29+ZPBf/lFfnO32pV7UooE3lzrNuieFX9g12+tbYlu
         V6q1f2rNvokjuwhkymy2rgy1hQnllPWr0NmPbcBKuG5ZxZRMWSxeG8ze/qVAD3Kl/6MP
         d2aNWS2FZThMVzhxY5Qth+G3Zj80RwpzhxaWDTCMavLNeUleA41bahYJnWxfuwj1eWcp
         LIU24u1Nzmk3vcc5+G7C5yLXhD4OmcfJEiGr2kZrkIZ4eUNZiptw3HivJ+HN9jquWqtF
         uZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577804; x=1795182604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiCkgNSK5y/MvI+rznjQud7W7zCWMAX8iwhD1RM5p4Y=;
        b=JkPYZrhbFVEdlg8ewYC37HD2M4Ae2+RBJScpB7BpQEtTySKzQcehclqaUVT6woPqLr
         dPEw0cTcfb7H2lhWt6Bptb6wbUjDNHuD7f29v4bx+AfcZuRSxRTR6MHfKbPbkl29Rfg+
         j4H2XU9IzQC49SmjnhJAZU1XvDUsiFQZKP/Z0MXRt3dDi5MIBd69x0LUI4Y+NPpU7iDx
         Ss0BT7De81aydCxPcZEgNoxiIrsno+vOF+jfn0flJR45g31Fr1B4M4dhTR7OO2VHFi6n
         MSmgbLDdw+A5OF6n+YiTDCblzRxJM3QwrDyLRfy8fGBcQS0cH+wNLpF9PwMx88dHQQFb
         XKvw==
X-Gm-Message-State: APuU4Z+YZ3PYXHdvi/cCnxKoJfaQJvIWyXWtSn1MjOQCQ1GVUbZY0uzk
	+2jBwOyWGPFWEEDfgJr0kqz4KLhNbvm3u/GrvgtduBLT063DQ4nZ/2P0PLnqvOeKL5idEBpeXJS
	0tCG7yQ==
X-Received: from pjyw24.prod.google.com ([2002:a17:90a:ea18:b0:3b0:e553:8f2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5604:b0:3a0:a912:e759
 with SMTP id 98e67ed59e1d1-3b1b0a39614mr2469908a91.25.1794577804208; Fri, 13
 Nov 2026 05:50:04 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:48 -0800
In-Reply-To: <20261018115229.315110-1-pablo45154@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018115229.315110-1-pablo45154@gmail.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441764204.75151.9010393350555160808.b4-ty@b4>
Subject: Re: [PATCH] KVM: x86: Initialize the PIO bounce buffer on PIT
 control-port reads
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pablo Azuaje <pablo45154@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Sun, 18 Oct 2026 13:52:29 +0200, Pablo Azuaje wrote:
> pit_ioport_read() bails out for reads of the control word register
> (port 0x43) without writing to the PIO bounce buffer.  The read is
> nevertheless reported as successful, so the guest receives whatever the
> buffer happens to hold -- typically its own bytes from a previous OUT
> or IN on the same port -- as the readback value.
> 
> Real hardware returns undefined data for reads of the control word
> register, so keep KVM's behavior well-defined and predictable: zero the
> bounce buffer before returning.  The read is still reported as
> successful, and returning the guest's own prior IO bytes as a
> pseudo-readback is observable state with no architectural meaning;
> zeroing is the least-surprise choice.  This is also hardening rather
> than a security fix: the leaked bytes belong to the guest itself, never
> to the host.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Initialize the PIO bounce buffer on PIT control-port reads
      https://github.com/kvm-x86/linux/commit/54cb295ef092

--
https://github.com/kvm-x86/linux/tree/next
