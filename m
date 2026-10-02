Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1A361DD0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975337; cv=none; b=tBHNjtunax7aFwLz4y5L++rmNQ5xojrb+QsqEV2q0O3We9gTh+7a8xMA6hUPO4qfDzKxrm9RVCz+rcgXyzTvMwop015hprxPTrzldTCErOVIVYL1MYDpTzerxDdECPmByqnsCi0W5olHzlgVZwqEdaTeegEMqnaAZpTTgI3tujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975337; c=relaxed/simple;
	bh=J1R30jkg0z5mEtu/3/sjhv3hwYdqiiO+ATSB6z3JnPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N1fUyTTQvduVqugOzv5IQRnbFYtIqO9I/RBfpPYSbU8zja9v2x7egY9E556gbwgLkOmvBfIT4exfLUEIIDtOmMGyhSvSPpO4UBizYZysEfNK4k8KqNfJZGoo9kOVdqd3P9PRb742GTxVjRvrwJmlCqMwOpbzDowLgHAs71Ij3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hk1Nrrgu; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk1Nrrgu"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db8c152622so149615ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975336; x=1791580136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRJ1bV1gQpquD4wKcD7z9DV/tvZaeEUb6Cg+brGjowY=;
        b=hk1NrrguEbkDiGJHrwlwhq2EVh5W2srRvZ0dTqZVjy6CZCIYUdXHxrQzCApD43a9Fj
         0tbhGsDz/Axzd7rv0E+HWmWbDz3LQN3QHs4lZeu5IEWn4pWtofV0hGmlv3BXjJFTzoi9
         +cNaeKLotWkO54CEYSgbKnuuogT65FRWI5cEK6JLcwQAujjf29OQvUvEUKTlMDkJfhaG
         wrM3KhdarOhn7BhblzxQ1ln+y4SLjQVb83CzLOqpLm5WQfwQ9GJ/ZtZsmIdfORC7AeEt
         UKtfd2smXJC0lhgTWe8XaBcpaRPeft1foabsaO9o7NDRrisgnJJZnJV0iFDtOC+m+Ydc
         QN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975336; x=1791580136;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRJ1bV1gQpquD4wKcD7z9DV/tvZaeEUb6Cg+brGjowY=;
        b=gwfPS+hgAns9mN/5Q2rcNQHr1yZsrBlaeA3ej9GMQ1b3qMCRw5cdtAPpXE6M9w0xSa
         JsF09s8G+Enca7HxWXcQmxlQ8cJTBkWYoxCL4Zg4eqjHIf7G9acJQhvEVH6NrC/VAbhx
         2M3hP5aVuUBl0XAu6AoOSTwU9lFlKTPLTaLCFsUgtsUZHveLNHdev2B1cGb1l897NWZY
         eyxDSkDE5h2yoQZ1a/0N3BvZpjQZCZTlmwMgSfhUTthz6oUxK9Q1n1pOwXy1w1nmRhiv
         0f+AYPchaJgOJU89QkY/ktSUeKHIcl1lq5C5w1AKE6dpprPhsBGEpZ4mF5TZGenF2JJN
         cp/Q==
X-Gm-Message-State: AFq9FYLVCidYE/eyxFvQ4lMCvFVS4vAQCCAhiVYOCH2T9EeaFxHxjPcu
	U7B9Htx7vThZ9Pr56stuJziC1xm6nQbpqD6/EecEM3i2XgjCiFu4NxgXG0uGx84rDiUAGXav9Zh
	J3ASK2Q==
X-Received: from plzw8.prod.google.com ([2002:a17:902:9048:b0:2e5:3340:8b27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc3:b0:2e3:1d6e:4cc6
 with SMTP id d9443c01a7336-2e4ea1c08bfmr6314055ad.15.1790975335508; Fri, 02
 Oct 2026 14:08:55 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:06 -0700
In-Reply-To: <20260930212114.3500045-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930212114.3500045-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097462201.4066402.1467939489474042717.b4-ty@b4>
Subject: Re: [PATCH v4 0/5] KVM: x86: Honor EFER_LMSLE_MBZ
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 30 Sep 2026 14:21:09 -0700, Sean Christopherson wrote:
> Jim's series to try to clean up the EFER.LMSLE_MBZ mess (and what a mess it is).
> I (still) didn't touch the KVM patches, and barely touched the selftests, i.e.
> Jim's testing from v2 should still hold.
> 
> v4:
>  - Go with a less fancy kvm_is_nested_virtualization_enabled(), because KVM
>    sucks (and not in an ironic Primus Sucks! way). [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
      https://github.com/kvm-x86/linux/commit/192dbad1bc0f
[2/5] KVM: x86: Honor the guest's EFER_LMSLE_MBZ
      https://github.com/kvm-x86/linux/commit/7358d13e1f19
[3/5] KVM: selftests: Rename svm_nested_clear_efer_svme to svm_nested_efer_test
      https://github.com/kvm-x86/linux/commit/cc2b9cc15ab7
[4/5] KVM: selftests: Add module param API to check if nested virtualization is enabled
      https://github.com/kvm-x86/linux/commit/58f4dc83da6e
[5/5] KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature
      https://github.com/kvm-x86/linux/commit/34f749161dab

--
https://github.com/kvm-x86/linux/tree/next
