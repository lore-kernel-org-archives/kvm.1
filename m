Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFE3B6BFE
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229285; cv=none; b=o/QnaEqCpyvJLne8Gu99+zLsrgErdAzHPagyn27+DuqYNkuUp9zEO/40g7sz03gG7C9v1vonSTe9USMLxhYAjh4x0k4bmZam7jT9mjb3mvas5CuNQODa4UyDJ1QZPNIw0VkjZxHnpMDUN/PjEjnqrqw7rm8DaecxdL0m8t+lb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229285; c=relaxed/simple;
	bh=p+ASDUdYz84jNx3iUfg4BSpMmcpuNqwANUP22/J2WOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWczXKaLoRmRR+V8dJWu9u7mBWdqd0aAGA9VP+I6U/wDQoRmxfW8suroNiMxC1GfjT4LUKqtZPgJX502DadVvuxMGrB/2eIEPuIoT0XtFZgiUBWmwUHAdAFvq0UOBhT4D+HgB3ysV4whDenAdPSEbG0j1cM6ApKoDEIxNdOXpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFCkAc7B; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFCkAc7B"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf084fe58so1031992b3a.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229284; x=1775834084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx3cX0Um4XbIxAKRYiUqFyiIniVc/uoy8TRTh+aipB0=;
        b=EFCkAc7B4e4++rbuv3e5zAL+8FsHE72/ReW7M48IJQnSrhMSsGVZC15n0AQYZoKr5S
         FussCS/aOje/s8GjzZ9bvIITQJ8wUuVxoP7biOhcbAGJI7oA0E6tg3anC8UXQZUfiH3i
         8ZB0X4hJ/As6YvQdrIuhazEkv4erb4M4b+FVm5EwLZOrrhRk4o3o9YA5Iwq2lLFuq3Bq
         mAUXZ87MlXFU3hIVcc+2yzk9QtgNnqM0LPfvF5X5Kd517wWOSmHyXNfvTT+CTV+koChF
         cpJsLpM1YJ/NtMr7pQCd2kKbtRYeDqj5OAGlAfloRAIhvXaTrfyKgVRQohQDYeH6z/k0
         uhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229284; x=1775834084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx3cX0Um4XbIxAKRYiUqFyiIniVc/uoy8TRTh+aipB0=;
        b=kEksisMZkcnSkjUJCRf1IdhRl9T2OpVumr+ua0k+VKwmg2n2f8gOOp5yOanbdKydKD
         x39dZ5nRyEzTDM5a+EmCEG4trfqXE9Nk7n6cZewk/u7kpx0DTSwEsUyfZfOx1bIbqBpQ
         sSAMRX8I2Ody0LRAaTX93S3l7rQob0BijQBEi6tfYOj4IJ7wKMDmRfT2F1mz0/8z63xz
         w6VGj1jMXWFifG7OT+WC53yxG+fHVIWR/LDsrMMn7IkAcxpWAyNPzNb4F4PPTgjhTzNs
         Gg8cFC3l9+orQ0cEiHsSe1O0rnIgcgoda+LoTcampFHH0G4iTVrSSs4omUT9HUYzU2YT
         UG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCULp+4ZOGNKuOC3Uf01WKzykvZ7vanT2osclesfvqY9FGTMkqREmc02I77LkBYint2ddH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7db28raZtGlmr2w5jA0f7r7QscvzW5Lp+uRn8ivEq4kD6Sw+
	3wcAiTX3GLmGxsmZUn3+Mioz6k9CMLOlz4XGNodMxLloOeDnzrAo0CxvyjUDdHmNdqkaDY/opcD
	Rp/MVPw==
X-Received: from pfiv17.prod.google.com ([2002:aa7:99d1:0:b0:82c:67aa:804])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10c6:b0:81f:4a0c:c584
 with SMTP id d2e1a72fcca58-82d0da44954mr3417884b3a.1.1775229284032; Fri, 03
 Apr 2026 08:14:44 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:54 -0700
In-Reply-To: <20260123090304.32286-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123090304.32286-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522907944.296735.10194559706279197463.b4-ty@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/mmu: Don't check old SPTE permissions when
 trying to unsync
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 23 Jan 2026 17:03:02 +0800, Lai Jiangshan wrote:
> Commit ecc5589f19a5 ("KVM: MMU: optimize set_spte for page sync") added
> a writable permission check on the old SPTE to avoid unnecessary calls
> to mmu_try_to_unsync_pages() when syncing SPTEs.
> 
> Later, commit e6722d9211b2 ("KVM: x86/mmu: Reduce the update to the spte
> in FNAME(sync_spte)") indirectly achieves it by avoiding some SPTE
> updates altogether, which makes the writable permission check in
> make_spte() much less useful.
> 
> [...]

Applied patch 2 to kvm-x86 mmu, with my proposed tweaks.

[1/2] KVM: x86/mmu: Don't check old SPTE permissions when trying to unsync
      SKIP, for now.
[2/2] KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large pages are allowed
      https://github.com/kvm-x86/linux/commit/b3ae3ceb5569

--
https://github.com/kvm-x86/linux/tree/next
