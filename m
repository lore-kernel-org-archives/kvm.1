Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFC409601
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086298; cv=fail; b=PBAwZhzpbew6bKuSYOjAN0FtoO3VyQ6cgBCEq1iDzKT85J4wHkICJ9I3xDLZafmeLYcPVJsS1Q2JeHoeMzUT4PfPtkCgU2QactjSl6CmAZqm5ZPyy4s+P0KyynvWGX1uAQe12EBBUtMYEX/Ac9H92m8nBXrJfrHr1htvHY6i7k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086298; c=relaxed/simple;
	bh=YgaMuimutYrfK8kTce2mAOvfpE6lc8tr/F9uszVwV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvTnVqtXqNrE3w+jf3Ky0HoYaGyaF9X1/7XMoOW2IE8ktFPA1p/RgtMWzaQnMp+1FbRXJK1QTdhTVz21nJIpqlVIXweWnDXHTu3PF7nWKDKXXmqDIMdCP42tYMeRzH92aDIGEbh9XkQ7ys4JWFxOcSi+VYger+LR9bUHHnrS6Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EUN4b4W+; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EUN4b4W+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDzqvmWMYJaWAgx/Hl5rsGQ2R4gQO1J5z/V6D0z2/2qelXiUuMaafdHIrMt/8ZTYepyzxeX+drdSKciEDcqfPvQ3u9gKNdpcLsJeFuxOY5fQehpD24r5LScinMH8qsL9lnuZA6+EZLhJ9L1VepWZi8BgNoebKqhuF7xyZUOtGu7+Hm5PDD8LeeVK5O6g/0XugPLeNVfPG5Rtl9+ma74GwjQ/FoNo13ud8l9Ig8uDWpjPB1acq7BjnWL6/pmUUj3zcZdVVGSjnogme1zpMXtUEuhOquojjOSDT8nu6pgyBb94x5eQykvD+kBQuB/yXuFkGyj0M+85vTMdoj6jPn7AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmrm8pDEP64a4GqOJvPm/5//6wuHRDKUA10MiGzbsE4=;
 b=u3wfRYu1xPOf0syxZxHSUnhI/nIXBNSYtBZ7peMrdbtYoO6mzcesYCSqdaBJeS4FOUXPxtU6qNFhfpI+jPewiWynQ9um4yQRShw96aNnEeH2HEHKNyio8Uzr7gYgTHNwpWB4+Z8bsHTyUTirNqojB9VAOHfwPnjCcXdRK9adLOmO/dT+1gPUCbRUeRy0FEQ+XUIe0P8XRHAwTXxVnGKPZ4jxRgmhiqmugc1kWNuQioTrYvCEWJRs5Ez7vmD6W0vtmPJgs1GmjF1u/Cj30Tlqzn2MLvNYUy6MnVw5s2S9w9jzWmITBB5tsAyQ5+uh+W8qMmWDNxi3s0dCj2oKR81GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmrm8pDEP64a4GqOJvPm/5//6wuHRDKUA10MiGzbsE4=;
 b=EUN4b4W+OS7IDuEufeGZQFV834xHsu1QofdEwCmS2EG95jQGpoFT+WCY/b6a/SlrNcztPKteKkPqKdSUyv7LwZHgC5DPO7oMtzrbLsJk3hkwQsKrZo852nxbKdQnjozMqy8BiVlIMIaYcOuEDw5vvjseLZ2863lJUgym4GQPuSOk3K1VJWS/xBQRHU+Km71TIay8ExyjG9MJfNnuZwP1EJeX5hb4oYYHQkLEo1wr/ebxd1vOpD3XoKralwal+8DijcoyzqCAvE6aZpz8fAHxqdo2uKVrwFfRSQ5ZpNpPCxz0OQmveYQvWdbERfb8gYR3LOeqkisR5IdO24yu4RZ5YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 20:24:51 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 20:24:51 +0000
Date: Fri, 29 May 2026 14:24:49 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Josh Hilke" <jrhilke@google.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/10] selftests/vfio: igb: Program MSI-X interrupt
 routing
Message-ID: <20260529142449.36fb00e8@nvidia.com>
In-Reply-To: <20260527001909.C0B6F1F000E9@smtp.kernel.org>
References: <20260526235417.2058313-5-jrhilke@google.com>
	<20260527001909.C0B6F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA0PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:d3::32) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: edfa6f5d-e604-4a03-5202-08debdc05666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iUISCOBWK9ak6YAbtWbuFWAZ1gb/wPC6wAWd6kVCCB+Cbq/NYmScSl3dvPiObUuBoGcHulwZOkf1wd+FsADkkxeaRe4FzSozHwoUH6nwVLjAlp+4hIkzKc4LcOf0K6T8Yiva4LqIVZSehQuqoJCt6s55dViMCiIS/MI3dZtIoGiPZbqFL0L0ezuyqwM8s/lS7IMgk8ZshipfaQnMYKMfbB4ManKa42eTyGO1TFutYFMLi8oWkQEyMAdWEt2KJzzSNR05dzq/2TQC/HXClRFM3KyeMwDwPrdmo4VI0oBTcKSiEh3SIXcFygawNlVJo+8Il5nzZEp4xIXaiUJ6Tbi+zEgI1l8NhVQWeqlgoeRtLiJN+sxkEmdz9zo2g8F4NjrG+mZIEGez5Gd/IW3uYQ3S73XN6k87mGogc+dsjBVfajwoXD0hShZGTKGQgneBM1vDFfZqGGGXXhJE1lty9vJTws4feh+GtMV3OoSomwOayiRaEaBCp0GxZIKODMZpdZFPX9VlhIQYABXYXmXUMhZfjIpe8OjrztYggMGf+zaFGirVOccCMaTZ0sYCZGg6Smy1Z4ICELjSt1yZHxxJsFUOzPZbdjq/mHsgT5LgNiefqpelghLqhoFMmOVGyzISBuO6LisIpCtan5c26JjjhM7xH0oORyU1Tzs00isQAyiJI7mK+5MtcXO2pjXBI+mMDYTS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3BnUlUzeWkycmNraTYrRitPSTZGU25uR1VKVVR0d1RLZnlVUncrYVJTTXdr?=
 =?utf-8?B?N3lMTFVRZzVLN0xVNStmTThOMVRDR01yUHpTNzh0ejZPdCtPcmJ5RWJHN3JL?=
 =?utf-8?B?TTFQakR1TEMrMmhYSFFxQis0YWxIcU1RMFlWYnU2R0kzaTNRVjZYUDNYdHdl?=
 =?utf-8?B?Vkdad1ZlQkJtbjBxUkVmU1FLbWoxeEkxK253bllHTHp5UHB3Yzh4WXdBQTRI?=
 =?utf-8?B?dHM1eUM2MGNNYWI0akVkd21HOXczMnozTTF3TDhicDBqTDFkK2ZlOGp4QWFu?=
 =?utf-8?B?T0VqSEVXa05sVjd0RmU5S3ZDeWRCS3pUMUZoK2pMMU9MVlNJa0lvczNTTUtr?=
 =?utf-8?B?TzdJbUZYUFJLY3A5d3FrQzJqdHdsUnpvdmxSc0FoN0dVU2RRNlZsM2FmTGsw?=
 =?utf-8?B?UkxFY3YvSitZZWZiYlg1VE4wRFNWSHVSek05R29sMTA1SFV4UkYzeVF5M1RB?=
 =?utf-8?B?ZERYUlpyODhkMEJDWVo2QzNJOFZkS2dzek4vT3JVRys2ZUNOZ1QrbW5jRitK?=
 =?utf-8?B?Z3RQZzVWSWk5MkN2Q0tWN2ZRSDBVK2UzMWkwL1lUd2ZMWVorMmdCUUx5OVpR?=
 =?utf-8?B?S0t6Z3dvbzYrVlF3MVg5MUR4SEFadkdZQlgrMnpQaW04ZnFvSDlCVytWdmRw?=
 =?utf-8?B?V0J5WmlGSHl3ZEt1VjJmclR4c0xxM0E5bjZLZnh5aHVrWk96cW0wcGV4NUR4?=
 =?utf-8?B?YzM3UUh1S09CMGF0WHByK2NNSG4wc0VCTnUvK2xKd0w2QzBHSUt2QnI5RUQr?=
 =?utf-8?B?QnJEK005QUkrUS84OTVsMXEzSVhiYTNuT3B4Qk9nZnFvWk5lbnVvN3Q5THFj?=
 =?utf-8?B?M3JpZkdiSkUyc3JTTXEveVFjTm41bkdKWG9KNW41MFp3QVFhR0pDMGtiVTJl?=
 =?utf-8?B?akVCek9BZjZDR0hRL0pmNU01YmRTdFFtT05yTVI2bSs1Qm1Wc0hGdUVQV3dJ?=
 =?utf-8?B?UnZRRGpXMHBMVnVyZHlMSGZBdGIxZkw4bjlXeFN2QUR0b1lxcGlPdTY5QTE5?=
 =?utf-8?B?aHNadmd4ZnlOcmd3K01hd3ppakYxZzMwSE1DbFdMK3hybEZIbnZIR0N3MUtB?=
 =?utf-8?B?dHU4dXNkVWswLzhYaFY5dStFZDRYb1RCMDVvTlZuQjE3R1k4OWhCVExJakFz?=
 =?utf-8?B?SnhtNndiRVcvNUZpZnUzQVhIOXRGK3RSbU5tLzZNZjdMbklOQU11Y09BZlVq?=
 =?utf-8?B?M0QvcVlFWjJWeHg0SjlLVVpWdUxkZm9tVGhhcHRTYkZ0M0ZId3RsaVJVRTlm?=
 =?utf-8?B?MWs4NVRHdjF4blhEN1lmQkFKd2N4Y3FMSC9IZlhvZVpwdCtsUjNWUGwrT2lI?=
 =?utf-8?B?T2RRS0o4eVhPdTVTNi9CL09jSW5tUEM2SlpKU3lzTDc2TldNRzQ2OG5Rbnl4?=
 =?utf-8?B?NzVCcHZsTTJIVGJyQ3dQYnppTzBmeUxIeFM0V2o4WTFrZmMrcjVQdnlvRnQ0?=
 =?utf-8?B?YXkxZXpyQUNJdC80MmJLOVBFYjNyanlOKy9DOGt2TWJvM2JJd3I4MDF6d1dk?=
 =?utf-8?B?cXJsUmpScHc2NHJ3Um5XaGgyUUZTTks5YlhqNjdpSEZzTXpEbmI3dkU1Mkda?=
 =?utf-8?B?OW9kQlVxOHYwN0ZZZytudG5paDRBcjBWK3BDSXE4NEdoTWlsRlhndDJ4SVRi?=
 =?utf-8?B?ZlN6QW1QQTJFYkl1STBLNEZDYlBEbHYvUHZyT0tOZ2xPVTNwOGJtUFBRV0Fr?=
 =?utf-8?B?ME0xbm91c1Z6WHI5V1hCc1h5bDE5dEttS0wyVFRTQ0IyVHZscFY1cVorUERq?=
 =?utf-8?B?Q0g5MXFVbENSdExPM2w1cTBMbm1Ia0czcU5LOVErMW5EZzhZRC80QlJSazlS?=
 =?utf-8?B?V0tDWDFoR3F1Y0ZFcWhnRGw1eFNWQ2NNSjdRK3BRczMzSnNIbDE3N0NSWENF?=
 =?utf-8?B?RXlOMkFlOUluVUhEbTRodlh3RlpzUFliNTdBL2xHR2hrUE1jUFBhMHV3aE1j?=
 =?utf-8?B?ZVh5ZExnR0plU0VJWi93djE5M0pOMVd5TnZ2YVFpMkZUSm9qT29HMmk2YWM3?=
 =?utf-8?B?V0lhU3Rkb3grcUxzTXRtL0U5aE93L1ExU0dTNWx5dFJUanBQVGdBWHVSYXZv?=
 =?utf-8?B?Ni9sTUZkUGFwNXRRR0NESXBjcHJ6VjhFWEZjTnRaVmhUNU5heGlRc1lybTBZ?=
 =?utf-8?B?Rko1b3I1VGkrWUJjalZCcmhrMmw5WXhyOU54WnhrZ1FoY1YveC9NQzNGdE1h?=
 =?utf-8?B?VXdEQWlBTWY4Mkd4VmlWQzFubUZQUlpiZ3M1SjIvZzhrODExNjZsQ0VPV3Rn?=
 =?utf-8?B?WWRNTUZUdEZpRWlXWjdVbTc5cURIalZiREJFdGNUMGhMRitQZDlOZzVBK3dR?=
 =?utf-8?B?Y2Nnc2trdzZWTklCbExBT3V0RjBEK3dkWEwyT2RRNlgrZGlhTGZzUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfa6f5d-e604-4a03-5202-08debdc05666
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 20:24:51.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EU2dxop+4encaxUUcDU/mnvjy/LScGXu5iGFYhPBnmxzx3HgxOIKc1eIKuRhB9ilKFbi/Xuh7fH4TAVSCIiQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

On Wed, 27 May 2026 00:19:08 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] igb_send_msi() was overlooked by the patch, causing a state re=
gression due to auto-masking and leaving a magic number unreplaced.
> --
>=20
> commit 059a9f7e058b59c775b2202ffd0af3e078efbd8a
> Author: Alex Williamson <alex.williamson@nvidia.com>
>=20
> selftests/vfio: igb: Program MSI-X interrupt routing
>=20
> This commit programs the full MSI-X routing sequence for the igb driver i=
n the
> vfio selftests. It enables auto-clear and auto-mask for vector 0 and repl=
aces
> magic numbers with appropriate macros to match hardware behavior.
>=20
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > index c0f9cefb23e59..a8f2072b68200 100644
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > @@ -271,11 +271,32 @@ static void igb_init(struct vfio_pci_device *devi=
ce)
> >  	/* Enable MSI-X with 1 vector for the test */
> >  	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> > =20
> > -	/* Enable auto-masking of interrupts to avoid storms without a real I=
SR */
> > -	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
> > +	/*
> > +	 * Program MSI-X interrupt routing per 82576 datasheet:
> > +	 *
> > +	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
> > +	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
> > +	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> > +	 * applies on EICR read/write).
> > +	 *
> > +	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> > +	 * Without auto-clear the cause stays set after delivery and the
> > +	 * test can see spurious interrupts on the next memcpy batch.
> > +	 *
> > +	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> > +	 * MSI-X assertion (effective because EIAME is set), so a single
> > +	 * interrupt is delivered per memcpy batch even if the cause
> > +	 * re-asserts before software re-enables the mask.
> > +	 *
> > +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> > +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> > +	 */
> > +	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
> > +	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
> > +	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0); =20
>=20
> [Severity: Medium]
> Will this auto-masking configuration break software interrupt generation =
in
> igb_send_msi()?
>=20
> When igb_send_msi() writes to IGB_EICS to generate a software interrupt,
> the hardware asserts the MSI-X message and auto-masks IGB_EIMS based on
> this EIAM configuration.
>=20
> Because igb_send_msi() does not explicitly unmask the interrupt before
> triggering it, will consecutive calls to igb_send_msi() silently fail to
> deliver the interrupt if there is no intervening unmask?

7.3.2.10  Extended Interrupt Auto Mask Enable Register (EIAM)

  Each bit set in this register enables clearing of the corresponding
  bit in the extended mask register following read or write-to-clear to
  EICR. It also enables setting of the corresponding bit in the
  extended mask register following a write-to-set to EICS.

Table 7-47

  EIAME: When set, upon firing of an MSI-X message, mask bits set in
  EIAM associated with this message are cleared. Otherwise, EIAM is
  used only upon read or write of EICR/EICS registers.

7.3.2.7  Extended Interrupt Cause Set Register (EICS)

  This registers allows to set the bits of EICR by software, by writing
  a 1b in the corresponding bits in EICS. Used usually to rearm
  interrupts the software didn't have time to handle in the current
  interrupt routine.

With EIAM[VEC0]=3D1 and EIMS[VEC0]=3D1 (set at init):

 1. igb_send_msi() writes EICS[VEC0]=3D1 =E2=86=92 sets EICR[VEC0]

 2. Per 7.3.2.10, the write-to-set to EICS makes EIAM set EIMS[VEC0]m
    so the mask is armed by the very same operation, regardless of its
    prior state.

 3. EICR[VEC0]=3D1 && EIMS[VEC0]=3D1 =E2=86=92 MSI-X message fires (per 7.3=
.2.8:
   "Interrupts appear on PCIe only if the interrupt cause bit is a one
   and the corresponding interrupt mask bit is a one").

 4. On assertion, with GPIE.EIAME=3D1, EIAM clears EIMS[VEC0] (one-shot thr=
ottle) and
   EIAC clears EICR[VEC0].

 5. Next igb_send_msi() =E2=86=92 step 2 re-sets EIMS[VEC0] again. Self-arm=
ing.
    No external unmask required.

The auto-clear (step 4) that the sashiko focused on is exactly undone by
the auto-set on the next EICS write (step 2). The two halves of EIAM
are what make the software-MSI path self-contained.

Verified on hardware with back-to-back send_msi().  False positive.

> tools/testing/selftests/vfio/lib/drivers/igb/igb.c:igb_send_msi() {
> ...
> 	igb_write32(igb, IGB_EICS, 1);
> ...
> }
>=20
> Also, does the hardcoded '1' in igb_send_msi() need to be replaced
>   with IGB_EICR_VEC0 to match the other magic number replacements in
>   this commit?

Yes, this should have included:

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/tes=
ting/selftests/vfio/lib/drivers/igb/igb.c
index a8f2072b6820..b4f75965e18d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -424,7 +424,7 @@ static void igb_send_msi(struct vfio_pci_device *device=
)
 {
 	struct igb *igb =3D to_igb_state(device);
=20
-	igb_write32(igb, IGB_EICS, 1);
+	igb_write32(igb, IGB_EICS, IGB_EICR_VEC0);
 }
=20
 const struct vfio_pci_driver_ops igb_ops =3D {

This should be added on commit or respin.  Thanks,

Alex
