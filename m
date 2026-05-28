Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54533C3BF5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965409; cv=none; b=a+aoV7n1NcFcHNch8iyWP0+SChYFBRGFvYHefZe1PnNfJBWowrXDLrFIvBoL4PlZwFjqc4LfgSIYdwdqtaAKXC8ut9RuA1OCBwaBeDqzOkwmWVzK845yOThMjNGOxeMfZWCPbbo/xyKx0RdtC96Kzb748Ppq9MRKKg2WOkkdKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965409; c=relaxed/simple;
	bh=eCJWbK5m+tNvzAyjDy46Navw29cBVreFmRG2Woa1MAw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nmdlXuVLV4KiErh7dEFFudMI7GrVkDIep07vstUbMsKP/MqJffmFzzrnIIu5TjPLU/q7XOvuWQgamxooLdkDSFkAXSWfozIQtw3+ulWhIjFbJfV8ulHIsrfmEOAwbpCZ6PGN1DkIhgs0ByX+f25nA5GdxZFfPTUDQjqcsw8QWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuqAh1/r; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuqAh1/r"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf125989f2so1575535ad.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779965407; x=1780570207; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46bMWh+gCQYzpY1dEMifCzkdbqK+/RCfas0dsX6v9EQ=;
        b=HuqAh1/roKoG0hIctEWFdBb2sH5x3sG2/KhuwkiE/htE7DObP/e0nm/OoTr1AuHstG
         ZE1djmIQWj0O8yMOmrZskKqt72gfx4cqqad7Wru2eTIN9iP6XtUnF3nx/I2Afqdyv5Nr
         aiZWZMU5dlll+8A6ztSaMyxo31dMWxI89v1r1w7QJsa//Ib1dFhdz7+sZOHepzbzITAT
         3eK/KcG9au19qgI0xrojwTeDJArN1MMu/mTEX3ZcRLBoPkznIOpYyaWi9ZPN5xFluz5t
         ITu9hC4Bv5EasiDfhr8zuuuV1odUJ4kSiPhy2iJE6NAUbfLYNtA1x5DBm2umglUA0Y3M
         Kr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965407; x=1780570207;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46bMWh+gCQYzpY1dEMifCzkdbqK+/RCfas0dsX6v9EQ=;
        b=MqBrxPpMG6a2UR5RZRdDomr1jn545CNwBGEn0e1hiQ44Z3aZ7btAQ4q7a21GYvrfmB
         4Sr3H1N1tbnZ6fy636Skt1JLHkA4G1PcQsRfDzfk2FM+Y0v2TDOHURNUaORTsPgQ4KcC
         io+3PQD3znRSYeWsrRTPjPLy03BKXu3OczA22g4pemwwWX2tNAR5H32DzWba7dvM5Gta
         Y6YqcqgV0KbnTMmd7BBPyLSW5p7PRxRJT8qQ50cwpoIKzW2kUWb3n1AnVIMUa4jnZfgs
         pIbrsN8oOjX98PaP5FG+PZqt6tfqJZ/QQpAKKMJzuzzy/EtkGf204gz/9dN6FobccbWz
         CJIg==
X-Forwarded-Encrypted: i=1; AFNElJ9ry8m1QooKR+X6OAJpEgMu1rEkaiIu+MqXfem3NGv4h7FwlYp/Z6x2ffAznRfNn1fcrFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/O0J9mod1zlDf1m7kkTnqamBYJUjDiexKDI/qFWeKyslzgqcH
	ka3MvuSJD8HiSKuv1jJDj8qPe8cm8xFUBHa0+qcu/Hm9g59taCoC5tTm
X-Gm-Gg: Acq92OE2BaHr+XgMiHUc3xH0eI36KSfCN5AaPROJnMKoHQMon+DiGp6fBbFUuul9ffq
	Euc1upN/iZsZraEFUleNL6bZoeCqOihZsh7y/Y7+tNvrWSHlb0EN4tAQ+IIZqHbXZ0+g8nLrjhr
	Nkm59Wazgr9DUeioNMmS7YRq5KVhXeA+HqGgBWQGKovmIFP94EAXw3+sbRj19Et7gRhP4C1DLuO
	PzioG/wlpynFgqqQTROIbeN+YMEG6drKwseyrAIEYz7sVMLKSmhl2SUcOnWQJr2aGur07xC4ImU
	37ZsWu9H5Tz9CMdrh3PNSVhs6JcxAIbwGwaYYZDWTTOmpjucxFm0HStwAKshQaIOldqZFODNfAO
	+zsNUMg+vhK169ee5rEcUe/aglL4CQOuqigK9Vwsls5fPIZffxhRuyxVNVxiKrNaQxPgqM8yk3a
	40TlvnYj9wkXuzCCsrBUgN6AmSZ4H7tAqF
X-Received: by 2002:a17:902:e845:b0:2ba:4f37:d3a7 with SMTP id d9443c01a7336-2beb06a63c6mr311583635ad.27.1779965407101;
        Thu, 28 May 2026 03:50:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc151sm180571765ad.24.2026.05.28.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:50:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260522152744.55251-2-amachhiw@linux.ibm.com>
Date: Thu, 28 May 2026 08:43:04 +0530
Message-ID: <pl2g6xbz.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor

s/H_SET_STATE/H_GUEST_SET_STATE 

> rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>

I think irrespective of the other UAPI changes, we should still get this
fixed - so that we don't see a late KVM guest boot failure msgs.

So, in this review, I would like to mainly look at fixing this issue
first and would request if we can defer the UAPI changes as a separate
patch series please.


> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_SET_STATE hcall and provides a clearer failure mode.

s/H_SET_STATE/H_GUEST_SET_STATE

>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..249d1f2e4e2c 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			guest_pcr_bit = PCR_ARCH_300;
>  			break;
>  		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
> +				cur_cpu_spec->pvr_value) {
> +				return -EINVAL;
> +			}

Instead of the complicated check can we simply do this?
			if (!cpu_has_feature(CPU_FTR_P11_PVR))
				return -EINVAL;

which means that if the Qemu is trying to set the arch_compat with P11
PVR (arch_compat) and if the host cpu FTR doesn't support P11 PVR, then
simply return -EINVAL

-ritesh

