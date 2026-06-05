Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE8368D75
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684355; cv=none; b=KhnFFGGiuU/YbDTm6+LL0SXa9eFtzhUXEzwyMP3I9ilGG5Sx+wnld7i4dvDc5cC9goTRD9nChqUN2kTnE3YNjof2QMFLzGNljE0a9IVA+crmxtqJOhgBdgxqRYNCFSkFX4/1nw0oBeWX+1ItWKybUJ0MJPhNOIVhwLUwtk9H44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684355; c=relaxed/simple;
	bh=LEK1kFPPDLdt1q/ky89ZSOs6sgBbr9K492P7SgzYC1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KiktXozSrCJfPlNN9mYA+N31GATbUNmxETjmpOVpB2lYwzWnioqObxzSgzwv+Np0GOUbxjeo448rY0L4OglziqlcpWAFA+lZdbshnCJePppw7KqyUSztuZpqsxApbjWOPodj2LrOKmds+f7+ztI/H6xlCJsC/jGK4Xtk1qmNYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RETS6e5r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RETS6e5r"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so2088724a91.3
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684354; x=1781289154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILgTySZ6hEVu3sD5iWFmyLaeS/EaFbNh/7JccS6Vz24=;
        b=RETS6e5rx/c7aafrEnthbgJz7aJISbXCLjAlZ9xAR/nAFKVSDMTy32njTeHEAiSQlh
         VyvXhemi7A/Yghh7fCAKx7s0f2ks45a5KxSv/lTVaet0eMTmp9sUqr/bhCSu+ujXzVq/
         6znm4eGOL9fVQWg+wXNp/8xQgXQWeyIR1Qnf9RMgnHKtZhj8y9QOrltf5zqkFi0VdYEt
         R46fnIKk7RyTjITDL9ePspPygfAubCbDrI4ujoIKLO48tvnyXtMpLjPxvx93RYonpKsG
         wwgQxDS1DHDC4iF4GaHHli4EZEbWeQrVFkV0t5EGpucGbH6XZz7nGD67l94tZ8LaiOfI
         k/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684354; x=1781289154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILgTySZ6hEVu3sD5iWFmyLaeS/EaFbNh/7JccS6Vz24=;
        b=io6ROBQUk1naMxuFpWE3bt91+Wur0t27CEIFbDtvNbfvrzcHis8jxI2yHSOHfFQNRr
         CNe71AeCMjqgz/p1PF5yboO9F2zg6BMFFQSe73iqhijWo71+EDSmvDT2fe9H7xeDZ9If
         98pDFh8r4YUkfJz5aDAZxEr633nn5Rj0D2Xk3NHyogITvhMtvEPspGXNjxn/jf3e+fr4
         GvNm2iL+Flv8QXN4nUiMEgGOOlhyUsqX5TOIj9lhAtSjW1SGK0AEttGeQDVYvC75rk49
         yBOwrLI9tD3dx2gTKY1tCgo4BAq1T+lrJxkGU2Jf1RMOsI01e16vkM/IYl5ZVR6nRiob
         a4BA==
X-Gm-Message-State: AOJu0Yx2g+E8nqcDWHqe9BcqjmoaRhCiqG8dhzelOXiVZYQfWkMbkwzM
	HCuwu5inns3Ymfler3F/lkn94EVMLAS3Zm9e8ekOv5F7ydL8bzRulPNUp8LimWdmkdqT/iqOH0S
	oTPGtWQ==
X-Received: from pjso21.prod.google.com ([2002:a17:90a:c095:b0:36b:b993:5186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d81:b0:36d:66d4:270d
 with SMTP id 98e67ed59e1d1-370f0582547mr5218306a91.20.1780684353494; Fri, 05
 Jun 2026 11:32:33 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:49 -0700
In-Reply-To: <20260528231052.404737-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068414043.2235650.4274865348571075426.b4-ty@google.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 28 May 2026 16:10:52 -0700, Sean Christopherson wrote:
> When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled, verify that KVM
> correctly virtualizes the host PAT MSR and the guest PAT register for
> nested SVM guests.
> 
> With nested NPT disabled:
>  * L1 and L2 share the same PAT
>  * The vmcb12.g_pat is ignored
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: selftests: Add a test for gPAT handling in L2
      https://github.com/kvm-x86/linux/commit/adeb462cecae

--
https://github.com/kvm-x86/linux/tree/next
