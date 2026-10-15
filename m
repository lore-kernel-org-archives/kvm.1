Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554345293E9
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069038; cv=none; b=FQO4725IQEkSwvpH82uRJuasmu5A/6jxCJE1q6F8th/V2D54kr3kHObQvNTqF4JPYRlfhmiOarBtZnnroMyocHbzK25yUKhKz9BygJHuOkl/MES54lFZ/DxVCWitHFeaL514tMmRulertgUUQ8Aa9JQd2KsLBGig96mXQ+YUfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069038; c=relaxed/simple;
	bh=j8dujvmgK4dl/NXr7CvP1EwjRXMje/JjztxTmi7ODS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TL/ECKkTozKAVFq4YfEPQsJXq3yLEoYgmlgNmfIKWRavpa9aRYJ6A/BIptsVHsh5vt/ZA8i5uvxPB+fgBKhGCABFanwAzoSIrtPAJbDeoq9M6vgdnjjEiJBIi22a+Uprho5GIC9PsDKwSAZ6L4MErhNL+8wMADjPsenWTJdQZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZnEnph1; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZnEnph1"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j8dujvmgK4dl/NXr7CvP1EwjRXMje/JjztxTmi7ODS8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792069033; v=1; x=1792673833;
 b=mZnEnph1NsfCOOhywNX7fVSoWXX7Zi9nR8ALAzfN+DX+0lwGE1SYwShqIdMmQJ+zQohwArB4
 nfcQiLAw+Vwnqj4TKWKih+Zz22M5JQniKcsJKf1nhVzObd7eunB5XaVcmkf6MrWPXXOlBThBQ7q
 J+hp4KeHBfdGYwCQRMDAdnuI=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5aeab5d2299b6ea8;
	Thu, 15 Oct 2026 12:57:13 +0000
X-Mizu-Trace-ID: 5aeab5d2299b6ea8
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
Subject: Re: [PATCH 0/7] KVM: arm64: Fix cross-CPU vcpu pausing
Date: Thu, 15 Oct 2026 13:57:12 +0100
Message-Id: <20261015125712.2650518-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261015100539.1011760-1-maz@kernel.org>
References: <20261015100539.1011760-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Marc,

On Thu, 15 Oct 2026 11:05:32 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> This series addresses these defects, and builds on top of it to:
>
> - add pausing to a single vcpu in addition to the full VM pausing
>
> - convert LPI disabling and the MOVALL command to vcpu pausing
>
> Patches on top of -rc6, most of them being Cc stable without any
> qualification (this has been broken for as long as I can remember).

I'll send a couple of nits on patches 2 and 5 as replies to those
patches.

For the series:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Tested on QEMU on top of -rc6: npVM and pVM boots in pKVM, npVM boots
with nVHE and VHE hosts, and vgic_irq and vgic_lpi_stress in all three
and with kvm-arm.mode=nested. My reproducer has vcpu 0 clear vcpu 1's
EnableLPIs while the LPI is in vcpu 1's LR: on -rc6 the LPI is still
pending on vcpu 1 afterwards, and with the series it isn't. With my
vgic-its v2 [1] on top, my MOVALL selftest and my shared LPI and DISCARD
reproducers pass, including with PROVE_LOCKING and with debug hooks
that force the DISCARD race.

Tested-by: Fuad Tabba <fuad.tabba@linux.dev>

v2 of "Fix LPI double mapping and DISCARD" [1] applies on top of this
series as it is. Would you take it as it is, or would you like me to
respin it?

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261013081646.933312-1-fuad.tabba@linux.dev/
