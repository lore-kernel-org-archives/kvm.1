Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881019;
	b=GPQf4sB78p/D2K02oETUImEAQ8AVRPT0bw8BKXt45Mb2ya97O/TdGmyr+W39IAZA0HtX
	 6/u6aw1+RxnkGT061zNuh/WjXfinYFpVyd/xAEboYNZbG3u2fYQ8rH28WaIQnWwXQU+Br
	 mF3/psZxtqfzy5aiE3mDOhCLHQe/GV4k/ZMgSUXL8kcEtetwCHGpBRvl/cKcMncR6nQK2
	 k5hXOsqNq6hUhxQTkYtPrMtRiROch4PDwJ/enqylMEDiLMaovOR4vyf6IEpqyWJbi1mzz
	 ZyWz7zNpX2IB7JZiNQempQiDNo2aCa//5ZCi8d2Slb0K/cPbrZjmmtEo4SiW4gKaYdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881019;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=IA2WY3yNmb+K5Fpsg52O2Iq7E8rleDjZAuLC45egiIs=;
	b=FvKogLYfmZhYvS87qQXuIZwyjwFJVXkFoCegWrDYBxDcI0ZHU0i2A/deIpzJ7BlMC63Y
	 HMp2cWAdWdcjStDNtZ54RXyjO6iBV9yS4YwrWAbpuyfuM8/wZroKbAYxY3C4mBYwy7tJl
	 id/wSqALy6cM9fUCsTsJp0y5U9TdbD+7La8sb/HEzQlPkyjePk+T6o+lweYXd3AMe/ae6
	 6gRglARgMkNdbDwXiXGa6CAG8eDnptFR4MFX6zyvkPXpQAQd+TRcItN1E9OAMOk1gRPar
	 K5tZ1orLFQczaRTuipgdy8ojrcd3y0IpSjbqXKZ3TSg4j1c9TdtWVfmH0KCORfRsHKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XSDmNO96;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A984606D83B
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 12:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A984606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XSDmNO96
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=exIR8W8oCZROFJI2uk7aiMwrPmf06QUD4IziM5WiRos=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793881016; v=1; x=1794485816;
 b=XSDmNO96XpJIePDfHax3GZpy1jV0PW9LdS6odNwmgQZJzrrYeWgU8yZK49ZroIxzcengPuH6
 Jzn0M0xo6H7202/cKJJxMYDdlypAUOP1TDgQ5YgstPhzzntfb/vdiWea9AtFSr/dxrKja+sFF1F
 zxqdDBRmyLMhivBbUVBacKzU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ea4345e8a51c999c;
	Thu, 05 Nov 2026 12:16:56 +0000
X-Mizu-Trace-ID: ea4345e8a51c999c
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bff701efa5so5936e87.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 04:16:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzoqAwDyzWMSlszLaDS5D4A6UAFaxnrxr9glzTjrnjTl/DGGljTJqTCoehx39y4oO0I+Gg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gjVtxfEBd6fzbR6cD5xhk0/VQOyyNlxaedSTC/4EtMw+K5b1k
	uATg2NpfbOKIzplWSoo9GOMDFS/sSo4uHV/MxoFu1YaQwFWGlieJdDZkNy5A32jflEDr7XoCUBX
	XIeVrgmBp4EqJqbCbRdq0Ku5zf52McsX61TWz9VB1
X-Received: by 2002:a05:6512:2387:b0:5bf:d1d4:d678 with SMTP id
 2adb3069b0e04-5bffa4669efmr169831e87.1.1793881012035; Thu, 05 Nov 2026
 04:16:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105110050.1244525-1-fuad.tabba@linux.dev>
 <20261105110050.1244525-4-fuad.tabba@linux.dev> <sashiko-outbox-198943@kernel.org>
In-Reply-To: <sashiko-outbox-198943@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 5 Nov 2026 12:16:15 +0000
X-Gmail-Original-Message-ID: <CA+EHjTy6+eybqqOoOPr0TxKfexD+gjcvpGQ-kCMmaKz2yQGiKQ@mail.gmail.com>
X-Gm-Features: AclHuK-wbPaGOFcnKWXZun6kQfFeB-tajjKRV0aOkS7s2VVDPjtOHTnCjBx72tA
Message-ID: <CA+EHjTy6+eybqqOoOPr0TxKfexD+gjcvpGQ-kCMmaKz2yQGiKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: arm64: vgic-its: Don't read the pending table
 when mapping an LPI
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 05 Nov 2026 11:23:34 +0000, sashiko-bot@kernel.org wrote:
[...]
> > diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
[...]
> > @@ -2717,9 +2714,25 @@ static int vgic_its_restore_tables_v0(struct vgic_its *its)
[...]
> > +        /* Enabling LPIs read the pending tables before these LPIs existed. */
> > +        kvm_for_each_vcpu(i, vcpu, kvm) {
> > +                if (!vgic_lpis_enabled(vcpu))
> > +                        continue;
> > +
> > +                ret = its_sync_lpi_pending_table(vcpu);
>
> [Severity: Medium]
> Can calling its_sync_lpi_pending_table() here cause KVM_DEV_ARM_ITS_RESTORE_TABLES
> to fail with -EFAULT when a vCPU with LPIs enabled has a pending table that
> does not cover LPI INTIDs targeting other vCPUs or unmapped collections?

Yes. Unlike the map-time read, this reads each LPI-enabled
redistributor's table at the bits of LPIs targeting others. Will fix
in v2 by skipping those LPIs.

[...]
> > +                if (ret) {
> > +                        vgic_its_free_device_list(kvm, its);
> > +                        vgic_its_free_collection_list(kvm, its);
> > +                        return ret;
> > +                }
>
> [Severity: Medium]
> If its_sync_lpi_pending_table() fails partway through syncing the vCPUs'
> pending tables, does this error path leave already-queued LPIs referenced in
> dist->lpi_xa and on vcpu->arch.vgic_cpu.ap_list_head?

Pre-existing. On kvmarm/fixes, vgic_add_lpi() already queues a pending
LPI as the restore maps it, so a later device-table failure leaves the
same state. The early return in vgic_add_lpi() on a retried restore is
a separate bug.

Cheers,
/fuad
