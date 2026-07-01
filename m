Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8A6FC3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871669; cv=none; b=uq8woGjHFAGi71AtX+vJ8u/wBzbvSj1L4JpM3bSZg68Gt89hOKhtw6GXU2pAeA+L2ZKvl1reJ9yxZ+ZsdEedEtI7Wv+zkzbZHtBbPsgpDZrdF62J7SPRAI1Y6bGrUZu/7Rd1RNPFXpCTFq2uTPpQRWmbILsVCbRylZNLmkoaz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871669; c=relaxed/simple;
	bh=5g9pYU+HEYvrFfgHEyAglmSIyZ7wOWV9/471iE/uvsI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YglzPim8N0QNqK+DLK6QvcJVzMUJbbfcIaJu8wgN8QsBMTU083AJdmTm27AIhKj7jn5K9oinMalk0EoujgReufgX0VXLuBJnkHZXLpR5w2ZlJM/vFhFGr5rMJ2rsHdluW4q+SS+0OlSTgyBhcr0UPvBnfQ/WAWDlHujx5rXM1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=erxvToz1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="erxvToz1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNKBeE3587126;
	Wed, 1 Jul 2026 02:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FZJ4XK
	oTlRpowuL+JpEDY75q25iCO0R2hn0/bTVpwro=; b=erxvToz1n3ebDYS5dBkhUZ
	3gmQAFvYUdyrXOk+2pXb70e38iM4GhBrUigFLdbLtGMUhHvIQPjS6c5MwCRzx44t
	LZAj4duy/uqUUovwgNaQzMl50BMhzJ89C1Z94sVH4f+bmkTTK+JISVYTMzVop2GB
	2NeEr4niZJ4waoDZElAiI71fs2LdxgzytuntfPTL/AHsmwFWui6zd2FF5uFVLlIm
	GF4FFdYIuVcI2+1//5pIE68yLGiRjxVsgd58jkLPQ7A5mtYd4sfK/ZlNPpn29Jwj
	lMvogP0aEd+4SWS6G0cqgX/O9MNerOzB8J139PO+1BpFSvzRNojmLJ+q8YKQp8Gw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg1ymx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:07:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66124clX018513;
	Wed, 1 Jul 2026 02:07:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhd4nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:07:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66127Sjf50594280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 02:07:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 954C320040;
	Wed,  1 Jul 2026 02:07:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C4FE20043;
	Wed,  1 Jul 2026 02:07:19 +0000 (GMT)
Received: from [9.67.23.244] (unknown [9.67.23.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 02:07:18 +0000 (GMT)
Message-ID: <444f825f-e1bd-4f31-81dc-e6916b1b79b5@linux.ibm.com>
Date: Wed, 1 Jul 2026 07:37:17 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v4 3/8] tests/qtest: Add Power11 chip & machine to qtests
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
 <20260630210355.789109-4-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260630210355.789109-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a447666 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=2rrNJ9MD9AVxGtTbJvUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX5FoqrOtClFZJ
 FVxwRq+eB27tX3Giaf0psPgZrFHPAJmygv8k+yqDLHQRsMiNDqyGiHWj6wHVRImCY36WMexQ1V+
 UoJpPwce3+NzdbECAo38SMmdbUvlSnI=
X-Proofpoint-GUID: MNAV6sOsfQsNAqR9cl7X1dyqrzJA8w9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfXyl7fkukGzhrP
 mr92HOgs0BE7gMfIa3bpzjDyBAV20am0Jk54aAZ2z76EufVnNiboa5wiLuNcc54dYTjwvTsqawu
 hlenGkrRBhcWFHPNbn7r83LlsbeWpCS69rdI3fK/6mmXwOIZnrqh1HKDdgHToqxaSzUn95ggCjx
 Zgp97jjzeRrtUxFPsEte6Ub+0s2p7hGenc1X7qUnvbzFacF7+cXdEvsLtJdotP3G4BxGpMDQS4N
 6j3rESDelNBmYbR/KXRvCJWgNxKaYmWLijoCudjGgD1mZnBax8Qk/IgM6yqpKnbasgB3baF5UOL
 Ce5pWjfswXiMT7u1S5yZTpKgI2eH/x8oSrkQiTp7n/U4sqmSyFXAAR7nusqqNh6INpo9zuPf4JO
 msUNA7Ho9i31zxI/CBPsm/9OMD/ZNF5E1ZZ/Klf+n9CF+swpUKJpXCxJsZPfnLW3TK+NXAjNK1g
 erK7Sti6isyLedBrSiw==
X-Proofpoint-ORIG-GUID: 0KVXkmA5Vw35AaRlhuNPjJoUYZalKl38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017

Thanks for addressing the comments I raised on v1. The changes look good 
to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

~ Nikhil


On 01/07/26 02:33, Aditya Gupta wrote:
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
> Tested-by: Misbah Anjum N<misanjum@linux.ibm.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
>   tests/qtest/pnv-spi-seeprom-test.c |  2 +-
>   tests/qtest/pnv-xive2-test.c       | 21 +++++++++++++++++----
>   tests/qtest/pnv-xscom-test.c       | 22 +++++-----------------
>   tests/qtest/pnv-xscom.h            | 29 ++++++++++++++++++++++++++---
>   5 files changed, 53 insertions(+), 31 deletions(-)
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
> index 5313d4ef18b7..9f67a0066864 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -14,6 +14,7 @@
>   #include "libqtest.h"
>   
>   #include "pnv-xive2-common.h"
> +#include "pnv-xscom.h"
>   #include "hw/intc/pnv_xive2_regs.h"
>   #include "hw/ppc/xive_regs.h"
>   #include "hw/ppc/xive2_regs.h"
> @@ -544,14 +545,16 @@ static void test_hw_group_irq_backlog(QTestState *qts)
>       g_assert_cmphex(lsmfb, ==, 0xFF);
>   }
>   
> -static void test_xive(void)
> +static void test_xive(const void *data)
>   {
> +    const PnvChip *chip = data;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
>       QTestState *qts;
>   
> -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> +    qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
>                         "-nodefaults -serial mon:stdio -S "
>                         "-d guest_errors -trace '*xive*'",
> -                      SMT, SMT);
> +                      machine, SMT, SMT);
>       init_xive(qts);
>   
>       test_hw_irq(qts);
> @@ -580,6 +583,16 @@ static void test_xive(void)
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> -    qtest_add_func("xive2", test_xive);
> +
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        /* xive2 exists from Power10 onwards */
> +        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
> +            continue;
> +        }
> +
> +        g_autofree char *tname = g_strdup_printf("pnv-xive2/%s",
> +                pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], test_xive);
> +    }
>       return g_test_run();
>   }
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
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name, pnv_chips[i].cpu_model); qtest_add_data_func(tname, 
> &pnv_chips[i], test); - g_free(tname); } } diff --git 
> a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h index 
> 5aa1701ea768..8e882dac9d36 100644 --- a/tests/qtest/pnv-xscom.h +++ 
> b/tests/qtest/pnv-xscom.h @@ -17,6 +17,7 @@ typedef enum PnvChipType { 
> PNV_CHIP_POWER8NVL, /* AKA Naples */ PNV_CHIP_POWER9, /* AKA Nimbus */ 
> PNV_CHIP_POWER10, + PNV_CHIP_POWER11, } PnvChipType; typedef struct 
> PnvChip { @@ -60,15 +61,23 @@ static const PnvChip pnv_chips[] = { 
> .first_core = 0x0, .num_i2c = 4, }, + { + .chip_type = 
> PNV_CHIP_POWER11, + .cpu_model = "Power11",
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
> @@ -77,4 +86,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
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
