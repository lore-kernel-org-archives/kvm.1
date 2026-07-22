Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B03B7B70
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749264; cv=none; b=fudx7GRs5pORDQyTUs3p+TLobI/EjGExhkSOk4xOBlUQRjJcAZGscPT4gyUt3abC0l6qDghkKopTj6Fo4tqsk9iZ+MKtyHVKMWmH5uHg+wH1Wl/rLHnlu+MSVdfvOJB+sD7QX8F40QBF901Rj5xsYWhlLVTlC8/03HdmcRPvbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749264; c=relaxed/simple;
	bh=7kTyB40oFlIluALDs9XAt2lFu1YN1LIdCiPCqvt/UgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeffBbCMxNpAjFXvJdn1zix54wBykOUGSkfB1VolFpH4SMtKLGjAY9PmwUSKD3dGxp3Gg0vw1GzMZQrDVxQoq8dyZpyZsBQvWuWIhqfZyT2fTSOBf0/Kl3tWMUl/dYPjz0RlNA7+af5vtFmmFDFG8Iqs2nOcyqI/WkmBsZTW770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYY0Yg6V; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYY0Yg6V"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cceabd70f5so258090925ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749262; x=1785354062; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWE97FUKUf3847vj+8EZyF89xO8S7BnbxlP1eCUHdrc=;
        b=jYY0Yg6VtEBtL3fQFu4im6xahljN+mCaxlDwqPW0Q686uxTxTH0WZNruAwKCDv3h7/
         dTS8VByObyyFtlgz1WTTqqWR+XK3gcyuBZX7Tbj9clZAJmQRxBXT/xcpIfUU25F/IEiO
         4zotd8xH6g21Ewp7cA+jzZqtEo63nnspG+oantll0M8f8iXKNp/irrzL1H6Sp+2gBvGZ
         O+zAK+KFdTMu/x1cvYB1nGqag1Y0heMiCAqABDbBzksrd2n6wbklsfT9SmZdcbuO9TOx
         bpgnn5bNmvOS8ukZNh6xKUdArzy6b6SjwJGNry3pBnkukUB6jLCm5unHdlfLi7q+yeSe
         tnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749262; x=1785354062;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWE97FUKUf3847vj+8EZyF89xO8S7BnbxlP1eCUHdrc=;
        b=ceFO0eq3yczvTv+LvR9YE7mVWbD3eWNjExFsEGpQki47tJ7wCLf/HX19Wg8aYLPjdy
         QMM3idgqkrcc3Fdt0UesS5GrIkuWw8JTTjzN4huuXTkA9syd5Vox2Q+VaTFqSbp+dNv5
         YCZ2lRaPfG0YGiGUNHRAd/zrk3D0IvdkW8JTQpfmqsjq83BIwR4bjDZNzv3rz1kHaRli
         7RHlEDjw6cF+muQ8bMUmPyaNiOczeYXiQmdMLGFOasM7AH2FLTFbcywpoWtEUtPEnHZf
         4Aj6pcVPKZLe5lUCcWqiquF/JXksNkNLz2rlNeSCZXLKoDjiYlbOH61nocKaW74aOviG
         Mvkg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2MMcrqPZ48zg6VbWg14eKmALrI7E98yc4xajO4DL0bbsFS0q1WzFGLb4YIsDgOImst54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIj7TqQXtpem9BrdezNu141xRSaHB3S3YyreDPkWgj5XbbGGw
	qAchmIDwTh42hBIIBwloukPtLVXXAi8G350vwVEEUswA1+UhGKM4xm4vXKBZS9VHIOk5qoMSHZ4
	NhpoOXg==
X-Received: from pla11.prod.google.com ([2002:a17:902:ffcb:b0:2cc:ed0e:f302])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ec7:b0:2cc:7d4a:3f5a
 with SMTP id d9443c01a7336-2cfa71db768mr2550265ad.20.1784749261649; Wed, 22
 Jul 2026 12:41:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:41:01 -0700
In-Reply-To: <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com> <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Message-ID: <amEczd6t2ipEwjjf@google.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
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
> Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
> adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
> removing guest memory (PAGE.REMOVE).
> 
> To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
> TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
> the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
> only supports creating _new_ mappings in page (pre)fault paths, all of
> which require an active vCPU.
> 
> The PAMT memory holds metadata for TDX protected memory. With Dynamic
> PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
> with a few pages that cover 2MB of host physical memory.
> 
> Releases are balanced via tdx_pamt_put(): every control-page free goes
> through tdx_free_control_page(), and guest data pages are put directly on
> the successful tdh_mem_page_remove() path and in the
> tdx_mem_page_add/aug() error path.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> ---

With the nits fixed,

Acked-by: Sean Christopherson <seanjc@google.com>
