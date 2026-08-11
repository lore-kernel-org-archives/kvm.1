Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE073382C9
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468725; cv=none; b=XNn0fpvQKQcZsrmjHE2vxyiTIwBfMwE+IUCmAVNy45mUlYYOhiTYi5kGMJCurM8+LMcZZe+wIwLJ8ckVEMLKWWr9NDx09YEtvO8/xHqISqxLvQ0+8RKBpKIyAuXwXds6Ke2V85celdvJULsSrjq2p99LOo9mUxxNN7BPpiZGfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468725; c=relaxed/simple;
	bh=aM8t6gbWVSBH/PXjIpG3X2PBmAzOnCTHTBlY6ixW2I4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7qaQ6JR9cuU+FUHyuStxHE8kv4CRNCfABL/yjachn56yL9R0Gr8vfuwGF0A40Y2BP+DbpDzWv+6bvuMF8noqJPqloIhteIZ01o4m10Dvblbu5+PrFIHRulFLTYe1oXdlM0CA5i6bBp5+4XBQQFCBNe4xG4Tk+VnfR3bNYYIOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjPKjjuo; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjPKjjuo"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487eb67173so167687b3a.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786468722; x=1787073522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AtIGM2NHe8OV4DKgN1nHk9aAoS7uuH7cfv4s5R8wW14=;
        b=PjPKjjuo/kiiHk3D/NmXAOnm7hm0O0fvRyA/GKIo5QfScQs9FF5gxVLgpjLGYP4yLC
         HzF/oRCpdr7bpaT3z3O7cdHK3LJtrMpsgQMBrRad0kgOBTVjsW4x4LhWHq0+pi+G7gLJ
         0FSoLSlKFIUYg6z92Tez3eTZHCM04F0iZsed2iHPJCFbUWIV+AOenQSoQ3Xp24m7oxEj
         bc9mMpoLAt8zJ+nLm5BrmUq5e2d1Ge6uejQkV5SydtuNXhUOhVg7mVZbWqDYbKljK3PX
         a9yp+a652GgCSo0C6guGDc/X6foXtFhNFJCN4YkP+RFDacMhJ/YvEiNsdrBGqzvd8Y+X
         DSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786468722; x=1787073522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AtIGM2NHe8OV4DKgN1nHk9aAoS7uuH7cfv4s5R8wW14=;
        b=IteWR/MvjPLXnunKdLUYvNiMjvIhyt7qzZUEMyQFwKhMjwX1AcERNVfBWR3nUOv6Jo
         MZ+OldL9xmhxznI1g/rNXSsjjtEElSpR5xQ2oPOkTG3rZw65TdmgfLjZl/4dFEW1fKo7
         jLd9+KBQwMxO6FJOin29FA64bWmAvZgY6DM5sMa4E3MbUHSsD1b4B1aFUvmJlWzWrvx+
         oEKuaxCQ4RBMrLalSxyfQ1vgc4u+xnord6FrmTIochkkAef/ldwcNM5EaP5gyFiiOrC8
         Vzrw7hC3XPE90FB03xtcrYpiwY0Qwh/T450iXxFrqkp+FCqG+8THPu/YFgonv5TpAPJF
         VQmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJPYCcFsCPr3Keos5j1GxXEFMxxKi33wz83M9HUFj6Dzs3bcbThM/a7hZVpUNh3f36kvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9TgS603q+aimZVQBS5YRYqkqJZxZSno0w/JGtKsmE3fo2M1C
	9flch4eDYqQEwVGRnxXumhnmfRnLb4OvCH17K0kUG+my0MdIWuz4r+tVtihaLJZOVwouPAW8zxV
	TvmXdIQ==
X-Received: from pfbds7.prod.google.com ([2002:a05:6a00:4ac7:b0:848:2a35:eb83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:139e:b0:848:5ed6:9d27
 with SMTP id d2e1a72fcca58-84fafa6094dmr1722392b3a.36.1786468722299; Tue, 11
 Aug 2026 10:18:42 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:18:41 -0700
In-Reply-To: <20260811060134.106973-4-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811060134.106973-1-jinyu.tang@linux.dev> <20260811060134.106973-4-jinyu.tang@linux.dev>
Message-ID: <antZcYiOR0WKi5Kv@google.com>
Subject: Re: [PATCH 3/3] KVM: selftests: Enable pre_fault_memory_test for RISC-V
From: Sean Christopherson <seanjc@google.com>
To: Jinyu Tang <jinyu.tang@linux.dev>
Cc: Anup Patel <anup@brainfault.org>, Anup Patel <apatel@ventanamicro.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Jinyu Tang wrote:
> RISC-V now supports KVM_PRE_FAULT_MEMORY, so include the generic
> pre_fault_memory_test in the RISC-V KVM selftest build.
> 
> The test uses PAGE_SIZE from the architecture processor header. Define
> the normal 4K RISC-V selftest page size so the generic test can build
> for RISC-V.
> 
> RISC-V selects VM_MODE_DEFAULT at runtime. Initialize the supported
> guest modes before creating the VM so the generic test can run on
> RISC-V hosts where the default mode is discovered from KVM
> capabilities.
> 
> Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
> ---

...

> diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> index a0fcae3cb7a8..6eebf0524673 100644
> --- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
> +++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> @@ -8,6 +8,7 @@
>  #include <linux/sizes.h>
>  
>  #include <test_util.h>
> +#include <guest_modes.h>
>  #include <kvm_util.h>
>  #include <processor.h>
>  #include <pthread.h>
> @@ -219,6 +220,8 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
>  
>  int main(int argc, char *argv[])
>  {
> +	guest_modes_append_default();

Can we do this for all selftests in kvm_selftest_init()?  Or perhaps even better,
handle it in kvm_selftest_arch_init() to avoid the gnarly #ifdefs?

Unless there's a meaningful downside to configuring the supported and default
modes, I don't see any reason to force tests to manually do this work.

> +
>  	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
>  
>  	test_pre_fault_memory(0, false);
> -- 
> 2.43.0
> 
