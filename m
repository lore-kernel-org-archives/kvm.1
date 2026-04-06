Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4365194C95
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516500; cv=none; b=bDgbhlFC27vLRo0zgJFvL3tQGzXdxI3gvqcB4hByvM8lOHQgE+D87euER6dA2EXW9VkNl87t/Q59X5cZqLSKafsoKGA5Y0vJYCO9agKTwNA3QZ5vtHYpoCrkNgHxKVC/sG72T71Zt0TOZY82YRmVOPZRDyZWFcB+BYCZX+h8Ms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516500; c=relaxed/simple;
	bh=siPND8xsPU9mCLpW0Z7T5dAsRBXpqLvnj7P4viTj0J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jitnKBgoVTzNrtJGw25ZUbCswHQAULaYq47BPk+KKvUWBbePixdEB6D95kXKaXjzUT/HEh0yV7zVWoC5oYs0Tt+qfX5OoZVpuBHQ4KG8HkGzb+m69zUPLfFi84ZgG5tlAMLJeWqvvcHhWz8BiE9DwPJzteW1HcNKPYcIxb0FENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCFEAloM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCFEAloM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76ad3b732eso6848378a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516499; x=1776121299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bw8FCdgjwfmWI+4R84SR3mMUmNsra0uKKt+trGCHhkc=;
        b=KCFEAloMgGp7S9z9cDk1BWy8TgmKxNL4uE9txD9DgSIVzIAyyICe1rLQfo0oFFqmHE
         OmphMY1lR6vwJXn2OKByjtwMZHfmm1h7zLfVGHJRsGHLoKH4o816x5INlzTZTORRzkRC
         6ggYdvpMfZ4eQdkzFFuZijRa3TpM5ahxX4tLBDjBUWX1NSMpxDr+KWPW6lVpIG/tX2tC
         ZCVarER6ok98j6xndWw2rzSYZ16c7uxg6gmXXyd1J3vfDZls6bKwDJRf2D5Od/YLUUmz
         lii0gLVMu2SdMsbLuCI5X9Yq2nIvMNDLsGaLg+y/vOmLvh3F8sHpqzjSYLT29ywStgDw
         i6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516499; x=1776121299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bw8FCdgjwfmWI+4R84SR3mMUmNsra0uKKt+trGCHhkc=;
        b=rkfTJTo7p7NtQ+Zwk8INXm776iu2e2+G/6NCGLkEcXX5/EKEU5iNuJk7T7y8bm/gFW
         ygcQyAPLJmEh+teey9kNRl6Fl/5JxKsz/P1xmke/uL58PrYYAv3ohX9nEE8XmSBP58/h
         Dsw/a5oYZ/fsJy62Rx1ur0vKvcZ/cas52E8N0WfgjUWT76wIDG0bYhpotmrKyDU23m+b
         9A+Cr2euygmUJNkwyB3WG6nO8x/xAr1s4j/Io2GDxqBPO2P9Tqguy3wEukwym625cQp3
         arBTDebd/CgLIwNWcIRzMsWS6I9H+vX4DFul/EBHr+bZ2RMKcLSeaz1xtiTTFH2BOu0Q
         e9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU5xXo/G0eHBTHymYFqFhpTW/UvKUHq+cWjQBZciCtYtn6ezqq2etsVU06HcyZYck9Kq80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3yqVd26fS0HRt6T59O5FxnXVbYDMcMc6cTdUZZu1SELhZbCE
	BrRofjijNtuS1yePDScdRGR1+NK0BRazQvufVCwIn3CXgmBHiRO/xI7BoLZaX4M+wv1Rb1u4d21
	FfVDs0g==
X-Received: from pfble6.prod.google.com ([2002:a05:6a00:4fc6:b0:829:6cf2:95da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1816:b0:81f:3f03:6838
 with SMTP id d2e1a72fcca58-82d0da7be19mr15069758b3a.15.1775516499004; Mon, 06
 Apr 2026 16:01:39 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:01:37 -0700
In-Reply-To: <20260402102953.2984284-1-mayuresh.chitale@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402102953.2984284-1-mayuresh.chitale@oss.qualcomm.com>
Message-ID: <adQ7UZVG9rQ1mOTI@google.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: make host wait timeout configurable
From: Sean Christopherson <seanjc@google.com>
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Mayuresh Chitale wrote:
> When memslot_perf_test is run on qemu, sometimes the RW subtest fails

For posterity, can you elaborate on exactly what "is run on qemu" means?

> @@ -900,7 +901,7 @@ static void help(char *name, struct test_args *targs)
>  {
>  	int ctr;
>  
> -	pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e last_test] [-l test_length] [-r run_count]\n",
> +	pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e last_test] [-l test_length] [-r run_count] [-a wait_timeout]\n",
>  		name);
>  	pr_info(" -h: print this help screen.\n");
>  	pr_info(" -v: enable verbose mode (not for benchmarking).\n");
> @@ -916,6 +917,8 @@ static void help(char *name, struct test_args *targs)
>  		targs->seconds);
>  	pr_info(" -r: specify the number of runs per test (currently: %i)\n",
>  		targs->runs);
> +	pr_info(" -a: specify the number of seconds for host wait timeout (currently: %i)\n",
> +		wait_timeout);

Why '-a'?  '-t' is available, and seems more intuitive for --timeout.

>  	pr_info("\nAvailable tests:\n");
>  	for (ctr = 0; ctr < NTESTS; ctr++)
> @@ -964,7 +967,7 @@ static bool parse_args(int argc, char *argv[],
>  	uint32_t max_mem_slots;
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hvdqs:f:e:l:r:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hvdqs:f:e:l:r:a:")) != -1) {
>  		switch (opt) {
>  		case 'h':
>  		default:
> @@ -1007,6 +1010,9 @@ static bool parse_args(int argc, char *argv[],
>  		case 'r':
>  			targs->runs = atoi_positive("Runs per test", optarg);
>  			break;
> +		case 'a':
> +			wait_timeout = atoi_positive("Host wait timeout", optarg);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.43.0
> 
