Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2C3BED2E;
	Wed, 18 Mar 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834238; cv=none; b=GpYa5w1xaOEj2kqGLG+VUfrEab/9pnq1JmSRGfE6KfDY//JoEer+n8AyWrfAxSRAogST1l4dim4uUrd7vqcOooNMZvJf13rPAPkF2WGxvMvqIpeayt6PV9aKkf3TOyOmxYTeEmi7BEfFBSXddc101fKeesZ09UjbC0sPXLaZnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834238; c=relaxed/simple;
	bh=PpcBch2bG46XeLREajv7IES6EqpC+cXWYQD0oYxZlo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OytXcwJhhgirTulAkz4zs0nUr1aSwb60QXjcKKLHFhonzEJ81yGjnG4SB4/k9S2vDPPuu5hhxyzmolUo+BEdSFSYrXnhqt4HJYe36PUgTCczDth0il+8zpaXZ4AqM1+WwPM8foTmBhuWoHkipzbucd4/xRQ3Q/dxoqzdi515U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=galcGDVE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="galcGDVE"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 319E840E0220;
	Wed, 18 Mar 2026 11:43:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TCJ4xmBq4fz3; Wed, 18 Mar 2026 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773834227; bh=g13qycu62PRbfxd6vUnJhc1IrpBmsGFIN1Tf1MYBtw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=galcGDVET6ZnSonSAkyRN6tSQe3oM4vdlMB/fAxqsELjQK6HChqE4CHQG9ykv+wlq
	 p/qEhOy26o/1xFRhOk+FKb5D3XUcjpAjatOrhb+EkmX9Z0cvbHL3SUq3pgEr/51s1o
	 WGIUo5aC2XKNqI5TcH+G3hUfzJ1qdAUrd9IeNhoPOejipDfNN6rWvztSAfblYH01FU
	 9FPEncTXl/QayQkhi0mW3nrk0tXCJ7khCYr1UqCTZhYYfJ7dWpbL5kFfWtrP2PISr9
	 w6P1B23vM9cZfeBvE5TravK4N+Pin5ePSFjYbe07bebHazMyMsOG5RcaoFH7XFcq2A
	 vFU+plPMgCkHQWUbNkzOdneorJ/Nxh4iErRlnHk7tAB/ksn4t5gZsGWjsoln2OcT7B
	 QVZm27V0y+e0C/ra54r7Eqg+YseYOEXbn5h4cX/M9L0rHoQIqzDoau8IurI2ZwvHH5
	 p+GfcfHgUcPsfWaKmDXhoPFQWuNfH6lNDXBdEf0ijbCf7teEMfGj6SrYoLgnw1x6Vg
	 zVl/tkh8pnQwcQ6jeB6UdcpGBl+yXhqJ6jTdjtX6/iiobL22h3suD/iWLclwsXB4TX
	 56cj0l4zPXxjTd3mw1hDwfJf9UYfEf4HNNu+LGVPaSyfIjm9yLqEf3ZqTLd0JxlrF5
	 cZ4cRNGLcO9fXFutDrFXFO2g=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9D80640E01B5;
	Wed, 18 Mar 2026 11:43:32 +0000 (UTC)
Date: Wed, 18 Mar 2026 12:43:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
	tglx@kernel.org, mingo@redhat.com, hpa@zytor.com, xin@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, x86@kernel.org,
	sohil.mehta@intel.com, chang.seok.bae@intel.com, jon.grimm@amd.com
Subject: Re: [PATCH v3 0/3] x86/fred: Fix SEV-ES/SNP guest boot failures
Message-ID: <20260318114326.GAabqP3gXCmlfpwfou@fat_crate.local>
References: <20260318075654.1792916-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318075654.1792916-1-nikunj@amd.com>

On Wed, Mar 18, 2026 at 07:56:51AM +0000, Nikunj A Dadhania wrote:
> Dave Hansen (1):
>   x86/cpu: Disable CR pinning during CPU bringup
> 
> Nikunj A Dadhania (2):
>   x86/cpu: Enable FSGSBASE early in cpu_init_exception_handling()
>   x86/fred: Fix early boot failures on SEV-ES/SNP guests
> 
>  arch/x86/coco/sev/noinstr.c  |  6 ++++++
>  arch/x86/entry/entry_fred.c  | 14 ++++++++++++
>  arch/x86/kernel/cpu/common.c | 41 +++++++++++++++++++++++++++---------
>  3 files changed, 51 insertions(+), 10 deletions(-)

Looks good so far in testing, I'll hammer on it some more and then queue it
later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
