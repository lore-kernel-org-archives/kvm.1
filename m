Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688F3590C3
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811722; cv=none; b=Cl93lXm+fPCoyMRYPLoCHNqC9S9gZRuBCrwpHLV213x9YRKsSL5gjrmDZGgqj+bEsDkH/9Ytbt0N21EdRDBwyOPFFdaHEOkz8tPFkMMgQQ3enaZ339a6eK9duUXDxM3xQAWFbQOd6mWygAHxU5FmM4HLccFB8uN/9svo/MOOw9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811722; c=relaxed/simple;
	bh=vfEfXnWX5XRHIG7xa/1KehCRje8+hVCYEYPeNc+IHz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqLRogMyRECKytsNpOB6jlTlT3jyT9eJgGbujhRUzLTGhzfex22468Y8si7AWSHImStjpPjoKYO0pJFxRXXRSw9yz3WHXMLIXM1/eJM1qqcAs1wXiwhYqPC3U2ul0B3ngvkbZe4sAhlhiQEgVSuRADeSGC2ALtITGnbY8Pmkc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXitUW0/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXitUW0/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cfff5f88dbso47031005ad.3
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 19:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785811720; x=1786416520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uu48l08iOiq9g5Bc53dhkabEeR0zOJy6W3JS0tzyMbo=;
        b=PXitUW0/qXsXIMqaO6h1XO7121mUhNpHLaTTn8Bz4yGMm31DRFeeMOUOzGBlPDHcek
         V7IAn0i0y53QzTFOlr1vSNonF0AUgRhZTrHLl6ZDi12oauQaDBgzUDGJsxfwkr07ViO2
         gaORhLlQbF/Y2pHm238jTkBXL8jjAv/460uujpdvcJbBiLtIeyiPG6LWAMl2+Fb3SdnQ
         eW7MNVneO7XgSHFEZKoSiAqIj12Awy2/Dn3UDVCbnqPsHZBm4kX4steDCA3iav8X/FUd
         N69WTmCe81MdRPIv1adkYyN8VoAcdFB1Yt0NjXc6gVMEw4DvDMZxPoiLQubUG9AoxuoE
         Bihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811720; x=1786416520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uu48l08iOiq9g5Bc53dhkabEeR0zOJy6W3JS0tzyMbo=;
        b=TuwJegB7hX8HxWPDJQPjROxwwiigLxtMKWl8YrVw4y5NFKgEnEqKDoH4dn1EQftU6f
         nWkSLdbaBpDhcOaHlsBGEbKafAAc8Ff4aEJAAtTmdA0QisBAcmUjNA0ih2j3BuFgkpox
         RdRUInmc1xq6MS0JJ7ILnjnYUg/okA8GYH+QJspmaAy8IBUHeOIRm3yzR3Gf+c1P9Zb5
         zvPCyZ46kLp0GATxSrLn783W/Hz7FHFnQOI5+ZT7eChb2AvgmCuOF+RN2qC06EJzQL3f
         5e1quXmx7PYCIvTcf16V0j8PC0kTBb9OdIAzII+57cN/N6mGdnJPC0KqPb/lInVDcocP
         2n1A==
X-Forwarded-Encrypted: i=1; AHgh+RrqlohFWb6JM9AqIdG24KKhYci5DEAT7qjO6kW0cMXVNcB1kHBHfn58dNs9b72a8kNIAK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpOSLHYru5KkgOgChM+3Mjk+EPHPxn0p/Chw1FXMxtS1CkSa8
	yf9kJg1hDQzKSVz29rNDSYp/bszNevI0hGMqDLEs+FBADuZDsSinKKxp
X-Gm-Gg: AR+sD12pmdCQWFwFcVSvkxYLws6OpBmKNbGY2+vsqmXhamrp03usXTkUFlZ8z4C8OD/
	mrTbc6tFeHa2/1iNSkpuohHfdlpSp58PDbMsQp7hpxGuAyBKOG++Ok0I4I8WNWVkQ1b6OHngATR
	lwjgv/FdBIaJqV4CU3hMW7pnct0EhHYwH7WgX3AGRkrYfUgbBbITmO3IGM0votZOzqypWR/rYrT
	b+YYLq3aPKJ7Pmt2dForBw9UD2VvSyo2LhJKbnI8u8VvgSj8y89YNy/2ypV67dgXCHmZV/Fjlps
	P1iAwXzHY2iGMrUJQMw+v2PcDHPUrhXzp33LGR0aUx559TVIulYntR7g+octgM/Ik0w+L87SDRB
	vhi/rk7KaHj0/sU3Ya+aBL3qMiRWpeJGPWP7waLiRN5b+2xPzBykeH7O7Xn8vjP4j7kgAZkoTbu
	rvrxh03Wh32rXxCMFWvPnjRe8LzC2XDQWQvbMJCbSVMs9ykYIyLyPUVBURuDlbJwwDyB5veuC37
	6N47fk=
X-Received: by 2002:a17:903:4b4c:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2d05242c4a2mr121069295ad.38.1785811720247;
        Mon, 03 Aug 2026 19:48:40 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm44837315ad.21.2026.08.03.19.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:48:39 -0700 (PDT)
From: "Yuhang.Chen" <yhchen312@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control VS-mode WFI trapping
Date: Tue,  4 Aug 2026 10:48:22 +0800
Message-Id: <20260804024822.2401012-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAhSdy2r8Ei9ESdSJB8McC1T=Atp0yNa2MxEbOWNVRTUM_8YFA@mail.gmail.com>
References: <20260709115610.287420-1-yhchen312@gmail.com>, <CAAhSdy2r8Ei9ESdSJB8McC1T=Atp0yNa2MxEbOWNVRTUM_8YFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anup,

Thanks for the review.

On Tue, 28 Jul 2026, Anup Patel <anup@brainfault.org> wrote:
> This would mean that for the "notrap" policy the VCPU would never
> sleep and increase host CPU utilization even when VCPU is idle.
> Is this expected behaviour ?

No, that was not intended. With "notrap", HSTATUS.VTW is cleared
unconditionally, so a VS-mode WFI never traps and the vCPU never reaches
kvm_vcpu_halt(); since WFI is only a hint, the vCPU thread can keep
spinning even while the guest is idle - the high host CPU you point out.

v2 drops "notrap" and replaces it with "auto": HSTATUS.VTW is cleared
only when the vCPU is the sole runnable task on its CPU
(single_task_running()), otherwise WFI traps and KVM blocks the vCPU
through kvm_vcpu_halt() as before. The default stays "trap", so there
is no regression, and the policy is re-evaluated on each vcpu_load() so
a vCPU that stops being the sole runnable task switches back to
trapping.

So to answer your question: the vCPU no longer stays busy at the
expense of other tasks - it either blocks through kvm_vcpu_halt(), or
runs WFI natively only when nothing else needs the CPU. On QEMU TCG,
host CPU stays around 5% while the vCPU is the sole task and rises back
to the trap level as soon as a competitor appears.

I have posted v2 as a new thread:

  [PATCH v2] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control
  VS-mode WFI trapping

Regards,
Yuhang
