Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484763;
	b=vhisrV047fAF+i8C/Ly5PxTL6hlRZQZ9LhRN9U95YRPIwk9OgJyNvCho6MOP7ere30Qk
	 s9+rJHm8UAfIfuuKvQzGFXd4BFii1aBn2fhrFNPPjmziThBNH6HllDRfQcDK/aV6U1D/N
	 Al+STxLiRwFmCZFps2kco7LfBgrajHQ0jY/XFAOOG1xAuu+sX9/XpKn1i9mIJvxRIAVNO
	 +twNL+iP7Z7EDVPLPsjecggCJqCm4qsH8zA+ZJTKrtXmFwkPswGkr99AAst+wMGe5FeRp
	 CinA8TEb8yFooFAQKwFB+UHWRlHnhx28Ge+Ip3+LIQOKlgcUDq+LQjypluQDIp1BdVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484763;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dZfij8Ivbo850EMf4X4H6hd0rBMJmTn82NT+hkeDdK4=;
	b=HGvbbTa7YZ0/TqYXf50r5+dOcC7IeLV/OPE89UU3+42ZIXoYlsQiwGJPHFXtCr8dBRQH
	 uyYxGGq5x5Vd4oeMQWYx2dJa+qd8seWgaXslxEkh5IOY1Hb92ApofodJB3oQf14EyTLUU
	 yZ09vtPXBiHLr1yqcpfMzNipv9DuIPuFBGxHmsTqM1gZe9I6gTKuXnMHcZ6P06uBtR7aU
	 ATlWGnF/CZCHvWqrtBWR0DlWDu8ymsdOpim+pe9kQQ7eNDR6jJCd+wDv8IlgahRJ0HHnF
	 Y6tcpExEsMDcrpsbHoDxt7GM4sPTsZdbOdk8y4kPqx56hN9WlHk9RG9zaobEwZQniyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAvSJI8M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0B606A88D;
	Thu, 12 Nov 2026 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MAvSJI8M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B781F00A07;
	Thu, 12 Nov 2026 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484762;
	bh=dZfij8Ivbo850EMf4X4H6hd0rBMJmTn82NT+hkeDdK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MAvSJI8MfGsC2DOUgxr8BEjv8QyT+8eTHZkaoP5FeG2QN6roNxmILNLbq2muIIYjo
	 /WV8YzG/Z9o3Zx+i4Z2oozyDCHYux4cyQGf0SxIHcF50NbpNQoxnO3AVaujPQ+uHLT
	 XGPHv/bGL4+YuGrCxoKqdOtgmnwmk/0Zzyu8eryDiJ1Rlg1cqZQKjn0J70T12tLTWi
	 kZFxtFe10D7iKNA3hMLrM9/Kt5IBU06UMYWLCMd7eWlId78gmh9cQABgto+psYwiqr
	 NUju/SooCxdRaQFBywYvhH8jK1BF3WroSvoiWbBjXDdDCcFxVaUszd684k6yHAwVq7
	 BCXyobxr+QMWg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id C1DC71980047;
	Thu, 12 Nov 2026 06:59:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 06:59:20 -0500
X-ME-Sender: <xms:Fqr1ak272VecbDQ9jXtTulx7h_XDkAZmtiU0CMBbYHDNOuUpG6RBbQ>
    <xme:Fqr1aj_hSHkh6oQJRfNQSizQdRAssetUdHIDwfr6imPAGOQxWe2gimUxXdRTudzKf
    bv9fNJjmQjfd9VqmswesRwIbJeogZ2G3s0JFA1IU1Ae9V4mADoA4QE>
X-ME-Received: <xmr:Fqr1aqeSpr5g1iT1RwJTuEaiLMrBglpVP6AgFZUmqOA6502iRjKsWhnYz1A>
X-ME-Proxy-Cause: dmFkZTF5BU3WKP534phhHhe91k0ltQ4AEcFtiJEGzM5fvraOsxf/CFFg94zJJiqAvx4MC7
    5G0d3Vaycvut1/TS01R4AQCvQudUjPvHvi4ITQUT+gSumV4dJ+nWwtffp4zM2sG9Qakcft
    80LUcZHh3jlAZxiy/qC5wYiXInBRNL7m/cuH4S4+4+V2YtKKGAOr6Q4sN0HSRK5eQ4dKKy
    INqTBMLT/vJA9jJX8Ro3Ha1nGs6AXVWGfo7nkTyy/Kc0uJk9pP9dbjt7Vv4AOLipphcCDC
    1pmzDhBY8jYKgt5qyEDRApnHLss25fh9YXwGsPczHz4U4vMksNf+outF9GGsQ1KOhBByaX
    KM31tmmA9W6b4JBrVNb97UOplCZhktLk5GAkkhgV1Z5kUY7T9itjLDDdySdphyARbWROga
    ewYyvZBoNJEcRiEgrREihRMXzNCRB+5qn1wBpMh0fVznbU/DRh0kdqvrpYHFIO0azopj9B
    X7T5V5F9Ncz+S9Xt+41+jcu325mOjKKF+psye6uog27smL8fEXVziH3vXhZg/wqwS1UYeh
    lBBRWEzhYj0bJBdZdC6eDxqJKko8abBb+SeEvBA5uxCG1RLAZIUoeSsMM9O/MYpZacqcwL
    woltQmaAuM883WEOIYuDqD71i5r0/iriczau0iXd2kaIWlDJ7xasSnsFMLgA
X-ME-Proxy: <xmx:Fqr1av5KReVWErtPQqDZz-WjpMj7qvfHg5XxC5DOvWiNreGWeUN5sA>
    <xmx:Fqr1amN7UeLC9tHaGajH6oZA4PCQio60F4TKJEN9Z8DuJ9hkt_Aujg>
    <xmx:Fqr1ao7C-vh-q4ZkbQbez4QmdZwmM_4HhP3rVCMr-9cfnihobyrBag>
    <xmx:Fqr1alyqNRWqgZ5uOSd1Rehn44rX-y5A3LEPu6Y50g2v3Ac4tusM4A>
    <xmx:Fqr1agRClIUjlRp08CLhHiK3-DYcWmdHHVA4hkRJeY1sQVisguCEN-qd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 06:59:17 -0500 (EST)
Date: Thu, 12 Nov 2026 11:59:16 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/virt/tdx: remove kernel-doc syntax from comment
Message-ID: <avWp_b6x719N2_AA@thinkstation>
References: <20261111214540.681690-2-manuelebnerli@mailbox.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111214540.681690-2-manuelebnerli@mailbox.org>

On Wed, Nov 11, 2026 at 10:45:40PM +0100, Manuel Ebner wrote:
> Remove kernel-doc syntax form multiline comment, fixing:
>   $ ./scripts/kernel-doc --none arch/x86/virt/vmx/tdx/tdx.c
>   Warning: arch/x86/virt/vmx/tdx/tdx.c:123 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * Enable VMXON and then do one-time TDX module per-cpu initialization SEAMCALL
> 
> Fixes: 165e77353831 ("KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init")
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
