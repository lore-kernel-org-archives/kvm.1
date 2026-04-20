Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277C24BBEE
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698570; cv=none; b=alKBkievIAcGAd+9oLuBz4eKl9m3iYMR6k9VdIMcgONtMajDBpG0osjQP63DiS4lwUVNcZZCk7yXI2KuVGYbatBdFyqIEJWbmXdQDOLw25OciIhqJ0On8qL2MV9dipAacfGGqCB5VG9PHvApnyIosAV0oTDN7fKzX5Ti1/g8Vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698570; c=relaxed/simple;
	bh=aap6XJ0o9GK8h6YbiZbmVzc3bbK8APITvNkx8V0wy4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DifP8bIui/wbVyDCR9SgenHPeGu9nCfdKrPbGqvnjpUFM6q0o6YXrOY7LBHIWmRECDgEKWvg+a1wGgNZCr+JNIw+FNi7v+MevZBTAeUcFwgr52lpXzY1pAaLWlJ1SsMtjQ5jEz8E8+lARgyhNK95RSn2PFOFavyGkoGASzI/1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYh/k53V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYh/k53V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810DCC2BCB6;
	Mon, 20 Apr 2026 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776698570;
	bh=aap6XJ0o9GK8h6YbiZbmVzc3bbK8APITvNkx8V0wy4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aYh/k53VWacy/lWe29dQYdXgF7WrsXjA2FpF3kYoJtHhaCQ2vcP5RU7aazNSoQVtA
	 xcmEIrmisIlPUtFsFs68qIewa2MmhEgHuA+HSFHcYAtIx4pt/AUeufcrighQlanVFx
	 0AVw3PCBzWYWSgrWYRU3KL7t42P1ij7BdsgcJkBOUrBx4gGWnC6qHxBcxp5zRWw9Po
	 BMFpedJCiqwoMccKT6EXHIhcmvEjV2GPtrVHx2NlLcadD879GAAJ8yIXQP+isjrOTz
	 +4NfV29YO5gODqO/FOL2qxxMG7e/MzhttDXzw+m2kX4MHC0NwfrV6fzV6RXlxY7uTU
	 4Xm6ZIxzDxRlw==
From: Thomas Gleixner <tglx@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "peterz@infradead.org"
 <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <87mryxekxy.ffs@tglx>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
Date: Mon, 20 Apr 2026 17:22:46 +0200
Message-ID: <87jyu1ejw9.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 20 2026 at 17:00, Thomas Gleixner wrote:
> On Thu, Apr 16 2026 at 20:50, Vishal L. Verma wrote:
> This code should never be reached with a rearm pending. Something else
> went wrong earlier. So while the patch "works" it papers over the
> underlying problem.

Peter just noticed that this should be fixed with

   1f5ffc672165 ("Fix mismerge of the arm64 / timer-core interrupt handling changes")

Thanks,

        tglx
