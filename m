Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821171;
	b=kK+hHG53OVntcpXSlIOSadIBinzCI9E8GTOqAPFh6lXEf3hz4SPtIMogzfr3lVr9/yUf
	 v2ixNWCNgaQ7vNYnfPKKunOk5kzBWSq9Srphl+DwMU4Pw5TvqmxTWAPMrwoRib9Nvhg4M
	 /fhu2nex0ErahtUMAqs629WkX14AnwBBscNLe5JNbWBOetdb9e0EK+r4rRfKh2Iz8zXaY
	 whoUTn+0KKdsWJjee7n52SuUvXZGWU5YzqpVi8wufxgWrkh3K2fIgmeLfQTdCox2JKkGa
	 v30tUeXWCMIC15BL0QoiF4mOJoVRalgrJZr9XXTLaP7RS937PR96fBco4RxMOG7jUwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821171;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=D7WbQXrrSrOg6sS9GtWj6hAsCJUVrDxUGniXvXJ1jxo=;
	b=Hg3HTEQEL8mcgWJ0nwxIGcJr2g/DaGtP4ri1FXB6R4PnOL5FPCtWBUuZFS0o2JtMWQH2
	 lmNkhIjFNbDIRI8ImUG9F4glzGBhBwoAomu6vEBUQ1rcmYdxjltQr65v2UpP2G/CP6dSR
	 aG8lKN0lS9f89PbmH28T6xUfydge6fJ9/Er7mSNMAdYLJhKtXcN03TxtRmVP83S5ZO2T1
	 hWSjDuDQe0tvHHGeW0xWPijuRwlYOJnSLga9/DOq/4dcRzuf3cR9vbqgiJzzJiMq5KipQ
	 0CsvV/acv5gGiGUe2ETRxsmlRLWTHIXaoLH52owEPU289TxTDCENEVjEsDKUDPTy2bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QCsziyi3;
	arc=none smtp.remote-ip=91.218.175.163
Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167360A383A
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 19:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5167360A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QCsziyi3
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=74ExVBB+ei6S46cEXVQqMO9R7/DDzZNlWMQikqnEM6k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793821168; v=1; x=1794425968;
 b=QCsziyi3VJRndH9QBC6nnErxG5RLVIfW+pvxkTcKkanB1Vdt6xbo/xEhSHp8CUdVEHjWrhj2
 N8QoP2CbXIdjt7J/LDoHtTlYzTKB1ZA/QHhb4580+DYSVk/lfc9e997QCFop+a9As82Fde3Yr5y
 XxLDTEWI66g+Sbyupqyb0KEk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6ff293ca35a908e0;
	Wed, 04 Nov 2026 19:39:28 +0000
X-Mizu-Trace-ID: 6ff293ca35a908e0
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be58ad9600so1378e87.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 11:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzbjQk2c8GIimqSjJ+4AY9rc+UxCIKXNJcm6HxCNXw7ogxKF9QKpVOXMXLyQlOjzUWYD08=@vger.kernel.org
X-Gm-Message-State: APuU4Z8u4yctwMOu3xdRPLFtKtk7y6Ax4uvOYgQ5wOZ6Yv0o7JGEcETb
	0czxUSqo/FK6FUL83QflqLzXSb6IbvBiJuiZynP/zXg6zZAfU2WWegMvDD0Sax4RQ2FNFmLzXmF
	b3iW8ErrpUvirqBjdloHZK+F/GKTV/RQv4Xz5JKCu
X-Received: by 2002:a05:6512:3dab:b0:5bf:ec8f:c361 with SMTP id
 2adb3069b0e04-5bff59a5dadmr217277e87.14.1793821166164; Wed, 04 Nov 2026
 11:39:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104084842.132944-1-fuad.tabba@linux.dev> <aus8xb_xT64WKHDu@e143914.arm.com>
In-Reply-To: <aus8xb_xT64WKHDu@e143914.arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 4 Nov 2026 19:38:49 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxkaNRhiq6mFFZTODfntk_e_o4gYGOGrjDd7Ehj4R9nYQ@mail.gmail.com>
X-Gm-Features: AclHuK8riSEhzUcDf-9TQZh3Kvvf2G4Bq4PoB9O0DW_xpYQYnA8l-TCApe4f2jc
Message-ID: <CA+EHjTxkaNRhiq6mFFZTODfntk_e_o4gYGOGrjDd7Ehj4R9nYQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] KVM: arm64: selftests: Tests for protected VMs
To: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Quentin Perret <qperret@google.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Joey,

Thanks for sharing this.

On Wed, 04 Nov 2026 14:10:45 +0000, Joey Gouly <joey.gouly@arm.com> wrote:
[...]
> For example I also added a 'pre-boot' stub, which looks like your
> pvm-entry.S:
>
>         https://gitlab.arm.com/linux-arm/linux-jg/-/commit/cd3ae35d89974b02b7051a0c45cc68b4df8f9d3e
>
> However I extracted the registers needed for the stub like this:
>
>         https://gitlab.arm.com/linux-arm/linux-jg/-/commit/f559d5b61fa1a37e2d7b23704bd367e079cf8eae
>
> This is because the current Realm branch I'm working on top of rejects
> writes to those system registers (TCR_EL1, CPACR_EL1 etc). Which is why
> I had to modify these functions, along with __aarch64_vcpu_add() and
> some others.

When EL2 boots a protected guest, it takes only PC and X0 from the
host, so pvm-entry.S reads the registers from a block that X0 points
to, rather than from X0-X7 like your stub. I think a block would work
for a realm too, since your test sets X0. The trampoline also sets
VBAR_EL1 and passes X0-X7 on to the guest code, for tests that install
exception handlers or take arguments.

The host side of pKVM accepts those register writes, so pkvm.c creates
the vCPUs with aarch64_vcpu_add() as for any VM and reads the
registers back, SP_EL1 and VBAR_EL1 included.

> I'm not sure how much there is to gain by sharing overall, but good to
> bring it up early!

Thanks again for raising it. I'd keep this series as it is for now.
When you post the realm tests, would it make sense for you to move the
trampoline and its boot-args block to neutral names and boot the realm
tests through them, with your register extraction in the same series?
Patch 2 is close to your "Allow VM types for arm64", but allows only
KVM_VM_TYPE_ARM_PROTECTED, so you'd only need to add the realm type to
that check.

Cheers,
/fuad
