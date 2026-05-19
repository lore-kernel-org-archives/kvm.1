Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E663AC00
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151688; cv=none; b=RDXXoTW7/G1+WDMqRxSnlDTsBlf7CiGb2tI3NnlHORCI88HBW2OHLDsJhq4Xfbn61PnB1+ctyT6wEXTenqeZ/i3kdcdL7VevV80Ig9ppIpygH1SLQeyb0PFCSY/F7zgY2EfhrrIjz7eky88jKdUapJMmgzIaRQH0m4RvfPw8+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151688; c=relaxed/simple;
	bh=QHKf+aZXn34+/5J/HD019n1CgKD1ux2J3xrbq47knvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AkOKvNpldhWyPsbL8oAbkDe1+Vh4IS5Jy9Xuvo5x1mBlDaG7T5qwb2DUh62MrDtS4zao1epVEyQOjicULd0t1thLVwGBwFiKICjVelByXERr8/IWk0Aaz3enpuMY2xjwHJ5V5BuDmr6Ua+59Pc8dDLr/27eqShw21UPtoJBp5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSQKCqPY; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSQKCqPY"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-7de75c9be06so9636193a34.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151686; x=1779756486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOIYlOIkyLAIe9d6QNLjzenaamPqaWyCi9gR//uAfps=;
        b=qSQKCqPYOKxSCtNnOdQSjb09nKtuSBQqTo/Tbd1RH5iYQZPKLNp8l0ep687ada7aXb
         q6Agz+VYh5IRKkIeIxnDTQMEFJlXL/5rUDwp9UnxXwq6pPwuEZHNtDtipimYL2Pz8lcS
         0D4ZKQG2rMm4TRAD8ODVI8iGB6fLT9nTkwj85DoI6fr5C6VaN8j4RxfPNnpsCKqffMPC
         +TyuoV1WENNt+VaFLwO9/si3Df4mpJMISPWC95imGUKx3Ytax1PHH1eubUG+jeq1q6WI
         d+mmczZ+VwYruQTD3/flNJXQS4uYz4YLJXUdL5SR0UMsQua3nuJ4p5p3bN/N7LwxNjUu
         mTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151686; x=1779756486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOIYlOIkyLAIe9d6QNLjzenaamPqaWyCi9gR//uAfps=;
        b=rmyv2WbsyNNTtIBAeB25nJjePP5AD8fFzFgxgUw+E6ZUTehKyIWj5zVkDsFqaxR+bz
         RhjQEa/JWCpgeVq0fX8LiINCZ7Q6bwRzXgl/OaxTMPS5hmB73lG4d7FcNjxEhGB8Qcp8
         PWuBbq6YBASR4sgsJzfay6JjWXSAjVz5rAg+sQpRKixt9Zse5w3Hc9rwd6ETJa+qSL86
         zPUUREHAl9TloGELyOyWHQDakeSksbF1jQzVrd2yLIS5BvEshH9QBfKUiX/ZHTJTRex6
         /QLaV52XjPd6zHhC33cobGTozPsUc5/8cQGetwiUZMCKvzWNKOe16v+rQ9n+iuh1tSiT
         aNpA==
X-Forwarded-Encrypted: i=1; AFNElJ/IiySbiZkJEL1TCgmLrJo1j2iawRoTuc656OUb23TDz9ZF+3a5Z4MlfdbtmmP9WifYMxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL14+zbOBDrNNFYdeujMdXUFx8BmIgLwQUdl9h5RgyAG84/mI
	2RyS38KjbiUfI84EgWFlQJJbPaKhOW/gdpvrXviP7VRkKKk7A9w0SnrD8+AvOeRigf1pLnyX9ZH
	j6aENoQ==
X-Received: from pjbnv3.prod.google.com ([2002:a17:90b:1b43:b0:369:1a1a:82c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4b:b0:35a:189b:43db
 with SMTP id 98e67ed59e1d1-369518b20ecmr14004943a91.4.1779151261772; Mon, 18
 May 2026 17:41:01 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:32 -0700
In-Reply-To: <20260409142226.2581-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adVGrJaRlRooO4su@google.com> <20260409142226.2581-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915096245.2229085.13630344593497072451.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86: Rate-limit global clock updates on vCPU load
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Lei Chen <lei.chen@smartx.com>
Cc: igor@gooddata.com, jan.cipa@gooddata.com, jaroslav.pulchart@gooddata.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Thu, 09 Apr 2026 22:22:26 +0800, Lei Chen wrote:
> commit 446fcce2a52b ("Revert "x86: kvm: rate-limit global clock updates"")
> dropped the rate limiting for KVM_REQ_GLOBAL_CLOCK_UPDATE.
> 
> As a result, kvm_arch_vcpu_load() can queue global clock update requests
> every time a vCPU is scheduled when the master clock is disabled or when
> the vCPU is loaded for the first time.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Rate-limit global clock updates on vCPU load
      https://github.com/kvm-x86/linux/commit/8fe2e698fce4

--
https://github.com/kvm-x86/linux/tree/next
