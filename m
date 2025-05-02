Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78520F09B
	for <kvm@vger.kernel.org>; Fri,  2 May 2025 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222723; cv=none; b=PNbv8CSNAypHVxWJ43Y1Z1TiqYwzjWX3kO6G0G+bCTWd9VfUXL2OgKB0XameAfbg9QwWVt0ynn4hbT80YMqC3+cP1TmYGzEsHK1Fy64iHItlb+jJjtlsHAFld9qSkg/idfXKWbqgzzdbz1QqR26FdcF4aXUu8c9D7nL08tLN41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222723; c=relaxed/simple;
	bh=mTw9meZwxQX27VgMX/IkJeu9X1ncOgS+hPnL6MC6iI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6Ng96iv8H3yY7LflrNZYYHopSSNcKqj/uM6RW4SuMCgnpHYgwhXMoX7EjTezbSu+AYGKSLPcg/1EccAWd68hoyOKCpP8sxpiEe2GM8ECeRdPrbu3SUq2CB5LW0aM7GceI5pcYv4deww9vRBN6GVF066NlKj8x/4yTdO2E9HBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en7quOWS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en7quOWS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30828f9af10so3605401a91.3
        for <kvm@vger.kernel.org>; Fri, 02 May 2025 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746222721; x=1746827521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUERDQgic6jYhSnng0bbK0BO6GHErZXOAhSsWHpvBSw=;
        b=en7quOWSoB6f9z+BacOtdUOzedlOHnpSL5UMr/oFWktSdme9OutoypOoEyHn4bTH/x
         3uXqS2kuCOnkr9zI0StLAJJ/uN35ljWwZKUWh54wCPKAuvl8ch/5PP6ZdmynzP6fHced
         zOBDsN7CWJxLLHKCWVvCsL2DA7PbwKIRgizLfnvgrYaqJY5UI5G3lN6g43QYL2S/d7dP
         FbCXif0634xYKdGSp5at092xKiGxrOFO3inKoMmOeK9WCTSQc0EjPhqN3+QAkSJseSYV
         Lj4RDV2+R7SxUe0YHVbxsgGYumt4NJwQP9DdZfjnDnjkcPYAtL1NCFfrx31Ma+IdKc4y
         cdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746222721; x=1746827521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUERDQgic6jYhSnng0bbK0BO6GHErZXOAhSsWHpvBSw=;
        b=F9QVGfza53uypD6jMqxuZKdp28kXFQoE80aC+Ld1KMNwJifjOxmZr3sKEaSiyeaK2B
         PMt5f9DIbpaEs77gdyi0Mx3kh99qV5+VRT+uK1e743hG+UmpOKSLh0PvZ3mVVK7Gra8B
         tXEqMsfNb9cx3TJxXU2SN3Lg0nY9bx/zlcukZOIRb58jY+2BZuiUedUO2O+TjWGX0pNh
         CS5U0wWoPcBtHTdlUKWCiQz2Orz4UIDd550/l86fnQn8K3WGt6fETB/WVIz92eX4L/uI
         gKz48m+cJh5mxndwGAPhFnPZGt4edNOBEo66ddWPZh7HlCUxM9fD3fCOZMwnsQ9Q6ogj
         pfqg==
X-Gm-Message-State: AOJu0YxDUmhxcoMegUbTUq5QbuB5vLJLVXkL4qYQR/bCveE527BUtUma
	bkVKZ4UAAHNco04Fp+L59vqcAnJGICEpUHMmp+QOu+d4BXF38fEZc0b0rN2Fr3Ltd7TU/Z6k+ES
	Otg==
X-Google-Smtp-Source: AGHT+IEwgH5mk6MVRWNhPp+TSJ2BuOkDoyHYKUScxrQW1rPrL85Vc8OC6M7uCh2JJCo7Vxa6BdY8Sj9gbmA=
X-Received: from pjbpt18.prod.google.com ([2002:a17:90b:3d12:b0:2fc:11a0:c549])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2747:b0:2f2:a664:df20
 with SMTP id 98e67ed59e1d1-30a4e579ef4mr7443371a91.7.1746222721474; Fri, 02
 May 2025 14:52:01 -0700 (PDT)
Date: Fri,  2 May 2025 14:51:01 -0700
In-Reply-To: <20250227222411.3490595-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227222411.3490595-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <174622246244.883023.7921101160630129073.b4-ty@google.com>
Subject: Re: [PATCH v3 0/6] KVM: SVM: Fix DEBUGCTL bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Feb 2025 14:24:05 -0800, Sean Christopherson wrote:
> Fix a long-lurking bug in SVM where KVM runs the guest with the host's
> DEBUGCTL if LBR virtualization is disabled.  AMD CPUs rather stupidly
> context switch DEBUGCTL if and only if LBR virtualization is enabled (not
> just supported, but fully enabled).
> 
> The bug has gone unnoticed because until recently, the only bits that
> KVM would leave set were things like BTF, which are guest visible but
> won't cause functional problems unless guest software is being especially
> particular about #DBs.
> 
> [...]

Applied patch 6 to kvm-x86 svm (1-5 already went into 6.15).

[6/6] KVM: SVM: Treat DEBUGCTL[5:2] as reserved
      https://github.com/kvm-x86/linux/commit/5ecdb48dd918

--
https://github.com/kvm-x86/linux/tree/next
