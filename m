Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD23749FD
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948377; cv=none; b=aE/LYRV/7n7mz7FF/s7HvyDft1o47AR/VpnW06sqTrRg3LpxFwvMLQx5aShODwYR9qvZYpwf5/HTpJ3ND3TTqaZk57UzWciuaCAlCAD7ezG04AZVsYjHiGT4KmmJQQWcUzs5TJYffZRGSE543JEo8Y3IKQYqQrTNWHR8d072ALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948377; c=relaxed/simple;
	bh=0/wTjwH2AmhnxiB2gEIxJBuTAX2kewLyyK40z9ZmoDU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4G7bvfmd7RS0h/fxi2jng51Qm3diUlsBqfQbxyQlL9BotwdUgETtRO4g4lPmxWFu3Hbq56khV9/0OE3aB6oVU0etWXlDZRulCAxzvPDsdqkL5eu2Jhq8IWkWbe+/KSk5iZMkYqAKN5aUqNjeKmyKU5sKU7dw0Fa9doDE49QUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPL0dmYL; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPL0dmYL"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so1760286a12.3
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948375; x=1786553175; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWq337Ttauiqykl6frHm/i4+dXlccI/8qbJrdOWFnnc=;
        b=hPL0dmYLzsjUDwtIF27pdCJLKVd/Hw0looa8mmdXLq8t7wp8PWEQMVHa7YI2LFsqa+
         DDL+N8ttL5dDmuM8ALv5+9RM7rVXID2HsYHx6w9bGJOEheVPYI7bG/v3lZ9o8JoSwK7l
         GEgGsgKsnYzpaWxAWIhCXLDi5DoXx6JOpHbINsaK70GorO+VTlZhKAwjqoRBZomQvgG1
         RoBFYglxFZhI4IM26LWuu/jjMGXOFTu842Ee2ESlS038juUHmOErSo4dGk/600OgamJ5
         LtTrbFtCQVok7uBU3tZOjuykKfryl8C/kAWFIZPlB9CKDHIGDRWCkRX1/pg6tgpZaKLE
         4c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948375; x=1786553175;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWq337Ttauiqykl6frHm/i4+dXlccI/8qbJrdOWFnnc=;
        b=f+VBlpSWm0S+qzI3RWoJxAbRy8/uNA1zmyR6MgC3PWBJZkU4Iae2gsYERl5c1S810E
         MXZsumDk7Okl0Go7BTncGgXikRkgWafypXkNz80mKYJzneKoZ2opxBp2cXQAaK1QPW2d
         F0x/yolzBL9LvE8DVW2/jI5Vlp+V+UYEYzSpAwmhxHKUndSyB8M/xyqIah+REYvrq2pb
         p/QyIbCBvN3PfBl4MdN6hUJqcgrihRjfM2AAeiV6aVowZmFSTlPisGwcqP80mTx75lLM
         eAdCNyn8KliM2HDZ+JOT8s7XNQjfjPUmgyPXIcZ27kWvj8KptqZaGsDxtTlDiBwfImE2
         S+/g==
X-Forwarded-Encrypted: i=1; AHgh+RoMUErbLCPqengXMpNt+p78FCESiW+wnPKE/ZY8W1lMQSV19PSrpEPLL8Sr6VELZpSLEPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJO/OuUfYm7qs+WHkSsZSO8/CIaD4HPAio7OMQaeDTKe3oVsvh
	7n4dfpirCOUEgd37qU1sCjayo8I9O7Yl9SSD+xJkzddwokXQpUpK05QB1ZpdIhH0dUQ04Ty6ryU
	kfc2UxA==
X-Received: from pgbck1.prod.google.com ([2002:a05:6a02:901:b0:c85:8035:8b21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:398e:b0:3c4:3321:5009
 with SMTP id adf61e73a8af0-3cb85eefa06mr9767805637.29.1785948375260; Wed, 05
 Aug 2026 09:46:15 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:03 -0700
In-Reply-To: <20260729170621.308809-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729170621.308809-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594830648.3638708.496651964153873489.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: VMX: Fix IPIv use-after-free + improve
 checking duplicate vcpu_id
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Dmytro Maluka <dmaluka@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Naveen N Rao <naveen@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vineeth Pillai <vineeth@bitbyteword.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>, 
	Aashish Sharma <aashish@aashishsharma.net>, Grzegorz Jaszczyk <jaszczyk@chromium.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 29 Jul 2026 17:06:19 +0000, Dmytro Maluka wrote:
> vCPU creation in kvm_vm_ioctl_create_vcpu() may fail after
> kvm_arch_vcpu_create() -> vmx_vcpu_create() already succeeded. In such
> case kvm_vm_ioctl_create_vcpu() destroys the newly created vCPU in the
> failure path. However, that leaves a side effect: the IPIv pid_table
> entry remains configured with this vCPU's pi_desc address. As a result,
> when another vCPU sends an IPI to the APIC ID of this failed-to-create
> vCPU, it will cause HW to write to this (freed!) pi_desc memory.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/2] KVM: Check for duplicate vcpu_id as early as possible
      https://github.com/kvm-x86/linux/commit/97d65b544f48
[2/2] KVM: VMX: Fix stale PID-pointer table entry left after vCPU free
      https://github.com/kvm-x86/linux/commit/b41f2ca6c060

--
https://github.com/kvm-x86/linux/tree/next
