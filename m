Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA73A5E64
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594556; cv=none; b=dzZj7pfYzub3OZ6dVOwR6p1eh4OUpxUfTBheydIgUpf2cegxh/+709hdQnH+VrukWfsJD0j7tug8jQN3qP30g1yWrnTyFGUXRVndxEp24AUdDsbXMm1+2fAFH57rxBPGFF4N0zEdk5OgChSdfSBfFzGWH/f71K19CNBvviWUj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594556; c=relaxed/simple;
	bh=3lgJBYvOUJihZVxvp3tDnjX1cWkNtGput7veuddsjnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=inHfymYVN4e2peuWVfQX6QoATPxjLm7ziQmYlEma9CqMb9wcnaXGDippg0V/ulGPJDxhXavqlgMy2aUZdYHPa2NvqMqpdlKYxA6Vy0+5eVgsHwCfBZjyJza/RyWsm6xsksJ5lORdVDamDVpZx+eGt1QI77dS7TzTsGEdYkM7BVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5SlYJMQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5SlYJMQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c331eda3so12453035ad.2
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594552; x=1781199352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Drwpy/6s2f28VzKCEaj2ovAelgTn6xvEROsuKM7YF3g=;
        b=f5SlYJMQclreotZHlNZ083GEOM3n2xcI6hNHLGEuF2bY5uysxQ6ygLDlEhfm+9Mdn+
         TzwBI9XJdTuUoN2JEzl1PiN3/3gEN25NBNnOLzM4o0k7s/Voidp9XZFlC0zzrbeQa5AG
         pbE0xKyR8+m0b1oGeQSFd+nivdzwW1eiak+jRdSYvp5fd57CfJkuLPqrCSlF1uupO9P2
         jOBbXvdigd/k61E05nFmsSXZ9ow3DX725WqgU5t7GxRtbfpA7Iiru+gpELO3Vb/rAGwq
         1ZfkdX0pbncj5g2k9YT8t5GfpQgtqF6lZJJUJVnFB5AVsEVDji5wx9mSbCu2M5jHxAma
         w6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594552; x=1781199352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Drwpy/6s2f28VzKCEaj2ovAelgTn6xvEROsuKM7YF3g=;
        b=YmbqPw5UWi/4Ecmm6B+o9TPXLK7M/4Orczwyuxu/gC/2T9CVhq/p6EuTGVPZ9n5SuA
         Z1DeHH2jESc/HOiHPVl0zDiFJQGhzc58lWVUElnghnfuSvs/ZN3LmnrCDGkyKHMrlSxp
         lLpH9XumLocSbKd/xnLck4Bx5ZK5KJ72GPgled1VZGi9HJLtoVFRFy7JPnCTrAoeaVO7
         ZmIdOOedGHGtAnYVBd9qZqY7sLn6P5Uw1s8U3SfcPb87ZVxVTuJOiCRw/9v0bNa79pyC
         ZSX5BHifVQxjOpOZxXu1YEgv0LPwGOaGlb3uGPDKTwk+6N3FRfM9fcdGjK1XThq8YHuC
         voQA==
X-Forwarded-Encrypted: i=1; AFNElJ+WjjRvNFPEC4awl5TFLlu26jACxVyw1AhPoAaYsptY+GtmZoJTQTfdyLFhb7lCnD03xBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpX0v/Tuop2LpZPadpdxwW5abnDqTeuuvDMTkrjo33Bqic9U+o
	UpOcYjVFpVrcnDNnCGbGY+kg8Vom9w49UYu9HuhVUPzDW8fWcZxV/NrtFF8mlI7SqWglG/VsoT5
	sFM0QDg==
X-Received: from plbkf15.prod.google.com ([2002:a17:903:5cf:b0:2b2:4611:5de2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:88c:b0:2bf:30d2:e891
 with SMTP id d9443c01a7336-2c1644dd2b8mr59102155ad.36.1780594551963; Thu, 04
 Jun 2026 10:35:51 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:35:51 -0700
In-Reply-To: <20260604020143.748245-14-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-14-jrhilke@google.com>
Message-ID: <aiG3d53A1G1J2_r_@google.com>
Subject: Re: [PATCH v5 13/21] KVM: selftests: Make number of IRQs configurable
 in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add a '-i' flag to tools/testing/selftests/kvm/irq_test.c to allow users

Don't spell out the path in the changelog, I can see that from the diff.  Write
changelogs using conversational language.  E.g. most people won't describe a
change like this as "modify tools slash testing slash selftests slash KVM
slash IRQ test dot C", they'd say something like "modify the IRQ test".
