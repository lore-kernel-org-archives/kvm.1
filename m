Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703963B6347
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644266; cv=none; b=iWEhz4knpoiBvtuKFN5XzbcaSgwkAwLAcRckgFcgqbmMZcLYJjflqa5uGCNv3JUSJT/RMt03y2YhYctLkZKGozMoBhVfTmmfv6tRtbNQI9eXzcKrC2WrFSH/uI33dIaTttf6IQweAwCYSj6jUMT4uJU+7CrfNpL3z2aULCt+X8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644266; c=relaxed/simple;
	bh=X1+FZtvAzOs4hMImpE8eH5iOjtUoEJlnx8bEvXZFpao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL5zYmHpXxwY29dbgl7ohq1UqZFX1KHNxb25AJbyD23JGQKYcLgi+O8gC3c4pEFLeAP5pOI7U5xn/eZZAtX2rFc90puyjRIhk0F6Ox2bdqnkqm7ps2JGi9DymFgcHUf5WV81Rp+/R4NTek5iraWqO8m1YWlxSLNIZZAlOk6TFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpGago/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpGago/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF7BC2BCB8
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644266;
	bh=X1+FZtvAzOs4hMImpE8eH5iOjtUoEJlnx8bEvXZFpao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpGago/LGoq8oL946aNZBR7RsK9XspwaPbD5sm8TqEgPDcsYrQVa1wIwtVfeaIGh6
	 GbEs9HeeiwxNIoK5XbjESwD51O1NnoUMEGqMrMun8DT3f6lneS2NVeBAKbpJOip328
	 AXo87JRLpOlX+u2wGOHrzFH5wS1KaqMqkYxFgtq9YwNbyGlnHcYzt+v86WlsiioCmT
	 MFCi+16zaQyfPKGZyAazHN5iYeTcFlQkxMXizdEn2kYblLmWkDaMoy6vmraUfFWMmr
	 8R1A8Hoq/riIFIf8eSlyJuG0jVPpU+qjabkJ0mKhb1p37VWDdjxabkFrRpQbgGd6gq
	 IUXk9SqZ/peRA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1039486866b.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 03:31:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmxWZ4en/XBZwUy55haTzOyN73kif85BTgELnRqmm2C2i0AJ20bA+VhX7FxtixxfraMZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzYJsoA9CyssrXGru22KezHKLOJbYaUmS/8TLTN1XMAHsuxm1u
	aq7XGtnb6h0h2abywusxf2aU7IsFzTDu98bAvsPsYPhh656VMoKMAQOiRNRVjFLd9pqiO33VS+q
	buG+C4DjpBf7UrTK1iB/caB0pi/Xt4rU=
X-Received: by 2002:a17:907:d90:b0:b99:6133:aceb with SMTP id
 a640c23a62f3a-b9c679ba5c7mr1158998666b.24.1775644264596; Wed, 08 Apr 2026
 03:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310092657.1023650-1-gaosong@loongson.cn>
In-Reply-To: <20260310092657.1023650-1-gaosong@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 Apr 2026 18:31:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7FuX6AE3TiC_O1ZEs=HRemDoZx9LOGC42q+6q8QF+8eA@mail.gmail.com>
X-Gm-Features: AQROBzCfMpmTBowf05uBQgICjdHd2MnhgM4dob8wI1FxPdi5421ZZ64s3CpiDc0
Message-ID: <CAAhV-H7FuX6AE3TiC_O1ZEs=HRemDoZx9LOGC42q+6q8QF+8eA@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: LoongArch: selftests: Add PMU test cases
To: Song Gao <gaosong@loongson.cn>
Cc: maobibo@loongson.cn, loongarch@lists.linux.dev, kernel@xen0n.name, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Mar 10, 2026 at 5:52=E2=80=AFPM Song Gao <gaosong@loongson.cn> wrot=
e:
>
> This series adds KVM selftests for the LoongArch Performance Monitoring U=
nit (PMU),
> covering basic event counting and overflow interrupt functionality.
>
> Thanks.
> Song Gao
>
> Song Gao (3):
>   KVM: LoongArch: selftests: Add cpucfg read/write helpers
>   KVM: LoongArch: selftests: Add basic PMU event counting test
>   KVM: LoongArch: selftests: Add PMU overflow interrupt test
>
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/include/loongarch/pmu.h     |  66 ++++++
>  .../kvm/include/loongarch/processor.h         |  15 ++
>  .../selftests/kvm/lib/loongarch/processor.c   |  14 +-
>  .../selftests/kvm/loongarch/guest_pmu_test.c  | 205 ++++++++++++++++++
>  5 files changed, 300 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/pmu.h
>  create mode 100644 tools/testing/selftests/kvm/loongarch/guest_pmu_test.=
c
>
> --
> 2.47.3
>
