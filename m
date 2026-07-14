Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4D433039
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057382; cv=none; b=PVUzDhpY1Vw9bv58ZrrC8A6a1+UGy8m5UMb0TbEQiiwcUAv54QDD/oC7MJ3WBDQ7yIWoQG2rpl4+0lF5P8XHDBsLMJTVhHkCQDukkdduOiIYbJKjuRSlhLhOwvd62/3UbMvc4fMmCAzzuQRAT2rFRR6ZGBnCbgJo7lPagQJQd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057382; c=relaxed/simple;
	bh=RsnXh/8ElTU9qZWcoJsFdKmUAqmosiGYht2P9+CIDyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KvKOdfkoTVkZ086gSgXIrclei1zil4Px6feaMu16UeNY2q3QQwHVxl05pCxyctq5FAbAsjWLZX0ezh0TSOjmHEYR6lNav3q7acGg/+PRCZosZXh8QEce2t2hJ0bebr4o5GHBGpDd9eHf3mlL1XGaMNqmyhx+JlA0PVjeqCloOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXjx8g5S; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXjx8g5S"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so8150928b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057380; x=1784662180; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ri6PQl08QpvRXhW+zMfxC/oHXbkP2yHQ6ED8yzvPbFs=;
        b=BXjx8g5SdZOfKu/+JuU9FFVXlYvAb38SrG6o7sR+JRScE3QNzntZ/64h4X2EgUuoVW
         0hdgUrbdh9GjH10y84+h50m/AZjooGvJmsvVKOX9xG7ay4AKjcyWRreYb7YGgiNtfJAN
         nKbnk4cxPBDGSlfeVoqiuxAdGjqN1/Yi33CpPBoFMisbKgRdHwYi79qquLV10FCw2w/O
         zFhP6wU4JgkRiowOEhbGNWYl3xFBmvvf96oB9/5TYC+WnP9OJebhJ8U/mjBNuaYy4ALH
         J2QuD7G2KMuE13TPawUgYE3DXr10++8kRQcIUFnpAm9FLQY+cpFHCgly20f/u3CyHALL
         4a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057380; x=1784662180;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ri6PQl08QpvRXhW+zMfxC/oHXbkP2yHQ6ED8yzvPbFs=;
        b=SzgfdMRasQN+GvwrTyyAN+Lh2krCZC+cNxPlM5jBUohZlhDT51Z93epS5HBcdCNNj+
         tMXKjNJTg6COs+KR6xpcx83qV+qE5FvJs7p5LtGShxiigWHEIYW7TyZ7PC/hdHpt7Mv6
         dESpSPxq2dsohTLGtbnmaW4/lX13Q/Erim45HsexpNhuOYtyceXUcHuhyjeRibM/cmbj
         06owyMzd10bvF08JmQN2JWb3OsK8wwadUpENY22hAEaDJk9IpfWtpemYKq8MYyclNksT
         fGIroL42LwbKDchdne3Bk8x8+F229S3VyLQ9fHkFA7l12KjA91YnNvG8k8jmK+Yp8Mts
         yhLA==
X-Gm-Message-State: AOJu0Yyc2EY431vfzLhskx+F48CKaQcYX45tTDIP8KHoC5WVRUjE1rmu
	k6wBgCVHOfVauQpn86efG781yGVEv/kZELTzfGmxS+N2eWu2yMFZPL0A2XCRWY9tPaKp6g6Tyrr
	VGtvKHA==
X-Received: from pfbdi5.prod.google.com ([2002:a05:6a00:4805:b0:848:4690:d658])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a117:b0:848:47d3:47ec
 with SMTP id d2e1a72fcca58-8488967d5cemr13427366b3a.31.1784057379715; Tue, 14
 Jul 2026 12:29:39 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:27 -0700
In-Reply-To: <20260630202828.440724-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630202828.440724-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405258631.3111985.13515439003620338114.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: x86: Convert nested ops to static calls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Jun 2026 13:28:25 -0700, Sean Christopherson wrote:
> Convert nested_ops to use static calls, mainly because the nested ops are
> bizarrely different than the x86 and PMU ops, and the kvm_x86_ops.nested_ops->
> code is an eyesore (IMO).  I haven't bothered to do any performance testing.
> 
> v2: In patch 1, keep the get_evmcs_version != NULL check in kvm_get_hv_cpuid(),
>     then convert it to a RET0 call in patch 2. [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
      https://github.com/kvm-x86/linux/commit/b65699be2c60
[2/3] KVM: x86: Add static calls for nested virtualization ops
      https://github.com/kvm-x86/linux/commit/4b9819a50674
[3/3] KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_ops
      https://github.com/kvm-x86/linux/commit/2c56780d8ec7

--
https://github.com/kvm-x86/linux/tree/next
