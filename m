Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95A21FF25
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151258; cv=none; b=oWjPq9EvsvJCHFJjolgdpoGpskSNUwOZRt0rOy4A22sU9+ZaaLdPJcwAgQFHsuW9V3KWE8in4d0VBByNJ3eMvKKXt8UUmmjJ0MHLB3YYLWahCSvpLEgR/mbuEPZj+TvLed/BQ4ayO0Qj7z1AaWUjoOsLJbhiNvRS0rUqsDwSIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151258; c=relaxed/simple;
	bh=FbG+wJGer7DbDBFVV0TO6IUa665R0UX1LReMh/QQVZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFK/mMMobXHf6et3rmOzGkpZq5ashpRXQw/n6/wJQ16mSWQFy5AOpo0Gvg9HhCm67JVOXBwQQesOQgt34pwHl4EYoYNcR/iEA2Jgx7PefVewHUKr0OUzZ4eyub+U9BZplttWTEp01cK6AE84rBs1syQ+TFCZh5Uzq5gzH6tUS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHz5YOoa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHz5YOoa"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8292e18166so1372525a12.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151256; x=1779756056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAFnyZvlo/xy8M7f53UQF60Xw7zi2fHUdsU+WPUumV8=;
        b=eHz5YOoam8tEsPTnra7WFlVfnKvzb5gq1ttFEQkArfWLMC5oTWCgVyEutJsDp9CF1A
         lMy40zV3qSN5kb9Eo46TFK0KnPuHGfwCrkriBDkDt8jod3xBh/k9s0i3R/sEfUY5Dc1x
         NVbvXe1bAe1SIPHzkGo4qiXBBij/qEijq22zRSSujff4o8kmqAiXak/Tek8nVKl1C7FP
         zyerHm5PcBg5SaGXw5ii+HuLfQp+V73QCU3zn1YTV4EkWknHE35f87CVaVLlKK3c7Kl4
         eH3jcAz/GtZ+B59Yu1+vnrgtd9PJJf455VJZd+PryZeFmk3+Ra8ak0WHq0LJfizcT9zA
         9KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151256; x=1779756056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAFnyZvlo/xy8M7f53UQF60Xw7zi2fHUdsU+WPUumV8=;
        b=LWMJXssu+81wmZyoiTNSMkocSvRL/zZy0oTEgu+Ujmul/aFbl1FjJEecf+fgw8rJqM
         Fz0Ke39CZS3wrgKUyhzbCAAyvaL+yVjNHS+ymS+NwHb7HKWt9jhV1mDWd0LHWAHxa6Ex
         H9JnEcYO5l/bx6NTVmTNeHdrgIO5kydIxDgwp3JAfDZaGvftiBgSU7DhlXwvmHd4Bny/
         vzh3uF3+1nn4JDaQ7k/XV6jb33DcQK+RMsC/7OQ5PHMiG2DfDMbKsA1e1KzRrIyI1HeO
         iF4Jtcj28+r9wtUb4e9YfVd62T5+F8E2MwBWcfoRxoeu+aWJgK+1EPrJNJHYX0jxN/KB
         6V8Q==
X-Gm-Message-State: AOJu0YxjdaLlTCZkawx0oPdWK1HzEYULVAS2cfNUfUYSry8Z4sL/0zUW
	SsN/YxFON2tRx8i7ugrBCNXX/mqi6yPb0coO98SAJastJzTAAS72wePAbG3bs0shrlsfg0SAwHy
	uohiK9A==
X-Received: from pgla17.prod.google.com ([2002:a63:b51:0:b0:c82:2e5b:8f33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a28:b0:3a2:dbaa:82ee
 with SMTP id adf61e73a8af0-3b22e642e28mr18727670637.9.1779151255874; Mon, 18
 May 2026 17:40:55 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:30 -0700
In-Reply-To: <20260409153846.1502656-2-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319000842.1213426-2-hisamshar@gmail.com> <20260409153846.1502656-2-hisamshar@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915073151.2227139.1935442048185097112.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Guard execinfo.h inclusion for
 non-glibc builds
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aqib Faruqui <aqibaf@amazon.com>, shuah@kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Thu, 09 Apr 2026 20:38:47 +0500, Hisam Mehboob wrote:
> The backtrace() function and execinfo.h are GNU extensions available
> in glibc but not in non-glibc C libraries such as musl. Building KVM
> selftests with musl-gcc fails with:
> 
>   lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory
> 
> Fix this by guarding the inclusion of execinfo.h and the stack dumping
> logic under #ifdef __GLIBC__. For non-glibc builds, provide a local
> stub for test_dump_stack().
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Guard execinfo.h inclusion for non-glibc builds
      https://github.com/kvm-x86/linux/commit/34065a5f3cf9

--
https://github.com/kvm-x86/linux/tree/next
