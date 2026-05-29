Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2D190462
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094884; cv=none; b=k4dtVmvf14QPD1Rr9h/RknwmiYieGsFiql/vsCHfzgQ5qmSRwy7nAjWcR576qDIp2KwvdaFeJL9Y4at61ft9eZCyatZDfN36GPlAVRa8A6TOUofeXjW2Vxyzfr1tGdH1aCekaZTljgWjhWGljzTcdTEILSUnvXpOotKTtj0WIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094884; c=relaxed/simple;
	bh=5yvJV9vXWs5Qlzw+uv0eTkJliBEe9uWpc/mKLSSPMHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gut81VQD7JZ+Y+SPQufNSnrNZM/dtwBG6dZp+OiGbczz+eC3xqDfikhBIUW3wRi2RK2UunN/Yj5dDnmWjWfDyIxrcDjUcXtyi1ULbPtltpi2BSFSAsGoyA139oH3GyRuLS43Sij0JaGUUvMbO08QABOxc/LlxsvZfJDulxntv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTKhD2No; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTKhD2No"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so1187340a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780094882; x=1780699682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMvAa7KIZl5UGBqGRwk9syGpPQlY3akFZd5KbTiPRrE=;
        b=JTKhD2NoouqHrqxUsqkaDP9C+tHRLf9AHkkW06Q7rtUPkYQTpk2KgmD6gMQk6YXRV2
         o19ocNjP16DsC74f3MYmZn2UBPVLRD4p6IuNJ+ca7bWapz8ucA7DcX4CVw0DiK1HqyVV
         NRrf/XpyvPd7mGjmbaEVB1V6H4lCcfhXXTtBwD6rwR1ATNYTWt2V2JK6wdE0fFulwJMB
         a8mjglsev/hwCXW0EhBO4phXOaac0Vn/tbihRoyE6XH1s+7qhUUzdD8izfeQiWWyee/m
         +Bo60gXaVlSiDL2s5AqCNkJlhA0f3DdAYwWL5Dhd2PkWFV5KiUs5ZfTi147kP/9pkvxN
         FgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094882; x=1780699682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMvAa7KIZl5UGBqGRwk9syGpPQlY3akFZd5KbTiPRrE=;
        b=LmTJZTCvSXC6cWS9I+XskX/kM8S3L8V5OwE5S+Llxbm9r4rm5LGP1ZTOnc9wpOYsfs
         lt9EfkoaEm+wuyvzG0q6ubuKhwbDx1lVbquu/06FEr8tuAlOEPPUn7pws8/K0YyadZ2m
         15QyPEjUOE7VvXCJxm97DrhMPGFlNq54ky8lvmqkuBBD4KNWbnPko0reKdlz4z0kRo3G
         atJEOswqfKVDnL1rF9yU3GxY0F9oEpAOmhKbHEjAHgozvEXtPZog5xUjCt7itsavjR7G
         Yb/lg/TkHnBcV8sj2L7ZUgeW13LG5nOGEB8OMMbcis5ac4g4/9CVWO+Zp+oEUOqJOGov
         tbJw==
X-Forwarded-Encrypted: i=1; AFNElJ8n+AVUec+Ioh1RURdB2i5MPcAo8/Qr6BiAstcl+H0/cwnfLnX87wIZuUhBNz2EW0uzxyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PIhpXdTanQ6N8HUC3niLVQ/1uXWCb6+2Gif/rtlb+rywRXml
	RjRs38nR2AWlCSmm9a39VY9A6teYO1o9r/mrFUO+c/H4kRwwEjWok1PFU9dHD79y2pzwNBeUyoV
	5YPEXTw==
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:36b:be8c:b289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590d:b0:36b:b3f4:d574
 with SMTP id 98e67ed59e1d1-36c68482266mr1051017a91.25.1780094882058; Fri, 29
 May 2026 15:48:02 -0700 (PDT)
Date: Fri, 29 May 2026 15:47:48 -0700
In-Reply-To: <20260305222627.4193305-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305222627.4193305-1-sagis@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <178009462446.880124.3655213722533116309.b4-ty@google.com>
Subject: Re: [PATCH v4 0/2] Extend KVM_HC_MAP_GPA_RANGE api to allow retry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Mar 2026 22:26:25 +0000, Sagi Shahar wrote:
> In some cases, userspace might decide to split MAP_GPA requests and
> retry them the next time the guest runs. One common case is MAP_GPA
> requests received right before intrahost migration when userspace
> might decide to complete the request after the migration is complete
> to reduce blackout time.
> 
> This is v4 of the series.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: TDX: Allow userspace to return errors to guest for MAPGPA
      https://github.com/kvm-x86/linux/commit/3e2dec1ede0a
[2/2] KVM: SEV: Restrict userspace return codes for KVM_HC_MAP_GPA_RANGE
      https://github.com/kvm-x86/linux/commit/5d40e5b49442

--
https://github.com/kvm-x86/linux/tree/next
