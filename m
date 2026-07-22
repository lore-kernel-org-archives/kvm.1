Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FE414DEE
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749231; cv=none; b=aoqIrxqi0aHr7noOwMt6h+MXprnqlLjp1Azy73ubrY88gtUQQt2k1fW0QCGYFE2AS1EnA9yPK4VUYmoKjzrQIDIz2icQwDHcsfiikESTrHAj9fQLgbscxbKcVX3lFBcf7FDgzGQ4URpr2dDyr7jOtku9AmgjjlGfR0JRE747014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749231; c=relaxed/simple;
	bh=nyBkYgKwOn4jVc5C8Fouc1FeTmY3h02EMe0OQ5ytqsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gls8snYm61rK/fdSQnRURLtpDCBuZVqxmF7U4LgMvxPO4usLYA5+zxjrpEqto/MXukG+YvUjN3I7FDL6jN0fhetWvyoi8vj99i3VFGjq5ghIEuzfPq74K0ymKTQ1auPpfjjfgsAm/Wt9jOZtAt5akI5PbKZsBJ3ewqOKYIgdvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hovqb5P3; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hovqb5P3"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484f26852dso9215942b3a.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749229; x=1785354029; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ptao9s40NBhMm9qoNoLOa2VZyEW6G4SG8hWVVOs/sao=;
        b=hovqb5P3n8VEqY52HNZccABZ9r0eeTb7CNfrnv5TVVoQkGIanFwTwexRUwgjHgPApg
         DGB2wDB6xXbra5LEz4UL0Y7qJRiv5vR+/i9JArTfesPNvf+gJjKpnNamlGuK539oakHz
         M3uv5FqGreIid2H4tlUK4bSkVxgAE8pVoVa2NyqqsO29PF8u94hUgHcfn8R9Cw7/2/PF
         hHxP01e74ara8BggeSQOMMD/H8mltABdBNXzJI89LVSwjYLtpoCkJAUxcGIL88XbTPHc
         bjEXrTSDRj2GYVp3x0rglPMtmzr0LvFRTH26JWu/If/DLPrTWMa426GRXsnETvEUt54g
         JnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749229; x=1785354029;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ptao9s40NBhMm9qoNoLOa2VZyEW6G4SG8hWVVOs/sao=;
        b=k2WXYbMYArEuFwd59k5RcJdjuL6olyhGDjkCuUCQ4Rt3Poz0FUvEmehmAcWZMDUXWs
         VDWHBXsCx4cAc5EpNyYS12UfW5PevUMoexE1cV31aBAtb/7q0Bx8vq9WoMB/KKzcstIl
         lkpzCMPiFEeHG/fJ+w3TTVK2dd+b21XiLrEEZ3msxcxHUxyqwN3omKPsLltrG4mxHqkQ
         atIXq407BeDbE9DgqZLFmYm1LnUMxmnnd7d74kz/6HxS41vcjh2QnkjsHjIna0ef8YoC
         VSjTc0OcxxtahV48WZ0f89541H7sytnPVA9pZiWMQjF30rQGzZpxKx2LI/R/uuxiT6Kg
         pPnA==
X-Forwarded-Encrypted: i=1; AHgh+RoE++P1GX91ihAoHmUwt3KBMgoVadXVhOvJNzv17KXWyvhmJ6uu7JZ1k8UxvqOJG0p+k4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodOCCM/NNgfDBaNbMohLhEOaQlba+ZM9twzXfEDYtpmzqneRo
	XqbeuFe5Ep88dXMLSRrH/3x5rcLj8KIDoi5aOhbo04QvIUV2xJ4fBzQ7eVKtcT1hhJDMnl4YDjV
	+BNqxVA==
X-Received: from pfbhj6.prod.google.com ([2002:a05:6a00:8706:b0:847:840c:ba17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:299a:b0:845:c6fc:2821
 with SMTP id d2e1a72fcca58-84e2b8a6521mr317062b3a.22.1784749228959; Wed, 22
 Jul 2026 12:40:28 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:40:28 -0700
In-Reply-To: <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com> <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
Message-ID: <amEcrPzZELfQ4jU9@google.com>
Subject: Re: [PATCH v7 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Use control page helpers for allocating and freeing TD control structures,
> such that these operations can work for Dynamic PAMT.
> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So the kernel must ensure PAMT backing is installed
> for any 4KB page being gifted to the TDX module, and must tear down the
> backing when all associated gifted pages are reclaimed.
> 
> TD scoped control pages (TDR, TDCS) and vCPU scoped control pages (TDVPR,
> TDCX) are all handed to the TDX module at 4KB page size and are therefore
> subject to this requirement. Replace the raw alloc_page()/__free_page()
> calls for these pages with tdx_alloc/free_control_page().
> 
> Switching between special Dynamic PAMT operations or normal page
> alloc/free operations is handled internally in
> tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
> calls. Just call them unconditionally. Similarly, drop the NULL checks
> before freeing, as tdx_free_control_page() handles NULL internally.
> 
> No functional change intended when Dynamic PAMT is not in use.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [sean: handle alloc+free+reclaim in one patch]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
