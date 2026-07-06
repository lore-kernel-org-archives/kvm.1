Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E73E9284
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372605; cv=none; b=c3PqUgJwvCunXlLe1oyuwsptcpjKb2jiDdLJPf8lmQFIkLC3HQgpMhdFBlCAoRQaO86QeAjQKfqEzUIyPOD983EgLKoNrB6zZ9lGTWfEkVwm6N/x+k7N4fCExR50/pAY4ciJtA48XKsiK+IVR5FFoP06W3grXPVZFh276xjnaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372605; c=relaxed/simple;
	bh=4GnilHduczk3eh6aVBjNmxjoSJR+DD5x02tgYeQxXb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvpSkwSOqVldF3HUujJVbABYsRHN0+X+7OlMC3rZcIANXXJZga3offBBAGxx9rV1zg4IUyd5SKJ/7ediEXgsWrNAgaHBXvlE7FbhIFQoSD9tKNb4viZTIvx0+HaCeUo3O1EpCxx5m/4h49a71ISUEol+CP3A2dAfweO33R8qHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ML0wLdsJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ML0wLdsJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8479f1a86ecso2398325b3a.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783372602; x=1783977402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5hIaEd5PA9pW7IosYUjHC2CfzgghDNBXbRfDIivL3g=;
        b=ML0wLdsJHKwFfjGsYdFUrxY1e+M19mIEdQO7sh0eTHNKrbZt/rvSttEIRGcclyE0Fp
         aJwVnD+CZ7ODOlqUTrGbN49JxoxvxFI1sCBvx88mHyT76q3FmawLJVtp/fSyvCqkV1oS
         vzfpeObU2YiLV9PguQeVFh5jHLRxkxv556lVftzTueseiK2lq1mu6S5MYkLqWqs2Aq1L
         Ep/KPp2oYWZDUrrQ+8lGOwKmoosHYukPViWFatukY5gtAiFeAPwNA+McJpo8tiRrKP4p
         N91XUCT2OAYTYm8iFUjk01rn1eE8ne8v2cdGNFXlAFgRKWwEcRwiiNp5EIjGIY99wgjo
         /d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783372602; x=1783977402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5hIaEd5PA9pW7IosYUjHC2CfzgghDNBXbRfDIivL3g=;
        b=Gd3rdw7dR04ioL3xRp5eDxpZvhLyg/EvO1Cq55Y+BGN8RECxE1re6bF62Ir9iXVfKG
         cYWP//kv43gmMYt58N2v2b5wiUEhpVtduR4Heu81P7vJhpIwaEHEnbBYa8AwsI2vc7fQ
         8vjCQgfmQMJLVWgYlieFIeAibbZcNJE524nnUw2eyF7cEveuB4zKPqYTBQK5WHVwwRXv
         WwfQBwTGQKgMf54Y+GkoaSBNZL6WPTXuYR0bhsHDE5WuhXT8/bIFd5iEaaLvngwX3Q7s
         5/Zd9PoShHl4FYI9Lyazr+/zDEIPa0zYEWMWtKzCvFzfh4nazpuxMGC3y+ZZg/ohk516
         y3Yw==
X-Forwarded-Encrypted: i=1; AHgh+Ronr/x6sl6GM0p9tyaZqxZDW8QpSGR5qL8ROMpyWtlvlcpvPtx7xi/aBYcrzFttZgM+cmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYYHvQJu5f1WMMAaL/frGc0jdhf8Fm3z9JYQtQc3f1usrUpdb
	HS6kGAAmDUZY3V3k3cbeXV8k4sWGv4xAzN9LSJ+ggnDbVOpt5SX/Jvxl6QdjWisKHg==
X-Gm-Gg: AfdE7ckU30F7f5o5UAg0f54TnvTXfjkakv2eia0aQA/9TNxZtqaZso/FBiDSONrQpbk
	+B4QSUxj3KatIrM0S1SbZO583M1ChlpCSGZVvqd6o9CRKo25g2/tuQk70BtioZW0b+1krUhuead
	mW6F3PrQdEnx6jHGrn58v/3aGyYlUDxcP4vy2lPsG2sFuhtS9nQymkZzkfdkTXBWYUhg+BBcsXk
	bnNNAuAfJlq8hjC8pXgpZeufBhVC1zaQ3xKow0Rz0jrPW90ag6J/154CUZn/rFlSf/LN1SqvW/Y
	K6pd3JesQKbTJxDoP83qIRrjn+Co4JItLTIYiAsCoClyG3BCGUu+TdSzIDlCPBL/1p1jVgmoC/M
	ZFxMxIU4lL5HsNvYDsiKNleDw6MuzetkQULt5uikww6yLmyscJJJ9584eKE0WWBCBGSohB4NdPe
	sR/Rz0n1RcGeNUHzrTMLayQvmHnOfkH7Iaxh2bwYSTcUVfPR53DSkunMxjsesDlA==
X-Received: by 2002:a05:6a00:18a7:b0:845:4d3d:c8c with SMTP id d2e1a72fcca58-84826d3e363mr2212071b3a.39.1783372601975;
        Mon, 06 Jul 2026 14:16:41 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8482b333d4fsm262662b3a.54.2026.07.06.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:16:41 -0700 (PDT)
Date: Mon, 6 Jul 2026 21:16:38 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v2 09/10] selftests/vfio: igb: Recover after DMA-read
 faults
Message-ID: <akwbNmaeX0Jmvs_x@google.com>
References: <20260526235417.2058313-1-jrhilke@google.com>
 <20260526235417.2058313-10-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526235417.2058313-10-jrhilke@google.com>

On 2026-05-26 11:54 PM, Josh Hilke wrote:
> From: Alex Williamson <alex.williamson@nvidia.com>
> 
> The mix_and_match test intentionally submits a TX descriptor with an
> unmapped source IOVA so that the DMA read fails.  On real 82576
> hardware the resulting fault leaves the descriptor engine unable to
> service subsequent valid descriptors, so the next memcpy in the same
> test iteration times out.
> 
> The 82576 datasheet (section 4.2.1.6.1) describes CTRL.RST as the
> software mechanism to recover from a hung device.  Empirically
> CTRL.RST alone is not sufficient in this state: the visible queue
> registers are reinitialized, but the next valid memcpy still posts
> descriptors without any TDH/TDT progress in the same process.  A
> fresh device open after the failure works, which points to a reset
> scope broader than CTRL.RST being required.  The 82576 advertises
> PCIe FLR; VFIO_DEVICE_RESET drives FLR and supplies that scope while
> preserving the selftest process and its DMA mappings.
> 
> Add igb_error_reset_and_reinit() implementing the recovery sequence:
> issue VFIO_DEVICE_RESET, re-arm the kernel-side MSI-X trigger against
> the still-valid eventfd via vfio_pci_irq_reenable() (this does not
> touch the eventfd, which test fixtures may have cached), and
> re-program the device via igb_hw_init().  FLR clears EICR and leaves
> EIMS=0, so no explicit interrupt mask or cause writes are needed.
> igb_hw_init() resets tx_tail/rx_tail to 0 and igb_memcpy_start() zeros
> each descriptor before submission, so no ring memset is needed either.
> 
> Call this from igb_memcpy_wait() on completion timeout, preceded by a
> 10 ms delay so that PCIe/IOMMU/AER error handling triggered by the
> just-observed DMA fault can release the device lock VFIO_DEVICE_RESET
> contends for.  The delay is heuristic and tied to the fault path, so
> it lives at the call site rather than inside the reset helper.  The
> failed memcpy still returns -ETIMEDOUT; reset recovery only ensures
> the next operation starts from a usable device state.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
