Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CB34753A
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396963; cv=none; b=Hu1IEcjVbFkADaVRkIA2VByuPPmPCVgXWYgMqaH6SsvW7X2z2xWHzmyfsD4UNU+2ZV5MajW5Gg4WssK6xGOSLtbeu6ENzw/HHKrrktD4r8Btiy5uyVjlZnO7yF9RT5xSHRkG+PptmQJwS/w25jABbC613j4FTd98Vc7uejACdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396963; c=relaxed/simple;
	bh=iZFB5O3yYls89/a7prTviepZAmlHYtU3yy8LB94oET4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErqD+T/VjwILQXAm4rg94gNxgXqd+gEMS/HgqEb7C6g8K8MW3+Pz9PhpugAma51OHB70cnCHH+anUNQ00548M/cc6Az1pj76rZVjMrJbZPLTcprjs5A/RkTvY4zE2rLWDCu9AT2HuSrrGOq3axbETWDjEEKKXvnoFpakkc/8mhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjYJF62m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjYJF62m"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so11483615e9.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396960; x=1787001760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYpJjvMop3p/gly/It61F2813t5+gwnEvzTnI0j75g0=;
        b=JjYJF62mKLOLaFTClVYJA5VWAHC1SCVMDGhy2MTeUF6AkxmaQYsjKKM9F+QXMvkph2
         pZUeSskFHLcTwH5SeGejxhwPIi09z6oZlA8S6mnx9aESFPkDaov3deghvOirFYv4bqAL
         nNo79oVwpg+mzN6n63l72qm2n/RdHLrJ3+PVIlYmcAPDjycFUOaF7qBxxSW66w/F1cHb
         9SayvJRV3LifM2ehDDa6pn7yQfLvZBPX3Ndj8bxpBmoPjDUeAqLONKQ6O9AACB732kv7
         /zlIVJVrVVo6iASiwvTeaIttBSTxQlHVD8c9QWWkxp4DoF4ObEyHIz+x18RNYM+2uCWz
         X/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396960; x=1787001760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYpJjvMop3p/gly/It61F2813t5+gwnEvzTnI0j75g0=;
        b=aoYLG210G6CQjHScXEEd4ppgcM6cprxzRpB748I0tF/cT+0rYtJ3mv5cxR2jHdrkz8
         lCRQCT55YXcvklTM4LNdaD8gwfKkL+nl42psh/qAcmujFFb67tjpil2L2ZzBORzcMy+v
         6XuD9ac48G207uLtVvv4VIouNxfyidZqv9fouR0fQ8K0fLsELEuIh5CkWVQQml6IIkcw
         wseheO6UDBJU2xmiMmdTtArwpJWdw9NQDz8UtxxWS7EMClMMH3xY6j9/PCZuzuBXPr9m
         QaEysTcCeYvqIyezLV+b7gv3LbrnaZFRwN8YpL6ST1GLL0S049kfATWdd6rDb9W3gZ7m
         sT2w==
X-Forwarded-Encrypted: i=1; AHgh+Rq5xHxE4SLABlUXWqjK8lJgpxfoDAGNf7EuTihKNN8ELlO2BJeoigsM4SfmO5H5R5QV19s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCP4DncTpgKm2Yuln54aJnz6ZELiW4P7ITT9othoAg26XhqB9
	fBnKajk84rOFp8qgusiLRIrdQNFYAbPBKYaJzJ2vdieg/Hc+YrMHIPqm
X-Gm-Gg: AR+sD10h/R0WHOSb64IXXbfDiXwhOnundyt1aAGTfHpA8xOw+0b1c7S9aiwc0aJF1im
	VrJf6OjYvk9WM7bIbR/heRXZSjgo1w3orqTWhiEGy/mVkPQFmeXL7Lg7RRswLC9/ExiZFskMgu0
	IrZwHukfRoTxt0PBsHdz3sUb4XlE86lZbCBD2SimrbaLnPbkIXeY8r9NYihDq+JlLwgsHHWEnjG
	667Aog5NIxF+ghMInyT2BfckztgxnjDo370udXBv/rKPKJ6cEYHQboClLVfguRALPs1omNvbcR9
	7ullmKrONbsRZM+a8tew6l9OSQB9UPAwzZzBOnfMOZOqsb5+znPBep/SzuL4KM2a5jOSPrnmtEx
	9WrSxc1eXXO8mNnsZ8VwsB52iOL8xHGh+s/YIx6F9uWYMCQRM0+G+1hHAWq0SMk4/56Wh+o+0A5
	7xi2o5uh9iyMXj7YkHufxzu+1/I9hak8PIqVolLUHygHIQWshW3rPRZIbyAf7aD9uAERmN/ZBvZ
	HS+Xw6xkPJqxi4lI6m+pxIrDUZiCKk+1QkLi20zSyJ5aikBpr+Lzw+jiEGzbPqJ2jyXVzLigXbH
	7+GZ3LIaLC54MB3BNMFGJvfCoyV+amdn/uWQ8+nrnb8YzfRmxcf/NDe074yHggnq3SMz0iM=
X-Received: by 2002:a05:600c:3585:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-49972740d07mr52058455e9.2.1786396959461;
        Mon, 10 Aug 2026 14:22:39 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a1e8-7401-316d-6c00-7a9a-8fac.310.pool.telefonica.de. [2a02:3100:a1e8:7401:316d:6c00:7a9a:8fac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740d2c6fsm18342935e9.9.2026.08.10.14.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:22:39 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:22:37 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Eric Auger <eric.auger@redhat.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] KVM: arm64: vgic-v3: Roll back failed
 redistributor region setup
Message-ID: <anotFcOP0kcQJwrA@gmail.com>
References: <cover.1786344511.git.kmehltretter@gmail.com>
 <4e00fc25aa61ec52e6ef033a53588ce3f5550982.1786344511.git.kmehltretter@gmail.com>
 <86tsp2139b.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86tsp2139b.wl-maz@kernel.org>

On Mon, Aug 10, 2026 at 03:03:44PM +0100, Marc Zyngier wrote:
> 
> > A later REDIST_REGION attribute can be inserted successfully and then
> 
> Later than what?

I meant a REDIST_REGION write after earlier
region writes have already assigned RDs to some vCPUs.

In the selftest (patch 2) 
- region 0 contains RDs for vCPUs 0 and 1
- region 1 contains RD for vCPU 2
- the REDIST_REGION write for region 2 fails while KVM processes vCPU 3

> Holes in the MMIO space are the norm. The IPA space can multi-TB
> large, and there is no reason why it'd cover everything (where would
> you place the RAM otherwise?).
> 
> Is the problem here that you are left with vcpus that seem to have
> been matched to an RD (base_addr being set), but that really are left
> unconnected?

Yes I guess "hole" is the wrong term. The vCPU still has an RD and a
base address, but its iodev has been removed from KVM_MMIO_BUS.
An access to that RD address then causes KVM_RUN to return
to userspace with KVM_EXIT_MMIO.

> 
> > failing vCPU already has its base address and region assigned, but the
> > old i < c rollback does not include it.
> 
> What is "it"?

I meant the current vCPU redistributor iodev.
vgic_register_redist_iodev() sets the vCPU's region and base address
before calling kvm_io_bus_register_dev(). If this call fails for
vCPU c, the rollback in vgic_register_all_redist_iodevs() processes only
vCPUs with indices below c.

> > Preserve devices assigned by earlier successful setters. On failure,
> > unregister only vCPUs associated with the newly inserted region, clear
> > their cached base addresses, and free that region. This also includes the
> > current vCPU when iodev registration itself fails.
> 
> What I don't see here is an argument explaining that doing this
> doesn't change the guest-visible assignment of RDs, which would be a
> regression.

vgic_register_redist_iodev() returns immediately if a vCPU's RD base
address is already set, so its RD region and address don't change.

Regions are filled in index order, a vCPU without an RD address can
use the new region only after older regions are full.

So freeing the new region and clearing the RD state of vCPUs associated
with it restores the state before the failed write.

> Based on what I understand of your earlier description, why isn't this
> as simple as this untested hack:

I ran the selftest (patch 2) with this, still failed with:

  Unexpected MMIO exit at 0x8050008

When redistributor registration for vCPU 3 fails, the for loop does
vCPUs 0 to 3. The issue is that the iodevs for vCPUs 0 to 2 were
registered by earlier successful region writes and should not be
unregistered.

On retry, vgic_register_redist_iodev() sees the set addresses
and does not re-register those iodevs.

> I don't mind the cleaning up, but not as part of fixing the issue,
> which has to be as small as possible (think of the backports).

I reworked the change without a new helper (see below).
Is this closer to what you had in mind?

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5913a20d83019..d9a28b983ecca 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -841,7 +841,7 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
 }
 
-static int vgic_register_all_redist_iodevs(struct kvm *kvm)
+static int vgic_register_all_redist_iodevs(struct kvm *kvm, u32 index)
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long c;
@@ -856,12 +856,15 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 	}
 
 	if (ret) {
-		/* The current c failed, so iterate over the previous ones. */
+		struct vgic_redist_region *rdreg;
 		int i;
 
-		for (i = 0; i < c; i++) {
+		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
+
+		for (i = 0; i <= c; i++) {
 			vcpu = kvm_get_vcpu(kvm, i);
-			vgic_unregister_redist_iodev(vcpu);
+			if (vcpu->arch.vgic_cpu.rdreg == rdreg)
+				vgic_unregister_redist_iodev(vcpu);
 		}
 	}
 
@@ -960,8 +963,10 @@ void vgic_v3_free_redist_region(struct kvm *kvm, struct vgic_redist_region *rdre
 
 	/* Garbage collect the region */
 	kvm_for_each_vcpu(c, vcpu, kvm) {
-		if (vcpu->arch.vgic_cpu.rdreg == rdreg)
+		if (vcpu->arch.vgic_cpu.rdreg == rdreg) {
 			vcpu->arch.vgic_cpu.rdreg = NULL;
+			vcpu->arch.vgic_cpu.rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+		}
 	}
 
 	list_del(&rdreg->list);
@@ -982,7 +987,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 	 * Register iodevs for each existing VCPU.  Adding more VCPUs
 	 * afterwards will register the iodevs when needed.
 	 */
-	ret = vgic_register_all_redist_iodevs(kvm);
+	ret = vgic_register_all_redist_iodevs(kvm, index);
 	if (ret) {
 		struct vgic_redist_region *rdreg;
 

Thanks,
Karl
