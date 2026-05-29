Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69F30AD10
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094897; cv=none; b=JKrCLyv8J2wSt88yIVrza/KGYuC3Xk9ujQpdYpQvyHy7BCS7SbaXUEYuILMau0sFVmCLNIAvsfAIVGmjqvpSd7+z+E3KBOnFvN3fn6IJ0PD/jd9ch56FB/otiRf9RnHtbKCAi+beof6QnXaukjBpbpkALg9iRU041KHgH0YaXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094897; c=relaxed/simple;
	bh=l0uZ7PeP/Tm8L8cl0KMR+r2LBzQYlzDzvMdnuHMvMi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kQX5N8Oz/D+9/iAyK8dz/St8GMMI3QZJnm9FQwI5Ff7RTJ723qEwHkQFctVmYd6oncuSoqnOZu9IuS1x/c9E96eKczjD7CZh5yIEo0VDzbYqxZCwuBw64WMg6qfW+KZopM/A9B+24zQLfoa3ha5+++8KwliwhugrU2THVm6PaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2BC5vXV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2BC5vXV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso159772365ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780094895; x=1780699695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBPwQbNkDcHNIOKv+ajv0sD13CI8gNAufbd+ZzaXhlM=;
        b=E2BC5vXVvZ1Dtnd8I9nSXlL1lJz7IGBmZ7MPF5YbpqBwbrN+K8V9zRVIT9hQ1BObiM
         0qSuqK2K/HQnV4GiOCMePQ/aXeNh0skWPxLKvIVOPSuvrgvr1E1Ir3Q1U9iKYI3TIBSY
         X/QdUrzwuy3nk+l26G+KNoVMk4iDvfAGajq7EZvoLgXmw2KgvbhfVwCvI3xkkFl12Z/2
         8zx6+dJFYHEN9ShAAlWRc1aUI0zTxMoCyJdChYYmpJ/jPmkSwHmT7SaURv3nyZBFsWgv
         QZTKgHQPiE1hVpwLCALzePhLX5+X9u5+Uv+ZQqfIDWfX6b6COxFNV2mwH0E7saTHa7tl
         TwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094895; x=1780699695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBPwQbNkDcHNIOKv+ajv0sD13CI8gNAufbd+ZzaXhlM=;
        b=dfecBckvGYcBFN08barQvYHdvJhymGLM24fBm1EnZAyBqhV6DhiNKFduDOnM6QLE0g
         aqFbvQkQm4arOpPAAjiK7Xv1VN2ak70IiSPzjrYs+6O2XxLKhPmwHpvPaCfVpJJ/ReaE
         k4cxEXIE8LnJ8TFHARGggultmUytVxSBgBIpgG8vxnH68x4lMrYJPQzuOiRzmFfivwgm
         tq4nQIDqfnLhqzp4QNMoSvm/YD2Emn11KlQo44lMMsNU+MIH5Cfbi6Tkb8YC4OB0bKYw
         fCUiGUNLd+H7lgkk7x5Hy+fWZYk7z5bVLgt3jhkblVasOLHg4qhJQ+9XA9KVMqS065gc
         hDLA==
X-Forwarded-Encrypted: i=1; AFNElJ8e31mIlemmMPC3gumxlpaJKiyEP9iBp+Y9yHt843JXOdP71VbDI7PL+MJt8QK/w/+Tn7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cRh/g1EQgCpL/vYUxfxbjk0xD4mgWMjkv96Hjl5j+VRlc4ki
	3NH4NbaJbAMUNkBpKf/UVTFUir0nSxfwogBSHiu6f10OQI2zb/JUUWOumDVFIoUYOmG/uGbzL83
	vcDJN4g==
X-Received: from plpp10.prod.google.com ([2002:a17:902:c70a:b0:2bd:56ce:d8ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c8:b0:2bf:1e5d:2b17
 with SMTP id d9443c01a7336-2bf3683bec2mr19652565ad.21.1780094895013; Fri, 29
 May 2026 15:48:15 -0700 (PDT)
Date: Fri, 29 May 2026 15:47:50 -0700
In-Reply-To: <20260509075201.4077-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <178009463332.880339.13655251210288710814.b4-ty@google.com>
Subject: Re: [PATCH v2 00/15] TDX MMU refactors
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kas@kernel.org, Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	kai.huang@intel.com, binbin.wu@linux.intel.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="utf-8"

On Sat, 09 May 2026 15:52:01 +0800, Yan Zhao wrote:
> This is v2 of the TDX MMU refactor series, based on Rick's v1 [1], which
> was extracted from the discussion on Sean's DPAMT/Huge page combined series
> [0].
> 
> v2 is rebased onto v7.1.0-rc2 and the v2 struct page to PFN conversion
> series. v1's first 4 cleanup patches are dropped from v2 and kept in the
> base (see "Base" section for details). The full stack is available at [6].
> 
> [...]

Applied to kvm-x86 mmu, thanks!  I gave a Rick and Yan a few Co-developed-by
attributions where they went waaaaay beyond just tweaking some of my patches
(or diffs).

Please take a look at the result.  Based on the lack of bot complaints, I think
I got the important stuff right?

[01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
        https://github.com/kvm-x86/linux/commit/12d595795de7
[02/15] KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
        https://github.com/kvm-x86/linux/commit/176dcd88f4b4
[03/15] KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
        https://github.com/kvm-x86/linux/commit/78d23e299bba
[04/15] KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_spte()
        https://github.com/kvm-x86/linux/commit/291bcb3a7583
[05/15] KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code
        https://github.com/kvm-x86/linux/commit/6b1280a738f9
[06/15] KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX code
        https://github.com/kvm-x86/linux/commit/40342185fd2b
[07/15] KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN_ON()
        https://github.com/kvm-x86/linux/commit/c1d3af136fbf
[08/15] KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's handle_changed_spte()
        https://github.com/kvm-x86/linux/commit/c1ec7f368d85
[09/15] KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to external PTEs
        https://github.com/kvm-x86/linux/commit/28c77a037804
[10/15] KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external PTEs
        https://github.com/kvm-x86/linux/commit/41367d77ee4e
[11/15] KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
        https://github.com/kvm-x86/linux/commit/c74893aa56f4
[12/15] KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
        https://github.com/kvm-x86/linux/commit/6eae9ce9461c
[13/15] KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf SPTEs
        https://github.com/kvm-x86/linux/commit/0cef26b537ff
[14/15] KVM: x86: Move error handling inside free_external_spt()
        https://github.com/kvm-x86/linux/commit/b35bda696e44
[15/15] KVM: TDX: Move external page table freeing to TDX code
        https://github.com/kvm-x86/linux/commit/110d4d263450

--
https://github.com/kvm-x86/linux/tree/next
