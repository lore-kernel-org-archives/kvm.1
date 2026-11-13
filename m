Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577683;
	b=Z5f45q7eKNxT3Chr3ou5xScsz58VdF/POK7+1TIi44bFDglAWCIpUKfRrgh5RSn9TQsZ
	 /bu57Zk+qCmo3uTfb5wZmrfcGgvmnuHs0/8phv1PRu2FOg9IOu6CgQxIWFDO006+fYquY
	 y7vq/D18VHlxv4lv3ns8PcuqqJ3YdQIcFtDIrTz/dNob3R4zArRWGoOTVcZnhFmlaJ629
	 xhph0qzeozzBJfEa0DBVSmYfW/2ImpcrbjRYx5vJROi76kYq7ncqLFp+m+YgVUnSBUMH1
	 RrIxDgNVppDhm4viN4+HcnTkc4MV6sv4UNbW2Cics9I3qSkfClK5wcmcEHahggNt+eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+Rep6yIuauYWXDcGLLrmPhle1wn1pHduGsJ/4dgXiJs=;
	b=J2LuOiPsx8FDPsVEMHtfAi/F9RV8BlNm87RmLsrGh3tncUc9Yi1gPocE21V+lZkmjM8N
	 x2cIDFeuRaK4EtmmVp0/pcrZV1vAdc7Rld1+HafauM67EVoGHTwFeuVa0UdTH82tFwdEs
	 PgqR5ZxN33bnFbkgt13TDKQ2NEUjyoHZiGmsvyEdeKF7T1+uAL7N++30hBNO9hGWbXxUT
	 mk3WZ8SDFW13m8nKNjWvyRkLDN7RpyRqugTs8FidH/05VJUCXZCjUA91+17usmVX7fDP5
	 CBLnMBg5+Ei6YeZKjAH4/iTefzlWU/XKGZALtXLgJQjD/bMVa3JzLaHk0iIaeDgbN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NlK2UyD3;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D8606A335
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19D8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NlK2UyD3
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea381ce04fso14627255ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577682; x=1795182482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Rep6yIuauYWXDcGLLrmPhle1wn1pHduGsJ/4dgXiJs=;
        b=NlK2UyD3BaewUX0aHskWZVJ+iyQWJvrvZCYIC65FoWE5ZV0MZdqX4x8H/lv0arEk+q
         /TvkTGDmtkuveaFAasI60NEWVXEp0emvVXNBjSCZ3BsWqC4rjNAbUASEzGR7hSzRRncO
         68vnDo6RwflrmO6cI+qo4vwG6TGLF/y3bNqk2wL/UhFhPYi97/5lpN7vN1qs5ksk0Nsb
         qUsUekER8Zr6taEvK+g9ToJT8P0vTjzS1A1xsRfXkBQUdGGgF4kziCfewb4/fLEVe4xY
         cUHkKsHdmt7WotRLYChy2xv6EN3lK7DGOyhi6XkISo23tCKyiY+v2+2vylX1C6i6dlVv
         YJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577682; x=1795182482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Rep6yIuauYWXDcGLLrmPhle1wn1pHduGsJ/4dgXiJs=;
        b=xeRn5WBN2SzOmz4Ig76gSyZM1vvMAe9wztFrMRe6Bo88ctpI5lsnLwlZ5q9SsFvhFp
         pDqJ/gVdEQ5I3R6TZBaNmq7N+gCHwywuVgAi95Dmpb6pvM3b49DchooY5YHmw+WYjFaD
         hywbA3f5DB0HXoe8V3QniaVythHaobOGaaIWsbmCkaDTa2Wi808KhhtPr8ogiSQtqjbi
         iqrs3mwabcA0kuE3RMQS7uaQTDUJEoiZGS7h02M6SPPTY4/I+7tUEuIlRssHUovi0KHR
         qK3vH7PbWK9j+rEnlgTdOtYFij8sJBlXMb3+4X4UpZIua+w8qcRzvSJN08hHmVzlmVnF
         2ocw==
X-Gm-Message-State: APuU4Z8Gf/Ey0R9oqqrhCUZk/bOw0XNhV1dGc9Cwq57fOKBQn9t0GxfF
	XEBxj05f3g32jWj/JK90VjRxP9rDUrfkvKgg9Va16d05W1nlTvL6JorrPhqrCK0sL1F1ltDGL4h
	z20lCWw==
X-Received: from plfp5.prod.google.com ([2002:a17:902:e745:b0:2ed:b76a:1234])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:324c:b0:2e5:1069:fc11
 with SMTP id d9443c01a7336-2edf16306ffmr39054035ad.1.1794577681821; Fri, 13
 Nov 2026 05:48:01 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:20 -0800
In-Reply-To: <20261022192908.554376-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022192908.554376-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441774942.76067.1957792443574511418.b4-ty@b4>
Subject: Re: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode when freeing
 nested state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Karthikeyan Bhargavan <karthik@cryspen.com>, Chris Mason <mason@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Oct 2026 12:29:08 -0700, Sean Christopherson wrote:
> If an SMI arrives while L2 is active, vmx_enter_smm() forces a VM-Exit
> to L1, and records in nested.smm.guest_mode that RSM has to re-enter L2
> and in nested.smm.vmxon that the vCPU was post-VMXON.  free_nested()
> clears the latter, but not the former.
> 
> Userspace can get KVM to free the nested state while the vCPU is in SMM,
> with KVM_SET_NESTED_STATE, e.g. with no VMXON region to say that the
> vCPU isn't in VMX operation, or by flipping the SMM flag back and forth
> with KVM_SET_VCPU_EVENTS.  When the guest then executes RSM,
> vmx_leave_smm() tries to re-enter L2 even though there is no vmcs12 any
> more, and nested_vmx_check_restored_vmcs12() dereferences the NULL
> nested.cached_vmcs12.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: nVMX: Clear nested.smm.guest_mode when freeing nested state
      https://github.com/kvm-x86/linux/commit/809f39842c17

--
https://github.com/kvm-x86/linux/tree/next
