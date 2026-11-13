Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577942;
	b=N6iKemQ62oQbjeqJamS+I2PBqzhy2782sYluRDvd7uOhOLUM5NkL8Isu3PEOF2NGJqvm
	 iS4+Lia0pijmjY8cwn+q1uBUPNRafjpc0wjyu1riBindQJspE/059Fnk6iRS/nsuDFiw/
	 T+z8HIhdPbauNGDQ0at2xJO7KsqU9GfrUzScCm4+GUCF3m91Pa6GfIBVWFvoOKGLktC+Q
	 oS6oEg48NeFFR3MjkudlJNtswXN1g0dlfRUUSfcf0dC6VORSGkSR/tQAuUl12ktwCDgef
	 hpKfR9BBFt8yvF5P++k4+/inOzLY+zRcQtpVBtFNdEi6/b3f1mrtgPNg2iX51DM4P/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=kHPOfs/L363vqa6CrVL16iEyvKA0LeMf5+EsKjiFVpI=;
	b=l4B796M5TfzLZ77YqM0FBty20Sfi5R7WwPMruC7v6u3sPYyeAEmiFL+1Pc5s5WePR/a8
	 Gai92lKT8fDWlNRzBHeIpx2N9arKdQone8obo9/FEL3piG1zxKMLoBl8/U71wk8JKZhfS
	 pmkH/yDhSk9JWu6GEofgW+URf4WRuLSm4T57lPtG7mQWiIc27RcCb/VKWYDTLU6uiH77s
	 Erp0vh8BOIqi0TOWMKavraIP/fwVZLjfZxR3At6gJsJrrtq83hqWn1GLWqbheIJ5ZpQ1z
	 23Q6ucXMTaP+kbXJrxAP1Jn7/ZzRSKtO9kErl0sPg2XweZQaxmg2VzTMFnUZ7RXAedQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jS0O4uel;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B460A6F46
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207B460A6F46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jS0O4uel
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so1173044a12.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577941; x=1795182741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHPOfs/L363vqa6CrVL16iEyvKA0LeMf5+EsKjiFVpI=;
        b=jS0O4uelsvAO6nmqCOnanNqzDBM46UItg1xdlm1CFDIf40vwHX+ueSyt9R0pogbZpu
         SlOcM/iBz5NwVIH1G7XZu9yg8XMKbcc3Sl8JGVud9lbOXsfqJzvgnFvSCFyO/vhFKgzm
         jNcCz1rUAuRgaX7T3N1bJC3CvUOel8M5nbr19uyLbFXCKzEivkfnSP1ei6xW47xCSYW2
         NCTvdYvj6U6rnlSruatJ06bYqVEpjE2riY1q8EfxDYCnq/x740mFGACstE4Odfgvt9o2
         g4lij6euYhj5kVgyREVaThLT3BuAYc5gKD3WBCNLLQmXk0p2rKm587BAqjr7RvMubKk4
         /Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577941; x=1795182741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHPOfs/L363vqa6CrVL16iEyvKA0LeMf5+EsKjiFVpI=;
        b=GKx5k89TM6YIw0kWFgprXsPtbN4hbUfHEQUJu0Cqcjb/OObDlowRGxdh/8O3YfY9C9
         r0hENw3lX4QtoWKwfgBK4NeRsO/UTcMsgueGrukg24ekiEFWf9inPchkh/bgNUb70Y3h
         EYgBkky6qLIFK9NSOyMIA4tk0OdCSMQNkcItxozFiYn5mZzERmbqIDrz9eJWayGRQ1yv
         CvWWY5kvGn1Ah3bzfa0YzTRnjR7JxZlPvw14a+2OYfoUGqWFkqMmlnzrD/4ocpNa0h66
         XewsBE/G4d8psxbm7MoIrLvxLUOtrKIGvBZMvfCiVjwoAdVAAlqHsAy5MQpQxPU65i2d
         ZdJw==
X-Gm-Message-State: APuU4Z9StNJKWu/2RhaaZ0jfCCzf00DaI4VVSqo6ECrlow5mI1/LjA97
	rt2GxjcYNiSHGulaI4GF1EEDcq8s2FZIV4ohrPXiVgkA2IdEXe6cDp+iLMmZe72ut+TQ/gQ9nFE
	K2i9pKQ==
X-Received: from pffl16-n1.prod.google.com ([2002:a05:6a00:c350:10b0:89d:1266:bfeb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:66c4:b0:3e2:a9cc:3ece
 with SMTP id adf61e73a8af0-3f7a74c34bfmr2400043637.23.1794577941323; Fri, 13
 Nov 2026 05:52:21 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:29 -0800
In-Reply-To: <20261022021820.298886-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022021820.298886-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441769063.75534.3196433143946646699.b4-ty@b4>
Subject: Re: [PATCH 0/2] KVM: nVMX: Fix a (benign) overwrite to a userspace buffer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 21 Oct 2026 19:18:18 -0700, Sean Christopherson wrote:
> Fix a bug where KVM writes more bytes for KVM_GET_NESTED_STATE than it reports
> in the output size if L1 is active and has a valid shadow VMCS pointer.  The
> bug is all but guaranteed to be benign in practice, as all VMMs I could find
> that support nested virtualization just preallocate the max buffer size.
> 
> Sean Christopherson (2):
>   KVM: nVMX: Save shadow VMCS when getting nested state iff L2 is active
>   KVM: selftests: Add regression test for KVM writing but not reporting
>     vmcs12
> 
> [...]

Applied patch 1 to kvm-x86 vmx, I'll follow-up on the selftest.

[1/2] KVM: nVMX: Save shadow VMCS when getting nested state iff L2 is active
      https://github.com/kvm-x86/linux/commit/0333e967fb05

--
https://github.com/kvm-x86/linux/tree/next
