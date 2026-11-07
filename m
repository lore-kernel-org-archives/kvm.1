Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068559;
	b=ZxEHqeGlzlc7i92U5EtnwWGS84q8J0eft1NXqmnmCjPI9P+jtFLk5aayW0vIhpj48T5X
	 m8j5+YyuhJcI1Ynvx+lIM0DtH8C6XTSgaSSs2RI/RdhnhXhxlZFRXXdb851DL6TMANhEN
	 oBymgJWKNS762N+vedGSjYOC7XNDM7eKHY5S9brIKmDfIP4EjD01aSoM4HQE9yXB8Mklu
	 QNM92ixCu88DrdVZ6aLz0QX2DynBmIlG9NXjkQpiR3RGXafY7oKCrAeRE8Qma4+wPBVe5
	 onJNh9mJIq61tqoBtg7c6lGCoaYotDdSHXihHkxAT2LCGwuilAhkLN/y21G4ITPH91Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068559;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 Feedback-ID:X-Infomaniak-Routing;
	bh=+pZEKhJ4S1DIwNXL8RYuy+6X+cpdAugo+6kxHr+BwgY=;
	b=z4S8QutfkAWw4KEIkBk0GiAzYByLGWLZ5KmqDf/HO5hJ0KU9zENB+lj0sH65ybLS6RI6
	 BIu33tqUTEhhN6ONC1WIX5bDB4cu4Ftkhr1/SDQnLzdIVcFqp2qZ/kQPUKZx77xrhC1jC
	 PqdPJzBy+QcX+R7I5sxWLN5ByIIsuQmTgEfohaAZ+0E3N5WfzFPToob8ACxoTU/Dykple
	 2sCCHXx1l/7x1cnn0KAY+9NQfCTX5wJLmdQtUK+EyWzMVI1B5V4Kb45D6+9IzTI2Z3FSw
	 sN5kexq4xjZJpRT6SNPK644kPjVWTzVQ8Wqxn29SUAZnhE+ZjopEbO6OyYTWBnTDh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=etik.com;
	spf=pass smtp.mailfrom=etik.com;
	dkim=pass header.d=etik.com header.i=@etik.com header.a=rsa-sha256 header.s=20210927 header.b=vITsI77r;
	arc=none smtp.remote-ip=83.166.143.173
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B7606A32C
	for <kvm@vger.kernel.org>; Sat,  7 Nov 2026 16:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65B7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=etik.com header.i=@etik.com header.a=rsa-sha256 header.s=20210927 header.b=vITsI77r
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jMLtD5bZLzdt;
	Sat,  7 Nov 2026 17:22:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etik.com;
	s=20210927; t=1794068548;
	bh=+pZEKhJ4S1DIwNXL8RYuy+6X+cpdAugo+6kxHr+BwgY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=vITsI77rxiY7b6mTrSWS3Z2lj1kOpGxI6MI9N8f/G9iPv80bLAY+HgZksppd4BpBU
	 hAZvXq5UL8ODnsKpbWJefpE4meeXv7vnFMJXNx8S3HP6Aw9GZ9NKh5UOOaNtMjepPm
	 orC6vgEEYC/7YjtZuIG5b+FJIVKnOA28gf2jLuws=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jMLtB4S97zT1t;
	Sat,  7 Nov 2026 17:22:26 +0100 (CET)
Message-ID: <1435d106-d4b0-487e-85d3-4032a9fe9332@etik.com>
Date: Sat, 7 Nov 2026 17:22:25 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: DV <dv@etik.com>
Subject: Re: [PATCH] kvm: hyper-v: Delay firing of expired stimers
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Sean Christopherson
 <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 hpa@zytor.com, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 nh-open-source@amazon.com, gurugubs@amazon.com, jalliste@amazon.co.uk,
 Michael Kelley <mhklinux@outlook.com>, John Starks <jostarks@microsoft.com>,
 David Woodhouse <dwmw2@infradead.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
References: <20260115141520.24176-1-graf@amazon.com>
 <aXO8I6xuZyZB7CxV@google.com>
 <769f538d-dd42-4d36-a4c5-7e6e48b209f6@amazon.com> <87bjigaeyx.fsf@redhat.com>
Content-Language: en-US
In-Reply-To: <87bjigaeyx.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: :74c292bbbde641d:ham:123049f310c9d1d
X-Infomaniak-Routing: alpha

Hi Vitaly, Alex, all,

On Mon, 26 Jan 2026, Vitaly Kuznetsov wrote:
> My bet goes to the clocksource switch, e.g. the guest disables (or
> just stops using, good luck detecting that :-) ) TSC page and uses
> raw TSC for some period or something.

I think I've hit a close relative of this, with a reproducer that
works on every boot. A Windows guest running its own Hyper-V computes
direct-mode stimer deadlines from the raw TSC, while KVM's reference
counter lags the TSC because of how QEMU restores kvmclock. Here the
lag is positive, so the guest's timers fire late instead of storming.

Setup
-----

Host: Intel Core Ultra 9 285K (invariant TSC, 3686.4 MHz), Linux
7.3.0, QEMU 10.2.4 (pc-q35-10.2), libvirt 12.2.0.

Guest: Windows 11 Pro 26H2 (build 26300.9711), 8 vCPUs, with
virtualization-based security on. So Windows runs as the root
partition on its own Hyper-V (L1), nested on KVM.

   -cpu host,migratable=off,hv-time=on,hv-relaxed=on,hv-vapic=on,
        hv-spinlocks=0xfff,hv-vpindex=on,hv-runtime=on,hv-synic=on,
        hv-stimer=on,hv-stimer-direct=on,hv-frequencies=on,
        hv-tlbflush=on,hv-tlbflush-direct=on,hv-tlbflush-ext=on,
        hv-evmcs=on,hv-avic=on,hv-emsr-bitmap=on,hv-xmm-input=on,...

Symptom
-------

Every timer inside Windows fired 0.3-0.7 s late. A 1 ms wait on a
high-resolution waitable timer took up to 466 ms, and an indirect
display driver paced only by a timer refreshed at 6-8 Hz instead of
120. Things only moved when some other interrupt woke a vCPU.

What L1 does
------------

With both hv-stimer-direct and hv-frequencies, L1 arms stimer0 in
direct mode (config 0x1ef8: vector 0xef, direct, auto-enable) and
writes absolute counts. Call X the amount by which the reference
counter lags guest TSC / HV_X64_MSR_TSC_FREQUENCY. L1's counts are
X too far out. A timer that should fire right away looks like this:

   kvm_hv_stimer_start_one_shot: vcpu_id 6 timer 0
       time_now 40095770231 count 40100417164

That count is 464.69 ms ahead of time_now, and X on that boot was
464.7 ms. L1 writes the count again on every L2 timer exit, so such a
timer keeps moving to now + X and only fires once the vCPU is quiet
for that long.

Without hv-stimer-direct, without hv-frequencies, or without
hv-stimer, L1 uses the local APIC timer instead (TMICT/TDCR writes,
a relative countdown), and all timers are on time. I've turned direct
mode off as a workaround: a 1 ms wait is now late by at most 1.24 ms.

Why the reference counter lags
------------------------------

get_time_ref_counter() follows kvmclock on both paths. The fallback
divides get_kvmclock_ns() by 100, and compute_tsc_page_parameters()
takes the TSC page's tsc_offset from the pvclock system_time.

QEMU's kvmclock_realize() calls KVM_GET_CLOCK when the VM is created.
kvmclock_vm_state_change() writes the saved value back with
KVM_SET_CLOCK when the VM starts running, and saves a new value
whenever it stops. So kvmclock, and with it the reference counter,
stands still from creation to first run and during every pause. The
guest TSC keeps counting through both. On six boots X was 297, 465,
570, 495, 669 and 512 ms.

Two measurements tie X to this:

- In a trace from QEMU startup, extrapolated back to zero, the guest
   TSC started at host monotonic 265208.1505 s and the reference
   counter at 265208.8205 s, 0.670 s later. X on that boot was
   669.2 ms.

- virsh suspend for 1.045 s, then resume: X grew from 669.2 to
   1689.3 ms (+1020.1 ms), and L1's far stimer deadline moved out by
   the same amount.

hv-evmcs off (X = 570.1 ms) and hv-reenlightenment on (X = 494.7 ms)
didn't change the behaviour. Host load and power management were
ruled out too.

Connection to your thread
-------------------------

If the reference counter were ahead of TSC time instead, L1's
deadlines would land in the past. stimer_start() expires a one-shot
whose count is in the past at once, L1 arms it again on its next
exit, and that would look like the expired-stimer storm Alex's patch
delays.

I haven't been able to try that here, because libvirt is set up to
start a fresh QEMU whenever the guest reboots. But a reset inside the
same QEMU process sets the guest TSC back to 0 while kvmclock keeps
counting, so I'd expect it to flip the sign, possibly by the whole
previous uptime. A resume path that restores the two clocks
differently could do the same.

Questions
---------

1. Should KVM keep the Hyper-V reference counter equal to guest TSC /
    TSC frequency when hv-frequencies is exposed? L1 seems to assume
    it is.

2. If so, where does the fix belong: in QEMU's kvmclock save/restore,
    or in KVM deriving the reference counter (and TSC page) from the
    guest TSC?

3. If not, should hv-stimer-direct be documented as unsafe for guests
    that run their own Hyper-V?

I can share the full traces and the Windows-side timer and frame
probes if they'd help.

Claude Code, an AI coding assistant, did the tracing and analysis
while I was looking into why the VM's virtual display ran at a few
frames per second.

Thanks,
David
