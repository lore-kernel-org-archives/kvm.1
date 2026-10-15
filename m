Received: from mta0.migadu.com (out-133.mta0.migadu.com [91.218.175.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1C529414
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069039; cv=none; b=JJk0Xn5VEYi6tJSlTxCvE2/Xt/fmTYO3J4IEZW8Biu9zB5M5DzMbzVKgRFZkB71CHtdyrSyPkReX/vVoswxF/womHJQHA+yYpoW27A4RPkIRdD1hh6DPFvCTsENI52vPmNlabN3NDqrBXdahbi/SSLK/CuDOOUnLqYQ7TIVP8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069039; c=relaxed/simple;
	bh=uGgOTqoXN8cnMYnIr0hBIol3IrBC3WkVwqukxqDL3aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmYQEFqJF5a0S9BpTAhpqJUjjgjWx9Hh/yOwvRztnOSyautkYoeMmzvh54kksnQm8EauYTH3nbiuFmj+dPjk4Qv25Wy5iYONEgOk4pXAkdSAcFf95lwmgXk6PxoWEn7eKkBVkqqNU/SKX0hdRZHD/rv/k6gbP3HwO++oyhDYDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilDjPIiX; arc=none smtp.client-ip=91.218.175.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilDjPIiX"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uGgOTqoXN8cnMYnIr0hBIol3IrBC3WkVwqukxqDL3aM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792069036; v=1; x=1792673836;
 b=ilDjPIiXt1iyGqGkqvHL5Yhnpd57tgsq7uQp3cSdvbZ9dCKIx7dCqm/9D2zgxEu/n+05U9/V
 BuA03TmTjsluEhfLaVg1sbryIcYNdx7tqb+xr2Dhmz04lCkwCNgXZl8uwDysVOKZGW98oTYwAoM
 sEWEIQ9S0yRa20pK8DzTIIh4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 860c7ff0ce382135;
	Thu, 15 Oct 2026 12:57:15 +0000
X-Mizu-Trace-ID: 860c7ff0ce382135
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 2/7] KVM: arm64: Move OUTSIDE_GUEST_MODE publication past context being saved
Date: Thu, 15 Oct 2026 13:57:13 +0100
Message-Id: <20261015125713.2650696-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261015100539.1011760-3-maz@kernel.org>
References: <20261015100539.1011760-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc,

On Thu, 15 Oct 2026 11:05:34 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> However, code that uses OUTSIDE_GUEST_MODE as a synchronisation point
> relies on the vcpu state to have been written back to the in-memory
> structures. Clearly, this is not what is happening

nit: missing full stop.

[...]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
[...]
> @@ -1390,6 +1389,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>
>  		kvm_arch_vcpu_ctxsync_fp(vcpu);
>
> +		/*
> +		 * All the state has been synchronised, let advertise
> +		 * we're outside of the guest.
> +		 */
> +		smp_store_release(&vcpu->mode, OUTSIDE_GUEST_MODE);

nit: could this say the vgic state rather than all the state? In pKVM,
a non-protected guest's context comes back later, in
handle_exit_pkvm_state() or on demand, and with VHE the EL1 sysregs
stay on the CPU until vcpu_put(). Also "let's advertise".

Cheers,
/fuad
