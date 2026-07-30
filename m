Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64A3314A1
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394299; cv=none; b=c5djGDl50DhXrpwM+cB3HsLAM7gFZDSAS77HtNw0KUGQ4LFepjYV1NQbWEVTiooGqXAvUT18X4VkVy3rh5nc9asbaqZFHIAen/5VmqtxjBSX62TcTV/iWlNRpwLttk7+hdGHyW6ikxJ/M8qPce7k24rq6OsuHb1LJ7N3TH9gZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394299; c=relaxed/simple;
	bh=icMXTnzaSJ6+MSeJ5Apat14mapNo5PQAIFNRe+YMLec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F793nhlx5HxODyotnvrLn2IAaluBMHQhnC+sdlQa+Z5IdA++ev+Ufx7v01RwRbi5DkEsO0olQy4+NJUmtJY3mNViI3xG6dez9vNmG1mugLuGiWtNqGibEMlX8tNjGv3Hbu13GmXu69qXCA6FsScJtyHnlbpM1swhZfoOXkLf5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4bnug+O; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4bnug+O"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cea3004256so20741645ad.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785394298; x=1785999098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icMXTnzaSJ6+MSeJ5Apat14mapNo5PQAIFNRe+YMLec=;
        b=C4bnug+OpoaYI6Db1xXte6jzqprbUS7hz8vW/xRkn3Jy6FNxdFaTaAJMOAjs7A6FPr
         hXDiKpO6hBsaeo7ZaXNBSthYr0obejy1ovGNJ84l1KXijgJsFUmow+uOnztO5lZOVI5J
         fIa9VDKyPvrTm6NIguioUD28h9ZHyFJHmApk9vLPVaWN1AKVU+KKTUEI7GWvHw45jpG1
         bOiWIBtPCGg2llF08yV7mlKLgibAesLjlWfbwOXcL+mIphrZgyltaZmke8tdCrMt6t7o
         lyPrt8AJLhcZgIuxpuAomwsExdp1lPvbVoyhaTC7a64wzrVFeeMG610sCaO0yqRWJ4yo
         DxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394298; x=1785999098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=icMXTnzaSJ6+MSeJ5Apat14mapNo5PQAIFNRe+YMLec=;
        b=msTehUZe9R1+w2+jld7sJHLQsHxidspJUNErRszZUDeg/sLGu/v266m7gVFUO0vWEI
         UNecqe7xNIIRjJVnREKIW86jV0k5w+iiTrMW72dN0XmXbGO3BEBr+XCTUX4fHK1sZFSg
         gaTA5ssJHltqx+XlhRiChnfl+ebtDDoR3N60XMUhRATPP2nVQlAPSgI8e1PqH8VY54uN
         MDDd03S7ZBYD3de2lM2ascbgsiQqNyw12rgQvBVc0qeBq2Al/h00Uw3ZH0yCAq55FMC0
         zeA0Sb9A+tLcQH+dr1fWJyx9XfB10zR0B/RM/RpQpDTkMr7tSUoMCUgOnSDq1rp+U5HA
         8wRA==
X-Forwarded-Encrypted: i=1; AHgh+RrOMlRli7GhuaVMgdX2UIExkVp718k/Km5tPS7eFRJVmAXL/PX0QcHqs8NJakMQTiBX370=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCH6/Jl6SCWELEMRyn6y7XAe0zLauOaoH0yzlf2kLHXy00Z4g8
	wYK9yfhAahNzc9qEXRs4JdiFat/fsJwx8KWvhTGEnz+uc1ODY6CeBQod
X-Gm-Gg: AR+sD10CuQXJj3tHZQvlORRIcijL7f2uA51RAiQWdhwjoZeEEeWyEDf76DMhgGi0/zz
	Qx/sNQE8Q0/5pgksnAbkzZ0WpM4BELLfTOolSF8qFV5Xry73LLgcjozWuemcLm2H38DKOwrVh97
	pkZ4SBdfA1d6tHynczoOX4vyLz5gl2oy7Qplw/YpVBzEh3hO4Ntl/2AksBLWLuYY9k7bUxuoddz
	0u9pni0716PxDCi2o4wgxSACRjHHdgVVyW9BPQBL+dssZijwevyNEfKD4XVz+bUMWcJZ6Jqd+4n
	2xDDDABOVdyberpQ7C/kY/0/uqesmDDePIIf3Uvghu1zoIuJU62HxYHXXadVMReAI2Sq9n/PN8M
	yHsKWRBRdjmqnIZT/SgtXbwNrCk9RA4/Q8Tqxbdeauxdb4Vha1kwNmI+4tln6EJROqeR6GM6Tvc
	ODqM9j+qbic16VzHNDijepI5OhC4oEj82opx1ZO8FTQIXu7DA1x0ug9PwmPnWX+MHhC5dpotXHl
	ixgnlwKpmV9oF4kAg==
X-Received: by 2002:a17:903:1585:b0:2c9:97a7:71ab with SMTP id d9443c01a7336-2d035d0097cmr15283805ad.38.1785394297603;
        Wed, 29 Jul 2026 23:51:37 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bca9d7sm21707555ad.52.2026.07.29.23.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:51:37 -0700 (PDT)
From: "Yuhang.Chen" <yhchen312@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] RISC-V: KVM: Add arch-specific tracepoints
Date: Thu, 30 Jul 2026 14:50:48 +0800
Message-Id: <20260730065048.3715824-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAAhSdy2Qa2DGFzb27MgmoH5Pf1BOrgwaZBqP__U9eejs5-5Bsw@mail.gmail.com>
References: <20260626103619.174179-1-yhchen312@gmail.com> <CAAhSdy2Qa2DGFzb27MgmoH5Pf1BOrgwaZBqP__U9eejs5-5Bsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anup,

Thanks for the review.

I've addressed your comments in v2.

On Tue, Jul 28, 2026 at 09:05:39PM +0530, Anup Patel wrote:
> Drop kvm_guest_fault, kvm_sbi_ecall, kvm_wait_riscv, and
> kvm_csr_access tracepoints. Instead add common
> kvm_vcpu_exit tracepoint for all vcpu exits just before the
> switch case in kvm_riscv_vcpu_exit() function.

Done. kvm_vcpu_exit now reports the full trap context
(sepc/scause/stval/htval/htinst) and is placed just before the switch
case, after the CAUSE_IRQ_FLAG early-return, so it fires only for
synchronous traps.

> Drop the kvm_irq_line and kvm_timer_update_irq tracepoints.
> Instead add common kvm_vcpu_irq tracepoint called from
> kvm_riscv_vcpu_set/unset_interrupt() function.

Done. kvm_vcpu_irq is called from kvm_riscv_vcpu_set_interrupt() and
kvm_riscv_vcpu_unset_interrupt(), covering all callers.

> The kvm_mmio_emulate tracepoint is fine.

Kept kvm_mmio_emulate unchanged.

v2 follows in this thread, with example trace output captured from QEMU
included in the commit message.

Thanks,
Yuhang
