Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4F3DD870;
	Wed,  8 Jul 2026 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495352; cv=none; b=qmMRXokDxppsMELl3gR7GLK65fLMipPvH1EnMmJigywWSQ7l6hlEJQnMXGPYEZSLNIB87x/2RVZ28b3TcYh/K/TlbaWTVqnF+4i8dOgF0fnWeZU13gx7IY7SZnfbBmahC5hls7c7u+1TArHpVv5lEVKlKbmRCWfq047yjgrc56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495352; c=relaxed/simple;
	bh=0sYbVskSjmCcx7cCy496GpXciPQg52CuM7SLw2/kyC4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P8K2S/5fKFZK473a0QsjHOOB4DVId5ajkzHjRcHBGl86uIDvf8iVHbbXZAHg2q64w7D2qU89UxuGdRRlaCmcuMNDDNCzMcmhXdDK+glZOam59GXeVo2qUuFd5UsfuoL253yM3Li2OUA3L0Yx7yR6+RZBsrx4akN2eRRlKti9hD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyhJAboT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyhJAboT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023DB1F000E9;
	Wed,  8 Jul 2026 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783495338;
	bh=nXrz1JhJYkK5xTRspbR1Vl1uzVDLKgTjni3ddD1l4bI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=nyhJAboTtmB+ho6GeJp/6cio7XVRXPa1T6M1RlCOTdimLwLY+xzrwBDvzXmPnsuq2
	 mv9kWcMCKFUT5hl7fbZz/yRoVLwoiDyfrPuvMYNNe457u1Qi8y4nrWWNh1hj+1HHf/
	 kMlRCkf16ojSdgwMWOmJnP/Xt4r6lAGeJyY+cwTgGtVksnL5xH2ahCVMK6ZK7kdvF7
	 sOO+nEwHzJ/CgmE5o5O4yWIOECzDqCWI9LPuaq2vQ/039UdRwdVTpQFjPt9z5e4/Gf
	 8L+rEg0VswcoNaRSrv3siM9TIOYteqCLPc7HQOwTZHDpYhIv6s5BweMF7b25+fy9vl
	 B76dTAN3GGf4Q==
Date: Wed, 8 Jul 2026 01:22:16 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Guodong Xu <docular.xu@gmail.com>
cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
    Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
    Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
    Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
    Chen Wang <chen.wang@linux.dev>, linux-doc@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
    Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
    Jesse Taube <jtaubepe@redhat.com>, 
    Charlie Jenkins <thecharlesjenkins@gmail.com>, 
    Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
    spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
    linux-kselftest@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 01/17] dt-bindings: riscv: sort multi-letter Z extensions
 alphanumerically
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-1-2c61f94a695a@gmail.com>
Message-ID: <a9f1aaa4-aca9-64fa-bf1c-100297a42d22@kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com> <20260701-rva23u64-hwprobe-v2-v5-1-2c61f94a695a@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Guodong Xu wrote:

> The multi-letter extension enum is documented as being sorted
> alphanumerically (see the "multi-letter extensions, sorted
> alphanumerically" comment), but several Z entries have drifted out of
> order.
> 
> Reorder the affected entries so the multi-letter Z list is sorted
> alphanumerically again.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Guodong Xu <docular.xu@gmail.com>

Thanks, will plan to send this for v7.2-rc.


- Paul
