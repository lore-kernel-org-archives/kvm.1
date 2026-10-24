Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804640;
	b=0HKHvLeDJlr1Ws2AtomoJnOxDxYLdXzUookuHhqpInTfZa+VI1ozBT9b3ZcNiX3gAeUX
	 xz0O2wvy5dwXn3G6hXv0EPrrQt8gQ9u72dSou89vPqU7e7gNHe8IZRlj3BcQl+Sxroq/q
	 Wvhmdp03iwNZByFfiGtylnccqOfcpeUlgb9xjuNTuw2K+VgovmDaNrZV62FDZaCzRgpVm
	 fgK4kyhxOH8PmfdRzkMDifi7OiDPYdcLimMXxpJEKmek78n3duhPJgP3kGvz72kDbvugV
	 xOToeMrhU6wSuCLcy1URCa8sdUz1KGI6NxMWgOmZ1fNNcLsxZw0gYtdwtpCApnepylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=k2xByoCKDMYQdbnv/CMNI1SrsG+UgozZ52mY92tXu2A=;
	b=kUjdBzAfPx6FCyMKQ7gBAIrf0zBjTuECP9j+YsnRz/evjiii2T47mt4ftMRQR3Pzl40U
	 UUdq5bJaaF7VSbMwI3LAEI5ezafaoYZTo3Upfon349Fv6thhxpQCnkV49Z0lrDdwi4NFu
	 IK49eIUE6sYaZOiNfBdTC9Av10xgWVSMYP8hRy0zZ76O4oyy9TzHGg7TAXTrgYEfVh3nn
	 VLbajaiS50pTBo+13/9+fg15zCT2WCaxReKVNnWMNSMjZFWaPU7zL5aXxUfpxaV5qcjwZ
	 OH4GWx+iT4YqMaz8W/hjVsroUSIibTZVpHE8PV+9hlVIbAonwFyKGdl7IM3Whfl5VVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eHV1Dg0R;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328A606A31A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 01:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F328A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=eHV1Dg0R
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e60770381cso13859855ad.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 18:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792804639; x=1793409439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k2xByoCKDMYQdbnv/CMNI1SrsG+UgozZ52mY92tXu2A=;
        b=eHV1Dg0RRPclMynewx1jnWTuwaoILuMCy80nzB3nrE2EntzzhcMvMNQbwp8rPdDo9U
         KBl7zFP8HgUdE3A5weGUngDuhhfgzQc98lKWqgJCJWW15uBZtvhv1lqiVTSqF4F0xhOh
         tqfTDdFOiQp1NxS8EutZP1o4OZnUFHdQwivgmvOi+KahpWp4BDKQyNvk9SRsJyVzFWkE
         +8ErCNzDM4penAWmboW7rn1zJuEWmNNVf9jBR6gpmommaXsUhmXnrXh0lbNe+Nomu99d
         10MES9ry8iMYhSKubbdt1ylL1CSf2o+ljr88vFKZrmtI9RtSyNnaDoVseG5sibWCPko3
         4HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792804639; x=1793409439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2xByoCKDMYQdbnv/CMNI1SrsG+UgozZ52mY92tXu2A=;
        b=Bl1AEWnl4uvUKnVWkZRiAnA11oK/1q5eHsU5r0ilrDgcKcqpxk1xZX8pirGoX0Yrcz
         mEIIYhYJgLUgiN3FPXYuhd4Spo7WdXkxDPoF59QbOZdRBU8iW2FHntxz7ydlFw8Wbt8J
         FZO1s2oxBn3zwHRRVQE2Wcvl4xyvvDNI1UYLl7xFnoBBJsNFWYPQSJPROsodANXFE7lO
         JAkp7YXSBsPizARabIMCXD3vspnRwbO6Xbaeq1xW+2nuoARHAVKoJaQFpqcfih7gpeJR
         pMuQbG1BxlWXigMpeQbT+Uavx0H8EhbtTJlOhU+gy2Kx0GagqN8lzZOfrZzaajzNj7I7
         IL5A==
X-Forwarded-Encrypted: i=1; AKwUvBwY8ZFya9YpruZe16ZEt/2EvcGHvA/sU3QBeH59LEK6i3Lk32zwXMQOTKVutb4yUstbSp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8OF9wFRZtkGArrSN6N3aviRKijimieufYG/G43azdZalptRmo
	UBBw+C1OAgaWcnXROMq/JXChHEk4DhtqEcccirudXVvROUHM1wJdVWMinezJxjVPEvuJaSCrI8C
	pkbvGGQ==
X-Received: from plbjk4.prod.google.com ([2002:a17:903:3304:b0:2e3:c3e:def2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c7:b0:2e9:7ff5:5459
 with SMTP id d9443c01a7336-2ea9c6c3337mr5775125ad.15.1792804639083; Fri, 23
 Oct 2026 18:17:19 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:17:18 -0700
In-Reply-To: <20261023171307.636760-1-amirmohammad.eftekhar@cispa.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261023171307.636760-1-amirmohammad.eftekhar@cispa.de>
Message-ID: <atwHHh1z3zVzLV4P@google.com>
Subject: Re: [PATCH] KVM: VMX: Add array_index_nospec() to evmcs_field_offset()
From: Sean Christopherson <seanjc@google.com>
To: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 23, 2026, Amirmohammad Eftekhar wrote:
> From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> 
> evmcs_field_offset() bounds-checks the guest-supplied field index against
> nr_evmcs_1_fields and then indexes vmcs_field_to_evmcs_1[] with it, but,
> unlike its vmcs12 counterpart get_vmcs12_field_offset(), it does not clamp
> the index with array_index_nospec() after the check.  The field index is
> derived from a guest-supplied VMCS field encoding on the enlightened
> VMREAD/VMWRITE path, so the array access can be performed speculatively
> past the bounds check (Spectre v1), disclosing memory adjacent to
> vmcs_field_to_evmcs_1[].
> 
> Clamp the index with array_index_nospec() immediately after the bounds
> check, mirroring get_vmcs12_field_offset().
> 
> Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> ---

You already posted this exact patch[*], and at a glance several of the bug reports
appear to be duplicates as well.  Please stop spamming duplicates.  If you have
questions about the flow and/or timing of patches, e.g. since we're in a merge
window, then Documentation/process/maintainer-kvm-x86.rst is your friend.

[*] https://lore.kernel.org/all/20261017093016.32348-3-amirmohammad.eftekhar@cispa.de
