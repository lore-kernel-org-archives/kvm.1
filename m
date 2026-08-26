Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB123C3F48
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787570; cv=none; b=UMG+T9hOoYtTTOX+WiEGaZO7mGE1ScL5+YW3WleyYzFgXmtutzfjyix1OkdXRXKxdGmsIWuGvHcslV6Ml77Flv3W2rIpeCkdVEkK1s0Ojia6FwrjFwyz1/QGplCWfUUh1qCtTUXjZP8H6QJgFDWzPfpP/6MVv82IgcdI24EAbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787570; c=relaxed/simple;
	bh=T2cASy/A5gmcwzlkeCr8k/+0qt1+e/cVRhWTFQSgJ94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPkSQwD83UcQGei1dl3bHB6Q6IqaA4uFfxECEv1NTSf2vDcLriQuKkxMBPqxhNOKvP4M4V9iKr0XvuJ2whIA9VcgtKIFReE5x+L0ohQORZzXrSlsf+mt5YKMpOZ9ECGKa1UCh0EKw8MNpdeWUh0xfzemDU3/vRHlK9kS6Z5Gzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsovOSfR; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsovOSfR"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e1da97175so2135655b3a.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787565; x=1788392365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AWa0fIdmVto+y2WP+GJGN8aDkmGU1CjNONs+72349AE=;
        b=JsovOSfRR6SVRX/2WRCMEBCk/mIAPIGH88bjX2Fmpan13tEZGMDAGKCOeCYkTOT6Mz
         VqBLUxkHDwgD0mjRK2Swwlts+yr8EUqRJVrPrcG9PPyX2ZznrgeyjXEe/5PS83Kmi5yV
         K5oAILCwxoW+EIG0n4EC7+5q/8OOuptXEjJlhlxpKRAm3rojRfpUP6Yj42PkVenw2fT/
         8e7e4rEfFvGQStrFbWcbkDvqoy3MqkQBZNPALb4bEgaW+uC61BHavO7/V5QtjWCV/51J
         yI9vnOsyM7e8dI+lhP2ez9qESbZ42U4trfdCa+L6V/F0uyb9LRJY3sKFPIJeFdqfw54b
         1yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787565; x=1788392365;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AWa0fIdmVto+y2WP+GJGN8aDkmGU1CjNONs+72349AE=;
        b=Yx5QxcLcTHvIh49Tp39SWaMJJ4GQWoVfB3oGoe95RtR7wCdpFfalgjHj9NnIdOtEH6
         nAUsfqLCxOP7KGoje7bS3GfEDYCEQL38Puww2xpZliP9DyMAD+f3r9iI/LCalYesPbvy
         LpZfgMr03mvlM114WbXuY19TICcEkCmPSDNiVceGbqVQZFiS2IXJ4vN54FSUXt4PlIzx
         IXcmCbFsybNsGo5jc6f8vQFk2fvuuRFJAgDGqNrrxQhsI6D/zbtHv+Tt40q+LfFJ/5cp
         3bEQQ1uMAym8I9gywmNZQ4nHwLXu+FT/NhiyFV0IXDXzzKLvRynZROduK/obsCP731QW
         kZaQ==
X-Gm-Message-State: AFuF++k8RzbESWCXKYYhYyr6WG4UA/WRAdorYiCR5PbmSp7t/TwxaAXR
	riuiB7uB7+pldD7zER6wXRuCU9R285S6arhwVu9EwEIYY2F+OW7+Ke5WAvMxsgIEUjYu8+RxQ1z
	DVw/TIg==
X-Received: from pgkp18.prod.google.com ([2002:a63:f452:0:b0:c92:11a5:bbce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da3:b0:84f:5cd7:e3c6
 with SMTP id d2e1a72fcca58-853721a6aecmr16693779b3a.5.1787787564303; Wed, 26
 Aug 2026 16:39:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:09 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-4-seanjc@google.com>
Subject: [PATCH v3 03/13] KVM: selftests: Don't clobber RFLAGS in happy path
 of __KVM_ASM_SAFE()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use a straight MOV instead of an XOR to zero R9 in the non-faulting path of
__KVM_ASM_SAFE() so as not to clobber RFLAGS.  XOR generates smaller code,
but optimizing performance by minimizing the code footprint is just about
the last thing that KVM selftests care about.

The bug is relatively benign in the current code base, e.g. it marginally
degrades the coverage in the fastops test, but otherwise does no harm.  But
the bug will become actively problematic if/when the "safe assembly" macros
are used for instructions that communicate results via RFLAGS, e.g. for VMX
instructions, which signal failure via RFLAGS.CF and RFLAGS.ZF.

Opportunistically use R9D instead of the full R9, as bits 63:32 of GPRs are
zeroed on writes to bit 31:0.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260818165258.2613603-5-vkuznets@redhat.com
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..282b8aaff799 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1318,7 +1318,7 @@ gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
 	"lea 1f(%%rip), %%r10\n\t"				\
 	"lea 2f(%%rip), %%r11\n\t"				\
 	fep "1: " insn "\n\t"					\
-	"xor %%r9, %%r9\n\t"					\
+	"mov $0, %%r9d\n\t"					\
 	"2:\n\t"						\
 	"mov  %%r9b, %[vector]\n\t"				\
 	"mov  %%r10, %[error_code]\n\t"
-- 
2.55.0.887.g758fc8c411-goog

