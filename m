Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7344E643
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249832; cv=none; b=JdMZ6gUu1zUEsoDLKPdbrsfHUSJu4HPiGaFlSpP7Z70vzVAzp+/fZGs8cgVUWbz3uxA18eAUYYkPNeEx+dBEfMsXXR2/pgKOhZ005DJybULT2xfeL/3ePQdvsHlI0N498BpjcgFnhRkBOyBjxg3wXAgdF/7Gx1aOQMAg/6kGmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249832; c=relaxed/simple;
	bh=15OZzuRwefKmcn1sxyHGXEk+mImGsHP+AS5DcNLhZLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i765POODk2ZIZrD+YIjwZ+4AJg8AeazSJX9sRbfEnMx7pFuJDdGj/m59k04WhHlywf6iA+0XR8oBPKu3UvJPiW8xqjeeQ/RX9xHI+hC07ucxbHpQbRS3sJhzuFVH0OelnU8hEw1CS/pNqg8g8eakXQ24629IWR2Xf57266PThPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEEeAyvl; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEEeAyvl"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8482b95574dso4169920b3a.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785249830; x=1785854630; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYHf8j8BEo9L8k4s6md5eo+0/d4t8WQSTRCLKG006Pg=;
        b=gEEeAyvl7GkQ6v1TLMK3BUACLxS/tUBLaZaj3koIV5sb7pv1cvJuh2skZkg+ywBwfL
         hx/kvtWv7Tb8txSbHgv+qXXEpqRwTOosMS93sKxSA/vj1dxsyzYMD4C+x9lkkOF9Gk//
         rU8Ae8kPmpivN6hvd1aAeVkKCsJjsKvMm3fmRvGgOuXcoujg+zT6XY0dRxfFoyN20lRj
         O2RSjl7f+1u3p4Am2dnPn0WiY9Adp/edK4raOr40QaO24e+yBFTj+plQu+kxk6Pi/2Al
         BjwnwaIugR6gdW1fO5WQ4SDRhGL0As+uEqPaFUzEF16rbUqv9Fu/3DA+Ysb5mWtMzv1D
         RBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249830; x=1785854630;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYHf8j8BEo9L8k4s6md5eo+0/d4t8WQSTRCLKG006Pg=;
        b=IgFw8RpTMHMyNmXK0Q93CUETADFyKo3QtGo74F8t7NuoXXKch3s4mFA4I2jdiD0+O1
         yBfEVOe8sZXgDK1k7mL45wIoNT785QdZdhO+nofkUwcPftZmE+aWnn+Ebblts3z91i7s
         uZvRYIWCp7u/mGEgkcAucEG/Uada2xhN10cqYANtwGfYjAX3S33yxtinVKVXyGCqZKlC
         lpGSGdbGxv/sQkQqRcjd33mxwTE5vpQquaFtpNofNv64xCuM+vDOShES9wnFHP+GqEt9
         z6jLyPALB/yCtP2JlHO3miTvqokbaaG6vMgB2fMJPt8R0NdiqhXA7U2WRVAQ8/sbukmZ
         2q+Q==
X-Forwarded-Encrypted: i=1; AHgh+RokoAGYqe6Bq79LRuL4WJ0WgXcraBSumcvwrggJNKJohdW6jaqnh7i8MoHgisc+oFdmmEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzS14pj+gAwkOOuuC8IjLBjyxMSk3hHfyQ1prx7z0Y2r2AVxeL
	CtJtX1ml67DdJdKfOFZQuXVKDX0WOzMVBZtSyqa10HTBdeQ2mH1KfCgU9iZIrNyak4hT11hFYut
	Yqg/O1Q==
X-Received: from pfmy25.prod.google.com ([2002:aa7:8059:0:b0:848:866d:f119])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4308:b0:84c:518b:d915
 with SMTP id d2e1a72fcca58-84e93367f0emr2823113b3a.65.1785249830149; Tue, 28
 Jul 2026 07:43:50 -0700 (PDT)
Date: Tue, 28 Jul 2026 07:43:49 -0700
In-Reply-To: <20260727235228.1007324-12-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-12-yosry@kernel.org>
Message-ID: <amjAJQ1VZIcoefYg@google.com>
Subject: Re: [PATCH v4 11/12] KVM: selftests: Support running stress
 save+restore and #PF test in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> Extend the stress test to allow running the access+#PF code in L2
> instead of L1 by adding proper L1 guest code to bootstrap L2. By
> default, the test runs in L2 after running in L1 if nested is supported.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  .../kvm/x86/save_restore_pf_stress_test.c     | 61 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> index 664ed280b2e76..0e5ddeb5af444 100644
> --- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> +++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> @@ -8,10 +8,13 @@
>  #include <pthread.h>
>  #include <signal.h>
>  #include <unistd.h>
> +#include <getopt.h>
>  
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> +#include "svm_util.h"
> +#include "vmx.h"
>  
>  #define NR_ITERATIONS		500
>  
> @@ -81,6 +84,36 @@ static void guest_access_memory(void *arg)
>  	}
>  }
>  
> +static void l1_svm_code(struct svm_test_data *svm)
> +{
> +	generic_svm_setup(svm, guest_access_memory);
> +	run_guest(svm->vmcb, svm->vmcb_gpa);
> +	GUEST_ASSERT(false);
> +}
> +
> +static void l1_vmx_code(struct vmx_pages *vmx)
> +{
> +	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
> +	GUEST_ASSERT(load_vmcs(vmx));
> +	prepare_vmcs(vmx, guest_access_memory);
> +
> +	/* Ignore any #PF */

This comment is rather ambiguous, especially when the #UD interception comes
along, because unless the reader is reading carefully and sees the PFEC_MASK
and PFEC_MATCH logic below, it's quite easy to read this as "intercept #PF to
ignore them".

I don't see any reason to write the code this way.  Yeah yeah, it's the SDM's
suggested way to ignore #PFs, but IMO that's unnecessarily convoluted.  The more
obvious way is to leave all fields '0'.

In other words, just delete this entire block of code and rely on the default
VMX allocation logic to disable interception of all exceptions.

Oh, damnit.  Argh.  I see why you need this.  init_vmcs_control_fields() is buggy
and actually configures #PF for interception.  Apparently Paolo didn't read the
"If there is inequality, the meaning of that bit is reversed (for example, a VM
exit occurs if that bit is clear)." part :-D

So, let's fix that in a prep patch (AFAICT, no existing tests cares about #PF
interception) so that this test doesn't have to carry confusing code, and because
intercpeting #PF but nothing else by default is bound to cause problems.

diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testing/selftests/kvm/lib/x86/vmx.c
index cd09c9de4485..089e1a8af53f 100644
--- tools/testing/selftests/kvm/lib/x86/vmx.c
+++ tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -232,7 +232,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 
        vmwrite(EXCEPTION_BITMAP, 0);
        vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0);
-       vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1); /* Never match */
+       vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, 0);
        vmwrite(CR3_TARGET_COUNT, 0);
        vmwrite(VM_EXIT_CONTROLS, rdmsr(MSR_IA32_VMX_EXIT_CTLS) |
                VM_EXIT_HOST_ADDR_SPACE_SIZE);    /* 64-bit host */

> +	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(PF_VECTOR)));
> +	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0));
> +	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1));
> +
> +	GUEST_ASSERT(!vmlaunch());
> +	GUEST_ASSERT(false);
> +}
