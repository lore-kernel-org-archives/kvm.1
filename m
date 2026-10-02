Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B72E88A4
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975458; cv=none; b=fSaaDyC4FlM22W0rI5ueEtYf1bLhnPQqcXUCnBW/QCWPaB2X62QInX9dHdbKimjF4dyYUckk8LepR65Go4kzZjJT3H6EigdxXMPpTrtHfakMpqWQUHF7O4VfYM8JAyYKehsfSC0MOlWp1yk1FLc+3XIXF/m6Cedh3oKVSPitqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975458; c=relaxed/simple;
	bh=78V9UClLkgSM+Q096DNl6yANoiNLypQ69ySOW83Ohak=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqZ6hLK50pxi/7jEuycLtzvhe5SP7YS5Zsf4lkc7fN/duRUzsgWBwts/dRVU7xJImZ0/QJnpW3CzkZD3f8lmq7RIXnjwXOffKyhN4SO148FDyO+Gf+RyL5Z2bfTfI8UwL7a5btwyCdAjgpIi0PiG60Dx/RvB/M0w2eO5xxFAtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjtVxXao; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjtVxXao"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2d3a3ff86so452295ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975456; x=1791580256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Encja9Pa0cINRWL3UIVwC6uU0b6hKnULnXvKZW+DXSs=;
        b=WjtVxXaotpmjsvLo9VfcEW1MM943DNZ0DvS9VOypyu4ejBEOZY+c7pxTKtqDzznqs+
         wB8x+BmVNai4Gfkwi58b6aKPzj6vxrNyDSXZi3VxUgTmR0vHSMkLghFcZEsmg+TZiYWw
         sFlhqhdRO0m22GiG2MSHI7qPkwCbUGJbc7MdV5wjbAnU2L6+m+UXZfEgMaNErnT6y76G
         DspgHiz8+FfZyA4JO6ixUjHeRw/KPKKmNhz9u0/QMTM7L8AQzmYp6Vkw6qqVnU+l4lDY
         rkU/YBKy08WcIAkC1fQs3IIvp3tt3ir3Ylch6PPVv5XCjjdPvFHx1J5IYFfAWXdnt3vU
         3b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975456; x=1791580256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Encja9Pa0cINRWL3UIVwC6uU0b6hKnULnXvKZW+DXSs=;
        b=fDV7YN8pzk5O/k5WhdxLcVRfTQXBIsXs7nv1mgdyiQ14uew7v9iBi829yvm31l2n+U
         EJzgNp6H7vHbbau+IBVcNpHL1S4UiS7Uib4MtQ4BMZSAGdCWVywSdvU0hds8yDWv06Fa
         UQgXlscWPKGGYc/DXKdjVGX2LmJvaYRRrbLXG3l3UV44QsnwY+yktSHYmqhxYz1s2r4u
         hKHJre12dbVpUHshdaTyZze3DJBUZrpJFEZK0Qeio5DJalApSZ7NJmUMhLOzJ1cptH6o
         zfgdWWeWkGvK5ufTp33wtnU3TyrS34uRhkq1h5cL+XZ1oZYrpir22sp9eaony/qSYxyY
         crqg==
X-Gm-Message-State: AFq9FYJGqohJM6cv1gzMaUaiNLqt39Y7JKoqMnhgnXMtJ9G/VD/RVJzM
	0FL0DwvKq+OpqiOaE43O4/HhpTHTS10dImaxC9gBMiF0VoXnGw3dKZRiPxxAHpZdo+JPdHoEwlX
	TYteTlw==
X-Received: from plic16.prod.google.com ([2002:a17:903:3710:b0:2e4:9be2:d072])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da83:b0:2df:5a40:3d52
 with SMTP id d9443c01a7336-2e49b6770abmr36763835ad.34.1790975455961; Fri, 02
 Oct 2026 14:10:55 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:24 -0700
In-Reply-To: <20260929202434.174501-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929202434.174501-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179068806716.2832648.1473072136170287671.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v2 0/2] x86: Make ACCEL_PROPS work
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 29 Sep 2026 20:24:32 +0000, Xiaoyao Li wrote:
> The goal of this series is to make ACCEL_PROPS work, which needs to use
> separate "-accel" parameter to configure the accelerator instead of
> "-machine accel=xxx".
> 
> Changes in v2:
> - Add patch 1 to resolve the incompatibility between "-enable-kvm" and
>  separate "-accel".
> 
> [...]

Applied to kvm-x86 next, with massaged changelogs (typos, and calling out
the kernel_irqchip => kernel-irqchip quirk).  Thanks!

[1/2] x86: Make cet and lam tests KVM-only
      https://github.com/kvm-x86/kvm-unit-tests/commit/efb3e010b96a
[2/2] x86/run: Use separate "-accel" option to configure the accelerator
      https://github.com/kvm-x86/kvm-unit-tests/commit/69ab2df8fa28

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
