Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAA459AE1
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183280; cv=none; b=dZTUvIKoBap01h8ral44ncPjWEcmadvz3k77H3rPQ1e6J4KoKoFCBOn5YZJcIKO9sRypWHsmZtZ6UEtpgSVg4/qNErYD9aXTrzZN0lmyVP0qzTVqy7hP0R5GISqPT8RgxJSZg7sOw/jDtjLE+2s3GvOICH4K5Qr5hd5v/cEVIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183280; c=relaxed/simple;
	bh=hYBtCZAMWd8+aQI8PbHL9CthqVGadfyYaQT9QHn4/OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tjmQyKUGzYf6RyDIEFNfiMLoj79b2Z08D0K1lrZgjz0IT3+K56y6Avm+qx5jdWrY57Wng3s0AXlMkwaGPTIN3wKuEjKj+y6WFDVeMIPCMkVQqLkXL9ItuCcGD7i4jHiypfkYHYhz2mLfiJ/9rkhw7bgg6vc7MwEmOK7PGMRN2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNm59tBZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNm59tBZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so4698537a12.3
        for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788183278; x=1788788078; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zOYfzBBMn/A1HAZOwgxGBFnYbdODnB7rBd8+xDq1+F4=;
        b=kNm59tBZo8qpd9T5iGpLHKQjIEbscwjnAykREiiOYHM7BhXNLDYyPq2+HovCvZezaS
         KV0IkQzf6aEguk/2wPu8z3yx2DFbUWHvzfmbtxcjAel4bHLIb8xefI2pk3YOgJHIxgvf
         AwlKbqV02a0SrL1J7cKKkZyTNG0KkgvTeRrTY407zsCzX9xq7HSEXee97EFkCZnq70NY
         MPtNLNAGHf+uGWC/Gp++nQfX1GNhUALyiAoQ3neQk9M2YcBnseDtZ2KtjfIJ9gL93x3x
         28JsCeGeZDPlfpFrwk3zID32DC/0fsZjM6R1JfXy41l4TfO32npRSaoEBo1JRR1+vKiF
         KSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183278; x=1788788078;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOYfzBBMn/A1HAZOwgxGBFnYbdODnB7rBd8+xDq1+F4=;
        b=czCG787g3yRDloSOd4j8mAAD+plEeEKnR1yIDnf3dYu4OVv6oZKOno5MMSKAvQ6ez5
         xhC3vIJOXYvXx6AkFnjIWML4wdxpkHdCosNy5kMgAJYvUQ3wgHlS7p4VNlq5LNSH0osZ
         x2KnQHo8Og8GdfiHhhAkNgJIsa9w5r4VZCb2aEgYmr53xMhqaM/tbRGLVrdysokmu3fc
         yoJ2eOBKfAezA9uvXSGAnMpDfzvqxgN4XFhPSlatX1bV0EziG9xP66cpR8TAVUxxtHeG
         LLaVeNg5ZB+li15qh4lIAopO2oDRc3nSVdD207mxAzsKU+Uw3BHvkMaxogxgUv5+G1AG
         SObA==
X-Forwarded-Encrypted: i=1; AHgh+RqGI8wYirEu7AA9XSeFF1ZOhwmPHa9OORLrPedIysZ0bytr7pcp9p7xIfSsQqhStDnFzRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mvBgvrpInciPJ8iV5l33REllnuoxGEWv870jyNc8tCr3y3uwHj
	H93gJa/k1/c7zNcVyvCLq+J1lM6UtghfY049aeD3MNQFSXqmAxDR+SR+lv5dpzPTS2kCJRNO/us
	wB/R1Mg==
X-Received: from pgbfq28.prod.google.com ([2002:a05:6a02:299c:b0:cc2:42f:ee3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a8a:b0:3d3:ad3c:49a5
 with SMTP id adf61e73a8af0-3d3ad3c6457mr29961504637.19.1788183277617; Mon, 31
 Aug 2026 06:34:37 -0700 (PDT)
Date: Mon, 31 Aug 2026 06:34:34 -0700
In-Reply-To: <b95f21c1cb45673351df50dab208ec8dd3e8ca66.camel@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com> <b95f21c1cb45673351df50dab208ec8dd3e8ca66.camel@amd.com>
Message-ID: <apWC6tyBOsf8LT1t@google.com>
Subject: Re: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: "jmattson@google.com" <jmattson@google.com>, "david@kernel.org" <david@kernel.org>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "pshier@google.com" <pshier@google.com>, 
	"shuah@kernel.org" <shuah@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ricarkol@google.com" <ricarkol@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 31, 2026, Shivank Garg wrote:
> On Sun, 2026-08-23 at 13:36 +0000, Shivank Garg wrote:
> > Split out the guest_memfd folio migration series [1], where migration part
> > needs more discussion. These fixes, reported by Sashiko bot [2][3], are
> > independent of it and can be reviewed on their own.
> > 
> > [1] https://lore.kernel.org/all/20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com 
> > [2] https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
> > [3] https://lore.kernel.org/all/20260728091945.EA6C31F000E9@smtp.kernel.org
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > ---
> > Shivank Garg (5):
> >       KVM: guest_memfd: take the invalidate lock when unbinding a dying file
> >       KVM: selftests: fix maxnode arguments in xapic_ipi_test
> >       KVM: selftests: use BITS_PER_TYPE() for NUMA masks
> >       KVM: selftests: add get_numa_mem_nodes()
> >       KVM: selftests: use allowed NUMA nodes in guest_memfd_test
> > 
> >  tools/testing/selftests/kvm/guest_memfd_test.c   | 86 ++++++++++++++++--------
> >  tools/testing/selftests/kvm/include/numaif.h     | 52 ++------------
> >  tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 14 ++--
> >  virt/kvm/guest_memfd.c                           | 23 ++++---
> >  4 files changed, 84 insertions(+), 91 deletions(-)
> > ---
> > base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
> > change-id: 20260822-shivank-gmem-fix-split-b8a9057cf987
> > 
> > Best regards,
> 
> Hi Sean, Paolo,
> 
> Would you consider queuing this for next (7.4)?

No, I'm expecting a new version based on the discussion in patch 1.

I also don't understand why the selftests changes are bundled in with what appears
to be a completely unrelated bug fix.
