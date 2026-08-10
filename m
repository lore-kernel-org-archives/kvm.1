Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270B3C1974
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369071; cv=none; b=I7CkjzlRsx5AaQcSXufJBBoVh714iiHh8WI5+xs0JoW9mdmVeUAZ+h5kZrXgoXpkWSYk30co/QOPSVsXsi1e/ibalS5yATeE2kPB5qLLXBa3/qmPa17EneyhRzIG+kUEVHG5Ypek0Th79WC4mm38965MoF0AvodkFHm9GgwcS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369071; c=relaxed/simple;
	bh=q6FNZp3XFaqNHFhMl6+y/FDb5a1CEfUMMH6myO0ku7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vDpw4u9/PHaz5OgRN0URaomHJrlFt8qZKb5xnLe92W0RIH/ddJbIOQ0hlRBQFiPNWCLjQXjsSk0g0SFfP2L6t++nyc35tGslW3jw82yNO6RbAC6cOSk156wlppCk9927Kjr97hZaGkhuA7MBuEd8tttEeioz422JwejMhIi344g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sH/JUYIH; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sH/JUYIH"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so2393228a12.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786369067; x=1786973867; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/OjVBVJfk4CwI9/GoWgBIfWW3MJVUID0+VTcUKcWM90=;
        b=sH/JUYIH7yf/OfLstBaHv1v3tygMHWKFFx95P2mEV94SMvLiNy+uFFU3luRo5Oc24J
         AU3QAnffU6rVvOqp0Rz6M2uXb5A+OkleVdfmxPZc391VHLA6iXSiJxZaSL9cktE/DWGI
         kkkb5nve9Wqv1AR5UFVcIdxoV+8/of2SnAQwHIOcYaKZw6J84pFrBoDBHB39pJobN926
         xDrVkvWxEtLH9hhyeW/Z811olNL6fv/C/Bfv8F2PRdAVo9EdgsLiA9jBeaUKbCoM8z1g
         Kz3xINKIvEQnYfvdBS+xci3Gqs/IauvxD25CB55eRSVRWLo4IirG3vP7rDWQhHDzHqsF
         Em5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369067; x=1786973867;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/OjVBVJfk4CwI9/GoWgBIfWW3MJVUID0+VTcUKcWM90=;
        b=g7Ym+7rMbcr+/TzYf5rMK33hWYIbjTSkBKZl5OZPPbJUGxTP9b4LtMpdOx53+BHOvt
         xXpLe8A9x6lxgKZcnyQwNSp3Mo7lfNbWWP2hb5wHiZiE8kcTpPTccheOWsR5liS2Q66r
         ZgtksRY5NrBowL1DZQWTnYmvWax2zrWiqLHIaqXJiSVFwpK14Lnavrdb5NJyvoZ/NLHO
         7n7s/Y9igKRy5IaMSz2q0zuXqZuoIxgdfiz04TaemIidkLOBzdgVMnBc8LzUcH1X8Qz8
         OB/iHu1kK4yZ0F9X6hd181z/awGZZh7l5Y6fXATHnL+LeHfcx/NP89NNI4HpkRluKKJC
         lGKw==
X-Forwarded-Encrypted: i=1; AHgh+RoWk/hz8GX2fBH7tp1ugUtpunfVp8NgqF7nZ1vXzKTQln90StvwE7RsyusxciYAoCfur4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfUzpTi7wAxnIJOTZZald6QRJdgnmRBOFfIW/zT9FkM2crFjb
	jVutvsz/Hiri41dYJn78TrA0WY6h1zqnE3KbPLeEXw2R2B+GU3J0gak9wVqgE0dzD1t7Bav6ETz
	IK3Dwcg==
X-Received: from pgii30.prod.google.com ([2002:a63:221e:0:b0:c9e:41e5:2eec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:10a:b0:3c3:a140:9380
 with SMTP id adf61e73a8af0-3cbce7fdeb0mr25171510637.16.1786369066622; Mon, 10
 Aug 2026 06:37:46 -0700 (PDT)
Date: Mon, 10 Aug 2026 06:37:46 -0700
In-Reply-To: <20260808081050.408657-3-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808081050.408657-1-gokul02k@gmail.com> <20260808081050.408657-3-gokul02k@gmail.com>
Message-ID: <annUKvHeseEqVtp7@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Free the VM when NX hugepage
 disabling is denied
From: Sean Christopherson <seanjc@google.com>
To: Gokul K <gokul02k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, Gokul K wrote:
> run_test() returns as soon as it has confirmed that disabling NX huge
> pages fails with -EPERM, without freeing the VM created a few lines
> earlier.
> 
> This is not an obscure path.

FWIW, the relative obscurity of the path doesn't really matter.  

> nx_huge_pages_test.sh runs the test a
> second time without CAP_SYS_BOOT for any non-root user, and main() calls
> run_test() with disable_nx_huge_pages=true on its second invocation, so
> an ordinary run of the wrapper script always takes it.
> 
> Free the VM before returning.
> 
> Fixes: b774da3f2e57 ("KVM: selftests: Test disabling NX hugepages on a VM")
> Signed-off-by: Gokul K <gokul02k@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86/nx_huge_pages_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
> index 70950067b989..49b70c05daec 100644
> --- a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
> +++ b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
> @@ -120,6 +120,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
>  		} else {
>  			TEST_ASSERT(r == -1 && errno == EPERM,
>  				    "This process should not have permission to disable NX huge pages");
> +			kvm_vm_free(vm);
>  			return;

I think I'd prefer the same patter you used in patch 1?  I.e.

diff --git a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
index 70950067b989..e3b20033a884 100644
--- a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
@@ -120,7 +120,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
                } else {
                        TEST_ASSERT(r == -1 && errno == EPERM,
                                    "This process should not have permission to disable NX huge pages");
-                       return;
+                       goto done;
                }
        }
 
@@ -213,6 +213,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
        check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 2);
        check_split_count(vm, 0);
 
+done:
        kvm_vm_free(vm);
 }
 

>  		}
>  	}
> -- 
> 2.54.0
> 
> 
