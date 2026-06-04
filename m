Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3663A4F36
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593455; cv=none; b=P5JT1MgJiLyafwKYur9TXmG2yfxBvds+BmTpLdqZJSoMRDO4ZF1l+thMDrS27o1nsS98NJ15IZmmgoKOjb8Y7jG+x24bjTb0sE51lHni9Zs1LwO0d96rbEVykqeuBNDCFDkwYHVlGnh5XP+pjv/0a8FB3mFb887/JLePa5M5XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593455; c=relaxed/simple;
	bh=cnQDhI3rPLRAlQ3SMyaVGYpY+5KTbMQDpuXpfVrgGhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWeux3cWDecoPqleeAKrMf/ueZNPdA8wkS4m+l7WwD1/zX8r7g/pKfR89dNi9/ec7hgSUl8B2rpSVU1uATZx345CNOGsD4grsCQMAjinPTevlqNXDmoYKTU3qk9GlyfCHU5Pl4ISq4GgEtS12JY30wP7SoqCiX7iLWk9biX+cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGUJGz4B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGUJGz4B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d99181eaaso1296606a91.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780593454; x=1781198254; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiE08N0otE8gZoBNOAFs9Ba6fLHtJ9Xhjyt4xcKDCXo=;
        b=tGUJGz4BSalyuHjP7z4e4RuTxPk3HWar9/up68mdQGmB79O87NSt2tVsbiJV5T7zqj
         MTjuQnJLSVysQ8dd1Evz53O7IeuAgVhpya5GDN9fVFG933Q0Y+NvG+wNGdbBz6AWGJPl
         09BzdVSk+ixNkHPmoj/IjbGHqHX3Mwv9ENBuCJzHlmXeO4dRhDKgXHmkmWd5Z2zthzo5
         k5MEXDF63qZGSntrbrqLNu5t1JlgpX+tDs/v6fs42VfUgeO3JXWuA2T++c2mDTu3WxAT
         E94b7uuivLZ2g/81CZSKbFxLjWr3KcEcYHl5f0ZRCanflV4ZRbXX69bavyl1BRse+BrU
         cC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593454; x=1781198254;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiE08N0otE8gZoBNOAFs9Ba6fLHtJ9Xhjyt4xcKDCXo=;
        b=YNXjHBHOjYqw0ePIxpb9ShQmKNUs0eMyDSL5Bxp3rE2RbXIEe7IIyZ4DxXgMmpEEDA
         0+laNR7kuLqCWc9fONPGxivDA6aP+PNbfH5Rb4GIqYXGPeXUcQquRoa7GEui1Wn00PEZ
         cCZ9Lu7FSpw67BKbAq3HJiMsGBtnc90hLsppAIu5chYsV4YfHW1jLM05+jOLQAokfCmy
         97kWxD638ndgnK8uiZmmrYf9W2X2bCRICxuBrUP3+NmbfMFZfpaSPqQOJCmIazsIL/tU
         2cJ7l1YO84yl87bzzgvIAb0AxovDgTdrwUx8NfykKhNMEA8crdfSxw07goLh55QQSuAi
         RpYw==
X-Forwarded-Encrypted: i=1; AFNElJ9i4H95qAWvwGfNOagjpaT0J+8bpe4eeP+d1duLssnlgf3VHDjQNXvcpMTIakLY6XWfV9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7P+M2qY5LSgFWQfrWRGIulehF/75y421DThN0HEiMzYgWiea
	HP2lpbXdStltEefK2P2/nvIcAy/egA3dvg7g8lrA7U+cb5c5oW2OOE9ZxsxaSeKPQL4JdO2v/3M
	GADgrdQ==
X-Received: from pjbqi11.prod.google.com ([2002:a17:90b:274b:b0:368:1f77:ffae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2742:b0:36b:bec8:94cf
 with SMTP id 98e67ed59e1d1-36e2f9a2497mr8748830a91.9.1780593453567; Thu, 04
 Jun 2026 10:17:33 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:17:32 -0700
In-Reply-To: <20260604020939.3D12C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-10-jrhilke@google.com> <20260604020939.3D12C1F00893@smtp.kernel.org>
Message-ID: <aiGzLEMLMR06kVZY@google.com>
Subject: Re: [PATCH v5 09/21] KVM: selftests: Add helpers to print proc IRQ
 affinity for IRQ test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > +static void print_proc_irq_file(unsigned int irq, const char *file)
> > +{
> > +	char path[PATH_MAX];
> > +	char buf[256];
> 
> [Severity: Medium]
> Will fgets() silently truncate the smp_affinity masks on large systems when
> reading into this buffer?
> 
> CPU affinity masks are formatted as comma-separated 32-bit hex words. A
> 256-byte buffer limits the output to roughly 910 CPUs. 
> 
> Because masks are printed from highest index to lowest, truncation would
> drop the affinity data for lower CPU indices, which are typically where 
> IRQs are pinned.
> 
> > +	FILE *fp;
> > +
> > +	snprintf(path, sizeof(path), "/proc/irq/%u/%s", irq, file);
> > +	fp = fopen(path, "r");
> > +	if (!fp) {
> > +		printf("  Failed to open %s\n", path);
> 
> [Severity: Medium]
> Does this bypass the selftest logging framework?
> 
> KVM selftests typically use pr_info() from test_util.h to allow standard
> informational output to be suppressed when QUIET is defined. Using printf()
> directly forces unconditional output and can cause log spam in CI
> environments.
> 
> > +		return;
> > +	}
> > +
> > +	if (fgets(buf, sizeof(buf), fp)) {
> > +		buf[strcspn(buf, "\n")] = 0;
> > +		printf("  %s: %s\n", path, buf);
> 
> [Severity: Medium]
> Should this also be updated to use pr_info() instead of printf() to respect
> the QUIET mode flag?

I think for the initial landing, it makes sense to skip this and the usage in
irq_test.  Printing the affinity information definitely qualifies as "nice to
have", i.e. it can wait.
