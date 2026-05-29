Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422931F9B3
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061249; cv=none; b=JWULrq8ff1DUM20/UO4388v82MKj27GKpuPyWeCfnQSAG87IcUlbnBYd8il/u52VkVVV3egL5FA5pWiIeg9oMKl+Yi9fUUxXXXe7Ygzlw39KyVsXNDBDirvpNnnjDVPX0o3BHdUT0DAALihlaFJLP4shi0KGJnC+oobmV2WOvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061249; c=relaxed/simple;
	bh=C0e/Ez6uh7FiLV34JDhA/vXiu6NfONlDk6b6EKC/S5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1BusGwG4KxNrLhBMJZ8CHW449tWA4MXIXs7E3ivWrHIVmt5zPCygZpnifVIiB7RZG3GLrmF/V1qtvPKviXLQmTWv0mZL9n7cO+5XoWUw6HqthtCnkUcqcICR7t11fzuJF8RsW+b3/Y7c/fwwOhyIEqltdQ8n3EfsgU2ip2LpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUhbsYgy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUhbsYgy"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso8286621b3a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780061248; x=1780666048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ9BShFIIZUp6olE5smFD4V12PZweAZYt2KEUAipHLA=;
        b=qUhbsYgybio9sjtiQERYbUYEwPR01sDeDb+R6syzsrEeflVQCCvA3fssO74vmrDnd6
         vRaRDPvaaVnSXApMWeZeLMAYuTuCj1iX+5scB9pAErMUqNv1GyNCCu9eeohNHt2pu9BQ
         2+ySlS/JPNmqxSGmltivb8aR+q/3ap9URkGNVsTsV7i/emYv3Z+vo4t50+7+dJMCxXRP
         AuXsG07JFn2pd42g0IbgCjuiCaSVR7Hka/k9GJNnChIP6LsXJUpWloAnCjeQINNdb5ti
         KJCcIPDhbLA529qr/CwNWfvu0kFLuZceu8OYREPZX/8ofYFAOQG7N7BjRyEbppTUyRBl
         cQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780061248; x=1780666048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQ9BShFIIZUp6olE5smFD4V12PZweAZYt2KEUAipHLA=;
        b=lrUW662bch/5Ws9wK5wE2nAGTKQqFw6/NNGnQiAS2S0hvZdHUsn5/fsspSPfmtV5BS
         o/M/NGRxAA2LFLpeg0pc4zTIyquFtjBjBhTsffp+ooGMpZj80tLhzrRS8NB+zVo7tL98
         Vandh10iR3C5R0L3sUy83HbSGBxwcX6teGU98FsVd+0TMMu88CEYbLCzBBFFpDOUQZyf
         CuJ3tDAqZJ/LQQevSClwYiM7yICRz2km7M9lcyPTxfvJXmOI6x/abzLgSEfi8TPwwnCN
         z3KRfr7A+Do4KJigsvHdDWAUvfDJdjYw/jKNlAwFBYHUabxsOVf0IRWmeRthwA4Rpuqb
         dGGA==
X-Forwarded-Encrypted: i=1; AFNElJ+VxZirgP20URBWmH5GigL/ISrGKsqPOr5Ijo8C19hpAd/jlMezWhlu/jdKeCkNUrgxjP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFIkRYDCZNlbUIOYiJ7ChspzdjsrY4UGnpWiKwY+MyaLXmEPD
	LCsmsw8n7ba/uq9GZzzaizguO0+n71rHsGThhjGjOO9UVgB65kpM58THeIfcXAfonmw+5hjF0UN
	L+1N+zQ==
X-Received: from pgsb25.prod.google.com ([2002:a65:67d9:0:b0:c7f:ca3d:442c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3208:b0:3a0:bc61:62e6
 with SMTP id adf61e73a8af0-3b411c00dd3mr2946625637.8.1780061247623; Fri, 29
 May 2026 06:27:27 -0700 (PDT)
Date: Fri, 29 May 2026 06:27:26 -0700
In-Reply-To: <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
Message-ID: <ahmUPsB2nOPFCRrW@google.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Yosry Ahmed wrote:
> > +int main(int argc, char *argv[])
> > +{
> > +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > +
> > +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> > +               goto skip_npt;
> > +
> > +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
> > +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
> > +skip_npt:
> > +       gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
> > +       return 0;
> > +}
> 
> The goto is really unnecessary here:
> 
> if (kvm_cpu_has(X86_FEATURE_NPT)) {
>        gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
> npt_enabled = true);
>        gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
> }
> gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);

Well, it's necessary to avoid the indentation.
