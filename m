Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19E45D5CC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251014; cv=none; b=bI0H/3rDDWTHQfGtd3L2eS2AMoYsj6PJTH5IRIQFC8ISTSoWQfCDy1oRs3ruFeIXjUaBqxkgITJcmQHr9PEppM1RH+vj7R9xLh+PXyUmAx5I5vGQKG1qSgiiR2cUYxhdN64B/DS7SOea9l5MCMZVZ4XrxJrIg0iW3zseUpj/AjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251014; c=relaxed/simple;
	bh=hIVcqP8IkbXdEvAVrx9UZOmaCWM+fGv6qI4uDdHcY38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dWy4hbulvaVcgJbVgqZVrllOZva29njGH3TAu1P67NRptMS3u2CLvyeDOyZ63cveXJLf/Zje+8/iON3JKYonkSG40B1/E1uagIraQkOXkvJHs42+JKObdX5T6BpqkeDo9p4lx3xREZmLKUsXfBjjHbHKEj7xlausDcuS+atsc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+cEP0rC; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+cEP0rC"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so5324913a12.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785251012; x=1785855812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cmz/vsXRUMZv1Bs7M6vVZ40nqLuwQAkuUYyxZxIEXck=;
        b=C+cEP0rCkzMS6MpF+sBwSRW7poe8vaZjTJH4yyDYgTyM5lgvfrAUAWuPupv8zXTh6S
         nyAI2Dy6RSkstnNtxjmfofjBjp8IoE3vvJ1narF78LrX17U6u9hoE4HDO+9DF0bJxeSQ
         2JIt+9d/swqfKohBkW7qoQldiUd28nkSyfj5qugoQoM4dN5KXhLfBC3EFsZfiEOKYXL2
         3B41B6t1vRRm9lXWe8znvk7F6nVt6cLmQaxdZafZtxVbTAETbcsCalurMOVI7nKb0N+5
         f8IAdcKcn4Mui6dlD2WE6U2d0uK1hUxHVJAj/77WFFuFTyOSjC1/rLziyZYNI7aWR4Ee
         U5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785251012; x=1785855812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmz/vsXRUMZv1Bs7M6vVZ40nqLuwQAkuUYyxZxIEXck=;
        b=AUBJN5Bd0EY4SxTHKIh3hx3+VYo13thBY1A183zX0lIwn2sEmilJroqZQfCfLxzOoT
         pq2aYGCqKWDjkMZDLrrO+g0qAeDl3g4qP62xyBDqhFHQst1hQVj9gKr6EUh+OwHwY8JV
         +XOpBkXgBSQLwiwyhKsP6+i26m4LYVtfMUq+w775t+qYpH7aAaENNxndXbTnQ5PxmyL9
         /9s1VkFzgyikqtv1Q6aFO6j1aN0rhlCl4pjNNCK6JENNVeECSPVSVKFF6s5U+//bcrtr
         ACwO3CdeLWydd2fw4LIUOvOToy2YZqy7RTJjS9kMJrBhtiRLdzXwoxjgguw2qAbrgcDj
         L23g==
X-Forwarded-Encrypted: i=1; AHgh+RpbHdKBE0NDEweNhh83O9JiGB89xtfiGDKR9SvuB1VnCnvLqhT0+I27+SrJDeuGtUV5hiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfB1WTI7pEabPWRbgJ5+ZFKpgra/djrXf+anVGfEM/rtwpt+Lq
	GNA7qVa2TnFFdPHdttyyuNwY7IdiXfaFebSvkCwVNRNV5OZYopwzPaCbGPJu+fJw3UM/76nxyc+
	1IJVjUw==
X-Received: from pgmr31.prod.google.com ([2002:a63:205f:0:b0:c92:11a5:bbca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:648e:b0:3c3:9c95:c0f1
 with SMTP id adf61e73a8af0-3c8ba5421c7mr3719989637.41.1785251012054; Tue, 28
 Jul 2026 08:03:32 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:03:31 -0700
In-Reply-To: <20260724234914.987987-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724234914.987987-1-jmattson@google.com> <20260724234914.987987-3-jmattson@google.com>
Message-ID: <amjEw9QcQN7owHKF@google.com>
Subject: Re: [PATCH v5 2/2] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: pbonzini@redhat.com, chao.gao@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 24, 2026, Jim Mattson wrote:

Sorry for the late review, I didn't actually look at the code in the previous
versions.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a07faa066ef0..ebe83a641473 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -153,6 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
>  #ifdef CONFIG_X86_64
>  static int __read_mostly cpu_preemption_timer_multi;
>  static bool __read_mostly enable_preemption_timer = 1;
> +static u64 __ro_after_init preemption_timer_limit;
>  module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
>  #else
>  #define enable_preemption_timer false
> @@ -8306,6 +8307,26 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
>  	return 0;
>  }
>  
> +/*
> + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> + * VMX-preemption timer may expire earlier than expected when programmed
> + * with large values. The workaround is to cap the timer value to strictly
> + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> + */
> +static __init u64 calc_preemption_timer_limit(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (cpuid_eax(0) < 0x15)
> +		return 1ULL << 32;

Tracking an exclusive limit is cumbersome because all of KVM's usage deals with
the max value, i.e. it forces all usage to effectively do "- 1".  I also think
we should go with "max_value" instead of "limit" so that there's less chance for
confusion around whether the limit is exclusive or inclusive.

And we should provide a local "const u64" for maximum architectural value.  The
other option would be to initialize the global to the max architectural value,
and then do early returns here, but I like explicitly setting the global before
checking it against use_timer_freq.

> +
> +	cpuid(0x15, &eax, &ebx, &ecx, &edx);
> +	if (!eax || !ebx)
> +		return 1ULL << 32;
> +
> +	return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);

While I appreciate Sashiko's paranoia about "((u64)ebx << 25) / eax)" yielding
zero, I think we should treat that as a WARNable offence.  And to avoid a false
positive due to running as a VM of a misconfigured hypervisor, I think we should
only apply the erratum workaround on bare metal, i.e. use the maximum value if
KVM detects X86_FEATURE_HYPERVISOR.

So this as fixup?  If this looks good to you, I'm happy to post v6 since I've
already got it locally and tested on CLX, ICX, and EMR.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ebe83a641473..dae41842a9ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -153,7 +153,7 @@ module_param(dump_invalid_vmcs, bool, 0644);
 #ifdef CONFIG_X86_64
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
-static u64 __ro_after_init preemption_timer_limit;
+static u64 __ro_after_init preemption_timer_max_value;
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #else
 #define enable_preemption_timer false
@@ -8313,18 +8313,25 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
  * with large values. The workaround is to cap the timer value to strictly
  * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
  */
-static __init u64 calc_preemption_timer_limit(void)
+static __init u64 calc_preemption_timer_max_value(void)
 {
+       const u64 ARCHITECTURAL_MAX_VALUE = UINT_MAX;
        u32 eax, ebx, ecx, edx;
 
+       if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+               return ARCHITECTURAL_MAX_VALUE;
+
        if (cpuid_eax(0) < 0x15)
-               return 1ULL << 32;
+               return ARCHITECTURAL_MAX_VALUE;
 
        cpuid(0x15, &eax, &ebx, &ecx, &edx);
        if (!eax || !ebx)
-               return 1ULL << 32;
+               return ARCHITECTURAL_MAX_VALUE;
 
-       return min_t(u64, 1ULL << 32, ((u64)ebx << 25) / eax);
+       if (WARN_ON_ONCE(!(((u64)ebx << 25) / eax)))
+               return ARCHITECTURAL_MAX_VALUE;
+
+       return (((u64)ebx << 25) / eax) - 1;
 }
 
 static __init void vmx_setup_preemption_timer(void)
@@ -8338,7 +8345,7 @@ static __init void vmx_setup_preemption_timer(void)
                cpu_preemption_timer_multi =
                        vmx_misc_preemption_timer_rate(vmcs_config.misc);
 
-               preemption_timer_limit = calc_preemption_timer_limit();
+               preemption_timer_max_value = calc_preemption_timer_max_value();
 
                if (tsc_khz)
                        use_timer_freq = (u64)tsc_khz * 1000;
@@ -8349,8 +8356,7 @@ static __init void vmx_setup_preemption_timer(void)
                 * value.  Don't use the timer if it might cause spurious exits
                 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
                 */
-               if (!preemption_timer_limit ||
-                   use_timer_freq > (preemption_timer_limit - 1) / 10)
+               if (use_timer_freq > preemption_timer_max_value / 10)
                        enable_preemption_timer = false;
        }
 
@@ -8392,7 +8398,7 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
         * It's possible that it fits on later vmentries, but checking
         * on every vmentry is costly so we just use an hrtimer.
         */
-       if ((delta_tsc >> cpu_preemption_timer_multi) >= preemption_timer_limit)
+       if ((delta_tsc >> cpu_preemption_timer_multi) > preemption_timer_max_value)
                return -ERANGE;
 
        vmx->hv_deadline_tsc = tscl + delta_tsc;
@@ -8426,7 +8432,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
                vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
                vmx->loaded_vmcs->hv_timer_soft_disabled = false;
        } else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-               vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_limit - 1);
+               vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_max_value);
                vmx->loaded_vmcs->hv_timer_soft_disabled = true;
        }
 }
