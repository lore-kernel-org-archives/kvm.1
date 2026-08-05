Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD98427F8E
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948711; cv=none; b=b83924yLR8t66NG081AolMAL13o6T8v4IRNGJSLi8TTIhfmTzJUmyimD/7Oy4D+S0BF7KalaUiJNDt18sgkeiVGpFBnVS8ygoq7+hYRBHkyFQMW5uUErI/33erSjW35mmAppwAK2tQEb1u+xQGtLq2L0WkvV2hqSMsBUGpr9Wns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948711; c=relaxed/simple;
	bh=icvrJSGpdYUNnT9Ydyn8XbeMIq0CEpuZVgm64o2M0J8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PeRqGRFGMxe94O8MBtR6LjuB+w1TRzg90NBZTgCSMYora0mfAEObeBtj9pbyrGpG/Z1+0PLvbud+6nJxmzhp0IcuSq/P94ENI4NJmUnbCC7vYXpMF6DIZ1QjeAQdJ5jJlYQwBm0hvwwwW6j0a1sstvwseYv6TGu6mRSq6JfCYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJIX9j01; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJIX9j01"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487eb67173so1975196b3a.2
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948709; x=1786553509; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrqhku8KyxeiISShmwJpJXHc7/raRYshoO3CpoShleo=;
        b=rJIX9j01M079M0bfTHWfXLIKK3H8Y4i8HR8rvdwuVpkvkqEOQdAfkSzOxe+8bGGTAj
         AtUgdlsDGjyEpWvU70fOnHjpOTMiWqqjUCEmJ/wpb+pINCuWlbe8lvhO9uhNJwbEXaCY
         7hR35PNkhkDgmV9ra0nkMQ+/cewf92PJbpY+udHK5A9geilpwhA4QkRkPA5PbE1e9Pha
         tf4lHSn3LjPamlItnL4w75hsrJG3fWarWUKNYbpp8phOOGpIV+OHMp9G17yzpXKDypwC
         wTlnjiCJoTA9FpBQTjimvh3FZqziDYRYp+8BBqju8W3BjpVBcubgD6wXqnZGh3Y3l8HV
         C+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948709; x=1786553509;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrqhku8KyxeiISShmwJpJXHc7/raRYshoO3CpoShleo=;
        b=jdZcp89dtoD7+DEHlRKbbzZvXlt8spWHRFDc948sNminLXOlVQnz5rrkh05XVBHMIg
         YZIgSoZmvvHu3Csui7Hkn35iWrALJjQZf+Z4oVXDFKa+AzvC96v9LTWofVWHeKK+R4E2
         bVsF4KUXGwZMnQTDQ7WcjFroA5FNnCrKrd467hvSOufBRruiyb8wWhBbmy/WGcIWVrHW
         yb1kLQTRk0PilBdmrr5dCpVvgf2zW5hK5cxdE/o6VmKQYlkGLUbIBs3l57BsyzBHuBqn
         QgjoXWlhrRgozqvTxiy9bRVdmImkZ/wrI01t1CmYJttBY5osijcEuVsUJj4evJz1GCrz
         ZdbA==
X-Forwarded-Encrypted: i=1; AHgh+RrCsFNbBXJWExS6ZoKyO0qM/Dp5r/czNp3a4p4IrlWzopF7aDhB3PMKQeWUJKn8WPso6CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8G0L4UkjAHpz70SuFKj77WcDWqtKPTdU2N0Jk9I3/b6+5ex5
	Zc6fc7Jln9VCXHMiAZ91GcuxqWAhPtBi0rIEHcNEWzpHo6j9lzu9rNxDGgaZx31I72nghWlUEkg
	9dB29Zw==
X-Received: from pghr18.prod.google.com ([2002:a63:e512:0:b0:c92:dd1e:dc3c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:99b:b0:848:76c4:fba9
 with SMTP id d2e1a72fcca58-84f2dff77c0mr8958464b3a.7.1785948708769; Wed, 05
 Aug 2026 09:51:48 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:10 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594833919.3639358.12902044577496582719.b4-ty@google.com>
Subject: Re: [PATCH v3 00/12] KVM: selftests: Add more syscall wrappers, fix hardware_disable_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 31 Jul 2026 12:56:00 -0700, Sean Christopherson wrote:
> Third time's a charm.  Sorry for the spam.
> 
> Buried in the middle of this is a fix for the hardware_disable_test where
> it can end up with a runtime of multiple minutes when running a preemptible
> kernels on a large NUMA system.  Turns out my analysis/guess in v1 was wrong;
> the problem isn't direct CPU contention, it's that letting the workers do any
> amount of "real" work on any CPUs leads to pthread_create() slowdowns from
> the perspective of the caller.
> 
> [...]

Applied to kvm-x86 selftests2, thanks!

[01/12] KVM: selftests: Add a KVM syscall wrapper for sched_setaffinity()
        https://github.com/kvm-x86/linux/commit/f766bf3d0ac8
[02/12] KVM: selftests: Set threads CPU affinity before doing work in hardware disable test
        https://github.com/kvm-x86/linux/commit/2887da61c42d
[03/12] KVM: selftests: Pre-set threads affinity in hardware disable test when possible
        https://github.com/kvm-x86/linux/commit/496779b54943
[04/12] KVM: selftests: Return the target CPU from pin_task_to_random_cpu()
        https://github.com/kvm-x86/linux/commit/8de0e85f654e
[05/12] KVM: selftests: Extract picking of random CPU from cpu_set_t to separate API
        https://github.com/kvm-x86/linux/commit/d58cc7bbc5a0
[06/12] KVM: selftests: Affine threads to random CPUs in hardware disable test
        https://github.com/kvm-x86/linux/commit/563416ea9ae4
[07/12] KVM: selftests: Drop unreachable, dead code from hardware disable test
        https://github.com/kvm-x86/linux/commit/bb0e7d84c4be
[08/12] KVM: selftests: Add KVM syscall wrapper for pthread_create()
        https://github.com/kvm-x86/linux/commit/5171573ce7cb
[09/12] KVM: selftests: Add KVM syscall wrappers for pthread_{cancel,join}()
        https://github.com/kvm-x86/linux/commit/bc9143135bf3
[10/12] KVM: selftests: Add helper APIs to cancel+join pthreads
        https://github.com/kvm-x86/linux/commit/939b20e5f35e
[11/12] KVM: selftests: Add KVM syscall wrappers for pthread_{g,s}etaffinity_np()
        https://github.com/kvm-x86/linux/commit/83b5065f3e1c
[12/12] KVM: selftests: Clean up global constants in hardware disable test
        https://github.com/kvm-x86/linux/commit/1039496ae75d

--
https://github.com/kvm-x86/linux/tree/next
