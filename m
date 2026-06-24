Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B223815B
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301667; cv=none; b=tT8h1R0gj9ahTMECtDLmCiYyRr/maRZ3eY3l1pLMhgvWtRzmrkXsr3u51dWmqGwSwgzxKulF9OeaZt7A+sgjuvT0tgs32EcVOM4j2PWg22weTcaLdFJdOQZTCzidtb96p9xQGjuTHAtqRt/vukitb/DeSFp8hnygfZPVuNscANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301667; c=relaxed/simple;
	bh=BGCBXkHKEnfsTjJjm78XxY3PuTRzGOL8MYroaDGSFz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faQkfzfyZLPy5Esm4Iv2a4C3ewmnF62RdC+VBp6CPqaYxiBUnauptrkrxVQ9wlFYZPe2heYQkX601lser0RAkL7adkAvojezQgN+DNOKm/QlB3NSF8+99F2tKLqRA+Iupq8sTSNiOS3a4XahlcxbwijqEvJLWchJInp6GIUV+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKf/dXKp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqzEGw7o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKf/dXKp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqzEGw7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782301665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FjsZjcaZpayI6vxjl0RKgUm8NlROnQ94/WmvUMIkQ5M=;
	b=SKf/dXKpxHHvSPTeT7CKfn72BvK6aS4pqt3rgAj+Ws92On7KYijqJ6CnHrwO3CR6+ozlUF
	/d37eco6XZSotnH2GWsi9N3M5q3exe4S9sHTokbKNQ0CWaSSkT4kYKDOo0Ne68tOtcZ9pw
	VKHi0c4IkNISQKnSn8u/dmoW5NX/DQY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-ajnFr2EnOsyRlzAtyuzfBQ-1; Wed, 24 Jun 2026 07:47:44 -0400
X-MC-Unique: ajnFr2EnOsyRlzAtyuzfBQ-1
X-Mimecast-MFC-AGG-ID: ajnFr2EnOsyRlzAtyuzfBQ_1782301663
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef616db45so778592f8f.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782301663; x=1782906463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FjsZjcaZpayI6vxjl0RKgUm8NlROnQ94/WmvUMIkQ5M=;
        b=aqzEGw7opIRG5AOoGjYFMZFHwlr9Jx1wEH49fIHOtcLuewrm46TN1aSdbMgYowIghz
         Dbb0kKJBp4rgfT5R1xAUIZ9Y8EiFQsU92zr4KMdbTzWPRm99HmoHeSu5aKDf8OZ1XIIq
         50j5eQU+F8NlDGsUQIOfOkRC6n7/zbB1UWDxr+aZkhmRxd01AIta/hNUxuFBM2QYg2AI
         dSeYWLLfyj++k58fo13cJpX2qPPaXO3xub+h9x5Peim1HXPl2/79MZIqPWEctFmPpGhg
         Tz8hPySSHXUNRs23dRiEyFJs/NSYF/F9NLQaeLnw+cY5AIWTqxwN77tfZ8hzbL/NlMXY
         bV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782301663; x=1782906463;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjsZjcaZpayI6vxjl0RKgUm8NlROnQ94/WmvUMIkQ5M=;
        b=OSm3qskRcfsRUjcbeXiHtamime/Ba9G4plnz/qCnhcNBhmh6LWiZ8OgaDAbBvWpNPP
         X+Ra+V4Pkt+dfYwUQrBLF7q9r2IKHKqDKvKTK3MfTDtORn/79fyrKeR5wNC9/8T6PoPQ
         f/+BrPBEZReyRQ3ied+O2R0pt/4BzIIGajmxebW7auBKLvQVjQ4LF4vlNqFptnHYpfvO
         LBsAIaFGPGLt1FV0fxvBVBd/M228nVJdP3tdsG4c4BlUfmYzAZMBaqQaATrURHBSuIaw
         hwWlHdncQSq7gEayzzQeCbyXWNquKt9/INArxYatYKRG0Dhr1IPfu4bWTibORJCsMPiL
         oFKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gET4pXiht2v9n7nMU+P/kvp5sc1tnr5dXDkN/OC1mlPi2/Fkq89sIWl6jRCSNi4JiTBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9M/+J3kf1P+oNJDD5sAwNSUxnoQJYn+mv1acnwUZv5X8IE75
	1IQIT+QJ3m9VUd8eZ/XAIl8Xw8ytZgq8yQ5l2IINCMY2m6Nok5035E1is3iVAnxLUrSwrYnbdH+
	Vt61U/z8vYGcEBAVvR6sqUuIVkJqUw2otFcOF/4KkHNUJOfVVwYG/rQ==
X-Gm-Gg: AfdE7cmzs/dFUMBceaRacXTyfhmn58GoDnAhUb67JhTxLLdkk03dZUNlak53LoiFOkP
	bhUu3DwWK7TP2rtdcPgybeLAQu/XyFor+qQlpQCjX59baQkXbxJBmqbBOd8HWy45A1WtWCKkx3E
	HjUu6oJ6ZvFAUDGP9r9cje65Qh8kgN8XVRVluA7/olZluufgYPklTV50/DI0+JUlIsJ7O2RuAkd
	LkGhGRicuBd7dgXf3HQUTJNv+Mu2N6TxFTkAM/VxYqmt2vX9eBzqFdheFl3QH1GfDb1Tl6+dZps
	mD0ZfiIyAcDEHu9ZBoSsAc8MbDkzbBRAZsATBp8qrwTt/qEfB2TPzReUbbPrrZQSZUiA6eHOoWb
	CHz+Pp4WwhtOTUvo3vlANOMvAMnyaTFqcmaHNDat+b+QBkhcoP5RVvYM=
X-Received: by 2002:a05:600c:3489:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-4926086e5edmr43809435e9.21.1782301662764;
        Wed, 24 Jun 2026 04:47:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3489:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-4926086e5edmr43808845e9.21.1782301662209;
        Wed, 24 Jun 2026 04:47:42 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6? ([2a01:cb19:8426:ae00:2b21:b1ac:81f4:97b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01c3bsm6809084f8f.10.2026.06.24.04.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 04:47:41 -0700 (PDT)
Message-ID: <ccbadb13-888b-495d-b894-826a8e664d3e@redhat.com>
Date: Wed, 24 Jun 2026 13:47:40 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260623141933.577981-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/26 16:19, Aditya Gupta wrote:
> Currently pnv-spi-seeprom-test was hardcoded to test the 4th chip in
> pnv_chips (power10 as of now).
> 
> This requires ensuring to update the index when removing/adding entries
> in pnv_chips, such as when Power8E or Power11 gets removed/added in
> future commits.
> 
> Iterate over all the chips instead, similar to other tests in
> pnv-xscom-test.c and pnv-host-i2c-test.c, but skip older chips, since
> TYPE_PNV_SPI only exists from Power10 onwards, hence skip older machines
> 
> Tests all the pnv_chips similar to other qtests
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/qtest/pnv-spi-seeprom-test.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> index 44e0b92730b4..721129cd39ab 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -77,6 +77,7 @@ static void test_spi_seeprom(const void *data)
>       const PnvChip *chip = data;
>       QTestState *qts = NULL;
>       g_autofree char *tmp_path = NULL;
> +    const char *machine = "powernv10";
>       int ret;
>       int fd;
>   
> @@ -87,11 +88,11 @@ static void test_spi_seeprom(const void *data)
>       g_assert(ret == 0);
>       close(fd);
>   
> -    qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
> +    qts = qtest_initf("-machine %s -smp 2,cores=2,"
>                         "threads=1 -accel tcg,thread=single -nographic "
>                         "-blockdev node-name=pib_spic2,driver=file,"
>                         "filename=%s -device 25csm04,bus=chip0.spi.2,cs=0,"
> -                      "drive=pib_spic2", tmp_path);
> +                      "drive=pib_spic2", machine, tmp_path);
>       spi_seeprom_transaction(qts, chip);
>       qtest_quit(qts);
>       unlink(tmp_path);
> @@ -100,9 +101,17 @@ static void test_spi_seeprom(const void *data)
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> -    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> -            pnv_chips[3].cpu_model);
> -    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
> -    g_free(tname);
> +
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
> +        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {

Can we remove this chip_type field from the tests too ? see 248e4e924e87.

> +            continue;
> +        }
> +
> +        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> +                pnv_chips[i].cpu_model);

please consider g_autofree variables.

> +        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
> +        g_free(tname);
> +    }
>       return g_test_run();
>   }

