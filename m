Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB024EFFA6
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613609; cv=none; b=UiDYJVqcUiDcAKNNjR8+B8PnA/f4u76lYSm49LkdyhPQmYFkqDtK0CwgPCVlA1Sat2XnN2cKVBMa+Y0d8qCxKVt6LmvbMXb1EG1Q+Pf0ANFO2DEoCEUKvv7Xs9hBsrmbw019m/EhAzvOeAmN0qPzfl/O11BN0tit6p7SQXQG940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613609; c=relaxed/simple;
	bh=6THoCCBVd+/ZjxZ3xgtcJIVoQhC/QcPIewn4tAZ+WI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BMjB150+6tb1ZNu7cqEF6h6dqFVHni/3BzzY55ICg9J0sdE+FS5sZxZokb47Q11jup71sriVnIDogFSbWWQHsQGtbvc5c20v/GopFr0jAdmkG+zPWQwlDLnrVqu5UK0DouGFs59TBlhhsZ5OCQ/NbLO5VZUrt1ivh6hIAIfz0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTkfir8/; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTkfir8/"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso2992351a12.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790613607; x=1791218407; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MWRr8LBMaJZmxpSUxy/Rjeh3NVu2xmhfdirmx3vVU0=;
        b=rTkfir8/1F6a7yCgMrZ8Y2agqXtHOhZboanxGWqljoN5OqYK3Nu7vjGMWJqU//DrMY
         BttlSBZEBJzVE6UTGIzFW+cRmgMSDpKF9Up+fMCn+sLY5hFBnVrcEoIsmwZUoirnFrdM
         lJfYtZM61NwtPhbv13XpXqmBqIx5v8ez0VaXggGywcXiE0/gqYKZmaoHvv8T77ve7bFf
         MhVX4mu7Ch0eLAKTrhXMpXsT9g1f4pJZl++Xc5pWYTeQvU/YmDcbTH8QCQxQIXKBuj6z
         6MqEMvF3IOenKzaK/zY2LZBcsFKtYIQ6pfHjow/kJtA6KyvFb4KJEMKE74tkGqX79TgY
         MTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613607; x=1791218407;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MWRr8LBMaJZmxpSUxy/Rjeh3NVu2xmhfdirmx3vVU0=;
        b=JRgcgJRAgMo/rEcgwfU+W8l1PO+ySqaj8/Oq8kil/r8RzCypoGvABlDB9U0YWHNONG
         /J6bD8E7PRtcMufOyafIVYlFsHlKKgroEhiEx8SEaqy5FRvebPcSyWzgecZJu8mZWmOv
         sfF2+vnPoqGROdTRpMgEsHQoSLeguJ5gPNP+KCr+qShQRP+J6bWXCoDQMDjatSDJyEuu
         E+Fuhch6ZeIYT8M0uTa25tWF/oAZ6nY7B0CYfIHYKa+/DbpFytn3tNDEzsuWJMvPHLBQ
         9TcDtAw+Zd9RrPK5jICkPxEOJIOuPbYU3iJeekrezlXQNPaieqCXuEK7LzOfUzVqdGcs
         JHFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGNAs72ev0gL7ExQLxjXjfPZ66O3wX1/JIsNxT9RfD87uR6sw8c+DQXbFVO/RmuSAbsko=@vger.kernel.org
X-Gm-Message-State: AFuF++lrhJGQq7unD3Yrq8zbDYYG4egKqx74ofQd8YLeTcKntNTEFYwk
	DgMr7RT3o/83lvtM+02BuTCWDmUjL6NlsTGXemieflsZLMsrOC+FVHynFPkN8rTl+Ooha4XrcgI
	7Le/2vQ==
X-Received: from pgbgj7.prod.google.com ([2002:a05:6a02:4947:b0:cc7:9d5b:c2ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf8f:b0:3de:79b7:d62e
 with SMTP id adf61e73a8af0-3de79b7da7cmr609965637.54.1790613606937; Mon, 28
 Sep 2026 09:40:06 -0700 (PDT)
Date: Mon, 28 Sep 2026 09:40:06 -0700
In-Reply-To: <20260926104355.13697-1-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260926104355.13697-1-tharitt97@gmail.com>
Message-ID: <arqYZpzSNppxYBK9@google.com>
Subject: Re: [PATCH] KVM: selftests: Verify KVM_MSR_EXIT_REASON_INVAL on
 reserved EFER write
From: Sean Christopherson <seanjc@google.com>
To: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, me@brighamcampbell.com, 
	jkoolstra@xs4all.nl
Content-Type: text/plain; charset="us-ascii"

On Sat, Sep 26, 2026, Tharit Tangkijwanichakul wrote:
> The msr_filter_deny test covers the FILTER and UNKNOWN MSR exit
> reasons, but nothing exercises KVM_MSR_EXIT_REASON_INVAL.
> 
> Have the guest set a reserved bit (bit 63) in EFER while preserving
> the other bits, and verify that the write exits to userspace with
> KVM_MSR_EXIT_REASON_INVAL along with the attempted value.
> 
> Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
> ---
> Tested on Intel Core i5-10210U (VMX). Not tested on AMD.
> ---
>  .../selftests/kvm/x86/userspace_msr_exit_test.c      | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
> index 2808ce727e5f..7446e1404264 100644
> --- a/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
> +++ b/tools/testing/selftests/kvm/x86/userspace_msr_exit_test.c
> @@ -309,6 +309,9 @@ static void guest_msr_calls(bool trapped)
>  	/* Invalid MSR, should always be handled by user space exit */
>  	GUEST_ASSERT(rdmsr(0xdeadbeef) == 0xdeadbeef);
>  	wrmsr(0xdeadbeef, 0x1234);
> +
> +	/* Setting a reserved EFER bit is rejected by KVM, exit with INVAL */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | BIT_ULL(63));

I'd rather use an MSR that is less likely to gain supported bits in the future.
It's definitely unlikely EFER[63] will be used in the near future, but it's far
from impossible.

My vote would be to write a non-canonical (even with LA57=1) value to MSR_FS_BASE
and/or MSR_GS_BASE.  While it's technically possible that x86 could extend the
canonical address space, that's pretty much guaranteed to require truly massive
architectural changes.  And if we reuse the NONCANONICAL macro (which we should),
then even if the unlikely happens, at the very least it will be easy to find what
all needs to be updated.  As a bonus, the test already uses in MSR_FS_BASE and
MSR_GS_BASE, so they're naturally fits.

Alternatively, we could use PAT, as it's extremely unlikely x86 is going to gain
new memory types in the near future, but I like using a non-canonical value.

>  }
>  
>  static void guest_code_filter_deny(void)
> @@ -627,6 +630,13 @@ static void handle_wrmsr(struct kvm_run *run)
>  		TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_UNKNOWN,
>  			    "deadbeef trap w/o inval fault");
>  	}
> +
> +	if (run->msr.index == MSR_EFER) {
> +		TEST_ASSERT(run->msr.data & BIT_ULL(63),
> +			    "MSR_EFER data missing reserved bit");
> +		TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_INVAL,
> +			    "MSR_EFER trap w/o inval fault");
> +	}
>  }
>  
>  KVM_ONE_VCPU_TEST(user_msr, msr_filter_deny, guest_code_filter_deny)
> @@ -667,7 +677,7 @@ KVM_ONE_VCPU_TEST(user_msr, msr_filter_deny, guest_code_filter_deny)
>  
>  done:
>  	TEST_ASSERT(msr_reads == 4, "Handled 4 rdmsr in user space");
> -	TEST_ASSERT(msr_writes == 3, "Handled 3 wrmsr in user space");
> +	TEST_ASSERT(msr_writes == 5, "Handled 5 wrmsr in user space");
>  }
>  
>  KVM_ONE_VCPU_TEST(user_msr, msr_permission_bitmap, guest_code_permission_bitmap)
> -- 
> 2.53.0
> 
> 
