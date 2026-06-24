Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BC3C2BA2
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311326; cv=none; b=YkLf35WmHIc2bFkzskMkl65kTSByID29AgiBvfWf4An067hQ399bzhAB1/fxhX1CaYAQHrp5aGqh/mVVPuv+9qnH2MXkhdTkhU5nP8rPlsWAEcu8YACo0eIwwOUVIiUYdWB6er8EUwu+9uJ62UB9LwoVx02F+ZmznzokjHmz+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311326; c=relaxed/simple;
	bh=YhkMWVSgEIbpiNhkj6ez80Jwjik13RTyMKNxxHFY5k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBs3rSALyAj6zy1U5aRZaazY5NvcVmGe9aXdPO6x0WpjO+t3AGyVeNA0ehdSawIfzuMa6CyBgoJc1istm+6o68bgSKyw2MB93U8pq/G4vK4oQRi6ki8Wr3m5LrlHQu3MnqzibvGxdaS46YzfWBGnYKUBZXn3ZwBsZd3LGpHerZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hh0MPPdk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hh0MPPdk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmi8Z596217;
	Wed, 24 Jun 2026 14:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Z94kfi
	UAm93RXBLrLcspjQdZC+Vm7C1VeVzQvsKK9Gg=; b=Hh0MPPdk0hb0hJHcxGBE6D
	VCuk0MGK1hJVdGvW/ee98DSg6OSE0USKGdZFFK//dqYFPetQ/gmQ3eDH+emRAm6D
	ZS7maag1Pam218SIPLHVDc8aJ0tAZxvyisMmeW46vS3yUHjcpom4kKXUosYKVYah
	t/nkhdKTrgZFrOhMv6yhpvxvk6dl0hNZebu4Dajkyz2PDKqAIBljKSlC5IcaTYat
	OIR5xp8vpyUZyIrjXHCooUurjA25FQw49SPoueJuqHa6cZ6BRTY8JlfgdkSoVNax
	hFG/8TQ9JPepAWpuw5T33osmxl9TGmoKftKO1oqSHZXpKmWONmCHlS7WatuHTXkA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hvse6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:28:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJjms003828;
	Wed, 24 Jun 2026 14:28:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phh03m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:28:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OESLmb39911934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 14:28:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3956E2004B;
	Wed, 24 Jun 2026 14:28:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7F420043;
	Wed, 24 Jun 2026 14:28:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.28])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jun 2026 14:28:14 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:58:11 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
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
        Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 2/8] tests/qtest/pnv_spi: Test Power11 PNV_SPI
Message-ID: <ajvkrq3e1103wLH7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-3-adityag@linux.ibm.com>
 <ccbadb13-888b-495d-b894-826a8e664d3e@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccbadb13-888b-495d-b894-826a8e664d3e@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: yd7cnFL-Hqr7q59kOnWpf8H5qR1nFYMU
X-Proofpoint-GUID: owxjWKmysTP1Im0zzj-cl3bfbk_27wXf
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3be98a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=L1eJwh8xV2WiUtXmEVcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfXwnCS++JGfZD4
 OgvsumcDmMalEHtsT1JdlTqElSpdrYi9VDZ7pmjk4aJxvbGG2N0zfAgLSQkAMD5sOaOCZGkQbTX
 38sywR2aDVjKL8jrDb16NyGUzi4RZShkKy1vv6UILpY8PoHyeNOk9bmygknpuMXx4I93kmHWUU1
 s+h92iGeH7+bgBpamaq27BvGgnRZr3y+77iGCJuxVRrnd0CUj4rCPH0IkrjCTs3nC9d9i92pdUh
 vEwV7jd9Wo2WnEH5pD7EekL//8ShQwURkn1pnFQDOPWIluiNlPLvCe19ylgEhy5VKtF55yxK/oe
 bOZarNIvWVBkGqQefonpJAPxdrLwnH0/Tk+tfl2T4fwelo0EhO0t62PlkVe++j2Z6LrbGVnBygz
 P3ZdzaxqhqAu/fIx6FV6B7ZSYwT5A3YxaVMVcBbhKXo6UrA4diXF0GM7mN0EBXycfhrE0iKcoLp
 L+VssEkkHjoJUG3vbvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX/0IzTN0UF8yA
 O5XaC2CiEAdbZc1q+Rozr1dgsNiwep2HJuOylrk84/U04HvsO8u8WoGFSIusoaBpcZPUzo5w7kl
 4CxcHmMRuekbXjgfgimElDc6Z24JxlA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240119

On 26/06/24 01:47PM, Cédric Le Goater wrote:
> On 6/23/26 16:19, Aditya Gupta wrote:
> > <...snip...>
> >
> >       g_test_init(&argc, &argv, NULL);
> > -    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> > -            pnv_chips[3].cpu_model);
> > -    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
> > -    g_free(tname);
> > +
> > +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> > +        /* TYPE_PNV_SPI is not instantiated for older Power8/9 machines */
> > +        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
> 
> Can we remove this chip_type field from the tests too ? see 248e4e924e87.

I went through the usage, and don't see any fix currently, as the
PnvChip structure these qtests are using is basic, and we need some way
to identify the chip type, for things like which machine to use, xscom
addresses, and to skip/do specific things for particular chip type.
I went through the mentioned commit and its parent, seems it was
possible with the compat property being handled by respective
class_init. So currently I don't see a better way, what do you think ?

> 
> > +            continue;
> > +        }
> > +
> > +        char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> > +                pnv_chips[i].cpu_model);
> 
> please consider g_autofree variables.

Sure cedric, will use it in v2.

Thanks,
- Aditya G

> 
> > +        qtest_add_data_func(tname, &pnv_chips[i], test_spi_seeprom);
> > +        g_free(tname);
> > +    }
> >       return g_test_run();
> >   }
> 
