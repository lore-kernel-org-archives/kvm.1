Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589C3D3315;
	Tue,  5 May 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011924; cv=none; b=dhq24n76znEICvesk6sknhHxc9kpk3TQzqBwuWmJP3gnRxfAYgiFePkwOe+bBHCqJEM8l+AjO8WqnRXiJ8ltf5CoC2AgizvL4Gfd9+8uJOLxPsdoCfaSb9ZmfoNwx0cSvq7QeXzP/YSlNgO9FLdPoXF/I9SkGhgD9+HcVSCZs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011924; c=relaxed/simple;
	bh=u1TNffjOTQScgQgHOm6HUq07Ara3K4AEvgtmk7ngCoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsZ+EMPQlYWrWoswlfyqnVwVFQoCHnukH6xiAJstIi5SvcZvThKhJE70swOZTAvKJDcg2MRpmZ75Qet/R6IbKb7gryIDS1kdDSsrfp81JSHVRlpj7LU5rmnr1vvq0eZytnGgiTFwaNSFfDgtLMPiMwZlOAxxullfcyc1sYoYpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0gCUNym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0gCUNym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4DC2BCB4;
	Tue,  5 May 2026 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778011923;
	bh=u1TNffjOTQScgQgHOm6HUq07Ara3K4AEvgtmk7ngCoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g0gCUNym1AaGUb74sYOFr37DzoB5h44Y35SreE4szEEYoIcTo2dFWjDRt/dLqC3zU
	 URdVZD3S5OaSDXpB8aYCFdc4z+PqEk1RPzoohiFu/IEcOt7sitjpZtf45omc8D5Nb+
	 NrW1tOns853utx4zov9xzmptqVX48wOFdV0+0kmYuj8L9HcUmHAQ15H2sUBK/bDbbp
	 AwfdWlR+F2w2SPrTsQWhmsGwFREqGlCMRst3DOfgUhREzKGC2b1yjK4AJJy8hQvmQ6
	 A/zwGtJ/y0DZWGFMAQ/11jvg790O6jAe5W0gYUrwlW68DSZGCIdx3fUf+tTGa+FNfp
	 ZI1QivfXfJQ9A==
From: Thomas Gleixner <tglx@kernel.org>
To: guoren@kernel.org, guoren@kernel.org
Cc: alex@ghiti.fr, anup@brainfault.org, aou@eecs.berkeley.edu,
 atish.patra@linux.dev, cp0613@linux.alibaba.com,
 fangyu.yu@linux.alibaba.com, gaohan@iscas.ac.cn, inochiama@gmail.com,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 me@ziyao.cc, palmer@dabbelt.com, pjw@kernel.org
Subject: Re: [PATCH V2 3/4] irqchip/riscv-imsic: Move nr_guest_files to
 per-HART local config
In-Reply-To: <20260425005916.3321811-4-guoren@kernel.org>
References: <20260425005916.3321811-1-guoren@kernel.org>
 <20260425005916.3321811-4-guoren@kernel.org>
Date: Tue, 05 May 2026 22:12:00 +0200
Message-ID: <87wlxhwr8v.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Apr 25 2026 at 00:59, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> With the recent KVM AIA per-HART HGEI conversion, the global
> nr_guest_files is no longer appropriate. Different HARTs in
> heterogeneous SoCs may have different numbers of guest interrupt
> files.
>
> Move `nr_guest_files` from `struct imsic_global_config` to
> `struct imsic_local_config`, and compute it per-CPU in
> imsic_setup_state() based on the actual MMIO guest file region size.
>
> Update the related comment to reflect that KVM now uses the
> per-HART value.
>
> This eliminates the last global assumption about guest files and
> completes the per-HART conversion series for RISC-V AIA/IMSIC.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

Assuming this goes through the risc-v tree:

Acked-by: Thomas Gleixner <tglx@kernel.org>
