Received: from smtpout2.mo536.mail-out.ovh.net (smtpout2.mo536.mail-out.ovh.net [51.210.91.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9A3B2FF9
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883638; cv=none; b=bTJ+itXdkfAHMhyUeRnPXn2z1jIkFA8IUA9uPEzPXh5unr8mKs7g/j71x6T5/RGMrJWmzcMs8ohxE0ziPiHdqhX5NSJQWogY9b+YULJ11CBA/ulzZv6zI+DQXT66qMdSBWnuqWNEiegUYbSC7AMeFXZp5nd52yN84QmS62VwIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883638; c=relaxed/simple;
	bh=dw4Gj3l0PolgAQc9zwe8boYeweP6AQJpodZT1X1TUCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXsr7BOISsVACyRJWc5vN/l4ZwqSRRzUfDR+osU6SApAZOFk1+5cqt4dxUUTLjFgdyGI1Qudu4dFmSRHaTc9vLGFLiF81CTggI4ioWPLmbfreg3BTvqTYJH0GFdIxKSWngiSO69wbkMaK28hTwNnyeC69poDoeaYd+ltwB0Q7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org; spf=pass smtp.mailfrom=kaod.org; dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b=gvlPyTmu; arc=none smtp.client-ip=51.210.91.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaod.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaod.org header.i=@kaod.org header.b="gvlPyTmu"
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4ghhFz2Zwlz81F7;
	Fri, 19 Jun 2026 15:24:06 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <jamin_lin@aspeedtech.com>; Fri, 19 Jun 2026 15:24:06 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.15])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ghhFy4z7Zz1xt2;
	Fri, 19 Jun 2026 15:24:06 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
	(Authenticated sender: clg@kaod.org)
	by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 7EAF312E36BA;
	Fri, 19 Jun 2026 15:24:04 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-110S0042df0b5fe-b46f-49f0-99f5-86917569cd8f,
                    D397870345096954499ACCBEFDDC37B3E918B293) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <43d140b8-e918-4c37-81ac-d05954465acf@kaod.org>
Date: Fri, 19 Jun 2026 17:24:03 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] tests/functional: update anacapa-bmc image
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Tyrone Ting <kfting@nuvoton.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
 <20260619130537.820184-3-alex.bennee@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260619130537.820184-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6851663883618397219
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF2D7aMXawZVblEoufsl8EnVwMgr593UsRimnKU1QcSQPn5QaPfxVEl5uYEE5o5keoogHD+8U2kHM5vUlw2AjO8zInK1HbbygPAYaFezKosfCMoS/xYypGiG8rWc0byi/0idnHKr1QIYXHAW40FMz/jt+N6OesYP2gjcOYGCPioB/lJEmO+0UmeZ2GnQUktKKAUFgeRTWqPi2+ZzGhflDS8EM84Qdh6Esq7ne/POLyKeYxW9ZoZSDLlRV8A63gstKL9cbTSVahLOXKvFTQV1J+Y7TZcXK4euLO1wCmLydIM5AchIm+hRSQL3XRgOdqxXt5xxS3KT1qJbtp7LrxJMBDakNMX/GwVwF33HUAUR/p7DrBNhUleRhEicXJ1f5o5W8u0IzcqDx6NahgnVg6cKj6QRlnMrmC0xu2yeQfpGuKKAS9cl3dt1rrbI7DArhqbUolQ+DcWGX8lbrqpetjuhnQOofIh7ToU6yf9ROnPvva/2fQbL62PinCrmi9GKqtna4R0OrjkXbODhbhtPFlH4xsHyKuj69V8yEJrvST4yKr9N4erXV27DenIZfqXjdA5a/La9Z26aNwTUyuCMn+Y/oWoNUOXUhG2TXFw13tnuGoKfdLBQp3rf5lFaqdKZS5pvcxQkIe03gQOc6YPyXzvsTsPHGGIkFPYPX5pjLNI+u8qdQ
DKIM-Signature: a=rsa-sha256; bh=CQC2yNnLs/sIVJK9rDuDX5qxfVgsLKbpiqkvaiGrCA4=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1781882649; v=1;
 b=gvlPyTmugJKKNtuh69KwrAaulcGdf4WKWoPJYCsOJbQ42XTezBxl3QEnEPOfI4w6eQ1IBFw0
 2DZFrKeQr53FFGO0/nTeqL4io0Nibv1FgP0siUAG52TeIKh4843muqUyqu+jPQYVDtrDi5qPF2q
 tDdSkweHArtiV6shY62CcGqLEnl+BlVmuZ6nS1p2KCGR1tP+PuV7JDJbrB1Bb4oqrr0Rpg+2SD8
 Kxg3TqZKuE7Ar0hJfkj4RU9aXIVVJN3YopeGDoZdyoSSHnkC8JJCXNtpTV3QZ3ueHBapsYC/KIe
 l4bG9LFk2F4t4iFY3P9RQ/4HsYhoxaVK1e4KYuDThxg9w==

On 6/19/26 15:05, Alex Bennée wrote:
> The initial version had the wrong DTB which caused issues with image
> corruption [1]. Update to the latest version.
> 
> [1] https://github.com/legoater/qemu-aspeed-boot/pull/7
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/arm/test_aspeed_anacapa.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
> index 27f8bd8b56a..b16c6035c95 100644
> --- a/tests/functional/arm/test_aspeed_anacapa.py
> +++ b/tests/functional/arm/test_aspeed_anacapa.py
> @@ -11,8 +11,8 @@
>   class AnacapaMachine(FacebookAspeedTest):
>   
>       ASSET_ANACAPA_FLASH = Asset(
> -        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
> -        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
> +        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
>   
>       def test_arm_ast2600_anacapa_openbmc(self):
>           image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

