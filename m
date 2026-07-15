Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AD392C32
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130473; cv=none; b=GoWKHvD0b9R23Nc6CuWLlGYyR224zbGAsLMWoJ1bdiErrEYKbPAoOOUJj15UrCnJjkZKwN8/XD1U1IRkcsn3uLDTRkhY49Zfl1kRQGvq84NMOE+2KU/goLpQxXLGv75WTNc1NmlKiI5pcgHIDIXdPN2YA8FMM5VmvR9WaY5Jiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130473; c=relaxed/simple;
	bh=/vHYl1kUal+AjTwaOme0WSizPI6J2ggmZxc5VKvR0AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfKGHkU46W10WNxjd8YUXJy/3AuFF4YaGM5xsUnkfo8+CCZgTpmxRFC9o2CvUpzHkpXuDDTfxt+YRof0NdY+XskBw3HE0F6oZGSYd+np+UqahxRuPtmbyVKdAvL+D1dJm8lEfbBr5YODULNt8mevxXfSIBXh/1aiz6ABV2poTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqFRVASb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqFRVASb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4301F000E9;
	Wed, 15 Jul 2026 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784130471;
	bh=F0FU3lNehG+4TnQoHX+uc37JhH7yhRS6evt0dkOoErA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AqFRVASb5Gu0NBapiDbDAMMEzRh8pR4sJV6sMAHXo+f9KXWVM6zk/0/4wkxqxAFPn
	 nAxzZBNSpYgU+LBRDGwMY3Yb2USieChlBzVZPQf+O9QirCozzpoExJi4xE2LsjY2dp
	 lrnkm+wybdRBs2F5TJPnyqYzmEXcwMAlWJhfXx/PDCy24VpcHzauiFaQPlQMvhz9TX
	 hvKaDcEJTQXCtxWb0KS9PR5g3gdadOeTZ4khdL3mLWVHpgcI3TVqT5jchfscfpoShm
	 ele+gywPTrado3SJPbFdS9NEao7QJhYSRw0aMRQvOR3y/X1UkrRfVHRietpeWeEa5J
	 kCfu1GugULPtQ==
Date: Wed, 15 Jul 2026 16:47:47 +0100
From: Will Deacon <will@kernel.org>
To: Jinyu Tang <tjytimi@163.com>
Cc: kvm@vger.kernel.org, Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [RFC PATCH 0/2] PCI bus/CPU address translation for MMIO
Message-ID: <alero77xVv6xrw6i@willie-the-truck>
References: <20260701142654.483659-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701142654.483659-1-tjytimi@163.com>

On Wed, Jul 01, 2026 at 10:26:52PM +0800, Jinyu Tang wrote:
> PCI BARs contain PCI bus addresses, while KVM MMIO exits and ioctls use
> CPU physical addresses.
> 
> kvmtool currently assumes that these two address spaces are identical.
> That is true for the existing default layouts, but it breaks once an
> architecture exposes a non-identity PCI MMIO window to the guest.
> 
> This series adds PCI bus/CPU address translation hooks with an identity
> default, then wires up RISC-V to exercise a non-identity PCI MMIO window
> through a new --pci-mmio-cpu-base option.

Why is that something a user would want to do?

Will
