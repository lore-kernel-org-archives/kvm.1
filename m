Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E33C1985
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056406; cv=none; b=gpJ1HvyDiY3Ar8jGU44O0DXwrvg3IC4RdW3zJQaHYHRjnNX1NE2vExTco0dI6/hNz5rzIztqnyL0V5qsXKigJvBzw319fZMJTDMzwQLRHUesGG8/lMhrr1rFYtRgIy1SQqMsgSguglIVJcVatv4GbSMyOYlZMkre6nGFkeKgJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056406; c=relaxed/simple;
	bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KGLHyedqMHiVbnSVoHLdyIxqd1GEC4GBeKSHZSNgRBZDxX09NMbDvFUJhWSYMdFcJ1ZNTLfCnHPNsvpmCChbDVy0VyWEsFnYFTPh8Gbiu1xGF7If+GcGyrSigmWyR/Hn35Sz0DKU4FLYhAIVI1a3Za9cm/2HxQUtnmffXNVlAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPiFm8i+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPiFm8i+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so6385467b3a.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056403; x=1780661203; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
        b=kPiFm8i+jLZsBLFA5HfJufsgEyFUi53a0JmB0/hn3m0nCdRSICRmCXMfVqzRkpPL0B
         BidNhE4uVLU4KopEXFOGkJb4XV34DIvCNlLWQd37FD6at2I6gjEBT32jU5iKPABFxSQy
         5vP9HhVDXXkRpbZ/9odGugqiW+jr8SBmK9lwpiFZkIGnvUrfAsY5Zhh9eE2kUi7QxeQm
         11kruOcvV7m0h7mLgfVH+pJv3MIcz9nK1HMWop5/whBiMopk/xMkGDaRRG82PmCOMLyD
         gsoLuZ7vdAAuoQDNc/5vxEWAs6Yp7A0KqxLJWhmNCcPbt7RRDAifmF5Pay0cOxV+Go4T
         CgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056403; x=1780661203;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMTekUZk7VJcI+1Zj/828Egv6I3G6W5x75YXUNbi4R4=;
        b=MvYWEZIRg3O1mWB8OYjlIqkeVCUg2UXt8UDLs/mMhvN3H9o4QDPL6IjpWFDDRLulos
         FRIUU9NLTash0jdb6plTrStKMq60aqZkMBk4DDO8menWjm2WpPZ2FJ5UKvHc+1zhHXIQ
         FRmUG+jtiw4kLeMHSM0d8oZNbRVmGdbT+GRzQ04TO0xCExgrL276xiVgmLTKAk0MxNey
         QBLdFGL8lqAQh+7vJK5ULvwJs8EO9zcllLZ3QA1PAOOe06/jk/TggR4XsQ995zeuHUpa
         qASP5TAQ5s5Nv5yGDF8A2EylWGRujOFBvq2G4tjwdHry0vbvY/rRLlM6QTg9mK+01TWM
         dnRw==
X-Forwarded-Encrypted: i=1; AFNElJ97ssJYZsmnMkcsPUMw/doqnv2j2Awn/c81M7wnBvKUjEhAxmTCgMy1SnX3sLVDcCpgeOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsAzJqhmG5hzWVGUO7xCmba+yUvsEW3J/E10Do0Db4QPRJruc
	/guBoy+/zhUQ5y50SqjmLbda2tUPXDaEFv6EmP/qqkBAmKOQKoH5H52c
X-Gm-Gg: Acq92OFwdxw3PXP/WXI/EPk/nJDx8zD1qKMNruZAvRsNcesqTJ0uMVuSpUhPrjTdr7F
	5HIhY5QuDkVAdYCQgnm3PYO1tUvIwrn5NUZufebiBwmmxb+2wQhU//wIEQ6m+79s462yGu5o2bD
	HprYCnyLcrx78ZpJAHtG+5B0PHRUk2It+rLSyb02IdVaE8IT314kzmWvBJ9I60NNJDNJ0LVI0PA
	CURlgbeB5TS+88+tQKKbpBqD7oGloTBazs8qLvdqMD/43/mghlAH/2DdO8iaplP9iRB8vjcv8/n
	hWlunavV7XDzrVwkjoLH46ThAbYggK+Jo8Z6MeJ8KoXQ4dpdlHA5ow5G3K9cK273p6YigO+968O
	aQbbQde0lROH1xznseZffTHCoRn2jTa1WoAADbw6KQjY8cybs/r4uSg60cg8MbypQNxv9/2c5Xv
	pkyqeigxipEUMAQURbUiAcTkWQA3Rbicy/
X-Received: by 2002:a05:6a00:e07:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-842119f9081mr2172322b3a.21.1780056402907;
        Fri, 29 May 2026 05:06:42 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214afffc1sm1838798b3a.7.2026.05.29.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:06:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
Date: Fri, 29 May 2026 17:23:39 +0530
Message-ID: <cxyewhx8.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com> <pl2g6xbz.ritesh.list@gmail.com> <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> So, we would still want to prioritize the whole series
> instead of just this one patch.
>

Patch-1 could go as a bug fix even in 7.1-rc6 (or maybe with 7.2
bug fixes). - Maddy?

So, you may want to add a fixes tag and maybe even cc stable if you are
seeing this issue from older kernels maybe when nestedv2 got introduced?
However the new UAPI discussion might still require more discussion with
the community and I don't think it is ready for 7.2 yet ;)

-ritesh

