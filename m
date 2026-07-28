Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237A466B1C
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250389; cv=none; b=P0BumjkWyFSHdKTd8rDEpZ9kAoCLEKx06XMzrUdFX8mnQyw7YbR42nPi/S1xdnaUh8XcPkw78970AnvEyHOoc/eqeH+6h8fkqAobx6ZZDL7zWtMvMpMlBZwh93LvgS1GWFXhFFHH/mB1GXlG1ez450K9cbV3w4SRxklr/uwsyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250389; c=relaxed/simple;
	bh=ev34CkbhmD0iX/IeeRnMWpNNjThPuwY1U6RaAwjxyMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQI4TzeomoXUeUqo/NyCQwTsqXhaOk2/TMhcTxSTH+eu4ULyR+kuHHWlwoZ2ljlBje+nme7i/T7i77Lv7EULxn6yxVgweTXisqQ0f8LvSissD0uB81kyRaBK8rvYoS1/9t2BTv/exP8ZIzcfY3Q32suuHP22GcBUta1e14nEuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/t9lC37; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/t9lC37"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2536711a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785250388; x=1785855188; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9pWpt9v5UPNGwNX/7tiRZM7v/nH0F92RtXnF3fMPvC4=;
        b=A/t9lC370Ksuvd3yY3zhLhYr+nBu22eI5Fk6U+AaKR/KyW2gNNXh7do+DRtBCMDtp4
         cCuJtH9FX1vzl7yarQZ+12nLjSst5sWesQuLpqvxzHspsQPPdmBmjOcGQnC0K3Mm7Ef+
         HbhkloiTnS446XKLAkdnVmMv5U0ThxgK/xi3awn5OSWSzjugRHM8r/8wB7I9FBlH0Xlt
         Tk7Ry3w4K/nUAFaR6JyeK7uNO8j8nTMZE+SkvAE0F+ztb4A+3GN4lS/yUKNJkGpzLTtS
         npbhJnhLNl9rju59T9FGAaui+0X6VxPwRjjBmDiTcg4OHBLLal5UTrKbas/iVa7+kAfd
         DzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250388; x=1785855188;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9pWpt9v5UPNGwNX/7tiRZM7v/nH0F92RtXnF3fMPvC4=;
        b=cV9qLxJLYorYymS+y+IDeb6RQ0uUoLG73Hy4g0NDVjnwcKhQOGleAg0IbgZ9CdG7Yg
         Sws/sNCHBouKDjGuoAtgceQhdQHrss31WUo3S9Anw4pL0yrdpGCETiQazLvwWjB3gI2f
         UQamSymjSy9DV7E//+QITzixYDwyxZEfAxxrXaljPkYRJ8bBPE2p3FbAGBBSyM1hnRk9
         U5FBi6jbh1W97zsjrbWUxM7pw+p9T1IRtA1VQpML44loIaj405NeJN7+U8C7w0ShhzzU
         ONStkKV/FHQqhKYQVHEaxF30+O09D8sbgsHvLysP6lmw0xZX35xuWq+FOJEJzkcQMyId
         HRhw==
X-Forwarded-Encrypted: i=1; AHgh+RrlDDq6ce8q+R+l3JvA+RLMZA/B6R5ydQGYyqN9ClTtQe6itpQCT+2V1w77RwpCwO3PdDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4/2npfVJemQTxBGDta0eIZg5kdURGe5Okn6kMrOqDehfwg8L
	SjDVzj9OO9MZv52cnvLnaVD8nUMVHyY9IrvRJRj/cXmFVqJZLxBB8/wanefabPrKkwH6rqFtNWP
	y3Kfj2A==
X-Received: from pjuj12.prod.google.com ([2002:a17:90a:d00c:b0:36b:7f07:6fcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4c:b0:38e:9e9e:ec57
 with SMTP id 98e67ed59e1d1-38f6a588a24mr1974650a91.43.1785250387458; Tue, 28
 Jul 2026 07:53:07 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:53:06 -0700
In-Reply-To: <20260727235228.1007324-10-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-10-yosry@kernel.org>
Message-ID: <amjCUgcjRRWH2zRO@google.com>
Subject: Re: [PATCH v4 09/12] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 88c6c8046ddec..e67b1e9893f68 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -112,6 +112,7 @@ TEST_GEN_PROGS_x86 += x86/set_sregs_test
>  TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
>  TEST_GEN_PROGS_x86 += x86/smm_test
>  TEST_GEN_PROGS_x86 += x86/state_test
> +TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test

Sort alphabetically (I'm guessing you forgot to move this when renaming from
stress_xxx to save_xxx).

>  TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
>  TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
>  TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> index 06d9ba1c4df33..2889782b0016b 100644
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> @@ -614,6 +614,15 @@ static inline void set_cr0(u64 val)
>  	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
>  }
>  
> +static inline u64 get_cr2(void)
> +{
> +	u64 cr2;
> +
> +	__asm__ __volatile__("mov %%cr2, %[cr2]"
> +			     : /* output */ [cr2]"=r"(cr2));

Drop the "/* output */" comment, if the reader doesn't know how asm constraints
work *and* can't deduce that it's an output given the function name and return
value, then they probably shouldn't be reading this code.

Oh, yeesh, all of these getters have that silly comment.  Drop it here, I'll send
a patch to remove those bad examples.

> +	return cr2;
> +}
> +
