Received: from mta0.migadu.com (out-211.mta0.migadu.com [91.218.175.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31DD47CC67
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162331; cv=none; b=NzvfMJyCK9EqmeVoiI/slzBHi9iMV9+krqGEKqk8wDyazsaBqFaFks/asubjiJX4MaGHsr2QFhTMD+e0BXbe93cjkm4ao1VpwYvYMzO+10atiwuz0AV74o34DZzz4UzrSRFQVCG3k6X2YNFxy9Nw0Y9bEEhbNwjSXGTursHD2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162331; c=relaxed/simple;
	bh=89HG7hn4Kzj5UE8Z7ANkfgcmDmkP7G7K3Oq+gIvcB8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfW7qxyr44uC3Xc7pS0RLGoBuCiooKqD2dKdA57QwQvt4TrkFzCRZeRkeF47COY2f5gBwacwDHVG7Az0NH2osbtOMIZG0Ba2gC5XuoRjXN+soNnSQ3I8FUm7OZAcJ4Iuzp6isVcwqmthE0BQIY2upYtbU5+fR2mZmeqi5eRtmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdqMPrek; arc=none smtp.client-ip=91.218.175.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdqMPrek"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=89HG7hn4Kzj5UE8Z7ANkfgcmDmkP7G7K3Oq+gIvcB8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790162327; v=1; x=1790767127;
 b=KdqMPrekLrC/5IiOtG9WhZ7CjRLE8f3T2sv3gCEeaA8Kk8LjD0TYolBhewHVPARf57Irh/EI
 FyJd6Yqvzgh1E3U1gGqmPr/GgdXK42ErwaxJC0qice4LuWuIc4/9F9bHNe9o/d/FQd+DQSiHL/h
 UvvVSlQwLA/xPluADfiSK/9g=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c8269ab479b64a1;
	Wed, 23 Sep 2026 11:18:47 +0000
X-Mizu-Trace-ID: 7c8269ab479b64a1
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b778bdb5b8so4882e87.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxXGVy1sIXsZF3/uMa1mR7Rk2ztTmZB1X1u+w2d+12XZR9C/g4VczrNEpFOIpLmNpNWk+k=@vger.kernel.org
X-Gm-Message-State: AFuF++ljazR3PtCuxlAsf6SYRYBCwerGou0xwvQulUwXPd5F5BFOys+P
	JwOXoKSSm1c0bJgHYg28pRxZ1DVoYPzCTnGUXBFQZtGVfxMxSL/4CmCkoHSo33fR4yj6Y/je60x
	Wl90IGpqfKznrx8XDkAgQPbngBKNBh+yHT/6R0HjK
X-Received: by 2002:a05:6512:acd:b0:5b8:d049:c45f with SMTP id
 2adb3069b0e04-5b8d8853d0fmr127952e87.14.1790162326446; Wed, 23 Sep 2026
 04:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org> <20260922-kvm-arm-prefault-v3-10-787bd3bc7e3f@kernel.org>
In-Reply-To: <20260922-kvm-arm-prefault-v3-10-787bd3bc7e3f@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 12:18:10 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyCc=T+HkvWv1g2Fg3OxGaa1i8Hdv296ivPc94jQqZq9g@mail.gmail.com>
X-Gm-Features: AcwNN1XC5SLsTqs8zqxJrWyrAoHwz-wo27sOUtBe-7VaIdl2y8EQBRd7i4qQqDs
Message-ID: <CA+EHjTyCc=T+HkvWv1g2Fg3OxGaa1i8Hdv296ivPc94jQqZq9g@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] KVM: arm64: Implement KVM_PRE_FAULT_MEMORY
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Tue, 22 Sep 2026 15:18:04 +0100, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
[...]
> +static long __pre_fault_s2(struct kvm_s2_mmu *mmu, struct kvm_vcpu *vcpu,
> +                           gpa_t gpa, struct kvm_memory_slot *memslot, s8 level)
[...]
> +        if (is_gmem)
> +                ret = gmem_abort(&s2fd, &result);
> +        else
> +                ret = user_mem_abort(&s2fd, &result);

When kvm_gmem_get_pfn() fails, gmem_abort() calls
kvm_prepare_memory_fault_exit() before returning, which on this path
writes vcpu->run's exit_reason and memory_fault fields outside
KVM_RUN. If that happens on a vCPU between its KVM_EXIT_MMIO and its
next KVM_RUN, kvm_arch_vcpu_ioctl_run() reads KVM_EXIT_MEMORY_FAULT
instead, skips kvm_handle_mmio_return(), and the guest repeats the
access. Could gmem_abort() skip that exit when result is set?
user_mem_abort() never writes kvm_run.

Cheers,
/fuad
