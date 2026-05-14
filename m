Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2872989B5
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730898; cv=none; b=V+9zmWZkLZo96dml/CcOkH0UF7pq7Jvnj9urMPh+U9g19lI3dmPRXWLOrpP2i0JtnZX09B33XJQ9Q16k6dufLlLt0r7y4jGjhNBglwIWm5G3hV2zcbKrsoBhY2ZA56D3VwXWF1/+rluqIjvpRK+fLB05cB8/5lLjMewtOxlU3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730898; c=relaxed/simple;
	bh=fsjYLSWcc71c+iOmkcD/Wk13v5fBkksJ8/Ir0dWeEvU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mMM6/nRjQ9j/i0qihyMTXhyiEiR7MYQabQepxcvkYrrnUpRq1w9uxLpJgMfkwM+bDu9qpKFrQDiVHHphoV3crViFoqnTiGJJwqpS05MpDOtOHvheXJLVUw9A1y9hOpT20U+uyWGcdvH6VQGlDGvKhTDu+NEWIBobLMr7JNXLnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JACkQY5x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JACkQY5x"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8025aecc40so3736919a12.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778730896; x=1779335696; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PKqV86kcIyK48A4gK3vO7m3hgwBILm7DPz49r+DJUUE=;
        b=JACkQY5xKJCZGQs26Zykmd9Lg1tJcQ4rVuepEZPfSDc4IJarKYmg8sBekobEEsBY4A
         yt2wdD7rVKFHhm00Ew77pL89nD/neAkT54oCT5Ey+ssxK3wSiN7gsgeXEecG4XLpMuf2
         4AK4Lvzt2TKRLWkUNqv1t/A8+JY7YC97NfDsx8PxuUneJowAHOHMC5lWOToOKVpjgkZJ
         IFCs/FLWexHIgSCIyXaRivY48dYSff1D2B8xv/acA+KoMNCKq5o02B3yF7psOgmP1DBO
         /94hkgxFEfWAfX8+rGk8wBrqkDgx704r+C7okeAD5de22NkfdrsOSCQHiElfURs12dD4
         qEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778730896; x=1779335696;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKqV86kcIyK48A4gK3vO7m3hgwBILm7DPz49r+DJUUE=;
        b=CrJhfZfKqKsi/G+1w8DUfXqbKOpmkij6wxpUgXjGsEaiBp1o+q0/8EUYU4OiqpedkF
         jm9Ln/FDnG2fLqqNyZ+UL15fY0pSD1m8KXm5oom9s1Xk1O6Mq+TjuKJx132Acr5f0iGm
         cYJwVQOYQPQJpIo1/+B8tQAGMOP5mKiJwvjGA4v3ovF+zLegPm5OwU+LwHwPwhM1liaH
         mu2hTJZ3sFPkJqBiWhN0RhNlTmrHBpoDLvxB/RjkM9XiWKjs9mYlHB/rpYSBXestDhj+
         xzuk9iXrgQc2N5TZtFRsowVHdT3nz+I59tZlZ3AyEBnZQaU1DnfzwpyB+WVENyY0DIRb
         +QNw==
X-Forwarded-Encrypted: i=1; AFNElJ+bCQiIz3ok3qCIrzc+4D4JCtNUgGkOHB0HMU6v4+lXxoUmrSe5ytFv4ffnhB3e2E9GWC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfhTlTHuAOW2I41YkJNZ6LySq8IKGW+S5v8eCQABJpiNOtduJT
	bS13zWiWBWANNRVaJC6DR3RaC/I+9JiExvbs1CpHrrJ++tF5tWcxOXpz
X-Gm-Gg: Acq92OHfnbguxt29EmAfQh60L2jxribL6eOrIAeDPUPFMgcKtnRWdX9qnMcgXTfRtjJ
	AlA/LMvgZob0a7zRQoGOofyUbtIcdLB9uCtPvQTQ94nDLPcJSUh4mpikbl67vJcUKbeAIFva34g
	g10JJx9r1cFZzpr6jIB/5ACe5g2CH1f+BEHuVT7DvPzwMqf+XuvEU2pq1tPoBUwnX5DkciolfxE
	FSMF3d88Z8eNHsFlTQdjqcfHpZiZJLAx7Bc8Z0pIZh6EjHDHjdwPf0HlCHfjjgXN08SHlcO94F0
	VQdwPsANM+ARDxdDk7IVrXvdE7Gu/KRE2kpseYcXtRnfFCNzphrNrOxxaw+DQRqEexIWGomJYaM
	3nSDRg3de0QfIEXOAzcdOpt0oODAzPCo5dLRare+ExqmjTD4yaSgQU4Zr0aNzcFp7f909g3Pqak
	9ElxvE+Gw0zr17LABT9+95CQ==
X-Received: by 2002:a17:90b:56c4:b0:366:44a4:ab0f with SMTP id 98e67ed59e1d1-3692346f997mr1680017a91.4.1778730896205;
        Wed, 13 May 2026 20:54:56 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede20a50sm4803643a91.3.2026.05.13.20.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:54:55 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] KVM: PPC: Handle CPU compatibility mode for nested guests
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Date: Thu, 14 May 2026 08:49:59 +0530
Message-ID: <o6iir82o.ritesh.list@gmail.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>


Hi Amit,

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, newer processor generations can operate in compatibility
> modes corresponding to earlier generations (e.g., a Power11 system running
> in Power10 compatibility mode). In such cases, the effective CPU level
> exposed to guests differs from the physical processor generation.
>
> This creates a problem for nested virtualization. When booting a nested KVM
> guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
> userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
> and attempt to configure the nested guest accordingly. However, the L1
> partition is constrained by the compatibility level negotiated with the
> hypervisor (L0), and requests exceeding that level are rejected, leading to
> guest boot failures such as:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>
> This series addresses the issue in two steps:
>
> 1. Detect and reject invalid compatibility requests early in KVM to avoid
>    late failures.
>
> 2. Provide a mechanism for userspace to query the effective CPU
>    compatibility modes supported by the host, so it can select an
>    appropriate CPU model for nested guests.
>

Do we really need to add a uapi change for this? Tools like Qemu can
read the device tree info of the host, isn't it?

> To achieve this, the series introduces a new KVM capability and ioctl
> (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
> compatibility modes supported by the host.
>
> The implementation supports both:
>
>   - PowerVM (nested API v2), where compatibility information is obtained
>     via the H_GUEST_GET_CAPABILITIES hypercall.
>   - PowerNV (nested API v1), where compatibility is derived from the device
>     tree ("cpu-version") representing the effective processor compatibility
>     level.

See there you go, for PowerNV if this info is provided in the device
tree, then Qemu could as well just read that info, no?

... yup, kvmppc_read_int_dt() can do that I guess.

So, my request is, can we look into this to see, if there is a possible
alternative to this? maybe we already have a mechanism which Qemu could
use to get this info already?

btw - I haven't given a full read of the patch series, but reading the
cover letter, I felt  we should atleast add this info to the cover
letter on, why a uapi change is really needed here, why can't the
existing alternatives work for us. 

-ritesh

>
> This allows userspace (e.g., QEMU) to select a CPU model consistent with
> the host compatibility mode, avoiding mismatches and enabling successful
> nested guest boot.
>
