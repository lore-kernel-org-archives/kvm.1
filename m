Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605383;
	b=CYpr0s0HOq1WpS2IggR5z17bV8iHQdrMvj9VcnwLcTxwgxpTA0vqWvHkhPhAmDebtbQH
	 IaPpASVaGgB6ibmKeR4YaxidWX8Zu0OLSwBS2wSXyRLS/YWM1x2APr7JUFWebN2IWLaw8
	 AziqOHJDGdv0Rsah4ha2Ce5LaUEtBzzDpc+u3ZDnk2V4uQ2l3F380yym9eUZ0rxf6fpwB
	 A1hN5AjjpMUHCTlWD+MrczeBqVXIg3mrU5qSMcBqaiBmTopdajyzxo31Qy8fzcVd6f4UH
	 pKovlJVwylnsDE+70naeEbueXzjkIjPePzYswGGuzxkfVCid0XOcVlSnQ8pH85FkcuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4iv8A6gqUfnNbo5/jmNa9lhvSF2xOy75Oyi24duA5IU=;
	b=2BJa0+kyHzQa7IeCJf/Y4V9leV/Pm2EkWmOlsJyihAPp7FBqywNwX+soS64f5sS6vuKX
	 87NVAknUE6BrvhqwrCtrr2CODDXPMOwf+SGTcvAOxneRGAAqS5RRL26F480ksIIL6UyKu
	 oAESrTGNlv4HDyP3DH467JhAFJ/n32i845xDxwUHylKht9GZ7nCp3f9ANA7aYrdG3NvEH
	 RZBlf8I/OOxuCVLd/y6cdE82oTlxEoXkIVvAoGbOuorxU6X/XWtVMT5kqekoNILM9xGGw
	 wvyhLYLhAAqqn7l7y+zWMVx/nCGLAuMo9Ga42Xuhc/3uNnOAggAYlV872eJu/4TFFYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j37pl6Kj;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D64606A332
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D64606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j37pl6Kj
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so6548811a12.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605381; x=1796210181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4iv8A6gqUfnNbo5/jmNa9lhvSF2xOy75Oyi24duA5IU=;
        b=j37pl6KjwtACM3h01DuxLsUzGaMNml3MpJwDyC9KUn2P6TnvVyWuvXILNk4Mdrs9Ic
         Sw7ql0AjRHvWqD4BGT/dQ6yO6eK4aQDXruaQDOXiCCF1cWkQ5Ht1dgf3aKfzA6AgVusi
         tx+0pAfwDQM3jST/uYWSyEAYSJopnXeCJL/0Y5HIfBYm85AchD2fLuDkr01+ZOWiQmkX
         BsKOhYxiqJNqbkczAu5rRkSUyoQyF7ukPTxlK34Enlo04fS42zEmWdDNS/dqR7IfY4ke
         lV4X84SzY13bA6oEX6pIri+WYFr22J11+ggTNaEm0j/G310b0dvAqsOpn9fjIVp0dKSf
         MfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605381; x=1796210181;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4iv8A6gqUfnNbo5/jmNa9lhvSF2xOy75Oyi24duA5IU=;
        b=J02nEqoIMTaagu23BcLUqEWLXshS8pc1E9/KhVn9y4mN29ntEZ59G0JEuBKT+X1jYY
         bodgeaoUlXnThmiMtvBjs9y97BU0CvEXhe0lcBMR6Md5OG3sVKSNv9p8IzILirLYCsxc
         AGUtBxJ9O3t1nsyOpjq8VxNUAzdmpTUFKf1Td+nnT35ji/w02/rZJnJiPQUAFy1oxsOm
         pRGyReENliSaBa2xCKrV6uBMo1Tao7XsHRs1OSBmHBDvlJ5ax9APKadtLNT0rjJqDSuC
         B834lpbbGGb+PWFhrzc/TGteElJWFz69ZNzKDPqUku7ZnF0PuoFwxLL815I36KSRQ8RN
         31sQ==
X-Forwarded-Encrypted: i=1; AL+hErHz1WVK9y4D0iMShZkDorzaAgc96suJ8HvvN9Y+pWAe5ivmQpTJ7NKgULNbtH4mC6QGDec=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TVUs2CBRZ3QxiMjjnABLJ2SOrpyrRYhHg5ABsYmCoxyUofmVy
	pTjeeIs7umFOtHO5c7sjtKc847OW4Z24tMqBp6BcBon5vP7jMdWe1j+T
X-Gm-Gg: AZFdTZfNqGxyjvvzRWyAR5t4sP6D8oj5/oRxTXqElr/i4GTulGCCAlbDslJGA2KTEwF
	MlNDVXjt3Gd9YLQLSaJ7bd5lbcq+upw6Da81TSVrTj2h25kpBJ4FscCXQ2pAexqSw4gF+/JuV1n
	gWr9yQ9kHd/lDc+luyw2x5QAaxrA5Q/+aIfABR3QoXuZcNUWhYPUXjxQg82ZWNULJLPGinhc7LT
	meeEsR7N2PoV+z5xMY6BqfoiSrsG5lIOJ3Wy+CBsHP3CWRJnns2GSHd/JSZHZp5d2uwv3A281y7
	SazLyhHIPTy8O3yrYwL7bh+hh3csVwdMeJf8XikGo2oN8d9OX37e7cHW+hDWcmDlAXm9imSeHOG
	ka/B1I61O5TGkxuK6finAW7C5hnZkbUczjq9nV8Z4isuQn1zWHAAStGSX+mw7sTXVKiMJvpvzDU
	5wWcvZFyF1ftOwkRxlX7Vn8e/GAGk0/dYGyEhyB48q0DQ1OQyprMkjQ7v0yOj8/Dotz05sdIbc3
	Mo60laydl+qAiS/2mrFN3ynRpHF3FV/03V1EvLFKMIPnt3j61xClCKqdb4IWM2Sqwd74WlOqGc/
	mVRW0zHLNBDnxSBlglyQrp5MUgeVd1Eiww==
X-Received: by 2002:aa7:d351:0:b0:6b4:86e1:cc67 with SMTP id 4fb4d7f45d1cf-6ba37ea0b91mr9087571a12.27.1795605380976;
        Wed, 25 Nov 2026 03:16:20 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba9b131d3bsm5256928a12.34.2026.11.25.03.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:16:20 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8e8fa5ae-f30a-4e38-8aa8-cd46e3b4ca31@xen.org>
Date: Wed, 25 Nov 2026 11:16:19 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/21] hw/i386/kvm/xen_evtchn: Fix off-by-one in
 do_remove_pci_vector()
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-9-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The empty-word optimisation advanced pirq by 64 on top of the loop
> increment, so the first PIRQ of the following word was never examined
> and could retain a stale device binding after the device was removed.
> 
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 3aff01b5d6c..d0807f5fece 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -1701,7 +1701,7 @@ static void do_remove_pci_vector(XenEvtchnState *s, PCIDevice *dev, int vector,
>            * and cache lines).
>            */
>           if (!(pirq & 63) && !(pirq_inuse_word(s, pirq))) {
> -            pirq += 64;
> +            pirq += 63;

I guess I'm missing a subtlety here, but the test only fires if pirq is 
a multiple of 64... so why is advancing to the next word by adding 64 
not correct?

>               continue;
>           }
>           if (except_pirq && pirq == except_pirq) {

