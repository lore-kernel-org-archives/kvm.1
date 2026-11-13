Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577950;
	b=siFzfQlHG8+lJWwlIjDlpwJoqlzO6pQhh8d2PsvBqYXjDHApwvkNnGVBZVKR+pM59XEg
	 1GP2nyZ+84rfFkQ6xWNOY66uJy7T3NuB5rH+aAoiNZ5uPG058Xn5fNkJ9dsHkhwj/8jRb
	 GiPCfqpWSU3YMK+hxM+OcMmSNtDcQ9vcaNrOoYKJXoTrNkUJsofz2SuAilyu7Nr9UHqLU
	 pdwrxkV8ALuxTZKeKe36V6rf1M9vhzFgUuh7x6ICfKeIupcaA3NW0f9iAzV+msron/s7V
	 jxUaXJPeEYCQ/hfRMIaISlK84CZJd/iqgu5DKK+5SJQipatn5tmcIz88vuNH3BAA7gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xtZVoHEKjEslNffaWu4f1H6eNQjIy/ggQUU7slMQKbg=;
	b=Tw/VQi0zk3BMSJ5KMj2IAY+xjkOSRmpwvbK68m7F0fSGv3lpF1Jc2vvp/JVtMv+F1Sh4
	 BleuzYbT9Gsg9fVEtM7ywczFtIeTR6d34MLNypqQCf7SMoFR19320rqKb6RwfOJYjyROz
	 3e3bfctP7gzmtpGB3CGu3yOqCg3s43H4eoSIv3lmrNrxVOW6NqLFYkgNaobwKYE89Vco6
	 f87EKzH99bHmEO9HZw0AAAgowfB7kzkY0vpwfzv1ch2cPe1eSdw2Qu43mRvzkvJTurxDx
	 O7Cp9aVvrSXellKJHoD/ToVgwR78N0vgYgaz66TbC3EgFVo5cdnJbfVHkiVGpVY7hKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cARDeU5p;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E433606A8B8
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E433606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cARDeU5p
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b191f8a9b3so1437772a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577949; x=1795182749; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtZVoHEKjEslNffaWu4f1H6eNQjIy/ggQUU7slMQKbg=;
        b=cARDeU5pPDR0f1GuGIRmOidvzxc+RWryLR2z5+yoXbGKJ8jqdQ4HhCiKy2XsYrAPAd
         BOFgI/aoKvqUhh1NkF9UGwiHSCej5AcTpo/oiWyRiGzqekjGqsmMlacKYXC+Rmuyz9l9
         BNwgYVy/9+ohY5lvsJf18fzwH72vjgcoOmNKHmkv9zGd+N/iVQRvf78AO9pu+C98nMwJ
         Sj+4X3NXY1q06CyDoWrGh6Ql8UjF/XVTRDe8uyYcU761Qh1izkVDXP4doKKfjzeLtf4c
         KTHwO+H3U//rgkl7UJ6eXDdqZfRRVGvj+zA8R57zBBengjD/tD1wRXKJutXtZMw0UPUB
         ugMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577949; x=1795182749;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtZVoHEKjEslNffaWu4f1H6eNQjIy/ggQUU7slMQKbg=;
        b=WN7ypSk7HmigjaYAu7UDdcf9xK2GXlp8HhPF/534cdXz/YsFjw3IVaVr4ojBdVq155
         DX7Hghf87uUmxMcTFl2S4HiaFAm4Znt8jCybrNPddBGZL/R9IhI7o9qOnvVFSP+BfySH
         RQGW2PhophhOJfM/yp8kOM6nlVu37QcnZCel1t/UBgJbKC89OkxWT+zIqEqS26zV8bC6
         tRpk7aenWeeA2Fnl4+02kG6D0WuMXQt4ErO+OSh7uCwcd8e+ykFT7l16i3oxhcyj9dkF
         VoIg5LjDMieCxTUElDiNohoVKayRDKTOytSVyJQwZOsbTQn3c97byuZOPgUaquFt1Jtg
         qkZw==
X-Gm-Message-State: APuU4Z8e/6iajRpFKdiDM1Iy01Q8u9IgOA1VOm+CBMLqS6qUmFdu4jBS
	q6WbNxrxhLj40SVYCAeA0sgTyhTYF2Ia0+1ZrjIQz5vzEr6BylJINqZH0AXEcahbagy+JJT34SN
	i4jooyw==
X-Received: from pgdo15-n2.prod.google.com ([2002:a05:6a02:620f:20b0:cdd:bfcd:be0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2590:b0:3a4:bd4e:6d15
 with SMTP id 98e67ed59e1d1-3b1b0a1080dmr2150084a91.34.1794577948910; Fri, 13
 Nov 2026 05:52:28 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:31 -0800
In-Reply-To: <20261022190530.541789-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022190530.541789-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441774252.75937.12953036689423091599.b4-ty@b4>
Subject: Re: [PATCH 0/2] KVM: VMX: Clear vmx->fail on exit to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot@google.com
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 12:05:28 -0700, Sean Christopherson wrote:
> Clear vmx->fail before exiting to userspace to report a failed VM-Entry to
> fix a splat triggered by syzkaller where the stale vmx->fail confuses the
> force nested VM-Exit flow.  Found on a Google-internal kernel, but the
> reproducer (will attach) works on upstream (but only on CPUs without CET,
> because it generates a VM-Fail by injecting #UD with an error code).
> 
> Sean Christopherson (2):
>   KVM: VMX: Clear vmx->fail before exiting to userspace on failed
>     VM-Enter
>   KVM: VMX: Dedup VM-Enter error handling for VM-Fail and VM-Exit
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: VMX: Clear vmx->fail before exiting to userspace on failed VM-Enter
      https://github.com/kvm-x86/linux/commit/40c0e9dd6b6d
[2/2] KVM: VMX: Dedup VM-Enter error handling for VM-Fail and VM-Exit
      https://github.com/kvm-x86/linux/commit/df070e4616e7

--
https://github.com/kvm-x86/linux/tree/next
