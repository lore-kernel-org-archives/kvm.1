Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241FA187346
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786244544; cv=none; b=pXhodQbmDfxdtG0/siGewzUgettvTkp8gV2TrbLEBnmbniZ76rTUlvlN7jHpxZvqbAYqlHog6Fhf7W/XMhoNKtNZxRsd1+DLtjTIhrPNQrqN5bOinxYNJUzdfu4/jy8Nk1AY6eEUoaee+iyPNQaA5L11TSJ+buqRIFzbGZMbuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786244544; c=relaxed/simple;
	bh=lGHML3ZvY2f6CK/2iSJyW08rjbVp2u9wDBAZxjmje3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gikwvv+FbyNqWKm6pPpYmP72tJq7jMEX7rriOcS2b2K4smd3iD1jMOdUsePkE5Z7+C/LeTmiRuhUAdGfEbOI63e6DRwNRNsdR+EXqDF6YNYJM3C0u5UeU7gMBiCEFC9j0P3En1/N6uU56AT2a/RD6rqOipOTf6Vlddmxwk7/NDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxqML4HM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxqML4HM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786244538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGHML3ZvY2f6CK/2iSJyW08rjbVp2u9wDBAZxjmje3c=;
	b=SxqML4HM/jRm3e8707Tq9PYt8sgeNRtswHmY66MLTjPVRyZ/FnP13mBz0x0a3jNt+Zuz4f
	TP6VSGXP8dRbOa5cJyblUmnRg2fShYL8NUhV4D418GeFXN+cmuJtTkOt2592XmIeh26Dgq
	RSb4ZUhHTGFY9RCs2yFRlGJxRR9gmsg=
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Will Deacon <will@kernel.org>
Cc: kvm@vger.kernel.org,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [RFC PATCH 0/2] PCI bus/CPU address translation for MMIO
Date: Sun,  9 Aug 2026 11:02:12 +0800
Message-ID: <20260809030212.274097-1-jinyu.tang@linux.dev>
In-Reply-To: <alero77xVv6xrw6i@willie-the-truck>
References: <20260701142654.483659-1-tjytimi@163.com> <alero77xVv6xrw6i@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 15, 2026 at 04:47:47PM +0100, Will Deacon wrote:
> On Wed, Jul 01, 2026 at 10:26:52PM +0800, Jinyu Tang wrote:
> > This series adds PCI bus/CPU address translation hooks with an identity
> > default, then wires up RISC-V to exercise a non-identity PCI MMIO window
> > through a new --pci-mmio-cpu-base option.
>
> Why is that something a user would want to do?

I added it as a simple way to exercise a non-identity PCI host bridge
window without adding a new machine type.

The main case is for VFIO MMIO. PCI BAR values are bus addresses,
while KVM installs VFIO BAR mappings/traps at guest CPU physical
addresses. Linux appears to make the same distinction when probing BARs:
pcibios_bus_to_resource() converts the BAR bus address to the CPU
resource address before it is used. Some real systems also appear to have
such non-identity PCI host bridge windows, for example the PCIe host
described in arch/arm64/boot/dts/hisilicon/hi3660.dtsi.

I added the option in this RFC to help validate kvmtool with our
in-development platform model, but I can remove it in v2. I think
kvmtool can add the internal PCI bus/CPU translation for non-identity
PCI windows.

Thanks,
Jinyu
