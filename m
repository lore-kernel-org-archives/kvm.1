Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603817;
	b=3OksV92JTC3In9E9S+jLINNKu25vGyE1kQrORH6sJh+LVsnwNOAQPeQObww0Ti+S3joM
	 V/VFAib40t5Sct27Szrez8LubmevFQt9PqLcOL3otFsTKHaAP2bnv3oNijf9oxIJQK3Gk
	 CAmXHEfjaMc77zGQOW4TQF2WowFQ3TlqD03p0WNwd/FSYXg32Pl7IlzfF94JAYXRcboie
	 jsBBVLGXM7oQarYjfescD1H7az6BlheaTQOGiRC9lcgKeH3D+8BAj3fUUSqbQfIpnzzV4
	 /SNahVbumFhdCfnBlVJPMrTKIPpcEWHrqVHB/uvBRuejjZImbWPRaiU175sTEdKZ2og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603817;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=hQAIhPtDDRnNo+21Cl07c/W2dETbZdTLJB62ektwDDU=;
	b=wLg64uh44LZSfBQFhlEqmpNSBAt0gZ58xkClXTPurNRFi0+fk+xOOsHTycSto4SvLL5K
	 ORGXen2OkeGayMnRcreqU6XBz1bvF8I5J0V57WoAiV/unzQDKfiIet54wqcy642sQGPm8
	 JMFDQQIXA+dA2tly1cAzg/0o3qXAw0pUTmBT75ahWxU0UE5iUwlDTJbRJL+h5gqG+hpkX
	 v6aQ76fzh7F4Q+VAw+mkaF2GRzgI0g9XLS5065RFP2s9zD6cytZ8nG2oNYgwDoyNKKJ7T
	 nNShsCNdWPNmbvuaQaeXq11XrwhH4uyo/Zb4mdYLEY8bLdNjYJXIB6jlgdThhd1ORhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FF606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 07:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39FF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.204])
	by APP-03 (Coremail) with SMTP id rQCowACneZrgOOhquhktAA--.47405S2;
	Mon, 02 Nov 2026 15:16:48 +0800 (CST)
Message-ID: <c5719b029fe9f7159a37bf4d56c11bca8ef61ca9.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH 0/7] riscv: ACPI boot and BRS-I SBI tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com, sunilvl@oss.qualcomm.com
Date: Mon, 02 Nov 2026 15:16:48 +0800
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
X-CM-TRANSID:rQCowACneZrgOOhquhktAA--.47405S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7k0a2IF6w1UM7kC6x804xWl14x267AK
	xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
	A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
	6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAF
	wVW8CwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jo_M3UUUUU=
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
Hi Drew,

Thanks for the review.

As requested, I have reached out to the RVI BRS community.
The discussion is here:
https://github.com/riscv-non-isa/riscv-brs/issues/308

(Also sent to tech-brs@lists.riscv.org)

Please let me know if anything else is needed.

Thanks,
Xiang

