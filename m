Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C723DCD8D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786078899; cv=none; b=DaR7HupbqUDuG6heS5i2ETRZ5qnmnimbDe4pYEE8l2G/4FXmrXOVddhnlREld5YtSG+A4Yw77o6PM+g3xLT0SJ2khDfZcYYoUzTzoOStiR9TLKRVTxyBHKQRTb2gNWKF8Sf5hWw3yDvnW4czR03q6FJPFMJ7942O8DUAey2QZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786078899; c=relaxed/simple;
	bh=GwGIzJRmOrXEhGKC2NN6k5R1SdCDi1PH7dohr9HhOV8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZC5hl98YuUvzwmIK322GIz1ieVfbU3Mdo+r3cvXQN58aVhz4oe/2GzHUZ/fmhZj9Oc01O4koTSjNdzQGu8Mh3yOUeVeggavEWwMho8ykg6Vze3AXn/4AhRkeLL6sDoS2owoDZ6KlWYCH6lPh9vWZOYwOpfwkFyEvn8topujW2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZMtcwK3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZMtcwK3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d0407aedd6so33367255ad.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786078885; x=1786683685; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gaexW5MzRJUBpA4wcPJkWsT4Yi4ofryncF8L6Hb2nTM=;
        b=XZMtcwK3fT1rNTNr4b4iwRClgZJFGJLbLsL8IyR4OZOdwMVYm4H2ijX4ZCFeJ6m22b
         Ucs3C7Fs6zyHS3gmFhCdPZRP9BYeMILMKy/2Xy6ktlIcEX9VZPXzKB2BFj5SuPy5Jyk8
         ZUjH9RacR3v+hwWEYN/zZaSqvVP645PMSRwZcQppSY59hUPOHM07dVSwpB7kw3yG/zSY
         XNJ3ZIko2B8U8L0ozCrDgrwlXJcZtQmccxa+qWog1s8idd3uw4XaGhmo+TmcgfwJrVqm
         Sn9Gb4uxkyvhfvMQndA5k/oKbVeu7l26NpuUrcRNVXf5rwv7FmdVvxu1MnD7MUIRVVG2
         KFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786078885; x=1786683685;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaexW5MzRJUBpA4wcPJkWsT4Yi4ofryncF8L6Hb2nTM=;
        b=oK7nZCRNltIwCtcDtDHql6I+t1Ev2o1b7sePJN/LcpAba/6H3fl9Ze55wUEJb0ZJwb
         DpuTwSYDlP9l3XwnAURitKxL04CXcbb5WBqvH2Gys4860jTCCFc/2OpvGLDMB01eJkI2
         FJ7J/nXp8XBBBEUyEfu00PCD6DdMSfcv+mcD8CKF2QLmiFmJsxA9Y8p4mJJ4jkMPUku/
         NcjMyjasA80h42TOf3hLpkzJRflbU/mMBrZvSLRxwP3TIUY/eyv5Iikd40tatQkos/L8
         qDo1poUyOurMpDPQii1jiO28jV/4HE/a3asvpDBG5RoedyC8KdkS2X0kNUx8rxYswK9p
         ZFig==
X-Forwarded-Encrypted: i=1; AHgh+RqGviOFQr0shH6nH1wn5rZplwOY58S976TYPCjaaa0DLBb81mpy4M0SYmVEsvdAhgSMqyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmVcYzEUgwZNXO462Hu1UGTPu4ebxn2nNPu9vZ+jCb/BBPN74
	GEm0DMzUK1YmhRHpD0PUNT6TthDJUueChP7gAy49Tsxoz3fK2Vvp5UQt
X-Gm-Gg: AR+sD112zeZNfbu7afULugLkcFVmZ7ALf4dMEPCwKXzaWwFfdlVQaLfQPLo0Jrs++Ud
	EFGQ2sjMW94f24PEZbL9v1aSiLR5r7NQnT6jMPHyesbmqKqs3nG8q0iJCnMW9WrzM/h4kAwg8du
	+jnF82v/yiuir5G/BTAmt3EFJEgFw/uGCEfk5GkxtmryhTOnN9hKaqUvc14gxPdW+/Un+3FBOhs
	X2vh9YyvWmSjbkrfHvwDKrFZiyQUT2EXLf0TuJzFClMZzPwhvJVWIYkH601zIymfbVuBNKt7YHy
	NASNMOIOs1Cg/GTLncs7jhL8rxLvwjFThYMp+feOxe+gtMDJ741r/FfTB5r8W6Jv/s3tbdtHprb
	awR5fpbaJAHg0ngpPCUMy8etVvEquz+jPm/2nufp8a/tUi/qAaxuSyQqqCqXwBsK8NG2+Ackwwd
	AXGkmm5riHzOx+6KfDZYTeayj41NkVJ4939oX50Ibmo8bMWEJdaPbYMC7N9zA=
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:983d:e9b4 with SMTP id adf61e73a8af0-3cb8603af0dmr23716971637.33.1786078884954;
        Thu, 06 Aug 2026 22:01:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm3026655eec.28.2026.08.06.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 22:01:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 3/4] KVM: PPC: Book3S HV: Add support for compat CPU capabilities for KVM on PowerNV
In-Reply-To: <20260806170645.11892-4-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:24:18 +0530
Message-ID: <bjbeledh.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-4-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> hypervisor (L0), the guest runs with the expected processor
> compatibility level. However, when booting a nested KVM guest (L2)
> inside the L1, QEMU derives the CPU model from the raw host PVR and
> attempts to run the nested guest at that level, instead of honoring the
> compatibility mode of the L1.
>
> Extend host CPU compatibility capability reporting to support nested
> virtualization on PowerNV systems (PAPR nested API v1).
>
> For nested API v2 (PowerVM), compatibility capabilities are served from
> the cached nested_capabilities value (populated at module init via
> kvmhv_nested_init() using the H_GUEST_GET_CAPABILITIES hcall). This
> information is not available on PowerNV systems.
>
> For nested API v1, derive the compatibility capabilities from the L1
> guest by reading the "cpu-version" property from the device tree, which
> reflects the effective (logical) processor compatibility level. Map this
> value to the corresponding compatibility capability bitmap using
> KVM-specific constants.
>
> The mapping is cumulative: a system running at a given compatibility
> level is assumed to also support older generations down the supported
> chain. Note that unlike KVM on PowerVM (nested API v2), KVM on PowerNV
> currently does not strictly enforce older generation compatibility modes
> for nested guests - the reported capabilities reflect what the host CPU
> can present, not what the hypervisor independently validates.
>
> Introduce a helper kvmppc_map_compat_capabilities() to translate CPU
> version values into KVM_PPC_COMPAT_CAP bits using a fallthrough switch,
> and integrate it into kvmppc_get_compat_caps(). The implementation
> applies masking to ensure only supported processor modes are exposed.
>
> This allows userspace to query host CPU compatibility modes on both
> KVM on PowerVM and on PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS
> ioctl.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 152cd08a5b38..4d0307f55e06 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6523,20 +6523,56 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +static int kvmppc_map_compat_capabilities(u32 cpu_version,
> +					  unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
> +		fallthrough;
> +	case PVR_ARCH_31:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
> +		fallthrough;
> +	case PVR_ARCH_300:
> +		*capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  
>  static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities = 0;
>  	long rc = -EINVAL;
> +	u32 cpu_version = 0;
>  
>  	if (kvmhv_on_pseries()) {
>  		if (kvmhv_is_nestedv2()) {
>  			WARN_ON_ONCE(!nested_capabilities);
>  			capabilities = nested_capabilities;
>  			rc = 0;
> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				if (!of_property_read_u32(np, "cpu-version",
> +							  &cpu_version)) {
> +					of_node_put(np);
> +					break;
> +				}
> +			}

What happens when we don't have "cpu-version" DT property?
Check this commit
5a61ef74f269f2 ("powerpc/64s: Support new device tree binding for discovering CPU features")

And also why do we need to parse the DT properties again?
Shouldn't we check something like this?

	if (cpu_has_feature(CPU_FTR_P11_PVR))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER11;
	if (cpu_has_feature(CPU_FTR_ARCH_31))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER10;
	if (cpu_has_feature(CPU_FTR_ARCH_300))
		capabilities |= KVM_PPC_COMPAT_CAP_POWER9;
	

-ritesh

> +			if (!cpu_version)
> +				return -EINVAL;
> +			rc = kvmppc_map_compat_capabilities(cpu_version,
> +							    &capabilities);
>  		}
>  	}
>  
> +	if (rc < 0)
> +		return rc;
> +
>  	host_caps->compat_capabilities = capabilities & KVM_PPC_COMPAT_BITMASK;
>  
>  	return rc;
> -- 
> 2.50.1 (Apple Git-155)
