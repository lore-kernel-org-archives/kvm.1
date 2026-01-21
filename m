Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2D2C326B
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768956727; cv=none; b=XjjmSmX0nwPqcq87COzs8M5B6YBzCYaq8THjmpmd7DeEUsnidgirKcSuiiDDMV5+izXxkr5S5oLsDgRl2DhIW6Vn3Al4OiNcRJ07qzNK9q47bMU1V0RSdMzGaUgtBRu3/YLGdEwAreaMfR4CAcLl5a1gkTmatVs9et5x8OB67N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768956727; c=relaxed/simple;
	bh=EkVcNVO1CNLIf3T/s28sXrF08YLCrCvJ5AM2yKBw9Zg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dg6q5qqVXe7syIcDCcJP+ZUmQiUlkYZLXlfTXkOAihG1s6rrpRunYm1jmTxGZQpXv0GpTmMRNV0TsTrhZWlteSM+pa3tb271vTJkZ+RzIhQJPIn7FM/EANZ0CTUjV5Yo59dH+3ReraR/SOuUf5RUSYI94/rULaHlC3RWKVerelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foEPk1Px; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foEPk1Px"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a089575ab3so54109835ad.0
        for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 16:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768956725; x=1769561525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MdgG0Ul2crpYgoSbV/KPCK+3WNDc/xDp+a+HIFVTx8=;
        b=foEPk1PxlmMmBL/K5FC3+xojidM8Udkpz0XkmLQGlFju2kBm/dmXLwIIspG8CT5rtV
         cl6kzo4URhDm/pke7/1Bdvp9c1tR6CjZ3TnpG3QxmP6x8B1TxH8UqNMcKo3SaPD70mzr
         yxYWxiksno5Z2VaNR2/ifWI9tOIX8Ja/TvEYyZUqVlsgdApSMqh863BIDg1VQy8n0QlS
         wJaZnIPqk3QUBe386fze6KmupD6532cAYLvKH/04sr7PojrbE9Kad31XHAGS9EOFvoZe
         pSPKnRdQAzUfYzeDsclPZaXp93Cg5k/QS8ZTlb2QNhlIjmzgLbOtXqmPEXTY6LYDsQ54
         AeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768956725; x=1769561525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MdgG0Ul2crpYgoSbV/KPCK+3WNDc/xDp+a+HIFVTx8=;
        b=PySdZsyMAAORn18M4wZnwhsXuHrn32P2i+kkROaMAA0FOyDHZpQ2uiffxfG4hnYrYC
         fJR5ZBDbgjKgn9MpeMMNAEIjm2hd/DMDmjpR414o7S29VUozmRk30LwZTkYaqttYizcU
         9SyJd8DffH/O+yKlX7Ots5nGl8OtcmnydT6F01jMJLSD0/b/4pKatDlk3M0BLxnaVck9
         GuklTL8oFSv8Y1niw99i8nFV0vWJM/ICkJcEEau9Gizq5lGmzviRiRYRdo9IQCVr1Al3
         pTX4U5tYNhmClyWRR+AFTvyqkHdYHKS+cWkoM9E/4InzCCR7hsWcw13fq3Vc3XeLBSCc
         TaRw==
X-Forwarded-Encrypted: i=1; AJvYcCUKOfHOY36MAsnhGQnzxLs11V9pzg2QZvxpcz58xmxhAnBuXENOZSIKlkxdGN60UhB+46I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NReKxvq0ZtOHZojEi6whelfMk2fu06/poWM2ElBRQrMtkgut
	12vkhKlGPFXWhEoKgJrhYOIRYk5B6NpcAspYBoK++aupDdljLRkgnyKDi844JwYXUE6w2dlbR9E
	VX0IefQ==
X-Received: from plbmt16.prod.google.com ([2002:a17:903:b10:b0:2a0:c208:8799])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db04:b0:2a0:bb05:df55
 with SMTP id d9443c01a7336-2a76951f3a7mr29795775ad.21.1768956725049; Tue, 20
 Jan 2026 16:52:05 -0800 (PST)
Date: Tue, 20 Jan 2026 16:52:03 -0800
In-Reply-To: <20251121005125.417831-13-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121005125.417831-1-rick.p.edgecombe@intel.com> <20251121005125.417831-13-rick.p.edgecombe@intel.com>
Message-ID: <aXAjMxbeMO0pioNF@google.com>
Subject: Re: [PATCH v4 12/16] x86/virt/tdx: Add helpers to allow for
 pre-allocating pages
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, chao.gao@intel.com, dave.hansen@intel.com, 
	isaku.yamahata@intel.com, kai.huang@intel.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de, 
	vannapurve@google.com, x86@kernel.org, yan.y.zhao@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 20, 2025, Rick Edgecombe wrote:
>  static int tdx_topup_external_fault_cache(struct kvm_vcpu *vcpu, unsigned int cnt)
>  {
> -	struct vcpu_tdx *tdx = to_tdx(vcpu);
> +	struct tdx_prealloc *prealloc = &to_tdx(vcpu)->prealloc;
> +	int min_fault_cache_size;
>  
> -	return kvm_mmu_topup_memory_cache(&tdx->mmu_external_spt_cache, cnt);
> +	/* External page tables */
> +	min_fault_cache_size = cnt;
> +	/* Dynamic PAMT pages (if enabled) */
> +	min_fault_cache_size += tdx_dpamt_entry_pages() * PT64_ROOT_MAX_LEVEL;

The caller passed in number of pages to be added as @cnt, don't hardcode what
could be conflicting information.  If the caller wants to add 50 pages, then this
code damn well needs to prepare for adding 50 pages, not 5.
