Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482473290D5
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280751; cv=none; b=PjttVGD7a1qssH3+qW9eLYiTCKow5A7lT7z45fxTao9mhLx7pbJxOf7eJXqwEoimvvvW2OsutaNIqr7masDZP0yjsZxdW2Q3iJuSs4LPnvyRmt/k7e9bCTYaVVUYrblYqwtknlpWdmfW1VvrTfup8qY1TlWRHQxfB9cDQ09TuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280751; c=relaxed/simple;
	bh=29xHuZJjBI/lc0zxSTYBaAz7TWyc72BQ/ZwliYn6Y9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nx6NdfUBZRUpQ653vKV9/jK5y6QtFKQYjazCedjFNvQXw7LLggYcRS2+qJn76V/WKq+KsJWxO4pBLI9KB5/cK6K1eQMdtnBwnTSPF5AN5tQl4k5fSrGrH7+LkpRolub+a8H/D8JaAMiUyHbMmhDjdw0i8wf0Ri+R5yQ0z8tjl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQjxn7n4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQjxn7n4"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9f5ac4e36so24088515ad.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778280749; x=1778885549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X37VjUtI67Morw79An+JARyuYLljbGKbsxOGZMV+5ns=;
        b=mQjxn7n4lndoQhmr+VoiB3PaBBosMfkafy8lgGFs0kXfdOgbz5XNXTlie6glRPk1E5
         0QYktQarkc59cwXFCu6tvedtS7r+tE8N/Zot7k2oDEZ+4RxE0I+iMCa1Cw7nBIuk4+eL
         WCo3wFGszCqKA2w1GIzI42avXUc31N1K02kDFOX++UM2uhlqEjVv78ZMEnuRpjZFbtii
         D2kvtvpEiO+2TBPp3Ak/z4yLzcKySPi1Y1oyB3thzQ2Q1qe6ddqej4BpCJYh/MqxFLnS
         ZdGBeHAu2CLO/Ly8QH6iECyWNCcgWu2QvluswRXdlnEHkDnH+seln+BhcmSqaP6Yztwh
         UFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280749; x=1778885549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X37VjUtI67Morw79An+JARyuYLljbGKbsxOGZMV+5ns=;
        b=nObAOZ3h9oUWadNs0psQa+ER9srX1jF2QFGnkVaK/5w7587WZBXodkoMvxziIUrkvQ
         zWE0If3qAEJ1FSBHJ94jLl5JV38ffSww5yM4oeyHFD/lu0lhf1bImdFaDZJY42savUfa
         IhKY84z/SwYzxeRy21qcbfBEOvR4xQQRwr3xftQvLjDaGHfOjRJG7TK8HUVGf9MddZ87
         tYeT1b4h0ajlup+w+NqEB/6EzAwhtwvWEk4FFZD0+ihjPm6K9oWnVZDdEfsCKxKmLkTr
         GHJz/cqCTlHl+6xaU/yGos/gB43k1loNdpS+2YNoN78C9CFPVxu3EE6f33uZkk2yXz43
         3ROQ==
X-Gm-Message-State: AOJu0YzqtMtPp3ZDD/WuaI90qFOFTWYxDSXBXE+Mw9FFeUbhLW3Rvx27
	Aqf86/KCDBWA9XXCb1mk3RD/iWDCuZfFCmu/XbTKCSBM7Tdu8Hzp0FznFyJpgxwMe6VdoHIN5rd
	Kujr4nw==
X-Received: from pghq5.prod.google.com ([2002:a63:e205:0:b0:c79:599a:d8e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e291:b0:3a2:d629:16a2
 with SMTP id adf61e73a8af0-3aab12eaf56mr5441364637.10.1778280749243; Fri, 08
 May 2026 15:52:29 -0700 (PDT)
Date: Fri, 8 May 2026 15:52:28 -0700
In-Reply-To: <20260407063245.2755579-2-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-2-nikunj@amd.com>
Message-ID: <af5pLI6MylNvpZVy@google.com>
Subject: Re: [PATCH v6 1/7] KVM: x86: Carve out PML flush routine
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	bp@alien8.de, joao.m.martins@oracle.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Nikunj A Dadhania wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fd1c4a36b593..628b6f51d2be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6720,6 +6720,37 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
>  		kvm_vcpu_kick(vcpu);
>  }
>  
> +void kvm_flush_pml_buffer(struct kvm_vcpu *vcpu, struct page *pml_page, u16 pml_idx)

Swap the order of patches 1 and 2, then you don't need to add @pml_page, only to
remove it one patch later.
