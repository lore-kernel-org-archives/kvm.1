Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D842882B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767995; cv=none; b=jM+rhH4XIjXyT4iZwas0uSLpF3W1VfFSUFMBh2PZg434L6r1gOzkXdSnv4DbcX17P0NnukpYU89/OsM1No7a4cWjNxoXZVmZT2TIroWSwLMgIMS7CBJ5+22/XoRD+3BiLpoQ5moW5j+zSd4BLdHNNYnvbrpsjmfbCBmbawihddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767995; c=relaxed/simple;
	bh=Fm5gGMCgIfeNDG/Bg80FSuuxecCyrNM0HlS/t4fTz2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af+7jzE6MEh5Fe17V7zcn62W/uCM541+yAxt/NSOfmHIzuEOfLZZY77SvkQ+c+F/KkZO4323kHA/QCR0j3rESh/WOu6awZEVTCA8UhRiHQtTGyHNwZG/VSxaZxYKEIxHSrrKVKp3fjJJRB1wWXjmMWJCOiIbnHusfQIOQx4MKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXTi5Uvu; arc=none smtp.client-ip=91.218.175.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXTi5Uvu"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fm5gGMCgIfeNDG/Bg80FSuuxecCyrNM0HlS/t4fTz2A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790767991; v=1; x=1791372791;
 b=SXTi5UvuV0WsY3MA4iUT5MfxTzTiXIXUp9SXjwZwzT7NO0kKNplkXAz6EdgZRVvGVx4NPYa+
 NJWXLjsv0WclYardy/7sQJbe1reAiMavhUjiwApTxj186oewokRsRwZT67nq62NrcXCqg7wTRGy
 VpRuHunnpKTeOSjkOASy7wyg=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 95fbaa6515cc444d;
	Wed, 30 Sep 2026 11:33:11 +0000
X-Mizu-Trace-ID: 95fbaa6515cc444d
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 13:33:10 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	opensbi@lists.infradead.org
Subject: Re: [kvm-unit-tests PATCH 2/2] riscv: dbtr: Add initial API corner
 case / error handling tests
Message-ID: <xpx2g5f6eadea73vbia7voxgwqj2snqyyftkcbs2sotre4b7z4@esewzeyddt5x>
References: <20260313050831.4016944-1-npiggin@gmail.com>
 <20260313050831.4016944-2-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313050831.4016944-2-npiggin@gmail.com>

On Fri, Mar 13, 2026 at 03:08:31PM +1000, Nicholas Piggin wrote:
> The SBI DBTR specification has quite detailed API requirements
> that are easy to get wrong. This implements the beginning of
> testing some corner cases, not with trigger behaviour but with
> API behaviour.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> These tests expose a bunch of major and minor errors in OpenSBI
> handling, for which I will post patches to the opensbi list. As
> well as possibly a bug in the SBI spec, reported here.
> 
> https://github.com/riscv-non-isa/riscv-sbi-doc/issues/257
> 
> Thanks,
> Nick
> ---
> ---
>  riscv/sbi-dbtr.c | 314 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 314 insertions(+)
>

Hi Nicholas,

Sorry I didn't pay attention to the OpenSBI and SBI spec work you've doing
related to these tests. Are the fixes in? Do these tests now match the
spec and the behavior of latest opensbi?

Thanks,
drew
