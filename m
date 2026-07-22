Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86133546D0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728298; cv=none; b=qD6b+kIfAF2msibtovRqh41ocOXVjEPusQpQwsa5qx+5sVkCXIbf5/NUMs/moi1XKxtT8GykJMHKYkG83dwl29mNQ2EO7RdbS4L6Q32Q0ma2eIDbzqHkbzgVTs54RUQJyjQnsxAthXHvCV0cI9jOmb22XCNSIKrTeXxfmGbmed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728298; c=relaxed/simple;
	bh=KmSl14NpFhGZYOOrvu51YFsVjduSR/GNutNROJn9pR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCei1cgEjgYmC5YrjLefxkGuN9YcrLD+xNnrRBMhWaO7KNM3J6u024ygujPtW+VuuVkSStp+anAWG2uVGy8oNlrsHdkJeuYR9mhasUAIFwNayuNFnv2B4hESu4G7x4Oye8vbb8idJbsXyewk3aM/Joc6MOvlNFw6EgokLcFze5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc8C5MiX; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc8C5MiX"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84865f326efso13187051b3a.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784728296; x=1785333096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ustquxVgfDp5qCDg5lIpkZtKikJ9TiRt9YA3YVBdNj0=;
        b=jc8C5MiXtGnPEAwj/FOATCcKe5wjjFp2mFTHNHbWlHgM5YeGzusZUQehOMf2x4w8lp
         qNdaaNfERSwdUdJqp/XgFzbyd+xvrv2FK5pGn8GbNfrXHuiEJEr18VxA0Eli0lfI7BhJ
         sVvHAZaLht3a+PlI6FaOz614PXT47vNJ9Xounswc2JMdYbuChNyDgE+sD6FIoBNDZq+4
         +xDYSS9b6hyGyIkNLeVWF+HW9LZ+gRsj6n5btZkxkCTrMwjfo0h01PTozA5B8iQauTnq
         5gydnkm1irsCS6Li4NI6EPcIQSfy+1NCsBlAQBeC0tNWOiw8Tyi5+tVbQ2OS7LI4AE+O
         j6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728296; x=1785333096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ustquxVgfDp5qCDg5lIpkZtKikJ9TiRt9YA3YVBdNj0=;
        b=R9Dm4mb7BKZIiPSyAp7z+A8C4JKpHueIF6OQ7s6Oizpo4KnDCRsEYiJKRe8ZgH+9HF
         mhtj91AaenRDhsQogC78uZkmFJNAln54qKDj+U+u5/PrzlHSEODNeG8hESNBHvVopoHS
         eAM9ua3jJ6LsZmKU35s3rbaVoCJ8Suh0fVHAhiVmAYVI/B7RFdxm/Dnp8UEIuEsSpnQO
         bLaK5shvZ/tDcIqXExBXgroL9ZVi83Fm8NVND3E/r+042evcenLSTgvrO1NvKn+NKK7d
         s1ahm8jy8TvkA5J94IABbpn8WDdOIeYIcaXWZz2vB7hxjQk5XXgk1uwXzKzRpQljoJFx
         616g==
X-Gm-Message-State: AOJu0YyVEfLcylgqhLqWQ9vRgjRrSG1d2PJwT3ICRX9Gm0BeDfxPg9hq
	fnQ3bNQm1xA1JD+NtCElh8QQA9ERgcsutjp8BwL+xa8Hacy2Bq0CvFIk8upu355MZDe1sI2Tefj
	b1Sjt/w==
X-Received: from pfux40.prod.google.com ([2002:a05:6a00:be8:b0:84c:2e32:7f79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8c13:b0:845:d286:1fb4
 with SMTP id d2e1a72fcca58-84c29505d88mr23892907b3a.50.1784728295928; Wed, 22
 Jul 2026 06:51:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:51:35 -0700
In-Reply-To: <20260722084702.1028983-2-amirmohammad.eftekhar@cispa.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722084702.1028983-1-amirmohammad.eftekhar@cispa.de> <20260722084702.1028983-2-amirmohammad.eftekhar@cispa.de>
Message-ID: <amDK50Z9WhMQZwYD@google.com>
Subject: Re: [PATCH] KVM: SVM: use wrmsrq_safe() when writing the nested TSC
 ratio MSR
From: Sean Christopherson <seanjc@google.com>
To: amirmohammad.eftekhar@cispa.de
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, rossow@cispa.de
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 22, 2026, amirmohammad.eftekhar@cispa.de wrote:
> From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
> 
> __svm_write_tsc_multiplier() writes vcpu->arch.tsc_scaling_ratio to the
> physical MSR_AMD64_TSC_RATIO with a plain wrmsrq().  Under nested TSC
> scaling the ratio is a composed value (see the companion x86.c change),
> and a composed value can set bits above the MSR's 40-bit width; those
> are reserved bits that architecturally fault (#GP) the WRMSR.  Today
> only the EX_TYPE_WRMSR extable stands between a guest-influenced ratio
> and a host #GP oops in ring 0 -- on a build or path without it the host
> faults.
> 
> Do not depend on the extable for a guest-influenced MSR write: use
> wrmsrq_safe(), and on failure keep the previous ratio (don't update the
> current_tsc_ratio cache) and warn.  Defense in depth alongside bounding
> the composed ratio at its source.

NAK.  As I said off-list, the EX_TYPE_WRMSR exception fixup _is_ the defense in
depth we want.  If KVM does have a bug, I want a WARN.
