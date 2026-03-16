Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673F37BE9F;
	Mon, 16 Mar 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653030; cv=none; b=Wocnt3x/kMu4/mOiUTsjF0oS6PoRJmJfkdBYqNMBIq/1ewjQfi1SdF4XxMisZkifa3njBmF9R5WdmpuHFqWPk/JAAjAUShxjSlxf050b71Mx4XSD4cxI8veovf5BbOUOoWtypJxRhE9T2uHWr6qwMJeK5SvK1Hg3I3X0IY4qpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653030; c=relaxed/simple;
	bh=+0OEHa4rIQo8D1puto8cfTie5ro4CDGOOBfYOvM/juw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pxej1QIvqCAAzbUBZrPusawLZvUOVV7wj7K/oY7scJUEYfLEwd18xZIxuYLtxZXgGL4RPCuPMVqkjgtPcDjP+HcGHBS3VPsujcxsTK5f06vJsig1l5GiIaz178s0acPN1PvMU0x9IeKKke0EHTWAxrmN1fnKoPbkkn++Jon34HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W3V8Vs9y; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W3V8Vs9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773653020; x=1774257820; i=markus.elfring@web.de;
	bh=+0OEHa4rIQo8D1puto8cfTie5ro4CDGOOBfYOvM/juw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W3V8Vs9yPUVx/Kds51y6HxzvLjxiz7R9n5yb79zix2ElfcgyPpc2VP4Y8xF3qxmb
	 FpZnR8hFEFD7Oo8T6bnMLCXXjSw6fEuLtWZYYWMHWJs0LfrAxFlmnjTA1MgzC7Rql
	 ou1ykiI3UGO2dKbxHEFzGIPgN0dwS5ahAaquU2+TG5poLTAWOpydGFLfRiRAynw7v
	 mNrWljcEiUvR2DHi72pdaFRpxX344UBD0XPK7UEd1hhSjH13ZLzDhpH0N2vv0ldMi
	 mtooYTG3tk8u/Q+X/T9pLMtbLOM1p35GSQ9yPNzK25zy3Ks9rv7R5q+BxpiO59h7y
	 aOWSpVCOnUIvjYfUFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1vxgS41d20-009fEu; Mon, 16
 Mar 2026 10:23:40 +0100
Message-ID: <19cdcafd-adab-469d-9729-f01e8bcaf543@web.de>
Date: Mon, 16 Mar 2026 10:23:27 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 kvm@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260314223144.154349-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] riscv: kvm: fix vector context allocation leak
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260314223144.154349-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9N87wlNrARLrv06H28B4CZ6O5Leb2WuGg06c0xJwdma+eJulo3f
 HEU2YIeyuoHR3SItVRPZHrX9pryDLT2L9eQFsNKu+lZHT0k4oZLBPx/ed6W3P95jxld/p+f
 2ZQXUNktPCRLeHThNqDLZul/VbVdfkWGxa5dVeTQ7z2sYFfLzgACrj3fljck/Pqr6cve4Ot
 6cLikWdQ/YcwWQawJE37w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sSDZyCtp5iY=;tBMDzrgZF0RqW2XERGbLoAByoqY
 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
 7CYOvK9u/cMcqr/+6JNE

> When the second kzalloc (host_context.vector.datap) fails in
> kvm_riscv_vcpu_alloc_vector_context, the first allocation
> (guest_context.vector.datap) is leaked. Free it before returning.

Were any source code analysis tools involved here?


How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0-rc4#n145

Regards,
Markus
