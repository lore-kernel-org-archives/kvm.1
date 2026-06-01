Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41E37F724
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342063; cv=none; b=li9wvfdX8TAYM93TrCQAh1jaiogKfx4S7yBFd0+whs91eebAIVdL6CX8yA6axR6MwQRmYrX4Zg0FMH+9dLVW4BvSoZjwHTM+X2iYnyiT3k9goj16hZUmlsf/FGG8Va0hHIlc1/NxRxd5GvaW7TS53iQ5sEpe6daprB5DGJeO1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342063; c=relaxed/simple;
	bh=0MN/Y67ymESe/boWcO1lDk0G+fGsBBsqQv3a1jAjItY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vkt2yCuN7/7mXiXnm59rVjA4sOct4vX1klOjthvCzA38IN+etfiBxkH0YTucgfcswbO43N4ztf5uFau0W6zhc58dGLdnfphVrD/zS9a78QVyyDH/2Cb98Zbkldc+Dv6n7YHcTegXoERvWUQT3eGSyVHTlMTH6xVEAY0+gwXV5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1WmmolL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1WmmolL"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bbcd40642so2641068a91.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780342060; x=1780946860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvbHZeJB95QM6qzIRNF0c6K2AYOJG5A+P32Gm5deDX8=;
        b=e1WmmolL7JJeflic+hjzVh7vdjGZLy3u//36E7G5KUI0EtSMwkUSSrlmHgl9j+hGJz
         UJfZueuGf7d2ZiHEZDZQ5kG+UiTNODt4wT2Q0CdXKIgPvZP73pMIP0Fx/Fu9Ni0fD9/M
         Cr8Z2scFHJ1wPkGH9jiIfWrGLluWILn7QVM/VNiQ5JNt4iZju8tTrzlZrU7OS6BAWUvm
         YaiybU6kxTb1Ap4hq4DSOjUYwHeuuH+Y3W9tAf8KtSxVINkMJnlY/dFqXGlQ+AayQsyl
         iQQQvY8sW2TKuLgYNL6t3GrmIh0JbW8Xgc0COXa4lrKpouB6bvS/sOLVgKMDdtsiIYJ9
         YXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342060; x=1780946860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvbHZeJB95QM6qzIRNF0c6K2AYOJG5A+P32Gm5deDX8=;
        b=tOKsNOYyim5OZD9HM/Pdn7ErgQsvcVsWTzVC3AMxlEjh0sZcWMcXRradKIlXQs+wii
         hAO6aj73x1jvbFdtUSt/M++QaJIlji5YxktFTvQhbdfmM9zMwHYcUBDlMmHt3aQXEqec
         xJZvVlTqqh2JesB8vfesd0zxIVWgQ6kL+ebE2L32aUf0TtLSmeOlYNcbDF9/fpBfeIwJ
         2lDhKU3/lrL4Dvf/RHPR74b907pLw/8tcKxZPzAVv//4mTmukg3Zg0HfdbfbPVv3QJMB
         L1qkYnsgtl/NwzPiJwGOHy+1YvD365/5bfz2WSKYuXwV6VUlrAAPgruvMjqraIdeoXRU
         fZ9A==
X-Forwarded-Encrypted: i=1; AFNElJ9PC34QNMQeSpneoWKUcOSA7WkCOXZLBQE2nxOgR+klMT+R+wW/O4T1ViSSYKduLFWkfLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKcXfjOpHVcqfbFSH0/f6/s+UqGzmbDCRPzgV4wIZupJU8dBu
	ETYuC5DyLNNwcfZcEmD99jDXWrimhbTIf+iuDw6K+LfQgsMuKODuO3R8l72RSqwMX6j909wnmf7
	XWMuSFw==
X-Received: from pgam4.prod.google.com ([2002:a05:6a02:2b44:b0:c85:85c9:de8c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5868:b0:36d:b818:f848
 with SMTP id 98e67ed59e1d1-36db818f91cmr5904376a91.5.1780342060307; Mon, 01
 Jun 2026 12:27:40 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:27:39 -0700
In-Reply-To: <20260530002134.558837-15-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com> <20260530002134.558837-15-jrhilke@google.com>
Message-ID: <ah3dK6QK_xN6TvL4@google.com>
Subject: Re: [PATCH v4 14/19] KVM: selftests: Add kvm_sched_getaffinity()
 wrapper and convert users
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, Josh Hilke wrote:
> diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> index 522ffff0462c..2e362fda50af 100644
> --- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
> +++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> @@ -82,5 +82,6 @@ __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
>  __KVM_SYSCALL_DEFINE(close, 1, int, fd);
>  __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
>  __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
> +__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);

This doesn't compile, needs:

diff --git tools/testing/selftests/kvm/include/kvm_syscalls.h tools/testing/selftests/kvm/include/kvm_syscalls.h
index 3e4cc91d5f87..d796a7228d9d 100644
--- tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -2,6 +2,8 @@
 #ifndef SELFTEST_KVM_SYSCALLS_H
 #define SELFTEST_KVM_SYSCALLS_H
 
+#include <sched.h>
+
 #include <sys/syscall.h>
 
 #define MAP_ARGS0(m,...)
