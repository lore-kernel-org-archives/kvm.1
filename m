Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718A375F65
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948689; cv=none; b=LIVuv7mlJ24dX3k7uGuH1nq0wWvNJdsjrT3+tE/hAVHlGZQJC1hGFAw4u3PdLLt/b9yT52/1giXBtml7ecvpOqOK5oxvYatdhBKTZeT1q46YKwfGdsrjydtdQPvLIJPuikinzVC13mmHZWg5AGNjx+GnyLVE2SYnSYMwo2U9l+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948689; c=relaxed/simple;
	bh=3wmlrhJUKL6EhS0ne4XFeRyZ33OKxpmaz/dhIRPgJ+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZShHlKl4yQdKxWCOjJj+NwRwZe2Qz3nMQLrK1R2078mL116rSwMMb87P/DHmVmcgoMd01oK0NebXLv1foPkbWsVNfIenH2uvmA0lSVDe+4U5NIEth8+ijJc5va28RlHTTNnbcdjzLsEpKX8T71HKIUO++GuWfm1Wz69xpsytsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AE+qAM7+; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AE+qAM7+"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca3673560so20141735ad.1
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948688; x=1786553488; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVnrfJm7EoHuoFBhCKNWdgDrVVFTTHwSGJlRk3/uOK8=;
        b=AE+qAM7+q1FwSNhHxTB28L7+vsxCWPyyWMJmqTHQZzrlgwE/xRlBOdfeVkpYoqStkK
         ake+ZiivHiqO2S6SD/B4Eoj3kQQqsdDYRAm+lUDixWbY365o4qm04p06pCkSYhkSLYg3
         pVtQRtDgbHS8yUdMNrpmTOVhXa5DA0WKSeGfT+XzJW1W7rSomI7u+Fbx2cezhMezzz3F
         RXzn+u1kAq1owgeWvayaodSIKCesVj/7WDpSPly2FJ8BiG4LTPHmzHudbQC9CjSeHt/d
         ti/cpudH3WqXN+NmvwYk/cvvvEnyQeyhRLEUGSs8bGd1IBikUB+GD9zVVxSCwA7z/+gl
         i6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948688; x=1786553488;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVnrfJm7EoHuoFBhCKNWdgDrVVFTTHwSGJlRk3/uOK8=;
        b=MvZ+qpg7HIK8JKvZv9Gg6Sy+Onl8PO1VjVQ/OPeXtaEbLovdsYB6DTOrd1J/TG6NFH
         Wt6VKh9TuFJgERRjbYE1foD4cLMEYAuHEGNJCghVniK/uNjYZgZH+mRpg+1QjMcmGLS5
         gIL9BGeCcy8rI6+UzM6ueycw6JRA077vQtG3uJ+WLJHAwwjDJ09r5VqucjylSNo0ywVu
         2nwJeTCDb1j94vFk0dqL1tF8lqqr1Rk5kAS2JBs1t1+iZILCYsSmQuI0Pjo//xAzx8+b
         KGiCLpWk8GplKGFBjLq/Atk3wtPbBtOeoTClR7QwYWH6wILMzBHHgASsNlC1P9OAQBeN
         Qz/w==
X-Gm-Message-State: AOJu0YwStZb7aq7fN8+fG68ofvorXrjK4Q7lIKHK8EnmaY92luq3CQCP
	UrYZSk36VE2Ry0YBIFHfA26xxJ1PeuycqbByHzf+eLZmhYPcO2txrvx+0gvyAc0MfUJ3Ibw3YUl
	Q7uTchA==
X-Received: from plca7.prod.google.com ([2002:a17:903:4687:b0:2cc:8e87:df3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea01:b0:2c9:bf82:dd11
 with SMTP id d9443c01a7336-2d0ca71b505mr86980745ad.7.1785948687909; Wed, 05
 Aug 2026 09:51:27 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:07 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594831856.3638910.14093695347939556302.b4-ty@google.com>
Subject: Re: [PATCH v5 0/6] KVM: nVMX: Synthesize SHUTDOWN on RSM with bad state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 31 Jul 2026 10:33:34 -0700, Sean Christopherson wrote:
> Synthesize SHUTDOWN if invalid guest state is detected a RSM, i.e. if SMRAM
> is clobbered by L1 (or host userspace) while handling an SMI that occurred
> while L2 was active.  This fixes yet another case of syzkaller tripping KVM's
> sanity check that KVM doesn't cancel a pending nested VM-Enter.
> 
> v5:
>  - Fix goofs in patch 1. [Sashiko]
>  - Print out correct target L1 vs. L2. [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/6] KVM: x86: Extract VMX's unhandleable emulation check to common x86
      https://github.com/kvm-x86/linux/commit/a40764607eab
[2/6] KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
      https://github.com/kvm-x86/linux/commit/281a4e5f1086
[3/6] KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initialization()
      https://github.com/kvm-x86/linux/commit/9fd7a4433d74
[4/6] KVM: selftests: Use port 0x80 in invalid nVMX guest state test
      https://github.com/kvm-x86/linux/commit/6fc510e1f101
[5/6] KVM: selftests: Refactor invalid nVMX state test to prepare for RSM testcase
      https://github.com/kvm-x86/linux/commit/2cb49770e28f
[6/6] KVM: selftests: Extend the invalid nVMX guest state test to cover RSM
      https://github.com/kvm-x86/linux/commit/bc44a9ce73cd

--
https://github.com/kvm-x86/linux/tree/next
