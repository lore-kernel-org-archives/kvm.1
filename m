Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77501318EF4
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983054; cv=none; b=OR7/plE2fgI/pefqBoAx15OkEAs9oO9HC8DVNLqDgSY/KHv+l7PGgQDs8EWvFA1tqUupXoU1F5ppsrPJ1Y4MXsG8fFQuPme6TCfi7Nwxo0GmgC6A7KZTllDLAazye5KzLXTeEnX8kP0x3Gv4WkomclK26b6aeFLUQSM7vOLSknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983054; c=relaxed/simple;
	bh=vQYW8NkeknDFxmdsiHCPbZW1E67XgtFXdvWKpJk6Ejw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5sBO66UXrPIVgIOSm5ylrIisC0Lec8DmQIwoP82YNbwFUbbBNX4a0QKblRplvuSXCkiQBveK4WMYEbqJhP+4hKLkStVO7riTy+2ZQtCKUsIhzpdBjlhQj9gShIR20FktOZU4uJByrwRMFHvzqNfcxOuRgEsbjjJVbmG9N4zsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/YBucrX; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/YBucrX"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so74270a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790983053; x=1791587853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CI6qAqATyeIeEDwUgJX5pEeRwbkwR8o7zikonxdsfbU=;
        b=m/YBucrXaS1oY1UcUs1yHHFQh+irOkCDEUA01jHXC2loJzkBnBDO3qsYxip5kIjniR
         iJAtRNMRjm/KoTXzmWkYV9W2E11CX130j9JX26Tal1ksietcRlqZpqUiPn4BGqc33i5d
         wEu6SGcUwAX31/oT0qXFRx+37+CREcLc+cwDhcsH1LUP7V5CcEPghVA/EdWBjpeoUwhW
         S4UglP2j1ovjH+XUARqtq36Cuyo9xeM/bDdi5JpHVwKxvx8VFeSeHx/yxBauWyffRyjs
         BIGM+uo3R6yAGa7wsRRd24jr9j4B9GAd+rXewvG33+WlftjsG1SwPXvPZgdUdH1LVxo5
         iv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983053; x=1791587853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CI6qAqATyeIeEDwUgJX5pEeRwbkwR8o7zikonxdsfbU=;
        b=OvBHXhuz0yhhd1DXx9o71HjIFUMoMb74NIUshGS47qvo7wbovxU0XgJtEOcvcZLcRA
         AdUq64Vpc87aX3V2YWF5myvwNytA6CX/xxJlNsLFVrhqtwrP7FsXLVDfc+eQSuhmM3Dd
         f0VPopjQdOmrSNNLHoOsOL8L5AH9lpk0fYwrCTIT6kS7htxj6zmtkh6/1weZIQrwBc+C
         ykcNfuqZCNwFbWc/68pL4dP28Lpv0hh/fEz7GDaBCoTvTRjE2Dz+KB52zyND1u6WBCqT
         s23syQvF+3nWzxvE61siZp3K9ixKtPVuqPxDkiT/9ztMSA56GVZM3cG8Zi/sQ2giaG5O
         P7Yw==
X-Forwarded-Encrypted: i=1; AKwUvByrDLpFTS/v0y5gw1VIpXM2Hhk2NtkGon+uUDt63fnfT0vlYIEZEbgLe6rRsRsW09fIBC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8HTpwH0/fjPisL5GtjEpntbFQSDSspH1kKQfjjLE9F0sOdGzd
	bN9DeM3VN8WWhhHrXXMijSAaje3L+TUk/NsJdO6nMUztvQKLs5Ko8T7XzXlX6xYpE9KLY8AhMmu
	eOdFK7w==
X-Received: from pjbnm15.prod.google.com ([2002:a17:90b:19cf:b0:3a4:a25d:8869])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55ce:b0:3a4:a383:f9cf
 with SMTP id 98e67ed59e1d1-3a6ce7cea1bmr4001396a91.38.1790983052501; Fri, 02
 Oct 2026 16:17:32 -0700 (PDT)
Date: Fri, 2 Oct 2026 16:17:31 -0700
In-Reply-To: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <e61df396-356f-4ef2-9c3a-db3c05cb5c52@linux.alibaba.com>
Message-ID: <asA7ixFlhNJpANoR@google.com>
Subject: Re: [PATCH v2] x86/kvm: introduce pv idle time
From: Sean Christopherson <seanjc@google.com>
To: He Rongguang <herongguang@linux.alibaba.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, vkuznets@redhat.com, 
	geert@linux-m68k.org, sammiee5311@gmail.com, lirongqing@baidu.com, 
	schuster.simon@siemens-energy.com, kai.huang@intel.com, 
	shannon.zhao@linux.alibaba.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="us-ascii"

+Vineeth and Josh

On Tue, Jul 21, 2026, He Rongguang wrote:
> Hi, this patch introduces a PV mechanism for guests to publish their
> vCPU idle state and accumulated idle time to the host. This allows
> the host to efficiently determine whether a vCPU is currently in its
> idle loop, and knows vCPU idled for how long. QEMU patch and ARM64
> support patch will follow in a subsequent series.
> 
> The guest writes a GPA pointing to a struct kvm_idle_time via
> MSR_KVM_PV_IDLE_TIME. When entering idle, the guest sets the flag field
> to KVM_PV_VCPU_IDLE. On idle exit, it clears the flag back to
> KVM_PV_VCPU_RUNNING and adds the elapsed idle duration to idle_accum
> (in nanoseconds).
> 
> The host can read the flag at any time through
> kvm_arch_is_vcpu_pv_idle() to make better scheduling or resource
> allocation decisions. For example, host may overcommit those vCPUs
> which are mostly idle. An in-guest agent may be absent, or may not
> report the status in time.
> 
> The accumulated idle time provides visibility into per-vCPU usage for
> monitoring purposes. An in-guest agent can report VM CPU usage, but
> this PV mechanism allows the host to obtain guest CPU usage even when
> no agent is installed. This is especially helpful when the hypervisor
> enables exitless-hlt/mwait (for better guest performance) or when the
> guest uses idle halt-polling, both of which make QEMU vCPU thread usage
> deviate from the actual in-guest vCPU usage.
> 
> This feature is advertised via KVM_FEATURE_PV_IDLE_TIME in CPUID leaf
> 0x40000001. Guests enable it by writing the appropriate MSR during
> initialization, similar to the existing steal time mechanism.
> 
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
> v2:
> - grab kvm->srcu in kvm_arch_is_vcpu_pv_idle() before calling into
>   kvm_read_guest_offset_cached().
> - return KVM_MSR_RET_UNSUPPORTED instead of 1 in MSR handling if
>   !guest_pv_has(feature).
> - in set MSR handling, set vcpu->arch.pv_idle_time.msr_val after
>   kvm_gfn_to_hva_cache_init() return success.
> - in kvm_arch_is_vcpu_pv_idle(), remove ghc->memslot check, let
>   kvm_read_guest_offset_cached() handle it.
> - in kvm_arch_is_vcpu_pv_idle(), no need to use struct kvm_idle_time
>   local variable, it is too big, just use __u64 flag is enough.
> - remove some straightforward code comments.
> 
> v1:
> -
> https://lore.kernel.org/kvm/36863cf7-61b9-4885-946d-1608179fcab4@linux.alibaba.com/T/#u
> ---
>  arch/x86/include/asm/kvm_host.h      |  7 +++
>  arch/x86/include/asm/kvm_para.h      | 19 ++++++++
>  arch/x86/include/uapi/asm/kvm_para.h | 24 ++++++++++
>  arch/x86/kernel/kvm.c                | 68 +++++++++++++++++++++++++++
>  arch/x86/kernel/process.c            |  7 +++
>  arch/x86/kvm/cpuid.c                 |  3 +-
>  arch/x86/kvm/x86.c                   | 69 ++++++++++++++++++++++++++++
>  7 files changed, 196 insertions(+), 1 deletion(-)

I really, really, reaaaaally don't want to take on any (more) PV scheduling ABI
in KVM, if possible.  And I definitely don't want to take a bunch of one-off
hooks, e.g. for idle tracking and then for something else a few months/years
later.

Vineeth and Josh are working on PV scheduling via sched_ext and I assume additional
communication channels.  I'm guessing idle state is one of the things that'll get
communicated to the host?  I don't know the exact status of their work, but they've
got a slot in the sched_ext MC at LPC:

https://lpc.events/event/20/contributions/2482
