Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE89371D0D
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484693; cv=none; b=id3bjZjK+DJ9R4ekwQOjZH9CngFcebLsGm+cfmXJAXg6MMzj7L+ZKgWAHSj9UVifZoJL+8jNYLGVKAYsVsYPWAz578x4i4iSeKBJGXO+pY6YDaHaGq2Q9hOnhiFQUhVnsMhWKd2JpzFxMf1eiPn7LKfPWA5UKbKmOIHNFsaQXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484693; c=relaxed/simple;
	bh=21MtZwI+e+KkwMlhiPu+kfllTf+Qk8+3FwvLe8hErV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fXQMmCG5bhL/WZ5OBfiuNXoM2CLOqXw5ieSTmht+i9VXX3doGczCEMhPlDFbiWaIZ32RTOGBUaqT9Al9RBIwUew2xsEr5Ad9By40gbRTjSASB+UnjkpOA77BStsOFC4ScgO7ULpuQQNVBglqWwql+e4E3T5vVVGRcSME0rb+bdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMR1/4Kx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMR1/4Kx"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c7a84a43eso6600292b3a.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775484692; x=1776089492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uH587ImNUMZJ0IQrnF9mROku72lvu2ZLAn/VModlexk=;
        b=XMR1/4Kxn9RD8hQ2KYZXMRW2QfpWY8ml5/pFrg8kAb7YCUgvOkjqI1ODodCy1Lna+/
         gbgKLGFZSTMi39BZqM2RSgu9fpTZa10rxngfWKaFZf9kHpNUtejnzNtqFXo/vZOjkH4j
         FVmYhg5n2HF0Kd6ys+CjdwNvXLlI61uUsVDjOu6wVYQyhMFk9MEEEkSoMzjFKAplbmjJ
         dbWty3dBrOLlWL26AhdHmm8Jo8U7qLfUoqfIM12woA9cRXLyioqOgzUY2EKi6GRxOOFD
         PS4ZQZfOJUamdnjNubthWcQulqS9dX1QvCD5mDr75jlDc6HGBn1tCoIvxX65QjkOAPZr
         tMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775484692; x=1776089492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uH587ImNUMZJ0IQrnF9mROku72lvu2ZLAn/VModlexk=;
        b=gwF5Qx1U14H8KOREEOkyLXdvYtCfR4jBixYlIRnlaAdVyd6uxao6c9EJlblxyNCg/J
         /KkeD8vop2ovCh0TDoMkbV0AF4UkwNDgMYU1+EOrRoi6D98GAAawOKwtLZFJ8TLSTu7N
         Ka8bC1afYDavwqqhjknEfYLqaumIJCVkxJRasncEsqU637fg5EEGsJ6eaM3oQuTs5cAA
         dau41HaavPNWfAHbKsJjHDbj2uBUNSSQ4AaGVEeO1Ph7Ze0UNmGulwFjqVLiaRqEwMQJ
         8QWvU3E9wUlk84aIFDnmGJakDtr/5G36xNovHmRYnnIphrAmKFO9k4V/ezGEABLn4o/w
         VU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXFLX7A0zISMFMZzvCWzh1PXUNU0mZhle+ZwhnTuHxKoJEfXdBTd81JFC22woMBlyVTaJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSP/al20gSn3Zp306XCZIjSbPhCkxfnjBPNau38JhrvszJhTja
	1iPm0EIuVi4tviYO+GaUkT3tvAbujehWBvUVWT3594/6e1Q9APtLZ9LsH9k/6yF/Mu2WzIlsDFc
	ZsQSt7A==
X-Received: from pfbg4.prod.google.com ([2002:a05:6a00:ae04:b0:827:4734:567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3902:b0:824:a01f:6335
 with SMTP id d2e1a72fcca58-82d0daa3ce1mr12399256b3a.22.1775484691314; Mon, 06
 Apr 2026 07:11:31 -0700 (PDT)
Date: Mon, 6 Apr 2026 07:11:29 -0700
In-Reply-To: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Message-ID: <adO_EYdKtl_TXooI@google.com>
Subject: Re: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt
 due to cross-CPU raw TSC inconsistency
From: Sean Christopherson <seanjc@google.com>
To: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Apr 05, 2026, Thomas Lefebvre wrote:
> Hi,
> 
> I'm seeing KVM_GET_CLOCK return values ~253 years in the future when
> running KVM inside a Hyper-V VM (nested virtualization).  I tracked
> it down to an unsigned wraparound in __get_kvmclock() and have
> bpftrace data showing the exact failure.
> 
> Setup:
>   - Intel i7-11800H laptop running Windows with Hyper-V
>   - L1 guest: Ubuntu 24.04, kernel 6.8.0, 4 vCPUs
>   - Clocksource: hyperv_clocksource_tsc_page (VDSO_CLOCKMODE_HVCLOCK)
>   - KVM running inside L1, hosting L2 guests
> 
> Root cause:
> 
> __get_kvmclock() does:
> 
>     hv_clock.tsc_timestamp = ka->master_cycle_now;
>     hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
>     ...
>     data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
> 
> and __pvclock_read_cycles() does:
> 
>     delta = tsc - src->tsc_timestamp;    /* unsigned */
> 
> master_cycle_now is a raw RDTSC captured by
> pvclock_update_vm_gtod_copy().  host_tsc is a raw RDTSC read by
> __get_kvmclock() on the current CPU.  Both go through the vgettsc()
> HVCLOCK path which calls hv_read_tsc_page_tsc() -- this computes a
> cross-CPU-consistent reference counter via scale/offset, but stores
> the *raw* RDTSC in tsc_timestamp as a side effect.
> 
> Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
> The hypervisor corrects them only through the TSC page scale/offset.
> If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
> later runs on CPU 1 where the raw TSC is lower, the unsigned
> subtraction wraps.
> 
> I wrote a bpftrace tracer (included below) to instrument both
> functions and captured two corruption events:
> 
>   Event 1:
> 
>     [GTOD_COPY] pid=2117649 cpu=0->0 use_master=1
>                 mcn=598992030530137 mkn=259977082393200
> 
>     [GET_CLOCK] pid=2117649 entry_cpu=1 exit_cpu=1 use_master=1
>       clock=8006399342167092479 host_tsc=598991848289183
>       master_cycle_now=598992030530137
>       system_time(mkn+off)=5175860260
>       TSC DEFICIT: 182240954 cycles
> 
>     master_cycle_now captured on CPU 0, host_tsc read on CPU 1.
>     CPU 1's raw RDTSC was 182M cycles lower.
> 
>       598991848289183 - 598992030530137 = 18446744073527310662 (u64)
> 
>     Returned clock: 8,006,399,342,167,092,479 ns (~253.7 years)
>     Correct system_time: 5,175,860,260 ns (~5.2 seconds)
> 
>   Event 2:
> 
>     [GTOD_COPY] pid=2117953 cpu=0->0 use_master=1
>                 mcn=599040238416510
> 
>     [GET_CLOCK] pid=2117953 entry_cpu=3 exit_cpu=3 use_master=1
>       clock=8006399342464295526 host_tsc=599040211994220
>       master_cycle_now=599040238416510
>       TSC DEFICIT: 26422290 cycles
> 
>     Same pattern, CPU 0 vs CPU 3, 26M cycle deficit.
> 
> kvm_get_wall_clock_epoch() has the same pattern -- fresh host_tsc
> vs stale master_cycle_now passed to __pvclock_read_cycles().
> 
> The simplest fix I can think of is guarding the __pvclock_read_cycles
> call in __get_kvmclock():
> 
>     if (data->host_tsc >= hv_clock.tsc_timestamp)
>         data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
>     else
>         data->clock = hv_clock.system_time;

That might kinda sorta work for one KVM-as-the-host path, but it's not a proper
fix.  The actual guest-side (L2) reads in __pvclock_clocksource_read() will also
be broken, because PVCLOCK_TSC_STABLE_BIT will be set.

I don't see how this scenario can possibly work, KVM is effectively mixing two
time domains.  The stable timestamp from the TSC page is (obviously) *derived*
from the raw, *unstable* TSC, but they are two distinct domains.

What really confuses me is why we thought this would work for Hyper-V but not for
kvmclock (i.e. KVM-on-KVM).  Hyper-V's TSC page and kvmclock are the exact same
concept, but vgettsc() only special cases VDSO_CLOCKMODE_HVCLOCK, not
VDSO_CLOCKMODE_PVCLOCK.

Shouldn't we just revert b0c39dc68e3b ("x86/kvm: Pass stable clocksource to guests
when running nested on Hyper-V")?

Vitaly, what am I missing?

> system_time (= master_kernel_ns + kvmclock_offset) was computed from
> the TSC page's corrected reference counter and is accurate regardless
> of CPU.  The fallback loses sub-us interpolation but avoids a 253-year
> jump.  On systems with consistent cross-CPU TSC, the branch is never
> taken.
> 
> One thing I wasn't sure about: when the fallback triggers,
> KVM_CLOCK_TSC_STABLE is still set in data->flags.  I left it alone
> since the returned value is still correct (just less precise), but
> I could see an argument for clearing it.
> 
> Disabling master clock entirely for HVCLOCK would also work but
> seemed heavy -- it sacrifices PVCLOCK_TSC_STABLE_BIT, forces the
> guest pvclock read into the atomic64_cmpxchg monotonicity guard,
> and triggers KVM_REQ_GLOBAL_CLOCK_UPDATE on vCPU migration.
> 
> Reproducer bpftrace script (run while exercising KVM on a Hyper-V
> host):
> 
>   #!/usr/bin/env bpftrace
>   /*
>    * Detect host_tsc < master_cycle_now in __get_kvmclock.
>    *
>    * struct kvm_clock_data layout (for raw offset reads):
>    *   offset 0:  u64 clock
>    *   offset 24: u64 host_tsc
>    */
> 
>   kprobe:__get_kvmclock
>   {
>       $kvm = (struct kvm *)arg0;
>       @get_data[tid] = (uint64)arg1;
>       @get_use_master[tid] = (uint64)$kvm->arch.use_master_clock;
>       @get_mcn[tid] = (uint64)$kvm->arch.master_cycle_now;
>       @get_cpu[tid] = cpu;
>   }
> 
>   kretprobe:__get_kvmclock
>   {
>       $data_ptr = @get_data[tid];
>       if ($data_ptr != 0) {
>           $clock = *(uint64 *)($data_ptr);
>           $host_tsc = *(uint64 *)($data_ptr + 24);
>           $use_master = @get_use_master[tid];
>           $mcn = @get_mcn[tid];
> 
>           if ($use_master && $host_tsc != 0 && $host_tsc < $mcn) {
>               printf("BUG: pid=%d cpu=%d->%d host_tsc=%lu mcn=%lu "
>                      "deficit=%lu clock=%lu\n",
>                      pid, @get_cpu[tid], cpu, $host_tsc,
>                      $mcn, $mcn - $host_tsc, $clock);
>           }
>       }
>       delete(@get_data[tid]);
>       delete(@get_use_master[tid]);
>       delete(@get_mcn[tid]);
>       delete(@get_cpu[tid]);
>   }
> 
>   kprobe:pvclock_update_vm_gtod_copy {
>       @gtod_kvm[tid] = (uint64)arg0;
>       @gtod_cpu[tid] = cpu;
>   }
>   kretprobe:pvclock_update_vm_gtod_copy
>   {
>       $kvm = (struct kvm *)@gtod_kvm[tid];
>       if ($kvm != 0) {
>           printf("GTOD: pid=%d cpu=%d->%d mcn=%lu use_master=%d\n",
>                  pid, @gtod_cpu[tid], cpu,
>                  $kvm->arch.master_cycle_now,
>                  $kvm->arch.use_master_clock);
>       }
>       delete(@gtod_kvm[tid]);
>       delete(@gtod_cpu[tid]);
>   }
> 
> Thanks,
> Thomas
