Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9146D57D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119935; cv=none; b=Rm/PSAeflgXjrVyYYtL0DBILAqkDQ3E6i36vCzI94Gwm+zzqv70tVZyQeQHftRhu6rUHWE7o89pVJJkgJCdi0u8sRJk78JYWtykfvTDqWz3nuZnjS9sBhxBbcpa8jzMERX38tc7K0dba2MLuL2usySFYpeb0xvl00BD3PtjUfw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119935; c=relaxed/simple;
	bh=0kwxv1/eDZYrSwhKI2vAj5MLljSsCZ7KMdZ9AU6PmZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sjF1hAQ3oocBoHrAynVY0VrHWfGvfAJ8SlKS6++7WyJPZ43FPqZ61NP+OJMP84be4B7wqczyuUIclcZv+NxobpLuwG1OqoSrFr/HdaTUZkgJlRC6eUAM9Yigjewh5UlSFy24eHuYIouSGGWoCV/tHLeTIYWVT0zZ6dikcSn6vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJidNzdA; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJidNzdA"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7049fa552so2482601a12.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786119933; x=1786724733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAxry1jRMnFZ0bYDegpiXJ+P2Rfk5/3SHM4b8b0+eqc=;
        b=KJidNzdAKzchz3HsomrkzRNj/E74PsGeEqF+q4/m6FXed61q7FjDG9baI2rjQDFBn8
         KqgxpaeTD7Ka9NuILu5l1xs3R3QBLz9NHfmL5dWvv8aUI/ReR/qUflbHTHBAW8GGglSq
         tOWPQWANEKCS2xF4Yu7phfzAYYtNCal2jcxHbkGJuLbMt6t1/EO1awUb8ODpLjYz49Hy
         dSAumPoKl5vC747TRWs2V23ESEP+KBNBbj7xNDakxOAw2anPau5TkihJHEClVtMF6HyD
         EC7RLVxZjO2rdOqGH65DtTB0tCH56hzTqd0jIk3NJMA5rMNNxhc1llJgxAX3e6gflhEX
         /H1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119933; x=1786724733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAxry1jRMnFZ0bYDegpiXJ+P2Rfk5/3SHM4b8b0+eqc=;
        b=EhOvema528HrmAb1o38HkgKzqOuFFReI9b8VE+Q6kzmGaBMsSiKGiPHghlJWitckaA
         ABAglWBhUajueKKSs+kNt6uHk88NmfbCUIa1Bbjw06SKWABOxTHOX2nN/XfvB0S3tyHk
         5LCsUhtwZ92AMkP9VYeCunQUIOKKQztZcyHqm/Z9H9RogS1SOW69KVz8aJu+GbsUSH3Z
         DQCPJgFmjh6PSiXhuZy+4E9bjTB4YvEOmdSWYVy1Wrx3sUc19/JPbvOtTtouFR/iZqhP
         FqPJoKpxs+Sk3Mmdm8RbHdCX8Ma3Shr4qQcyAsYfdQYndpqt4L0iafEIVyzay5Y9xMvn
         oCtg==
X-Forwarded-Encrypted: i=1; AHgh+RqI6tTs2YSV/+nMqLBJDFxFbKXdPIEg+6B9BHdL44lU///vtNRALiwghtfq4URoWK5ZfRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zK5WHc/UHF1+tbsSg462yqDJNIdpgsd831KB/SeEuWBJkRnk
	+52P7xWEiKaJkSkES2rzP7qyYJUrBRw8ybpD/TY8Tto9DkTS6XSMppw51iPDiygSv90CuKbb4cx
	dWREtVA==
X-Received: from pjhk3.prod.google.com ([2002:a17:90a:4c83:b0:381:5fcd:c992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3847:b0:383:f52b:d616
 with SMTP id 98e67ed59e1d1-3909d89bd69mr8108741a91.10.1786119932919; Fri, 07
 Aug 2026 09:25:32 -0700 (PDT)
Date: Fri,  7 Aug 2026 09:25:21 -0700
In-Reply-To: <20260731173842.2649391-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <178611954141.350753.14844441795145580419.b4-ty@google.com>
Subject: Re: [PATCH v2 0/5] MAINTAINERS: KVM tweaks and additions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 31 Jul 2026 10:38:37 -0700, Sean Christopherson wrote:
> A few tangentially related KVM MAINTAINERS updates, details in each patch
> (though the shortlog is probably enough info in most cases).
> 
> v2: Collect David's acks, drop RFC tag.
> 
> v1 (RFC): https://lore.kernel.org/all/20260428171541.1342335-1-seanjc@google.com
> 
> [...]

Applied to kvm-x86 maintainers.

[1/5] MAINTAINERS: Add kvm-x86 tree to KVM x86 entries
      https://github.com/kvm-x86/linux/commit/4c6547282f08
[2/5] KVM: guest_memfd: Move gmem function declarations to dedicated guest_memfd.h
      https://github.com/kvm-x86/linux/commit/f8479adb280a
[3/5] MAINTAINERS: Add an entry for KVM's guest_memfd
      https://github.com/kvm-x86/linux/commit/fad1da20e62a
[4/5] MAINTAINERS: Add David H. as a KVM guest_memfd reviewer
      https://github.com/kvm-x86/linux/commit/fc176fd65582
[5/5] MAINTAINERS: Add myself (Sean) as a reviewer in the main KVM entry
      https://github.com/kvm-x86/linux/commit/82bd660be36f

--
https://github.com/kvm-x86/linux/tree/next
