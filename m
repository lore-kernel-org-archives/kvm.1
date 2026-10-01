Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94230369D72;
	Thu,  1 Oct 2026 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790823742; cv=none; b=kin6KBnFX8X+IWfx8mz6YrELvgY4hO8CCLyKN/YeET7FDEn7ZmFEOEIpLrubyWgW2kCVnk17ThyilwOw8avKiiwF0wIW/K2+71CilHWNAwN/CR3ksfqFCxOE39pvS8LVT7wqev7b8ZBePYyJEbC0SAhxw7s/WFl9BLa36XFFYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790823742; c=relaxed/simple;
	bh=p7yLThUetmC1jxA3gLI7OCu+41AjTasrTwLqKS+rhiw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QWAXnM6d1nKdzxocPGS7RAdXVrYydwjWxhnBil+xzqZElU2XmurPvGc2PRdA2kCA9sjMNQIJflT5DiYK0dDf2FsNRnUKUlZqRNv0X18jNyt8YTHluFJHfcH2xGAO9x0mLTFe0xTGcJ2759oo/sZZy4T+E7GDnVV1j/LMfEDFaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6AEfScX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6AEfScX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1291F000FF;
	Thu,  1 Oct 2026 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790823741;
	bh=ESWOgs8pthL4jmbP6/5JXBqu6W3vx75aJI4JxJVxXSs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=R6AEfScXRENdXKHujYsvSw3LlfeLTXBYuicWRQquboXNP+FZy7yZuMNEkbGSkqX66
	 mI8wLVbX04wVCmIcG+mvgiVrvk5VSG7VIG4tVnkX7tfnCEt5kPEw4H8mvn6hFO64l0
	 bAqB/oLjNMhYXHGrkMy3ddePs1ynWeccpeHtOTavExBBiDSlmiUYZILjWV/o2C4BRf
	 XPoVhTelNYsSJh5/lluiUXssDVK9UEL8DzInBsHwiobgQVauUwGiGZJ4KQIoIzFYq0
	 uDlPfPOVNIKzG8cJEOxmtnRQ51tpyY+Jz86BWzKeydMvWPDS+EohKcYOKxJfGHq3go
	 a5D9SPkUpLCSg==
Date: Wed, 30 Sep 2026 21:02:16 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
    kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] RISC-V: Clear HSTATUS.HU on CPU initialization
In-Reply-To: <20260924-hstatus_hu-v2-1-7e970f5f1d8d@sifive.com>
Message-ID: <9e3dd333-2747-45dd-6880-2b83a3778f66@kernel.org>
References: <20260924-hstatus_hu-v2-1-7e970f5f1d8d@sifive.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Sep 2026, Yong-Xuan Wang wrote:

> The RISC-V privileged specification does not mandate HSTATUS reset
> values, leaving the HU bit potentially set after hardware reset.
> When HU=1, hypervisor instructions (HLV/HLVX/HSV) can execute in
> U-mode to access guest memory, which may cause unintended behavior
> if not explicitly controlled.
> 
> Clear HSTATUS.HU during CPU initialization to ensure hypervisor
> instructions are only available in HS-mode, preventing unexpected
> guest memory access from U-mode code.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

Thanks, queued for v7.3-rc.


- Paul
