Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF73E00A5
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731932; cv=none; b=QjgGxsJWGso0mdIOauzTYuFIHoG+6Uf55srHVv6QiBSfj6hTeqXREyMspS7P8yauV+fYOe7uDiKwk+peON3srHJDD6HeRQsYuLNpkhyx1Cqe9d/eqNYJ4CbRMhAQ4CeiIwg3errVYHAr77nUQuL8t85X2kMgcJEMWgVNPHUE85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731932; c=relaxed/simple;
	bh=93OLNu9mVisNOEyLy4XQrC9X4YMNKGPXbgGEFl7YepQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4E6TCcWIcCaZnjfF9tG0SMXdDxtEaFkFMraVZ/nuZYZbijrwiWETNeGg2mjia12bGBNtHlJUM5i+ddNOxnIW8JahyAm/XSxn9SSeXFhOkbun9N0UOKX0M9RzAqOO/EonG1epP8T4/JD2LxB4dN+wxaayUkcDuZL4Z4gcP/C6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUVrcsq4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=twEQ/Gmc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUVrcsq4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="twEQ/Gmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782731929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
	b=UUVrcsq4/YI7r/MrpfrMEBrRo0gzGMBPiXgOXY1SrF0PjxB9VdtEgE+DsBs56RHHqKAqiD
	ROC/AwkMKGiYB9OmVg6Bsb8f0wTrSetLMb41Sewv1zs9NWtxoE6Ylvq0yVJEHCtlNxhYmK
	wq3DSl1d03vSs/RAs2Rqww2SevA9TkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Ub4djAocOBaR4i_CBf6LRw-1; Mon, 29 Jun 2026 07:18:48 -0400
X-MC-Unique: Ub4djAocOBaR4i_CBf6LRw-1
X-Mimecast-MFC-AGG-ID: Ub4djAocOBaR4i_CBf6LRw_1782731927
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so484282f8f.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 04:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782731927; x=1783336727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
        b=twEQ/Gmcj+RhHtRubNjydql8pxpJX7CkWs4CB51okVU+PGzO4m9BVoE5/GLfyFm4PB
         ylsQA0+Jvo9At3+Zx/xTGFstO+caZxKPhhRrdMgJS7ZMnmFDuI7RREUhXpXs8RNexwq9
         k/XyVK6Eckk1h3Tl6ctGFY94NFS88m7hWBqBxlh3Fb1A4ONIC+6Qu3VlpejlXL2LSBdC
         9we8pG6WTNphOW8sAA2Zv+4GqH2+8D47POHYNtPTzJVrFRfTATClSoC3ANZp9MpU0LWl
         Cfb1q3vFyxsrYuFTKhSbcv7R5RFChL3cyOiwp4sOg+FLP89bpjd4F8l4ABXx+4dh/bmO
         poLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782731927; x=1783336727;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1eo34HDlJf8DxUgko0Ua0AT3spbAIisH7eKoas4rug=;
        b=Ira0kuVuO6tSSeC9f4Wb9tgE4p6Ay2SzD48PeRYfSTlTPzCikXq0ZG7ooq2FfN6e4x
         nccb0f0vyPEfZ5cZomdZeUX283ts0/2HlZZclISlxyeyBAFjNn0zJHOrh/tDQYrLzgxY
         fPA0I58fennCGxiH1RsjyfMhFXBmZmHcDkiyMabDkq1ZH8fFtWsbs6ncgWWGxgpwT7ET
         j6kjkWw/t9ff8ix7TaIVLi3Pmt9Zj9F83K4qBX4TWEIMI5jzHr8N5/aM0Whqzl3vXbFg
         VJEJbMWaOyXMfKRg+5torL98oCLHqvS/j4P+B6bkmynvK7o52+7jV/wpQYDPLJ3mpBOc
         f0bw==
X-Forwarded-Encrypted: i=1; AHgh+RqW01FgtEv6t2css2/psA+FaT1Y+8c9t2g8djUqIB1vLbDInipFgSYuHMd/Hbf1HqH1USs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRggTkYBKCEPkNVi/uaIIuqB2ETCTx+oEW6RGyZe4c1Y7wd2V0
	jE/UtTmXS1Jmbzsn759VDpQvKSZfeW92jbQbqYFDvc5fmdmVxQQKlSDPsawg7L2aMGNRbmFAxQC
	gSO89zkJNkI5/gF66U4xI7Hf+nAhS+NRgP6WM/4fe8Ov6zB2OIjzocg==
X-Gm-Gg: AfdE7cloLvDSIuT1TpUknS5Is4QI4eSEXfqTtcUFaJ2kjVcVqiHaXwURM8h6LjYWEm8
	eSCMWt/3FJ7v9K/qfZFutJ+v4Ashj7b8U+sCjR2ydoheesghI9MHS4ZDgH+XYhQngdb0t3WjsUY
	YgdSDb4xkVsT9rThHcfUxqUhFg6mj3OXM5saqqR9Gb3bjIMVvD+ORFJK5evHqXFSDAYIIkmVnY8
	K9kuqHTTo/fpPqkZN5+uFIKrN2FTU2ukpDcqPxVWH9eaGuiX/E1+E+6beyA7MEpwO6vmIvbpdpf
	KaAN3ND9Hi54Rp6RpajI8WQ/mhhUrfzvhCCdJ0LjoiOjQCTjFx2CPRokfwQzaoUfri5PIGZvJOG
	M5cpUeX2WFij3VRa4QAmvx5+qwipk64kjbVwIHJUAF4NyCBvhOA==
X-Received: by 2002:a05:6000:220e:b0:473:e954:6ac7 with SMTP id ffacd0b85a97d-473e9546e61mr4047423f8f.2.1782731926680;
        Mon, 29 Jun 2026 04:18:46 -0700 (PDT)
X-Received: by 2002:a05:6000:220e:b0:473:e954:6ac7 with SMTP id ffacd0b85a97d-473e9546e61mr4047358f8f.2.1782731926123;
        Mon, 29 Jun 2026 04:18:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a? ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4721c88bfcasm20051303f8f.10.2026.06.29.04.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:18:45 -0700 (PDT)
Message-ID: <32d7c4b1-dbb9-485b-8feb-df999532de60@redhat.com>
Date: Mon, 29 Jun 2026 13:18:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] tests/qtest: Add Power11 chip & machine to qtests
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org,
 Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
 <20260629110411.3051274-4-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260629110411.3051274-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/26 13:04, Aditya Gupta wrote:
> Previously the machines/chips tested by qtest was till Power10, update
> the tests to also test PowerNV11 and Power11 PNV Chip
> 
> Since if-else-if ladder was common pattern to get machine type,
> implement pnv_get_machine_type so new processor cases can be implemented
> in one location in pnv_get_machine_type
> 
> While at it, also add g_autofree to allocation by g_strdup_printf in
> modified tests
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
>   tests/qtest/pnv-spi-seeprom-test.c |  2 +-
>   tests/qtest/pnv-xive2-test.c       |  2 +-
>   tests/qtest/pnv-xscom-test.c       | 22 +++++---------------
>   tests/qtest/pnv-xscom.h            | 32 +++++++++++++++++++++++++++---
>   5 files changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
> index 51e613ebdcb2..5fd54f9de771 100644
> --- a/tests/qtest/pnv-host-i2c-test.c
> +++ b/tests/qtest/pnv-host-i2c-test.c
> @@ -402,15 +402,14 @@ static void reset_all(QTestState *qts, const PnvChip *chip)
>   static void test_host_i2c(const void *data)
>   {
>       const PnvChip *chip = data;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
> -    const char *machine = "powernv8";
>       PnvI2cCtlr ctlr;
>       PnvI2cDev pca9552;
>       PnvI2cDev pca9554;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> +    /* i2c is initialised for rainier in case of P10 */
> +    if (chip->chip_type == PNV_CHIP_POWER10) {
>           machine = "powernv10-rainier";

Is that true for all tests ? in that case, pnv_get_machine_type()
could return "powernv10-rainier".


>       }
>   
> @@ -473,10 +472,9 @@ static void add_test(const char *name, void (*test)(const void *data))
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> -        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
>                                         pnv_chips[i].cpu_model);
>           qtest_add_data_func(tname, &pnv_chips[i], test);
> -        g_free(tname);
>       }
>   }
>   
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> index 1a78e8d966a5..8bb30eb649aa 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -77,7 +77,7 @@ static void test_spi_seeprom(const void *data)
>       const PnvChip *chip = data;
>       QTestState *qts = NULL;
>       g_autofree char *tmp_path = NULL;
> -    const char *machine = "powernv10";
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       int ret;
>       int fd;
>   
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index 5313d4ef18b7..80de9d09ed09 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -548,7 +548,7 @@ static void test_xive(void)
>   {
>       QTestState *qts;
>   
> -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> +    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
>                         "-nodefaults -serial mon:stdio -S "
>                         "-d guest_errors -trace '*xive*'",
>                         SMT, SMT);
> diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
> index c814c0f4f5b1..94b50c071c02 100644
> --- a/tests/qtest/pnv-xscom-test.c
> +++ b/tests/qtest/pnv-xscom-test.c
> @@ -28,15 +28,9 @@ static void test_xscom_cfam_id(QTestState *qts, const PnvChip *chip)
>   static void test_cfam_id(const void *data)
>   {
>       const PnvChip *chip = data;
> -    const char *machine = "powernv8";
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> -        machine = "powernv10";
> -    }
> -
>       qts = qtest_initf("-M %s -accel tcg -cpu %s",
>                         machine, chip->cpu_model);
>       test_xscom_cfam_id(qts, chip);
> @@ -57,7 +51,8 @@ static void test_cfam_id(const void *data)
>   
>   static void test_xscom_core(QTestState *qts, const PnvChip *chip)
>   {
> -    if (chip->chip_type == PNV_CHIP_POWER10) {
> +    if ((chip->chip_type == PNV_CHIP_POWER10) ||
> +        (chip->chip_type == PNV_CHIP_POWER11)) {
>           uint32_t first_core_thread_state =
>                    PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
>           uint64_t thread_state;
> @@ -84,14 +79,8 @@ static void test_xscom_core(QTestState *qts, const PnvChip *chip)
>   static void test_core(const void *data)
>   {
>       const PnvChip *chip = data;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
> -    const char *machine = "powernv8";
> -
> -    if (chip->chip_type == PNV_CHIP_POWER9) {
> -        machine = "powernv9";
> -    } else if (chip->chip_type == PNV_CHIP_POWER10) {
> -        machine = "powernv10";
> -    }
>   
>       qts = qtest_initf("-M %s -accel tcg -cpu %s",
>                         machine, chip->cpu_model);
> @@ -104,10 +93,9 @@ static void add_test(const char *name, void (*test)(const void *data))
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> -        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
>                                         pnv_chips[i].cpu_model);
>           qtest_add_data_func(tname, &pnv_chips[i], test);
> -        g_free(tname);
>       }
>   }
>   
> diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
> index 5aa1701ea768..eefe206a2007 100644
> --- a/tests/qtest/pnv-xscom.h
> +++ b/tests/qtest/pnv-xscom.h
> @@ -9,6 +9,9 @@
>   #ifndef PNV_XSCOM_H
>   #define PNV_XSCOM_H
>   
> +#include <stdint.h>
> +#include <assert.h>


Seems unrelated. Why do you need these includes ?

Thanks,

C.


> +
>   #define SMT                     4 /* some tests will break if less than 4 */
>   
>   typedef enum PnvChipType {
> @@ -17,6 +20,7 @@ typedef enum PnvChipType {
>       PNV_CHIP_POWER8NVL,   /* AKA Naples */
>       PNV_CHIP_POWER9,      /* AKA Nimbus */
>       PNV_CHIP_POWER10,
> +    PNV_CHIP_POWER11,
>   } PnvChipType;
>   
>   typedef struct PnvChip {
> @@ -60,15 +64,23 @@ static const PnvChip pnv_chips[] = {
>           .first_core = 0x0,
>           .num_i2c    = 4,
>       },
> +    {
> +        .chip_type  = PNV_CHIP_POWER11,
> +        .cpu_model  = "Power11",
> +        .xscom_base = 0x000603fc00000000ull,
> +        .cfam_id    = 0x220da04980000000ull,
> +        .first_core = 0x0,
> +        .num_i2c    = 0,
> +    },
>   };
>   
>   static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
>   {
>       uint64_t addr = chip->xscom_base;
>   
> -    if (chip->chip_type == PNV_CHIP_POWER10) {
> -        addr |= ((uint64_t) pcba << 3);
> -    } else if (chip->chip_type == PNV_CHIP_POWER9) {
> +    if ((chip->chip_type == PNV_CHIP_POWER11) ||
> +        (chip->chip_type == PNV_CHIP_POWER10) ||
> +        (chip->chip_type == PNV_CHIP_POWER9)) {
>           addr |= ((uint64_t) pcba << 3);
>       } else {
>           addr |= (((uint64_t) pcba << 4) & ~0xffull) |
> @@ -77,4 +89,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
>       return addr;
>   }
>   
> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> +{
> +    static const char *const machine_types[] = {
> +         [PNV_CHIP_POWER8]  = "powernv8",
> +         [PNV_CHIP_POWER9]  = "powernv9",
> +         [PNV_CHIP_POWER10] = "powernv10",
> +         [PNV_CHIP_POWER11] = "powernv11",
> +     };
> +
> +    g_assert(chip_type <= PNV_CHIP_POWER11);
> +
> +    return machine_types[chip_type];
> +}
> +
>   #endif /* PNV_XSCOM_H */

