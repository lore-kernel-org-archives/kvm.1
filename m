Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CF36921E
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401120; cv=none; b=FhdR/LqhkRgrtfpufXtNBG7P66XzFHEo5fDVsOpmPMtiFos3TqfnS3F0gBbj3YK+LGXtA1spmRZv5G8S5e3YDO645JM1A7TQhMVBCdoe/66iPAwGFwqErvfNxQQ8KU8i1ygX67Vc+kTzIAJ3yqWNl5AZfUmyCJ3qovt4V6NGx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401120; c=relaxed/simple;
	bh=RvvP0kRRmyCDMDIDJ4ncYNus69AHU02jK9lGrDT7lUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V38kspn2ZDbPRfQEgmQs+yidBMjYrJtttjGkOqtU3p2gnC5kejhCc66wsB9po4UkiCI1tLGCxjpPHb310EoIo+XzBWRXIodif3HuonMlJwXrKnn1e1OjXGBUhCOX8mttLFrlQrXLZw+eL9BJOPVOtnKatCTnPLRYMry6o0zRVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDztyGSC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qEyc7PBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDztyGSC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qEyc7PBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792401117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
	b=YDztyGSC/OgWwDMELqS9lvsaszDZb533k5o7cKshJIp83B553jL0f9CB3pVxWjlI2gNW9N
	+4NpacNV/L1Rnjlqi5d1Pbcp2tK7DPWtD/TnXODIZFqC9+EcyZfXEfYLfw9O6o5z8kRD1m
	SultUdHzq2ymsiDveZcFVPVV2/EeD/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-FyJQyZqqPCiU_CVNOfL3AA-1; Mon, 19 Oct 2026 09:11:56 +0000
X-MC-Unique: FyJQyZqqPCiU_CVNOfL3AA-1
X-Mimecast-MFC-AGG-ID: FyJQyZqqPCiU_CVNOfL3AA_1792401115
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1cf5e7012so15272755e9.2
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792401115; x=1793005915; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
        b=qEyc7PBVb5m0NbuepYIUqXBRGIE/0TPB5EGNOA/bqq1esKw6o/nUwRaeAuxhNd9xfC
         XNP4ZN17mGD067TMIOl2aAvrmY9sauZb9XuBK4AnHRFDAJlZKQz70kHoww3DyvZFsDPy
         +xj8VyU+tKOtwXnT54YNryubZp1btYr9Q525CeCGpBeKpvC7zRBdWUJfsxRaU6ubCT2V
         LtWQLLv5n9NpR/xTzcrfluHS0kP+A9C9thQZzTuvwoljmixWPnjB4HOuSL3GuuI92Ai8
         ZISgS/3XYnvtAOrYZlJkWswZpbIRkinUormUBLbO2fi3LaZ2Iz0prQeBqnzjGpjL920X
         t1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401115; x=1793005915;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
        b=A8TyCcrmYGQIKCftSRQvfX2t4D8asZt6FU4u8WB7IiUZlh7Iw87UAeD0foiwTA0i4O
         qAMO6x+coDdzxZqKF3UvXw5Turq/wyQtgqBLF15cie0amukBiZ4LBcYVqfiPRnDYxiHp
         lX28KvIU9Vc2e4lyjaCI53YubSNRud/asnBRPTmS7LpapOtEty9M7v7iRkj3H7IXNSbd
         ficCr5RYhDANekfiIriVVe2KDmxX/IlVp8+8g2Xg4QGzu5VCEECYFdnwolHX/7KCVPSN
         EJUfqhN7FMJK+s0/WkPHCHa/nhMJcnLKTwdE1/d8EVHmM4xbVJCw+EMPUkEykPLhohVp
         SP7g==
X-Forwarded-Encrypted: i=1; AKwUvBxivBdX5XwXz1N+62PWYlBzbOxCTZNxRvFzFCWDq+C2DF7AupntEp4ypJypx/blPAu/x+Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDZF3uztOqzWmpamAnqU6K5gnCoKQ6nIRTSm4kudOixHLT1kpH
	XdnyaBqbbmd6UlX7HxhoO1814tXGcIlY65a97uobakBZ48b+xEAe+Zwdjs5lqCVhKGm49vTxBQw
	L1z6Ps0mw+HlVHJoYyZ3vscD4CJQdB1caE6/QnbhT9wiTvO6bpucQZs7dV26pgw==
X-Gm-Gg: AYBFou2PPevKSOD3ZDbxZ6KiL65op05piVXmj70ouNx/6dXlYMxHGTaVy6qzUfZOWyC
	zyDoUeQpRnIKF3j5oo7m0Nvac7DkFAaL89pQ8ToYxpwhLrgvhc+3UUntUzBrfCGNnsfgskh1buF
	9IiB5FKRlCcTaF0W3oNCKIMrPI/aeTjSnP5+/086cpRZTVOjZD+pdVFnXUHNA9RGlLhlVZ0HOIj
	Cc7d2KT26ocqqFnbyJZnsMwVQkUBXFrXbUgOc6mZ/GT1v1jhNGMjBjEutM7Lzn7v0wUalc+nO9k
	TwoGsvGa4Wb8KBncpuFh3I7IFQTb0AwduN7+W41Xjf5r8ofM19V3JIlq8fxNelX1Q0FV/mDPzpL
	txjVAtLbYrNeaxtEaQPsH8flmgilblGDT2GUw1DCB7w==
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a1d75e6f32mr142061075e9.5.1792401114939;
        Mon, 19 Oct 2026 02:11:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a1d75e6f32mr142060435e9.5.1792401114368;
        Mon, 19 Oct 2026 02:11:54 -0700 (PDT)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8a81587sm505305865e9.1.2026.10.19.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:11:53 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andrea Oliveri <oliveriandrea@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, Andrea Oliveri
 <oliveriandrea@gmail.com>
Subject: Re: [PATCH] i386: Hyper-V nested sleep states enlightenment
In-Reply-To: <20261016234027.1002275-1-oliveriandrea@gmail.com>
References: <20261016234027.1002275-1-oliveriandrea@gmail.com>
Date: Mon, 19 Oct 2026 11:11:53 +0200
Message-ID: <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrea Oliveri <oliveriandrea@gmail.com> writes:

> Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
> Security) allows hibernation of its root partition only if the parent
> hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
> it, so such guests report "The hypervisor does not support hibernation".
>
> Add a "hv-nested-sleep" property that sets the bit. It is a hint
> only and needs no KVM support. With it, Windows 11 26H2 with VBS,
> HVCI and Credential Guard hibernates and resumes.
>
> The nested hypervisor uses the bit for one more thing, on resume:
> instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
> TSC and the parent reference time saved at suspend, asking the parent
> to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
> the nested hypervisor ignores the status and already compensates the
> TSC jump in software, so the guest clock stays correct.
>
> Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>

Please take a look at the competing proposal:

QEMU:
https://lore.kernel.org/qemu-devel/20261005194057.10910-1-hmushi@amazon.co.uk/
KVM: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/

> ---
>  docs/system/i386/hyperv.rst    | 10 ++++++++++
>  target/i386/cpu.c              |  1 +
>  target/i386/cpu.h              |  1 +
>  target/i386/kvm/hyperv-proto.h |  1 +
>  target/i386/kvm/kvm.c          |  5 +++++
>  5 files changed, 18 insertions(+)
>
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index e1babffb0f..4b37d5536b 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -187,6 +187,16 @@ Existing enlightenments
>    Note: enabling this feature on old hardware (without APICv/AVIC support) may
>    have negative effect on guest's performance.
>  
> +``hv-nested-sleep``
> +  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
> +  Security, or with the Hyper-V role) that sleep states are supported for a
> +  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
> +  on top of KVM disables hibernation (S4) for its root partition: Windows
> +  reports "The hypervisor does not support hibernation", and an S4 attempt
> +  makes the nested hypervisor reset the machine. No KVM support is needed: the
> +  bit is a hint only. On resume the nested hypervisor issues a hypercall that
> +  KVM does not implement; the nested hypervisor ignores the failure.
> +
>  ``hv-no-nonarch-coresharing`` = on/off/auto
>    This enlightenment tells guest OS that virtual processors will never share a
>    physical core unless they are reported as sibling SMT threads. This information
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5da80ade70..9df628ed2a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
>      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
>                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
>  #ifdef CONFIG_SYNDBG
>      DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
>                        HYPERV_FEAT_SYNDBG, 0),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e7a88074c0..bff8b1d192 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2374,6 +2374,7 @@ struct ArchCPU {
>      uint64_t hyperv_features;
>      bool hyperv_passthrough;
>      OnOffAuto hyperv_no_nonarch_cs;
> +    bool hyperv_nested_sleep;
>      uint32_t hyperv_vendor_id[3];
>      uint32_t hyperv_interface_id[4];
>      uint32_t hyperv_limits[3];
> diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> index a9f056f2f3..df6ce6ae42 100644
> --- a/target/i386/kvm/hyperv-proto.h
> +++ b/target/i386/kvm/hyperv-proto.h
> @@ -81,6 +81,7 @@
>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
>  #define HV_NO_NONARCH_CORESHARING           (1u << 18)
> +#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
>  
>  /*
>   * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index da922f72d7..76f1a37ea5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
>              HV_NO_NONARCH_CORESHARING;
>      }
>  
> +    /* Only a hint for a nested Hyper-V: no KVM support is needed */
> +    if (cpu->hyperv_nested_sleep) {
> +        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
> +    }
> +
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_IMPLEMENT_LIMITS;
>      c->eax = cpu->hv_max_vps;

-- 
Vitaly

