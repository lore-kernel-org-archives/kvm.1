Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577872;
	b=GLrqGpJ2qEVfkLcSk4GBhdsVz4WBcLd6YnK8Odr9Xpum25ee5VA8xPeXFohwqzcHL2n7
	 nouWg97Xf1qFs09p9oa+nqZ3qcxSJduCWYanu8J6sJ7EQutqeMZX9LDeafSUSBhLyR+Dh
	 oQ1nbeWNn2LLUHV+55hKCe4+L/0dhog1I3RgTYl3mMN0RhpS6P02rGGXeMPFdIkyG33Xn
	 FNiERZWL5D7j3UE/TRMloGKpDlJq4AOUINTroOotZbFuSrBBv9vnM5QlPWQqDCzJ1CyfS
	 RpW7F6IojFbBjPx1zTOyZILqfHOieSX1bAE0ghhg5rkjb977scOPmil354EA//uyYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=e7yA3YWoAnnKTfnIvqWXC9kbQySfcwLKR4KGL8avuCM=;
	b=qKK3ksTEM6mTld+xzofmAn4C0+tltUDATcBCLd+sYSadTXHBthQb4NGPodIbz1mmLNjW
	 E4c9sVEuNRwbtupxDRSHQA/L6QdyD28HL/sz+Q/dt7NsChV+2BdZF8PBU5a68MLIyKd3C
	 hCZRfnZjOeKE1b84X/mnqaM8fxgwp+6mfs0vJgFrkBkWj/4x74gMlxu9GYZkCCEKe+Gm3
	 Lc8903CjrH96JLzGrK+Q1pz9ph1Fg25hEhpurRy79Mv3w4nHuDFduqfHnAhYkfzN+QJNE
	 hf7yBtOWM6jkQkz/bg2CLJPsiSyjuCrh+hc/xsvFChfwVFRfcy1nP8vvNEIk0xBH6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6FL9RFe;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE460A3827
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AE460A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f6FL9RFe
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso584716a12.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577872; x=1795182672; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7yA3YWoAnnKTfnIvqWXC9kbQySfcwLKR4KGL8avuCM=;
        b=f6FL9RFe9dT5BTTHOxUtFUHctuKpRMPCjvr59NaB2celnu9uvuowEEMYsXUnDFkxmz
         F780pnluzhvn/Ufb04pZmVsAIAsbVi2yDNhhk0VT4fCBsBSU6IWsk5tAp5QhlDG5FoiO
         M9geHwQEGdslbJHpDQX+9FNKegbqmb3UiYa9ZIbYLsjDcbeQdKSbnuhsCPyNotH6/NHA
         GlOefFoaqpARmbRCk8JFLzazJcYPy/7irScXbRXekOmBAqUcKTZIscfgkKkOQxc0QPrE
         TIpZ4FGZTfiEuipZnTSXNoP4tAB6cKf/stTe6ttxHey0pOGXA7EXM/deyP5PXJLH1Ekz
         vgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577872; x=1795182672;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7yA3YWoAnnKTfnIvqWXC9kbQySfcwLKR4KGL8avuCM=;
        b=jMk7DSCkr7pXIfOCRnB4Dpzk7tvz/U33ydE70rhjAQaEv07W/Rwr5J48xOMwUVPYtF
         VAZ2f52i02t8xfIi2QbDSbKLdIyiVHKksy5H1YOTdrcejP8858eh60QhYTMhNOlOufnG
         1J62A8PP07XtC81SSoSK//vW+vLYRgHVghr5aW5ci8KmYQmdWq3Cb9dNJJQTDB0T51hs
         0JCZVmQgUTizpsi7FRdVfqVlh9jeOiv3xZJgfiNs2mxPXLYIb51DaNsZUyApR31xF2oW
         srP1vQM7wU+o0kDSCAkhgnt4VMJxJBoUP8VckgupTFkkGu1lnFh7x3D0cCU3ZEb23AGq
         2PKw==
X-Gm-Message-State: APuU4Z+HMKuM38kgCUA8/3BM8x13DucviQmljc5TlgMXLdk0ECKu7nkI
	L4IKmw8+qCZ/WMzmda5aeFkph3w8eR2F8kWy8SGBXTsOA5UZ8q2UG5FdgRg7+vP75d/tP0HmEo7
	xQ502JA==
X-Received: from pglf35.prod.google.com ([2002:a63:1023:0:b0:cd6:23e7:ad7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7e0c:b0:3eb:7346:7662
 with SMTP id adf61e73a8af0-3f7a85d9db6mr1963054637.64.1794577871573; Fri, 13
 Nov 2026 05:51:11 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:08 -0800
In-Reply-To: <20261110203330.11789-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110203330.11789-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441798938.78395.321265981492593275.b4-ty@b4>
Subject: Re: [PATCH] KVM: selftests: Override memmove() to prevent "magic"
 references to memcpy()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Nov 2026 12:33:30 -0800, Sean Christopherson wrote:
> Override memmove() along with the other string operations to prevent the
> compiler from generating a reference to the built-in memcpy() when using
> musl as the libc with a static build, which utlimately results in an error
> during linking due to a duplicate memcpy symbol:
> 
>   ld.lld: error: duplicate symbol: memcpy
>   >>> defined at string_override.c:23 (lib/string_override.c:23)
>   >>>            $BUILD/build/selftests/c/lib/string_override.o:(memcpy)
>   >>> defined at memcpy.lo:(.text+0x0) in archive $BUILD/build/musl/lib/libc.a
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
>   make: *** [Makefile.kvm:382: $BUILD/build/selftests/c/demand_paging_test] Error 1
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Override memmove() to prevent "magic" references to memcpy()
      https://github.com/kvm-x86/linux/commit/5a588219fe45

--
https://github.com/kvm-x86/linux/tree/next
