Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB65A38644D
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202858; cv=pass; b=X+njQ8MvzzVfY5qqREDFfv5mb4x/JWflt3Z86n4azIOyW8Lhic+1rKl6IMBqbnsCjkWtAXhuGJgIljGbAj1uf9vYlZaBIW3UzAOPi/9nJ59IeiwrlliVSawWydLCuG/Lq1zlaA8PctkOBJSOukr4GG8HdklhvFCDmCdCl6dnzQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202858; c=relaxed/simple;
	bh=kbQceU69YI8zlRogIjlJ0Jefj/2QvndFBDUyO3J/F8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b87WAbg0p79DRq08fTMXbVQ1QEhKAsGIiOcKXAuhyqpMFd11tWq7jY84pSfzckYQpBkTWqNCp8NpW2RdZsbtbOywfrIvrTzYBY8VdklykuTDz18pnXSz9ynwyT3Cy6QyxSnbAjnWX/1+wWy4JtRWXra0YJK9ovNw48AUb056AI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+bz1mwC; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+bz1mwC"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a1e1817db6so52563336d6.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776202856; cv=none;
        d=google.com; s=arc-20240605;
        b=OAfYSE1E9FaoFC1f/pAw/jt6Pxq+4alXtHNz3NCgK1/2YxlMz80Jb4pXXkNmX/9nMy
         p0z3dXbxRRkpCbhNNjz1b7//Dh8JKMKom6JYNV5R3l8IL6efryOrAfxZwzIoteK8niKY
         8TLzQ9JXunQjsIRFwQ8PUrfkl59tBhBIRJQa6hepZpnl+FKPiym30P7xqdibdl5HkCxZ
         ibOHB8PC8ExLzCZymRM6duTm80T2dAZ7Lnpm2nLIJLk3DgK897uykq8O4zZrEvIEJcdn
         a74/avTDwJ+DElqIhw1l9hCmPHYknTH2UN/75hT6lXksQDlLA6S5avSraMBOsRxnzXRq
         VQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kbQceU69YI8zlRogIjlJ0Jefj/2QvndFBDUyO3J/F8k=;
        fh=t4wjTIcRo2x/La+yqZ14sHjG2lTsq49eV6sOT6MXGd4=;
        b=Cw1g3MYg9DVQPLWzRINB9V02BMYcpTsbbMt+IJ7k3mMyJnSY7wwggpGFQqWCOQX8iV
         AzeNtQAukwpQhmfEohSfX0CGIs5w1C2fSYOF06RA965ezgeWOGKXwiyDVw0QSPBanjse
         3ftFgO6Xvb64m94WV/ujd6x8s3jdx2ZRpD1yPf8rjU3Yh/bn4usjV73W2ZHlbKfunvTt
         /0XTObdqfmXvZ692wB4wKCkJXz897OcG0yrUHha2PbpoYvhoJ31A8jC5IPoyx3Evqhxw
         BJwRJCvWXtFV6mAaZjiSKE677/W/4YMNKDls6bDkkkEoSrEfZfO+RN038rIc9THsIZZ3
         xMGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776202856; x=1776807656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbQceU69YI8zlRogIjlJ0Jefj/2QvndFBDUyO3J/F8k=;
        b=A+bz1mwChXv+LUvb7Dv3hMxLJElpqZhxxEWBSJiap08pDjL3lYmWdhqqWKxbd0/Y84
         o/APzVRFnqPfrIX/mhrAdoxKNWLKw085CrZUW534BW/1EzTeInRkA5PGN1pYbT/dT1V/
         Onxw27s2HHt9BnhyUZYcfmbj9KpSJXAqhCkd87hD32kQu8lROKhkDY/hqqK5GmRNhYnP
         gU8UnmXHqZp8TBLxhrF4OqtXqg08VrH/d5175Vv8cm82zyIcapjQAZnj1EvWN8J9t5ZC
         3NjgoRU+Gd6XUjdaiQJ7olB1XwqbzbTviIuqLV5IDn36xgjLRp1eE7RRRuwwjfK1AbAM
         rLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202856; x=1776807656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbQceU69YI8zlRogIjlJ0Jefj/2QvndFBDUyO3J/F8k=;
        b=E5BGrREa/NY7h95I8q6+6A4zAPxcQEXMR80Em0RV/tGFm5CupL9GMiY7OFXhtC2XKK
         HSOeoh5uPEh9cmDc0tci/gp9D7660CdybFuGOMDk2msSIWi1lHX6cj/xyvVaE8uOEkl2
         ogfBoiOo27SvJ5mxOo1EVP61SgrzyEkZ7OTbKGAdLj6eOhrUJ6WH55Zbey+5H5rPQRn7
         /ZxEMt9Q+APiFMav/bnM2NzXnGJuemijMOD0hOLXzfep/angaXGWd95LuMe73awuaPH5
         7F7p6cDHSJ+5eFX2VkiR7K0YQj66UVa1apuvp4WhobJRHspbyAWkjvaxBI44E3dizCIL
         nTHg==
X-Gm-Message-State: AOJu0Yz2VX8StAEgkIgyr7kcdmf1Ewu/5oSQ3PIJH9ZGU++apmXeSRgU
	JRMBbCwai+AQRJGGZpIB7TicnBQClZuTgp40zPc7+imGGPOOMZRyRHVZSFlF7B5/wH5rXgTW5aD
	ORLlFmaj+HY73SI3Y7A3iXgGzvjqQnTMzNlEun0w1
X-Gm-Gg: AeBDievPYHtpG9u5pVcgaC3W4sTLjpVkPd3Y36f8yiGnOCRFYni8zwkEJkW2nt4IXw7
	pYNz3Uhx5RozCdx+I1o03kxy8+184jtwK5ULJTXsrb60gBqqZNuNX65GwyUPXAZz/c1eOyOegL8
	gdmgSYb37RLfIXP27vkyr8XcBqlhSlLzO5avkxk7v46dBHQ3zkjMh7eOSMlO9U31vNaFrmjGHQd
	UtkPgDfaas5NikeKFqRa+md0nvHEK67WvvqnuC2NYMaMGfKSWbVo/xUVWyTmlCQXd9w20rQxK5x
	YqTytWiJI8pKOVVf554lnt1GjyM=
X-Received: by 2002:a05:6214:c21:b0:8ac:7e8d:859b with SMTP id
 6a1803df08f44-8ac861b77f6mr303189226d6.16.1776202855012; Tue, 14 Apr 2026
 14:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318155413.793430-1-steven.price@arm.com>
In-Reply-To: <20260318155413.793430-1-steven.price@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Tue, 14 Apr 2026 14:40:43 -0700
X-Gm-Features: AQROBzAobYGs6qZALJkhuUvP32YWYfFdjJZKqlEWIdyyyT7N50O82BunKYW5J_Y
Message-ID: <CABpDEukEO4Y_fg8fv5Nr1_Pw_qOK=2UmioXk=WyPEzoEprPcGA@mail.gmail.com>
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 8:54=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> This series adds support for running protected VMs using KVM under the
> Arm Confidential Compute Architecture (CCA).
>
> New major version number! This now targets RMM v2.0-bet0[1]. And unlike
> for Linux this represents a significant change.
>
> RMM v2.0 brings with it the ability to configure the RMM to have the
> same page size as the host (so no more RMM_PAGE_SIZE and dealing with
> granules being different from host pages). It also introduces range
> based APIs for many operations which should be more efficient and
> simplifies the code in places.
>
> The handling of the GIC has changed, so the system registers are used to
> pass the GIC state rather than memory. This means fewer changes to the
> KVM code as it looks much like a normal VM in this respect.
>
> And of course the new uAPI introduced in the previous v12 posting is
> retained so that also remains simplified compared to earlier postings.
>
> The RMM support for v2.0 is still early and so this series includes a
> few hacks to ease the integration. Of note are that there are some RMM
> v1.0 SMCs added to paper over areas where the RMM implementation isn't
> quite ready for v2.0, and "SROs" (see below) are deferred to the final
> patch in the series.
>
> The PMU in RMM v2.0 requires more handling on the RMM-side (and
> therefore simplifies the implementation on Linux), but this isn't quite
> ready yet. The Linux side is implemented (but untested).
>
> PSCI still requires the VMM to provide the "target" REC for operations
> that affect another vCPU. This is likely to change in a future version
> of the specification. There's also a desire to force PSCI to be handled
> in the VMM for realm guests - this isn't implemented yet as I'm waiting
> for the dust to settle on the RMM interface first.
>
> Stateful RMI Operations
> -----------------------
>
> The RMM v2.0 spec brings a new concept of Stateful RMI Operations (SROs)
> which allow the RMM to complete an operation over several SMC calls and
> requesting/returning memory to the host. This has the benefit of
> allowing interrupts to be handled in the middle of an operation (by
> returning to the host to handle the interrupt without completing the
> operation) and enables the RMM to dynamically allocate memory for
> internal tracking purposes. One example of this is RMI_REC_CREATE no
> longer needs "auxiliary granules" provided upfront but can request the
> memory needed during the RMI_REC_CREATE operation.
>
> There are a fairly large number of operations that are defined as SROs
> in the specification, but current both Linux and RMM only have support
> for RMI_REC_CREATE and RMI_REC_DESTROY. There a number of TODOs/FIXMEs
> in the code where support is missing.
>
> Given the early stage support for this, the SRO handling is all confined
> to the final patch. This patch can be dropped to return to a pre-SRO
> state (albeit a mixture of RMM v1.0 and v2.0 APIs) for testing purposes.
>
> A future posting will reorder the series to move the generic SRO support
> to an early patch and will implement the proper support for this in all
> RMI SMCs.
>
> One aspect of SROs which is not yet well captured is that in some
> circumstances the Linux kernel will need to call an SRO call in a
> context where memory allocation is restricted (e.g. because a spinlock
> is held). In this case the intention is that the SRO will be cancelled,
> the spinlock dropped so the memory allocation can be completed, and then
> the SRO restarted (obviously after rechecking the state that the
> spinlock was protecting). For this reason the code stores the memory
> allocations within a struct rmi_sro_state object - see the final patch
> for more details.
>
> This series is based on v7.0-rc1. It is also available as a git
> repository:
>
> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v13
>
>

Hi Steven,

I have a question regarding host kexec and kdump scenarios, and
whether there is any plan to make them work in this initial series.

Intel TDX and AMD SEV-SNP both have a firmware shutdown command that
is invoked during the kexec or panic code paths to safely bypass
hardware memory protections and boot into the new kernel. As far as
I know, there is no similar global teardown command available for
the RMM.

What is the roadmap for supporting both general kexec and
more specifically kdump (panic) scenarios with CCA?

Thanks,
Alper
