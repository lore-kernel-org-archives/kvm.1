Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030032;
	b=5PtANRVigaRV17W5YTh2ZU8UOZ8D44gjZqFen+1TlVeQ+fRNlgU5S+pWuD0eDapp01xI
	 u8bE5gqFOmfQ0VF/mIdGv8ax2GlfzyxErbfsVVbFZyzJFPASrNaoT+WH/NPtvzaWwZuNP
	 U5mSQSxVMkfZS9yioE2S8ysaiiu5zwrnciCZlJoYjzCywyLj3mMioYipPq0r9UheMdlo3
	 j35qPGIAAhvDRdjJ2dexxwXy5RnfvhmjfVQEZeQlS/z5Qx09ZQYXMt3PU/ioaE8drmdD0
	 wvZQNwvA2gBQOWZ3v3UdkIww0BD6otWW/8WqUjffncc0L+Par0WXBlluPeEVl2MpFUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030032;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=blX6pw/i6Lh2miqN/ThCCzDAkXlVW6VkbPCR4LHq7gY=;
	b=OD8y0WGXHXFkpzV4u7agwjkEKn2JjuA7DPvuI1WD2QTZWOC/UAviYqDjcSHhf5L9x5hi
	 vrS74RXn/WWjSpg1UI3Fp271Bge4EHl+ojtE/CIRyEwf2J8p+0Bhb24JS3ho6rcFhnMqr
	 TO+UISR5TGbPYQ9KYJB3fVXWVGkvBQGyOYWC7L5OBKd5VtF9O7VAb/hCd18od6jybERHZ
	 d4SmyIIt72AIA9BGmw7GGRdXijZobCZkMM4lo24vP+76iVu/dbrQeQSWNMX619IFscCWr
	 6Tjy/cegt6yShjYe6kl/7NVpTd+vPPdlmgeCbn/1QB9CbvlFGURyaE99nSAO2lrPsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gBANzwqV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GTe8VeMa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7657606A32C
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7657606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gBANzwqV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GTe8VeMa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793030030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=blX6pw/i6Lh2miqN/ThCCzDAkXlVW6VkbPCR4LHq7gY=;
	b=gBANzwqVbmo5e6fHVYLAPUpuALxFh7hnSO+SiIgLg7eCX/fnhANYq6pupWzJdksLQKvBgZ
	W3qMmG82IV9O3NYBmDCbil8bjrR84nyyD9rdWQ6MQrQ51QFDbRHFiYh+vB3c9RWQ6EF0eI
	1RYUrmyZw1/t0vYYf2JS9k5Kgn/cTmg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-in7N4qOAPKi9STXKn2STbQ-1; Mon, 26 Oct 2026 11:53:49 -0400
X-MC-Unique: in7N4qOAPKi9STXKn2STbQ-1
X-Mimecast-MFC-AGG-ID: in7N4qOAPKi9STXKn2STbQ_1793030028
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso19146685e9.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793030028; x=1793634828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blX6pw/i6Lh2miqN/ThCCzDAkXlVW6VkbPCR4LHq7gY=;
        b=GTe8VeMaO6pXs4/eYgkflnghxVCBbEhGY1+hupebPU2OOqypg1Tz20RAfrrYFQXYm6
         JgBVzKy5EksSDCwG2EKTmyPZjXgkWkNcavT2R5razmUT8u5Voob6slb95CY3Dfq5d48r
         V49oojHAG+8CZ03yVjcNFgb9mhjQatGzRnVnEXh/9AFfCBiJxYJHU3CyWeUx75th1zZM
         BCCwMdJeJmUA5qI1M13A2UU9yMyFlIMXK0YKN2TDKSu89wS8W0qkYCuY7CmGgv56p4uC
         ZeDluznbSPH6Ig1/0fCZh50mZAajaisCfswy2YgrwjQaljgguKPZX/X21hoSLYl/ilej
         nHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030028; x=1793634828;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blX6pw/i6Lh2miqN/ThCCzDAkXlVW6VkbPCR4LHq7gY=;
        b=o3LTW+cS/ugjRbPpt+pNH46PT7ThDcV6ODhBWZj8ZWYHjn18Fl2OyUEH83R+X89SzI
         aS2ejwLMRYW8OJ5q7eFk3PYeNT9R7Zjk9FmPGU9l8jrXiYPkHwAmaD9FW+ZKe+w/qOvH
         BW4CbEeVV67x555b6RaIXplOgHsUPZiVhy30B8QlrJhoQH+IUQA5fL0lsZtroBkPL5QP
         hfJGyCc2Be+9IzMdXdVPkJjHgTJjP3b5vps4i7cNFoHqsLqRpfbZ85ckezwuX52KMjrX
         kdoh5u1CFDiaPkxt4Y+JaT2lNhFpxTrXiUwiQKwuiqyqBxLeF2VPggmpp9t/PCdw7/Bd
         EH+Q==
X-Gm-Message-State: AFq9FYIywq+BIULSx5t3Sy42n5Q0IYFdPIhfTMDga4csaRtBJ/EnApA/
	puJa7rSCAmqKbpG2+NuA5kOgEHT1u/08vi43rbVuYn7rs8dpEtJy+vY5nDyEryVBLwwCrS0JQRR
	VZlNNjIYSEDFXeeEJsk4ycwnlVpR0xi+cFECFWtEjKQJn0w82xMc8iA==
X-Gm-Gg: AYBFou20gm4o+Mp4nJPmEbvmO2VPxHMKFqlmR5oZkopyNof3kx/p9qBMrD0doHxJUKa
	QnOQlWtkAN5DMX5XYFMwbkXIDD7u1LslFdY1G6fprgzfQTHPhQWQie9sQTG6pb5zr6TDUJCCXId
	qSTQeSk1XfXHHEoh6k78uvXmiP8TXTcoa1LZDoI9baxGnoXqhg+dY36mkbwCPekjOVUMqTybjpc
	EpX5Ll2it3WykMD3UUOBMqnviLQlBDxUG7fPtel7nMSMv9v3oUkVorMaRBOITbY/b7IEVRNoIKa
	26A69BdnzY+2Ughx0JpIGKm566qjU5IrVVEMbGSxqtnZIZAMHa9yT8tKh4iQJyIO+roZEdTJ
X-Received: by 2002:a05:600c:4e4b:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4a35aca5bd3mr122507535e9.16.1793030027794;
        Mon, 26 Oct 2026 08:53:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4a35aca5bd3mr122507265e9.16.1793030027380;
        Mon, 26 Oct 2026 08:53:47 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm17386387f8f.17.2026.10.26.08.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 08:53:45 -0700 (PDT)
Message-ID: <ae52ca61-b178-48bc-a456-27c6f3393b13@redhat.com>
Date: Mon, 26 Oct 2026 16:53:43 +0100
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
Subject: Re: [PATCH v9 6/7] target/arm: enable WFE sleeping for A-profile
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Hao Wu <wuhaotsh@google.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Pedro Barbuda
 <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
 <20260624103049.884930-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260624103049.884930-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/06/2026 12.30, Alex Bennée wrote:
> To enable full architectural behaviour for A-profile we need to do a
> number of things:
> 
>    - add support for the event stream to wake things up
>    - add support for potential trap on sleep
>    - handle the global monitor's interactions with WFE
>    - remove the M-profile specific gates
  Hi Alex,

this patch broke the test_arm_quanta_gsj test in 
tests/functional/arm/test_quanta_gsj.py. The test is not run by default, so 
nobody noticed. But if you run it like this:

  QEMU_TEST_ALLOW_SLOW=1 QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./run \
   ~/devel/qemu/tests/functional/arm/test_quanta_gsj.py

you'll notice that the test never finishes on the current master branch. 
When switching back to the commit before the "enable WFE" patch, the test 
works fine again and finishes within a minute or two here.

Could you please have a look when you've got some spare time?

  Thanks,
   Thomas

