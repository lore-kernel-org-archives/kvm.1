Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024389;
	b=433VvQfpl9bz4SEHSjTYrArO5qVgP55aa/y4rM2E9RBq8YJSNOUducmN/8GP9cHIZSA6
	 vta4Do7GN08YKKevU+uBrMTDlrIDMatcgnq0JY5mOsxFaEXVL4Oa941KtLU3bK7AjxI6x
	 sOlMUxChlSn7IYxZNbzkJ40RQlkmJRubqoVUIfAZ6HW7XUCQtZd5YJaiKfaR9gs0VU15a
	 cv5oN6SpZ/nKYrE68RLoQLhmJ+9OEv6CrU/A8O1dI7Hz69uy0lKF8kvnbD6yPzyKHbnaJ
	 j9o9m1vQiK0axKWAaRd/AqNj4kGoDi8bhs4GVEMam93109zRrLK/qFxv3ALv/PP5mcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024389;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mIvlMhQp2XPMKkyqstwBRddoJIhsg5ZvouNFjygJYDk=;
	b=Wph9KBHnPlR+IOL/0Fw1bzKWubCTInFZUPNsNCqJ0YRs/YR3wFYGapd8xw/bVPR6ZIOe
	 VWirtq211OtlqSLuwx8UDhvOimkqeDoxuCggV3mNhlA1B2/hwfO/VzmFFv2HWUu6yFCTp
	 9NDhzmmR9Gplj3LW7tR6kiD79wCUooTcgvpDuzZIJU+pWvcXsEDTRAchzaVCGEe7IbrqP
	 tbS21LQUDLyjCv8PvZBlC/HChSk7n1YlXqGo6Jw8C6QziVqHHGx1kXiu4sf1EJg+j3not
	 HwrC/qY7v44HRndTfLAgKMVDjYXsS1Ucaa+69XSuaSrzwSeDFsySheDV2ER35rDiFQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kKrkgOt9;
	arc=none smtp.remote-ip=95.215.58.54
Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D8606A332
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E4D8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kKrkgOt9
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+m7k99GokHGG2Xt0WNDUpUu/POJp/u8hXMkzLb7HkPI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795024385; v=1; x=1795629185;
 b=kKrkgOt9Z0+Uxd0OLSeRAMXHHLAwszcLDUbKbF12OkJtRBtdtWKPCEIzYjNBS/HTPbsasfAS
 uB5YRPSbid1q4JNdkyBI3GN/ci90xJ1VOlf8DjQgJu1KHxicG+32bBCr18ovse2tMz48PwuBhzD
 9MA0algsT312UDIoJhrsXcmk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55e39e18abac30ad;
	Wed, 18 Nov 2026 17:53:05 +0000
X-Mizu-Trace-ID: 55e39e18abac30ad
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 18:52:30 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, 
	Chinmay Rath <rathc@linux.ibm.com>, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] Move position-independant code flags into
 the target specific Makefiles
Message-ID: <av3l0ZC64ouIp4KN@orel>
References: <20261113120101.145183-1-thuth@redhat.com>
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
In-Reply-To: <20261113120101.145183-1-thuth@redhat.com>

On Fri, Nov 13, 2026 at 01:01:01PM +0100, Thomas Huth wrote:
> The settings for position-independant code are currently quite a mess:
> It depends on the target whether we need the flags or rather should even
> disable PIC / PIE, but currently the settings are spread between the
> main Makefile (-fno-pic is the default, unless CONFIG_EFI has been set)
> and the target specific Makefiles.
> This leads to some weird situations where we have -fno-pic in the CFLAGS,
> but link with -pie in the LDFLAGS since we still want to get a relocation
> table, but then again need to add a "-z notext" to the linker flags to
> avoid warnings about relocation entries in the text segment.
> Let's face it: Always adding -fno-pic / -no-pie in the main Makefile is
> a bad idea. Move the settings to the target specific Makefiles instead
> where we know what we really want, and then we can finally drop the
> "-z notext" settings, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile            | 6 +-----
>  arm/Makefile.arm    | 2 ++
>  arm/Makefile.arm64  | 3 +--
>  powerpc/Makefile    | 5 ++++-
>  riscv/Makefile      | 1 +
>  s390x/Makefile      | 3 +++
>  x86/Makefile.common | 5 +++++
>  7 files changed, 17 insertions(+), 8 deletions(-)
>

Acked-by: Andrew Jones <andrew.jones@linux.dev>
