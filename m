Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEA2E62C6
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067966; cv=none; b=Oi4EiuagxosU0f7zfUo+AOtFkXOpnd977WydGLJ624/5bMsh1pUf/+WsqIfbSO0ozbW/tzab9Kuxhx4sfuHZELdOgureqvNmZ5SoKku0pGMSSPUuvNF+dGJfHaXDW5qG/h2Zsog+GpRwv/R+/Qs39LZmZ2/AxMUlYpJt/n7Sczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067966; c=relaxed/simple;
	bh=0neaokEvDvCfBuu/Fx5r3uiSSbYKBuo5aFELkon2UwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVM0HS4GfWG6pY5MGGhwzoEqJzduG6JYJ6wHr5G0fu2PKF8F1F2EJrOE5kjuHbZFhsihwQvIwi38AmqWx3BeC88DeV7YHtVnZYPVVSUEEAyG6XCkFBPlA1ETtNLz2jvaYEg/dZ1iL3JQmt0D8lgZTsT5QT94IYUI7DsPyD+vh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oOOAKxhZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oOOAKxhZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cd9fa609aso29536b3a.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775067964; x=1775672764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhZ1mA0lE5i0zKRyy7QucwZ9Uq6VZ4dPueh6WmVgfzs=;
        b=oOOAKxhZBwYTCETyH3e6Ud0VaekN+8vs/+llzoyHXK41SD8Rh//psOsLhzr4nMIR4r
         a4UZXlsBG3mKX/yuT5Xcs8DiJYcRiUDF77qBKsEzbHPi0nM7IH2Bb/L5U77XozfBW711
         yInyRU0I5NoWZWmmRJ3oYNbfob0TI6Zb6RlxQspFScvhh27Iz0y8VRORElOy06VY3fN1
         IpHVHvG1uyXDiMUPXdtQNFlxT4aaShbEPpbHY5Hoh4IlTWjCWdS/qCsYQqvCMAGwvXwx
         GNRoFBmv1m3Q/XdL9kpjMnOjv/kKSNolAQo5pmjYwmPDXjy/zsF+R7z+depB8/GGIPai
         cbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067964; x=1775672764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhZ1mA0lE5i0zKRyy7QucwZ9Uq6VZ4dPueh6WmVgfzs=;
        b=ofgH1SB7JgDmuLDt0/T44CTsUjL4xswbR0U3HdHCVQzSvK9J+VJ1dI75QiGWxlbW09
         w7nJ7mBbwp4mZKhxfRvnP+RvCeAXQd3VwG65ThTXRR+4uAW7L/XYpDvo8WJxrIO3NMIv
         yQEO78swupvNlcHXxiVRVLn3gpXwrdXssBr5HGuWxSQpcVPqAL9j/C6c9sHgK5wu0iSV
         NJdVf3pbqyFH0QwpmFFxoNUiU8kBLRB7a/WhBqmITQsV5ZszHxfcZXz+SFegNX40y4Wm
         36lIRzck3HZJLxRFYFLH/aBW1i9rkvyYkNY1OHtCScRbpZNG27UrhceGL54lV0+wkAMn
         fObA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkCDpNJ1zg5MFINN0sG4GQTNjgK5PdPheO6uKRCrAP2Fz75l/m7b698p41siKQ/I1RtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsd3CX5yJVInMLFGnLh2mQtu927sDaVRsqBK82NEmW5wLrvDI8
	yM9jFzAPs0CuZyq2VAeRlswleBUwLeSeVilTGZMPzckd7Epumv5hN/UKxa0p6igQ3R6kxf0se9x
	M8nBINg==
X-Received: from pfbii10.prod.google.com ([2002:a05:6a00:8c8a:b0:82c:6cfd:5945])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:348a:b0:82c:6b1b:7ad4
 with SMTP id d2e1a72fcca58-82cfb85d99dmr523717b3a.3.1775067964217; Wed, 01
 Apr 2026 11:26:04 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:26:03 -0700
In-Reply-To: <20260331194033.3890309-3-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-3-jrhilke@google.com>
Message-ID: <ac1jO1e2_BIs1Kx0@google.com>
Subject: Re: [PATCH v2 02/14] KVM: selftests: Add helper functions for IRQ testing
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> diff --git a/tools/testing/selftests/kvm/include/irq_util.h b/tools/testing/selftests/kvm/include/irq_util.h
> new file mode 100644
> index 000000000000..a5d6b63b30da
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/irq_util.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_PROC_UTIL_H
> +#define SELFTEST_KVM_PROC_UTIL_H
> +
> +#include <stdint.h>
> +
> +int get_irq_number(const char *device_bdf, int msi);
> +uint64_t get_irq_count(int irq);
> +uint64_t get_irq_count_by_name(const char *name);

These are far too generic.  I'm also not convinced these should exist at all.
I'll add more context in the next patch.

> +#endif /* SELFTEST_KVM_PROC_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 8b39cb919f4f..8be02e7980eb 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -1144,6 +1144,17 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
>  	memcpy(&(g), _p, sizeof(g));				\
>  })
>  
> +#define READ_FROM_GUEST(_vm, _variable) ({		\
> +	sync_global_from_guest(_vm, _variable);		\
> +	READ_ONCE(_variable);				\
> +})
> +
> +#define WRITE_TO_GUEST(_vm, _variable, _value) do {	\
> +	WRITE_ONCE(_variable, _value);			\
> +	sync_global_to_guest(_vm, _variable);		\
> +} while (0)

These belong in a separate patch.  I also think we should convert as many users
as possible when they're introduced.

We might want a better name than WRITE_TO_GUEST(), because that suggests it _just_
writes to guest, but it also writes to the host value.  Maybe SYNC_FROM_GUEST_AND_READ()
and WRITE_AND_SYNC_TO_GUEST()?  Stupidly verbose, but IMO it doesn't look too weird
in the code.

> +
> +

Unnecessary newline.

>  /*
>   * Write a global value, but only in the VM's (guest's) domain.  Primarily used
>   * for "globals" that hold per-VM values (VMs always duplicate code and global
