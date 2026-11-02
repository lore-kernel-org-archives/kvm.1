Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602293;
	b=4kRd71Y3ut3ZGFAxxTfPop+py9fTUNj/O3xuLFBK5LdG01uGjFbis3nRIwLsCRymwlUk
	 EXp5M2U24tmkeetEY2z0hrHGqMhjKcv0ajDOlwCfMwpDiFsIEwbGdXmgIZkhCVpsneOww
	 pLpmXPrhgPEaj6nYfSpQfEAi9TVdbrk9NPN5upIKQMR5+voekChG8Y5nlIhdvY+gIwya3
	 E7q9WxFH0/GQBEQnwqf6E7WTTPIqvt46jsAXVqLBUYYsSzktPSDTaDgNuauB4HhVZcMFl
	 J7iBhgb65/GM7fzwcENsbrh6pFldS1dNiKq2WoO0tcv0sNqMIJF55bRIgZgr9Ib7DKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602293;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=ZZevhdRaCUZLV5SuEqAfvFvDHw+5jeMC9GpYafkUYlY=;
	b=AkX+XvlYOx0pwMbVfo4Ct8W+HiiEwozgAPRZrB+cwEUa8smMHe9/Q/MaJm8tcFo6U2Us
	 he9et4NI2dKPMe1NJ6LnKG5w1wvuJnEhREBGPXumGSmK8c+2XGZkWCudUC+kG+fCiasbR
	 ktVAkf07+BzB1KLB0nK/bK8oupH3Q3yyP1rcG77EWtI9LCmUKPZPuw7zFUhQvrZ6tawRG
	 +mtg70PlWs4gO2YqqzhAtZWuMrsiCQ0jy+DdGJMgVstX5B3sqpYiuFjojNfrw5W43wnPM
	 cXhI7M6BkbPccuMzSZXqb4xnD7UB1ldTXmSkWJJ1XY/BtzuUcNbt+wn4wn1oBibZB7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6D606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 06:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CA6D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.204])
	by APP-03 (Coremail) with SMTP id rQCowAA3R5jkMuhqxeIsAA--.45599S2;
	Mon, 02 Nov 2026 14:51:16 +0800 (CST)
Message-ID: <27862416b42dd8c13a0266700d361edcd97910e1.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH 0/7] riscv: ACPI boot and BRS-I SBI tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com, sunilvl@oss.qualcomm.com, tech-brs@lists.riscv.org
Date: Mon, 02 Nov 2026 14:51:16 +0800
In-Reply-To: <syzvrpkpdg5gjo4q6fgeypshwc33vzlzy3r6bvu5pqwm5iogl6@gewf5shwul3k>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
	 <syzvrpkpdg5gjo4q6fgeypshwc33vzlzy3r6bvu5pqwm5iogl6@gewf5shwul3k>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:rQCowAA3R5jkMuhqxeIsAA--.45599S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kKryrZr18Zw43uFyDJrb_yoW8uF18pa
	y8Ga1jkws3JF18Zws29w47ur1xuws5Ar43J3WrJ3y7Wrs0vF1IyrZ2qw4q9r4UWr4kW3yq
	v3ZIvFsYg3WUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xS
	Y4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyw
	ZcUUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 13:22 +0200=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
>=20
> Thanks for this series, Xiang. I'm glad to see kvm-unit-tests getting
> used. But please make sure you work with the RVI BRS community to ensure
> your work is aligned with their plans.
>=20
> Thanks,
> drew
>=20
Hi Drew,

Thanks for the review.

As requested, I have reached out to the RVI BRS community (tech-brs@lists.r=
iscv.org) to align this work. The mail I sent is included below (also
CC'ed on this reply):

---
Hi BRS TG,

I=E2=80=99m Xiang W from the OpenRuyi team (https://openruyi.cn/). We are w=
orking on promoting standardized server firmware for RISC-V and are
particularly interested in making BRS-I practical to implement and test.

As part of this effort we have been contributing BRS-I related tests in two=
 places:

1. FWTS (ACPI / SMBIOS)
   - https://github.com/fwts/fwts/pull/43
   - https://github.com/fwts/fwts/pull/47
   - https://github.com/fwts/fwts/pull/48

2. kvm-unit-tests (SBI requirements)
   - https://lore.kernel.org/kvm-riscv/20260924033945.176581-1-wangxiang@is=
cas.ac.cn/T/
   - (current branch: https://github.com/openRuyi-Project/kvm-unit-tests/tr=
ee/brs-i)

Andrew Jones reviewed the kvm-unit-tests series and asked us to make sure t=
he work is aligned with the RVI BRS community=E2=80=99s plans. That is the
main reason for this mail.

We would like to:

- Confirm that the direction we are taking (BRS-I ACPI/SMBIOS checks in fwt=
s + SBI requirement tests in kvm-unit-tests) matches the TG=E2=80=99s
expectations.
- Understand whether there is already planned or ongoing work on BRS-I test=
 coverage that we should coordinate with.
- Get guidance on the known discrepancy in OE_SBI_060_010 (brs_tests.adoc l=
ists Smcsrind + Smcdeleg, while the normative text only mentions the
S-mode extensions, and S-mode ISA strings do not normally contain M-mode ex=
tensions).

Any feedback on priorities, existing test plans, or preferred places to con=
tribute would be very helpful.

Thanks,
Xiang W
OpenRuyi / ISCAS
wangxiang@iscas.ac.cn
---

Please let me know if anything else is needed.

Thanks,
Xiang

