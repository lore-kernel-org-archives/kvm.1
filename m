Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889D93769FF
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878432; cv=none; b=UjHZDR0FeythbDjxEX9tl8ClAL3LBVRrAMPkBE8SDD9iSd4zTi6p+VwrZOBO4DAYDMX1dX3KnZFvqMg3E0V8PghbRgwqIXCfpNH/oZQQhy6Fv4khgtq6MWQ+jo/A9QcnnskQq7w+VcDFIwBPN/ofPGXzimpNEEpe/yEPa7KJ75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878432; c=relaxed/simple;
	bh=WCIcwrrTPMRmog2SUs+VIrCq0XbCEwlD78QOssRp5n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcsDPumUD5KvvQ75nvFmuWH4O+OP/+bs0D3y2mltmxhf48kxIOkVpBv4gYRq/nSnwy/XZpyOCYhHnPYDajZphvuMvrb2gj84OtURKFPo8Amfwxyo1wUsf46l1+kHR/8NU/NsFn0l/WuiAlYAMF96nstS8SKPV/V9G9lX6Decj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d9ng6axe; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d9ng6axe"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c591fb1cbso228782eec.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878428; x=1783483228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAjXq9Ej4fB7f7nIuAnBVBBySejxitzWJLxvllDtjcA=;
        b=d9ng6axe4B3l1jO2GAO4/8HsCPwfxVwZikiyfGiXDvovU2XW5eFaoOs07WKzYUXcUe
         R6NTsFMoXzC4p++w8muF9epCE4qRLluO1IjLChJUOZHF7MANlIB7Zf6fuiIYnHICTTou
         qk7qGOS88JhM1hrSGyOK74jJY28OXzvjT+NrU8xlijaoHpzoWzA65p6ssSu0a9Wg0yBy
         9RySouRJ9h3+uP1kRFqTdkMtSew5faLO1R1KroYS6/jhg4+J/sRObt4QL+hUHVok/8mv
         jTxHGKG6dP5y7qaaKJvtV8GfqOvG9HFVg1SYTJj9yoc8bwh3BX9/IDLgQ57c6ZaMbs1i
         +2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878428; x=1783483228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAjXq9Ej4fB7f7nIuAnBVBBySejxitzWJLxvllDtjcA=;
        b=fdD0hv8Fo69Ojq8qPwaHnWb23DY+jHNEUSU3BXph01LP+sH57qwOlmLXcNdpziB2WP
         OiJ4tioez+u0rgNPaQCY2uHAPXUzTDQpnuXutkvQgRDhmuiRaSU/fM4gL4TdC18RXIOZ
         W1eXZqgNhNHTEea4KZ86t2LBbeJIBrMxw7RGvsOpBSJkQinTRUopwZ8gwnWJD5dv+Dov
         0dbtJDYiFaccTlXq0dfZzhYH5YYoFh5j5CGjtgT1uKJzhcRL4+vK0EAb4Mpp4fR+dc/A
         2Ew1QDm4X6wwt/X5lHYXTIYm5MGKLitKIdFSaQSRgOJxv2o+JaPuwaK4wYDOhiRZT7sP
         t4sw==
X-Forwarded-Encrypted: i=1; AHgh+RrKz5w1iOv0m/+n27sIBtKJG+JeYUG4u4gFoD+hhbNIyI2qeneBUZSyWshk6XBE4g0HJBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DhLKoRy6TvvIaFEYJ91vnJ0KmeI8raVFf5/ryLz38PZHgWWc
	eNWKnBJVi+UxpKrEPZIglchfBZJpAhUBkFRI93X8To5uW4A2D1hcbYaWUwOj83rq/EI=
X-Gm-Gg: AfdE7cm/sIWhJQ4/m/xhF9uO2FoKKW6JNju0NHEolB1C29HccSZ+bXMG3GDbbTJdTje
	+adN8vrOrClKVFEJYigvP3WwBM3Iw4p3XpC+kCgI195qZSVq0Kyx1462d7Ha3RS38nZtIKeK6sB
	tluouVc5a41vFW2k63nnMsIlp8zbmfbI5MWtbVZocwrXKZ17f8ud7Jgv66Ns0QAKKoKx+3VTUFm
	c9BCBbeA2470pNFYU9M5u7lKfW+ELO88tbBLRXqoLEEna85LLpC2+6wKkoxUUnmb8nRga9FEiyX
	v3cWW9CZ7zDP8LWHYvOG1A80ufJFKl/oPCV1/Zi7M03yjlkwC6C0tWumkC9qcKSTMX7kZeffszg
	HGM9Ymuvs0wZCnY2xzMDdyUpaojhNj/nMdQKEE6qZuLb4/Eb2tZNRG4+v8F6MGmxOyvsb2Rww/4
	g4fbYVPdGGGcvnv71ulBZgEo/tzvQymOkuCGWhCd6EaWPmbXQFtMkXlrBjIalM0ukH
X-Received: by 2002:a05:7300:d516:b0:30e:c801:eace with SMTP id 5a478bee46e88-30eff05c70emr10195eec.5.1782878427991;
        Tue, 30 Jun 2026 21:00:27 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.00.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:00:27 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] RISC-V: KVM/IOMMU: Fix MRIF irqfd notice handling
Date: Wed,  1 Jul 2026 12:00:13 +0800
Message-ID: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fangyu,

I put together a local test branch based on Andrew's RISC-V IOMMU
irqbypass series [1] and your MRIF RFC series [2], then ran VFIO device
assignment tests on hardware on top of that combined tree.

One test case that exposed a problem was a VFIO guest started with QEMU's
AIA emulation mode, e.g. `riscv-aia=emul`.  The guest could hang because
a normal MSI injection was classified as a MRIF notice, so KVM skipped
the software IMSIC EIP update and the interrupt was never made pending.

The issue is that the current code identifies a MRIF notice by comparing
the injected guest interrupt ID with cached host MSI data:

    msg->data == iid

That is a payload value comparison, not a source/provenance check.  A
normal MSI injection can carry the same interrupt ID value as a cached
host MSI message.  If the vCPU is currently using the software IMSIC file
and this collision happens, KVM can misclassify the normal MSI as a MRIF
notice, skip the software IMSIC EIP update, and leave the guest waiting
for an interrupt that was never made pending.

This series identifies MRIF notices by irqfd route provenance instead.
irqfd_wakeup() already injects from a seqcount-protected copy of
irqfd->irq_entry, so patch 2 keeps the architecture's MRIF notice metadata
in that route snapshot.  Userspace MSI injection and normal guest MSI
injection do not carry irqfd MRIF provenance and therefore follow the
normal software IMSIC path.

The generic KVM change is needed because the decision must be made from
the same copied route that irqfd_wakeup() injects from; keeping the
provenance in RISC-V side state would not be tied to that route snapshot.

Feel free to fold any of these patches into previous commits if you think
that is a better shape for the next version. I also have a few other local
adaptation and improvement patches on top, but kept them out of this series
to focus on the MRIF notice issue. Please let me know if you already have a
plan for the next revision, I am happy to support your next version in
whichever form is useful.

Zhanpeng Zhang (3):
  iommu/riscv: Complete MRIF MSI PTE setup
  KVM: Move irqfd arch data into route snapshots
  RISC-V: KVM: Identify MRIF notices from irqfd snapshots

These patches are based on a combined tree, not a plain upstream tree.
The combined tree is made up of the following pieces:
In your series, patch 4/6 is already covered by the irqbypass series [1].
I ported patches 1/6, 2/6, 3/6, the relevant MRIF MSI PTE part of 5/6,
and the notice handler part of 6/6, with a few integration changes.

Fangyu Yu's MRIF RFC series [2] (selected patches):
  [1/6] RISC-V: Add more elements to irqbypass vcpu_info
  [2/6] RISC-V: KVM: Transfer the physical address of MRIF to iommu-ir
  [3/6] RISC-V: KVM: Add a xarray to record host irq msg
  [5/6, adapted] iommu/riscv: Add MRIF mode support
  [6/6, adapted] RISC-V: KVM: Check the MRIF in notice MSI irq handler

Andrew Jones et al. [1] (irqbypass series, omitted):
  [RFC PATCH v2 00/18] iommu/riscv: Add irqbypass support

[1] https://lists.infradead.org/pipermail/kvm-riscv/2025-September/010148.html
[2] https://lwn.net/ml/all/20250811061104.10326-1-fangyu.yu@linux.alibaba.com/
