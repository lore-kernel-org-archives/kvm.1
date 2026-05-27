Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1FF4534A2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905673; cv=none; b=CpkWIOFdcbj/1JUytrac3nibw0cvyPuuBO/ueGR7GXR1herq2h84VYGHWCdFspwlaFDblLhQ41KVIfIQZEhr4ShX23d85AYY3BKHdf8v556b9KBxNIKVdF0jSKazn+sINe3ZHrwKWr5W730ddWz9U7JuSHZbdwOXtWSRRcS9epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905673; c=relaxed/simple;
	bh=O9pOk5v+q8VTzg7ynkOmwYh/WXaD4qHadkilsV42SIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TfC/QpzWMTzD4tGS4X4VOHD2JZ2NeqaGtqcQ3GQV82RSt1aCCDP03FXsOctmmaqxX1iyNM6aEExSSwQ3soJ1nEufaHeqFaL8r1Uh6RtlA+hlEEr8Pv628quAEyLV7EjZOYYH6rkB4kukOqkWmJQTAICSnrwRDn+qWcExN5TAk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mc54KIjd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc54KIjd"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso1694535ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905671; x=1780510471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQnId2rHDW8In1E8uy3X9GmOauCk23K9nsxnBe9nCG8=;
        b=Mc54KIjdXwwSJ/75s2zPL3WwJ9YewKkBKbkD1z93OHK75c9hlk50N7jm+DhMCX+tP+
         SXvp1o7Ip5lSuvE5wquAfPvJk4WE1DefFZ9mjPjlb/Q8xpRwFT7DTOEmVgywa12wapbm
         MYG9CIFEq2VoMay5olmLF/vEasBdiHCkUGA2W9aTQroepejKDkl2pm/80f5XF9V8Uoki
         NkgCTSjC1gdIRngg0C94bJ3bg/T+BQIK2pJQAFewx6It72mj3PwvOeqEUEVMvV4C/ofw
         q8cR3zNP9HGJA+hVsWHW8m4E0rX7xxlwqRbCwYjOy9T9aYFJJYXTsRGDqUwNhZFPnnI0
         W53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905671; x=1780510471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQnId2rHDW8In1E8uy3X9GmOauCk23K9nsxnBe9nCG8=;
        b=kKtuofU+CnfMIj91OXft/3M3L79W0SwPx6PB8YY2JZr1X+xBlF+gpShSYbo0DE6TKV
         fq0LaiaXpr5CKmjgiTfcPD1KfCwzKhvfupnT/FJrLbr52kwRbnBTvcuQS6aJBF6a7ExR
         y+JR8uawEfhh0MNbSIWomBFIkNPv2paT5sLqAXV6Ems+7D21qp2q2Ef9iCnDbDd+vRWk
         nC6y91gh00JTQIKqmO+Ph8C5oFGySS0IMZwJvLtTPjmpdDxlH1EcjChQsgQuTxfyRbRi
         N80e8E60v//IhI9cPI+nYmnbcOf3kwnVEChbcEt6pQwWHzJFe8xwwf3ifE4qIc+w53PT
         FtHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pxLtGaOdEmTTTMvVAyiuhDbRJHsM98RLPaI4BvIwtP/0NnEbNles7OiNcwyzl72E9+VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikiTsRdIXz+xp9jxessFPiaSztgB1hjq29WOpvcMCraffLAWE
	Xav9oNC8XPNsK3aevK06tIT1hVerLdrv3GNSzcHSspt4ICGMEPEKcqSgrSIyRwA+qQugLW9p05I
	piOt6TQ==
X-Received: from plop17.prod.google.com ([2002:a17:902:8a91:b0:2bc:9bda:56d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64e:b0:2b2:50bd:83b3
 with SMTP id d9443c01a7336-2beb035c826mr257510165ad.10.1779905670713; Wed, 27
 May 2026 11:14:30 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:12 -0700
In-Reply-To: <20260430014852.24183-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990514368.4120011.1575758464694752462.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] struct page to PFN conversion for TDX guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, dave.hansen@linux.intel.com, pbonzini@redhat.com, 
	Yan Zhao <yan.y.zhao@intel.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com, 
	sagis@google.com, binbin.wu@linux.intel.com, xiaoyao.li@intel.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="utf-8"

On Thu, 30 Apr 2026 09:48:52 +0800, Yan Zhao wrote:
> This is v2 of the struct page to PFN conversion series, which converts TDX
> guest private memory mapping/unmapping APIs from taking struct page to
> taking PFN as input.
> 
> v2 is based on v7.1.0-rc1 + Sean's 4 cleanup patches (see details in
> section "Base" below). The purpose is to get Dave's Ack, so Sean can take
> it from the KVM x86 tree. The full stack of v2 is available at [14].
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/4] x86/tdx: Use PFN directly for mapping guest private memory
      https://github.com/kvm-x86/linux/commit/6ad0badd765c
[2/4] x86/tdx: Use PFN directly for unmapping guest private memory
      https://github.com/kvm-x86/linux/commit/4c7a1247646c
[3/4] x86/tdx: Drop exported function tdx_quirk_reset_page()
      https://github.com/kvm-x86/linux/commit/4a72a6dc447d
[4/4] x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external users
      https://github.com/kvm-x86/linux/commit/3f330fbb918f

--
https://github.com/kvm-x86/linux/tree/next
