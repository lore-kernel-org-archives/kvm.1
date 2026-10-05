Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256E429037
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239482; cv=none; b=clLpxmeFSF2v5jwssgGRBVP+ke7KfZfSUL7dcwl2RdVnIgm57GP/qRpxrG0/sliDVn1keN5KF73UNfTCYn8DIMG1PXJj/iYTe4WZAlqKmXwy0ykKwyyRoqusOVHfIfq15yE/4x7ec3q9HYKfoDs0hiYZsdv9nhuhPZ8pm8dejpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239482; c=relaxed/simple;
	bh=fJsx0uA6khk1HRvoK9tFCr7F6Fo9cbBNyW26zVd3mog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugj9o2m/y4f/KWhw0K8iyVBTdMRyNX/efjlthpRbc6FDmwKeqYD57UocvvmEA918iRRXVSjMwbdVbxOySeu/ehv3loNxeoiWvwWWxacWThPNm6NiNgMH0I/YtX3wPsIEw86pa7nH0uZr8BRgTkqsR7eKTebrGnl2tlHSjer7mY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8M64Ha4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8M64Ha4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e2e4ef20beso21745ad.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791239479; x=1791844279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiSimi82Dk/ZGnkJeyaCV/mnPB9bT0XsGcAfkBTe7Ms=;
        b=b8M64Ha4Dp1XtA21Wqx1f7Ns/kpgVGuKsTw1r9C2cVmrOu4Hyoeb7HwmnM7GoDtNph
         xDRjEReoF5JwcbYOLBsKrCmo/Mg3nNbs3yQkPEhsfaq86P6ehpnOPraxHYLTZbAbvJyK
         ax3r5gnjT03tYkW9ukzfBz2L5jbJlcBiiYqyKvL9TfDUtgXSslo0OsKzL+i4TSuzdqWh
         t3coKTGfxvq0ddH4AAC4nIr9cfk106kQhDmxSYTifFl+7Tnu5AYQaLqpjwHBIQz+DPXT
         rITSpJnijViPRX++UBQPunIyqkGcDwzcPaZZCUE/Pw9xA84xOT0yTOj4kanND1h6jtyJ
         RgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791239479; x=1791844279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oiSimi82Dk/ZGnkJeyaCV/mnPB9bT0XsGcAfkBTe7Ms=;
        b=ip05PfYFWwRs5i/Xm7eAAdEHdpjUHFNtr58W1Le30GaisQsBCywGe6x70oL2UHnCVn
         tHNHeIW9sR83kUcYTcog/MacmFS0co/VfnW1g2RHy90Uw55uaZyFSIeM4/A1WpL7ASf1
         RqI28MqezNZsiELXi1p126m0kalkbqw2cWtwBXOc3jEPPs/ucEWrKdEvA63e8dRbqMr+
         Or7NQgkuua5F0oQc5mJ682dUva6R8A3gCAVLzKHE4W/b9TYHPIKKXLFTgi3wkMU+eXjl
         Qks3xTHpCoXQy+lPjOLKT2HFfM8kEkZ1HtpuKa5YPPOrqZojtlil7t0iLkxYqUmQesuj
         ILXA==
X-Gm-Message-State: AFq9FYKRxXMkbU3SabiBQro4Jy/MUEnR5H5eUlz62yoO0m2SObmH6453
	k7kjCeWeXOeRPn70jiTw97sgb+GAukBmLYgTOwaR1tqwyhGSPEf/A83fTcFFoE2EE609ysR0EPv
	YgC37Zg==
X-Gm-Gg: AYBFou3qirf3f/sCiyd07OmLmIqgz6ntMLKUOilKDKYjoH2QbqoU7jF2wypRMjrrH2w
	yqYVhG1jUYeOYN1oqZqVq+exm8eCBBDoshAWAcZbOLa92q7fTIHyjeEKWlCEoxB+oXDFM0EWNQM
	iKonPnn0L7NX3RUgilzXtg0X55hsKiHUhmSeyWTfCuvHXXb4xw6cfWSMQRwKjBJYNKH2kkO96xl
	sA9ESMAW7OCQtZusmNMijiHLstZgYSy9FgGMzF9KWLL4V9hfzRZ2qp7MJopSdIzm+WCdIBCwv5y
	op9/LYxHvo+8WjxmjOgwhiXwewITFcP1J3rPWlcrNNkD+5afWTpxRgkYRhMSJ6sV7Fbl7EqkL9t
	XoTGHx1N8tuKDvSOonb47gh0oLd7gWx3VBmZM5vynXtdsvqQTBaXvm0IIEt5gDcL24LhiAKShB5
	jsLd/mYNMexAt5ev4L/GcAxALwxfwHXk8N76zUnkSzsIyXWvHWxJZMtfTyGmt+qlZl4mkt9Zz35
	PZ9FcORL/Ul3JY7rwN+CTl1KH4p6eWyOLwedWH7h74=
X-Received: by 2002:a17:903:3c4c:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2e5c9fc1f6emr2100015ad.2.1791239478925;
        Mon, 05 Oct 2026 15:31:18 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d9f86aesm1455404a12.18.2026.10.05.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:31:17 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:31:06 +0000
From: Lisa Wang <wyihan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v15 07/23] KVM: selftests: Add TDX boot code
Message-ID: <asQlKs3pxOjhLUp1@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-7-7c62a5d8a992@google.com>
 <20261002091330.4B5D31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002091330.4B5D31F00899@smtp.kernel.org>

On Fri, Oct 02, 2026 at 09:13:29AM +0000, sashiko-bot@kernel.org wrote:
> [ ... ]
> 
> > +	/*
> > +	 * Find the address of struct td_per_vcpu_parameters for this
> > +	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
> > +	 * struct address into eax for indirect addressing.
> > +	 */
> > +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> > +	mul %esi
> 
> [Severity: Medium]
> Is it correct to read the vCPU index from %esi in td_boot here?
> 
> According to the TDX architecture specification (via TDH.VP.INIT), the vCPU
> index is initialized in the %ecx register, while %esi is initialized to 0.
> 
> If %esi is used, will all vCPUs evaluate to index 0, causing them to
> incorrectly share the same stack and guest code pointer? This seems like it
> could corrupt the SMP stack and fail multi-vCPU tests.

According to the TDX spec, %esi is the vCPU index.

> [ ... ]
> 
> > +	/*
> > +	 * Set up control registers (x86 does not support moving memory
> > +	 * directly to a control register).
> > +	 */
> > +	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
> > +	movl %edi, %cr4
> > +	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
> > +	movl %edi, %cr3
> > +	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
> > +	movl %edi, %cr0
> > +
> > +	/* Switching to 64bit mode after ljmp and then jump to guest code */
> > +	ljmp $(KERNEL_CS),$1f
> 
> [Severity: Medium]
> Does td_boot miss a wrmsr to set EFER.LME before enabling paging?
> 
> The TDX VM guest boot code enables paging (CR0.PG) and physical address
> extensions (CR4.PAE) here, but appears to omit writing the EFER MSR to set
> the Long Mode Enable (LME) bit.
> 
> According to the x86 architecture, enabling paging without setting EFER.LME
> puts the processor into 32-bit PAE paging mode instead of 64-bit IA-32e
> mode.
> 
> Will the subsequent far jump attempt to load a 64-bit code segment
> (KERNEL_CS has L=1), causing a #GP fault since it is invalid in 32-bit mode?
> It seems this might crash the guest VM unconditionally on every boot.

In TDX, TDH.VP.INIT initializes EFER.LME = 1 already.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com?part=7
