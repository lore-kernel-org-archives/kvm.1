Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C748A8B1
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725810; cv=none; b=InvCnGLwtMen4bmWPjQsx7py26AnLq2cAsKd4cvXTAe/3Ix9AaZMJNCZh+7EDK0a92Q/zSBoEg80PH8ScMkhAHt0W98a+TCOeHYBrJYxdAdl8wdpk9aYmIEWnC1UhopGuHPuw/oy0enIYJs0s+EnJP/9nvwF+crh947PY4AZtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725810; c=relaxed/simple;
	bh=8PPb9fnW5inzVvVJ0q4AtntZzt01JJ1xSrRX1Jz4xDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJpl4ROEj8sd3kp9e70r7jl2P42LW20icUGBjJKVG0EzbScfwApNfQrG9el/MpdxwWEwrtB+wg5N7TNK/x1mMf20rt0mSnLeCg5VHHVpWSoYs0wVu71Ng5eBSsiZJLsiZVp6XqMIFxFkiMtey5ayslfXI5SuyprY1yetPCE+7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsRVv0Ya; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsRVv0Ya"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8488ac68185so2248886b3a.2
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786725807; x=1787330607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PPb9fnW5inzVvVJ0q4AtntZzt01JJ1xSrRX1Jz4xDk=;
        b=jsRVv0Yafui/lQCUUuOFNyBGl4gcu9aNJiAPVVUMvTfdRG8BByReJBPsmhQ37HGNap
         zHDxCAGedE0ngbX7yP2AeUtbDL/xjAOljtvzABLJiFs1xHSYa7ySyB2dVZ1YhWhxr0C+
         Xqrq+tw3E+56eCJ9KR0mpySFqouN9iNWjmIvYFHflUvKuHVM0e6TwZLklIY1eyCPTPRc
         YdkuuDMvuTcGm8SraHW9OWz6peK2M0B7/DTh9Gg6g6a6+o4i6IxmrLjKgJUE14+TEfH/
         16nOQ8N/VsaTJWgI2l3jch1u5lU9C9uWPT8srjI9PgUdgHlt6tpX8PaPEFmyCwdSsLmD
         OE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786725807; x=1787330607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PPb9fnW5inzVvVJ0q4AtntZzt01JJ1xSrRX1Jz4xDk=;
        b=SWCfaH2Ytfp1bF7u436X1PF6X/mRE5OB3hZmJyTXMceHMwHRkAXDp2z4cMmRUTNTU+
         XL4hj2WU3KLcUnVW2V7Cp2+PIA6oZvM1woierCxDmOCxuESlDPg/8TH7kAPoTUAcPyCz
         krowSZMquN7u+8DhdlX6qPyak6Vfd0B3POR9auShyUsLxhjqQZGDaG54Mz313f7dmL28
         JYvcov1gQ16NG2LzNv0ytqqcsyjclA+Q2ipF6+m2sfiHCoMS9TXvWetCP092Pxafalmw
         qKbzJgaDBduzhoB4BO0MkMkDOh2TWQJO9xidGyNC3e1NkUj47KvhWDkjIcthdh8UgPG8
         vhYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCvRLoOoxPPkJCUk4s8TDKLdAJ7AdkkwXW5vyih98kso7bb6yxnZhZtbTuVR38crslGcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkqfh7jrcyeCEJnuPVfBJ9bix9bstwlqvz6OQVQg3NNG5xHfqq
	rEoIgT+VxoMnyrALW6laOGpzkR77Z5EwNqYGkhRFjODg6NHcKv+SctHIRDttT7D6I2Ea8idYwai
	dnHPHcQ==
X-Received: from pgbeh9.prod.google.com ([2002:a05:6a02:2569:b0:c92:864:4328])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301b:b0:848:76af:db37
 with SMTP id d2e1a72fcca58-84fde11e1f5mr8614245b3a.7.1786725807369; Fri, 14
 Aug 2026 09:43:27 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:43:26 -0700
In-Reply-To: <20260814163137.297DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814162221.2144473-1-vkuznets@redhat.com> <20260814162221.2144473-2-vkuznets@redhat.com>
 <20260814163137.297DE1F000E9@smtp.kernel.org>
Message-ID: <an9Frud7pHPXMFRN@google.com>
Subject: Re: [PATCH 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does handle_vmptrst() need the
> same fix?

LOL, one of these days Sashiko will look at the next patch before responding.
