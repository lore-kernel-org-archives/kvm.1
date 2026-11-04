Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811016;
	b=ktQBoQvgmZJ7dA0wiUCfaIapleewp16l+gcHpeQpmtGbN+hg52E1dD56Y0EQwbAVJO81
	 Pv9onvXhp1aHphva6g1FZbJBJQyLZCpCl497QCa3IdxyTS9O+Kl0GxZABcWVOETlBIJPm
	 mGp0AbGEQun4o9OnkylBhlAJUdVdSbbhWJsyAhtOWmuOyQ/GQB2/i48eBO74LuWJjdgQ8
	 x1JidP/wBpQKHqNmsGGM0Gq4/mQo1MR5T1l2IfWYxAJAylx/pWZIiYBh5umpDrXVQXtC8
	 tXLW4u2KQvcN7qoA7o9S23y7lhGHXkw0Q2xniWpadJEUrwJ/adernwZAr9GaaR+yfBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=P5qFYjBpoihP1d3aZdf6ZOVbEHGPd4/o6Ut1jFZ75ZA=;
	b=2xDKuw/z8SZLQfhCNiV01obYZSs9wZSn2zhW/XkZv+FBLlYRy74QxPtyFWoCwkhpEenO
	 3nXmhZeMZL1QpkJRmrQIWuqcOHnwl2DNyvU9wRQhWQst41O5qV8lGPEvmWZydl18H1Myy
	 2aV8kCyitC3fS1AgMk195z5TWxeXAnqqeYo1hS41U+tG+oeF6b8ZHd0paVii95tFpPGcV
	 swRr8I5ENog4K65qBRvWX2PIa3YVrjnTRUKYH2Epd5F8OKT94kL4dt80yQsm/YUWvgtQG
	 kzlhU2LF/0NNyg/kcp7n8zKWj3McYTD5JFc+ePkGhv7/k8ccNYTn6vO1616dHGuIjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oQJif5J7;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A4606D81D
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 16:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD8A4606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oQJif5J7
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd65070d3feso544799a12.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793811015; x=1794415815; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5qFYjBpoihP1d3aZdf6ZOVbEHGPd4/o6Ut1jFZ75ZA=;
        b=oQJif5J7fwSCFEZjyzg8i57pnHrFhx97X3b2/7HNKARVPyW4jPKMBLEd5KIEEmkGbv
         b3j+ghTpmUvRoQLb5P5YzaL5LRQktLHxN/k8EH5s5OpqNCc6pWAGdetFK0E8Ei7QjHgr
         Q5T4O+d9DkqEIArAwfbO6fsVlmrw+vO74VUdn0ZvDwDIwnf8M3laAGrYRxGLGPgkqPyi
         wwOJGPvGxfdtVghRAEqMe+Cv5wEmGnPapXuvmUvYJ9ZCnkMr1IiXDxefxW1riTKbuiVH
         u4a8ONdOSREYNwVF/+SgIXQ/Xh5xpdFunsTMWvnTwNq/10rFyUZCDcOOsz14DydmxFAk
         OUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811015; x=1794415815;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5qFYjBpoihP1d3aZdf6ZOVbEHGPd4/o6Ut1jFZ75ZA=;
        b=uVC3AmuYcgEfotDPMK5qi3O56CyPmbI/mnAu39gano1Rx3OSmY4+lOdww2Fpv75GAe
         9mRLn5aOX75V3WHs+nw6Ox6zbsWNTP15tlIzpUqqlmyPID1M1W/Jlk6MjP2qW8BOeAb/
         7MWOtKxU6bkgelJXAWsPgvGh8+AyWNx1leCZUZwKBNtwRoOtKhZ4Drf78fD48IuIii5b
         FANKtzLWJKJSN/Iu9qXbtc1r+lhcTjnVTO/IY+azwjBuIbdXyw9yUfIVKCZgVbg1cjmI
         NO6LSL4pYd6ULjNwkUallLoG8v2wS6cpTHGqmxa4bB7Hwn+rprqOPHDalOhYur3iaIk6
         NxMw==
X-Forwarded-Encrypted: i=1; AKwUvByNUVlROpOkCPLYtnP8fPP4xzL/KjY0YVwfe0H2I5BtLbAgPtW3UHr2YePZJkbuBRhbaUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+ke95FoEvvE7CzWYgcGGnlPjPaYC5PKgrYFdnWLgREYRQH/Dj
	rDrDgViAobeVryKbaYujBtSBt8rMRKhPuwoAETifoK+mJstH4N6pe2UTJ0enXGHFNBofvD0O33t
	V307kfQ==
X-Received: from pgdc9.prod.google.com ([2002:a05:6a02:5109:b0:cd5:f887:3cfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734d:b0:3e1:a402:680c
 with SMTP id adf61e73a8af0-3eb98517683mr18495637.21.1793811014778; Wed, 04
 Nov 2026 08:50:14 -0800 (PST)
Date: Wed, 4 Nov 2026 08:50:14 -0800
In-Reply-To: <sashiko-outbox-196866@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104080721.2169-1-zhangchujun@cmss.chinamobile.com> <sashiko-outbox-196866@kernel.org>
Message-ID: <autiRrLCDz6JTuiB@google.com>
Subject: Re: [PATCH] selftests/kvm: check fopen() return in get_run_delay()
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: zhangchujun <zhangchujun@cmss.chinamobile.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/kvm: infinite loop when fopen() fails in get_run_delay()
> --
> 
> commit fed2657e5d999eb78e5e508f23ea617f2787e14a
> Author: zhangchujun <zhangchujun@cmss.chinamobile.com>
> 
> selftests/kvm: check fopen() return in get_run_delay()
> 
> This commit adds a NULL check on the FILE pointer returned by fopen() in
> get_run_delay() so that it returns MIN_RUN_DELAY_NS instead of passing NULL to
> fscanf() and fclose() when /proc/<tid>/schedstat cannot be opened.
> 
> > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > index f5f7189f96a84..2827f7d7d905e 100644
> > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > @@ -421,6 +421,8 @@ long get_run_delay(void)
> >  	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
> >  	fp = fopen(path, "r");
> >  	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
> > +	if (!fp)
> > +		return MIN_RUN_DELAY_NS;
> 
> [Severity: Medium]
> If fopen() fails to open /proc/<tid>/schedstat (for instance, when
> CONFIG_SCHED_INFO is disabled in the host kernel), will returning the constant
> MIN_RUN_DELAY_NS here cause the callers of get_run_delay() to hang in an
> infinite loop?
> 
> get_run_delay() reads the calling thread's cumulative scheduler run_delay
> counter, and both callers in the tree wait for subsequent readings to advance
> past an initial baseline.
> 
> In tools/testing/selftests/kvm/steal_time.c:main():
> 
> 		run_delay = get_run_delay();
> 		kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
> 		kvm_pthread_getaffinity(thread, &cpuset);
> 		TEST_ASSERT(CPU_COUNT(&cpuset) == 1 && CPU_ISSET(cpu, &cpuset),
> 			    "Worker failed to inherit parent's CPU affinity");
> 
> 		do
> 			sched_yield();
> 		while (get_run_delay() - run_delay < MIN_RUN_DELAY_NS);
> 
> When get_run_delay() returns MIN_RUN_DELAY_NS on every call,
> get_run_delay() - run_delay evaluates to 0, which is always less than
> MIN_RUN_DELAY_NS, causing this loop to spin forever.
> 
> Similarly, in tools/testing/selftests/kvm/x86/xen_shinfo_test.c:main():
> 
> 				rundelay = get_run_delay() + MIN_STEAL_TIME;
> 				do {
> 					sched_yield();
> 				} while (get_run_delay() < rundelay);
> 
> Here, rundelay becomes MIN_RUN_DELAY_NS + MIN_STEAL_TIME while get_run_delay()
> continues returning MIN_RUN_DELAY_NS, which also spins forever.
> 
> Should get_run_delay() instead fail or skip via TEST_ASSERT() or
> TEST_REQUIRE() when fopen() fails, similar to other file-opening helpers in
> tools/testing/selftests/kvm/lib/test_util.c such as get_sysfs_val() and
> get_def_hugetlb_pagesz()?

Ya, I agree with Sashiko.  Not only could returning MIN_RUN_DELAY_NS lead to
failure, it could result in false passes, which is arguably even worse.  E.g.
running the steal time test with CONFIG_SCHEDSTATS=n seems pointless.

I don't think we want to simply do TEST_REQUIRE() if fopen() fails, because that
would result in weird skips if fopen() initially succeeds but then randomly fails
partway through the test.

I think the best way to tackle this would be to provide separate APIs to open and
read the file, and then have the open API do TEST_REQUIRE() and the read API do
TEST_ASSERT().

E.g.

FILE *sys_open_schedstat(void)
{
	char path[64];
	FILE *f;
	int fd;

	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
	fd = open_path_or_exit(path, O_RDONLY);

	f = fdopen(fd, "r");
	TEST_ASSERT(f, __KVM_SYSCALL_ERROR("fdopen()", -1));
	return f;
}

long get_run_delay(FILE *f)
{
	long val[2];
	int r;

	r = fscanf(f, "%ld %ld ", &val[0], &val[1]);
	TEST_ASSERT(r == 2, __KVM_SYSCALL_ERROR("fscanf()", r));

	return val[1];
}
