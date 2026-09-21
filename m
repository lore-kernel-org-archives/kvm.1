Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED283AD539
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974665; cv=none; b=Gz2UWMlRKT4l0lw4KouVnYIG/1mursT0F7vtlTUDvc5sIPyepSb4pW0h16OtvSLrMhIlUogUe1s8zsngAg0B3f/FXawlUYedsbdOlm20DDmtTLbjP4q9mumqAJ2mb4dM7/6YpuOQTpodSb7tj2nYerj5ZGHfnKiisaKLTr4tixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974665; c=relaxed/simple;
	bh=Eux8pfzDoKUAWcecKGVOzPBlEfy59s1p123uGcIZ0h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXay749g3P4k7+tqq2UPZ1hwUyLcq1Xd4t/RDTJblk2mD8nojLqblPDm3X/PSBg1A0qMfmFCEfOsRxF5YQ8wpVwhL2pU0dkhIgcji4tfVzBUgQe/KtvcI6+aXbChkwpc/CBGofKov7dnWptHuBXb+4oO4Wg+/LfWU2RhvMMPF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=odhsy0lf; arc=none smtp.client-ip=95.215.58.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="odhsy0lf"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Eux8pfzDoKUAWcecKGVOzPBlEfy59s1p123uGcIZ0h4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789974661; v=1; x=1790579461;
 b=odhsy0lfPB08u7CB0z74GAcCLpfp6i293umH36jRRwAeyN6iV0Jxpn7dBiOQMrKuhHoVmjwM
 QUbL6Qm+sUFEHp+JYFUKSu2XWmIp2rG0U4DMCKZmr8oDruoVBbAbaK5P8wRDZQFeXxmXcqdfWLg
 4tKUdnlmcXec1CXADcMqDBsI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a30d87bd77f3cb2a;
	Mon, 21 Sep 2026 07:11:01 +0000
X-Mizu-Trace-ID: a30d87bd77f3cb2a
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso5966e87.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:11:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3MTdr96XNFOygg51trhGjzv9pbbyi8wLAJbEmreF3fuQrTWosrT6iXpnBv/lxyJdkCAM=@vger.kernel.org
X-Gm-Message-State: AFuF++mWoOOFs6qSvWsgF7mAYdyi6QbchCDFGEuNA2Yric9kS5XsLYeu
	viMjvHAC/y0lCLg6Nm+d7uyHW+U+Ci9jKqVfNIFRRrM7piVFZHnzC2EvaFL7Q4m/2Zaeuj9ifRJ
	GVKGA5UALEKpZNhxEB92zzI04TFonXyJDPbyMHSB0
X-Received: by 2002:a05:6512:2216:b0:5b8:d049:c45f with SMTP id
 2adb3069b0e04-5b8d049c61amr15291e87.14.1789974660051; Mon, 21 Sep 2026
 00:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902134118.2718200-1-fuad.tabba@linux.dev>
In-Reply-To: <20260902134118.2718200-1-fuad.tabba@linux.dev>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 21 Sep 2026 08:10:23 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyHJjN28zXYJUF9otZvyWP5-3Ln0fy=xJ_EE-bOdvMmHQ@mail.gmail.com>
X-Gm-Features: AcwNN1Xk01oNkxJ7UZIT8ZwQcfv1F3nhRMlj7kGCMC3JqdaEoVZDyc6bymlUU9I
Message-ID: <CA+EHjTyHJjN28zXYJUF9otZvyWP5-3Ln0fy=xJ_EE-bOdvMmHQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix arm64 sysreg header dependencies
To: Oliver Upton <oupton@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

On Wed, 2 Sep 2026 14:41:18 +0100, Fuad Tabba <fuad.tabba@linux.dev> wrote:
> The rule generating the arm64 sysreg header targets the generated
> directory, and its only prerequisites are tools/arch/arm64/tools/*,
> which is the inner Makefile. An existing directory looks up to date,
> so an incremental build never regenerates sysreg-defs.h. A selftest
> referencing a register added to the table since then fails with
> undeclared SYS_* identifiers. Clean builds are unaffected.

[...]

Gentle ping on this one. It's arm64-only (the Makefile.kvm rule that
generates sysreg-defs.h), so I think it'd go through kvmarm rather
than Paolo's tree. Could you take a look when you get a chance?

Cheers,
/fuad
