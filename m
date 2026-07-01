Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A53361DAB
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782871408; cv=none; b=Zk8Th/OhdOp6LoMSvt3x6QOjVuYg7Lf2kHMhvMCHo1C8sZmCpaK7dcEWtzUJF2ExyIL5OsS7Q8TKhjPgvovJQW0EgotA2zL2THSvx5JWQ0N+jKJh64ig30pytYAiHQn49omV1A/SRT7HJuz1xvRJLoZ8VxXMV6Mb0VF6C57OCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782871408; c=relaxed/simple;
	bh=LcRRgjAzfWb+aaflnR7gwpcRoSpV0+FCUKLwfsriKhQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=J61w1eenXWph6RhpaVYPZiQ9ZAd6bKAEsa5eolboDebbOQhzM6UTd6g1ATRJ7HS6SprLW1K6fe1m6j06PKnooD/kKpo2BnpY7FFvPhSvrEs/eFGOY+5VZC6ef2kwgd2CL8h5+b9lyBD2bCh4D9V1sNObo7Lv8jc/pDJQLZVx7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XePZrGKm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XePZrGKm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNIkX83389610;
	Wed, 1 Jul 2026 02:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VZ7Qc1
	tXAAYJIEY3faHWw6c4X5/7errt0BuNwY3YCEk=; b=XePZrGKmzk8vSO+sQtVdUZ
	sAhem1HA55Tt8G3ykZ68+jKsxki6G8YYhy9YgEngAuoSQc19THrasoj0e0pKzJxW
	6Q7yJ0dolerVQS4AnMOSe5EThHqbj28GxUriSCK5e1aA0FKsam+RiKhwuwmw95mz
	n3TqCJai4kwMU7tVtY2bc5oTuv6gk9ENKBlRJnUkGs4AF6Mu4lL9Bk8qID0Wwdnt
	bd38DqGrojFQ+FUXTKIuO6vITMaqSLGajfTLbAY2RRrEJFc3cFt+9h/je348mYXf
	usbzNmJpN8UFUILoC3doi8iQqwbkU5FUj4ZCLCKkpZ2vdFUs4ey04HewUpDpgCBA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5t0d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:03:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6611nfeo019564;
	Wed, 1 Jul 2026 02:03:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk569e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:03:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661231aV24117518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 02:03:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE2FE20043;
	Wed,  1 Jul 2026 02:03:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B07C620040;
	Wed,  1 Jul 2026 02:02:51 +0000 (GMT)
Received: from [9.67.23.244] (unknown [9.67.23.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 02:02:51 +0000 (GMT)
Message-ID: <4ed4d350-af91-4d0a-9078-19b447d6ba2a@linux.ibm.com>
Date: Wed, 1 Jul 2026 07:32:49 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: Re: [PATCH v4 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
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
 <20260630210355.789109-3-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260630210355.789109-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX1rFaqixBqlhe
 /EObKVP5RXz6OnC6K+kbTIUNdFtAa39Mata7ojEH4J2ofUj4FiRNEm3mlnPwXBbAfx54gtZ9F5y
 y7Xf4ND9JoWDF/1x9SogXW4veL04JrwJsSBqxPv01oUw8czw5cn2vA9dIHJHwi+fRFEoTDCvg1X
 7Xqf1fR0I8gHsSjOSMpHnvAJ6GAT7UJwS3318G8h6bg9iXqhrNo6KwmtqsNPv+d50oiotC5yN55
 GCADp1ls/DqveDgnKaw/1yPQ+TemS0/OT4a8YacLKjGQHFxkOmKkKZAzvX6Rh2APVWwWt45Mcn9
 nsrvowsF62fAN2oyFuEgLFNA+QoN7rv7rvgHe9WGSwb6+XPbHC3HkGLbvfD0Hq96GfYrdrSlg+H
 rXoBq0yEzpQ0Xm5vzl974tKB38csKcqHGZUVdbyFbw3G5IAkVTI8lcGWwAduE+c2nvNrvfAIhzm
 XDsjQ4nUTai1MHufqlg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44755b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=K23rW0AUlckyGdoYF8kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JlSO3Jv69c9B6Yci5UtRN5EsxBcKytFo
X-Proofpoint-GUID: jr74H3mAoYQRUdM-MfnaS0BjitBNF_nl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX9ymfzUJy+4YX
 hv56+nsyf7OeDK3dPJhRi0tvmNuHK6AG24Gh8QQoTftVRLAf21uCPHm+Icvx7zJSlv2frAL+ok3
 fYZMErN5oSsoAPataM4wd3LRDFtWY8s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017

Good to go from my side.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

~ Nikhil


On 01/07/26 02:33, Aditya Gupta wrote:
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
> Tested-by: Misbah Anjum N<misanjum@linux.ibm.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   tests/qtest/pnv-spi-seeprom-test.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> index 44e0b92730b4..1a78e8d966a5 100644
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
> @@ -100,9 +101,16 @@ static void test_spi_seeprom(const void *data)
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
> +            continue;
> +        }
> +
> +        g_autofree char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> +                pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
> +    }
>       return g_test_run();
>   }
