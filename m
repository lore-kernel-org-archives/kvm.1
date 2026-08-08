Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB2A59
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151365; cv=none; b=OctaGSYGc4e4xEzZWGoRtCuWRL5W5QTlaxGgR3HmLBNq+g+s2hwG5OLXeXNbfMh8hYwk+1oLTtY/djU1CVGUQ49NBYad5L+fRQoiMp+mpfOO8AqwCE2IC1EXGKEUoHepkNf/m8NMC4nTpF4yzrq6U0x+HqPBtUp0FP+Wt53B4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151365; c=relaxed/simple;
	bh=MhcB397fB9fZ8OKdkEZCupInxArvrZSMIawSJHA8+Ek=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=FU8yyYsOiwlexiQX8MnRCqnuuExjzdkzicb3U46Z7gfJMU5C3iMvfTJR8lWrs+BY7UizO0rq8aUKiBER/rjkBUFWiTE2g1C/jQ6FgKPXaCr4PsujlCXhmNc7sIVjpWAUy2YcqbQciK5T3srgMGEZA2ch9ty4YNt1VDjZ7ZEwR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfhBXpjE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfhBXpjE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8484f229529so56201b3a.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786151363; x=1786756163; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6xF7Vf0vsAzDGiN9uOUXdMTijirUIpfVi3ov9/6Fs1k=;
        b=mfhBXpjEtC/5v1cIVhlw3L9No97b0YVNag6MsCfrnY85xpM/Lb5pm4ns/lUFssCfvZ
         1bogLjY76QLabrpeVvFfTid2AUtgrxnIU9+tPYvk31Bsrdgdck4XxDRCSZT20X5zp8hA
         H1i/c7Lm6XKc7sOTHqfzl1PlO1z5WXdGW7jCLrcnvaEq6ibiJXRFPmRsB5iGd16ChAF8
         1XuT+NEWFQ+VvU1bTEQKdpU+Xr5Mej+35eptTw0Pydy8q/hBDy/pkHYTlVK327l8dnHp
         ww8BgvCKqzXtGLapHlXkkDiTx93lYGpm4uLlkTUvOrQODngPx93P1QsNxnu7sVfLHRRu
         Du1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786151363; x=1786756163;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xF7Vf0vsAzDGiN9uOUXdMTijirUIpfVi3ov9/6Fs1k=;
        b=I+jvRErhIw+FyZ3qa7t8EfVsY95ebGjnayt9Iiodo7zk7amHasw0s7WGS4CpL3foLz
         T4m6fEYxqm3Sp8mOrZpvGaYKVZbbnOxMMFnSQnt6uynRx+R8Vyql5BCu7nIPx/E/aH2v
         YFlfkAVYIT99kkWqwfnyBGA5GbAzcunQCdkplQBtLiPSpuVtOFLfQuaJJS+VrQO1tRDt
         AdqfpDaUYQtLcLEy2VKHWAW150cKsKrUCbScxJUg+1TtuzhO7PbyZgGBau/1z/eR5mCs
         WEgTl0Am3hvtV5iWVH8bN7ug3PI3ApM+mOcU/FJ5Fh24098n0+N1UJWRdaalqbKt0MDu
         MYhA==
X-Forwarded-Encrypted: i=1; AHgh+RquD3kye4wpuHuucun4dhY+Hwl2h2Az91i7gYjIRMvFDxxXjN6qCy2FwJ3AKIlxR6gAvNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vwYWruUFulNDtr8X2dJAyGOSS3Paj3VqTGqQ/Uvhw9UciMyC
	yrYlOAP7ISX2Ne4fCv5XAtFH2diJzhnu15qvRpYDY1CoOgqGrqMZqCmR
X-Gm-Gg: AR+sD106tlsccU2kOVTnViBZm9AzBvQLaboVwSDet+OW93JfDKjV68khXIz9kEMdnlI
	rXVvwFvFLA731iQepp0Y95yr43ya58y1WsGiD3IyFxnv37SrRthz6JnhwhhFtF8JNjoKhIffGi6
	zC9iEnnccstYEgd5Oz2bXk0FDb6VySNl63KA9pnO60vsJ6CoMScQ/1l7IGu7poGdU0Bn47fP6Fm
	I2U2BBnAaYQxG5OFgGddD1WIhevf2BvSSFG5lwzkg3r8mOm9PNRIawdcBnBQ6wskrZz40FVfpk3
	8mlvYRFMEjkkHErVHQbuuZlIQu7YMPy1oOivOBb0cZK18BpSl/8EjyTCsg7i/DEzwd43BU4+8Ui
	WysDIbo00r58A5SCFi6L/62TUYY0rDFFD6o3W6on2uglIMhXkav/S/fiTBI/jzZjSCabyMQAKKU
	h0gCxG7WZJKDdL3zoOwB1vUxtZjGPNqqHBI+BegcPI83nPd9dUpPb/z+uS8dU=
X-Received: by 2002:a05:6a20:c79a:b0:3b4:71c1:ab29 with SMTP id adf61e73a8af0-3cbce7d128emr5049089637.16.1786151363483;
        Fri, 07 Aug 2026 18:09:23 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141018f18d6sm12260170c88.0.2026.08.07.18.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 18:09:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <20260807172433.82045-2-amachhiw@linux.ibm.com>
Date: Sat, 08 Aug 2026 06:30:40 +0530
Message-ID: <33wpl93b.ritesh.list@gmail.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com> <20260807172433.82045-2-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
>
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
>
> Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> the compatibility modes supported by the host in respective bit numbers,
> allowing userspace (e.g., QEMU) to select an appropriate compatibility
> level when configuring nested KVM guests.
>
> The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> CPU compatibility capabilities via a PowerPC-specific backend
> implementation when available.
>
> The struct kvm_ppc_compat_caps places the 'size' field first so it can
> be read alone via get_user() before copy_struct_from_user() is called,
> avoiding pointer arithmetic to locate the size field.
>
> The ioctl is defined using _IO so the ioctl number remains stable even if
> the struct grows in future versions. It uses copy_struct_from_user() and
> copy_struct_to_user() to provide forward- and backward-compatible
> extensibility: older userspace passing a smaller struct to a newer kernel
> gets zero-padded trailing fields. Newer userspace passing a larger struct to
> an older kernel (usize > ksize) succeeds if trailing bytes are zero (the
> kernel reports back min(usize, ksize) as the filled size); if trailing bytes
> are non-zero, the kernel writes back ksize into host_caps.size and returns
> -E2BIG so userspace can retry with the correct size.
>
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> (24) marking the size of the initial struct version, used as the
> minimum floor for size field validation, similar to other versioned
> struct interfaces in the kernel.
>
> The 'flags' field is reserved for future use. The kernel rejects any
> call where flags is non-zero with -EINVAL, preventing garbage values
> from being baked into ABI permanently.
>
> The ioctl returns appropriate error codes: E2BIG if usize exceeds
> PAGE_SIZE, or if new userspace provides a larger struct with non-zero
> trailing bytes (with ksize written back into host_caps.size for the
> retry); EINVAL for an invalid size or non-zero reserved fields; EFAULT
> for failed copy operations; and ENOTTY if the backend doesn't implement
> get_compat_caps.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - Add PAGE_SIZE guard after get_user() to bound the check_zeroed_user()
>     scan in the usize > ksize path [Ritesh]
>   - Drop manual usize > sizeof(host_caps) pre-check; delegate entirely to
>     copy_struct_from_user() which succeeds on zero trailing bytes and
>     returns -E2BIG only on non-zero trailing bytes; handle -E2BIG with
>     ksize writeback and -EFAULT escalation if put_user() fails [Ritesh]
>   - Fix host_caps.size on success path: use min_t(u64, usize,
>     sizeof(host_caps)) so new userspace with zero trailing bytes gets back
>     the number of bytes the kernel actually populated, not usize [Ritesh]
>

Thanks for addressing them!
The only remaining comments from Sashiko now are because, it cannot find
the implementation of ->get_compat_caps() since it is in the next patch.

So as for this patch, the changes looks good to me. Please feel free to
add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  8 +++
>  arch/powerpc/kvm/powerpc.c          | 78 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  3 ++
>  4 files changed, 90 insertions(+)

