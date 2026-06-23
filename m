Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C337C90A
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222016; cv=none; b=dyXlAUBommG/Pvii+truWk5VtMiNKlfsB8lyADRjgnwpi5rVeCIxJnTzDSmXxHrPxBwl28iLLcX/XKZfZDL9UdVOXLErLnLV1mONFXA4vQEsQvEqnVkfF8XQstwPd4gNo8qb8JyQD8aRcXmjhM/9b09c5FkFv9REYXfo0Wybp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222016; c=relaxed/simple;
	bh=8q5QhEQdlM3d6kQ3XX6ma4td3ssAZCufnK99f0nfE4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uixhRvlBtUBW3hY9kFZG55VC5It3uD2sMbwEnSqY7TyDj1pbcuznFnoQ/h5NrFqAE4cJ0bshCT1oEY3tCCy1+mFkXeIHu547oUpO+IVE0BRatOlkxW4PbVa5hzmXSQQv7nTWFD92XUVtokHdRzdhQvW/+uCJCPfCFLdvETZEGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuVhyNWW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuVhyNWW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c272e532so53187045ad.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782222014; x=1782826814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAvjmMtZBSA7brQ2Om+ad+/lAiJh5nkfAfWiCHYFESo=;
        b=KuVhyNWWWLP8uFtboqM3Y7Xd+o4iDqWw0HGkjCc1mL2JDSt7WyFhUuDgt9oghEqhgX
         G7aNcJbVr4c/qQ1HZEpuuizCrpwZT10eT/Q25dcVbBSXRxzLRjltSeKAbhZL0ftS63oT
         zA8FPUgAYm55RMLDOpgPp7wSUfYUBso+BDy+oleOFTeLL1MUbyvThJ9sY6iunJYysqXW
         2SsVubGUJNn6Z09SRJdDUGxtRsLCK3GA3ioeiYXe3+Yh8GRvs0oo97bHqXMeYig8Gewo
         h2Tgn1okIvyobNecyH1FaO8IvSn59qV7qyZmClbdgZrHT4cs10EB/wAQjX0OzDSOV2sG
         X0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782222014; x=1782826814;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WAvjmMtZBSA7brQ2Om+ad+/lAiJh5nkfAfWiCHYFESo=;
        b=O3OQQhoBo6x07jC1tm9K7JroB+NnZ+wfpV2tqjW0pCe/2nQUy1ttJtgVUX3XVljLEA
         WSMfJbe+nlzzxyRbYOtKOGghyt2rejwyKDm2UEmLdP1YZGGEdsFSd6HYQb4bLVqFSF/q
         8qgul3zZbHmqfYLWYk7ZMov7dp4x+Vu6bTQA6rRl9xbnOIE9UZIwPnLtomsYTFhwTS4h
         TUVSl3Xb3t/MOqkjHQn5WJPezbvPwvZKjZUpNfUGBINv1I0RZo0pS7w65C9Lg3vyURUn
         JzGmyQn8iRrVuzrIRSyFloLueM1R4DEZX8suGyS6Zhuv5X6x3kdR4oOroC49ZFwy1pS0
         szjg==
X-Forwarded-Encrypted: i=1; AHgh+RokmAPbbqjFHgTEcmBviRf+xVt+QpQaFwAkUOnYo7NlSYQ6ZTdL7NpCCYVqPp7a9syj6Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkQtdjlnmRJb+4GpUxG+iGiqKozmsV+lNmHe6kSi+EHMuuWE6
	oBNNj2QH5JmldfxSULb7E4gd7btPuhRw9Bt+aOLJDNg8SGtnKxQ15niqFBQQ0DxsZLD/VuI0W/7
	tOoR2Pg==
X-Received: from plwp7.prod.google.com ([2002:a17:903:2487:b0:2c6:7ea2:f696])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:2c2:50c7:58ab
 with SMTP id d9443c01a7336-2c7c9a34cbcmr23536425ad.23.1782222013976; Tue, 23
 Jun 2026 06:40:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:40:13 -0700
In-Reply-To: <ajKnKeo1FV3zbjEt@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-5-joro@8bytes.org>
 <aiqtWVMqTK6vDoZ8@google.com> <aiqwjn2DVOumfr3T@8bytes.org>
 <ajGOELiYwKByXbVP@google.com> <ajJAYZAPxNrrsiYp@8bytes.org>
 <ajKadxZEMI253AoT@google.com> <ajKe-oboTRowcO_i@8bytes.org>
 <ajKjMIBb21qB46fh@google.com> <ajKnKeo1FV3zbjEt@8bytes.org>
Message-ID: <ajqMvQLMGONiLn1S@google.com>
Subject: Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>, Jethro Beekman <jethro@fortanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote:
> > Ok, so it took us a few times to learn our lesson.  I still don't see t=
hat as a
> > strong argument for new uAPI, especially not for VMSA pages.  I am very=
 firmly
> > of the opinion that letting anything but the host kernel configure the =
VMSA is
> > beyond stupid, but unfortunately we're stuck with AP_CREATION.  Expandi=
ng that
> > surface has a very, very, VERY high bar to get over.
>=20
> The strongest argument in my view (and the main reason we are doing this)=
 is
> actually the predictable launch measurement. On SEV-SNP this is a require=
ment
> to use platform VM-identity features like the ID Block.

And I'm saying that unless KVM *can't* provide a predictable launch measure=
ment,
which AIUI isn't the case, then the launch measurement *must* be stable acr=
oss
kernels because it's part of KVM's ABI.  So as I see it, the issue isn't th=
at
KVM is inherently unpredictable, it's that we lack tests to validate a thor=
ny,
subtle piece of KVM's ABI.

In other words, I want tests, not more complexity in KVM.
