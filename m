Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1923CBE75
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603305; cv=none; b=KqTv813YLYUmSc6osy8nolpgVE/QURnFVCm7swLHHdCVtO+6jntv2Vefly7Bd+2EyeiwgbboeMGr6afoFG7ryBsBINd4r8GwYi2iyVka97r3Nk5xNATWrtaCNOAqDbUR/MjQJEkisjCj+4d2wIAnXFafZwuSFB/ec+6gZHshDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603305; c=relaxed/simple;
	bh=7svpXRcLhx3PnBggRwJDqotnihcdfOM38zOYziRLhL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZT925yUdWtJO0wf1Nf1/iQrZDngpXvR61XAxEwZwVM05Do9KnEE1i6nPa/zYTHwBuNF+nV2dSiZUjHj265lfyjTYA+zOq9w0CbfiFJw3PeI3D+2tE/H0ho8HICUaAwekiDyszbBwbssmV5KiujZuBDu8kFQXN+BlpPx2eIpH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0ERv8KI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0ERv8KI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8604fbe71eso407766a12.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780603302; x=1781208102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=brORHmYeh25RijbjqWxavSMz1lrfTLYcIXmAQLSnYsE=;
        b=g0ERv8KIH4hlk6T+7Uc/2XvazBVBxvOEPlc1j35IQybx9QWKm58+uwnk3O8ixfi1A0
         PTA0UbJutgI1jQaPEkbOEmrCCzczGR5lLMNuy/DrKOEOM+GsjKOEi9nvJswqfvqhU0T4
         DTHXDnI59Om0lp+GD8oT+REw7kIJZMgeAMVuTVT2dvt+FXS5hF2VbR9vasIQmZL6Zja3
         289yCdfYaCZH4quHvI0L4gA+UCOxfSv4NJjpanarzXvJx4CuXUYM7Sxv6PUz0za5KY/X
         4rGYsYkZ/CHiH474nitGIaQQMLweynJyjoL7zWxShcE0Wi4j7T4yDy69bn3hbxyPAAoI
         cQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780603302; x=1781208102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brORHmYeh25RijbjqWxavSMz1lrfTLYcIXmAQLSnYsE=;
        b=sYTgqfuIFXE/uB5kZqdbUvPxjwolaj6fNQvc5t4Rn0ut/ZFddBZccW8zoly3jwNeaC
         bHIKpeMf/FTggHhUEZ1VDcSgZLVJGgbakYS5PF32gpIs8j8b73QoED7zNh2OVu7MOUJ2
         X3UXSYvP8Ya0BcyFta9P+4CouF4sybKYI6Mt0U2Iy0KD1aghJObtG7YamxKYPylIzgbc
         YI9O5ntnHNSndifXvw3v13Y02XQlkKSTPveSpUKYD5u60AXvV/Sg3qDNBDScvO2dHBgZ
         9g/w6Ahlh1Qi4NHT+qNBOx8PWaxxz+FlAsZvSWk/vP71CuVqbwdm1sQN+nltcLIichcy
         L5Cw==
X-Forwarded-Encrypted: i=1; AFNElJ/i//9snz5LGhE+WVvLFA+AYAIn/81BvWnSey+70JTlTXUZ9vQlbX0L/O8LPy5CQteu1nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykX91MDbyHHmm7eGt0yKB7oFt802mfYTB1kfo1MdQmP2Ia3Oqq
	TX6GjFzVXsIhWNPvX6p8i2pxKJlfn6tnYnRYCoaP1nuhrYIUb2riPfkcD5FZU3Bfj1xDYPUgrpV
	tU7CATw==
X-Received: from pfff11.prod.google.com ([2002:a05:6a00:bd0b:b0:842:54be:af42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:174b:b0:842:5d9b:d590
 with SMTP id d2e1a72fcca58-842b0f568a9mr198041b3a.30.1780603301517; Thu, 04
 Jun 2026 13:01:41 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:01:40 -0700
In-Reply-To: <20260604020959.E008F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-7-jrhilke@google.com> <20260604020959.E008F1F00893@smtp.kernel.org>
Message-ID: <aiHZpCVhKedZvGl0@google.com>
Subject: Re: [PATCH v5 06/21] KVM: selftests: Add helper to get host IRQ from
 device MSIX for IRQ bypass test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, sashiko-bot@kernel.org wrote:
> > +unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
> > +{
> > +	char search_string[64];
> > +	char line[4096];
> > +	int irq = -1;
> > +	FILE *fp;
> > +
> > +	fp = open_proc_interrupts();
> > +
> > +	snprintf(search_string, sizeof(search_string), "vfio-msix[%d]", msix);
> > +
> > +	while (fgets(line, sizeof(line), fp)) {
> > +		if (strstr(line, device_bdf) && strstr(line, search_string)) {
> > +			TEST_ASSERT_EQ(1, sscanf(line, "%d:", &irq));
> 
> [Severity: Medium]
> Is the 4096-byte buffer large enough for systems with high core counts?
> 
> In /proc/interrupts, each online CPU gets its own column for interrupt counts.
> On systems with many CPUs, a single line might exceed 4096 bytes. When
> this happens, fgets() reads the line in multiple chunks.
> 
> If the line is chunked, the first chunk contains the IRQ number, and a
> subsequent chunk contains the target device names. The strstr() condition
> would match on the later chunk, but sscanf() would look for the IRQ number
> format at the beginning of that same chunk.
> 
> Since the later chunk lacks the leading IRQ number, sscanf() would return 0,
> which would then cause TEST_ASSERT_EQ to fail and crash the test.

I'm fine punting on this for now.  Crashing is unfortunate, but easy enough to
workaround if someone with a massive system wants to run the test, and more
importantly shouldn't mislead the user.
