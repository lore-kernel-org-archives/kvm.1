Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CC382F0E
	for <kvm@vger.kernel.org>; Sun,  5 Apr 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775427020; cv=pass; b=VgVkiFdqoXEE6LKVYrlzLa77+tHvvaDkIcM7nmMdtvcRwZyR1zyzEYRKtBriebbULzTZPpSN86pD7OryD5abTd6oEa3ljXsmubf4xf2VQf1btZkpduYyMuVWvF5zbDc4AtDJM5RdOHCndW0H0PUnI24+v+JN+hix3pld8P+jEX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775427020; c=relaxed/simple;
	bh=ABUjEWGDZYHREqnQ0FoQ2NGfgCH18iC9mDSHCs7Bdws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cHLUHg5qErQbsZE1zFwAzP3R15/dTeDm+HUGbDmksQANMvoZFDGHO5fsU5FqqLjNgedWX42ZZTbHLi8YKaFq1nbe/cbVOyT6bj5f0I+VZ18hJh7AVlJVsTIJbRM+sPfCcUAvMvbovgeQ1HBR312lwuZGcSgXqMYMdhm+rE2I0y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP1YSvBt; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP1YSvBt"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76864f4e58so1235275a12.1
        for <kvm@vger.kernel.org>; Sun, 05 Apr 2026 15:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775427018; cv=none;
        d=google.com; s=arc-20240605;
        b=aeeoskY0mUMb7N7T8k1vMNDo+LgfAWj5GLkhmEiVOgM1MzOiziwlS2bkCKEZN/1fJv
         g3kktbtaZ3fet2BVi3yARh/1D7K10NfBoercf1aMJf1fkBECvk8X6e6tmIv6OpQ/D6KX
         VFL8x/Bpif4UJAfj4K5dSoqEGNtkIElwWG6ZfkVyc9uIPlqnI2QXcRAXrHJUe+ZuUpMY
         UlqK8LS5myMyz83vsYklyDdpwW+lZx5sEnz1lhaY3aQ6YjHMa9hlDtBbcQ+dJ64Vb5l/
         Orf+KnMcXcUj9ABesfihiWCsQ940WZNmb3cJ7XIhj7v0E3XaFGadwCmMOVpv0g9yqi1i
         kgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        fh=H3/KK8QBGjalGN85cXmwwbL+7Oiv0814hi0QK1apIZE=;
        b=QQ+ahg3pjBzuK8qqNxH/8smPc4HtHO32Y7X2sB78V26WkAb9hw5G3E0rml812mKgeM
         nwv1f91qcpW9ma0n1L6pvCo0oBIyUqw0CAEVKOyjBJ++Zo9whhdDZU658cI/yNkev4ro
         dHh0pQbeNJve8Jsezs+9EY2jxNmRQpihPkJ+w89MtlDjT402gfNqh7dKaPvdFX0yuwxo
         QsaoSPPXch9Clvfvu9z6fX8PsFCaZ4EimjmSVe39HoTUSv90Fh9WlGJHb57AHnfLwxf/
         Aas2elyWNB+j2sjLKuaFdzh6R2xlERAOcAnhHgEtmysSmAbIjCL4Ai7fCc/U90p71c3+
         2+Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775427018; x=1776031818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        b=iP1YSvBtoOu9bqPRdP3j8rrFjtR46+1xrjNJyNNgsJK/ZaJ4Rnvf7uAciI35pHPhpE
         1AyGVy/XOlndXLfMtKF9OC9TLQpcDE9w7MV5dnUbv8cdJ8dcQA6shl2S02uGwm4WwMdV
         /aTpPh8WZDNfiIRxVhdzO3EUYUazWVE1MMrEUHvGI4KWU11GeDsVehSBlatcTUbzssMI
         TvPgsW93MzJf/uD+ObD3lwYwC6NL2JgzPUtN6mBuXBoGzlOmyKdMfDL67wF1w8Ihh3/m
         d98Pz89ldzmzE1cXw9jMtWKAOyatyXFwRGrn3UOMXFNvy+tBTftXmmTjnBEPZzrC8vL6
         sMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775427018; x=1776031818;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9u+QzC2aJqKtNe3/rtmBsCiYMsv2LB2s8cYUNUD6G0=;
        b=f4amEaX9tR8Nm8+dXgCNXerS4gdS+fE9TcR8hH3lxv4iX/dxxCIt7WmDCPHWdrNads
         wrOGv7kqZOvoW/qsaYlP6ficAeKZ82YbpWvG8yIaDf4VmfYg8FeZZhW8vzCWAd6iI5Hx
         NUyuzy+oLaPftyDIdXdotOkdRzzXCIQTBGcQ593gpvpuURMaUP+D2NJlWaWzj4AXRa9u
         0R60UOnwmH1Y7qNlNvbyhKRQGquPvLJDZB0OPelWLydPlGDwQN8DiLSgnVv2HIIX92ci
         NrCB/Irf0tv/lkWjziCyK419cq2+g7pG2TD0x3xYMwArYZY7drXFD2RoWCaHFIomh2I8
         SrSw==
X-Gm-Message-State: AOJu0Yx43YEnePE81Lwfmxv3nIrCfH0B7G7VixYZDtNTWOl8lpuGmiOe
	7ahtUraA0mIfZKfOiaJfDbnc58p73tlB2i24ca5/qa/ToI7WdNT0GLkJ8KUxJ2RpmrT73S644gF
	2tcRxae2IzI6HM6q49FaCqG1OAdbgP1c=
X-Gm-Gg: AeBDiet6jYCJFsf1dV8h7QTihSpefEnsmO7tLdKKACfU3z5xegpk0ZGWSOn/Z4rhcBV
	67tz95n+8AdAZQm7sqCW2GAEeHdXIboFyh9Nm5zavZiNyUfH+Bf8bXFSDVYOdhAa1m8miYg3Sbw
	Wp5O76+CzvQ8QVdhHnFO7hizrs8ixa6uAyq2XzD36i4n4Il8qQ4hRt2goQLM+CRjpwjzSyOANEc
	zXN4m6cYn3xACSNBNNl81dEpDmKcgPpV2Us1/X8VU4ffcOcaQ/ZG0p1yJUpj+HUUBowMN8JKX4I
	AIMt/TceVXsTNaPLVKR4Xg/eqmh+Q/DjHp3JAzCY8/qwK7HbfxY=
X-Received: by 2002:a05:6a20:12c5:b0:39c:4af6:4305 with SMTP id
 adf61e73a8af0-39f2ef776f8mr10913190637.10.1775427018045; Sun, 05 Apr 2026
 15:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thomas Lefebvre <thomas.lefebvre3@gmail.com>
Date: Sun, 5 Apr 2026 15:10:07 -0700
X-Gm-Features: AQROBzBRYTfs3R9pignNAUl0z7_W9YKD9Yw5QkOdj1ny5dpfRahj1Q-2xMfYdFA
Message-ID: <CAKdXbaV1PTwetd4zs6+6Rp7h0dwHU1ygMoof5eAcfL6XYZF1xA@mail.gmail.com>
Subject: [BUG] KVM: x86: kvmclock jumps ~253 years on Hyper-V nested virt due
 to cross-CPU raw TSC inconsistency
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm seeing KVM_GET_CLOCK return values ~253 years in the future when
running KVM inside a Hyper-V VM (nested virtualization).  I tracked
it down to an unsigned wraparound in __get_kvmclock() and have
bpftrace data showing the exact failure.

Setup:
  - Intel i7-11800H laptop running Windows with Hyper-V
  - L1 guest: Ubuntu 24.04, kernel 6.8.0, 4 vCPUs
  - Clocksource: hyperv_clocksource_tsc_page (VDSO_CLOCKMODE_HVCLOCK)
  - KVM running inside L1, hosting L2 guests

Root cause:

__get_kvmclock() does:

    hv_clock.tsc_timestamp = ka->master_cycle_now;
    hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
    ...
    data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);

and __pvclock_read_cycles() does:

    delta = tsc - src->tsc_timestamp;    /* unsigned */

master_cycle_now is a raw RDTSC captured by
pvclock_update_vm_gtod_copy().  host_tsc is a raw RDTSC read by
__get_kvmclock() on the current CPU.  Both go through the vgettsc()
HVCLOCK path which calls hv_read_tsc_page_tsc() -- this computes a
cross-CPU-consistent reference counter via scale/offset, but stores
the *raw* RDTSC in tsc_timestamp as a side effect.

Under Hyper-V, raw RDTSC values are not consistent across vCPUs.
The hypervisor corrects them only through the TSC page scale/offset.
If pvclock_update_vm_gtod_copy() runs on CPU 0 and __get_kvmclock()
later runs on CPU 1 where the raw TSC is lower, the unsigned
subtraction wraps.

I wrote a bpftrace tracer (included below) to instrument both
functions and captured two corruption events:

  Event 1:

    [GTOD_COPY] pid=2117649 cpu=0->0 use_master=1
                mcn=598992030530137 mkn=259977082393200

    [GET_CLOCK] pid=2117649 entry_cpu=1 exit_cpu=1 use_master=1
      clock=8006399342167092479 host_tsc=598991848289183
      master_cycle_now=598992030530137
      system_time(mkn+off)=5175860260
      TSC DEFICIT: 182240954 cycles

    master_cycle_now captured on CPU 0, host_tsc read on CPU 1.
    CPU 1's raw RDTSC was 182M cycles lower.

      598991848289183 - 598992030530137 = 18446744073527310662 (u64)

    Returned clock: 8,006,399,342,167,092,479 ns (~253.7 years)
    Correct system_time: 5,175,860,260 ns (~5.2 seconds)

  Event 2:

    [GTOD_COPY] pid=2117953 cpu=0->0 use_master=1
                mcn=599040238416510

    [GET_CLOCK] pid=2117953 entry_cpu=3 exit_cpu=3 use_master=1
      clock=8006399342464295526 host_tsc=599040211994220
      master_cycle_now=599040238416510
      TSC DEFICIT: 26422290 cycles

    Same pattern, CPU 0 vs CPU 3, 26M cycle deficit.

kvm_get_wall_clock_epoch() has the same pattern -- fresh host_tsc
vs stale master_cycle_now passed to __pvclock_read_cycles().

The simplest fix I can think of is guarding the __pvclock_read_cycles
call in __get_kvmclock():

    if (data->host_tsc >= hv_clock.tsc_timestamp)
        data->clock = __pvclock_read_cycles(&hv_clock, data->host_tsc);
    else
        data->clock = hv_clock.system_time;

system_time (= master_kernel_ns + kvmclock_offset) was computed from
the TSC page's corrected reference counter and is accurate regardless
of CPU.  The fallback loses sub-us interpolation but avoids a 253-year
jump.  On systems with consistent cross-CPU TSC, the branch is never
taken.

One thing I wasn't sure about: when the fallback triggers,
KVM_CLOCK_TSC_STABLE is still set in data->flags.  I left it alone
since the returned value is still correct (just less precise), but
I could see an argument for clearing it.

Disabling master clock entirely for HVCLOCK would also work but
seemed heavy -- it sacrifices PVCLOCK_TSC_STABLE_BIT, forces the
guest pvclock read into the atomic64_cmpxchg monotonicity guard,
and triggers KVM_REQ_GLOBAL_CLOCK_UPDATE on vCPU migration.

Reproducer bpftrace script (run while exercising KVM on a Hyper-V
host):

  #!/usr/bin/env bpftrace
  /*
   * Detect host_tsc < master_cycle_now in __get_kvmclock.
   *
   * struct kvm_clock_data layout (for raw offset reads):
   *   offset 0:  u64 clock
   *   offset 24: u64 host_tsc
   */

  kprobe:__get_kvmclock
  {
      $kvm = (struct kvm *)arg0;
      @get_data[tid] = (uint64)arg1;
      @get_use_master[tid] = (uint64)$kvm->arch.use_master_clock;
      @get_mcn[tid] = (uint64)$kvm->arch.master_cycle_now;
      @get_cpu[tid] = cpu;
  }

  kretprobe:__get_kvmclock
  {
      $data_ptr = @get_data[tid];
      if ($data_ptr != 0) {
          $clock = *(uint64 *)($data_ptr);
          $host_tsc = *(uint64 *)($data_ptr + 24);
          $use_master = @get_use_master[tid];
          $mcn = @get_mcn[tid];

          if ($use_master && $host_tsc != 0 && $host_tsc < $mcn) {
              printf("BUG: pid=%d cpu=%d->%d host_tsc=%lu mcn=%lu "
                     "deficit=%lu clock=%lu\n",
                     pid, @get_cpu[tid], cpu, $host_tsc,
                     $mcn, $mcn - $host_tsc, $clock);
          }
      }
      delete(@get_data[tid]);
      delete(@get_use_master[tid]);
      delete(@get_mcn[tid]);
      delete(@get_cpu[tid]);
  }

  kprobe:pvclock_update_vm_gtod_copy {
      @gtod_kvm[tid] = (uint64)arg0;
      @gtod_cpu[tid] = cpu;
  }
  kretprobe:pvclock_update_vm_gtod_copy
  {
      $kvm = (struct kvm *)@gtod_kvm[tid];
      if ($kvm != 0) {
          printf("GTOD: pid=%d cpu=%d->%d mcn=%lu use_master=%d\n",
                 pid, @gtod_cpu[tid], cpu,
                 $kvm->arch.master_cycle_now,
                 $kvm->arch.use_master_clock);
      }
      delete(@gtod_kvm[tid]);
      delete(@gtod_cpu[tid]);
  }

Thanks,
Thomas
