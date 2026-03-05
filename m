Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21283E1200
	for <kvm@vger.kernel.org>; Thu,  5 Mar 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730760; cv=none; b=SgD2Ijzk3LMUz4BOHxX6WOPS6NHNjjnnlBwp+ZQSVJHCi+RU3OCWhK5beLIWEAhvAB34JVxrJo7oHIGwtmIm6cwOQnFq/rMbKe5nw7dON7M1kGBfMY32BCSUFcxuoPWDvFxdPpXjwsyDVhd03HiqYg8b5tUBaRkhZeTUQlyztAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730760; c=relaxed/simple;
	bh=/GBXVfac68MdWpS9IPkjlYgDOQ7R+pVysyaAoMFshkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tD9FmXvRMHP63lDnI4FC2bZDQjW82wA2BtBAI3KHwy7RqooCNAsLhnI2H/UWPhAu/uXlURkfYbjemD+dM6FE46q2GvKbLbFqcI9hCGqll1PKkrxz+Yw6Sduv5zlLar7RrjFQWcaV8HGWUQmbHrB4ApgealsyBMXNgRtV4IyFkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFsGiG73; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFsGiG73"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4e9577ceso202205065ad.1
        for <kvm@vger.kernel.org>; Thu, 05 Mar 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730759; x=1773335559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVU6FN0uky/dFXnRa2qLZyTUmWtwIpEtVM3+JzMj2G8=;
        b=DFsGiG73oNRHF3ik9JGjRp9oBJeCINfnncqwo8XWR1/TuKmn1kbLHiTuxG82OJt9Iq
         dmvkw3cagc3zEUMsJ2XpKyM/FAM5Ik16KVMrpe5Dy8whkijpviEDfkiN9c0okmXjatDL
         dOCKRtGDVrEP5RUNyqumtec2eExM4T4oyCEZVzRXgVRaslrPACPYYqZDNA+30/ZxvbEK
         XLFEI5gq/RYIL4Ebdgeqo/iD7HvG4bIFsVD1hCgBeX3qTYpgeF+eZ1SZXswMHe5lqOoS
         ElPTHES+1JGyGrVkGYDOdw07U1ddpdgkcxLLqAHmx/9tr2ofKiRgmmUUtZHPdZ/+oPRp
         b/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730759; x=1773335559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVU6FN0uky/dFXnRa2qLZyTUmWtwIpEtVM3+JzMj2G8=;
        b=mrOegd5DoD4USa/UnaFQMQdOZFh6jU77o65O63hF0KJ2u/g9ICOz3qBd3KMr49kpyR
         fVH7ZWYAvWo4oyXlzxsbL/TBWZvxGZsfN5Vk9WavthWCgNuhbuZRmmDm1zfzISIbDyPO
         C3meST1ZWi+jLcFjRa9t3BN4EJ4oDAvB2KL1XOUopJEEcKd7f1kf2I4MEHVQaaxaW6N2
         2bQW4q2yiuJmkkGOszJKTV5DMfZi5LvBL5vEs3MoN6oBSVb2AxiEOOV5xanbEKHNJT84
         t9xnveqkjiaqA65gZSevUWkLYvtWmdYLnF0brTr2t/MhsturqMVzpRrUpRwMCq6BKq+F
         ZKlA==
X-Forwarded-Encrypted: i=1; AJvYcCX4unKyAbyaJgjmF2YZw4sZ00cE/oImzHbOvsBOltBpu5aENpcaAGAkWPiReJHBSiVI568=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxql0m8VJenRQ2pZwGYZzG6rR36koGFQ5rsCUYTmHmaAxQhhzqn
	6KZ0NDwkn2SgVB7rjQBSugnRtprl6+Uj88c/mYyPfDh7OC9crc4KG4QeWfUNKOwpjUXjYjHKOQc
	6NF+xZw==
X-Received: from plpg12.prod.google.com ([2002:a17:902:934c:b0:2a9:63f4:124])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8b:b0:2ae:5104:571e
 with SMTP id d9443c01a7336-2ae6a9deed1mr57715595ad.9.1772730758990; Thu, 05
 Mar 2026 09:12:38 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:21 -0800
In-Reply-To: <20260224225017.3303870-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224225017.3303870-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272744743.1549777.12918725553146045215.b4-ty@google.com>
Subject: Re: [PATCH] KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU
 to guest mode
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 24 Feb 2026 22:50:17 +0000, Yosry Ahmed wrote:
> On nested VMRUN, KVM ensures AVIC is inhibited by requesting
> KVM_REQ_APICV_UPDATE, triggering a check of inhibit reasons, finding
> APICV_INHIBIT_REASON_NESTED, and disabling AVIC.
> 
> However, when KVM_SET_NESTED_STATE is performed on a vCPU not in guest
> mode with AVIC enabled, KVM_REQ_APICV_UPDATE is not requested, and AVIC
> is not inhibited.
> 
> [...]

Applied to kvm-x86 nested, thanks!

[1/1] KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
      https://github.com/kvm-x86/linux/commit/24f7d36b824b

--
https://github.com/kvm-x86/linux/tree/next
