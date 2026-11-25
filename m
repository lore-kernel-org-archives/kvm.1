Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569555;
	b=nVc916p6G59DR3XD+YzR2rPsOXKPGXEUCZueBijV4M3XoYYVmQwD2ptRiw2G0S+UVD4s
	 N+N8uUAuxCEDyRGIPi8DVpHwW6KJSPoVAs9rFC0yjnlRNPv/DoxCPgaY/3iiM3bkNrtQa
	 8a+/zWvTcwPwrXOLyFxB0/Fhs1cI6yKKlNQDOqZVUUTGSYD8QpZjqsTz+LsVyg/YOPUcS
	 JFDWYxDtitI/yXabJ26EjsxYqSKMR09Wc+Ogc0Y7w0zz49STpCILNMLd1YbisNgVHX5SO
	 aarQkxjlRtMvEPfuWEBASliHTmpQYx03aJ/zAxQvKV2bPfwoLAJoZbW34e5OoSIR2cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569555;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=gIpH4uruVxyMdEa9YmClgpzrT9V2fo18Rh9Lq0ZVDEs=;
	b=P+4dj1qhMQEoYxEhzBhO1MSP/DoDClVVlwxlMF1b9qvLuyNTRjvu0mdpv0Cc6R7U8nev
	 CWdX74f5T+dKxlbQ2aSmfzVkgc+V+8jpKotVq3sn9NpzWyHuL2Gv2X2uA6Q5PvLIwenDn
	 0K0d+TrHF5e+lIJhkBWdFj/akDNi8PiPTZNlW+O83FrVWcHmrFvGzePUAyTtpjaEOR8w/
	 7LezGtVk2ICbZxbNpO4arEbBRZ29ZC381XLk6spBbj1vkhFbN0PsTqhyfHlD5Ype8zve3
	 bY6YtD6vKnFllOtHa66ZMIahoTjHw5roNbr9M0iRx1k8AtU14UVJnvYrTKdoxWk59SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A5606A326
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 167A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.240])
	by APP-03 (Coremail) with SMTP id rQCowABncJGENwZr0nO8AQ--.444S2;
	Wed, 25 Nov 2026 09:19:02 +0800 (CST)
Message-ID: <a9e29922b006ee2c5b89870f6730cc7ea6fcff48.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH v2 8/8] riscv: Add BRS SBI requirement
 tests
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com
Date: Wed, 25 Nov 2026 09:19:00 +0800
In-Reply-To: <awXH92cKFHKZKPFp@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
	 <20261105082035.133680-9-wangxiang@iscas.ac.cn> <awAxIHVLgbqTIYq5@orel>
	 <be563f376884fa46178aa4f78468aeb13272506f.camel@iscas.ac.cn>
	 <awXH92cKFHKZKPFp@orel>
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
X-CM-TRANSID:rQCowABncJGENwZr0nO8AQ--.444S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXFWDXF4DCF45tryrWr18Grg_yoWxWwc_uF
	W0yr18Cwsrt3Wjkan3tF4Svrn3KFs2g3W8ZrWUt39aqF45AF93CrsYg34Sy3ZxGr4kGFsF
	gr4Y939rCryjgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jrYFAUUUUU=
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-11-24=E4=BA=8C=E7=9A=84 18:24 +0100=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Tue, Nov 24, 2026 at 08:50:20PM +0800, Xiang W wrote:
> > >=20
> > > I've sent https://lore.kernel.org/all/20261120135613.1388647-1-andrew=
.jones@linux.dev/
> > > to avoid having to do all this DT parsing in the test code. Your next
> > > version should add a patch that adds the ACPI support for setting
> > > thread_info.imsic_addr and then this patch should use it.
> > >=20
> > Thanks for writing that helper.
> >=20
> > v3 will carry your DT patch and add the ACPI side. The BRS tests then=
=C2=A0
> > just read cpus[].imsic_addr.
>=20
> Let's rename imsic_addr to imsic_pa
OK

Thanks,
Xiang
>=20
> Thanks,
> drew

