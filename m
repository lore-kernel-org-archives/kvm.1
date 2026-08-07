Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E54280CD5
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077173; cv=none; b=lKPj2dBPYof3BzTJo7Cu2Rjtj4qiowjo3wP+7k3TtKbjXbi+1b2sSjLfgMaCL9WExTjzGc9bvpofSfA44QM7p1KjB9CezSqov5D7ar/7gofgzOrQmD3XwD3TpO9uOZPJnNePhhY/OQS7R0puVmGBdeeK4+dGBWASivzGTbEiWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077173; c=relaxed/simple;
	bh=M3Lxbp9rzrBW5TCqXW/t/Ptj2VwgFqJHT6weFnFcgEk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=skV+8YSGgEPvpvgP9nEH0yiLhjdpWtoQvJihb2kGt7AaA7aYk7UCk99GGnGibVUWnNmjaUR9BYePPgx/gxow0csEuf3FYJSm63JioLgmhFtFZVDKdumcX+8WdH5IzNih0k/5HNLbIWhuEnYh05z6iZvsVk7LJi9e6Mf/b1h6GHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW9/78tN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW9/78tN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc73e322dbso33459085ad.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077171; x=1786681971; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vkqjg35/cvh8GomrXzxAYhQLuU0mAPIeu9aJpH6Zlvc=;
        b=IW9/78tN9BAiO31trfDNiSFhqIiAI2IxSE/U8vcPevtcygNJeSkHRnv4Ht/WpJPSEW
         BGl6jyWRJGyk2msDmjB/8IJu2Y4EF+Mjrdp9XddAm9Wbg3TPkdMW74GW4QCuvmOfnQhZ
         FJlKCT0dL3W05frwPqri+TvN/VQXnURVK2lFgQMT3O6W6dZ91FZO3atN/+zn/jVr2T/F
         GKM5rFxkxr/T6UhTrKJCWaUIDbyrwexubEz40q0kqtJyLHvuIx9bD9HeBWZihT4/0s8c
         ZqXsn0NlS49A4AsVwnz/SIMu+R2Glso1H5VVw94nf4kcAFfEwg6QIwSYhc47tYdkCmNu
         0h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077171; x=1786681971;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vkqjg35/cvh8GomrXzxAYhQLuU0mAPIeu9aJpH6Zlvc=;
        b=XdIYR8yeRxA+L8DEp2Lj+EdPK2t8XpU3gZUsLuCTZSZuJsKJZXKkLakPv2itu7T8bU
         ys029je121y1ha4WyJi/ecbKRgU18lTaI0uBSmX3jDs4oYdXUtQjBBQY4R8zcZ1/Ok9F
         RF3b9TJSum7QWlyAQMfqr2gdF2v4CwFtuOR/QUYxCZ7k0jxbMskChjrEiDCbA6+T8OHT
         4EI+DLChWxZyRzV2xo37ygBa8oBQIz1bSiv4ycVRQulqypd7A1yNdKdVrsDgtgPf94wT
         06JXYHb+KqrZcw/0C4iWTotxzw744Tu+SM9DW19tlFbM/YPBTwInPVTHTCDHZkoV0rlv
         886g==
X-Forwarded-Encrypted: i=1; AHgh+RrypjyGo0g/N+SNb+qQ7h9CC2qQTjqrjr2fdRHEx5Uapb0Brw5+JW0ZaVp8ugK9t/9Zu2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTDDjwCyxa0lal2uXDPGAHPha/6yJMiZB2vx+bC3ftGZ3pQUk
	bEb41NycVmZbuCgxzvpItXdicO2ZHyPVDWlfg4bWcM/ZBLXB6H35FESW
X-Gm-Gg: AR+sD13OHZhXHdb+RIYGLSNu95p38SF1/nJL9Xz+EHJMOFGFRfJkxPUj1+bAvBM8nl2
	yXQ35P3dZGSh9cXdVzE+LeH89J5c4q81bRVCC5DsE1nsWzYzqcq3aT1e4c1RXTFg9b6nYS8Wl3C
	AKrPAFml2mY6N9seZ13gftGZUpcW/KOzTTEFojRlWop+n3wzdb+vNi/QTgBNWwZWSAPnkyEt2MA
	Wl5t4w+gnj8lQy0/6ZAuYp7BkxtQ++sm9bInTGI+EqdjoAEbvCA7AkRNzdJ3xZkBW2NO1HlLita
	xEXTQVMzGAyuXLsTOkOk1RydPvTXhAiG1EqZ+KYyZjUH053C/x2jkPvHN4z7ec5xdcEtF6gx+KN
	zvi4GRdRm+dsAAQxUyexctjwCqzv9nWon3w1s0PXRasS+qXHPWdKBPBxUIGuKCP8sdo/caKIJ4V
	NYILL+QaAjcNDJKcS3rnrrpc8YzLYSXMK1ZAIYOi1V9BCPXB9KEfJy1erJAT5x/h5dH3vYQg==
X-Received: by 2002:a05:6a21:685:b0:3b3:1b38:d9c3 with SMTP id adf61e73a8af0-3cb85e99243mr23742133637.4.1786077171329;
        Thu, 06 Aug 2026 21:32:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm2604158eec.23.2026.08.06.21.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:32:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] KVM: PPC: Book3S HV: Implement compat CPU capability retrieval for KVM on PowerVM
In-Reply-To: <20260806170645.11892-3-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:01:58 +0530
Message-ID: <h5l6lfep.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
>
> When running nested KVM guests, QEMU derives the host CPU type using
> mfpvr(), which reflects the physical processor version. This can result
> in a mismatch between the CPU model selected by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
>
> For example, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This occurs because QEMU selects a CPU model corresponding to the
> physical processor (via mfpvr()), while the host operates in a lower
> compatibility mode. As a result, KVM rejects the requested compatibility
> level during guest initialization.
>
> On pseries nestedv2 systems, add support for retrieving host CPU
> compatibility capabilities for nested guests on PowerVM. The capability
> bitmap reflects the processor modes negotiated between the Power
> hypervisor (L0) and the host partition (L1) via the
> H_GUEST_GET_CAPABILITIES hcall, but is retrieved from the cached
> nested_capabilities value populated during module initialization,
> avoiding repeated hypervisor calls. A WARN_ON_ONCE() flags the
> unexpected case where nested_capabilities is zero on a nestedv2 system.
> The implementation defines KVM-specific capability constants
> (KVM_PPC_COMPAT_CAP_POWER9/10/11), masks unsupported bits, and exposes
> the result through the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> invoked by the generic KVM ioctl handling code.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h | 10 ++++++++++
>  arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)

Looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
